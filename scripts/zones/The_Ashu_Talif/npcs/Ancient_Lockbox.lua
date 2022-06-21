-----------------------------------
-- Area: The Ashu Talif
-- Ancient Lockbox
-----------------------------------
require("scripts/globals/appraisal")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lootNormal =
    {
        { -- Beastmen Coin - 35%
            {rate = 150, item = xi.items.MYTHRIL_BEASTCOIN},
            {rate = 150, item = xi.items.GOLD_BEASTCOIN},
            {rate =  50, item = xi.items.PLATINUM_BEASTCOIN},
        },
        { -- Beastmen Coin - 35%
            {rate = 300, item = xi.items.MYTHRIL_BEASTCOIN},
            {rate =  30, item = xi.items.GOLD_BEASTCOIN},
            {rate =  20, item = xi.items.PLATINUM_BEASTCOIN},
        },
        { -- HQ1/HQ2 Gem - 65%
            {rate = 55, item = xi.items.JADEITE},
            {rate = 75, item = xi.items.PERIDOT},
            {rate = 55, item = xi.items.ONYX},
            {rate = 75, item = xi.items.PAINITE},
            {rate = 55, item = xi.items.TURQUOISE},
            {rate = 75, item = xi.items.AQUAMARINE},
            {rate = 55, item = xi.items.LIGHT_OPAL},
            {rate = 75, item = xi.items.MOONSTONE},
            {rate = 55, item = xi.items.PEARL},
            {rate = 75, item = xi.items.BLACK_PEARL},
        },
        { -- HQ1/HQ2 Gem - 70%
            {rate = 40, item = xi.items.GOSHENITE},
            {rate = 60, item = xi.items.ZIRCON},
            {rate = 40, item = xi.items.SPHENE},
            {rate = 60, item = xi.items.CHRYSOBERYL},
            {rate = 40, item = xi.items.PEARL},
            {rate = 60, item = xi.items.BLACK_PEARL},
            {rate = 40, item = xi.items.PERIDOT},
            {rate = 60, item = xi.items.JADEITE},
            {rate = 40, item = xi.items.GARNET},
            {rate = 60, item = xi.items.SUNSTONE},
            {rate = 40, item = xi.items.AMETRINE},
            {rate = 60, item = xi.items.FLUORITE},
            {rate = 40, item = xi.items.ONYX},
            {rate = 60, item = xi.items.PAINITE},
        },
        { -- HQ3 Gem - 30%
            {rate = 60, item = xi.items.EMERALD},
            {rate = 60, item = xi.items.RUBY},
            {rate = 60, item = xi.items.SAPPHIRE},
            {rate = 60, item = xi.items.SPINEL},
            {rate = 60, item = xi.items.TOPAZ},
        },
        { -- HQ3 Gem - 20%
            {rate = 40, item = xi.items.EMERALD},
            {rate = 40, item = xi.items.RUBY},
            {rate = 40, item = xi.items.SAPPHIRE},
            {rate = 40, item = xi.items.SPINEL},
            {rate = 40, item = xi.items.TOPAZ},
        },
        { -- HQ1/HQ2/HQ3 Gems - 50%
            {rate = 50, item = xi.items.SPHENE},
            {rate = 75, item = xi.items.TOPAZ},
            {rate = 33, item = xi.items.ONYX},
            {rate = 50, item = xi.items.PAINITE},
            {rate = 33, item = xi.items.GOSHENITE},
            {rate = 50, item = xi.items.ZIRCON},
            {rate = 33, item = xi.items.GARNET},
            {rate = 50, item = xi.items.SUNSTONE},
            {rate = 50, item = xi.items.PEARL},
            {rate = 75, item = xi.items.ANGELSTONE},
        },
        { -- Moonstone/Deathstone - 20%
            {rate = 100, item = xi.items.DEATHSTONE},
            {rate = 100, item = xi.items.MOONSTONE},
        },
        { -- Start Sapphire - 5%
            {rate = 50, item = xi.items.STAR_SAPPHIRE},
        },
        { -- Koga Shuriken - 100%
            {rate = 1000, item = xi.items.KOGA_SHURIKEN},
        },
    }

    local lootExtra =
    {
        {
            {rate = 600, item = xi.items.UNAPPRAISED_BOX},
            {rate = 400, item = xi.items.UNAPPRAISED_DAGGER}
        }
    }

    local instance = player:getInstance()
    local instanceID = instance:getID()
    local chars = instance:getChars()
    local chestID = npc:getID()
    local lootTable

    if chestID == ID.npc.ANCIENT_LOCKBOX_EXTRA then
        lootTable = lootExtra
    else
        lootTable = lootNormal
    end

    if instance:completed() and npc:getLocalVar("open") == 0 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED + 2)
        else
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npc) npc:entityAnimationPacket("kesu") end)
            npc:timer(16000, function(npc) npc:setStatus(xi.status.DISAPPEAR) end)

            for _, lootGroup in pairs(lootTable) do
                local roll = math.random(1000)
                local sum = 0

                for _, entry in pairs(lootGroup) do
                    sum = sum + entry.rate
                    if roll <= sum then
                        if entry.item ~= nil then
                            if chestID == ID.npc.ANCIENT_LOCKBOX_EXTRA then
                                player:addItem({id = entry.item, appraisal = xi.appraisalUtil.Origin.SCOUTING_THE_ASHU_TALIF})
                                for _, char in pairs(chars) do
                                    char:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, entry.item)
                                end
                            else
                                player:addTreasure(entry.item, npc)
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
