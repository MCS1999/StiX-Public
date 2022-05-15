Framework = exports['qb-core']:GetCoreObject()
hasPaidTaxes = {}


RegisterNetEvent('stix:taxes:pay', function(source, cid)
    local id = source
    local taxPayer = Framework.Functions.GetPlayer(id)

    -- Ensures taxPayer Gets Selected off one of the ids if the source does not go through for whatever reason.
    if not taxPayer then
        taxPayer = Framework.Functions.GetPlayerByCitizenId(cid)
    end
    local taxPayerId = taxPayer.PlayerData.citizenid
    local Bracket = Settings.Bracket
    local targetBracket = 'LowerClass'
    local DiscordId = '<@' .. taxPayer.PlayerData.discord:gsub("discord:", "") .. '>'


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

    -- Tax Calculations.
    local tax = Framework.Shared.Round(taxPayer.PlayerData.money.bank * Bracket[targetBracket].percentage)

    -- Check wheter they have paid taxes within the same server session. if not then send the bill.
    if hasPaidTaxes[taxPayerId] then
        return
    else
        taxPayer.Functions.RemoveMoney('bank', tax)
        TriggerEvent('stix:taxes:manageLotto', tax, 'add')
        TriggerEvent('stix:taxes:logs', 'taxes', Settings.Logs.CityName, 'black', '`Name :` **' .. taxPayer.PlayerData.charinfo.firstname .. ' ' .. taxPayer.PlayerData.charinfo.lastname .. '** \n `Taxes Paid :` **$' .. tax .. '** \n `Bracket :` **' .. targetBracket .. '** \n `Discord :`' .. DiscordId)
        TriggerClientEvent('QBCore:Notify', taxPayer.PlayerData.source, 'You have paid - $' .. tax .. ' In Taxes. your tax bracket is - ' .. targetBracket, 'success', 7500)
        hasPaidTaxes[taxPayerId] = true
    end
end)
