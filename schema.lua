local typedefs = require "kong.db.schema.typedefs"

return {
  name = "request-jwt-header",
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { jwt_secret = { type = "string", default = "JWT_Secret"}, },
          { jwt_expires_in = { type = "number", default = 8 * 60 * 60 },
        },
       },
     },
    },
   },
}