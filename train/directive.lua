--------------------------------------------------------------------------------
-- Directive
--------------------------------------------------------------------------------

Directive = class(function(directive, index) 
	directive:init(index) 
end)


function Directive:init(index)
	
	self.alive = true
	
	if (index == nil) then index = 0 end
	if (index < 0) then index = 0 end
	if (index > 7) then index = 7 end
	
	local x = 23
	local y = 480 - 114
	local rx = 0
	local ry = 0
	local w = 0
	local h = 0
	local char
	
	self.chars = {}
	
	-- b
	
	rx = 0
	x = x + 0
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 25, 35)
	char:setClippingRectangle(rx, 0, 25, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- a
	
	rx = rx + 25
	x = x + 25
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 25, 35)
	char:setClippingRectangle(rx, 0, 25, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- s
	
	rx = rx + 25
	x = x + 25
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 16, 35)
	char:setClippingRectangle(rx, 0, 16, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- i
	
	rx = rx + 16
	x = x + 16
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 7, 35)
	char:setClippingRectangle(rx, 0, 7, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- c
	
	rx = rx + 7
	x = x + 7
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 18, 35)
	char:setClippingRectangle(rx, 0, 18, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- s
	
	rx = rx + 18
	x = x + 18
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 17, 35)
	char:setClippingRectangle(rx, 0, 17, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- #
	
	rx = 150 + 25 * index
	x = x + 26
	if (index == 0) then w = 12 else w = 25 end
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, w, 35)
	char:setClippingRectangle(rx, 0, w, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	-- :
	
	rx = 125
	x = x + w + 2
	char = ViewObject("#skins/levels/basics/bg/start_title.png", 0, 0, 10, 35)
	char:setClippingRectangle(rx, 0, 10, 35)
	char:setPosition(x, y)
	table.insert(self.chars, char)
	
	--
	
	for i,char in ipairs(self.chars) do
		char:setAlpha(0)
	end
	
	-- subtitle
	
	if (index == 0) then
		w = 274
		h = 18
	elseif (index == 1) then
		w = 244
		h = 19
	elseif (index == 2) then
		w = 213
		h = 18
	elseif (index == 3) then
		w = 266
		h = 40
	elseif (index == 4) then
		w = 184
		h = 14
	else
		w = 191
		h = 14
	end
	
	self.subtitle = ViewObject("#skins/levels/basics/bg/directive" .. (index+1) .. ".png", 0, 0, w, h)
	self.subtitle:setPosition(23, y - 28)
	self.subtitle:setAlpha(0)
	
end

function Directive:transitionOn()

	local delay = BEAT * 0.25
	
	for i,char in ipairs(self.chars) do
		Tweener.tween(char, Tweenables.ALPHA, 0.0, 1.0, BEAT * 0.5, "Quad.easeOut", i * delay)
		Tweener.tween(char, Tweenables.X, 320, nil, BEAT * 0.75, "Quad.easeOut", i * delay)
	end
	
	Tweener.tween(self.subtitle, Tweenables.ALPHA, 0.0, 1.0, BEAT * 2, "Quad.easeOut", BEAT * 2)

end


function Directive:transitionOff()

end



--
--
-- 
--
--


function Directive:dispose()
	for i,char in ipairs(self.chars) do
		char:dispose()
	end
	
	self.subtitle:dispose()
	
end


function Directive:destroy()
	
	if (self.alive == false) then return end
	self.alive = false
	
	self:dispose()
	
	self.chars = nil
	self.subtitle = nil
		
end
