Settings = {}

Settings.Addons = { -- Addon Modules
    ['Cars'] = false, -- WIP Vehicle Taxes
    ['Property'] = false, -- WIP Property Taxes
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
    ['taxes'] = '',
    ['lotto'] = '',
    ['winners'] = '',
    ['timer'] = '',
    ['CityName'] = 'enter_city_name Taxes'
}