package = "plugin"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/Liberxue/kong-request-jwt-header.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      ["request-jwt-header.handler"] = "request-jwt-header/handler.lua",
      ["request-jwt-header.schema"] = "request-jwt-header/schema.lua"
   }
}
