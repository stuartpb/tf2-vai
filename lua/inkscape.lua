local inkscape = {}

--Executes Inkscape with the parameters specified in the table argument.
local function exec(params)
  return os.execute(
    '"C:/Program Files (x86)/Inkscape/inkscape.exe" '
    ..table.concat(params,' '))
end

inkscape.exec = exec

--Renders an SVG with Inkscape.
local function render(src,dest,w,h)
  return exec{'-f',src,'-e',dest,'-w',w,'-h',h}
end

inkscape.render = render

return inkscape
