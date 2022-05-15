Settings = {}



Settings.PayStations = { -- Add Physical Locations
    ['Enabled'] = false
}

Settings.AutoBill = { -- Bill Them on First Join.
    ['Enabled'] = true
}

Settings.Bracket = {
    ['LowerClass'] = {entry = 4000, percentage = 0.01}, -- 4k - 2%
    ['MiddleClass'] = {entry = 80000, percentage = 0.02}, -- 80k - 4%
    ['UpperClass'] = {entry = 400000, percentage = 0.03}, -- 400k - 6%
    ['TopClass'] = {entry = 1000000,  percentage = 0.04} -- 1mil - 8%
}

Settings.Lotto = {
    ['Enabled'] = true,
    ['LimitPrice'] = 2000000,
    ['Online'] = true,
    ['Time'] = 20160, -- Minutes  (2weeks of server uptime)
    ['Update'] = 5
}

