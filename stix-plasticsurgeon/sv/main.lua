local Framework = exports['qb-core']:GetCoreObject()
local hasBeenSeen = {}
RegisterNetEvent('stix:surgeon:canPay', function(source)
    local src = source

    if not src then
        print('[Debug]: No Source Found')
        return
    else
        print(src)
    end

    local player = Framework.Functions.GetPlayer(src)

    if player.PlayerData.money.bank >= 1000 and not hasBeenSeen[player.PlayerData.citizenid] then
        player.Functions.RemoveMoney('bank', 1000)
        exports['qb-management']:AddMoney('ambulance', 1000)
        TriggerClientEvent('stix:surgeon:canpay',player.PlayerData.source)
    elseif player.PlayerData.money.cash >= 1000 and not hasBeenSeen[player.PlayerData.citizenid] then
        player.Functions.RemoveMoney('cash', 1000)
        exports['qb-management']:AddMoney('ambulance', 1000)
        TriggerClientEvent('stix:surgeon:canpay',player.PlayerData.source)
    end
end)

Framework.Functions.CreateCallback('stix:paramedic:fee', function(source, cb, fee)
    local src = source
    local player = Framework.Functions.GetPlayer(src)

    if player.PlayerData.money.bank >= fee then
        player.Functions.RemoveMoney('bank', fee)
        exports['qb-management']:AddMoney('ambulance', fee)
        cb(true)
    elseif player.PlayerData.money.cash >= fee then
        player.Functions.RemoveMoney('cash', fee)
        exports['qb-management']:AddMoney('ambulance', fee)
        cb(true)
    else
        cb(false)
    end
end)