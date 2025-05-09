local status = {}
local playerState = LocalPlayer.state
local speedMultiplier = Config.UseMPH and 2.23694 or 3.6
local minSpeeds = {
    unbuckled = Config.MinimumUnbuckledSpeedToGainStress / speedMultiplier,
    buckled = Config.MinimumBuckledSpeedToGainStress / speedMultiplier
}
local framework = require("modules.bridge.main")

---@return number
function status.getHunger()
    return framework.getHunger()
end

---@return number
function status.getThirst()
    return framework.getThirst()
end

---@return number
function status.getStress()
    return framework.getStress()
end

if Config.EnableStressOnSpeeding and Config.EnableSeatbelt then
    local isSpeedMonitoringThreadActive = false

    local function speedMonitoringThread()
        if isSpeedMonitoringThreadActive or not cache.vehicle then return end

        isSpeedMonitoringThreadActive = true

        CreateThread(function()
            while cache.vehicle do
                local vehicleClass = GetVehicleClass(cache.vehicle)
                local canVehicleGainStress = Config.VehClassStress[tostring(vehicleClass)]

                if canVehicleGainStress then
                    local speed = GetEntitySpeed(cache.vehicle)
                    local stressSpeed = (playerState.seatbelt or playerState.harness) and minSpeeds.buckled or minSpeeds.unbuckled

                    if speed >= stressSpeed then
                        TriggerServerEvent("hud:server:GainStress", math.random(1, 3))
                    end
                end

                Wait(15000)
            end

            isSpeedMonitoringThreadActive = false
        end)
    end

    AddEventHandler("ox_lib:cache:vehicle", function()
        Wait(500)
        speedMonitoringThread()
    end)

    do speedMonitoringThread() end -- for resource restart
end

if Config.EnableStressEffects then
    ---@param stressValue number
    ---@return { intensity: number, timeout:number }
    local function getBlurLevel(stressValue)
        local blurLevel = { intensity = 1500, timeout = 60000 }

        for i = 1, #Config.BlurLevels do
            local level = Config.BlurLevels[i]

            if stressValue >= level.min and stressValue <= level.max then
                blurLevel.timeout = level.timeout
                blurLevel.intensity = level.intensity
                break
            end
        end

        return blurLevel
    end

    CreateThread(function()
        while true do
            if framework.isPlayerLoaded() and not framework.isPlayerDead() then
                local stress = status.getStress()
                local blurLevel = getBlurLevel(stress)

                if stress >= Config.MinimumStressForEffects then
                    TriggerScreenblurFadeIn(1000.0)
                    Wait(blurLevel.intensity)
                    TriggerScreenblurFadeOut(1000.0)

                    if stress >= 100 then
                        local fallRepeat = math.random(2, 4)
                        local ragdollTimeout = fallRepeat * 1750

                        if not IsPedRagdoll(cache.ped) and IsPedOnFoot(cache.ped) and not IsPedSwimming(cache.ped) then
                            SetPedToRagdollWithFall(cache.ped, ragdollTimeout, ragdollTimeout, 1, GetEntityForwardVector(cache.ped) --[[@as number]], 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                        end

                        Wait(1000)

                        for _ = 1, fallRepeat do
                            Wait(750)
                            DoScreenFadeOut(200)
                            Wait(1000)
                            DoScreenFadeIn(200)
                            TriggerScreenblurFadeIn(1000.0)
                            Wait(blurLevel.intensity)
                            TriggerScreenblurFadeOut(1000.0)
                        end
                    end
                end

                Wait(blurLevel.timeout)
            else
                Wait(1000)
            end
        end
    end)
end

if Config.GainStressWhileShooting then
    ---@param weaponHash number
    ---@return boolean
    local function isWeaponWhitelistedForStress(weaponHash)
        for i = 1, #Config.WhitelistedWeaponStress do
            if weaponHash == Config.WhitelistedWeaponStress[i] then
                return true
            end
        end

        return false
    end

    local function isPlayerTryingToShoot()
        return IsPlayerFreeAiming(cache.playerId) or
            IsControlPressed(0, 24) or IsControlJustPressed(0, 24) or
            IsControlReleased(0, 24) or IsControlJustReleased(0, 24)
    end

    local isMonitorShootingThreadActive = false

    local function monitorShootingThread()
        if isMonitorShootingThreadActive or not cache.weapon then return end

        isMonitorShootingThreadActive = true

        CreateThread(function()
            while cache.weapon do
                if cache.weapon ~= `WEAPON_UNARMED` and not isWeaponWhitelistedForStress(cache.weapon) then
                    while isPlayerTryingToShoot() do
                        if IsPedShooting(cache.ped) then
                            if math.random() < Config.StressWhileShootingChance then
                                TriggerServerEvent("hud:server:GainStress", math.random(1, 3))
                            end

                            Wait(1000)
                        end

                        Wait(0)
                    end
                end

                Wait(1000)
            end

            isMonitorShootingThreadActive = false
        end)
    end

    AddEventHandler("ox_lib:cache:weapon", function()
        Wait(500)
        monitorShootingThread()
    end)

    do monitorShootingThread() end -- for resource restart
end

return status


