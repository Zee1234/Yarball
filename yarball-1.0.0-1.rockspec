package = "Yarball"
version = "1.0.0-1"
source = {
   url = "git://github.com/Zee1234/Yarball",
}
description = {
  summary = "A Tarbal-like file transport method for Lua",
  homepage = "git://github.com/Zee1234/Yarball",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1, < 5.4"
}
build = {
  type = "builtin",
  modules = {
    ["yarball"]        = "yarball/yarball.lua",
    ["yarball.encode"] = "yarball/encode.lua",
    ["yarball.decode"] = "yarball/decode.lua",
    ["yarball.export"] = "yarball/export.lua"
  }
}