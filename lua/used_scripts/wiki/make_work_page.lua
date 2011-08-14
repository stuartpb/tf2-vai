local achievements = require "lua.achievements"

local classes = {"Medic", "Pyro", "Heavy", "Scout", "Sniper",
  "Spy", "Soldier", "Demoman", "Engineer"}

for i=1, #classes do
  print('<tr><th colspan="2">'..classes[i]..'</th><tr>')
  local class_achs = achievements[string.lower(classes[i])]
  local tokens = {}
  for k, v in pairs(class_achs) do
    tokens[#tokens+1] = {
      token = k,
      name = v.name}
  end
  table.sort(tokens, function(m,n) return m.token < n.token end)
  for j=1, #tokens do
    print((string.gsub(
      '<tr title="$name"><td>$token</td>\n  <td></td>\n</tr>',
      "%$(%a*)",tokens[j])))
  end
end
