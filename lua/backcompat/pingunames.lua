--This file creates a table mapping the numbers of pingu's original
--wallpaper pack to the filenames in this pack.

--Get the mapping of tokens to original filenames
local zipnames=require "lua.zipped_set_filenames"

pingunames={}
local mappings={}

--for all the classes included in pingu's original pack
for _, class in pairs{"medic","pyro","heavy","scout","sniper","spy"} do
  for token, orig in pairs(zipname[class]) do
    --List the class + token as a slash-separated path
    local fullname=class..'/'..token
    --Include the original filename in a mapping used to sort the fullnames later
    mappings[fullname]=orig
    --add this full filename to the set
    pingunames[#pingunames+1]=fullname
  end
end

--Sort the original filenames case-insensitive to determine the order
table.sort(pingunames,
  function(n,m)
    return string.lower(mappings[n]) < string.lower(mappings[m])
  end)

return pingunames
