--------------------------------------------------------------------------------
-- ViewObject

-- Object containing the state of a view object - a layer comprised of bitmap 
-- data being rendered onto the Lua display stack.
 
-- Property access is not strictly controlled. Properties can either be 
-- accessed by their related getter/setter methods, or directly. However, when 
-- properties are set directly, they are not committed until their related 
-- apply method is called, which in turn applies the properties to the render. 

--------------------------------------------------------------------------------

IMPORT(Script.CLASS)
IMPORT(Script.BLENDMODE)

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

ViewObject = class(function(viewObj, link, x, y, width, height) 
	viewObj:init(link, x, y, width, height) 
end)

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:init(link, x, y, width, height)
	
	-- init props not set directly here...

	self.link = nil
	self.blendMode = nil
	
	-- set (create) the link to a view (bind the view to the view object)
	
	self:setLink(link)
	
	-- set the init properties of the view
	
	if (x == nil) then x = 0 end
	if (y == nil) then y = 0 end
	if (width == nil) then width = 320 end
	if (height == nil) then height = 480 end
	
	self.x = x
	self.y = y
	self:applyPosition()
	
	self.width = width
	self.height = height
	
	self.registeredWidth = width
	self.registeredHeight = height
	
	self.scaleX = 1.0
	self.scaleY = 1.0
	
	self.rotation = 0
	
	self.colorR = 0xff
	self.colorG = 0xff
	self.colorB = 0xff
	self.colorA = 0xff
	
	self:setBlendMode(BlendMode.NORMAL)

end

--------------------------------------------------------------------------------------
-- measure the link and apply its properties as the current state.
-- note: doing so normalizes 'alpha' to 1.0
--------------------------------------------------------------------------------------

function ViewObject:measure()
	self:measurePosition()
	self:measureSize()
	self:measureRotation()
	self:measureColor()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:isDirty()
	local dirty = false
	if (self:isPositionDirty() or self:isSizeDirty() or self:isRotationDirty() or self:isColorDirty()) then dirty = true end
	return dirty
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:validate()
	if (self:isDirty()) then self:measure() end
end

--
--
-- Position property access/modifiers
--
--

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setPosition(x, y)

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

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyPosition()
	LuaBridgeVisual.set_position(self.link, self.x, self.y)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getX()
	return self.x
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setX(x)
	self.x = x
	self:applyX()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyX()
	LuaBridgeVisual.set_x(self.link, self.x)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getY()
	return self.y
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setY(y)
	self.y = y
	self:applyY()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyY()
	LuaBridgeVisual.set_y(self.link, self.y)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:measurePosition()
	local position = LuaBridgeVisual.get_position(self.link)
	self.x = position[0]
	self.y = position[1]
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:isPositionDirty()
	local position = LuaBridgeVisual.get_position(self.link)
	local dirty = (self.x ~= position[0] or self.y ~= position[1])
	return dirty
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:validatePosition()
	if (self:isPositionDirty()) then self:measurePosition() end
end


--
--
-- Size property access/modifiers
--
--

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getSize()
	return self.width, self.height
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setSize(width, height)

	if (width == nil) then 
		width = self.width
	elseif (type(width) == 'table') then
		local args = width
		width = args[0]
		height = args[1]
	end

	if (height == nil) then height = width end
	
	self.width = width
	self.height = height
	self:applySize()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applySize()
	self.scaleX = self.width / self.registeredWidth
	self.scaleY = self.height / self.registeredHeight
	LuaBridgeVisual.set_scale(self.link, self.scaleX, self.scaleY)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getWidth()
	return self.width
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setWidth(width)
	self.width = width
	self:applyWidth()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyWidth()
	self.scaleX = self.width / self.registeredWidth
	LuaBridgeVisual.set_scale_x(self.link, self.scaleX)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getHeight()
	return self.height
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setHeight(height)
	self.height = height
	self:applyHeight()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyHeight()
	self.scaleY = self.height / self.registeredHeight
	LuaBridgeVisual.set_scale_y(self.link, self.scaleY)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getScale()
	return self.scaleX, self.scaleY
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setScale(scaleX, scaleY)
	
	if (scaleX == nil) then 
		scaleX = self.scaleX
	elseif (type(scaleX) == 'table') then
		local args = scaleX
		scaleX = args[0]
		scaleY = args[1]
	end
	
	if (scaleY == nil) then scaleY = scaleX end
	
	self.scaleX = scaleX
	self.scaleY = scaleY
	self:applyScale()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyScale()
	self.width = self.registeredWidth * self.scaleX
	self.height = self.registeredHeight * self.scaleY
	LuaBridgeVisual.set_scale(self.link, self.scaleX, self.scaleY)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getScaleX()
	return self.scaleX
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setScaleX(scaleX)
	self.scaleX = scaleX
	self:applyScaleX()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyScaleX()
	self.width = self.registeredWidth * self.scaleX
	LuaBridgeVisual.set_scale_x(self.link, self.scaleX)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getScaleY()
	return self.scaleY
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setScaleY(scaleY)
	self.scaleY = scaleY
	self:applyScaleY()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyScaleY()
	self.height = self.registeredHeight * self.scaleY
	LuaBridgeVisual.set_scale_y(self.link, self.scaleY)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:measureSize()
	local scale = LuaBridgeVisual.get_scale(self.link)
	self.scaleX = scale[0]
	self.scaleY = scale[1]
	self.width = self.registeredWidth * scale[0]
	self.height = self.registeredHeight * scale[1]
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:isSizeDirty()
	local scale = LuaBridgeVisual.get_scale(self.link)
	local dirty = (self.scaleX ~= scale[0] or self.scaleY ~= scale[1] or self.width ~= self.registeredWidth * scale[0] or self.height ~= self.scaleY * scale[1])
	return dirty
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:validateSize()
	if (self:isSizeDirty()) then self:measureSize() end
end


--
--
-- Rotation property modifiers
--
--

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getRotation()
	return self.rotation
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setRotation(rotation)	
	self.rotation = rotation
	self:applyRotation()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyRotation()
	LuaBridgeVisual.set_angle(self.link, -self.rotation) -- << invert GL rotation back to clockwise
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:measureRotation()
	self.rotation = -(LuaBridgeVisual.get_angle(self.link))
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:isRotationDirty()
	local rotation = -(LuaBridgeVisual.get_angle(self.link))
	local dirty = (self.rotation ~= rotation) 
	return dirty
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:validateRotation()
	if (self:isRotationDirty()) then self:measureRotation() end
end

--
--
-- Texture property modifiers
--
--

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getColor()
	return self.colorR, self.colorG, self.colorB, self.colorA
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setColor(r, g, b, a)
	
	if (type(r) == 'table') then
		local args = r
		r = args[0]
		g = args[1]
		b = args[2]
		a = args[3]
	end
	
	if (r ~= nil) then self.colorR = r end
	if (g ~= nil) then self.colorG = g end
	if (b ~= nil) then self.colorB = b end
	if (a ~= nil) then self.colorA = a end
	
	self:applyColor()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:applyColor()
	LuaBridgeVisual.set_color(self.link, self.colorR, self.colorG, self.colorB, self.colorA)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:getAlpha()
	return self.colorA / 255
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:setAlpha(alpha)
	self.colorA = math.floor(255 * alpha)
	self:applyColor()
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:measureColor()
	local color = LuaBridgeVisual.get_color(self.link)
	self.colorR = color[0]
	self.colorG = color[1]
	self.colorB = color[2]
	self.colorA = color[3]
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:isColorDirty()
	local color = LuaBridgeVisual.get_color(self.link)
	local dirty = (self.colorR ~= color[0] or self.colorG ~= color[1] or self.colorB ~= color[2] or self.colorA ~= color[3])
	return dirty
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:validateColor()
	if (self:isColorDirty()) then self:measureColor() end
end

--------------------------------------------------------------------------------------
-- Blend mode does not have a validation scheme, it is applied directly
--------------------------------------------------------------------------------------

function ViewObject:getBlendMode()
	return self.blendMode
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:setBlendMode(blendMode)
	self.blendMode = blendMode
	self:applyBlendMode()
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:setBlendModeCustom(blendSource, blendDest)
	self.blendMode = BlendMode.CUSTOM
	LuaBridgeVisual.set_blending(self.link, true, blendSource, blendDest)
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:applyBlendMode()
	local blendSource, blendDest = BlendMode.getGLBlendFunc(self.blendMode)
	LuaBridgeVisual.set_blending(self.link, true, blendSource, blendDest)
end

--
--
-- Translation methods
--
--

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:translatePosition(x, y) 

	if (x == nil) then x = 0 end
	x = self.x + x
	
	if (y == nil) then y = 0 end
	y = self.y + y
	
	self:setPosition(x, y)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:translateSize(width, height)

	if (width == nil) then width = 0 end
	width = self.width + width
	
	if (height == nil) then height = 0 end
	height = self.height + height
	
	self:setSize(width, height)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:translateScale(scaleX, scaleY)

	if (scaleX == nil) then scaleX = 0 end
	scaleX = self.scaleX + scaleX
	
	if (height == nil) then height = 0 end
	scaleY = self.height + scaleY
	
	self:setScale(scaleX, scaleY)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:translateRotation(rotation)

	if (rotation == nil) then return end
	self:setRotation(self.rotation + rotation)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:translateAlpha(alpha)

	if (alpha == nil) then return end
	self:setAlpha(self.colorA + alpha)
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObject:translateColor(r, g, b, a)

	if (r == nil) then r = self.colorR end
	if (g == nil) then g = self.colorG end
	if (b == nil) then b = self.colorB end
	if (a == nil) then a = self.colorA end
	
	self:setColor(r, g, b, a)
end

--
--
-- Visibility modifiers
--
--

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:show()
	self:setScale(self.scaleX, self.scaleY)
	self:setPosition(self.x, self.y)
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------
function ViewObject:hide()
	LuaBridgeVisual.set_scale_x(self.link, 0)
	LuaBridgeVisual.set_scale_y(self.link, 0)
	LuaBridgeVisual.set_x(self.link, -1)
	LuaBridgeVisual.set_y(self.link, -1)
end

--
--
-- Misc
--
--

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:getLink()
	return self.link
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:setLink(link)
	
	--PRINT("ViewObject:setLink " .. link)
	
	if (self:isLinked()) then 
		
		self:removeLink()
		 
		if (link == nil) then
			return
		end
	end
	
	if (type(link) == 'string') then
		self.link = LuaBridgeVisual.load_image(link)
	else 
		self.link = link
	end
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:removeLink()
	LuaBridgeVisual.remove_image(self.link)
	self.link = nil
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:isLinked()
	if (self.link ~= nil) then return true end
	return false
end

--
--
-- @TODO refactor these additions into getter/setter and default params
--
--

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:setClippingRectangle(x, y, w, h)

		if (x == nil) then x = 0 end
		if (y == nil) then y = 0 end
		if (w == nil) then w = self.width end
		if (h == nil) then h = self.height end
		
		LuaBridgeVisual.set_source_rectangle(self.link, x, y, w, h)
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function ViewObject:setAnchor(x, y) 

	if (x == nil) then x = 0 end
	if (y == nil) then y = self.height end
	LuaBridgeVisual.set_anchor(self.link, x, y)

end

--------------------------------------------------------------------------------------
-- Dispose of the view object's binding but keep its state. Can be useful
-- to clear the view but retain its old state/appearance
--------------------------------------------------------------------------------------

function ViewObject:dispose()
	if (self:isLinked()) then self:removeLink() end
end

--------------------------------------------------------------------------------------
-- Fully destroy the view object - remove its view binding and nil its props
--------------------------------------------------------------------------------------

function ViewObject:destroy()
	
	self:dispose()
	
	-- @TODO procedurally clear this table...
	
	self.x = nil
	self.y = nil
	self.width = nil
	self.height = nil
	self.registeredWidth = nil
	self.registeredHeight = nil
	self.scaleX = nil
	self.scaleY = nil
	self.rotation = nil
	self.colorR = nil
	self.colorG = nil
	self.colorB = nil
	self.colorA = nil
	self.blendMode = nil
	
end


