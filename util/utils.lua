--------------------------------------------------------------------------------
-- General Util Methods
--------------------------------------------------------------------------------


Utils = { }

-- various added randomness methods

function Utils.random(range)
	if (range == nil) then range = 1.0 end
	return LuaBridge.random() * range
end


function Utils.randomBetween(lowerLimit, upperLimit)
	return lowerLimit + LuaBridge.random() * (upperLimit - lowerLimit)
end


function Utils.randomSeed(range)
	return math.floor(Utils.random(range) + 0.5)
end


function Utils.randomInt(range)
	return math.floor(Utils.random(range) + 0.5)
end


function Utils.randomIntBetween(lowerLimit, upperLimit)
	local lower = math.floor(lowerLimit)
	local upper = math.ceil(upperLimit)
	return lower + math.floor(LuaBridge.random() * (upper - lower))
end




