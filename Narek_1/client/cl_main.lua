ESX = nil

local PlayerData = {}

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(100)
	end 
end)

function OpenShopMenu()
	local elements = {}
	for _,v in pairs(Config.Food) do table.insert(elements, {label = v[1]..' | <span style="color:red;">'..v[3]..'$</span> ', name = v[2]}) end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'actions', {title = _U('shop'), align = 'left', elements = elements }, function(data, menu)	
		for _,v in pairs(Config.Food) do
			if data.current.name == v[2] then
				TriggerServerEvent('Narek_1:Shop', 1, v[1], v[2], v[3])
			end
		end
	end, function(data, menu) menu.close() end)
end

function OpenArmurerieMenu()
	local elements = {}
	for _,v in pairs(Config.Weapon) do table.insert(elements, {label = v[1]..' | <span style="color:red;">'..v[3]..'$</span> ', name = v[2]}) end
 	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'actions', { title = _U('armurerie'), align = 'left', elements = elements }, function(data, menu)		
		for _,v in pairs(Config.Weapon) do
			if data.current.name == v[2] then
				ESX.TriggerServerCallback('Narek_1:checkLicense', function(hasWeaponLicense)
					if v[4] == 1 then
						if hasWeaponLicense then
							TriggerServerEvent('Narek_1:Shop', 2, v[1], v[2], v[3])
                		else
							ESX.ShowAdvancedNotification(_U('armurerie'), '', _U('PasLicense'), 'CHAR_DOM', 1)
						end
					else
						TriggerServerEvent('Narek_1:Shop', 2, v[1], v[2], v[3])
					end
				end, GetPlayerServerId(PlayerId()), 'weapon')   
			end
		end
	end, function(data, menu) menu.close() end)
end

function OpenPoleEmploiMenu()
	ESX.TriggerServerCallback('esx_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = _U('poleemploi'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('esx_joblisting:setJob', data.current.job)
			exports['mythic_notify']:SendAlert('success', 'Vous avez un nouvel emplois !', 2500)
			--ESX.ShowNotification(_U('SetJob'))
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

Citizen.CreateThread(function()
	while true do
        time = 500
		for _,v in pairs(Config.Shop) do
		    if v[1] == 1 then
				if Vdist2(GetEntityCoords(PlayerPedId(), false), v[2]) < 3 then time = 10 if IsControlJustPressed(1,51) then OpenShopMenu() end end	
		    elseif v[1] == 2 then
				if Vdist2(GetEntityCoords(PlayerPedId(), false), v[2]) < 3 then time = 10 if IsControlJustPressed(1,51) then OpenArmurerieMenu() end end
		    elseif v[1] == 3 then
				if Vdist2(GetEntityCoords(PlayerPedId(), false), v[2]) < 2 then time = 10 if IsControlJustPressed(1,51) then OpenPoleEmploiMenu() end end
			end	
		end
		Citizen.Wait(time)
	end
end)
