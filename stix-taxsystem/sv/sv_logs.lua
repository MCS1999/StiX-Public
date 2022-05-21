local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('stix:taxes:logs', function(name, title, color, message, tagEveryone)        
    local tag = tagEveryone or false
    local webHook = Settings.Logs[name]
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'Taxes & Lotto System',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/967260734360805427/975270718684143626/STixwrldLOGO.png',
            },
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'IRS', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'IRS', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)



Framework.Commands.Add('Taxes', 'Test Taxes Command.', {}, false, function(source, args)
    local src = source
    local test = Framework.Functions.GetPlayer(src)
    TriggerEvent('stix:taxes:pay', test.PlayerData.source, test.PlayerData.citizenid)
end, 'god')

Framework.Commands.Add('Taxes_2', 'Test Lotto Command. `/Taxes_2 add` to add lotto money and `/Taxes_2 minus` to remove lotto money', {}, false, function(source, args)
    if args[1] then
        TriggerEvent('stix:taxes:manageLotto', 100, args[1])
    else
        Debug('Invalid arugment')
    end
end, 'god')