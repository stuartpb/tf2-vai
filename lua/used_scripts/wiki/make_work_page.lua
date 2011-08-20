local tf = require "lua.achievements"
local notes = require "lua.notes"

local classes = {"Medic", "Pyro", "Heavy", "Scout", "Sniper",
  "Spy", "Soldier", "Demoman", "Engineer"}

for i=1, #classes do
  print('##'..classes[i])
  local class = string.lower(classes[i])
  local tokens = {}
  for k, v in pairs(tf[class]) do
    local note = notes[class][k]
    if note then --quick skip of missing achievment icons
      tokens[#tokens+1] = {
        token = k,
        name = v.name,
        note = note}
    end
  end
  table.sort(tokens, function(m,n) return m.token < n.token end)
  print"<table>"
  print"<tr><th>Filename</th><th>Achievement name</th><th>Remaining work</th></tr>"
  for j=1, #tokens do
    print((string.gsub(
      '  <tr>\n    <td>$token</td>\n    <td>$name</td>\n    <td>\n$note</td>\n  </tr>',
      "%$(%a*)",tokens[j])))
  end
  print"</table>"
end
