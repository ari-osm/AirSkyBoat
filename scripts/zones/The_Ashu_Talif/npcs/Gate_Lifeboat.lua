-----------------------------------
-- Area: The Ashu Talif
-- Gate: Lifeboat
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3 and option == 1 then
        player:startEvent(102)
    elseif csid == 102 then
        player:setPos(0, 0, 0, 0, 54)
    end
end

return entity
