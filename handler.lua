-- local BasePlugin = require "kong.plugins.base_plugin"
-- local SetRequestJWTHeader = BasePlugin:extend()
-- local jwt = require "luajwt"

-- SetRequestJWTHeader.VERSION = "0.1.0"
-- SetRequestJWTHeader.PRIORITY = 2000

-- -- local SetRequestJWTHeader = {
-- --   PRIORITY = 900,
-- --   VERSION = "1.0"
-- -- }
-- local payload = {
-- 	iss = "12345678",
-- 	nbf = os.time(),
-- 	exp = os.time() + 8400,
-- }

-- -- -- encode
-- local alg = "HS256" -- (default)
-- local token, err = jwt.encode(payload,get_jwt_secret, alg)
-- function SetRequestJWTHeader:rewrite(conf)
--    kong.service.request.set_header("X-Kong-JWT-Kong", token)
--    kong.log("saying hi from the 'rewrite' handler")
-- end

-- return SetRequestJWTHeader
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
   kong.service.request.set_header("X-Kong-JWT-Kong", jwt_token)
end

return SetRequestJWTHeader