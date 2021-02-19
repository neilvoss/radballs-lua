--------------------------------------------------------------------------------
-- Point (2D, and/or a Vector2D)
--------------------------------------------------------------------------------

IMPORT(Script.CLASS)

--------------------------------------------------------------------------------

Point = class(function(point, x, y) 
	point:set(x, y)
end)


-- PI precision for Point

Point.PI = 3.141592653589793


-- get the x and y of the point as a table

function Point:get() 
	return self.x, self.y
end


-- set the x and y of the point

function Point:set(x, y)
	
	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	self.x = x
	self.y = y
	
end

--
--
-- Default overrides
--
--

-- override addition (p1 + p2)

function Point.__add(p1, p2)
	return Point(p1.x + p2.x, p1.y + p2.y)
end


-- override subtraction (p1 - p2)

function Point.__sub(p1, p2)
	return Point(p1.x - p2.x, p1.y - p2.y)
end


-- override multiplication (p1 * p2)

function Point.__mul(s, p)
	return Point(p.x * s, p.y * s)
end


-- override division (p1 / p2)

function Point.__div(p, s)
	return Point(p.x / s, p.y / s)
end


-- override unary minus (p = -p)

function Point.__unm(p) 
	return Point(-p.x, -p.y)
end


-- override equality (p = p)

function Point.__eq(p1, p2)
	return (p1.x == p2.x and p1.y == p2.y)
end


-- override concat '..' with operation producing the dot product

function Point.__concat(p1, p2)
	return p1.x * p2.x + p1.y * p2.y
end


-- override exp '^' with operation producing the cross product

function Point.__pow(p1, p2)
	return p1.x * p2.y - p1.y * p2.x
end


-- override tostring

function Point.__tostring(pt) 
	return string.format('Point(%f, %f)', p.x, p.y)
end


--
--
-- Methods
--
-- As Member 				- pointInstance:someMethod(...)
-- Members-only :D 			- pointInstance.someMethod(anotherPointInstance, ...)
-- As Class 				- Point.someMethod(pointInstance, ...) 
--
--

-- translate the point's x and y by a point or amount/s


function Point:translate(x, y)

	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	self.x = self.x + x
	self.y = self.y + y
	
	return point
	
end


-- add a point or amount/s to the point

function Point:add(x, y)
	
	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	self.x = self.x + x
	self.y = self.y + y
	
	return self
	
end


-- subtract a point or amount/s from the point

function Point:subtract(x, y)
	
	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	self.x = self.x - x
	self.y = self.y - y
	
	return self
	
end


-- multiply the point by a point or amount/s

function Point:multiply(x, y)

	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	self.x = self.x * x
	self.y = self.y * y
	
	return self
	
end


-- scale the point by a scalar point or amount/s

function Point:scale(x, y)

	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end

	self.x = self.x * x
	self.y = self.y * y
	
	return self
	
end


-- divide the point by a point or amount/s

function Point:divide(x, y)

	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	self.x = self.x / x
	self.y = self.y / y
	
	return self
	
end


-- invert the point

function Point:invert()

	self.x = -self.x
	self.y = -self.y
	
	return self
	
end


-- check the point (A) for equality with another point (B)

function Point:equals(point)
	return (self.x == point.x and self.y == point.y)
end


-- get the dot product of the point and another point or amount/s

function Point:dot(x, y)

	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	return self.x * x + self.y * y
	
end


-- get the cross product of the point and another point or amount/s

function Point:cross(p)

	if type(x) == 'table' and getmetatable(x) == Point then 
		local tp = x 
		x = tp.x 
		y = tp.y
	end
	
	if (y == nil) then y = x end
	
	return self.x * y - self.y * x
	
end


-- rotate the point by the given angle with the given origin

function Point:rotate(angle, origin)
	
	if (angle == nil) then
		angle = 0
	end
	
	if (origin == nil) then
		origin = Point(0, 0)
	end
	
	angle = -angle -- << flip for GL
	local radians = Point.PI * angle / 180
	
	self:subtract(origin)
	
	local tx = self.x * math.cos(radians) - self.y * math.sin(radians)
	local ty = self.x * math.sin(radians) + self.y * math.cos(radians)
	
	self.x = tx
	self.y = ty
	
	self:add(origin)
	
	return self

end


-- get the angle of the point-as-vector

function Point:getAngle()
	return math.atan2(self.x, self.y) * (180 / Point.PI)
end


-- set the angle of the point-as-vector (use Point:rotate to do so with varied origin)

function Point:setAngle(angle)

	-- local radians = math.rad(angle)
	local radians = Point.PI * angle / 180
	local magnitude = math.sqrt((self.x * self.x) + (self.y * self.y))
	self.x = magnitude * math.cos(radians)
	self.y = magnitude * math.sin(radians)
	
	return self
	
end


-- get the angle between the point (A) and another point (B), in degrees

function Point:angleBetween(point)
	
	local product = self:dot(point)
	local magnitudeA = self:getMagnitude()
	local magnitudeB = point:getMagnitude()

	return math.acos(product / (magnitudeA * magnitudeB))
	
end


-- get the sine of the angle between the point and another point, in degrees

function Point:angleBetweenSin(point)

	local product = self:cross(point)
	local magnitudeA = self:getMagnitude()
	local magnitudeB = point:getMagnitude()
	
	return (product / (magnitudeA * magnitudeB))
	
end


-- get the cosine of the angle between the point and another point, in degrees

function Point:angleBetweenCos(point)

	local product = self:dot(point)
	local magnitudeA = self:getMagnitude()
	local magnitudeB = point:getMagnitude()
	
	return (product / (magnitudeA * magnitudeB))
	
end


-- reflect point with self...

function Point:reflect(point)

	local horizontalReflection = Point(point.y, -point.x)
	local angle = 2 * self:angleBetween(point)
	
	if (0 >= self:angleBetweenCos(horizontalReflection)) then
		angle = angle * -1
	end
	
	self:rotate(angle)
	
	return self
	
end


-- project the point onto a point

function Point:project(point)

	local magnitude = self:getMagnitude()
	local scalar = self:dot(point) / (magnitude * magnitude)
	self:set(point)
	self:scale(scalar)
	
	return self
	
end


-- get the magnitude (length) of the point-as-vector

function Point:getMagnitude()
	return math.sqrt((self.x * self.x) + (self.y * self.y))
end


-- get the length of the point (ease of use for flash ports)

function Point:length()
	return self:getMagnitude()
end


-- get the distance between the point and a point

function Point:distance(point)

	local dx = point.x - self.x
	local dy = point.y - self.y
	
	return math.sqrt((dx * dx) + (dy * dy))
	
end


-- interpolate the point with another

function Point:interpolate(point)
	
	local tx = (self.x + point.x) * 0.50
	local ty = (self.y + point.y) * 0.50
	
	self.x = tx
	self.y = ty
	
	return self
	
end


-- set the magnitude (length) of the point-as-vector

function Point:setMagnitude(magnitude)

	local currentMagnitude = self:getMagnitude()
	
	if (0 < currentMagnitude) then
		self:multiply(magnitude / currentMagnitude)
	else
		self.y = 0
		self.x = magnitude
	end
	
	return self
	
end


-- normalize the point

function Point:normalize() 

	local length = self:getMagnitude()
	self.x = self.x / length
	self.y = self.y / length
	
	return self
	
end


-- swap the point with another point

function Point:swap(point)

	local tx = self.x
	local ty = self.y
	self.x = point.x
	self.y = point.y
	point.x = tx
	point.y = ty
	
	return self
	
end


-- get a new point that is normal (clockwise) to the point

function Point:getRightNormal()
	return Point(self.y, -self.x)
end


-- get a new point this is normal (counterclockwise) to the point

function Point:getLeftNormal()
	return Point(-self.y, self.x)
end


-- check if the point is normal to another point

function Point:isNormalTo(point)
	
	local dotProduct = self:dot(point)
	return (dotProduct == 0)

end


-- copy the point as a new point

function Point:copy()
	return Point(self.x, self.y)
end







