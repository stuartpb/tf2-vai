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

--This gets the "tf" table of achievement names.
require "data.achievements"

pingunames={}
local mappings={}

---[=[ Medic ------
-- All 36 Medic pack images are 422 square pixel images of the "png" extension.

for token,ach in pairs(tf.medic) do
  --The Medic pack does not include milestone images
  if not string.find(token,"achieve_progress") then

    --CamelCase the achievement name, converting the few words starting with
    --a lower-case letter to upper case (concordia, ibi, victoria)
    local orig=string.gsub(ach.name,' (%l?)',string.upper)

    --Remove all non-alphanumeric characters (a couple apostrophes and a comma)
    orig=string.gsub(orig,'%W','')

    local fulltoken="medic/"..token
    mappings[fulltoken]=orig
    pingunames[#pingunames+1]=fulltoken
  end
end

---]=]-------------

---[=[ Pyro -------
-- All 38 Pyro pack images are 512 square pixel images of the "png" extension.

for token,ach in pairs(tf.pyro) do
  local orig

  --The Pyro pack uses a completely different rule for milestone filenames
  if string.find(token,"achieve_progress") then
    orig="pyro_"..token
  else
    --The filename for the all-uppercase-letters "OMGWTFBBQ" is uppercase
    if not string.find(ach.name,"%U") then
      orig=ach.name
    else
      --all other filenames are lowercase
      orig=string.lower(ach.name)
    end

    --convert all spaces to underscores
    orig=string.gsub(orig,' ','_')

    --Remove all characters that aren't alphanumeric, underscores,
    --or an apostrophe (in "makin'_bacon")
    --(basically the question mark in "Got A Light?")
    orig=string.gsub(orig,"[^%w_']",'')
  end

  local fulltoken="pyro/"..token
  mappings[fulltoken]=orig
  pingunames[#pingunames+1]=fulltoken
end

---]=]-------------

---[=[ Heavy ------
-- All 38 Heavy pack images are 512 square pixel images of the "png" extension.

for token in pairs(tf.heavy) do
  --All Heavy achievements are named with their full token.
    local fulltoken="heavy/"..token
    mappings[fulltoken]="tf_heavy_"..token
    pingunames[#pingunames+1]=fulltoken
end

---]=]-------------

---[=[ Scout ------
-- All 38 Scout pack images are of the "png" extension.
-- Dimensions range from 512 pixels square to as large as 519x516 pixels
-- ("side_retired.png").

for token, ach in pairs(tf.scout) do
  local orig

  --The Scout pack uses full tokens for milestone filenames
  if string.find(token,"achieve_progress") then
    orig="tf_scout_"..token
  else
    --all filenames are lowercase
    orig=string.lower(ach.name)

    --convert all spaces and hyphens to underscores
    orig=string.gsub(orig,'[ %-]','_')

    --Remove all characters that aren't alphanumeric or underscores
    --("I'm Bat Man" loses its apostrophe, lots of other punctuation)
    orig=string.gsub(orig,'[^%w_]','')

    --Straight-Up Outright Typo Accomodation:
    --"Beanball" has 3 'l's in its filename ("beanballl").
    orig=string.gsub(orig,'beanball','beanballl')
    --In "Belittled Beleaguer", "Beleaguer" is misspelled "beleauger".
    orig=string.gsub(orig,'beleaguer','beleauger')

  end

  local fulltoken="scout/"..token
  mappings[fulltoken]=orig
  pingunames[#pingunames+1]=fulltoken
end

---]=]-------------

---[=[ Sniper -----
-- All 35 Sniper pack images are 512 square pixel images of the "png" extension.

for token, ach in pairs(tf.sniper) do
  --The Sniper pack does not include milestone images
  if not string.find(token,"achieve_progress") then

    --all filenames are lowercase
    local orig=string.lower(
      --Also, the 'Ü' in "Überectomy" is converted to a plain 'u'.
      string.gsub(ach.name,'Ü','u'))

    --convert all spaces to underscores
    orig=string.gsub(orig,' ','_')

    --"De-sentry-lized" keeps its hyphens
    if string.find(orig,"[^%w%-]") then
      --but "Self-destruct Sequence" does not
      --Remove all characters that aren't alphanumeric or underscores
      orig=string.gsub(orig,"[^%w_]",'')
    end

    --Straight-Up Outright Typo Accomodation:
    --The filename for "Dropped Dead" is "drop_dead".
    orig=string.gsub(orig,'dropped_dead','drop_dead')

    --Each filename is prefixed with tf_sniper_
    --(like the token, but not the same).
    orig="tf_sniper_"..orig

    local fulltoken="sniper/"..token
    mappings[fulltoken]=orig
    pingunames[#pingunames+1]=fulltoken
  end
end

---]=]-------------

---[=[ Spy --------
-- All 34 Spy pack images are 512 square pixel images of the "png" extension.

for token, ach in pairs(tf.spy) do
  --The Spy pack does not include milestone images
  if not string.find(token,"achieve_progress") then

    --all filenames are lowercase
    local orig=string.lower(ach.name)

    --convert all spaces to underscores
    orig=string.gsub(orig,' ','_')

    --Remove all characters that aren't alphanumeric or underscores
    orig=string.gsub(orig,"[^%w_]",'')

    --Straight-Up Outright Typo Accomodation:
    --"Triplecrossed"'s filename is "triple_crossed".
    orig=string.gsub(orig,'triplecrossed','triple_crossed')
    --For some reason, Eyes in "tf_spy_for_your_Eyes_only" is capitalized.
    --(Not that Windows would care, but Linux would, and dammit,
    --this script is portable!)
    orig=string.gsub(orig,'eyes','Eyes')

    --Each filename is prefixed with tf_spy_
    --(like the token, but not the same).
    orig="tf_spy_"..orig

    local fulltoken="spy/"..token
    mappings[fulltoken]=orig
    pingunames[#pingunames+1]=fulltoken
  end
end

---]=]-------------

table.sort(pingunames,function(n,m) return string.lower(mappings[n])<string.lower(mappings[m]) end)

return pingunames
