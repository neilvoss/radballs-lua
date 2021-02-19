--------------------------------------------------------------------------------
-- Tweenable properties of ViewObjects
--------------------------------------------------------------------------------


Tweenables = {}

Tweenables._map = {
	X 					= 'x',
	Y 					= 'y',
	WIDTH 				= 'width',
	HEIGHT 				= 'height',
	SCALE 				= 'scale',
	SCALE_X 			= 'scaleX',
	SCALE_Y 			= 'scaleY',
	ROTATION 			= 'rotation',
	COLOR 				= 'color',
	ALPHA 				= 'alpha'
}

Tweenables.X 			= Tweenables._map.X
Tweenables.Y 			= Tweenables._map.Y
Tweenables.WIDTH 		= Tweenables._map.WIDTH
Tweenables.HEIGHT 		= Tweenables._map.HEIGHT
Tweenables.SCALE 		= Tweenables._map.SCALE
Tweenables.SCALE_X 		= Tweenables._map.SCALE_X
Tweenables.SCALE_Y 		= Tweenables._map.SCALE_Y
Tweenables.ROTATION 	= Tweenables._map.ROTATION
Tweenables.COLOR 		= Tweenables._map.COLOR
Tweenables.ALPHA 		= Tweenables._map.ALPHA


Tweenables.isValid = function(prop) 

	for k, v in pairs(Tweenables._map) do
		if (v == prop) then return true end
	end
	
	return false
end


Tweenables.match = function(prop)

	if (Tweenables.isValid(prop)) then return prop end
	
	-- shortcuts
	
	if (prop == 'w') then return Tweenables.WIDTH end
	if (prop == 'h') then return Tweenables.HEIGHT end
	if (prop == 'sx' or prop == 'scalex') then return Tweenables.SCALE_X end
	if (prop == 'sy' or prop == 'scaley') then return Tweenables.SCALE_Y end
	if (prop == 'r' or prop == 'angle') then return Tweenables.ROTATION end
	if (prop == 'c') then return Tweenables.COLOR end
	if (prop == 'a' or prop == 'o' or prop == 'opacity') then return Tweenables.ALPHA end
	
	return nil
	
end
