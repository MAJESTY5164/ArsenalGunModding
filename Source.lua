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
    Edit(g, n, v)
end

function mod(g)
    print('Modding ' .. g)
    Modify(g, "Bullets", 10)
    Modify(g, "FireRate", 0.011)
    Modify(g, "Auto", true)
    Modify(g, "RecoilControl", 0)
    Modify(g, "Ammo", 99999)
    Modify(g, "Spread", 0)
    Modify(g, "MaxSpread", 0)
end

getgenv().modlite = function(g)
    print('Modding ' .. g)
    Modify(g, "FireRate", 0.011)
    Modify(g, "Auto", true)
    Modify(g, "RecoilControl", 0)
    Modify(g, "Ammo", 99999)
    Modify(g, "Spread", 0)
    Modify(g, "MaxSpread", 0)
end

getgenv().modall = function()
    local weapons = game:GetService("ReplicatedStorage").Weapons:GetChildren()
    for i = 1, #weapons do
        mod(weapons[i].Name)
    end
end

getgenv().modalllite = function()
    local weapons = game:GetService("ReplicatedStorage").Weapons:GetChildren()
    for i = 1, #weapons do
        modlite(weapons[i].Name)
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
        StoreInfo[#StoreInfo + 1] = Gun.MaxSpread.Value
    end
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
        Modify(g, "MaxSpread", StoreInfo[pos + 7])
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
    
    --  modall()
    --  modalllite()
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
