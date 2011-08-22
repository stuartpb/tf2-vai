--As this file contains functions to render all achievements for a given
--resolution, it requires the names of the achievements to render.
local tf = require "lua.achievements"

--This script requires a function to render SVGs
--(taking an input filename, an output filename,
--and a horizontal and vertical resolution).

--The 'inkscape' module of this project, for running
--Inkscape commands, provides this function.

local inkscape = require "inkscape"
local render_svg = inkscape.render

--Table for module to return.
rendering={}

do
  --The names of the various ratios (as used in directory names).
  local ratios={
    [ 4/3 ]= '4-3' , --1280x960
    [ 5/4 ]= '5-4' , --1280x1024
    [16/9 ]='16-9' , --1280x720
    [16/10]='16-10', --1280x800
  }

  --Function that calls the renderer.
  --Separate from single wallpaper rendering so multiple wallpaper rendering
  --doesn't have to look up the ratio each time.
  function rendering.render_wallpaper(class,achievement,w,h,ratio)
    return render_svg(
      string.format("aspect-ratios/%s/%s/%s.svg",ratio,class,achievement),
      string.format("rendered/%ix%i/%s/%s.png",h,w,class,achievement),w,h)
  end

  function rendering.render_single_wallpaper(class,achievement,w,h)
    return render_wallpaper(class,achievement,w,h,
      assert(ratios[w/h],"No wallpapers for requested resolution's aspect ratio"))
  end

  --Renders all wallpapers for a given resolution.
  function rendering.render_all_for_resolution(w,h)
    local ratio = assert(ratios[w/h],"No wallpapers for requested resolution's aspect ratio")
    for class, achievements in pairs(tf) do
      for achievement in pairs(achievements) do
        render_wallpaper(class,achievement,w,h,ratio)
      end
    end
  end

end

return rendering
