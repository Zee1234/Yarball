local randomString = require 'spec.randomString'
local function descend()
  return math.random() < 0.5
end
local function ascend()
  return math.random() < 0.25
end
local function randomName()
  return randomString(math.random(5,20),'%w%p"\'')
end
local function randomContent()
  return randomString(math.random(5,2000),'%w%p"\'')
end


local function randomTable()
  local ret = {}

  local function fillRecursive(tab)
    goUp = false
    repeat
      tab[randomName()] = randomContent()
      if descend() then
        local name = randomName()
        tab[name] = {}
        fillRecursive(tab[name])
      end
      if ascend() then goUp = true end
    until goUp
  end

  fillRecursive(ret)

  return ret
end


return randomTable