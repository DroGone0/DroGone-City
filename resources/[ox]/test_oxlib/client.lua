RegisterCommand('testnotif', function()
    lib.notify({
        title = '🔔 Notification',
        description = 'Ceci est un test de notification avec ox_lib.',
        type = 'inform' -- types possibles : 'inform', 'success', 'error'
    })
end)
