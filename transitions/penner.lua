--------------------------------------------------------------------------------
-- Easing Equations (thanks Robert Penner)
--------------------------------------------------------------------------------


Penner = {}

-- precalculated PI precisions used by Penner

Penner.PI			= 3.141592653589793
Penner.HALF_PI		= 1.5707963267948966
Penner.DOUBLE_PI	= 6.283185307179586


-- default easing

Penner.DEFAULT = Penner.quadEaseOut


--------------------------------------------------------------------------------
-- Back Easing 
--------------------------------------------------------------------------------

Penner.backEaseIn = function(t, b, c, d, s)
	
	if (s == nil) then s = 1.70158 end
	
	t = t / d
	return c * (t) * t * ((s + 1) * t - s) + b
	
end


Penner.backEaseOut = function(t, b, c, d, s)

	if (s == nil) then s = 1.70158 end
	
	t = t / d - 1
	return c * ((t) * t * ((s + 1) * t + s) + 1) + b
	
end


Penner.backEaseInOut = function(t, b, c, d, s)
	
	if (s == nil) then s = 1.70158 end
	
	t = t / (d * 0.5)
	
	if (t < 1) then 
		s = s * 1.525
		return c * 0.5 * (t * t * (((s) + 1) * t - s)) + b
	end
	
	t = t - 2
	s = s * 1.525
	return c / 2 * ((t) * t * (((s) + 1) * t + s) + 2) + b
	
end


--------------------------------------------------------------------------------
-- Bounce Easing 
--------------------------------------------------------------------------------

Penner.bounceEaseOut = function(t, b, c, d)

	t = t / d
	
	if ((t) < (1 / 2.75)) then
		return c * (7.5625 * t * t) + b
	elseif (t < (2 / 2.75)) then
		t = t - 1.5 / 2.75
		return c * (7.5625 * (t) * t + 0.75) + b
	elseif (t < (2.5 / 2.75)) then
		t = t - 2.25 / 2.75
		return c * (7.5625 * (t) * t + 0.9375) + b
	else
		t = t - 2.625 / 2.75
		return c * (7.5625 * (t) * t + 0.984375) + b
	end
	
end


Penner.bounceEaseIn = function(t, b, c, d)

	return c - Penner.bounceEaseOut(d - t, 0, c, d) + b
	
end


Penner.bounceEaseOut = function(t, b, c, d)

	if (t < d * 0.5) then
		return Penner.bounceEaseIn(t * 2, 0, c, d) * 0.5 + b
	else 
		return Penner.bounceEaseOut(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
	end
	
end


--------------------------------------------------------------------------------
-- Circular Easing 
--------------------------------------------------------------------------------

Penner.circEaseIn = function(t, b, c, d)
	
	t = t / d
	return -c * (math.sqrt(1 - (t) * t) - 1) + b
	
end


Penner.circEaseOut = function(t, b, c, d)

	t = t / d - 1
	return c * math.sqrt(1 - (t) * t) + b
	
end


Penner.circEaseInOut = function(t, b, c, d)
	
	t = t / (d * 0.5)
	
	if ((t) < 1) then 
		return -c * 0.5 * (math.sqrt(1 - t * t) - 1) + b
	end
	
	t = t - 2
	return c * 0.5 * (math.sqrt(1 - (t) * t) + 1) + b
	
end


--------------------------------------------------------------------------------
-- Cubic Easing 
--------------------------------------------------------------------------------

Penner.cubicEaseIn = function(t, b, c, d)
	
	t = t / d
	return c * (t) * t * t + b

end


Penner.cubicEaseOut = function(t, b, c, d)

	t = t / d - 1
	return c * ((t) * t * t + 1) + b

end


Penner.cubicEaseInOut = function(t, b, c, d)
	
	t = t / (d * 0.5)
	
	if ((t) < 1) then 
		return c * 0.5 * t * t * t + b
	end
	
	t = t - 2
	
	return c * 0.5 * ((t) * t * t + 2) + b

end


--------------------------------------------------------------------------------
-- Elastic Easing 
--------------------------------------------------------------------------------

Penner.elasticEaseIn = function(t, b, c, d, a, p)
	
	local s
	
	if (t == 0) then 
		return b
	end
	
	t = t / d
	
	if ((t) == 1) then
		return b + c 
	end	
	
	if (p == nil) then
		p = d * 0.3
	end
	
	if (a == nil or (c > 0 and a < c) or (c < 0 and a < -c)) then 
		a = c
		s = p / 4
	else 
		s = p / Penner.DOUBLE_PI * math.asin(c / a)
	end
	
	t = t - 1
	
	return -(a * math.pow(2, 10 * (t)) * math.sin((t * d - s) * Penner.DOUBLE_PI / p)) + b
	
end


Penner.elasticEaseOut = function(t, b, c, d, a, p)

	local s
	
	if (t == 0) then 
		return b
	end
	
	t = t / d
	
	if ((t) == 1) then 
		return b + c
	end 
	
	if (p == nil) then 
		p = d * 0.3
	end
	
	if (a == nil or (c > 0 and a < c) or (c < 0 and a < -c)) then 
		a = c
		s = p / 4
	else 
		s = p / Penner.DOUBLE_PI * math.asin(c / a)
	end
	
	return (a * math.pow(2, -10 * t) * math.sin((t * d - s) * Penner.DOUBLE_PI / p ) + c + b)
	
end


Penner.elasticEaseInOut = function(t, b, c, d, a, p)

	local s
	
	if (t == 0) then 
		return b
	end
	
	t = t / (d * 0.5)
	
	if ((t) == 2) then 
		return b + c
	end
	
	if (p == nil) then 
		p = d * (0.3 * 1.5)
	end
	
	if (a == nil or (c > 0 and a < c) or (c < 0 and a < -c)) then 
		a = c
		s = p / 4
	else 
		s = p / Penner.DOUBLE_PI * math.asin(c / a)
	end
	
	if (t < 1) then 
		t = t - 1
		return -0.5 * (a * math.pow(2, 10 * (t)) * math.sin((t * d - s) * Penner.DOUBLE_PI / p)) + b
	end
	
	t = t - 1
	return a * math.pow(2, -10 * (t)) * math.sin((t * d - s) * Penner.DOUBLE_PI / p ) * 0.5 + c + b
	
end


--------------------------------------------------------------------------------
-- Exponential Easing 
--------------------------------------------------------------------------------

Penner.expoEaseIn = function(t, b, c, d)

	if (t == 0) then
		return b
	else
		return c * math.pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end

end


Penner.expoEaseOut = function(t, b, c, d)

	if (t == d) then
		return b + c
	else 
		return c * (-math.pow(2, -10 * t / d) + 1) + b
	end
	
end


Penner.expoEaseInOut = function(t, b, c, d)

	if (t == 0) then 
		return b
	end
	
	if (t == d) then 
		return b + c
	end
	
	t = t / (d * 0.5)
	
	if ((t) < 1) then 
		return c * 0.5 * math.pow(2, 10 * (t - 1)) + b
	end
	
	t = t - 1
	
	return c * 0.5 * (-math.pow(2, -10 * t) + 2) + b

end


--------------------------------------------------------------------------------
-- Linear Easing 
--------------------------------------------------------------------------------

Penner.linearEaseNone = function(t, b, c, d)

	return c * t / d + b

end


Penner.linearEaseIn = function(t, b, c, d)

	return Penner.linearEaseNone(t, b, c, d)

end


Penner.linearEaseOut = function(t, b, c, d)

	return Penner.linearEaseNone(t, b, c, d)

end


Penner.linearEaseInOut = function(t, b, c, d)

	return Penner.linearEaseNone(t, b, c, d)

end


--------------------------------------------------------------------------------
-- Quadratic Easing 
--------------------------------------------------------------------------------

Penner.quadEaseIn = function(t, b, c, d)

	t = t / d
	return c * t * t + b

end


Penner.quadEaseOut = function(t, b, c, d)
	
	t = t / d
	return -c * t * (t - 2) + b

end


Penner.quadEaseInOut = function(t, b, c, d)
	
	t = t / (d * 0.5)
	
	if (t < 1) then 
		return c * 0.5 * t * t + b
	end
	
	t = t - 1
	
	return -c * 0.5 * (t * (t - 2) - 1) + b

end


--------------------------------------------------------------------------------
-- Quartic Easing
--------------------------------------------------------------------------------

Penner.quartEaseIn = function(t, b, c, d)

	t = t / d
	return c * (t) * t * t * t + b

end


Penner.quartEaseOut = function(t, b, c, d)

	t = t / d - 1
	return -c * ((t) * t * t * t - 1) + b

end


Penner.quartEaseInOut = function(t, b, c, d)

	t = t / (d * 0.5)
	
	if ((t) < 1) then 
		return c * 0.5 * t * t * t * t + b
	end
	
	t = t - 2
	
	return -c * 0.5 * ((t) * t * t * t - 2) + b

end



--------------------------------------------------------------------------------
-- Quintic Easing 
--------------------------------------------------------------------------------

Penner.quintEaseIn = function(t, b, c, d)

	t = t / d
	return c * (t) * t * t * t * t + b

end


Penner.quintEaseOut = function(t, b, c, d)

	t = t / d - 1
	return c * ((t) * t * t * t * t + 1) + b

end


Penner.quintEaseInOut = function(t, b, c, d)

	t = t / (d * 0.5)
	
	if ((t) < 1) then 
		return c * 0.5 * t * t * t * t * t + b
	end
	
	t = t - 2
	
	return c * 0.5 * ((t) * t * t * t * t + 2) + b

end




--------------------------------------------------------------------------------
-- Sinusoidal Easing 
--------------------------------------------------------------------------------

Penner.sineEaseIn = function(t, b, c, d)

	return -c * math.cos(t / d * Penner.HALF_PI) + c + b
	
end


Penner.sineEaseOut = function(t, b, c, d)
	
	return c * math.sin(t / d * Penner.HALF_PI) + b
	
end


Penner.sineEaseInOut = function(t, b, c, d)
	
	return -c * 0.5 * (math.cos(Penner.PI * t / d) - 1) + b
	
end




--------------------------------------------------------------------------------
-- Strong Easing (just shortcuts Quintic Easing) 
--------------------------------------------------------------------------------

Penner.strongEaseIn = function(t, b, c, d)

	return Penner.quintEaseIn(t, b, c, d)

end


Penner.strongEaseOut = function(t, b, c, d)

	return Penner.quintEaseOut(t, b, c, d)

end


Penner.strongEaseInOut = function(t, b, c, d)

	return Penner.quintEaseInOut(t, b, c, d)

end



