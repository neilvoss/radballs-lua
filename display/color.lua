--------------------------------------------------------------------------------
-- Color
--------------------------------------------------------------------------------

IMPORT(Script.CLASS)

--------------------------------------------------------------------------------

Color = class(function(color, r, g, b) 
	color:set(r, g, b)
end)


-- get the r g b of the color

function Color:get() 
	return self.r, self.g, self.b
end


-- set the r g b of the color

function Color:set(r, g, b)
	
	if type(r) == 'table' and getmetatable(r) == Color then 
		local t = r 
		r = t.r	
		g = t.g
		b = t.b
	end
	
	self.r = Color.fitValue(r)
	self.g = Color.fitValue(g)
	self.b = Color.fitValue(b)
	
end

--
-- Overrides
--

-- override addition
-- add a color or an amount to the color

function Color.__add(color, value)

	local rd = 0
	local gd = 0
	local bg = 0
	
	if type(value) == 'table' and getmetatable(value) == Color then
		rd = value.r
		gd = value.g
		bd = value.b
	else 
		rd = value
		gd = value
		bd = value
	end
	
	local r = Color.fitValue(color.r + rd)
	local g = Color.fitValue(color.g + gd)
	local b = Color.fitValue(color.b + bd)
	
	return Color(r, g, b)
end


-- override addition
-- subtract a color or an amount from the color

function Color.__sub(color, value)

	local rd = 0
	local gd = 0
	local bg = 0
	
	if type(value) == 'table' and getmetatable(value) == Color then
		rd = value.r
		gd = value.g
		bd = value.b
	else 
		rd = value
		gd = value
		bd = value
	end
	
	local r = Color.fitValue(color.r - rd)
	local g = Color.fitValue(color.g - gd)
	local b = Color.fitValue(color.b - bd)
	
	return Color(r, g, b)
end


-- override multiplication

function Color.__mul(color, value)

	local rd = 0
	local gd = 0
	local bg = 0
	
	if type(value) == 'table' and getmetatable(value) == Color then
		rd = value.r
		gd = value.g
		bd = value.b
	else 
		rd = value
		gd = value
		bd = value
	end
	
	local r = Color.fitValue(color.r * rd)
	local g = Color.fitValue(color.g * gd)
	local b = Color.fitValue(color.b * bd)
	
	return Color(r, g, b)
end


-- override division to return the distance between 2 colors (a bit odd but useful)

function Color.__div(color1, color2)
	return Color.distance(color1, color2)
end


-- override unary minus

function Color.__unm(color) 
	return Color(255 - color.r, 255 - color.g, 255 - color.b)
end


-- override equality

function Color.__eq(color1, color2)
	return (color1.r == color2.r and color1.g == color2.g and color1.b == color2.b)
end


-- override concat '..' to average with a value or color

function Color.__concat(color, value)

	local rd = 0
	local gd = 0
	local bg = 0
	
	if type(value) == 'table' and getmetatable(value) == Color then
		rd = value.r
		gd = value.g
		bd = value.b
	else 
		rd = value
		gd = value
		bd = value
	end
	
	local r = Color.fitValue((color.r + rd) * 0.5)
	local g = Color.fitValue((color.g + gd) * 0.5)
	local b = Color.fitValue((color.b + bd) * 0.5)
	
	return Color(r, g, b)
end


-- override exp '^' with brightness factor

function Color.__pow(color, power)

	local r = Color.fitValue((color.r + (255 * power)) / power)
	local g = Color.fitValue((color.g + (255 * power)) / power)
	local b = Color.fitValue((color.b + (255 * power)) / power)
	
	return Color(r, g, b)
	
end


-- override tostring

function Color.__tostring(color) 
	return string.format('Color(%i, %i, %i)', color.r, color.g, color.b)
end




--
-- Methods
--

function Color:normalize(ceiling)

	if (ceiling == nil) then ceiling = 1.0 end
	
	local r = (self.r / 255) * ceiling
	local g = (self.g / 255) * ceiling
	local b = (self.b / 255) * ceiling
	
	return r, g, b
end


function Color:getHsv()
	return Color.rgbToHsv(self.r, self.g, self.b)
end


function Color:setHsv(h, s, v)
	self.r, self.g, self.b = Color.hsvToRgb(h, s, v)
end


function Color:getHsl()
	return Color.rgbToHsl(self.r, self.g, self.b)
end


function Color:setHsl(h, s, l)
	self.r, self.g, self.b = Color.hslToRgb(h, s, l)
end


function Color:getLab()
	return Color.rgbToLab(self.r, self.g, self.b)
end


function Color:setLab(l, a, b)
	self.r, self.g, self.b = Color.labToRgb(l, a, b)
end


function Color:getDistance(fromColor)
	return Color.distance(self, fromColor)
end


-- copy

function Color:copy()
	return Color(self.r, self.g, self.b)
end




--
-- Utilities
-- 


-- distance (simple CIE76 method, not great but was easy to implement...)

function Color.distance(color1, color2) 

	local l1,a1,b1 = Color.rgbToLab(color1.r, color1.g, color1.b)
	local l2,a2,b2 = Color.rgbToLab(color2.r, color2.g, color2.b)
	
	local d = math.sqrt(math.pow(l2 - l1, 2) + math.pow(a2 - a1, 2) + math.pow(b2 - b1, 2))
	
	return d
end


-- average

function Color.average()

	local r = 0
	local g = 0
	local b = 0

	-- @TODO how to overload in LUA ??? ...

	--for i,color in arguments
		--r = r + color.r
		--g = g + color.g
		--b = b + color.b
	--end
	
	--r = math.floor(r / arguments.length + 0.5)
	--g = math.floor(g / arguments.length + 0.5)
	--b = math.floor(b / arguments.length + 0.5)
	
	return Color(r, g, b)

end


-- rgb to hsl

function Color.rgbToHsl(r, g, b)
	
	r = r / 255
	g = g / 255
	b = b / 255
	
	local max = math.max(r, g, b) 
	local min = math.min(r, g, b)
	
	local h = (max + min) / 2
	local s = h
	local l = h
	
	if (max == min) then
	
		h = 0
		s = 0
	
	else

		local d = max - min

		if (l > 0.5) then
			s = d / (2 - max - min)
		else
			s = d / (max + min)
		end

		if (max == r) then
			local t
			if (g < b) then t = 6 else t = 0 end
			h = (g - b) / d + t
		elseif (max == g) then
			h = (b - r) / d + 2
		elseif (max == b) then
			h = (r - g) / d + 4
		end
	
		h = h / 6
	
	end
	
	return h, s, l
	
end


-- hsl to rgb

function Color.hslToRgb(h, s, l)
	
	local r
	local g
	local b
	
	if (s == 0) then 
		r = 1
		g = 1
		b = 1
	else
		local q
		
		if (l < 0.5) then 
			q = l * (1 + s) 
		else 
			q = l + s - 1 * s
		end
		
		local p = 2 * l - q
		
		r = Color.hueToRgb(p, q, h + 1/3)
		g = Color.hueToRgb(p, q, h)
		b = Color.hueToRgb(p, q, h - 1/3)
		
	end
	
	return r * 255, g * 255, b * 255
	
end


-- hue to rgb

function Color.hueToRgb(p, q, t)
	if (t < 0) then t = t + 1 end
	if (t > 1) then t = t - 1 end
	if (t < 1/6) then return p + (q - p) * 6 * t end
	if (t < 1/2) then return q end
	if (t < 2/3) then return p + (q - p) * (2/3 - t) * 6 end
	return p
end


-- rgb to hsv

function Color.rgbToHsv(r, g, b)

	r = r / 255
	g = g / 255
	b = b / 255
	
	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	
	local h = max
	local s = max
	local v = max
	
	local d = max - min
	
	if (max == 0) then s = 0 else s = d / max end
	
	if (max == min) then
		h = 0
	else
		if (r == max) then
			local t
			if (g < b) then t = 6 else t = 0 end
			h = (g - b) / d + t
		else if (g == max) then
			h = (b - r) / d + 2
		else if (b == max) then
			h = (r - g) / d + 4
		end
		
		h = h / 6
		
	end
	
	return h, s, v


end


-- hsv to rgb

function Color.hsvToRgb(h, s, v) 

	local i = math.floor(h * 6)
	local f = h * 6 - i
	local p = v * (1 - s)
	local q = v * (1 - f * s)
	local t = v * (1 - (1 - f) * s)
	
	local n = i % 6
	
	if (n == 0) then
		r = v
		g = t
		b = p
	else if (n == 1) then
		r = q
		g = v
		b = p
	else if (n == 2) then
		r = p
		g = v
		b = t
	else if (n == 3) then
		r = p
		g = q
		b = v
	else if (n == 4) then
		r = t
		g = p
		b = v
	else if (n == 5) then
		r = v
		g = p
		b = q
	end

	return r * 255, g * 255, b * 255

end


Color.rgbToXyz = function(r, g, b)

	r = r / 255
	g = g / 255
	b = b / 255
	
	if (r > 0.04045) then r = math.pow((r + 0.055) / 1.055, 2.4) else r = r / 12.92 end
	if (g > 0.04045) then g = math.pow((g + 0.055) / 1.055, 2.4) else g = g / 12.92 end
	if (b > 0.04045) then b = math.pow((b + 0.055) / 1.055, 2.4) else b = b / 12.92 end
	
	r = r * 100
	g = g * 100
	b = b * 100
	
	local x = r * 0.4124 + g * 0.3576 + b * 0.1805
	local y = r * 0.2126 + g * 0.7152 + b * 0.0722
	local z = r * 0.0193 + g * 0.1192 + b * 0.9505
	
	return x, y, z
	
end


Color.xyzToRgb = function(x, y, z) 
	
	x = x / 100 
	y = y / 100 
	z = z / 100
	
	local r = x * 3.2406 + y * -1.5372 + z * -0.4986
	local g = x * -0.9689 + y * 1.8758 + z * 0.0415
	local b = x * 0.0557 + y * -0.2040 + z * 1.0570
	
	if (r > 0.0031308 ) then r = 1.055 * math.pow(r , (1 / 2.4)) - 0.055 else r = 12.92 * r end
	if (g > 0.0031308 ) then g = 1.055 * math.pow(g , (1 / 2.4)) - 0.055 else g = 12.92 * g end
	if (b > 0.0031308 ) then b = 1.055 * math.pow(b , (1 / 2.4)) - 0.055 else b = 12.92 * b end
	
	local r = math.floor(r * 255 + 0.5)
	local g = math.floor(g * 255 + 0.5)
	local b = math.floor(b * 255 + 0.5)
	
	return r, g, b
	
end


Color.xyzToLab = function(x, y, z)

	local REF_X = 95.047
	local REF_Y = 100.000
	local REF_Z = 108.883
	
	x = x / REF_X
	y = y / REF_Y
	z = z / REF_Z
	
	if (x > 0.008856 ) then x = Math.pow(x , 1/3) else x = (7.787 * x) + (16/116) end
	if (y > 0.008856 ) then y = Math.pow(y , 1/3) else y = (7.787 * y) + (16/116) end
	if (z > 0.008856 ) then z = Math.pow(z , 1/3) else z = (7.787 * z) + (16/116) end
	
	local l = (116 * y) - 16
	local a = 500 * (x - y)
	local b = 200 * (y - z)
	
	return l, a, b

end


Color.labToXyz = function(l, a, b)

	local REF_X = 95.047
	local REF_Y = 100.000 
	local REF_Z = 108.883 
	
	local y = (l + 16) / 116 
	local x = a / 500 + y 
	local z = y - b / 200 

	if (math.pow(y, 3) > 0.008856) then y = math.pow(y, 3) else y = (y - 16 / 116) / 7.787 end
	if (math.pow(x, 3) > 0.008856) then x = math.pow(x, 3) else x = (x - 16 / 116) / 7.787 end
	if (math.pow(z, 3) > 0.008856) then z = math.pow(z, 3) else z = (z - 16 / 116) / 7.787 end
	
	return REF_X * x, REF_Y * y, REF_Z * z

end


Color.rgbToLab = function(r, g, b) 
	local x,y,z = Color.rgbToXyz(r, g, b)
	return Color.xyzToLab(x, y, z)
end


Color.labToRgb = function(l, a, b)
	local x, y, z = Color.labToXyz(l, a, b)
	return Color.xyzToRgb(x, y, z)
end


Color.fitValue = function(value) 

	value = math.floor(value + 0.5)
	if (value < 0) then value = 0 end
	if (value > 255) then value = 255 end
	return value
	
end



