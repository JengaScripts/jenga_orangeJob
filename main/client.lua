CreateThread(function()
    while true do
        Wait(Config.TreeRefreshInterval)
        for i = 1, #Config.Locations do
            if Config.Locations[i].collected then
                Config.Locations[i].collected = false
            end
        end
    end
end)

CreateThread(function()
    local player = PlayerPedId()
	while true do
        local sleep = 2000
		local pCoords = GetEntityCoords(player)
		for i = 1, #Config.Locations do
            if not Config.Locations[i].collected then
                local coords = vector3(Config.Locations[i].coords.x, Config.Locations[i].coords.y, Config.Locations[i].coords.z)
                local distance = #(pCoords - coords)
                if distance < 20 then
                    sleep = 0
                    DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 50, false, true, 2, nil, nil, false)
                    if distance < 2 then
                        DrawText3D(coords.x, coords.y, coords.z, Config.Lang.collectorange)
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent("jenga_orangejob:client:startCollecting")
                            Config.Locations[i].collected = true
                        end
                    end
                end
            end
		end
		Wait(sleep)
	end
end)

CreateThread(function()
    local player = PlayerPedId()
	while true do
        local sleep = 2000
		local pCoords = GetEntityCoords(player)
        local distance = #(pCoords - vector3(Config.OrangeJuice.x, Config.OrangeJuice.y, Config.OrangeJuice.z))
		if distance < 20 then
			sleep = 0
			DrawMarker(2, Config.OrangeJuice.x, Config.OrangeJuice.y, Config.OrangeJuice.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 50, false, true, 2, nil, nil, false)
			if distance < 2 then
				DrawText3D(Config.OrangeJuice.x, Config.OrangeJuice.y, Config.OrangeJuice.z, Config.Lang.converttojuice)
				if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("jenga_orangejob:server:orangeJuice")
				end
			end
		end
		Wait(sleep)
	end
end)

RegisterNetEvent("jenga_orangejob:client:startCollecting", function()
	SendNUIMessage({nui = "open", min = Config.MinOrange, max = Config.MaxOrange})
    SetNuiFocus(true, true)
end)

RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent("jenga_orangejob:server:close", data)
end)

DrawText3D = function (x, y, z, text)
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

if Config.Blip then
    CreateThread(function()
        local orangeblip = AddBlipForCoord(Config.OrangeBlip.x, Config.OrangeBlip.y, Config.OrangeBlip.z)
        SetBlipSprite(orangeblip, 1)
        SetBlipAsShortRange(orangeblip, true)
        SetBlipScale(orangeblip, 0.5)
        SetBlipColour(orangeblip, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.OrangeBlipName)
        EndTextCommandSetBlipName(orangeblip)

        local orangeblipjuice = AddBlipForCoord(Config.OrangeJuiceBlip.x, Config.OrangeJuiceBlip.y, Config.OrangeJuiceBlip.z)
        SetBlipSprite(orangeblipjuice, 1)
        SetBlipAsShortRange(orangeblipjuice, true)
        SetBlipScale(orangeblipjuice, 0.5)
        SetBlipColour(orangeblipjuice, 5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.OrangeJuiceBlipName)
        EndTextCommandSetBlipName(orangeblipjuice)
    end)
end