if getgenv().ArsenalModsLoaded == nil then
     weapons = game:GetService("ReplicatedStorage"):WaitForChild("Weapons"):GetChildren()
    
    -- Function to check if a weapon has "MaxSpread"
     function checkMS(weaponName)
         specificWeapon = game:GetService("ReplicatedStorage"):WaitForChild("Weapons"):FindFirstChild(weaponName)
        if specificWeapon then
            return specificWeapon:FindFirstChild("MaxSpread") ~= nil
        end
        return false
    end

    -- Define modding template
     Moddingtemplate = {
        "Gun", "Bullets", "FireRate", "Auto", "RecoilControl", "Ammo", "Spread", "MaxSpread"
    }

    -- Function to edit weapon properties
     function Edit(g, n, v)
        if g:FindFirstChild(n) and g[n]:IsA("ValueBase") then
            g[n].Value = v
        else
            warn(g.Name .. ' does not have a value for "' .. n .. '"')
        end
    end

    -- Function to modify a weapon property
     function Modify(fg, n, v)
         g = game:GetService("ReplicatedStorage").Weapons:WaitForChild(fg)
        if n == "MaxSpread" and checkMS(fg) then
            Edit(g, n, v)
        elseif n ~= "MaxSpread" then
            Edit(g, n, v)
        end
    end

    -- Function to apply mods to a weapon
    getgenv().mod = function(g, v)
        print(v and ('Modding ' .. g .. " with " .. v .. " bullets per shot") or ("Modding " .. g))
        Modify(g, "FireRate", 0.011)
        Modify(g, "Auto", true)
        Modify(g, "RecoilControl", 0)
        Modify(g, "Ammo", 999)
        Modify(g, "Spread", 0)
        if v then
            Modify(g, "Bullets", v)
        else
            Modify(g, "MaxSpread", 0)
        end
    end

    -- Function to apply mods to all weapons
    getgenv().modall = function(v)
        for _, weapon in ipairs(game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
            mod(weapon.Name, v)
        end
    end

    -- Function to apply specific mods
    getgenv().modSpecific = function(Modding)
        print('Modding ' .. Modding["Gun"])
        for _, property in ipairs(Moddingtemplate) do
            if property ~= "Gun" and Modding[property] ~= nil then
                print(property .. " " .. tostring(Modding[property]))
                Modify(Modding["Gun"], property, Modding[property])
            end
        end
    end

    -- Store original weapon data
     StoreInfo = {}
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
                    MaxSpread = checkMS(gun.Name) and gun:FindFirstChild("MaxSpread") and gun.MaxSpread.Value or nil
                })
            end
        end
        print("Weapons have been saved")
    end
    print("Arsenal Gun Mod module has loaded")

    -- Function to find weapon in StoreInfo
     function findInTable(tbl, name)
        for _, data in ipairs(tbl) do
            if data.Name == name then
                return data
            end
        end
        return nil
    end

    -- Function to reset weapon mods
    getgenv().reset = function(g)
         data = findInTable(StoreInfo, g)
        if data then
            print("Resetting " .. g)
            for property, value in pairs(data) do
                if property ~= "Name" then
                    Modify(g, property, value)
                end
            end
        else
            warn("Gun not found: " .. g)
        end
    end

    -- Function to reset all weapon mods
    getgenv().resetall = function()
        for _, weapon in ipairs(game:GetService("ReplicatedStorage").Weapons:GetChildren()) do
            reset(weapon.Name)
        end
    end
end
