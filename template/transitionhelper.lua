--------------------------------------------------------------------------------
-- 
-- 
-- 
--------------------------------------------------------------------------------

IMPORT(Script.CLASS)
IMPORT(Script.GAME)

-- stuff usually needed by transitions but not necessarily by this 
-- (convenience imports for transition scripts)

IMPORT(Script.GLOBALS)
IMPORT(Script.VIEWOBJECT)
IMPORT(Script.BLENDMODE)
IMPORT(Script.GRAPHICS)
IMPORT(Script.STAGE)
IMPORT(Script.POINT)
IMPORT(Script.TWEEN)
IMPORT(Script.TWEENABLES)
IMPORT(Script.TRANSITION)

--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

TransitionHelper = class(function(transitionHelper, duration, debug) 
	transitionHelper:init(duration, debug) 
end)

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function TransitionHelper:init(duration, debug)
	
	if (duration == nil) then duration = 8 end
	self.duration = duration
	
	self.beat = 0
	self.onsetTime = 0
	self.currentBeat = 0
	self.currentBeatSub = 0
	
	self.isInitialized = false	
	self.shouldUpdate = true
	
	self.debug = false
	if (debug == true) then self.debug = true end
	
	-- frames to wait at the end before returning complete
	
	self.waitFrames = 2
	
	-- @TODO query the game for this
	
	self.shouldSkipAnimation = false	
	
	-- assignable delegates
	
	self.onUpdateSequencer = nil
	self.onComplete = nil
	
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function TransitionHelper:update(beat)
	
	if (self.debug) then PRINT("BEAT " .. beat) end
	
	-- initialize the updates to the correct start beat
	
	if (isInitialized == false) then
		self.beat = beat
	end
	
	-- synchronize the current BPM, setting globals
	
	BPM = Game.getBpm()
	MSPB = 60 / BPM * 1000
	MSPBS = MSPB * 0.25
	
	-- if animation should be skipped, terminate immediately
	
	if (self.shouldSkipAnimation == true) then 
		self:cleanUp(views)
		return 1 
	end
	
	--
	
	local updateTime = os.clock()
	
	-- if the beat counter increments, set the onset time of the new beat and update the current counts
	
	if (beat > self.beat) then
		self.beat = beat
		self.onsetTime = updateTime
		self.currentBeat = self.currentBeat + 1
		self.currentBeatSub = 0
		self.shouldUpdate = true
	end
	
	-- update sub beats
	
	local dt = (updateTime - self.onsetTime) * 1000
	
	if (dt > MSPBS) then
		if (self.debug) then PRINT('tick') end
		self.onsetTime = updateTime
		self.currentBeatSub = self.currentBeatSub + 1
		self.shouldUpdate = true
	end
	
	-- if should update and a sequencer update delegate has been assigned, call the delegate with the
	-- updated timing values
	
	if (self.shouldUpdate) then
		
		if (self.debug) then PRINT("onUpdateSequencer: " .. self.currentBeat .. " " .. self.currentBeatSub) end
		
		self.shouldUpdate = false
		if (self.onUpdateSequencer ~= nil) then self.onUpdateSequencer(self.currentBeat, self.currentBeatSub) end
	end
	
	-- return 1 (transition complete) or 0 (transition in progress)
	
	if (self.currentBeat >= self.duration + 1) then
	
		-- call onComplete delegate if one has been assigned
	
		if (self.onComplete ~= nil) then self.onComplete() end
		
		-- wait for a defined number of frames before returning complete
		
		self.waitFrames = self.waitFrames - 1
		
		if (self.waitFrames <= 0) then return 1 else return 0 end
		
	else
		return 0
	end
	
end

--------------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------------

function TransitionHelper:cleanUp(collection)

	-- double check this...

	for k, v in pairs(collection) do
	
		PRINT('cleaning up view key: ' .. k)
		
		if type(v) == 'table' and getmetatable(v) == ViewObject then 
			v:destroy()
		else
			self:cleanUp(v)
		end
	end

end


