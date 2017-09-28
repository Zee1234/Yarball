local randomString = require 'spec.randomString'
local function descend(x)
  return math.random() < x
end
local function ascend(x)
  return math.random() < x
end
local function randomName()
  return randomString(math.random(5,20),'%w%p"\'')
end
local function randomContent()
  return randomString(math.random(5,2000),'%w%p"\'')
end


local function randomTable()
  local ret = {}
  local total = 1

  local function fillRecursive(tab, depth)
    total = total + 1
    depth = depth or 1
    repeat
      tab[randomName()] = randomContent()
      if descend(0.5) then
        local name = randomName()
        tab[name] = {}
        fillRecursive(tab[name], depth+1)
      end
      if ascend(total/250) then break; end
    until false
  end

  fillRecursive(ret)

  return ret
end


return randomTable