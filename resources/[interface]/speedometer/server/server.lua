
RegisterServerEvent('hudevents:leftVehicle')
AddEventHandler('hudevents:leftVehicle', function()	
    TriggerClientEvent('hudevents:leftVehicle', source)
end)

RegisterServerEvent('hudevents:enteredVehicle')
AddEventHandler('hudevents:enteredVehicle', function(currentVehicle, currentSeat, vehicle_name, net_id)	
    TriggerClientEvent('hudevents:enteredVehicle', source, currentVehicle, currentSeat, vehicle_name, net_id)
end)


Citizen.CreateThread(function()
	Citizen.Wait(5000)
    local resName = GetCurrentResourceName()
	local havePermission = false
	local customer = nil	
	local actual_server_ip

	if resName ~= "speedometer" then
		print("^2["..resName.."] - IT WAS NOT STARTED CORRECTLY.")
		print("^2["..resName.."] - THE RESOURCE NAME MUST BE speedometer")
		--Stop_Resource()
	end

	
	Citizen.Wait(20000)

end)


------------------------
-- FINAL AUTENTICAÇÃO --
------------------------