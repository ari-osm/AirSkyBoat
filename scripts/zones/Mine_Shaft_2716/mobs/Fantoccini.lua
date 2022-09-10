-----------------------------------
-- Area: Mine Shaft 2716
-- ENM: Pulling the Strings
-- NM: Fantoccini
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local jobTable =
{
    [xi.job.WAR] =
    {
        modelId = 1209,
        skills = {64, 65, 66, 67, 68, 69, 70},
        ability = 0, -- warcry
        spellListId = 0,
        petId = 0,
    },
    [xi.job.MNK] =
    {
        modelId = 1210,
        skills = {1, 2, 3, 4, 5, 6, 7},
        ability = 0, -- ???
        spellListId = 0,
        petId = 0,
    },
    [xi.job.WHM] =
    {
        modelId = 1214,
        skills = {160, 161, 162, 163, 164, 165, 166},
        ability = 0, -- ???
        spellListId = 1,
        petId = 0,
    },
    [xi.job.BLM] =
    {
        modelId = 1215,
        skills = {160, 161, 162, 163, 164, 165, 166},
        ability = 0, -- ???
        spellListId = 2,
        petId = 0,
    },
    [xi.job.RDM] =
    {
        modelId = 1216,
        skills = {32, 33, 34, 35, 36, 37, 38},
        ability = 0, -- ???
        spellListId = 3,
        petId = 0,
    },
    [xi.job.THF] =
    {
        modelId = 1218,
        skills = {16, 17, 18, 19, 20, 23},
        ability = 0, -- ???
        spellListId = 0,
        petId = 0,
    },
    [xi.job.PLD] =
    {
        modelId = 1219,
        skills = {32, 33, 34, 35, 36, 37, 38, 40},
        ability = 0, -- ???
        spellListId = 4,
        petId = 0,
    },
    [xi.job.DRK] =
    {
        modelId = 1220,
        skills = {96, 97, 98, 99, 100, 101, 102},
        ability = 0, -- weapon bash
        spellListId = 5,
        petId = 0,
    },
    [xi.job.BST] =
    {
        modelId = 1224,
        skills = {4, 65, 66, 67, 68, 69, 70},
        ability = 0, -- ???
        spellListId = 0,
        petId = 1,
    },
    [xi.job.BRD] =
    {
        modelId = 1227,
        skills = {16, 17, 18, 19, 20},
        ability = 0, -- ???
        spellListId = 6,
        petId = 0,
    },
    [xi.job.RNG] =
    {
        modelId = 1228,
        skills = {192, 193, 194, 195, 196, 197},
        ability = 0, -- barrage
        spellListId = 0,
        petId = 0,
    },
    [xi.job.SAM] =
    {
        modelId = 1229,
        skills = {144, 145, 146, 147, 148, 149, 150},
        ability = 0, -- meditate
        spellListId = 0,
        petId = 0,
    },
    [xi.job.NIN] =
    {
        modelId = 1232,
        skills = {128, 129, 130, 131, 132, 133, 134},
        ability = 0, -- ???
        spellListId = 7,
        petId = 0,
    },
    [xi.job.DRG] =
    {
        modelId = 1234,
        skills = {112, 113, 114, 115, 116, 117, 118},
        ability = 0, -- ???
        spellListId = 0,
        petId = 2,
    },
    [xi.job.SMN] =
    {
        modelId = 1235,
        skills = {176, 177, 179, 181},
        ability = 0, -- ???
        spellListId = 0,
        petId = 3,
    },
    [xi.job.BLU] =
    {
        modelId = 1396,
        skills = {32, 33, 34, 35, 36, 37, 38, 40},
        ability = 0, -- ???
        spellListId = 8,
        petId = 0,
    },
    [xi.job.COR] =
    {
        modelId = 1397,
        skills = {16, 17, 18},
        ability = 0, -- chaos roll
        spellListId = 0,
        petId = 0,
    },
    [xi.job.PUP] =
    {
        modelId = 1398,
        skills = {1, 2, 3, 4, 5, 6, 7},
        ability = 0, -- ???
        spellListId = 0,
        petId = 4,
    },
}

local function spawnPet(mob)
    if mob:getLocalVar("petSpawned") == 0 and mob:getLocalVar("petId") > 0 then
        mob:setLocalVar("petSpawned", 1)
        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:timer(3000, function(mobArg)
            if mobArg:isAlive() then
                local pet = GetMobByID(mobArg:getID() + mobArg:getLocalVar("petId"))
                local pos = mobArg:getPos()
                pet:setSpawn(pos.x, pos.y, pos.z, pos.rot)
                pet:spawn()
                mobArg:entityAnimationPacket("shsm")
                mobArg:SetAutoAttackEnabled(true)
                mobArg:SetMagicCastingEnabled(true)
                mobArg:SetMobAbilityEnabled(true)
            end
        end)
    end
end

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    -- Give some time for the ENM to be set up
    mob:timer(3000, function(mobArg)
        local battlefieldPlayers = mobArg:getBattlefield():getPlayers()
        local job = battlefieldPlayers[1]:getMainJob()

        mobArg:changeJob(job)
        mobArg:setModelId(jobTable[job].modelId)
        mobArg:setLocalVar("petId", jobTable[job].petId)
        mobArg:setLocalVar("petSpawned", 0)
        mobArg:setSpellList(jobTable[job].spellListId)
    end)
end

entity.onMobFight = function(mob, target)
    spawnPet(mob)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local job = mob:getMainJob()
    local randomnumber = math.random(1,#jobTable[job].skills)
    local skillId = jobTable[job].skills[randomnumber]

    --mob:changeJob(13)

    print(string.format("JOB: %s.", job))
    print(string.format("RAND: %s", randomnumber))
    print(string.format("SKILLID: %s", skillId))

    return skillId
end

entity.onMobDeath = function(mob, player, isKiller)
    -- Despawn other mobs to complete ENM
    local bfID = mob:getBattlefield():getArea()
    if GetMobByID(ID.mob[bfID].MOBLIN_FANTOCCINIMAN):isSpawned() then
        DespawnMob(ID.mob[bfID].MOBLIN_FANTOCCINIMAN)
    end

    local petId = mob:getLocalVar("petId")
    if petId > 0 then
        if GetMobByID(petId):isSpawned() then
            DespawnMob(petId)
        end
    end
end

return entity
