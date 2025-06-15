local Tiro = {}
Tiro.__index = Tiro

function Tiro.new(x, y, img, width, height)
    local instance = setmetatable({}, Tiro)
    instance.x = x
    instance.y = y
    instance.img = img
    instance.img_width= img:getWidth()
    instance.width = width
    instance.height = height
    instance.direccion = 1
    instance.speed = 50
    instance.puedeDisparar = true
    instance.tiempoDisparoMax = 2
    instance.timerDisparo = instance.tiempoDisparoMax
    instance.Tiros_nave = {}
    return instance
end

function Tiro:dibujar()
    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(self.img, self.x, self.y)
end

function Tiro:actualizar(dt)
    local final = love.graphics:getWidth() - self.width - self.img:getWidth()
    self.x = self.x + (dt * self.speed * self.direccion)
    if self.x > final then
        self.x = final
        self.direccion = -1
    elseif self.x < self.width - (self.img_width) then
        self.x = self.width -(self.img_width)
        self.direccion = 1
    end
end

function Tiro:disparar(dt)
    if self.puedeDisparar then
        local nuevo_tiro = {
            x = self.x,
            y = self.y,
            img = love.graphics.newImage("Tiro.jpg")
        }
        table.insert(self.Tiros_nave, nuevo_tiro)
        self.puedeDisparar = false
        self.timerDisparo = self.tiempoDisparoMax
    end
end

function Tiro:actualizar_tiros(dt)
    self.timerDisparo = self.timerDisparo - dt
    if self.timerDisparo < 0 then
        self.puedeDisparar = true
    end
    for i, tiro in ipairs(self.Tiros_nave) do
        tiro.y = tiro.y + (250 * dt)
        if tiro.y < 0 then
            table.remove(self.Tiros_nave, i)
        end
    end
end

function Tiro:dibujar_tiros()
    for i, tiro in ipairs(self.Tiros_nave) do
        love.graphics.draw(tiro.img, tiro.x, tiro.y)
    end
end

return Tiro