function love.load()
  x = 0
  y = 0
  step = 5
  sizeInt = 30
  texture = love.graphics.newImage("icons/cuter_icon.png")
end

function love.update(dt)
  if love.keyboard.isDown("right") then 
    x = x + step
  elseif love.keyboard.isDown("left") then
    x = x - step
  elseif love.keyboard.isDown("up") then
    y = y - step
  elseif love.keyboard.isDown("down") then
    y = y + step
  end
end

function love.draw()
  love.graphics.setBackgroundColor(200, 100, 00)
  love.graphics.rectangle("fill", x, y, sizeInt, sizeInt)
end
