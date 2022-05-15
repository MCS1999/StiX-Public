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
    ['taxes'] = 'https://discord.com/api/webhooks/974142286822772776/06YozR6Cvzl2HQcFNv9AqX5L_bIkoKJsUKqvZLvrBVcnAQyPN_T9tu6Ob5A5D4HHtn6Y',
    ['lotto'] = 'https://discord.com/api/webhooks/975270011142807552/nWUGhwTz9wzZoNz3_MrYmQqAGBC8c8I_WIcYsrYfevryilhdnQtue1352dn5eQ3inNIK',
    ['winners'] = 'https://discord.com/api/webhooks/975278036532486204/TUlkutQ3MkuKGsSBNJRBcHhrYUrjfqCSRvxszxWRse4BFJ6WP88Oyy8ZePXFLZuU6-GC',
    ['timer'] = 'https://discord.com/api/webhooks/975278221522243654/263HrT-3r1_6mAsSUWJ9YehjRmztXHWvQrNbdS5ZtjawE5Ms3NlFEcq2EFIkJzHGOUL-',
}