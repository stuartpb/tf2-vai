local tf = require "lua.achievements"
require "imlua"

function convert(filename)
  im.FileImageLoad("tgas/"..filename..".tga"):Save("pngs/"..filename..".png","PNG")
end

for token in pairs(tf.demoman) do
  --Demoman milestones are prefixed with "tf_demo_" instead of "tf_demoman_".
  if string.find(token,"achieve_progress") then
    convert('tf_demo_'..token)
  else
    --All other Demoman achievements are named with their full token.
    convert('tf_demoman_'..token)
  end
end
