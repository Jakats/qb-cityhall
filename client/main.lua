local inCityhallPage = false
local qbCityhall = {}
local dmvrequest = false
local weaponrequest = false
local boatingrequest = false
local planerequest = false

qbCityhall.Open = function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    inCityhallPage = true
end

qbCityhall.Close = function()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
    inCityhallPage = false
end

qbCityhall.DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    inCityhallPage = false
end)

local inRange = false

Citizen.CreateThread(function()
    CityhallBlip = AddBlipForCoord(Config.Cityhall.coords)

    SetBlipSprite (CityhallBlip, 487)
    SetBlipDisplay(CityhallBlip, 4)
    SetBlipScale  (CityhallBlip, 0.65)
    SetBlipAsShortRange(CityhallBlip, true)
    SetBlipColour(CityhallBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("City Services")
    EndTextCommandSetBlipName(CityhallBlip)
end)

local creatingCompany = false
local currentName = nil
Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        inRange = false

        local dist = #(pos - Config.Cityhall.coords)
        local dist2 = #(pos - Config.DrivingSchool.coords)
        local dist3 = #(pos - Config.WeaponSchool.coords)
        local dist4 = #(pos - Config.BoatingSchool.coords)
        local dist5 = #(pos - Config.FlyingSchool.coords)

        if dist < 20 then
            inRange = true
            DrawMarker(2, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if #(pos - vector3(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z)) < 1.5 then
                qbCityhall.DrawText3Ds(Config.Cityhall.coords, '~g~E~w~ - City Services Menu')
                if IsControlJustPressed(0, 38) then
                    qbCityhall.Open()
                end
            end
        end

        if dist2 < 20 then
            inRange = true
            DrawMarker(2, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if #(pos - vector3(Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z)) < 1.5 then
                qbCityhall.DrawText3Ds(Config.DrivingSchool.coords, '~g~E~w~ - Request driving lessons')
                if IsControlJustPressed(0, 38) then
                    if not dmvrequest then
                        dmvrequest = true
                        TriggerServerEvent('qb-cityhall:server:sendDriverTest')                       
                    else
                        QBCore.Functions.Notify("You have allready requested lessons!", 'error', 5000)
                    end
                end
            end
        end

        if dist3 < 20 then
            inRange = true
            DrawMarker(2, Config.WeaponSchool.coords.x, Config.WeaponSchool.coords.y, Config.WeaponSchool.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if #(pos - vector3(Config.WeaponSchool.coords.x, Config.WeaponSchool.coords.y, Config.WeaponSchool.coords.z)) < 1.5 then
                qbCityhall.DrawText3Ds(Config.WeaponSchool.coords, '~g~E~w~ - Request shooting lessons')
                if IsControlJustPressed(0, 38) then
                    if not weaponrequest then
                        weaponrequest = true
                        TriggerServerEvent('qb-cityhall:server:sendWeaponTest')
                    else
                        QBCore.Functions.Notify("You have allready requested lessons!", 'error', 5000)
                    end
                end
            end
        end

        if dist4 < 20 then
            inRange = true
            DrawMarker(2, Config.BoatingSchool.coords.x, Config.BoatingSchool.coords.y, Config.BoatingSchool.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if #(pos - vector3(Config.BoatingSchool.coords.x, Config.BoatingSchool.coords.y, Config.BoatingSchool.coords.z)) < 1.5 then
                qbCityhall.DrawText3Ds(Config.BoatingSchool.coords, '~g~E~w~ - Request boating lessons')
                if IsControlJustPressed(0, 38) then
                    if not boatingrequest then
                        boatingrequest = true
                        TriggerServerEvent('qb-cityhall:server:sendBoatTest')
                    else
                        QBCore.Functions.Notify("You have allready requested lessons!", 'error', 5000)
                    end
                end
            end
        end

        if dist5 < 20 then
            inRange = true
            DrawMarker(2, Config.FlyingSchool.coords.x, Config.FlyingSchool.coords.y, Config.FlyingSchool.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if #(pos - vector3(Config.FlyingSchool.coords.x, Config.FlyingSchool.coords.y, Config.FlyingSchool.coords.z)) < 1.5 then
                qbCityhall.DrawText3Ds(Config.FlyingSchool.coords, '~g~E~w~ - Request flying lessons')
                if IsControlJustPressed(0, 38) then
                    if not planerequest then
                        planerequest = true
                        TriggerServerEvent('qb-cityhall:server:sendPlaneTest')
                    else
                        QBCore.Functions.Notify("You have allready requested lessons!", 'error', 5000)
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(2)
    end
end)

RegisterNetEvent('qb-cityhall:client:getIds')
AddEventHandler('qb-cityhall:client:getIds', function()
    TriggerServerEvent('qb-cityhall:server:getIDs')
end)

RegisterNetEvent('qb-cityhall:client:sendDriverEmail')
AddEventHandler('qb-cityhall:client:sendDriverEmail', function(examinerCharinfo, playerCharinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr"
        if examinerCharinfo.gender == 1 then
            gender = "Mrs"
        end
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Driving lessons request",
            message = "Hello " .. gender .. " " .. examinerCharinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take driving lessons<br />If you are willing to teach, please contact us:<br />Name: <strong>".. playerCharinfo.firstname .. " " .. playerCharinfo.lastname .. "</strong><br />Phone Number: <strong>"..playerCharinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)


RegisterNetEvent('qb-cityhall:client:sendWeaponEmail')
AddEventHandler('qb-cityhall:client:sendWeaponEmail', function(examinerCharinfo, playerCharinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr"
        if examinerCharinfo.gender == 1 then
            gender = "Mrs"
        end
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Shooting lessons request",
            message = "Hello " .. gender .. " " .. examinerCharinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take shooting lessons.<br />If you are willing to teach, please contact us:<br />Name: <strong>".. playerCharinfo.firstname .. " " .. playerCharinfo.lastname .. "</strong><br />Phone Number: <strong>"..playerCharinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)

RegisterNetEvent('qb-cityhall:client:sendBoatEmail')
AddEventHandler('qb-cityhall:client:sendBoatEmail', function(examinerCharinfo, playerCharinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr"
        if examinerCharinfo.gender == 1 then
            gender = "Mrs"
        end
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Boating lessons request",
            message = "Hello " .. gender .. " " .. examinerCharinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take boating lessons.<br />If you are willing to teach, please contact us:<br />Name: <strong>".. playerCharinfo.firstname .. " " .. playerCharinfo.lastname .. "</strong><br />Phone Number: <strong>"..playerCharinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)

RegisterNetEvent('qb-cityhall:client:sendPlaneEmail')
AddEventHandler('qb-cityhall:client:sendPlaneEmail', function(examinerCharinfo, playerCharinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr"
        if examinerCharinfo.gender == 1 then
            gender = "Mrs"
        end
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Flying lessons request",
            message = "Hello " .. gender .. " " .. examinerCharinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take flying lessons.<br />If you are willing to teach, please contact us:<br />Name: <strong>".. playerCharinfo.firstname .. " " .. playerCharinfo.lastname .. "</strong><br />Phone Number: <strong>"..playerCharinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)

local idTypes = {
    ["id_card"] = {
        label = "Birth Certificate",
        item = "id_card"
    },
    ["driver_license"] = {
        label = "Drivers License",
        item = "driver_license"
    },
    ["weaponlicense"] = {
        label = "Weapons License",
        item = "weaponlicense"
    },
    ["boat_license"] = {
        label = "Watercraft License",
        item = "boat_license"
    },
    ["plane_license"] = {
        label = "Aircraft License",
        item = "plane_license"
    }
}

RegisterNUICallback('requestId', function(data)
    if inRange then
        local idType = data.idType

        TriggerServerEvent('qb-cityhall:server:requestId', idTypes[idType])
        QBCore.Functions.Notify('You have recived your '..idTypes[idType].label..' for $50', 'success', 3500)
    else
        QBCore.Functions.Notify('This will not work', 'error')
    end
end)

RegisterNUICallback('requestLicenses', function(data, cb)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = {}

    for type,_ in pairs(licensesMeta) do
        if licensesMeta[type] then
            local licenseType = nil
            local label = nil

            if type == "driver" then 
                licenseType = "driver_license" 
                label = "Drivers Licences"
            elseif type == "weapon" then
                licenseType = "weaponlicense" 
                label = "Weapons Licences"
            elseif type == "boat" then
                licenseType = "boat_license" 
                label = "Watercraft Licences"
            elseif type == "plane" then
                licenseType = "plane_license" 
                label = "Aircraft Licences"
            end

            table.insert(availableLicenses, {
                idType = licenseType,
                label = label
            })
        end
    end
    cb(availableLicenses)
end)

local AvailableJobs = {
    "trucker",
    "taxi",
    "tow",
    "reporter",
    "garbage",
}

function IsAvailableJob(job)
    local retval = false
    for k, v in pairs(AvailableJobs) do
        if v == job then
            retval = true
        end
    end
    return retval
end

RegisterNUICallback('applyJob', function(data)
    if inRange then
        if IsAvailableJob(data.job) then
            TriggerServerEvent('qb-cityhall:server:ApplyJob', data.job)
        else
            TriggerServerEvent('qb-cityhall:server:banPlayer')
            TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "POST Request (Abuse)", "red", "** @everyone " ..GetPlayerName(player).. "** has been banned for abusing localhost:13172, sending POST request\'s")         
        end
    else
        QBCore.Functions.Notify('Unfortunately will not work ...', 'error')
    end
end)
