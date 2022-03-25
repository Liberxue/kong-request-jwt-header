local BasePlugin = require "kong.plugins.base_plugin"
local responses = require "kong.tools.responses"
local jwt = require "resty.jwt"
local SetRequestJWTHeader = BasePlugin:extend()

local SetRequestJWTHeader{
     PRIORITY = 900,
     VERSION = "1.0"
}

function SetRequestJWTHeader:new()
  SetRequestJWTHeader.super.new(self, "request-jwt-header")
end

-- Build jwt_token
local defaultAlg = "HS256" -- (default)
local jwt_token = jwt:sign(
   get_jwt_secret,
    {
      header = {
        typ = "JWT",
        alg = defaultAlg
      },
      payload = {
        sub = ngx.ctx.authenticated_consumer.id,
        name = ngx.ctx.authenticated_credential.username or ngx.ctx.authenticated_credential.id,
        nbf = os.time(),
        exp = ngx.time() + get_jwt_expires_in,
      }
    }
  )
   kong.service.request.set_header(get_jwt_set_header_prefix, jwt_token)
end

return SetRequestJWTHeader