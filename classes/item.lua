item = {}

-- Constructor
function item:new(itemX, itemY)
    local object = {
    x = itemX,
    y = itemY,
    width = 32,
    height = 32,
    frame = math.random(1,20),
    delay = 200,
    delta = 0,
    maxDelta = 10
    }
    setmetatable(object, { __index = item } )
    return object
end

function item:update(dt)
    self.delta = self.delta + self.delay * dt
    
    -- if maxDelta is reached, advance one frame
    if self.delta >= self.maxDelta then
        self.frame = self.frame % 20 + 1
        self.delta = 0
    end
end

-- returns true if the tile given is empty
function item:isColliding(map)
    -- get tile coordinates
    local tileX, tileY = math.floor(self.x / map.tileWidth), math.floor(self.y / map.tileHeight)
    local layer = map.tl["Walls"]
    
    -- grab the tile at given point
    local tile = layer.tileData(tileX, tileY)
    
    -- return true if the point overlaps a solid tile
    return not(tile == nil)
end

-- returns true if the object intersects this item
function item:touchesObject(object)
    local cx1, cx2 = self.x - self.width / 2, self.x + self.width / 2 - 1
    local cy1, cy2 = self.y - self.height / 2, self.y + self.height / 2 - 1
    local px1, px2 = object.x - object.width / 2, object.x + object.width / 2 - 1
    local py1, py2 = object.y - object.height / 2, object.y + object.height / 2 - 1
    
    return ((cx2 >= px1) and (cx1 <= px2) and (cy2 >= py1) and (cy1 <= py2))
end