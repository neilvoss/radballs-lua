--------------------------------------------------------------------------------
-- Cursor
--------------------------------------------------------------------------------

Cursor = class(function(cursor, x, y) 
	cursor:init(x, y) 
end)


function Cursor:init(x, y)
	
	if (index == nil) then index = 0 end
	if (row == nil) then row = 0 end
	
	-- child objs --
	
	self.hand1 = ViewObject("#skins/levels/basics/bg/cursor1.png", 0, 0, 119, 173)
	self.hand1:setPosition(x, y)
	self.hand1:setAlpha(0)
	
	self.hand2 = ViewObject("#skins/levels/basics/bg/cursor2.png", 0, 0, 119, 180)
	self.hand2:setPosition(x, y)
	self.hand2:setAlpha(0)
	
	self.hand3 = ViewObject("#skins/levels/basics/bg/cursor3.png", 0, 0, 105, 138)
	self.hand3:setPosition(x, y)
	self.hand3:setAlpha(0)
	
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

function Cursor:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end


function Cursor:setPosition(x, y)

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


function Cursor:applyPosition()
	self.hand1:setPosition(self.x, self.y)
	self.hand2:setPosition(self.x, self.y)
	self.hand3:setPosition(self.x, self.y)
end


function Cursor:getX()
	return self.x
end


function Cursor:setX(x)
	self.x = x
	self:applyX()
end


function Cursor:applyX()
	self.hand1:setX(self.x)
	self.hand2:setX(self.x)
	self.hand3:setX(self.x)
end


function Cursor:getY()
	return self.y
end


function Cursor:setY(y)
	self.y = y
	self:applyY()
end


function Cursor:applyY()
	self.hand1:setY(self.y)
	self.hand2:setY(self.y)
	self.hand3:setY(self.y)
end

--
--
-- 
--
--

function Cursor:moveTo(x, y, duration, delay)

	if (x == nil) then x = self.x end 
	if (y == nil) then y = self.y end
	
	if (duration == nil) then duration = BEAT end
	if (delay == nil) then delay = 0 end 
	
	Tweener.tween(self.hand1, Tweenables.X, nil, x, duration, "Quad.easeOut", delay)
	Tweener.tween(self.hand1, Tweenables.Y, nil, y, duration, "Quad.easeOut", delay)
	Tweener.tween(self.hand2, Tweenables.X, nil, x, duration, "Quad.easeOut", delay)
	Tweener.tween(self.hand2, Tweenables.Y, nil, y, duration, "Quad.easeOut", delay)
	Tweener.tween(self.hand3, Tweenables.X, nil, x, duration, "Quad.easeOut", delay)
	Tweener.tween(self.hand3, Tweenables.Y, nil, y, duration, "Quad.easeOut", delay)
	
	self.x = x
	self.y = y

end


function Cursor:setState(state)

	if (state == nil) then state = 0 end
	if (state < 0) then state = 0 end
	if (state > 2) then state = 2 end
	
	if (state == 0) then
		self.hand1:setAlpha(1)
		self.hand2:setAlpha(0)
		self.hand3:setAlpha(0)
	end
	
	if (state == 1) then
		self.hand1:setAlpha(0)
		self.hand2:setAlpha(1)
		self.hand3:setAlpha(0)
	end
	
	if (state == 2) then
		self.hand1:setAlpha(0)
		self.hand2:setAlpha(0)
		self.hand3:setAlpha(1)
	end

end


function Cursor:fistPump(numBeats)

	if (numBeats == nil) then numBeats = 4 end
	if (numBeats < 0) then numBeats = 1 end
	
	local startY = self.hand3:getY()
	local endY = startY + 46
	local duration = BEAT * 0.5 - BEAT * 0.01
	
	self:setState(2)

	for i=0,numBeats do
		Tweener.tween(self.hand3, Tweenables.Y, startY, endY, duration, "Quad.easeIn", BEAT * i)
		Tweener.tween(self.hand3, Tweenables.Y, endY, startY, duration, "Quad.easeOut", BEAT * i + BEAT * 0.5)
	end
	
end






--
--
-- 
--
--


function Cursor:dispose()
	self.hand1:dispose()
	self.hand2:dispose()
	self.hand3:dispose()
end


function Cursor:destroy()
	
	self:dispose()
	
	self.x = nil
	self.y = nil
	self.hand1 = nil
	self.hand2 = nil
	self.hand3 = nil
		
end

