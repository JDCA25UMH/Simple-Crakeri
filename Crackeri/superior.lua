function SuperiorBorder(x,y, width, height)

return {
x=x,
y=y,
width= width,
height= height,

background = function (self)


love.graphics.setColor(0.098, 0, 0.741)
love.graphics.rectangle("fill", self.x, self.y , self.width, self.height )
end,

tables_dos = function(self)
love.graphics.setColor(1,1,1)
love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end,
letrero= function(self)

love.graphics.setColor(1,1,1)
love.graphics.print("Puntaje:", self.x, self.y)

end,

points = function (self,num)

local textnum= tostring(num)
love.graphics.setColor(0,0,0)
love.graphics.print(textnum ,self.x,self.y)



end,

}
end
return SuperiorBorder