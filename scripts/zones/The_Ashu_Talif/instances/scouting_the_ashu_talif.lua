-----------------------------------
-- Scouting the Ashu Talif
-- !instance 6002
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/utils")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------
local instance_object = {}
local waves =
{
    {
        ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[4],
        ID.mob[55].CREW_RNG[5],
    },
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[4],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[3],
    },
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[3], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[1], ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[4],
    },
    {
        ID.mob[55].CREW_MNK[3], ID.mob[55].CREW_MNK[4], ID.mob[55].CREW_MNK[5], 
        ID.mob[55].CREW_RDM[1], ID.mob[55].CREW_RDM[3], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[4], ID.mob[55].CREW_RNG[5],
    },
    {
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    {
        ID.mob[55].IMP[1],
    },
    {
        ID.mob[55].IMP[2], ID.mob[55].IMP[3],
    },
    {
        ID.mob[55].IMP[1], ID.mob[55].IMP[2], ID.mob[55].IMP[3], ID.mob[55].IMP[4],
    },
    {
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    {
        ID.mob[55].CREW_MNK[1],
        ID.mob[55].CREW_RDM[2],
        ID.mob[55].CREW_RNG[3],
        ID.mob[55].IMP[1],
    },
    {
        ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[1],
        ID.mob[55].CREW_RNG[2],
        ID.mob[55].IMP[1],
    },
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[2], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[3],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    {
        ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[1], ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[3],
        ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    {
        ID.mob[55].CREW_MNK[2], ID.mob[55].CREW_MNK[5],
        ID.mob[55].CREW_RDM[3],
        ID.mob[55].CREW_RNG[1], ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[3],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    {
        ID.mob[55].CREW_MNK[3], ID.mob[55].CREW_MNK[4],
        ID.mob[55].CREW_RDM[1],
        ID.mob[55].CREW_RNG[2],
    },
    {
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[5],
        ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    {
        ID.mob[55].CREW_MNK[4], ID.mob[55].CREW_MNK[5],
        ID.mob[55].CREW_RDM[1], ID.mob[55].CREW_RDM[4],
        ID.mob[55].CREW_RNG[2], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[1], ID.mob[55].IMP[2],
    },
    {
        ID.mob[55].IMP[1], ID.mob[55].IMP[2], ID.mob[55].IMP[3],
        ID.mob[55].SWIFTWINGED_GEKKO,
    },
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[3],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[3],
        ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[5],
        ID.mob[55].IMP[2], ID.mob[55].IMP[3],
    },
    {
        ID.mob[55].CREW_MNK[1], ID.mob[55].CREW_MNK[2],
        ID.mob[55].CREW_RDM[2], ID.mob[55].CREW_RDM[4],
        ID.mob[55].CREW_RNG[3], ID.mob[55].CREW_RNG[4],
        ID.mob[55].IMP[1], ID.mob[55].IMP[4],
    },
}

instance_object.registryRequirements = function(player)
    --return player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF) == QUEST_ACCEPTED
    return utils.getQuestVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF, 'Prog', 2)
end

instance_object.entryRequirements = function(player)
    --return player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF) == QUEST_ACCEPTED
    return utils.getQuestVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF, 'Prog', 2)
end

instance_object.onInstanceCreated = function(instance)
    local mob = GetMobByID(ID.mob[55].SWIFTWINGED_GEKKO, instance)
    mob:spawn()
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setStatus(xi.status.INVISIBLE)
    instance:setProgress(1)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    utils.setQuestVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF, 'Prog', 0)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, char in pairs(chars) do
        char:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        char:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress == 1 then -- Wave 1
        spawnWave(1, instance)
    elseif progress == 4 then -- Wave 2
        instance:complete()
        -- spawnWave(2, instance)
    elseif progress == 9 then -- Wave 3
        spawnWave(3, instance)
    elseif progress == 18 then -- Wave 4
        spawnWave(4, instance)
    elseif progress == 27 then -- Wave 5
        spawnWave(5, instance)
    elseif progress == 28 then -- Wave 6
        spawnWave(6, instance)
    elseif progress == 29 then -- Wave 7
        spawnWave(7, instance)
    elseif progress == 31 then -- Wave 8
        spawnWave(8, instance)
    elseif progress == 35 then -- Wave 9
        giveTempItems(instance)
        spawnWave(9, instance)
    elseif progress == 36 then -- Wave 10
        spawnWave(10, instance)
    elseif progress == 40 then -- Wave 11
        spawnWave(11, instance)
    elseif progress == 44 then -- Wave 12
        spawnWave(12, instance)
    elseif progress == 52 then -- Wave 13
        spawnWave(13, instance)
    elseif progress == 60 then -- Wave 14
        spawnWave(14, instance)
    elseif progress == 69 then -- Wave 15
        spawnWave(15, instance)
    elseif progress == 73 then -- Wave 16
        giveTempItems(instance)
        spawnWave(16, instance)
    elseif progress == 74 then -- Wave 17
        spawnWave(17, instance)
    elseif progress == 82 then -- Wave 18
        spawnWave(18, instance)
    elseif progress == 90 then -- Wave 19
        spawnWave(19, instance)
    elseif progress == 94 then -- Wave 20
        spawnWave(20, instance)
    elseif progress == 102 then -- Wave 21
        spawnWave(21, instance)
    elseif progress == 110 and instance:completed() == false then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    local mob = GetMobByID(ID.mob[55].SWIFTWINGED_GEKKO, instance)
    local players = instance:getChars()
    
    for i, player in pairs(players) do
        player:messageSpecial(ID.text.OBJECTIVE_COMPLETE)
        player:completeQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.SCOUTING_THE_ASHU_TALIF)
    end

    -- Spawn exit and chest(s)
    instance:getEntity(bit.band(ID.npc.LIFEBOAT, 0xFFF), xi.objType.NPC):openDoor()
    instance:getEntity(bit.band(ID.npc.GATE_LIFEBOAT, 0xFFF), xi.objType.NPC):setUntargetable(false)
    instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), xi.objType.NPC):setStatus(xi.status.NORMAL)
    if not mob:isSpawned() then
        instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX_EXTRA, 0xFFF), xi.objType.NPC):setStatus(xi.status.NORMAL)
    end
end

function spawnWave(wave, instance)
    for i, mobID in pairs(waves[wave]) do
        local mob = GetMobByID(mobID, instance)

        if mobID == ID.mob[55].SWIFTWINGED_GEKKO then
            if mob:isSpawned() then
                -- Give a random person hate
                local chars = instance:getChars()
                mob:addEnmity(chars[math.random(#chars)], 0, 1)

                -- Show mob
                mob:hideName(false)
                mob:setUntargetable(false)
                mob:setStatus(xi.status.UPDATE)
                mob:setMobMod(xi.mobMod.NO_MOVE, 0)
                
                -- Delay casting
                mob:timer(1000, function(mob)
                    if mob:isSpawned() then
                        mob:SetMagicCastingEnabled(true)
                    end
                end)
            else
                instance:setProgress(instance:getProgress() + 1)
            end
        else
            mob:timer(2000, function(mob)
                if not mob:isSpawned() then
                    mob:spawn()
                    mob:SetMobSkillAttack(0)
                    mob:setMobMod(xi.mobMod.LINK_RADIUS, 30)
                    mob:addMod(xi.mod.ATTP, -50)
                    mob:addMod(xi.mod.RATTP, -50)
                    mob:addMod(xi.mod.MATT, -25)
                else
                    instance:setProgress(instance:getProgress() + 1) -- If the mob can't spawn, then just increase the counter
                end
            end)
        end
    end
end

function giveTempItems(instance)
    local chars = instance:getChars()
    for i, player in pairs(chars) do
        player:messageSpecial(ID.text.BAG_FEELS_HEAVIER)

        if not player:hasItem(xi.items.DAEDALUS_WING, 3) then
            player:addTempItem(xi.items.DAEDALUS_WING, 1)
        end
        if not player:hasItem(xi.items.VILE_ELIXER_I, 3) then
            player:addTempItem(xi.items.VILE_ELIXER_I, 1)
        end
        if not player:hasItem(xi.items.REVITALIZER, 3) then
            player:addTempItem(xi.items.REVITALIZER, 1)
        end

        if player:getMainJob() == xi.job.DRG and not player:hasItem(xi.items.VIAL_OF_DRACHENESSENCE, 3) then
            player:addTempItem(xi.items.VIAL_OF_DRACHENESSENCE, 1)
        elseif player:getMainJob() == xi.job.BST and not player:hasItem(xi.items.PET_FOOD_ZETA, 3) then
            player:addTempItem(xi.items.PET_FOOD_ZETA, 1)
        end
    end
end

return instance_object
