# Welcome, Thank you for downloading a ColdStiX Development Product. 

# This Product Is Free! and you may edit it how you please. but do not sell it this is Licensed under GNU General Public License v3.0


# Instructions #

1. In `qb-core>server>player.lua` around line 44 Place this in the function `CheckPlayerData`

```lua
function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    PlayerData.source = source
    PlayerData.citizenid = PlayerData.citizenid or QBCore.Player.CreateCitizenId()
    PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
    PlayerData.discord = PlayerData.discord or QBCore.Functions.GetIdentifier(source, 'discord') <-- Add this in
    PlayerData.name = GetPlayerName(source)
    PlayerData.cid = PlayerData.cid or 1
    PlayerData.money = PlayerData.money or {}
    PlayerData.optin = PlayerData.optin or true

```

2. Run the sql

3. Configure the Shared.lua in the `shared` folder.


# Documentation #

*There is not much to do in here its pretty drag and drop ~~almost~~*
```lua
    TriggerEvent('stix:taxes:manageLotto', amount, action) -- Server Trigger (Recommended)
    TriggerServerEvent('stix:taxes:manageLotto', amount, action) -- Client Trigger
    -- Amount : the amount of money to add into the lotto. the taxes automatically get placed into the Lottery Pool. but if you want to integrate it with any other sources you may use the event to add or remove to it.

    -- Action : `add` - Adds to the current Lottery Pool. `remove` - Removes from the current Lottery Pool.
```

```lua
    TriggerEvent('stix:taxes:pay', source, cid) -- Server Trigger (Recommended)
    TriggerServerEvent('stix:taxes:pay', source, cid) -- Client Trigger

    -- Source : This is the players source id, this will be used to identify the players money,bank to determine taxes the logic is all handled automatically. all you need to do it place this where you want this to trigger (this has a automatic built in system to only charge 1x per restart of server.)

    -- cid : this is the players citizenid. this is a failsafe and is required if source cannot be found then it will use the cid to search player this is again a failsafe to allow fool proofing of the script.

# About Me

- Discord : ColdStiX#1906

- Experience : 7+ Years of FiveM Development (On and Off)

- Languages Known : CPP, CS, JS, LUA, HTML, CSS

- Games I Play : Insurgency Sandstorm, FiveM, BF2042 ... thats all I might get No Mans Sky.

# Support

- Discord : https://discord.gg/VjRVvJRpqX Looking for active developer looking to expand and show case free and or private work here. and bring in more people with like minds and share ideas.

- Donation : https://ko-fi.com/coldstix Anything Helps. Looking to Get a new pc for better development so your kindness is helpful. but my main goal is to bring more fun and enjoyable uniuqe scripts for all communities.