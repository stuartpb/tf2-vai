local rendering = require "lua.rendering"
local ra4r = rendering.render_all_for_resolution
local unpack = table.unpack or unpack

local resolutions={
  {1024,768},
  {1280,800},
  {1280,1024},
  {1440,900},
  {1680,1050},
  {1920,1080},
  {1920,1200},
}

for i=1, #resolutions do
  ra4r(unpack(resolutions[i]))
end
