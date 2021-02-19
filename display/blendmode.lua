--------------------------------------------------------------------------------
-- BlendMode Utilities (and Enumarations)
--------------------------------------------------------------------------------


BlendMode = {}

BlendMode.NORMAL		= "blendModeNormal"
BlendMode.CUSTOM		= "blendModeCustom"
BlendMode.ADD			= "blendModeAdd"
BlendMode.SUBTRACT		= "blendModeSubtract"
BlendMode.LIGHTEN		= "blendModeLighten"
BlendMode.SOFTLIGHT		= "blendModeSoftLight"
BlendMode.DARKEN		= "blendModeDarken"
BlendMode.BLACKEN		= "blendModeBlacken"
BlendMode.SCREEN		= "blendModeScreen"
BlendMode.MULTIPLY 		= "blendModeMultiply"
BlendMode.OVERLAY 		= "blendModeOverlay"
BlendMode.INVERT		= "blendModeInvert"
BlendMode.BLEND			= "blendModeBlend"
BlendMode.FILTER		= "blendModeFilter"
BlendMode.KNOCKOUT		= "blendModeKnockout"
BlendMode.MODULATE		= "blendModeModulate"
BlendMode.NONE 			= "blendModeNone"


-- Return the GL Blend Func enumerations for the src/dst blending of a given 
-- blend mode key (as a list of src and dst enumerations)

BlendMode.getGLBlendFunc = function(blendModeKey) 

	local src = "GL_ONE"
	local dst = "GL_ONE_MINUS_SRC_ALPHA"
	
	if (blendModeKey == BlendMode.NORMAL) then
	
		-- default
		
	elseif (blendModeKey == BlendMode.ADD) then
	
		src = "GL_ONE"
		dst = "GL_ONE"
		
	elseif (blendModeKey == BlendMode.SUBTRACT) then
	
		src = "GL_ZERO"
		dst = "GL_ONE_MINUS_SRC_COLOR"
		
	elseif (blendModeKey == BlendMode.LIGHTEN) then
	
		src = "GL_ONE_MINUS_DST_COLOR"
		dst = "GL_ONE"
		
	elseif (blendModeKey == BlendMode.SOFTLIGHT) then
	
		src = "GL_DST_COLOR"
		dst = "GL_ONE"
		
	elseif (blendModeKey == BlendMode.DARKEN) then
	
		src = "GL_ZERO"
		dst = "GL_ONE_MINUS_SRC_COLOR"
		
	elseif (blendModeKey == BlendMode.BLACKEN) then
	
		src = "GL_ZERO"
		dst = "GL_ONE_MINUS_SRC_ALPHA"
		
	elseif (blendModeKey == BlendMode.SCREEN) then
	
		src = "GL_ONE"
		dst = "GL_ONE_MINUS_SRC_COLOR"
		
	elseif (blendModeKey == BlendMode.MULTIPLY) then
	
		src = "GL_DST_COLOR"
		dst = "GL_ONE_MINUS_SRC_ALPHA"
		
	elseif (blendModeKey == BlendMode.OVERLAY) then
	
		src = "GL_ONE_MINUS_DST_COLOR"
		dst = "GL_ONE_MINUS_SRC_ALPHA"
		
	elseif (blendModeKey == BlendMode.INVERT) then
	
		-- TBA
		
	elseif (blendModeKey == BlendMode.BLEND) then
	
		src = "GL_SRC_ALPHA"
		dst = "GL_ONE_MINUS_SRC_ALPHA"
		
	elseif (blendModeKey == BlendMode.FILTER) then
	
		src = "GL_DST_COLOR"
		dst = "GL_ZERO"
		
	elseif (blendModekey == BlendMode.KNOCKOUT) then
	
		src = "GL_ONE_MINUS_SRC_ALPHA"
		dst = "GL_ONE"
		
	elseif (blendModeKey == BlendMode.MODULATE) then
	
		src = "GL_DST_COLOR"
		dst = "GL_SRC_COLOR"
		
	elseif (blendModeKey == BlendMode.NONE) then
	
		src = "GL_ZERO"
		dst = "GL_ONE"
		
	end
	
	return src, dst
	
end






