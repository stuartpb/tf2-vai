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
require "achievement_strings"

function pathtosvg(subdir,presvg)
  return string.format("%s/%s.svg",subdir,presvg)
end

function rename(subdir,orig,new)
  local origname=pathtosvg("incoming",orig)
  local newname=pathtosvg("square/"..subdir,new)
  local success,message= os.rename(origname,newname)
  if not success then print(message) end
end

--[=[ Medic ------
-- All 36 Medic pack images are 422 square pixel images of the "png" extension.

for token,ach in pairs(tf.medic) do
  --The Medic pack does not include milestone images
  if not string.find(token,"achieve_progress") then

    --CamelCase the achievement name, converting the few words starting with
    --a lower-case letter to upper case (concordia, ibi, victoria)
    local orig=string.gsub(ach.name,' (%l?)',string.upper)

    --Remove all non-alphanumeric characters (a couple apostrophes and a comma)
    orig=string.gsub(orig,'%W','')

    --Rename the file at this position to its token
    rename('medic',orig,token)
  end
end

---]=]-------------

--[=[ Pyro -------
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

  --Rename the file at this position to its token
  rename('pyro',orig,token)
end

---]=]-------------

--[=[ Heavy ------
-- All 38 Heavy pack images are 512 square pixel images of the "png" extension.

for token in pairs(tf.heavy) do
  --All Heavy achievements are named with their full token.
  rename('heavy','tf_heavy_'..token,token)
end

---]=]-------------

--[=[ Scout ------
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

  --Rename the file at this position to its token
  rename('scout',orig,token)
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

    --Rename the file at this position to its token
    rename('sniper',orig,token)
  end
end

---]=]-------------

--[=[ Spy --------
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

    --Rename the file at this position to its token
    rename('spy',orig,token)
  end
end

---]=]-------------

--[=[ Soldier ----
-- All 38 Soldier pack images are 512 square pixel images of the "jpg" extension.

do
  --Soldier filenames are so inconsistent I'm just going to straight up map them.
  local map={
    kill_group_with_crocket = "trisplatteral_damage",
    kill_two_during_rocket_jump = "death_from_above",
    three_dominations = "dominator",
    defend_medic = "war_crime_and_punnishment",
    kill_taunt = "spray_of_defeat",
    destroy_sentry_out_of_range = "guns_of_navar0wnedt",
    kill_sniper_while_dead = "mutually_assured_destruction",
    kill_airborne_target_while_airborne = "wings_of_glory",
    kill_engy = "engineer_to_eternity",
    nemesis_shovel_kill = "trench_warfare",
    destroy_stickies = "bomb_squaddie",
    crouch_rocket_jump = "where_eagles_dare",
    buff_friends = "banner_of_brothers",
    kill_twenty_from_above = "screamin",
    shoot_mult_crits = "crockets_are_such_bs",
    kill_defenseless = "geneva_contravention",
    kill_on_fire = "semper_fry",
    kill_five_stunned = "the_longest_gaze",
    freezecam_gibs = "gora_gora_gora",
    kill_spy_killer = "war_crime_spybunal",
    defend_cap_thirty_times = "hamburger_hill",
    gib_grind = "frags_of_our_fathers",
    rj_equalizer_kill = "duty_bound",
    buff_teammates = "the_boostie_boys",
    kill_demoman_grind = "out_damned_scot",
    kill_pyro = "backdraft_dodger",
    equalizer_streak = "aint_got_time_to_bleed",
    kill_with_equalizer_while_hurt = "near_death_expedience",
    bounce_then_shotgun = "for_whom_the_shell_trolls",
    kill_airborne_with_direct_hit = "death_from_below",
    freezecam_taunt = "worth_a_thousand_wars",
    duo_soldier_kills = "gomer_pileon", --most egregious break: Brothers in Harms
    mvp = "metals_of_honor",
    ride_the_cart = "ride_the_valkartie",
    assist_medic_uber = "mashed",
  }

  for token in pairs(tf.soldier) do
    local orig

    --The Soldier pack uses the real full token name for milestone filenames
    if string.find(token,"achieve_progress") then
      orig=token
    else
      orig=map[token]
    end

    --Each filename is prefixed with tf_soldier_
    --(like the token, but, except for milestones, not the same).
    orig="tf_soldier_"..orig

    --Rename the file at this position to its defname
    rename('soldier',orig,token)
  end
end

---]=]-------------

--[=[ Demoman ----
-- All 38 Demoman pack images are 512 square pixel images of the "tga" extension.

for token in pairs(tf.demoman) do
  --Demoman milestones are prefixed with "tf_demo_" instead of "tf_demoman_".
  if string.find(token,"achieve_progress") then
    rename('demoman','tf_demo_'..token,token)
  else
    --All other Demoman achievements are named with their full token.
    rename('demoman','tf_demoman_'..token,token)
  end
end

---]=]-------------
