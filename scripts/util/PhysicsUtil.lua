local PhysicsUtil = {}

function PhysicsUtil.isColliding(rect1, rect2)
   local dir=nil
   if (rect1.x < rect2.x+rect2.width and rect2.x < rect1.x+rect1.width and rect1.y < rect2.y+rect2.height and rect2.y < rect1.y+rect1.height) then
      local q

      local cx1 = rect1.x + rect1.width/2
      local cy1 = rect1.y + rect1.height/2
      local cx2 = rect2.x + rect2.width/2
      local cy2 = rect2.y + rect2.height/2

      local t1 = rect1.y
      local b1 = rect1.y + rect1.height
      local l1 = rect1.x
      local r1 = rect1.x + rect1.width
      local t2 = rect2.y
      local b2 = rect2.y + rect2.height
      local l2 = rect2.x
      local r2 = rect2.x + rect2.width

      if (cx1 <= cx2 and cy1 <= cy2) then
         q = 1
      end
      if (cx1 >= cx2 and cy1 <= cy2) then
         q = 2
      end
      if (cx1 > cx2 and cy1 > cy2) then
         q = 3
      end
      if (cx1 < cx2 and cy1 > cy2) then
         q = 4
      end

      --right
      if ((b1-t2 > r2-l1 and q == 2) or (b2-t1 < r1-l2 and q == 3)) then
         dir="r"
      --left
      elseif ((b1-t2 > r1-l2 and q == 1) or (b2-t1 > r1-l2 and q == 4)) then
         dir="l"
      --top
      elseif ((b1-t2 < r2-l1 and q == 2) or (b1-t2 < r1-l2 and q == 1)) then
         dir="t"
      --bottom
      end
      if ((b2-t1 < r2-l1 and q == 3) or (b2-t1 < r1-l2 and q == 4)) then
         dir="b"
      end
   end
   return dir
end

return PhysicsUtil