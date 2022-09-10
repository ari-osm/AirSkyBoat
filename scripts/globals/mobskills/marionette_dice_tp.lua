-----------------------------------
-- Marionette Dice (6 & 8)
--
-- Description: Gives 1000 TP to target
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
    target:addTP(1000)

    skill:setMsg(xi.msg.basic.TP_INCREASE)

    return target:getTP()
end

return mobskill_object
