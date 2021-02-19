--------------------------------------------------------------------------------
-- Tri
-- Right triangle used for trick drawing
--------------------------------------------------------------------------------

IMPORT(Script.CLASS)
IMPORT(Script.VIEWOBJECT)
IMPORT(Script.POINT)

--------------------------------------------------------------------------------

Tri = class(ViewObject, function(t, sourceBitmap)
	if (sourceBitmap == nil) then sourceBitmap = "#skins/levels/common/temp/test_triangle_01.png" end
	ViewObject.init(t, sourceBitmap, 0, 0, 256, 256)
	self:init()
end)

function Tri:init()

	self.a = Point(0, 0)
	self.b = Point(255, 0)
	self.c = Point(0, 255)

end



-- override setters to update a,b,c when set
-- create a 'random bind to (triangle)' method
