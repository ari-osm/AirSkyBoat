-----------------------------------
-- Marionette Dice (2 & 12)
--
-- Description: Benediction for target
-- Type: Magical
--
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local heal = target:getMaxHP() - target:getHP()
    target:addHP(heal)
    target:wakeUp()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return heal
end

return mobskill_object
