-----------------------------------
-- ID: 5246
-- Item: Vial of Drachenessence
-- Item Effect: Instantly restores 25% of pet HP
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/pets")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if not target:hasPet() or target:getPetID() ~= xi.pet.id.WYVERN then
        return xi.msg.basic.REQUIRES_A_PET
    end
    return 0
end

item_object.onItemUse = function(target)
    local pet = target:getPet()
    local totalHP = pet:getMaxHP() / 4
    pet:addHP(totalHP)
    pet:messageBasic(xi.msg.basic.RECOVERS_HP, 0, totalHP)
end

return item_object
