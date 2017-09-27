return function(lib)
  assert(lib == 'lfs' or lib == 'love', 'No filesystem library information provided')

  return {
    encode = require 'yarball.encode' (lib),
    decode = require 'yarball.decode' (lib)
  }
end