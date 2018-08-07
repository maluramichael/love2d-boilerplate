string.lpad = function(str, len, char)
  if char == nil then
    char = " "
  end
  return str .. string.rep(char, len - #str)
end

string.rpad = function(str, len, char)
  if char == nil then
    char = " "
  end
  return string.rep(char, len - #str) .. str
end

function string.starts(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

function string.ends(str, e)
  return e == "" or string.sub(str, -string.len(e)) == e
end

function spairs(t, order)
  -- collect the keys
  local keys = {}
  for k in pairs(t) do
    keys[#keys + 1] = k
  end

  -- if order function given, sort by it by passing the table and keys a, b,
  -- otherwise just sort the keys
  if order then
    table.sort(
      keys,
      function(a, b)
        return order(t, a, b)
      end
    )
  else
    table.sort(keys)
  end

  -- return the iterator function
  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], t[keys[i]]
    end
  end
end

function dashLine(p1, p2, dash, gap)
  local dy, dx = p2.y - p1.y, p2.x - p1.x
  local an, st = math.atan2(dy, dx), dash + gap
  local len = math.sqrt(dx * dx + dy * dy)
  local nm = (len - dash) / st
  local gr = love.graphics
  gr.push("all")
  gr.translate(p1.x, p1.y)
  gr.rotate(an)
  for i = 0, nm do
    gr.line(i * st, 0, i * st + dash, 0)
  end
  gr.line(nm * st, 0, nm * st + dash, 0)
  gr.pop()
end

function drawLine(from, to)
  love.graphics.line(from.x, from.y, to.x, to.y)
end

function drawLineOffset(from, to)
  love.graphics.line(from.x, from.y, from.x + to.x, from.y + to.y)
end

function getRandomPointInArea(left, top, right, bottom)
  return love.math.random(left, right), love.math.random(top, bottom)
end

function bind(t, k)
  return function(...)
    return t[k](t, ...)
  end
end

function round(num, numDecimalPlaces)
  local mult = 10 ^ (numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
