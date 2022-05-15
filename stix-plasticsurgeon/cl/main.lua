local Framework = exports['qb-core']:GetCoreObject()
local PlayerData = Framework.Functions.GetPlayerData()
local doctorInSession = false

-- Sets the playerdata when spawned
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = Framework.Functions.GetPlayerData()
end)

-- Sets the playerdata to an empty table when the player has quit or did /logout
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- When the players job gets updated this will trigger and update the playerdata
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

-- When the players gang gets updated this will trigger and update the playerdata
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerData.gang = GangInfo
end)

-- This will update all the PlayerData that doesn't get updated with a specific event other than this like the metadata
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)


RegisterNetEvent('stix:surgeon:canpay',function()
    print('[Debug] Checking player in at surgeon.')
    Framework.Functions.Notify('Thank you for visiting Pillbox Finest Plastic Surgeon!', 'success', 5000)
    DoScreenFadeOut(5000)
    Wait(5000)
    SetEntityCoords(PlayerPedId(), 314.32, -568.23, 43.28, true, true, false, false)
    Wait(5000)
    DoScreenFadeIn(5000)
    Wait(3000)
    TriggerEvent('fivem-appearance:barberMenu')
end)

RegisterCommand('fadein', function()
    DoScreenFadeIn(1000)
end, false)

CreateThread(function()
    local mainPoly = {}
    mainPoly[#mainPoly+1] = BoxZone:Create(vector3(vector3(312.11, -592.86, 43.28)), 1.5, 1.5, {
        name="surgeon_01",
        debugPoly = false,
        heading = -20,
        minZ = 43.28 - 2,
        maxZ = 43.28 + 2,
    })

    local mainCombo = ComboZone:Create(mainPoly, {name = "mainPoly", debugPoly = false})
    mainCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            exports['qb-core']:DrawText('View Plastic Surgeon','left')
            KeyPressed()
        else
            exports['qb-core']:HideText()
        end
    end)
end)


KeyPressed = function()
    local using = false
    CreateThread(function()
        while not using do
            Wait(0)
            if IsControlJustPressed(0, 38) then
                print('[Debug]: KeyPressed.')
               TriggerServerEvent('stix:surgeon:canPay', PlayerData.source)
               using = true
            end 
        end
    end)
end