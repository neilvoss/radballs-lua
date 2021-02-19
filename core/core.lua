--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

RESOURCE_PATH = ""
DOCUMENT_PATH = ""

----

Core = {}

function Core.init(resourcePath, documentPath) 
	
	-- seed lua's own random and iterate it over a few passes
	
	math.randomseed(os.time())
	for i=0,10 do local rand = math.random() end
	
	RESOURCE_PATH = resourcePath
	DOCUMENT_PATH = documentPath
	
	IMPORT(Script.CLASS)
	IMPORT(Script.GAME)
	IMPORT(Script.UTILS)
	
end

Core._imported = {}
Core._benchmarkLabel = ""
Core._benchmarkTime = 0

----

Script = {}

Script._map = { 

	CLASS 					= "core/class.lua", 
	GAME 					= "core/game.lua", 
	BLENDMODE 				= 'display/blendmode.lua',
	COLOR 					= 'display/color.lua',
	GRAPHICS 				= 'display/graphics.lua',
	STAGE 					= 'display/stage.lua',
	VIEWOBJECT 				= 'display/viewobject.lua',
	VIEWOBJECTCOLLECTION 	= 'display/viewobjectcollection.lua',
	TRI						= 'draw/tri.lua',
	POINT					= 'geom/point.lua',
	PENNER 					= 'transitions/penner.lua',
	TRANSITION 				= 'transitions/transition.lua',
	TWEEN 					= 'transitions/tweener.lua',
	TWEENABLES 				= 'transitions/tweenables.lua',
	VALUETWEEN 				= 'transitions/valuetweener.lua',
	UTILS 					= 'util/utils.lua',
	
	GLOBALS 				= 'template/globals.lua',
	TRANSITIONHELPER 		= 'template/transitionhelper.lua',
	
	TRAIN_RADBALL 			= 'train/radball.lua',
	TRAIN_GROUP 			= 'train/group.lua',
	TRAIN_CURSOR			= 'train/cursor.lua',
	TRAIN_BEATWAVE 			= 'train/beatwave.lua',
	TRAIN_DIALOG 			= 'train/dialog.lua',
	TRAIN_DIRECTIVE			= 'train/directive.lua',
	TRAIN_PANEL 			= 'train/panel.lua',
	TRAIN_METER 			= 'train/meter.lua',
	
	_END_MAP 				= '_end_map'
}

Script.CLASS 				= Script._map.CLASS
Script.GAME 				= Script._map.GAME
Script.BLENDMODE 			= Script._map.BLENDMODE
Script.COLOR 				= Script._map.COLOR
Script.GRAPHICS 			= Script._map.GRAPHICS
Script.STAGE 				= Script._map.STAGE
Script.VIEWOBJECT 			= Script._map.VIEWOBJECT
Script.VIEWOBJECTCOLLECTION = Script._map.VIEWOBJECTCOLLECTION
Script.TRI 					= Script._map.TRI
Script.POINT 				= Script._map.POINT
Script.PENNER 				= Script._map.PENNER
Script.TRANSITION 			= Script._map.TRANSITION
Script.TWEEN 				= Script._map.TWEEN
Script.TWEENABLES 			= Script._map.TWEENABLES
Script.VALUETWEEN 			= Script._map.VALUETWEEN
Script.UTILS 				= Script._map.UTILS

Script.GLOBALS  			= Script._map.GLOBALS
Script.TRANSITIONHELPER 	= Script._map.TRANSITIONHELPER

Script.TRAIN_RADBALL 		= Script._map.TRAIN_RADBALL
Script.TRAIN_GROUP 			= Script._map.TRAIN_GROUP
Script.TRAIN_CURSOR 		= Script._map.TRAIN_CURSOR
Script.TRAIN_BEATWAVE 		= Script._map.TRAIN_BEATWAVE
Script.TRAIN_DIALOG 		= Script._map.TRAIN_DIALOG
Script.TRAIN_DIRECTIVE 		= Script._map.TRAIN_DIRECTIVE
Script.TRAIN_PANEL			= Script._map.TRAIN_PANEL
Script.TRAIN_METER			= Script._map.TRAIN_METER

Script.isValid = function(prop) 
	
	for k, v in pairs(Script._map) do
		if (v == prop) then return true end
	end
	
	return false
end


---- Import a script into the lua context. Validates, and minimizes redundant imports.

function IMPORT(script) 
	
	if (Script.isValid(script) == false) then
		LuaBridge.print("Script: '" .. script .. "' is not valid.")
		return
	end
	
	FORCE_IMPORT(script)

end


---- Import a script into the lua context (without validation).

function FORCE_IMPORT(script)

	-- find a better way to do this 'contains key' thing...
	
	for i, v in ipairs(Core._imported) do
	
		if (script == v) then
			LuaBridge.print("Script: '" .. script .. "' was already imported.")
			return
		end
	end
	
	LuaBridge.print("Importing Script: '" .. script .. "'")
	
	table.insert(Core._imported, script)
	
	dofile(RESOURCE_PATH .. "skins/levels/common/lua/" .. script)
	
end
	

---- Print a message, or a generic ping with a timestamp

function PRINT(message) 
	
	if (message == nil) then 
		message = ">> PING " .. os.clock()
	end
	
	LuaBridge.print(message)

end


---- Simple inline benchmark

function BENCHMARK(label)

	if (label == nil) then label = Core._benchmarkLabel end
	
	local currentTime = os.clock()
		
	if (Core._benchmarkTime == 0 or label ~= Core._benchmarkLabel) then
		PRINT("LUA BENCHMARK: " .. label .. " start time: " .. currentTime)
	else
		PRINT("LUA BENCHMARK: " .. label .. " cycle time: " .. currentTime - Core._benchmarkTime)
	end
	
	Core._benchmarkLabel = label
	Core._benchmarkTime = currentTime
	
end

