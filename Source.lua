 if getgenv().ArsenalModsLoaded == nil then
local weapons = game:GetService("ReplicatedStorage"):WaitForChild("Weapons"):GetChildren()

-- Function to check if a weapon has "MaxSpread" based on the weapon's name
local function checkMS(weaponName)
    -- Find the weapon in the "Weapons" folder by name
    local specificWeapon = game:GetService("ReplicatedStorage"):WaitForChild("Weapons"):FindFirstChild(weaponName)
    
    -- If the weapon exists, check if it has "MaxSpread"
    if specificWeapon then
        local maxSpreadChild = specificWeapon:FindFirstChild("MaxSpread")
        return maxSpreadChild ~= nil -- Return true if "MaxSpread" exists, false otherwise
    else
        return false -- Return false if the weapon doesn't exist
    end
end


Moddingtemplate = {
    "Gun",
    "Bullets",
    "FireRate",
    "Auto",
    "RecoilControl",
    "Ammo",
    "Spread",
    "MaxSpread"
}

function Edit(g, n, v)
    if g:FindFirstChild(n) and g[n]:IsA("ValueBase") then
        g[n].Value = v
    else
        warn(g.Name .. ' does not have a value for "' .. n .. '"')
    end
end

function Modify(fg, n, v)
    local g = game:GetService("ReplicatedStorage").Weapons:WaitForChild(fg)
    if n == "MaxSpread" then
        if checkMS(fg) then
        Edit(g, n, v)
        end
    else
        Edit(g, n, v)
    end
end

getgenv().mod = function(g, v)
    if v == nil then
    print('Modding' .. g)
    else
    print('Modding ' .. g.. " with ".. v)
    end
    Modify(g, "FireRate", 0.011)
    Modify(g, "Auto", true)
    Modify(g, "RecoilControl", 0)
    Modify(g, "Ammo", 999)
    Modify(g, "Spread", 0)
    if v ~= nil then
    Modify(g, "Bullets", v)
    else
    Modify(g, "MaxSpread", 0)
    end
end

getgenv().modall = function(v)
    local weapons = game:GetService("ReplicatedStorage").Weapons:GetChildren()
    for i = 1, #weapons do
        if v ~= nil then
        mod(weapons[i].Name, v)
        else
        mod(weapons[i].Name)
        end
    end
end

getgenv().modSpecific = function(Modding)
    print('Modding ' .. Modding["Gun"])
    for i = 1, 8 do
        if Moddingtemplate[i] ~= "Gun" then
            if Modding[Moddingtemplate[i]] ~= nil then
                print(Moddingtemplate[i] .. " " .. tostring(Modding[Moddingtemplate[i]]))
                Modify(Modding["Gun"], Moddingtemplate[i], Modding[Moddingtemplate[i]])
            end
        end
    end
end

StoreInfo = {}

if #StoreInfo == 3 then

for i = 1, #game:GetService("ReplicatedStorage").Weapons:GetChildren() do
    local Gun = game:GetService("ReplicatedStorage").Weapons:GetChildren()[i]
    if tostring(Gun) ~= "Standing" then
        StoreInfo[#StoreInfo + 1] = Gun
        StoreInfo[#StoreInfo + 1] = Gun.Ammo.Value
        StoreInfo[#StoreInfo + 1] = Gun.Auto.Value
        StoreInfo[#StoreInfo + 1] = Gun.Bullets.Value
        StoreInfo[#StoreInfo + 1] = Gun.FireRate.Value
        StoreInfo[#StoreInfo + 1] = Gun.RecoilControl.Value
        StoreInfo[#StoreInfo + 1] = Gun.Spread.Value
        if checkMS(Gun) then
        StoreInfo[#StoreInfo + 1] = Gun.MaxSpread.Value
        else
            StoreInfo[#StoreInfo + 1] = nil
        end
    end
end
print("Weapons have been saved")
end
print("Arsenal Gun Mod modual has loaded")

local function findInTable(table, name)
    for i = 1, #table, 6 do
        if table[i].Name == name then
            return i
        end
    end
    return nil
end

getgenv().reset = function(g)
    local pos = findInTable(StoreInfo, g)
    if pos then
        print("Resetting " .. g)
        Modify(g, "Bullets", StoreInfo[pos + 3])
        Modify(g, "FireRate", StoreInfo[pos + 4])
        Modify(g, "Auto", StoreInfo[pos + 2])
        Modify(g, "RecoilControl", StoreInfo[pos + 5])
        Modify(g, "Ammo", StoreInfo[pos + 1])
        Modify(g, "Spread", StoreInfo[pos + 6])
        if checkMS(g) then
        Modify(g, "MaxSpread", StoreInfo[pos + 7])
        end
    else
        warn("Gun not found: " .. g)
    end
end

 getgenv().resetall = function()
    local weapons = game:GetService("ReplicatedStorage").Weapons:GetChildren()
    for i = 1, #weapons do
        reset(weapons[i].Name)
    end
end
end
    
    --  modall()
    --  mod(Gun)
    --  resetall()
    --  reset(Gun)
    --[[
    Modding = {
    Gun = "DBS",
    Bullets = 100, --Bullets per shot
    FireRate = 0.011, --Minimum is 0.011
    Auto = true,
    Recoil = 0,
    Ammo = 999,
    Spread = 0,
    MaxSpread = 0
    }
    ModSpecific()
    --]]
