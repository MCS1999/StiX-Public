local Lotto_Time = 0

local Seconds = 1000 * 1
local Minutes = Seconds * 60
local Hours   = Minutes * 60
local Days    = Hours * 24
local Weeks   = Days * 7
local Months  = Weeks * 4
local Years   = Months * 12

local PrizePool = nil


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        if Settings.Lotto.Enabled then
            StartCountDown()
        end
    end
end)

StartCountDown = function()
    while true do
        Lotto_Time = Lotto_Time + Settings.Lotto.Update
        local result = MySQL.Sync.fetchAll('SELECT * from taxes WHERE enabled = ?', { 1 })
        if result then
            for _, v in pairs(result) do
                local Time = v.time - Settings.Lotto.Update

                if v.time >= 1 then -- Lets Remove One Minute From Lotto Timer Im sure there are better ways to doing this. but imma noob ....
                    TriggerEvent('stix:taxes:logs', 'timer', 'Lottory Timer', 'blue', '`Time Remaining : ||'..Time..'|| Minute(s)`')

                    MySQL.update('UPDATE taxes SET time = ? WHERE enabled = 1', { Time }, function(affectedRows)
                        if affectedRows then
                            print('Succesfully Updated lotto time to ' .. Time)
                        end
                    end)

                    PrizePool = v.prize

                else
                    ChooseWinner(v.prize)
                    MySQL.update('UPDATE taxes SET time = ?, prize = 0 WHERE enabled = 1', { Settings.Lotto.Time }, function(affectedRows)
                        if affectedRows then
                            TriggerEvent('stix:taxes:logs', 'lotto', 'Lottory Reset', 'yellow', 'Lottery Has Ended and has been reset! Better Luck Next Time!')
                        end
                    end)
                end
            end
        end
        Wait(Settings.Lotto.Update * Minutes)
        Lotto_Time = 0
    end
end

local online = {}
ChooseWinner = function(prize)
    local players = Framework.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name ~= nil) then

            table.insert(online, k)
        end
    end

    local winner = math.random(1, #online)

    if winner then
        local Lucky = Framework.Functions.GetPlayer(online[winner])

        if Lucky then
            local WinnerName = Lucky.PlayerData.charinfo.firstname .. ' ' .. Lucky.PlayerData.charinfo.lastname
            if Settings.Addons.usingDiscord then
                DiscordId = '<@' .. Lucky.PlayerData.discord:gsub("discord:", "") .. '>'
            else
                DiscordId = 'Disabled'
            end
            Lucky.Functions.AddMoney('bank', prize)
            TriggerEvent('stix:taxes:logs', 'winners', 'Lottory Winner', 'green', '`Character :` **__'..WinnerName..'__** \n `Discord :` **'..DiscordId..'** \n `Jackpot :` ||$'..prize..'||', true)
            TriggerClientEvent('QBCore:Notify', -1, WinnerName..' Has Won the Lottery!!!! ($'..prize..')', 'success', 3000)
        end
        return
    end

end

-- TriggerEvent('stix:taxes:manageLotto', amount, action)
RegisterNetEvent('stix:taxes:manageLotto', function(amount, action)
    local amount = amount
    local action = action

    if not action then action = 'add' end -- default it to add

    if not PrizePool then PrizePool = 0 print('[Debug] - We cannot find the prize pool. reverted to default.') return end 

    if action == 'add' then
        if (PrizePool + amount) > Settings.Lotto.LimitPrice then print('[Debug] This is not a error but the lotto price did not increase because we have exceeded the set limit of $'..Settings.Lotto.LimitPrice) return end

        MySQL.update('UPDATE taxes SET prize = prize + ? WHERE enabled = 1', { amount }, function(affectedRows)
            if affectedRows then
                TriggerEvent('stix:taxes:logs', 'lotto', 'Lottory Added $', 'green', '**||$'..amount..'||** has been added to Lottery Total of $'..(PrizePool + amount)..'.')
            end
        end)

    elseif action == 'minus' then

        MySQL.update('UPDATE taxes SET prize = prize - ? WHERE enabled = 1', { amount }, function(affectedRows)
            if affectedRows then
                TriggerEvent('stix:taxes:logs', 'lotto', 'Lottory Removed $', 'red', '**||$'..amount..'||** has been removed from Lottery Total of $'..(PrizePool - amount)..'.')
            end
        end)
    end
end)