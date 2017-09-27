math.randomseed(os.time())
math.random()
math.random()
math.random()
math.random()
math.random()


local randomTable = require 'spec.randomSimpleTable'
local dataDump = require 'spec.dataDumper'

local export = require 'yarball.export'

describe('`export`', function()
  it('Creates code that can be loaded by `load` or `loadfile` (based on version)', function()
    if loadstring then
      assert.is.truthy(loadstring(export(randomTable())))
    elseif load then
      assert.is.truthy(load(export(randomTable())))
    else error 'Neither load nor loadstring in environment' end
  end)


  it('Creates an identical (simple) table', function()
    for i = 1, 1000 do
      local inn = randomTable()
      local out
      local expo = export(inn)
      --if i == 1 then print(dataDump(expo)) end
      assert.is_true(type(expo) == 'string')
      if loadstring then
        out = loadstring(expo)
      elseif load then
        out = load(expo)
      else error 'Neither load nor loadstring in environment' end
      assert.is.truthy(out())
      assert.are.same(out(),inn)
    end
  end)
end)