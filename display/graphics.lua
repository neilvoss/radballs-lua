--------------------------------------------------------------------------------
-- Drawing from bitmaps
-- Note for our purposes the bitmap assets used by this have to be declared in 
-- the current level's XML.
--------------------------------------------------------------------------------

IMPORT(Script.VIEWOBJECT)

--------------------------------------------------------------------------------

Graphics = { }

-- precalculated PI precision used by Graphics
Graphics.PI = 3.141592653589793 


-- draw a line between 2 points using a source linesegment bitmap

Graphics.drawLine = function(line, startX, startY, endX, endY, r, g, b, a, thickness, sourceBitmap)
	
	if (r == nil) then r = 0xff end
	if (g == nil) then g = 0xff end
	if (b == nil) then b = 0xff end
	if (a == nil) then a = 0xff end
	
	if (thickness == nil) then thickness = 1 end
	if (thickness > 50) then thickness = 50 end
	
	-- length of each dimension
	
	local dx = startX - endX
	local dy = startY - endY
	
	-- magnitude of vector
	
	local width = math.sqrt(dx * dx + dy * dy)
	if (width < 1) then width = 1 end
	
	-- scale the base line segment bitmap
	
	local scaleX = width / 100
	local scaleY = 1.0
	if (thickness > 1) then scaleY = thickness / 100 end
	if (thickness < 1) then scaleY = thickness / 1 end

	-- angle of vector (get radians, convert radians to angle, offset angle)

	local angle = math.atan2(dx, dy) 
	angle = angle * 180 / Graphics.PI
	angle = 270 - angle
	
	-- apply translation and transformation to a line segment bitmap to 
	-- synthesize the line
	
	if (sourceBitmap == nil) then 
	
		if (thickness <= 1) then 
			sourceBitmap = "#skins/levels/common/graphics/line.png" 
		else
			sourceBitmap = "#skins/levels/common/graphics/line_thick.png"	
		end
	end
	
	if (line == nil) then 
		line = ViewObject(sourceBitmap, 0, 0, 100, thickness + 2)
	end
	
	local anchorY = 2
	if (thickness > 1) then anchorY = 101 end
	
	line:setAnchor(0, anchorY)
	line:setScale(scaleX, scaleY)
	line:setPosition(startX, startY)
	line:setRotation(-angle)
	line:setColor(r, g, b, a)
	
	return line
	
end


-- draw a filled rectangle using a box bitmap (lookup to best resolution)

Graphics.drawRect = function(x, y, width, height, r, g, b, a)

	if (r == nil) then r = 0xff end
	if (g == nil) then g = 0xff end
	if (b == nil) then b = 0xff end
	if (a == nil) then a = 0xff end
	
	local baseSize
	
	if (width >= height) then
		baseSize = width
	else
		baseSize = height
	end
	
	baseSize = math.ceil(baseSize / 100) * 100
	
	if (baseSize > 500) then
		baseSize = 500
	end
	
	local rect = LuaBridgeVisual.load_image("#skins/levels/common/graphics/rect" .. baseSize .. ".png")
	
	local scaleX = width / baseSize
	local scaleY = height / baseSize
	
	LuaBridgeVisual.set_scale(rect, scaleX, scaleY)
	LuaBridgeVisual.set_position(rect, x, y)
	LuaBridgeVisual.set_color(rect, r, g, b, a)
	LuaBridgeVisual.set_blending(rect, true, "GL_ONE", "GL_ONE_MINUS_SRC_ALPHA")
	
	return rect
	
end


-- draw a filled circle using a circle bitmap (lookup to best resolution)

Graphics.drawCircle = function(x, y, diameter, r, g, b, a)
	
	if (r == nil) then r = 0xff end
	if (g == nil) then g = 0xff end
	if (b == nil) then b = 0xff end
	if (a == nil) then a = 0xff end
	
	local baseSize = math.ceil(diameter / 100) * 100
	
	if (baseSize > 500) then
		baseSize = 500
	end
	
	local circ = LuaBridgeVisual.load_image("#skins/levels/common/graphics/circ" .. baseSize .. ".png")
	
	local scale = diameter / baseSize
	
	LuaBridgeVisual.set_scale(circ, scale, scale)
	LuaBridgeVisual.set_position(circ, x, y)
	LuaBridgeVisual.set_color(circ, r, g, b, a)
	LuaBridgeVisual.set_blending(circ, true, "GL_ONE", "GL_ONE_MINUS_SRC_ALPHA")
	
	return circ
	
end


-- render a layer of noise, returning a ViewObject containing the noise texture

Graphics.addNoise = function(amount)
	
	local padding = 8 -- padding for pvr edge artifacts
	
	local noiseUrl = "#skins/levels/common/graphics/noise_01.pvr"
	local noise = ViewObject(noiseUrl, 0, 0, 512, 512)
	
	local tx = padding + Utils.randomInt(512 - 320 - padding * 2)
	local ty = padding + Utils.randomInt(512 - 480 - padding * 2)
	
	noise:setClippingRectangle(tx, ty, 320, 480)
		
	if (amount == nil) then amount = 0.05 end
	if (amount > 1.00) then amount = 1.00 end
	if (amount < 0.00) then amount = 0.00 end
	
	noise:setAlpha(amount)
	
	return noise
	
end


-- subtractively randomize all color channel amounts

Graphics.randomizeColor = function(viewObject, amount)

	if (amount < 0) then return end
	if (amount > 255) then amount = 255 end
	
	local r = viewObject.colorR - Utils.randomInt(amount)
	local g = viewObject.colorG - Utils.randomInt(amount)
	local b = viewObject.colorB - Utils.randomInt(amount)
	local a = viewObject.colorA - Utils.randomInt(amount)
	
	if (r < 0) then r = 0 end
	if (g < 0) then g = 0 end
	if (b < 0) then b = 0 end
	
	viewObject:setColor(r, g, b, a)
	
end


-- subtractively randomize a (random) single color channel amount

Graphics.randomizeColorChannel = function(viewObject, amount)

	if (amount < 0) then return end
	if (amount > 255) then amount = 255 end
	
	local r = viewObject.colorR
	local g = viewObject.colorG
	local b = viewObject.colorB
	local a = viewObject.colorA
	
	local rand = Utils.randomInt(10)
	local value = Utils.randomInt(amount)
	
	if (rand < 3) then r = r - value end
	if (r < 0) then r = 0 end
	
	if (rand >= 3 and rand < 7) then g = g - value end
	if (g < 0) then g = 0 end
	
	if (rand >= 7) then b = b - value end
	if (b < 0) then b = 0 end
	
	viewObject:setColor(r, g, b, a)
	
end


-- subtractively randomize the red color channel amount

Graphics.randomizeColorR = function(viewObject, amount)

	if (amount < 0) then return end
	if (amount > 255) then amount = 255 end
	
	local r = viewObject.colorR
	local g = viewObject.colorG
	local b = viewObject.colorB
	local a = viewObject.colorA
	
	r = r - Utils.randomInt(amount)
	if (r < 0) then r = 0 end
	
	viewObject:setColor(r, g, b, a)
	
end


-- subtractively randomize the green color channel amount

Graphics.randomizeColorG = function(viewObject, amount)

	if (amount < 0) then return end
	if (amount > 255) then amount = 255 end
	
	local r = viewObject.colorR
	local g = viewObject.colorG
	local b = viewObject.colorB
	local a = viewObject.colorA
	
	g = g - Utils.randomInt(amount)
	if (g < 0) then g = 0 end
	
	viewObject:setColor(r, g, b, a)
	
end


-- subtractively randomize the blue color channel amount

Graphics.randomizeColorB = function(viewObject, amount)

	if (amount < 0) then return end
	if (amount > 255) then amount = 255 end
	
	local r = viewObject.colorR
	local g = viewObject.colorG
	local b = viewObject.colorB
	local a = viewObject.colorA
	
	b = b - Utils.randomInt(amount)
	if (b < 0) then b = 0 end
	
	viewObject:setColor(r, g, b, a)
	
end


-- subtractively randomize the amount of all channels uniformly

Graphics.randomizeColorAmount = function(viewObject, amount)

	if (amount < 0) then return end
	if (amount > 255) then amount = 255 end
	
	local r = viewObject.colorR
	local g = viewObject.colorG
	local b = viewObject.colorB
	local a = viewObject.colorA
	
	local value = Utils.randomInt(amount)
	
	r = r - value
	if (r < 0) then r = 0 end
	
	g = g - value
	if (g < 0) then g = 0 end
	
	b = b - value
	if (b < 0) then b = 0 end
	
	viewObject:setColor(r, g, b, a)
	
end




-- take a snapshot of the current lua view and return it as a view object containing the snapshot

Graphics.snapshot = function() 

	local snapshotId = LuaBridgeVisual.snapshot()
	local snapshot = ViewObject(snapshotId, 0, 0, 320, 480)
	snapshot:setX(160)
	snapshot:setY(240)
	
	return snapshot

end


-- clear the GL frame buffer that the lua view is drawing into (deprecated)

Graphics.clear = function() 
	
	-- LuaBridgeVisual.clear_screen()

end



