--------------------------------------------------------------------------------
-- Tweener (Factory/Manager)
--------------------------------------------------------------------------------

IMPORT(Script.TWEENABLES)
IMPORT(Script.VIEWOBJECT)

--------------------------------------------------------------------------------

Tweener = { }


-- TWEENER AS SINGLE-TWEEN FACTORY


Tweener.tween = function(viewObject, prop, startValue, endValue, duration, easeFunction, delay)
	
	
	-- tween x
	
	if (prop == Tweenables.X) then
		
		if (startValue == nil) then startValue = LuaBridgeVisual.get_x(viewObject.link) end
		if (endValue == nil) then endValue = LuaBridgeVisual.get_x(viewObject.link) end
		if (startValue == endValue) then return end
		
		viewObject:setX(startValue)
		
		LuaBridgeVisualIntroOutro.tween_x(viewObject.link, endValue, duration, easeFunction, delay)
		
		viewObject.x = endValue
	
	
	-- tween y
	
	elseif (prop == Tweenables.Y) then
	
		if (startValue == nil) then startValue = LuaBridgeVisual.get_y(viewObject.link) end
		if (endValue == nil) then endValue = LuaBridgeVisual.get_y(viewObject.link) end
		if (startValue == endValue) then return end
		
		viewObject:setY(startValue)
		
		LuaBridgeVisualIntroOutro.tween_y(viewObject.link, endValue, duration, easeFunction, delay)
		
		viewObject.y = endValue
	
	
	-- tween width
	
	elseif (prop == Tweenables.WIDTH) then
	
		local endScale

		if (startValue == nil) then 
			startValue = viewObject.registeredWidth * LuaBridgeVisual.get_scale_x(viewObject.link) 
		end
		
		if (endValue == nil) then 
			endScale = LuaBridgeVisual.get_scale_x(viewObject.link)
			endValue = viewObject.registeredWidth * endScale
		else
			endScale = endValue / viewObject.registeredWidth
		end
		
		if (startValue == endValue) then return end
		
		viewObject:setWidth(startValue)
		
		LuaBridgeVisualIntroOutro.tween_scale_x(viewObject.link, endScale, duration, easeFunction, delay)
		
		viewObject.width = endValue
		viewObject.scaleX = endScale
		
		
	-- tween height
	
	elseif (prop == Tweenables.HEIGHT) then
	
		local endScale

		if (startValue == nil) then 
			startValue = viewObject.registeredHeight * LuaBridgeVisual.get_scale_y(viewObject.link)
		end
		
		if (endValue == nil) then 
			endScale = LuaBridgeVisual.get_scale_y(viewObject.link)
			endValue = viewObject.registeredHeight * endScale
		else
			endScale = endValue / viewObject.registeredHeight
		end
		
		if (startValue == endValue) then return end
		
		viewObject:setHeight(startValue)
		
		LuaBridgeVisualIntroOutro.tween_scale_y(viewObject.link, endScale, duration, easeFunction, delay)
		
		viewObject.height = endValue
		viewObject.scaleY = endScale
	
	
	-- tween scale (uniform)
	
	elseif (prop == Tweenables.SCALE) then
		
		if (startValue == nil) then startValue = LuaBridgeVisual.get_scale_x(viewObject.link) end
		if (endValue == nil) then endValue = LuaBridgeVisual.get_scale_x(viewObject.link) end
		if (startValue == endValue) then return end
		
		viewObject:setScaleX(startValue)
		viewObject:setScaleY(startValue)
		
		LuaBridgeVisualIntroOutro.tween_scale_x(viewObject.link, endValue, duration, easeFunction, delay)
		LuaBridgeVisualIntroOutro.tween_scale_y(viewObject.link, endValue, duration, easeFunction, delay)
		
		viewObject.scaleX = endValue
		viewObject.scaleY = endValue
		
		viewObject.width = viewObject.registeredWidth * endValue
		viewObject.height = viewObject.registeredHeight * endValue
		
	
	-- tween scale x
	
	elseif (prop == Tweenables.SCALE_X) then
		
		if (startValue == nil) then startValue = LuaBridgeVisual.get_scale_x(viewObject.link) end
		if (endValue == nil) then endValue = LuaBridgeVisual.get_scale_x(viewObject.link) end
		if (startValue == endValue) then return end
		
		viewObject:setScaleX(startValue)
		
		LuaBridgeVisualIntroOutro.tween_scale_x(viewObject.link, endValue, duration, easeFunction, delay)
		
		viewObject.scaleX = endValue
		viewObject.width = viewObject.registeredWidth * endValue
	
	
	-- tween scale y
	
	elseif (prop == Tweenables.SCALE_Y) then
		
		if (startValue == nil) then startValue = LuaBridgeVisual.get_scale_y(viewObject.link) end
		if (endValue == nil) then endValue = LuaBridgeVisual.get_scale_y(viewObject.link) end
		if (startValue == endValue) then return end
		
		viewObject:setScaleY(startValue)
		
		LuaBridgeVisualIntroOutro.tween_scale_y(viewObject.link, endValue, duration, easeFunction, delay)
		
		viewObject.scaleY = endValue
		viewObject.height = viewObject.registeredHeight * endValue
	
	
	-- tween rotation
	
	elseif (prop == Tweenables.ROTATION) then
	
		if (startValue == nil) then startValue = (LuaBridgeVisual.get_angle(viewObject.link)) end
		if (endValue == nil) then endValue = (LuaBridgeVisual.get_angle(viewObject.link)) end
		if (startValue == endValue) then return end
		
		viewObject:setRotation(startValue)
		
		LuaBridgeVisualIntroOutro.tween_rotation(viewObject.link, endValue, duration, easeFunction, delay)
		
		viewObject.rotation = endValue
	
	
	-- tween color
	-- start and end values should be passed as tables in the format: {r,g,b,a}
	
	elseif (prop == Tweenables.COLOR) then
		
		local startR
		local startG
		local startB
		local startA
		local endR
		local endG
		local endB
		local endA
		
		local currentR, currentG, currentB, currentA = viewObject:getColor()
		
		if (startValue == nil) then
			startR = currentR
			startG = currentG
			startB = currentB
			startA = currentA
		else
			startR = startValue[0]
			startG = startValue[1]
			startB = startValue[2]
			startA = startValue[3]
		end
		
		if (endValue == nil) then
			endR = currentR
			endG = currentG
			endB = currentB
			endA = currentA
		else
			endR = endValue[0]
			endG = endValue[1]
			endB = endValue[2]
			endA = endValue[3]
		end
		
		if (startR == endR and startG == endG and startB == endB and startA == endA) then return end
		
		endR = endR * math.pow(2, 24)
		endG = endG * math.pow(2, 16)
		endB = endB * math.pow(2, 8)
		endA = endA
		
		local endColor = endR + endG + endB + endA
		
		viewObject:setColor(startR, startG, startB, startA)
		
		LuaBridgeVisualIntroOutro.tween_color(viewObject.link, endColor, duration, easeFunction, delay)
		
		viewObject.colorR = endR
		viewObject.colorG = endG
		viewObject.colorB = endB
		viewObject.colorA = endA
		
		
	-- tween alpha
	
	elseif (prop == Tweenables.ALPHA) then
	
		if (startValue == nil) then startValue = viewObject:getAlpha() end
		if (endValue == nil) then endValue = viewObject:getAlpha() end
		if (startValue == endValue) then return end
		
		local endR, endG, endB, endA = viewObject:getColor()
		
		endR = endR * math.pow(2, 24)
		endG = endG * math.pow(2, 16)
		endB = endB * math.pow(2, 8)
		endA = endValue * 255
		
		local endColor = endR + endG + endB + endA
		
		viewObject:setAlpha(startValue)
		
		LuaBridgeVisualIntroOutro.tween_color(viewObject.link, endColor, duration, easeFunction, delay)
		
	end
	
end

