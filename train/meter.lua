--------------------------------------------------------------------------------
-- Meter
--------------------------------------------------------------------------------

Meter = class(function(meter) 
	meter:init() 
end)


--
--
--
--
--
--
--


function Meter:init()
	
	self.barPadding = 11
	self.baseX = 46
	self.barX = self.baseX + self.barPadding
	self.baseY = 480 - 36
	self.baseWidth = 230
	self.barWidth = self.baseWidth - self.barPadding * 2
	
	self.track = ViewObject("#skins/levels/basics/bg/animation_tiles.png", 0, 0, self.baseWidth, 22)
	self.track:setClippingRectangle(250, 200, self.baseWidth, 22)
	--self.track:setBlendMode(BlendMode.BLEND)
	self.track:setAlpha(0.2)
	self.track:setPosition(self.baseX, self.baseY)
	
	self.barL = ViewObject("#skins/levels/basics/bg/animation_tiles.png", 0, 0, self.barPadding, 22)
	self.barL:setClippingRectangle(250, 200, self.barPadding, 22)
	--self.barL:setBlendMode(BlendMode.BLEND)
	self.barL:setAlpha(0.5)
	self.barL:setPosition(self.baseX, self.baseY)
	
	self.bar = ViewObject("#skins/levels/basics/bg/animation_tiles.png", 0, 0, self.barWidth, 22)
	self.bar:setClippingRectangle(250 + self.barPadding, 200, self.barWidth, 22)
	--self.bar:setBlendMode(BlendMode.BLEND)
	self.bar:setAlpha(0.5)
	self.bar:setPosition(self.barX, self.baseY)
	
	self.pos = ViewObject("#skins/levels/basics/bg/animation_tiles.png", 0, 0, 24, 24)
	self.pos:setClippingRectangle(250, 250, 24, 24)
	--self.pos:setBlendMode(BlendMode.BLEND)
	self.pos:setAlpha(1.0)
	self.pos:setPosition(self.barX + self.barWidth * 0.5, self.baseY)
	
	--
	
	self:valueTo(0.5)
	
end


--
--
-- 
--
--
--
--

function Meter:update()

	--
	
end


--
--
-- Move the meter with a very slight ease of the position. 
-- The track doesn't ease as it is awkward to ease a clipping rect at this point,
-- and easing the width of the track looks bad.
--
--

function Meter:valueTo(value)
	
	if (value < 0) then value = 0 end
	if (value > 1) then value = 1 end
	
	local barWidth = self.barWidth * value
	local posX = self.barX + barWidth - 12
	local fromX = self.pos:getX()
	
	self.bar:setClippingRectangle(250 + self.barPadding, 200, barWidth, 22)
	
	if (posX >= fromX) then
		if (posX - fromX > 12) then fromX = posX + 12 end
	else
		if (fromX - posX > 12) then fromX = posX - 12 end
	end
	
	Tweener.tween(self.pos, Tweenables.X, fromX, posX, BEAT, "Quad.easeOut", 0)
	
end


--
--
-- 
--
--
--
--

function Meter:dispose()
	
	self.track:dispose()
	self.barL:dispose()
	self.bar:dispose()
	self.pos:dispose()
	
end


--
--
--
--
--
--
--


function Meter:destroy()
	
	self:dispose()
	
	self.track = nil
	self.barL = nil
	self.bar = nil
	self.pos = nil
		
end

