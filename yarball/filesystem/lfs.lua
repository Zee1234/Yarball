local lfs = require('lfs')

local read = function(path)
  local f = io.open(path, 'rb')
  if not f then return; end
  local text = f:read '*all'
  f:close()
  return text
end
local write = function(path, data)
  local f = io.open(path, 'wb')
  assert(f, 'Unable to open file at '..tostring(path))
  f:write(data)
  f:close()
  return true
end
local iterateDir = lfs.dir
local type = function(path)
  local attr = lfs.attributes(path)

  return {
    file = attr.mode == 'file',
    dir = attr.mode == 'directory'
  }
end
local mkdir = lfs.mkdir

return {
  read = read,
  write = write,
  iterateDir = iterateDir,
  type = type,
  mkdir = mkdir
}