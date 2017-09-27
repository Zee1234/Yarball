local load = loadstring or load
function string.escape(self) 
  return self:gsub('\\','\\\\'):gsub('"','\\"'):gsub('\r',''):gsub('\n','\\\\n')
end


local function _export(yarball)
  assert(type(yarball) == 'table', 'Attempt to export non-table')

  local strings = {'return {'}

  local function serialize(object)
    for key, value in pairs(object) do
      assert(type(key) == 'string', 'Table recieved by export is not a simple table')
      local t = type(value)

      if t == 'string' then
        strings[#strings+1] = ('["%s"]="%s",'):format(key:escape(), value:escape())
      elseif t == 'table' then
        strings[#strings+1] = '["'
        strings[#strings+1] = key:escape()
        strings[#strings+1] = '"]'
        strings[#strings+1] = '={'
        serialize(value)
        strings[#strings+1] = '},'
      else
        error 'Table recieved by export is not a simple table'
      end
    end
  end
  serialize(yarball)
  strings[#strings+1] = '}'
  return string.dump(load(table.concat(strings)))
  --return table.concat(strings)
end


return _export