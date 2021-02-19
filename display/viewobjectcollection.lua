--------------------------------------------------------------------------------
-- ViewCollection
--------------------------------------------------------------------------------

IMPORT(Script.CLASS)
IMPORT(Script.VIEWOBJECT)

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

ViewObjectCollection = class(function(viewCollection) 
	ViewObjectCollection:init()
end)

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:init()
	self.views = {}
	self.indexedViews = {}
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:addView(key, viewObject)
	
	if (self.views[key] ~= nil and self.views[key] ~= viewObject) then
		PRINT("WARNING: ViewObjectCollection.addView key: ' .. key .. ' contained an object that was overridden.'")
	end
	
	self.views[key] == viewObject
	table.insert(self.indexedViews, self.views[key])
	
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:removeView(key)

	local view = self:getView(key)

	if (type(key) == 'string') then
	
		table.remove(self.indexedViews, self:indexOf(key))
		self.views[key] = nil
		
	elseif (type(key) == 'number') then
	
		table.remove(self.indexedViews, key)
		key = self:getKey(view)
		self.views[key] = nil
		
	end
	
	return view
	
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:contains(key)
	
	if (self.views[key] ~= nil) then return true end
	return false
	
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:getView(key)
	
	if (type(key) == 'string') then return self.views[key] end
	if (type(key) == 'number') then return self.indexedViews[key] end
	return nil
	
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:getKey(viewObject)

	for k, v in pairs(self.views) do
		if (v == viewObject) then return k end
	end
	
	return nil
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:indexOf(search)

	if (type(search) == 'string') then
		search = self.views[search]
	end
	
	for i, v in ipairs(self.indexedViews) do
		if (v == search) then return i end
	end
	
	return 0
	
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:clear()
	
	for k, v, in pairs(self.views) do
		v:destroy()
	end
	
	self.views = {}
	self.indexedViews = {}
end

--------------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------------

function ViewObjectCollection:destroy()
	self:clear()
end


