local export = require 'yarball.export'

local read, iterateDir, filetype

local function encode(basePath)
  assert(type(basePath) == 'string', 'Attempt to call encode with non-string argument')

  basePath = basePath:gsub('\\','/'):gsub('/%s*^','') -- Standardize syntax

  assert(filetype(basePath).dir, 'Attempt to call encode on a non-directory')

  local function runner(path)
    local container = {}
    for name in iterateDir(path) do
      repeat
        if name == '.' or name == '..' then break; end
        local fullpath = path..'/'..name
        local details = filetype(fullpath)
        if details.file then
          container[name] = read(fullpath)
        elseif details.dir then
          container[name] = runner(fullpath)
        else
          return error 'Found non-file, non-directory object'..fullpath
        end
      until true
    end
    return container
  end

  return export(runner(basePath))
end



return function(lib)
  local flsys = require('yarball.filesystem.'..lib)
  read, iterateDir, filetype = flsys.read, flsys.iterateDir, flsys.type

  return encode
end