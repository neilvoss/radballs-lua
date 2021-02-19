--------------------------------------------------------------------------------
-- Dialog
--------------------------------------------------------------------------------

Dialog = class(function(dialog, index, x, y, row) 
	dialog:init(index, x, y, row) 
end)


function Dialog:init(index, x, y, row)
	
	if (index == nil) then index = 0 end
	if (row == nil) then row = 0 end
	
	-- child objs --
	
	self.elem = ViewObject("#skins/levels/basics/bg/dialog" .. index + 1 .. ".png", 0, 0, 512, 100)
	self.elem:setPosition(x, y)
	self.elem:setClippingRectangle(0, row * 50, 256, 50)
	self.elem:setBlendMode(BlendMode.SCREEN)
	--self.elem:setRotation(-4 + Utils.randomInt(8)) -- too blurry
	self.elem:setAlpha(0)
	
	-- position --
		
	if (x == nil) then x = 0 end
	if (y == nil) then y = 0 end
	
	self.x = x
	self.y = y
	self:applyPosition()
	
end


--
--
-- Position property access/modifiers
--
--

function Dialog:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end


function Dialog:setPosition(x, y)

	if (x == nil) then 
	
		x = self.x
		
	elseif (type(x) == 'table') then
	
		local args = x
		
		if (getmetatable(x) == Point) then
			x = args.x
			y = args.y
		else
			x = args[0]
			y = args[1]
		end
	end
	
	if (y == nil) then y = self.y end
	
	self.x = x
	self.y = y
	
	self:applyPosition()
end


function Dialog:applyPosition()
	self.elem:setPosition(self.x, self.y)
end


function Dialog:getX()
	return self.x
end


function Dialog:setX(x)
	self.x = x
	self:applyX()
end


function Dialog:applyX()
	self.elem:setX(self.x)
end


function Dialog:getY()
	return self.y
end


function Dialog:setY(y)
	self.y = y
	self:applyY()
end


function Dialog:applyY()
	self.elem:setY(self.y)
end

--
--
-- 
--
--

function Dialog:setRow(row)

	if (row == nil) then row = 0 end
	if (row < 0) then row = 0 end
	if (row > 4) then row = 4 end
	
	self.elem:setClippingRectangle(0, row * 50, 256, 50)
	Tweener.tween(self.elem, Tweenables.ALPHA, 0.0, 1.0, BEAT, "Quad.easeOut", 0)
	
	--self.elem:setAlpha(1)

end


function Dialog:fadeOff()
	
	Tweener.tween(self.elem, Tweenables.Y, nil, 490, BEAT, "Quad.easeOut", 0)

end






--
--
-- 
--
--


function Dialog:dispose()
	self.elem:dispose()
end




function Dialog:destroy()
	
	self:dispose()
	
	self.x = nil
	self.y = nil
	self.elem = nil
		
end

