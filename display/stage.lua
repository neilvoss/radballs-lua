--------------------------------------------------------------------------------
-- Stage 
--------------------------------------------------------------------------------

IMPORT(Script.BLENDMODE)

--------------------------------------------------------------------------------

Stage = { }



Stage.width = 320
Stage.height = 480
Stage.orientation = Stage.ORIENTATION_PORTRAIT
Stage.resolution = 150
Stage.blendMode = BlendMode.NORMAL

--

StageOrientation = {}
StageOrientation.PORTRAIT = "portraitOrientation"
StageOrientation.LANDSCAPE = "landscapeOrientation"
StageOrientation.SQUARE = "squareOrientation"

-- 

function Stage.init()
	Stage.validate()
end

--

function Stage.validate()
	-- read all the stage properties from the game
	-- define the params of Stage from them...
end

--

function Stage.getWidth()
	return Stage.width
end

--

function Stage.getHeight()
	return Stage.height
end

--

function Stage.getOrientation()
	return Stage.orientation
end

-- 

function Stage.getResolution()
	return Stage.resolution
end

--

function Stage.getBlendMode()
	return Stage.blendMode
end

--

function Stage.setBlendMode(blendMode)
	-- set the BlendMode for the stage's FBO
	Stage.blendMode = blendMode
end

--








