local yarball = require 'yarball.yarball' 'lfs'
local encode = yarball.encode
local decode = yarball.decode

local ld = loadstring or load


local thisname = 'lfs_spec.lua'
local thispath = debug.getinfo(1).source:sub(2, -1*thisname:len()-1)
local projectpath = thispath..'/..'

local cipath = os.getenv 'TRAVIS_BUILD_DIR' or os.getenv 'APPVEYOR_BUILD_FOLDER' or projectpath
local copypath = cipath..'/../yarball_duplication_directory_yep'

describe('Encode', function()
  it('runs without error', function()
    assert.is.truthy(encode(projectpath))
  end)

  it('retuns a string', function()
    assert.is_true(type(encode(projectpath)) == 'string')
  end)

  it('retuns a string that can be loaded into a function', function()
    assert.is_true(type(ld(encode(projectpath))) == 'function')
  end)

  it('retuns a string that can be loaded into a function that returns a table', function()
    assert.is_true(type(ld(encode(projectpath))()) == 'table')
  end)

  it('returns identical output for identical input', function()
    assert.are.same(encode(projectpath), encode(projectpath))
    assert.are.same(encode(projectpath..'/..'), encode(projectpath..'/..'))
  end)

  it('returns different outputs for different input', function()
    assert.are_not.same(encode(projectpath..'/..'), encode(projectpath))
  end)
end)

describe('Decode', function()
  local projectstring = encode(cipath)
  local projectfunction = ld(projectstring)
  local projectobject = projectfunction()

  it('runs successfully', function()
    decode(copypath, projectobject)
  end)

  it('creates an exact duplicate', function()
    assert.are.same(ld(encode(copypath))(), projectobject)
  end)

  it('functions even if folders already exist', function()
    decode(copypath, projectobject)
  end)

  it('overrides files', function()
    projectobject.spec['dataDumper.lua'] = 'hi'
    decode(copypath, projectobject)
    assert.are.same(ld(encode(copypath))(), projectobject)
  end)
end)