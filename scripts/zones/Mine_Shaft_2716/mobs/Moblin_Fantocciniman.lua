-----------------------------------
-- Area: Mine Shaft 2716
-- ENM: Pulling the Strings
-- NM: Moblin Fantocciniman
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:SetAutoAttackEnabled(false)
    mob:setMP(0)
end

entity.onMobEngaged = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 250) -- Roll dice every 25-35 seconds
    mob:showText(mob, ID.text.FANTOCCINIMAN_BASE)
end

entity.onMobFight = function(mob, target)
    if mob:getHP() < mob:getMaxHP() then
        mob:SetAutoAttackEnabled(true)
        mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    end
end

entity.onMobSkillTarget = function(target, mob, skill)
    local bfID = mob:getBattlefield():getArea()
    local fantoccini = GetMobByID(ID.mob[bfID].FANTOCCINI)
    local newTarget
    
    -- Force the skill on either Fantoccini or his target
    if skill:getID() < 1420 then
        newTarget = fantoccini:getTarget()
    else
        newTarget = fantoccini
    end

    return newTarget
end

entity.onMobDeath = function(mob, player, isKiller)
    -- Apply terror effect to Fantoccini and any pets
    local bfID = mob:getBattlefield():getArea()
    for i=0, 4 do
        local npc = GetMobByID(ID.mob[bfID].FANTOCCINI + i)
        if npc:isSpawned() then
            npc:addStatusEffect(xi.effect.TERROR, 0, 0, 900)
        end
    end
end

return entity
