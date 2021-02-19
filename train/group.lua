--------------------------------------------------------------------------------
-- Group
--------------------------------------------------------------------------------

Group = class(function(group, index, x, y, size) 
	group:init(index, x, y, size) 
end)


function Group:init(index, x, y, size)
	
	if (index == nil) then index = 0 end
	if (size == nil) then size = 0 end
	
	-- child objs --

	local headX = 0
	local headW = 100
	if (size == 1) then 
		headX = 100 
		headW = 150
	end
	local headY = 0
	
	local faceX = 200
	local faceY = 150
	if (index > 2) then faceY = 200 end
	
	self.head = ViewObject("#skins/levels/basics/bg/animation_tiles.pvr", 0, 0, headW, 100)
	self.head:setClippingRectangle(headX, headY, headW, 100)
	self.head:setBlendMode(BlendMode.BLEND)
	
	if (index == 0) then
		self.head:setColor(252,106,176,255) 	-- r
	elseif (index == 1) then
		self.head:setColor(230,239,114,255) 	-- y
	elseif (index == 2) then
		self.head:setColor(81,252,157,255) 		-- g
	else
		self.head:setColor(82,178,249,255) 		-- b
	end
	
	self.head:setAlpha(0.0)
	
	self.face = ViewObject("#skins/levels/basics/bg/animation_tiles.pvr", 0, 0, 50, 50)
	self.face:setClippingRectangle(faceX, faceY, 50, 50)
	self.face:setBlendMode(BlendMode.BLEND)
	self.face:setAlpha(0.0)
	
	self.halo = ViewObject("#skins/levels/basics/bg/animation_tiles.pvr", 0, 0, 100, 100)
	self.halo:setClippingRectangle(250, 0, 100, 100)
	self.halo:setBlendMode(BlendMode.BLEND)
	self.halo:setAlpha(0.0)
	
	self.particles = {}
	
	for i=1,32 do
	
		local particle = ViewObject("#skins/levels/basics/bg/animation_tiles.pvr", 0, 0, 14, 14)
		
		local px = 0
		local py = 118
		
		if (Utils.randomInt(10) > 5) then
			px = 208		
		else
			px = 228
		end
		
		particle:setClippingRectangle(px, py, 14, 14)
		particle:setPosition(x + Utils.randomInt(92), y + Utils.randomInt(92))
		particle:setBlendMode(BlendMode.BLEND)
		
		if (index == 0) then
			particle:setColor(252,106,176,255) 	-- r
		elseif (index == 1) then
			particle:setColor(230,239,114,255) 	-- y
		elseif (index == 2) then
			particle:setColor(81,252,157,255) 		-- g
		else
			particle:setColor(82,178,249,255) 		-- b
		end
		
		particle:setAlpha(0.0)
		
		table.insert(self.particles, particle)
		
	end
	
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

function Group:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end


function Group:setPosition(x, y)

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


function Group:applyPosition()
	self.head:setPosition(self.x, self.y)
	self.face:setPosition(self.x + Utils.randomInt(46), self.y + Utils.randomInt(46))
	self.halo:setPosition(self.x, self.y)
end


function Group:getX()
	return self.x
end


function Group:setX(x)
	self.x = x
	self:applyX()
end


function Group:applyX()
	self.head:setX(self.x)
	self.face:setX(self.x + Utils.randomInt(46))
	self.halo:setX(self.x)
end


function Group:getY()
	return self.y
end


function Group:setY(y)
	self.y = y
	self:applyY()
end


function Group:applyY()
	self.head:setY(self.y)
	self.face:setY(self.y + Utils.randomInt(46))
	self.halo:setY(self.y)
end

--
--
-- 
--
--

function Group:show(delay, useHalo)

	if (delay == nil) then delay = 0 end
	if (delay < 0) then delay = 0 end

	Tweener.tween(self.head, Tweenables.ALPHA, 0.0, 1.0, 0.01, "Quad.easeOut", delay)
	Tweener.tween(self.face, Tweenables.ALPHA, 0.0, 1.0, 0.01, "Quad.easeOut", delay)
	Tweener.tween(self.halo, Tweenables.ALPHA, 0.0, 1.0, 0.01, "Quad.easeOut", delay)

end


function Group:dim()
	Tweener.tween(self.halo, Tweenables.ALPHA, 1.0, 0.0, BEAT, "Quad.easeOut", 0)
end


function Group:fadeOut(duration, delay)
	
	if (self.alive == false) then return end
	
	if (duration == nil) then duration = BEAT end
	if (duration < 0) then duration = BEAT end
	
	if (delay == nil) then delay = 0 end
	if (delay < 0) then delay = 0 end
	
	Tweener.tween(self.head, Tweenables.ALPHA, 1.0, 0.0, duration, "Quad.easeOut", delay)
	Tweener.tween(self.face, Tweenables.ALPHA, 1.0, 0.0, duration, "Quad.easeOut", delay)
	
	self.halo:setAlpha(0)

end


function Group:glow()

	if (self.alive == false) then return end
	
	self.halo:setAlpha(1.0)

end


function Group:explode()

	self.head:setAlpha(0)
	self.face:setAlpha(0)
	self.halo:setAlpha(0)
	
	for i,particle in ipairs(self.particles) do
		
		local tscale = 3 * Utils.random()
		local tx = particle:getX() - 100 + Utils.randomInt(200)
		local ty = particle:getY() - 100 + Utils.randomInt(200)
		
		particle:setAlpha(1.0)
		particle:setRotation(Utils.randomInt(360))
		particle:setScale(0.1, 0.1)
		
		Tweener.tween(particle, Tweenables.SCALE, nil, tscale, BEAT, "Quad.easeOut", 0)
		Tweener.tween(particle, Tweenables.X, nil, tx, BEAT, "Quad.easeOut", 0)
		Tweener.tween(particle, Tweenables.Y, nil, ty, BEAT, "Quad.easeOut", 0)
		Tweener.tween(particle, Tweenables.ALPHA, 1.0, 0.0, BEAT * 0.5, "Quad.easeOut", BEAT * 0.5)
		
	end
	
end


--
--
-- 
--
--


function Group:dispose()

	self.head:dispose()
	self.face:dispose()
	self.halo:dispose()
	
	for i,particle in ipairs(self.particles) do
		particle:dispose()
	end
end


function Group:destroy()
	
	if (self.alive == false) then return end
	self.alive = false
	
	self:dispose()
	
	self.x = nil
	self.y = nil
	self.head = nil
	self.face = nil
	self.halo = nil
	self.particles = nil	
end

