ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Narek_1:Shop')
AddEventHandler('Narek_1:Shop', function(id, label, item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(item)
    
    if xPlayer.getMoney() >= price then
        if id == 1 then
            if Config.Weight then
                if xPlayer.canCarryItem(item, 1) then
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.removeMoney(price)
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('shop'), '',  _U('AchatShop')..'x1 ~y~'..label, 'CHAR_DOM', 1)
                else
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('shop'), '', _U('PasPlace'), 'CHAR_DOM', 1)
                end 
            else
                if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('shop'), '', _U('PasPlace'), 'CHAR_DOM', 1)
                else
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.removeMoney(price)
                    TriggerClientEvent('esx:showAdvancedNotification', source, _U('shop'), '',  _U('AchatShop')..'x1 ~y~'..label, 'CHAR_DOM', 1)
                end
            end    
        elseif id == 2 then
            if xPlayer.getWeapon(item) then
                TriggerClientEvent('esx:showAdvancedNotification', source, _U('armurerie'), '', _U('DejaArme'), 'CHAR_DOM', 1)
            else
                xPlayer.addWeapon(item, 200)
                xPlayer.removeMoney(price)
                TriggerClientEvent('esx:showAdvancedNotification', source, _U('armurerie'), '', _U('AchatArme')..label, 'CHAR_DOM', 1)
            end
        end

    else
        if id == 1 then
            TriggerClientEvent('esx:showAdvancedNotification', source, _U('shop'), '', _U('PasArgent'), 'CHAR_DOM', 1)
        elseif id == 1 then
            TriggerClientEvent('esx:showAdvancedNotification', source, _U('armurerie'), '', _U('PasArgent'), 'CHAR_DOM', 1)
        end
    end
end)

RegisterServerEvent('Narek_1:Autre')
AddEventHandler('Narek_1:Autre', function(label, job)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent('esx:showAdvancedNotification', source, _U('poleemploi'), '', _U('SetJob')..label, 'CHAR_DOM', 1)
    xPlayer.setJob(job, 0) 
end)
