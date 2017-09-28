local write, mkdir

local function decode(basePath, yarball)
  assert(type(basePath) == 'string', 'Attempt to call decode without valid path')
  assert(type(yarball) == 'table', 'Attempt to call decode without valid yarball')
  local function runner(path, table)
    mkdir(path)
    for name, data in pairs(table) do
      assert(type(name) == 'string', 'Invalid yarball supplied to decode. Some files may have been created!')
      if type(data) == 'string' then
        write(path..'/'..name, data)
      elseif type(data) == 'table' then
        runner(path..'/'..name, data)
      else
        error 'Invalid yarball supplied to decode. Some files may have been created!'
      end
    end
  end

  runner(basePath, yarball)

  return true
end


return function(lib)
  local flsys = require('yarball.filesystem.'..lib)
  write, mkdir = flsys.write, flsys.mkdir

  return decode
end