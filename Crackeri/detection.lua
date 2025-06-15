function detectCollision(x1, y1, width1, height1, x2, y2, width2, height2)

if x1 + width1  > x2 and x1< x2 + width2 and y1 + height1 > y2 and y1 < y2 + height2 then
   
   return true
else
	return false
end

end


function Detectover(x1, y1, width1, height1, x2, y2, width2, height2)

if x1 + width1  > x2 and x1< x2 + width2 and y1 + height1 > y2 and y1 < y2 + height2 then
return true
else
 return false
end


end 


function Detectpoint(x1, y1, width1, height1, x2, y2, width2, height2)

if x1 + width1  > x2 and x1< x2 + width2 and y1 + height1 > y2 and y1 < y2 + height2 then
return true
else
 return false
end

end


function DetectEnd(x1, y1, width1, height1, x2, y2, width2, height2)
if x1 + width1  > x2 and x1< x2 + width2 and y1 + height1 > y2 and y1 < y2 + height2 then
return true
else
 return false
end

end