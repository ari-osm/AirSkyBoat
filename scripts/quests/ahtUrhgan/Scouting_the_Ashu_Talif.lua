
-----------------------------------
-- Scouting the Ashu Talif
-- Halshaob, Nashmau , !pos 28.537 -7 -85.250 53
-- Cutter, Arrapago Reeff, !pos -462 -2 -394 54
-- Note: Currently, a quest cannot be "repeated" by using the log book status
--       so we are going to use the Prog var for logic.
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.GUESTS_OF_THE_EMPIRE
        end,

        [xi.zone.NASHMAU] =
        {
            ['Halshaob'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 1 and npcUtil.tradeHasExactly(trade, {{ xi.items.IMPERIAL_BRONZE_PIECE, 3 }}) then
                        player:confirmTrade()
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                        return quest:progressEvent(302, xi.items.IMPERIAL_BRONZE_PIECE, 3, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(301, 4092) -- arg1 = quests avaiable
                    else
                        return quest:progressEvent(300)
                    end
                end,
            },

            onEventFinish =
            {
                [300] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Quest accepted ro completed
    {
        check = function(player, status, vars)
            return status > QUEST_AVAILABLE
        end,

        [xi.zone.NASHMAU] =
        {
            ['Halshaob'] =
            {
                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 0 and npcUtil.tradeHasExactly(trade, {{ xi.items.IMPERIAL_BRONZE_PIECE, 3 }}) then
                        player:confirmTrade()
                        quest:setVar(player, 'Prog', 2)
                        return quest:progressEvent(302, xi.items.IMPERIAL_BRONZE_PIECE, 3, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(301, 4092, 0, 0, 2) -- arg4 = current quest
                    else
                        return quest:progressEvent(301, 4092, 0, 0, 0) -- no quest active
                    end
                end,
            },
        },
    },
}

return quest
