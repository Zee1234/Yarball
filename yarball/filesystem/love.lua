local read = love.filesystem.read
local write = love.filesystem.write
local _iter = love.filesystem.getDirectoryItems
local iterateDir = function(path)
  local obj = {}
  for k, v in ipairs(_iter(path)) do
    obj{v} = true
  end
  return pairs(obj)
end
local _isDir = love.filesystem.isDirectory
local _isFile = love.filesystem.isFile
local type = function(path)
  local file = _isFile(path)
  local dir = _isDir(path)
  return { file = file, dir = dir}
end
local mkdir = love.filesystem.mkdir

return {
  read = read,
  write = write,
  iterateDir = iterateDir,
  type = type,
  mkdir = mkdir
}