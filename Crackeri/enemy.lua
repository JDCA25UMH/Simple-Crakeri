function Enemy(x, y)
  local image = love.graphics.newImage("image.png")
  return {
    x = x,
    y = y,
    image = image,
    width = image:getWidth(),
    velocidad = 50,
    direccion = 1,

    draw = function(self)
      love.graphics.setColor(1, 1, 1)
      love.graphics.draw(self.image, self.x, self.y)
    end,

    update = function(self, dt)
      local final = love.graphics:getWidth() - self.width
      self.x = self.x + (dt * self.velocidad * self.direccion)

      if self.x > final then
        self.x = final
        self.direccion = -1
      elseif self.x < 0 then
        self.x = 0
        self.direccion = 1
      end
    end,
  }
end