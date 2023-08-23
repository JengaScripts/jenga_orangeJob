ESX,QBCore = nil,nil
local FrameWork = GetResourceState('es_extended') ==  'started' and 'ESX' or GetResourceState('qb-core') ==  'started' and 'QBCORE'

if FrameWork == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    if not ESX then
        ESX = exports['es_extended']:getSharedObject()
    end
elseif FrameWork == 'QBCORE' then
	QBCore = exports['qb-core']:GetCoreObject() 
else
    print("FrameWork Not Detected!")
end

print("Framework: ".. FrameWork)

if QBCore then
    RegisterNetEvent("jenga_orangejob:server:close", function(data)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem("orange", tonumber(data.reward))
        TriggerClientEvent('QBCore:Notify', source, Config.Lang.collected.." "..data.reward, "success")
    end)

    RegisterNetEvent("jenga_orangejob:server:orangeJuice", function(data)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player.Functions.RemoveItem("orange", Config.OrangeToJuice) then
            Player.Functions.AddItem("orangejuice", 1)
            TriggerClientEvent('QBCore:Notify', source, Config.Lang.collectedjuice, "success")
        else
            TriggerClientEvent('QBCore:Notify', source, Config.Lang.dontenoughorange, "error")
        end
    end)
else
    RegisterNetEvent("jenga_orangejob:server:close", function(data) 
        local Player = ESX.GetPlayerFromId(source)
        Player.addInventoryItem("orange", tonumber(data.reward))
        Player.showNotification(Config.Lang.collected.." "..data.reward)
    end)

    RegisterNetEvent("jenga_orangejob:server:orangeJuice", function(data)
        local Player = ESX.GetPlayerFromId(source)
        local count = Player.getInventoryItem("orange").count
        if count and count > 0 then
            Player.removeInventoryItem("orange", Config.OrangeToJuice)
            Player.addInventoryItem("orangejuice", 1)
            Player.showNotification(Config.Lang.collectedjuice)
        else
            Player.showNotification(Config.Lang.dontenoughorange)
        end
    end)
end