-- how to use

--[[

Stat = "Ammo" -- FireRate | Auto | RecoilControl | Ammo | Spread | Bullets | MaxSpread | StoredAmmo | Speed%
Value = 999
getgenv().modstats(Stat, Value)
getgenv().resetstats(Stat)

getgenv().Bullets(Value)
getgenv().MagSize(Value)
getgenv().FireRate(Value)
getgenv().FireType(Value)
getgenv().Spread(Value)
getgenv().MaxSpread(Value)
getgenv().StoredAmmo(Value)
getgenv().WalkSpeed(Value)

getgenv().HitboxExpander (cannot be disabled)

getgenv().GetBanned (idk why you would use this lol)

--]]

-- check if in arsenal

currentgame = game.PlaceId
arsenalid = 286090429

if currentgame == arsenalid then

-- API
weapons = game:GetService("ReplicatedStorage"):WaitForChild("Weapons"):GetChildren()

getgenv().checkMS = function(weaponName) -- check MaxSpread
     specificWeapon = game:GetService("ReplicatedStorage"):WaitForChild("Weapons"):FindFirstChild(weaponName)
    if specificWeapon then
        return specificWeapon:FindFirstChild("MaxSpread") ~= nil
    end
    return false
end

getgenv().Edit = function(g, n, v)
    if g:FindFirstChild(n) and g[n]:IsA("ValueBase") then
        if n == "Total Spread" then
            g["Spread"].Value = v
            g["MaxSpread"].Value = v
        else
            g[n].Value = v
        end
    end
end

 StoreInfo = {} -- Store original weapon data
if #StoreInfo == 0 then
    for _, gun in ipairs(game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
        if gun:IsA("Folder") and gun.Name ~= "Standing" then
            table.insert(StoreInfo, {
                Name = gun.Name,
                Ammo = gun:FindFirstChild("Ammo") and gun.Ammo.Value,
                Auto = gun:FindFirstChild("Auto") and gun.Auto.Value,
                Bullets = gun:FindFirstChild("Bullets") and gun.Bullets.Value,
                FireRate = gun:FindFirstChild("FireRate") and gun.FireRate.Value,
                RecoilControl = gun:FindFirstChild("RecoilControl") and gun.RecoilControl.Value,
                Spread = gun:FindFirstChild("Spread") and gun.Spread.Value,
                MaxSpread = checkMS(gun.Name) and gun:FindFirstChild("MaxSpread") and gun.MaxSpread.Value or nil,
                StoredAmmo = gun:FindFirstChild("StoredAmmo") and gun.StoredAmmo.Value,
                ["Speed%"] = gun:FindFirstChild("Speed%") and gun["Speed%"].Value,
            })            
        end
    end
    print("Weapons have been saved")
end

MeleeDir = game.ReplicatedStorage.Melees:GetChildren()
Melees = {}
i = 0
while i < #MeleeDir do
    i += 1
    Melees[i] = tostring(MeleeDir[i])
end
PlayerSkinsDir = game.ReplicatedStorage.Obtainables:GetChildren()[1]:GetChildren()[1]
plrskins = {}
i = 0
while i < #PlayerSkinsDir:GetChildren() do
i += 1
plrskins[i] = tostring(PlayerSkinsDir:GetChildren()[i])
end
print("Arsenal Gun Mod module has loaded")

 function findInTable(tbl, name)
    for _, data in ipairs(tbl) do
        if data.Name == name then
            return data
        end
    end
    return nil
end

getgenv().Modifyweaponstat = function(fg, n, v)
    g = game:GetService("ReplicatedStorage").Weapons:WaitForChild(fg)
    if n == "MaxSpread" and checkMS(fg) then
        getgenv().Edit(g, n, v)
    else
        getgenv().Edit(g, n, v)
    end
end

getgenv().resetweaponstat = function(g, s)
    data = findInTable(StoreInfo, g)
    if data then
        print("Resetting " .. g .. " " .. s)
        for property, value in pairs(data) do
            if property == s then
                getgenv().Modifyweaponstat(g, property, value)
            end
        end
    end
end

-- UserFunctions

getgenv().modweaponstat = function(g, s, v)
    -- FireRate Auto RecoilControl Ammo Spread Bullets MaxSpread StoredAmmo Speed%
    print(('Modding gun: ' .. g .. " stat: " .. s .. " value: " .. tostring(v)))
    getgenv().Modifyweaponstat(g, s, v)
end

getgenv().resetstats = function(s)
    for _, weapon in ipairs(game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
        getgenv().resetweaponstat(weapon.Name, s)
    end
end

getgenv().modstats = function(s, v)
    for _, weapon in ipairs(game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
        if s == "Ammo" and v > 999 then v = 999 end
        if s == "Ammo" and v < 1 then v = 0 end
        if s == "FireRate" and v < 0.011 then v = 0.011 end
        if s == "Bullets" and v < 1 then v = 1 end
        if s == "Spread" and v < 0 then v = 0 end
        if s == "MaxSpread" and v < 0 then v = 0 end
        if s == "StoredAmmo" and v < 0 then v = 0 end
        getgenv().modweaponstat(weapon.Name, s, v)
    end
end

-- Indevidual Stats

getgenv().Bullets = function(v)
    if v ~= nil then getgenv().modstats("Bullets", v) end
end
getgenv().MagSize = function(v)
    if v ~= nil then getgenv().modstats("Ammo", v) end
end
getgenv().FireRate = function(v)
    if v ~= nil then getgenv().modstats("FireRate", v) end
end
getgenv().FireType = function(v)
    if v == true or v == false then getgenv().modstats("Auto", v) end
end
getgenv().Spread = function(v)
    if v ~= nil then getgenv().modstats("Spread", v) end
end
getgenv().MaxSpread = function(v)
    if v ~= nil then getgenv().modstats("MaxSpread", v) end
end
getgenv().StoredAmmo = function(v)
    if v ~= nil then getgenv().modstats("StoredAmmo", v) end
end
getgenv().Recoil = function(v)
    if v ~= nil then getgenv().modstats("RecoilControl", v) end
end
getgenv().WalkSpeed = function(v)
    if v ~= nil then getgenv().modstats("Speed%", v) end
end

-- Example
--[[

Stat = "Ammo" -- FireRate | Auto | RecoilControl | Ammo | Spread | Bullets | MaxSpread
Value = 999
getgenv().modstats(Stat, Value)
getgenv().resetstats(Stat)

--]]

-- more arsenal stuffz

-- hitbox expader
getgenv().HitboxExpander = function()
function getplrsname()
	for i,v in pairs(game:GetChildren()) do
		if v.ClassName == "Players" then
			return v.Name
		end
	end
end
local players = getplrsname()
local plr = game[players].LocalPlayer
coroutine.resume(coroutine.create(function()
	while  wait(1) do
		coroutine.resume(coroutine.create(function()
			for _,v in pairs(game[players]:GetPlayers()) do
				if v.Name ~= plr.Name and v.Character then
					v.Character.RightUpperLeg.CanCollide = false
					v.Character.RightUpperLeg.Transparency = 1
					v.Character.RightUpperLeg.Size = Vector3.new(10,10,10)

					v.Character.LeftUpperLeg.CanCollide = false
					v.Character.LeftUpperLeg.Transparency = 1
					v.Character.LeftUpperLeg.Size = Vector3.new(10,10,10)

					v.Character.HeadHB.CanCollide = false
					v.Character.HeadHB.Transparency = 1
					v.Character.HeadHB.Size = Vector3.new(30,30,30)

					v.Character.HumanoidRootPart.CanCollide = false
					v.Character.HumanoidRootPart.Transparency = 1
					v.Character.HumanoidRootPart.Size = Vector3.new(10,10,10)

				end
			end
		end))
	end
end))
end

getgenv().GetBanned = function()
    for _=1,100000 do
        game:GetService("ReplicatedStorage").Events.ReplicateProjectile:FireServer({"Baseball",0,Vector3.new(0,100,0),CFrame.new(),45,0,0,0,"Cone Launcher",Vector3.new(),false,{},1})
    end
end

getgenv().ListMelee = function()
    for i = 1, #Melees do
        print(Melees[i])
    end
end

getgenv().ListSkins = function()
    for i = 1, #plrskins do
        print(plrskins[i])
    end
end

getgenv().SetMelee = function(v)
    for _, value in ipairs(Melees) do
        if value == v then
            game:GetService("Players").LocalPlayer.Data.Melee.Value = v
        end
end
end

getgenv().SetSkin = function(v)
    for _, value in ipairs(plrskins) do
    print(value == v)
        if value == v then
            game:GetService("Players").LocalPlayer.Data.Skin.Value = v
        end
end
end

end
