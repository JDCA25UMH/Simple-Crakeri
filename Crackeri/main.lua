
local enemy = require "enemy"

local superior = require "superior"

local Button= require "button"

local Tiro = require "tiro"

local DetectionCollision = require "detection"

local game= {

	state={
		menu=true,
		running=false,
		ended= false
	}
}



local buttons= {
	colors= {
		red= 0.6, 
		blue=0.6,
		green=0.6
	},
	menu_state={}
}
 local border= {
	point= 0,
	dos_border = {}
}




local score_space= 60

function love.load()

 enemy = Enemy(20 + score_space,20+score_space)
    local img = love.graphics.newImage("Tiro.jpg")
    
 
    tiroObj = Tiro.new((enemy.width/2)+score_space ,(enemy.image:getHeight()/2)+score_space,
     img,enemy.image:getWidth()/2, enemy.image:getHeight()/2 )

 Bloque = {}
 Bloque.__index = Bloque

 function Bloque.new(x,y,width, height)
 	local instance = setmetatable({}, Bloque)
    instance.x=x
    instance.y= y
    instance.width = width
    instance.height = height
 	return instance
 end


 bloque1 = Bloque.new(0,550,50,50)
 bloque2 = Bloque.new(50,550,50,50)
 bloque3 = Bloque.new(100,550,50,50)
 bloque4 = Bloque.new(50,500,50,50)
  shot = Bloque.new(65,479,20,20) 

puedeDisparar= true
TiempoDisparoMax= 0.2
timerDisparo = TiempoDisparoMax

balas = {}

balasImg = love.graphics.newImage("BalaLinda.jpg")


local function startNewGame()
   game.state["menu"] = false
    game.state["running"] = true
end



buttons.menu_state.play_game = Button(startNewGame,{r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]},
 {r = 0, g = 0, b = 0}, 120, 40)
buttons.menu_state.settings= Button(nil, {r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]}, 
	{r = 0, g = 0, b = 0}, 120, 40 )


border.dos_border.primero = SuperiorBorder(10, 10,love.graphics.getWidth()-20,60)
border.dos_border.tabla_uno = SuperiorBorder(love.graphics.getWidth()/2 -40, 20 ,40 ,40)

border.dos_border.score= SuperiorBorder(love.graphics.getWidth()/2-140,30)
border.dos_border.puntos = SuperiorBorder(love.graphics.getWidth()/2-30,30)


end 

function love.update(dt)
enemy:update(dt)

   tiroObj:actualizar(dt)
    tiroObj:disparar(dt)
    tiroObj:actualizar_tiros(dt)


function Bloque:move(dt, minX, maxX)
    if love.keyboard.isDown("right") then
        self.x = math.min(self.x + (dt * 120), maxX)
    elseif love.keyboard.isDown("left") then
        self.x = math.max(self.x - (dt * 120), minX)
    end
end
bloque1:move(dt, 0, 649)
bloque2:move(dt, 50, 699)
bloque3:move(dt, 100, 749)
bloque4:move(dt, 50, 699)
shot:move(dt, 65, 714)



timerDisparo = timerDisparo -(dt*1)

if timerDisparo<0 then
    puedeDisparar= true
end

nuevaBala= {}
if love.keyboard.isDown("up") and puedeDisparar then
nuevaBala = {
    x= shot.x,
    y = shot.y,
    img= balasImg
}
table.insert(balas, nuevaBala)
puedeDisparar= false
timerDisparo = TiempoDisparoMax
end

for i,bala in ipairs(balas)do
bala.y = bala.y -(250*dt)
if bala.y < 0 then 
table.remove(balas,i)
end


end


function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do -- check if one of the buttons were pressed
                    buttons.menu_state[index]:checkPressed(x, y)
              
                end
                elseif game.state["ended"]then
                    for index in pairs(buttons.menu_state)do
                    buttons.menu_state[index]:checkPressed(x, y)
                end
             end
          end
       end
    end



end


function love.draw()

if game.state["running"]then 
love.graphics.setBackgroundColor(1,1,1)
function drawBlock(block, color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", block.x, block.y, block.width, block.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", block.x, block.y, block.width, block.height)
end

drawBlock(bloque1, {0.5288, 0.1122, 0.988})
drawBlock(bloque2, {0.5288, 0.1122, 0.988})
drawBlock(bloque3, {0.5288, 0.1122, 0.988})
drawBlock(bloque4, {0.5288, 0.1122, 0.988})
drawBlock(shot, {0,0,0})

local fondo= love.graphics.newFont(16)
love.graphics.setFont(fondo)




enemy:draw()
tiroObj:dibujar()
tiroObj:dibujar_tiros()

border.dos_border.primero:background()
border.dos_border.tabla_uno:tables_dos()
border.dos_border.score:letrero()
border.dos_border.puntos:points(border.point)


for i = #tiroObj.Tiros_nave, 1, -1 do

  local tiro = tiroObj.Tiros_nave[i]

function Bloque:detectionfinal(x,y,width,height)

local over = Detectover(self.x, self.y, self.width, self.height, tiro.x,
    tiro.y, tiro.img:getWidth(), tiro.img:getHeight())
if over then 
game.state["running"] = false
 game.state["ended"] = true 
end

end

bloque1:detectionfinal(bloque1.x, bloque1.y, bloque1.width, bloque1.height)
bloque2:detectionfinal(bloque2.x, bloque2.y, bloque2.width, bloque2.height)
bloque3:detectionfinal(bloque3.x, bloque3.y, bloque3.width, bloque3.height)
bloque4:detectionfinal(bloque4.x, bloque4.y, bloque4.width,bloque4.height)
shot:detectionfinal(shot.x, shot.y, shot.width,shot.height)

for i, bala in ipairs(balas)do
love.graphics.draw(bala.img, bala.x, bala.y)

for i = #tiroObj.Tiros_nave, 1, -1 do

  local tiro = tiroObj.Tiros_nave[i]


  for j = #balas, 1, -1 do
    local bala = balas[j]
    local collision = detectCollision(tiro.x, tiro.y, tiro.img:getWidth(), tiro.img:getHeight(),
                                      bala.x, bala.y, bala.img:getWidth(),bala.img:getHeight())

  local pointer = Detectpoint(bala.x, bala.y, bala.img:getWidth(), bala.img:getHeight(),
    enemy.x, enemy.y, enemy.width, enemy.image:getHeight())

local endsuperior = DetectEnd(bala.x, bala.y, bala.img:getWidth(), bala.img:getHeight(),
    border.dos_border.primero.x, border.dos_border.primero.y, border.dos_border.primero.width,
    border.dos_border.primero.height)

    if collision then
      -- Maneja la colisión entre el tiro y el enemigo
      table.remove(tiroObj.Tiros_nave, i)
      table.remove(balas, j)
   elseif pointer then 

table.remove(balas, j)
      border.point = border.point + 1
 
 elseif endsuperior then

    table.remove(balas, j)
  end

end
end

end 
end


elseif game.state["menu"] then 
local fondo= love.graphics.newFont(16)
buttons.menu_state.play_game:draw("Play Game", 10, 20, 17, 10)
love.graphics.setFont(fondo)
 buttons.menu_state.settings:draw("Settings", 10, 70, 17, 10)
 
 elseif game.state["ended"]then 
love.graphics.setBackgroundColor(0,0,0)
local fondo= love.graphics.newFont(25)

buttons.menu_state.exit = Button(love.event.quit,{r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]}, 
    {r = 0, g = 0, b = 0}, 120, 40 )

love.graphics.setFont(fondo)
love.graphics.setColor(1,1,1)
love.graphics.print("Game Over", love.graphics.getWidth()/2-70,
    love.graphics.getHeight()/2 -100)

local fondoexit = love.graphics.newFont(18)
love.graphics.setFont(fondoexit)
buttons.menu_state.exit:draw("Exit", love.graphics.getWidth()/2-60,
    (love.graphics.getHeight()/2)-45 ,17,10)

end

 
end 