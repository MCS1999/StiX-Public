Framework = exports['qb-core']:GetCoreObject()
hasPaidTaxes = {}
hasOwnedVehicles = {}
hasOwnedProperties = {}
DiscordId = nil


RegisterNetEvent('stix:taxes:pay', function(source, cid)
    --print('start')
    local id = source
    local taxPayer = Framework.Functions.GetPlayer(id)

    -- Ensures taxPayer Gets Selected off one of the ids if the source does not go through for whatever reason.
    if not taxPayer then
        taxPayer = Framework.Functions.GetPlayerByCitizenId(cid)
    end
    local taxPayerId = taxPayer.PlayerData.citizenid
    local Bracket = Settings.Bracket
    local targetBracket = 'LowerClass'
    if Settings.Addons.usingDiscord then
        DiscordId = '<@' .. Lucky.PlayerData.discord:gsub("discord:", "") .. '>'
    else
        DiscordId = 'Disabled'
    end

    --print('Determine')
    -- Determine Bracket Placement.
    if taxPayer.PlayerData.money.bank <= Settings.Bracket['LowerClass'].entry then
        targetBracket = 'LowerClass'
    elseif taxPayer.PlayerData.money.bank >= Settings.Bracket['MiddleClass'].entry and taxPayer.PlayerData.money.bank < Settings.Bracket['UpperClass'].entry then
        targetBracket = 'MiddleClass'
    elseif taxPayer.PlayerData.money.bank >= Settings.Bracket['UpperClass'].entry and taxPayer.PlayerData.money.bank < Settings.Bracket['TopClass'].entry then
        targetBracket = 'UpperClass'
    elseif taxPayer.PlayerData.money.bank >= Settings.Bracket['TopClass'].entry then
        targetBracket = 'TopClass'
    end


    --print('Calculations')
    -- Tax Calculations.
    local tax = Framework.Shared.Round(taxPayer.PlayerData.money.bank * Bracket[targetBracket].percentage)
    local carCount = 0
    local propertyCount = 0
    --print('Getting Cars')
    if Settings.Addons.Cars then
        local result = MySQL.Sync.fetchAll('SELECT vehicle from player_vehicles WHERE citizenid = ?', { taxPayerId })

        if result then
            for i = 1, #result do
                carCount = carCount + 1
                local vehicle = result[i].vehicle

                if Settings.Addons.Cars.Prices[vehicle] then
                    tax = tax + Settings.Addons.Cars.Prices[vehicle]
                    Wait(4500)
                else
                    tax = tax + Settings.Addons.Cars.Prices['Base']
                    Wait(4500)
                end

            end
        end
    end

    --print('Check')

    -- Check wheter they have paid taxes within the same server session. if not then send the bill.
    if hasPaidTaxes[taxPayerId] then
    else
        taxPayer.Functions.RemoveMoney('bank', tax)
        TriggerEvent('stix:taxes:manageLotto', tax, 'add')
        if Settings.Addons.Cars.Enabled and not Settings.Addons.Property then
            TriggerEvent('stix:taxes:logs', 'taxes', Settings.Logs.CityName, 'black', '`Name :` **' .. taxPayer.PlayerData.charinfo.firstname .. ' ' .. taxPayer.PlayerData.charinfo.lastname .. '** \n `Taxes Paid :` **$' .. tax .. '** \n `Bracket :` **' .. targetBracket .. '** \n `Discord :`' .. DiscordId..' \n `Vehicles Taxed` :**'..carCount..'**')
            TriggerClientEvent('QBCore:Notify', taxPayer.PlayerData.source, 'You have paid - $' .. tax .. ' In Taxes. your tax bracket is - ' .. targetBracket, 'success', 7500)
            hasPaidTaxes[taxPayerId] = true
        elseif Settings.Addons.Cars.Enabled and Settings.Addons.Property then
            TriggerEvent('stix:taxes:logs', 'taxes', Settings.Logs.CityName, 'black', '`Name :` **' .. taxPayer.PlayerData.charinfo.firstname .. ' ' .. taxPayer.PlayerData.charinfo.lastname .. '** \n `Taxes Paid :` **$' .. tax .. '** \n `Bracket :` **' .. targetBracket .. '** \n `Discord :`' .. DiscordId..' \n `Vehicles Taxed` :**'..carCount..'** \n `Properties Taxed` :**'..propertyCount..'**')
            TriggerClientEvent('QBCore:Notify', taxPayer.PlayerData.source, 'You have paid - $' .. tax .. ' In Taxes. your tax bracket is - ' .. targetBracket, 'success', 7500)
            hasPaidTaxes[taxPayerId] = true
        elseif not Settings.Addons.Cars.Enabled and Settings.Addons.Property then
            TriggerEvent('stix:taxes:logs', 'taxes', Settings.Logs.CityName, 'black', '`Name :` **' .. taxPayer.PlayerData.charinfo.firstname .. ' ' .. taxPayer.PlayerData.charinfo.lastname .. '** \n `Taxes Paid :` **$' .. tax .. '** \n `Bracket :` **' .. targetBracket .. '** \n `Discord :`' .. DiscordId..' \n `Properties Taxed` :**'..propertyCount..'**')
            TriggerClientEvent('QBCore:Notify', taxPayer.PlayerData.source, 'You have paid - $' .. tax .. ' In Taxes. your tax bracket is - ' .. targetBracket, 'success', 7500)
            hasPaidTaxes[taxPayerId] = true
        else
            TriggerEvent('stix:taxes:logs', 'taxes', Settings.Logs.CityName, 'black', '`Name :` **' .. taxPayer.PlayerData.charinfo.firstname .. ' ' .. taxPayer.PlayerData.charinfo.lastname .. '** \n `Taxes Paid :` **$' .. tax .. '** \n `Bracket :` **' .. targetBracket .. '** \n `Discord :`' .. DiscordId)
            TriggerClientEvent('QBCore:Notify', taxPayer.PlayerData.source, 'You have paid - $' .. tax .. ' In Taxes. your tax bracket is - ' .. targetBracket, 'success', 7500)
            hasPaidTaxes[taxPayerId] = true
        end
    end

    --print('End')
    return
end)
