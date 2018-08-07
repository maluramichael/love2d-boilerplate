local scene = {}
function scene:init()
end
function scene:draw()
  love.graphics.rectangle("fill", 0, 0, 100, 100)
end
function scene:update(dt)
end
function scene:keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
end
return scene
