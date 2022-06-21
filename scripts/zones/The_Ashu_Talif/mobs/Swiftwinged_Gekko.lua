-----------------------------------
-- Area: The Ashu Talif
--   NM: Swiftwinged Gekko
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
end

entity.onMobFight = function(mob, target)
    local mobPos = mob:getPos()

    if mobPos.x == 5.5 and mobPos.y == -31 and mobPos.z == 47 then
        mob:hideName(true)
        mob:untargetable(true)
        mob:setStatus(xi.status.INVISIBLE)
        mob:disengage()
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setPos(0.000, -22.500, 18.000)

        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
    end
end

entity.onCastStarting = function(mob, spell)
    mob:SetMagicCastingEnabled(false)
    mob:pathTo(5.500, -31.000, 47.000)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
