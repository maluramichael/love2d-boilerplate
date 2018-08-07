local loadTimeStart = love.timer.getTime()

require "globals"

local debugMenu = false

function love.load()
  -- random
  math.randomseed(os.time())

  -- physics
  love.physics.setMeter(16)

  -- graphics
  local filter = config.graphics.filter
  love.graphics.setDefaultFilter(filter.down, filter.up, filter.anisotropy)
  love.graphics.setBackgroundColor(0,0,0)

  -- states
  -- Draw is left out so we can override it ourselves
  local callbacks = {"errhand", "update"}
  for k in pairs(love.handlers) do
    callbacks[#callbacks + 1] = k
  end

  gameState.registerEvents(callbacks)
  gameState.switch(states.launch)

  if DEBUG then
    local loadTimeEnd = love.timer.getTime()
    loadTime = (loadTimeEnd - loadTimeStart)
    print(("Loaded game in %.3f seconds."):format(loadTime))
    print(("Loaded assets in %.3f seconds."):format(assetLoadTime))
  end
end

-- system
function love.draw(dt)
  if initialized == false then
    return false
  end

  local drawTimeStart = love.timer.getTime()
  love.graphics.clear(0,0,0)
  gameState.current():draw()

  local drawTimeEnd = love.timer.getTime()
  local drawTime = drawTimeEnd - drawTimeStart

  if debugMenu then
    local width, height = love.graphics.getDimensions()

    love.graphics.push("all")
    love.graphics.setColor(0, 0, 0, 0.4)
    love.graphics.rectangle("fill", 0, 0, width, height)
    local x, y = config.debug.stats.position.x, config.debug.stats.position.y
    local dy = config.debug.stats.lineHeight
    local stats = love.graphics.getStats()

    local memoryUnit = "KB"
    local ram = collectgarbage("count")
    local vram = stats.texturememory / 1024
    if not config.debug.stats.kilobytes then
      ram = ram / 1024
      vram = vram / 1024
      memoryUnit = "MB"
    end
    local info = {
      "FPS:             " .. ("%0d"):format(love.timer.getFPS()),
      "DRAW:            " .. ("%0.3fms"):format(lume.round(drawTime * 1000, .001)),
      "RAM:             " .. string.format("%0.2f", lume.round(ram, .01)) .. memoryUnit,
      "VRAM:            " .. string.format("%0.2f", lume.round(vram, .01)) .. memoryUnit,
      "Draw:            " .. stats.drawcalls,
      "Draw batched:    " .. stats.drawcallsbatched,
      "Images:          " .. stats.images,
      "Canvases:        " .. stats.canvases,
      "Switches:        " .. stats.canvasswitches,
      "Shader switches: " .. stats.shaderswitches,
      "Fonts:           " .. stats.fonts,
      string.format("Loaded game in %.3f seconds.", loadTime),
      string.format("Loaded assets in %.3f seconds.", assetLoadTime),
    }
    love.graphics.setFont(config.debug.stats.font[config.debug.stats.fontSize])
    for i, text in ipairs(info) do
      local sx, sy = config.debug.stats.shadowOffset.x, config.debug.stats.shadowOffset.y
      love.graphics.setColor(config.debug.stats.shadow)
      love.graphics.print(text, x + sx, y + sy + (i - 1) * dy)
      love.graphics.setColor(config.debug.stats.foreground)
      love.graphics.print(text, x, y + (i - 1) * dy)
    end
    love.graphics.pop()
  end
end

function love.update(dt)
  if DEBUG and loveBird then
    loveBird.update()
  end

  if DEBUG and lurker then
    lurker.update()
  end
end

function love.keypressed(key, code, isRepeat)
  if not RELEASE and code == config.debug.key then
    debugMenu = not debugMenu
  end
end

function love.resize(w, h)
  print(("Window resized to width: %d and height: %d."):format(w, h))
end
