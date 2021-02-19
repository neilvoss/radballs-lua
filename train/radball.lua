--------------------------------------------------------------------------------
-- Radball - should maybe extend vs. decorate?
--------------------------------------------------------------------------------

Radball = class(function(radball, index, x, y) 
	radball:init(index, x, y) 
end)


function Radball:init(index, x, y)
	
	if (index == nil) then index = 0 end
	if (index < 0) then index = 0 end
	if (index > 3) then index = 3 end

	local sx = Utils.randomInt(3) * 50
	local sy = 100 + 50 * index
	
	self.elem = ViewObject("#skins/levels/basics/bg/animation_tiles.pvr", 0, 0, 50, 50)
	self.elem:setClippingRectangle(sx, sy, 50, 50)
	self.elem:setBlendMode(BlendMode.BLEND)
	self.elem:setAlpha(0)
	
	-- position --
		
	if (x == nil) then x = 0 end
	if (y == nil) then y = 0 end
	
	self.x = x
	self.y = y
	self:applyPosition()
	
	self.alive = true
	
end


--
--
-- Position property access/modifiers
--
--

function Radball:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end


function Radball:setPosition(x, y)

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


function Radball:applyPosition()
	self.elem:setPosition(self.x, self.y)
end


function Radball:getX()
	return self.x
end


function Radball:setX(x)
	self.x = x
	self:applyX()
end


function Radball:applyX()
	self.elem:setX(self.x)
end


function Radball:getY()
	return self.y
end


function Radball:setY(y)
	self.y = y
	self:applyY()
end


function Radball:applyY()
	self.elem:setY(self.y)
end

--
--
-- 
--
--

function Radball:fallTo(y, delay, duration)
	
	if (duration == nil) then duration = BEAT * 1.5 end
	
	if (delay == nil) then delay = 0 end
	
	self.elem:setAlpha(1)
	
	Tweener.tween(self.elem, Tweenables.Y, nil, y, duration, "Quad.easeOut", delay)
	
	self.y = y

end


function Radball:swapTo(x, y, halo, swap)
	
	Tweener.tween(self.elem, Tweenables.X, nil, x, BEAT * 0.5, "Quad.easeOut", 0)
	Tweener.tween(self.elem, Tweenables.Y, nil, y, BEAT * 0.5, "Quad.easeOut", 0)
	
	if (halo ~= nil) then
		
		halo:setPosition(self.x, self.y)
		
		Tweener.tween(halo, Tweenables.X, nil, x, BEAT * 0.5, "Quad.easeOut", 0)
		Tweener.tween(halo, Tweenables.Y, nil, y, BEAT * 0.5, "Quad.easeOut", 0)
		
		halo:setAlpha(1.0)
		
		if (swap == true) then
			Tweener.tween(halo, Tweenables.ALPHA, 1.0, 0.0, BEAT * 0.5, "Quad.easeOut", BEAT * 0.5)
		else
			Tweener.tween(halo, Tweenables.ALPHA, 1.0, 0.0, BEAT, "Quad.easeOut", BEAT)
		end
	end
	
	self.x = x
	self.y = y
	
end


function Radball:fadeOut(duration, delay)

	if (self.alive == false) then return end
	
	if (duration == nil) then duration = BEAT end
	if (duration < 0) then duration = BEAT end
	
	if (delay == nil) then delay = 0 end
	if (delay < 0) then delay = 0 end
	
	Tweener.tween(self.elem, Tweenables.ALPHA, 1.0, 0.0, duration, "Quad.easeOut", delay)

end


--
--
-- 
--
--


function Radball:dispose()
	self.elem:dispose()
end


function Radball:destroy()
	
	if (self.alive == false) then return end
	self.alive = false
	
	self:dispose()
	
	self.x = nil
	self.y = nil
	self.elem = nil
		
end

