local Webhooks = {
    ['taxes'] = 'https://discord.com/api/webhooks/974142286822772776/06YozR6Cvzl2HQcFNv9AqX5L_bIkoKJsUKqvZLvrBVcnAQyPN_T9tu6Ob5A5D4HHtn6Y',
    ['lotto'] = 'https://discord.com/api/webhooks/975270011142807552/nWUGhwTz9wzZoNz3_MrYmQqAGBC8c8I_WIcYsrYfevryilhdnQtue1352dn5eQ3inNIK',
    ['winners'] = 'https://discord.com/api/webhooks/975278036532486204/TUlkutQ3MkuKGsSBNJRBcHhrYUrjfqCSRvxszxWRse4BFJ6WP88Oyy8ZePXFLZuU6-GC',
    ['timer'] = 'https://discord.com/api/webhooks/975278221522243654/263HrT-3r1_6mAsSUWJ9YehjRmztXHWvQrNbdS5ZtjawE5Ms3NlFEcq2EFIkJzHGOUL-',
}

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
    local webHook = Webhooks[name] or Webhooks['default']
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

-- QBCore.Commands.Add('testLogs', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function(source, args)
--     TriggerEvent('stix:taxes:logs', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
-- end, 'god')
