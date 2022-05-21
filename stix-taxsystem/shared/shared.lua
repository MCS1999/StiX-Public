Settings = {}

Settings.Addons = { -- Addon Modules
    ['Cars'] = {
        ['Enabled'] = true,
        ['Prices'] = {
            ['Base'] = 250, -- Leave this, this will be the base price for cars not listed below.
            
            ---------------------------------------------------------------------------------------

            ['oracle2'] = 1000, -- Model Name and how much the car cost into taxes.
        }
    }, -- WIP Vehicle Taxes
    ['Property'] = true, -- WIP Property Taxes
    ['usingDiscord'] = false, -- If using the discord api attacthment from the ReadMe then enable else disable.
}

Settings.Bracket = {-- Tax Bracket Settings. Do Not Add or Remove Brackets, Only Alter `entry` and `percentage`.
    ['LowerClass'] = {entry = 20000, percentage = 0.01}, -- 1%
    ['MiddleClass'] = {entry = 80000, percentage = 0.02}, -- 2%
    ['UpperClass'] = {entry = 200000, percentage = 0.03}, -- 3%
    ['TopClass'] = {entry = 800000,  percentage = 0.04}, -- 4%
}

Settings.Lotto = { -- Lottery Settings - this uses money from 
    ['Enabled'] = true,
    ['LimitPrice'] = 2000000,
    ['Time'] = 20160, -- Minutes  (2weeks of server uptime)
    ['Update'] = 5
}

Settings.Logs = {
    ['taxes'] = 'https://discord.com/api/webhooks/977437110896295966/4REY1nloiNW4_g6n5VFsoKZy6L8FQgopHBlqy7Fab_tmOkAj4dtCGqX34kQLkzTcJy8s',
    ['lotto'] = 'https://discord.com/api/webhooks/977437110896295966/4REY1nloiNW4_g6n5VFsoKZy6L8FQgopHBlqy7Fab_tmOkAj4dtCGqX34kQLkzTcJy8s',
    ['winners'] = 'https://discord.com/api/webhooks/977437110896295966/4REY1nloiNW4_g6n5VFsoKZy6L8FQgopHBlqy7Fab_tmOkAj4dtCGqX34kQLkzTcJy8s',
    ['timer'] = 'https://discord.com/api/webhooks/977437110896295966/4REY1nloiNW4_g6n5VFsoKZy6L8FQgopHBlqy7Fab_tmOkAj4dtCGqX34kQLkzTcJy8s',
    ['CityName'] = 'enter_city_name Taxes'
}