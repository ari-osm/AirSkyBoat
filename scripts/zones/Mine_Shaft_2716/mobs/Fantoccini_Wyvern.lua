-----------------------------------
-- Area: Mine Shaft 2716
-- ENM: Pulling the Strings
-- NM: Fantoccini Wyvern
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    local bfID = mob:getBattlefield():getArea()
    local master = GetMobByID(ID.mob[bfID].FANTOCCINI)

    master:timer(45000, function(masterArg)
        masterArg:setLocalVar("petSpawned", 0)
    end)
end

return entity
