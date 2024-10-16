-----------------------------------
-- Horror Cloud
--
-- Description: A debilitating cloud slows the attack speed of a single target.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Can be overwritten and blocked by Haste.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLOW
    local noResist = 1

    -- 2 minute unresisted duration.
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1250, 0, 180, 0, 0, noResist))

    return typeEffect
end

return mobskillObject
