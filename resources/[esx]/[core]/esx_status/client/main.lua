local OriginalStatus, Status, isPaused = {}, {}, false

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	
	for i=1, #OriginalStatus, 1 do
		if status.name == OriginalStatus[i].name then
			status.set(OriginalStatus[i].val)
		end
	end

	table.insert(Status, status)
end)

AddEventHandler('esx_status:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

RegisterNetEvent('esx:onPlayerLogout', function()
	Status = {}
	if Config.Display then
		SendNUIMessage({
			update = true,
			status = Status
		})
	end
end)

RegisterNetEvent('esx_status:load', function(status)
	while not ESX.PlayerLoaded do Wait(0) end

	OriginalStatus = status
	TriggerEvent('esx_status:loaded')

	if Config.Display then TriggerEvent('esx_status:setDisplay', 0.5) end

	CreateThread(function()
		local data = {}
		while ESX.PlayerLoaded do
			for i=1, #Status do
				Status[i].onTick()
				table.insert(data, {
					name = Status[i].name,
					val = Status[i].val,
					percent = (Status[i].val / Config.StatusMax) * 100
				})
			end

			if Config.Display then
				local fullData = data
				for i=1, #data, 1 do
					fullData[i].color = Status[i].color
					fullData[i].visible = Status[i].visible(Status[i])
				end
				SendNUIMessage({
					update = true,
					status = fullData
				})
			end

			TriggerEvent('esx_status:onTick', data)
			table.wipe(data)
			Wait(Config.TickTime)
		end
	end)
end)

RegisterNetEvent('esx_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end
	if Config.Display then
		SendNUIMessage({
			update = true,
			status = GetStatusData()
		})
	end
end)

RegisterNetEvent('esx_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end
	if Config.Display then
		SendNUIMessage({
			update = true,
			status = GetStatusData()
		})
	end
end)

RegisterNetEvent('esx_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end
		if Config.Display then
		SendNUIMessage({
			update = true,
			status = GetStatusData()
		})
	end
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

AddEventHandler('esx_status:getAllStatus', function(cb)
	cb(Status)
end)

AddEventHandler('esx_status:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)

-- Pause menu disable hud display
if Config.Display then
	AddEventHandler('esx:pauseMenuActive', function(state)
		if state then
			isPaused = true
			TriggerEvent('esx_status:setDisplay', 0.0)
			return
		end
		isPaused = false
		TriggerEvent('esx_status:setDisplay', 0.5)
	end)

	-- Loading screen off event
	AddEventHandler('esx:loadingScreenOff', function()
		if not isPaused then
			TriggerEvent('esx_status:setDisplay', 0.3)
		end
	end)
end

-- Update server
CreateThread(function()
	while true do
		Wait(Config.UpdateInterval)
		if ESX.PlayerLoaded then TriggerServerEvent('esx_status:update', GetStatusData(true)) end
	end
end)





--[[ COMMANDE RAJOUTER ]]
-- FAIM
TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F',
	function(status)
		return true
	end,
	function(status)
		status.remove(1000) -- Perte de faim à chaque tick
	end,
	{ remove = 10000 }
)

-- SOIF
TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0FCFDA',
	function(status)
		return true
	end,
	function(status)
		status.remove(1000) -- Perte de soif à chaque tick
	end,
	{ remove = 8000 }
)

--[[ COMMANDE RAJOUTER ]]
RegisterCommand('getstatus', function()
    if not Status or #Status == 0 then
        print('[esx_status] ❌ Statuts non disponibles.')
        return
    end

    local hunger, thirst, armor = nil, nil, nil

    for i = 1, #Status do
        local stat = Status[i]
        if stat.name == "hunger" then hunger = stat.val end
        if stat.name == "thirst" then thirst = stat.val end
        if stat.name == "armor" then armor = stat.val end
    end

    print('------------------------------------------')
    print('[esx_status] FAIM   :', hunger or 'nil')
    print('[esx_status] SOIF   :', thirst or 'nil')
    print('[esx_status] ARMURE :', armor or 'nil')

    if armor then
        print('[esx_status] % ARMURE :', math.floor((armor / 1000000) * 100).."%")
    end
    print('------------------------------------------')
end)
