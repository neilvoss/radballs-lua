--------------------------------------------------------------------------------
-- Default transitions
--------------------------------------------------------------------------------

IMPORT(Script.TWEEN)
IMPORT(Script.TWEENABLES)
IMPORT(Script.VIEWOBJECT)

--------------------------------------------------------------------------------

Transition = { }

Transition.fadeIn = function(view, duration, ease, delay)
	
	if (view == nil) then return end
	
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
		
	Tweener.tween(view, Tweenables.ALPHA, 0.0, nil, duration, ease, delay)
	
end


Transition.fadeOut = function(view, duration, ease, delay)
	
	if (view == nil) then return end
	
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
		
	Tweener.tween(view, Tweenables.ALPHA, nil, 0.0, duration, ease, delay)
	
end


Transition.scaleIn = function(view, startScale, duration, ease, delay)
	
	if (view == nil) then return end
	
	if (startScale == nil) then startScale = 0.0 end
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startX = view:getX() + (view:getWidth() * 0.5) * (1 - startScale)
	local startY = view:getY() + (view:getHeight() * 0.5) * (1 - startScale)
		
	Tweener.tween(view, Tweenables.X, startX, nil, duration, ease, delay)
	Tweener.tween(view, Tweenables.Y, startY, nil, duration, ease, delay)
	Tweener.tween(view, Tweenables.SCALE_X, startScale, nil, duration, ease, delay)
	Tweener.tween(view, Tweenables.SCALE_Y, startScale, nil, duration, ease, delay)
	
end


Transition.scaleOut = function(view, endScale, duration, ease, delay)
	
	if (view == nil) then return end
	
	if (endScale == nil) then endScale = 0.0 end
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local endX = view:getX() + (view:getWidth() * 0.5) * (1 - endScale)
	local endY = view:getY() + (view:getHeight() * 0.5) * (1 - endScale)
		
	Tweener.tween(view, Tweenables.X, nil, endX, duration, ease, delay)
	Tweener.tween(view, Tweenables.Y, nil, endY, duration, ease, delay)
	Tweener.tween(view, Tweenables, nil, endScale, duration, ease, delay)
	Tweener.tween(view, Tweenables, nil, endScale, duration, ease, delay)
	
end


Transition.slideInLeft = function(view, duration, ease, delay)

	if (view == nil) then return end
	
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startX = -view:getWidth()
	
	Tweener.tween(view, Tweenables.X, startX, nil, duration, ease, delay)
	
end


Transition.slideInRight = function(view, duration, ease, delay)

	if (view == nil) then return end
	
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startX = STAGE_WIDTH
	
	Tweener.tween(view, Tweenables.X, startX, nil, duration, ease, delay)
	
end


Transition.slideInTop = function(view, duration, ease, delay)

	if (view == nil) then return end
	
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startY = STAGE_HEIGHT
	
	Tweener.tween(view, Tweenables.Y, startY, nil, duration, ease, delay)
	
end


Transition.slideInBottom = function(view, duration, ease, delay)

	if (view == nil) then return end
	
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startY = -view:getHeight()
	
	Tweener.tween(view, Tweenables.Y, startY, nil, duration, ease, delay)
	
end


Transition.slideInRandom = function(view, maxDistance, duration, ease, delay)

	if (view == nil) then return end
	
	if (maxDistance == nil) then maxDistance = 320 end
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startX = view:getX() - maxDistance + math.random() * (maxDistance * 2)
	local startY = view:getY() - maxDistance + math.random() * (maxDistance * 2)
	
	Tweener.tween(view, Tweenables, startX, nil, duration, ease, delay)
	Tweener.tween(view, Tweenables.Y, startY, nil, duration, ease, delay)
	
end


Transition.slideInRandomX = function(view, maxDistance, duration, ease, delay)

	if (view == nil) then return end
	
	if (maxDistance == nil) then maxDistance = 320 end
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startX = view:getX() - maxDistance + math.random() * (maxDistance * 2)
	
	Tweener.tween(view, Tweenables.X, startX, nil, duration, ease, delay)
	
end


Transition.slideInRandomY = function(view, maxDistance, duration, ease, delay)

	if (view == nil) then return end
	
	if (maxDistance == nil) then maxDistance = 320 end
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	local startY = view:getY() - maxDistance + math.random() * (maxDistance * 2)
	
	Tweener.tween(view, Tweenables.Y, startY, nil, duration, ease, delay)
	
end


Transition.rotateIn = function(view, rotation, duration, ease, delay)

	if (view == nil) then return end
	
	if (rotation == nil) then rotation = math.random() * 360 end
	if (duration == nil) then duration = 1 end
	if (ease == nil) then ease = "Quad.easeOut" end
	if (delay == nil) then delay = 0 end
	
	Tweener.tween(view, Tweenables.ROTATION, rotation, nil, duration, ease, delay)
end



	
	