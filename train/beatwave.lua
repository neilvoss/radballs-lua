--------------------------------------------------------------------------------
-- BeatWave
--------------------------------------------------------------------------------

BeatWave = class(function(beatwave) 
	beatwave:init() 
end)


function BeatWave:init()
	
	--self.elem = ViewObject("#skins/levels/basics/bg/beatwave.png", 0, 0, 320, 46)
	--self.elem:setScaleX(4.0)
	--self.elem:setBlendMode(BlendMode.ADD)
	
	self.elem = ViewObject("#skins/levels/basics/bg/animation_tiles.pvr", 0, 0, 320, 60)
	self.elem:setClippingRectangle(0, 450, 320, 60)
	self.elem:setBlendMode(BlendMode.BLEND)
	
	self.x = 0
	self.y = 480 + 23
	self:applyPosition()
	
end


--
--
-- Position property access/modifiers
--
--

function BeatWave:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end


function BeatWave:setPosition(x, y)

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


function BeatWave:applyPosition()
	self.elem:setY(self.y)
end


function BeatWave:getY()
	return self.y
end


function BeatWave:setY(y)
	self.y = y
	self:applyY()
end


function BeatWave:applyY()
	self.elem:setY(self.y)
end

--
--
-- 
--
--

function BeatWave:update()

	--
	
end

function BeatWave:next()
	--self.elem:setBlendMode(BlendMode.ADD)
	self:moveTo(self.y - 46, BEAT * 0.75, 0)
end




function BeatWave:moveTo(y, duration, delay)
	
	if (duration == nil) then duration = BEAT end
	if (delay == nil) then delay = 0 end
	
	Tweener.tween(self.elem, Tweenables.Y, nil, y, duration, "Quad.easeOut", delay)
	self.y = y

end






--
--
-- 
--
--


function BeatWave:dispose()
	self.elem:dispose()
end




function BeatWave:destroy()
	
	self:dispose()
	
	self.x = nil
	self.y = nil
	self.elem = nil
		
end

