--encoding: utf-8
--(Ü has to be explicitly defined so it can be converted)

--This file standardizes the filenames of all achievement SVGs to
--the lowercase achievement string token, as Valve packages their
--icon packs inconsistently, with different filename patterns for
--each pack (not even consistent in the same update or same pack,
--in the case of the Soldier and Demoman).

--The original file types are also inconsistent, but since this
--script is designed to run after they have all been converted
--to SVG, this is ignored.

--Usage:
--
--  lua move_to_standardized_filenames.lua [class]
--
--To be run from a directory containing an "incoming" directory, containing
--SVG files with the original filnames (ie "incoming/PeerReview.svg"),
--and a "square" directory, containing a directory for the class
--whose achievements are getting renamed (ie "square/medic/").
--If no class is specified, the script will attempt to move every filename for
--every class from "incoming" to that class's directory in "square".

--Get the mapping of tokens to original filenames
local zipnames=require "lua.zipped_set_filenames"

function pathtosvg(subdir,presvg)
  return string.format("%s/%s.svg",subdir,presvg)
end

function rename(subdir,orig,new)
  local origname=pathtosvg("incoming",orig)
  local newname=pathtosvg("square/"..subdir,new)
  local success,message= os.rename(origname,newname)
  if not success then print(message) end
end

local class=arg[1]

if class then
  if not zipnames[class] then error(string.format("%q is not a valid class",class))
  else
    for token, orig in pairs(zipnames[class]) do
      rename(class,orig,token)
    end
  end
else
  for class, namepack in pairs(zipnames) do
    for token, orig in pairs(namepack) do
      rename(class,orig,token)
    end
  end
end
