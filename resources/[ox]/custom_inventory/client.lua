local slots = GetConvarInt('inventory:slots', 50)
local poidsMax = GetConvarInt('inventory:weight', 30000)
local imagepath = GetConvar('inventory:imagepath', 'nui://ox_inventory/web/images')

-- Debug rapide
print('[CustomInventory] Slots:', slots)
print('[CustomInventory] Poids Max:', poidsMax)
print('[CustomInventory] Chemin Images:', imagepath)

-- Interception de l'ouverture de l'inventaire
RegisterNetEvent('ox_inventory:openInventory', function(data)
    -- Cache l'inventaire ox_inventory
    SendNUIMessage({ action = 'hideOxInventory' })

    -- Active ton inventaire custom
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openCustomInventory',
        inventory = data,
        config = {
            slots = slots,
            poidsMax = poidsMax,
            imagepath = imagepath
        }
    })
end)

-- Interception de la fermeture de l'inventaire
RegisterNetEvent('ox_inventory:closeInventory', function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'closeCustomInventory' })
end)

-- NUI Callback pour fermer depuis l'UI
RegisterNUICallback('closeInventory', function(data, cb)
    TriggerEvent('ox_inventory:closeInventory')
    cb('ok')
end)
