--------------------------------------------------------------------------------
-- Panel
--------------------------------------------------------------------------------

Panel = class(function(panel, x, y) 
	panel:init(x, y) 
end)


function Panel:init(x, y)
	
	self.alive = true
	
	local bg = ViewObject("#skins/levels/basics/bg/panel.png", 230, 78)
	bg:setClippingRectangle(0, 0, 230, 78)
	bg:setAlpha(0)
	self.bg = bg
	
	self.anchorOffsetX = 100
	self.anchorOffsetY = -20
	
	local anchor = ViewObject("#skins/levels/basics/bg/panel.png", 30, 20)
	anchor:setClippingRectangle(0, 234, 30, 20)
	anchor:setAlpha(0)
	self.anchor = anchor
	
	local text = ViewObject("#skins/levels/basics/bg/panel_text.png", 210, 50)
	text:setClippingRectangle(0, 0, 210, 50)
	text:setAlpha(0)
	self.text = text
	
	self.x = x
	self.y = y
	self:applyPosition()
		
end


function Panel:setState(index)

	-- @todo: elseif

	if (index == 0) then
	
		self.bg:setClippingRectangle(0, 0, 230, 78)
		
		self.text:setClippingRectangle(0, 0, 210, 50)
		
		self.anchor:setClippingRectangle(0, 234, 30, 20)
		self.anchor:setColor(244, 130, 105, 255)
		self.anchorOffsetX = 100
		self.anchorOffsetY = -20
		self.anchor:setPosition(self.x + self.anchorOffsetX, self.y + self.anchorOffsetY)
		
		self:show()
		
		Tweener.tween(self.bg, Tweenables.Y, self.bg:getY() + 46, nil, BEAT, "Quad.easeOut", 0)
		Tweener.tween(self.anchor, Tweenables.Y, self.anchor:getY() + 46, nil, BEAT, "Quad.easeOut", 0)
		Tweener.tween(self.text, Tweenables.Y, self.text:getY() + 46, nil, BEAT, "Quad.easeOut", 0)
		
		
	end
	
	if (index == 1) then
		self.text:setClippingRectangle(0, 50, 210, 50)
		self:nextText()
	end
	
	if (index == 2) then
		self.text:setClippingRectangle(0, 100, 210, 50)
		self:nextText()
	end
	
	if (index == 3) then
		self.text:setClippingRectangle(0, 150, 210, 50)
		self:nextText()
	end
	
	if (index == 4) then
		self.bg:setClippingRectangle(0, 78, 230, 78)
		self.text:setClippingRectangle(0, 200, 210, 50)
		self.anchor:setColor(176, 141, 193, 255)
		self.anchor:setRotation(180)
		self.anchorOffsetX = 130
		self.anchorOffsetY = 98
		self.anchor:setPosition(self.x + self.anchorOffsetX, self.y + self.anchorOffsetY)
		self:show()
	end
	
	if (index == 5) then
		self.text:setClippingRectangle(0, 250, 210, 50)
		self:nextText()
	end
	
	if (index == 6) then
		self.text:setClippingRectangle(0, 300, 210, 50)
		self:nextText()
	end
	
	if (index == 7) then
		self.text:setClippingRectangle(0, 350, 210, 50)
		self:nextText()
	end
	
	if (index == 8) then
		self.bg:setClippingRectangle(0, 156, 230, 78)
		self.text:setClippingRectangle(0, 400, 210, 50)
		self.self.anchor:setAlpha(0)
		self:show(true)
	end
	
end


function Panel:show(hideAnchor)
	--self.bg:setAlpha(1)
	--self.anchor:setAlpha(1)
	--self.text:setAlpha(1)
	Tweener.tween(self.bg, Tweenables.ALPHA, 0.0, 1.0, BEAT * 0.5, "Quad.easeOut", 0)
	Tweener.tween(self.text, Tweenables.ALPHA, 0.0, 1.0, BEAT * 0.5, "Quad.easeOut", BEAT * 0.5)
	if (hideAnchor == nil or hideAnchor == false) then Tweener.tween(self.anchor, Tweenables.ALPHA, 0.0, 1.0, BEAT * 0.5, "Quad.easeOut", 0) end
end


function Panel:nextText()
	Tweener.tween(self.text, Tweenables.ALPHA, 0.0, 1.0, BEAT * 0.5, "Quad.easeOut", 0)
end


function Panel:hide()
	self.bg:setAlpha(0)
	self.anchor:setAlpha(0)
	self.text:setAlpha(0)
end


function Panel:moveTo(x, y)
	self:setPosition(x, y) -- @todo tween
end

--
--
-- Position property access/modifiers
--
--

function Panel:getPosition(asPoint)
	
	if (asPoint == nil or asPoint == false) then 
		return self.x, self.y 
	end
	
	return Point(self.x, self.y)
end


function Panel:setPosition(x, y)

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


function Panel:applyPosition()
	self.bg:setPosition(self.x, self.y)
	self.text:setPosition(self.x + 10, self.y + 14)
	self.anchor:setPosition(self.x + self.anchorOffsetX, self.y + self.anchorOffsetY)
end


function Panel:getX()
	return self.x
end


function Panel:setX(x)
	self.x = x
	self:applyX()
end


function Panel:applyX()
	self.bg:setX(self.x)
	self.text:setX(self.x + 10)
	self.anchor:setX(self.x + self.anchorOffsetX)
end


function Panel:getY()
	return self.y
end


function Panel:setY(y)
	self.y = y
	self:applyY()
end


function Panel:applyY()
	self.bg:setY(self.y)
	self.text:setY(self.y + 14)
	self.anchor:setY(self.y + self.anchorOffsetY)
end


--
--
-- 
--
--


function Panel:dispose()

	self.bg:dispose()
	self.text:dispose()
	self.anchor:dispose()
	
end


function Panel:destroy()
	
	if (self.alive == false) then return end
	self.alive = false
	
	self:dispose()
	
	self.bg = nil
	self.text = nil
	self.anchor = nil
		
end
