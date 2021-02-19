--------------------------------------------------------------------------------
-- Tweener for any value (must be run on an update thread)
--------------------------------------------------------------------------------

IMPORT(Script.CLASS)

--------------------------------------------------------------------------------

ValueTweener = {}

ValueTweener.tweens = { }
ValueTweener.numTweens = -1
ValueTweener.currentTime = -1

-- Initializes the ValueTweener with a start time based on any normal, numerical 
-- time unit. Only needed if ValueTweener will be used to supply object (table)
-- property tweens (in which case ValueTweener.update() should also be called with
-- each update cycle).

ValueTweener.init = function(currentTime) 
	ValueTweener.currentTime = currentTime
end


-- Tween a property of an object (generic) from a startValue to and endValue, 
-- given a start time and duration, and an ease function. Optionally, a delay 
-- can be passed in, and the current time of the tweener can be bypassed with 
-- a custom start time.

-- Warning: does not check for or filter overriding tweens for now...

ValueTweener.tweenProp = function(obj, prop, startValue, endValue, duration, easeFunction, delay, currentTime)

	if (currentTime == nil) then currentTime = ValueTweener.currentTime end
	
	local tween = ValueTween(obj, prop, startValue, endValue, currentTime, duration, easeFunction, delay)
	
	ValueTweener._addTween(tween)

end


-- Update ValueTweener, updates any currently active tweens, and removes them from 
-- the active tweens collection once they are complete.

ValueTweener.update = function(currentTime)
	
	ValueTweener.currentTime = currentTime
	
	if (ValueTweener.numTweens < 0) then return end
	
	local tween = ValueTweener.tweens[0]
	
	-- iterate over the tweens collection as a linked list
	
	while (tween ~= nil) do 
		local complete = tween:update(currentTime)
		if (complete) then ValueTweener._removeTween(tween) end
		tween = tween._next -- << @TODO check this
	end
	
end


ValueTweener._addTween = function(tween) 
	
	local previousSiblingTween = ValueTweener.tweens[ValueTweener.numTweens]
	previousSiblingTween._next = tween
	tween._next = nil
	
	ValueTweener.numTweens = ValueTweener.numTweens + 1
	
	tween._index = ValueTweener.numTweens
	
	table.insert(ValueTweener.tweens, tween)

end


ValueTweener._removeTween = function(tween)

	ValueTweener.numTweens = ValueTweener.numTweens - 1
	
	local removeIndex = tween._index
	
	table.remove(ValueTweener.tweens, removeIndex)
	
	tween:dispose()
	
	if (removeIndex > 0) then
	
		local previousSiblingTween = ValueTweener.tweens[removeIndex - 1]
		
		if (removeIndex < ValueTweener.numTweens) then
			previousSiblingTween._next = ValueTweener.tweens[removeIndex]
		else
			previousSiblingTween._next = nil
		end
	end
	
	for i = removeIndex, ValueTweener.numTweens do
		local nextSiblingTween = ValueTweener.tweens[i]
		nextSiblingTween._index = nextSiblingTween._index - 1
	end

end




-- VALUE TWEEN (SINGLE) THREAD HELPER FOR VALUE TWEENER

--------------------------------------------------------------------------------
-- Tween any prop of an object (table)
--------------------------------------------------------------------------------


ValueTween = class(function(valueTween, obj, prop, startValue, endValue, startTime, duration, easeFunction, delay) 
	valueTween:init(obj, prop, startValue, endValue, duration, easeFunction, delay)
end)


function ValueTween:init(obj, prop, startValue, endValue, startTime, duration, easeFunction, delay) 
	
	self._complete = false
	
	if (obj == nil or prop == nil) then self._complete = true end
	if (startValue == nil) then startValue = obj[prop] end
	if (endValue == nil) then endValue = obj[prop] end
	if (startValue == endValue) then self._complete = true end
	if (startTime == nil) then startTime = 0 end
	if (duration == nil or duration <= 0) then self._complete = true end
	if (easeFunction == nil) then easeFunction = Penner.easeOutQuad end
	if (delay == nil) then delay = 0 end
	
	self.obj = obj
	self.prop = prop
	self.startValue = startValue
	self.endValue = endValue
	self.change = endValue - startValue
	self.startTime = startTime + delay
	self.endTime = self.startTime + duration
	self.easeFunction = easeFunction
	
	self._index = nil -- << used for table index for removal
	self._next = nil -- << used for single linked list item reference
	
end


function ValueTween:update(currentTime)
	
	-- tween has completed
	
	if (currentTime >= self.endTime or self._complete) then
		if (self.obj ~= nil and self.prop ~= nil) then self.obj[self.prop] = self.endValue end
		return true
	end
	
	-- tween is updating
	
	local tweenTime = currentTime - self.delay
	self.obj[self.prop] = self.easeFunction(tweenTime, self.startValue, self.change, self.duration)
	
	return false

end


function ValueTween:dispose()

	self.obj = nil
	self.prop = nil
	self.startValue = nil
	self.endValue = nil
	self.change = nil
	self.startTime = nil
	self.easeFunction = nil
	
	self._index = nil
	self._next = nil

end
