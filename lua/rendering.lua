--As this file contains functions to render all achievements for a given
--resolution, it requires the names of the achievements to render.
local tf = require "lua.achievements"

--Table for module to return.
rendering={}

---[=[ Inkscape-specific implementation ---------------------------------------
--Function that executes Inkscape with the parameters
--specified in the table argument.
local function inkscape_exec(params)
  return os.execute(
    '"C:/Program Files (x86)/Inkscape/inkscape.exe" '
    ..table.concat(params,' '))
end

--Function that renders an SVG with Inkscape.
local function inkscape_render(src,dest,wh)
  return inkscape_exec{'-f',src,'-e',dest,'-w',w,'-h',h}
end

--Function to render an SVG at the given resolution.
local function render_svg(src,dest,w,h)
  return inkscape_render(src,dest,w,h)
end
---]=]-------------------------------------------------------------------------

--Function that renders all wallpapers for a given resolution.
do
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
