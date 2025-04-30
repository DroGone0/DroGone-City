lib.locale()

Config                         = {}

Config.Debug                   = false

Config.ClothingScript          = 'illenium-appearance' -- 'illenium-appearance', 'fivem-appearance' ,'core' or false -- to disable
Config.EmsJobs                 = { "ambulance", "ems" }
Config.RespawnTime             = 0                     -- in minutes
Config.UseInterDistressSystem  = true
Config.WaitTimeForNewCall      = 5                     -- minutes

Config.ReviveCommand           = "revive"
Config.ReviveAreaCommand       = "revivearea"
Config.HealCommand             = "heal"
Config.HealAreaCommand         = "healarea"
Config.ReviveAllCommand        = "reviveall"

Config.AdminGroup              = "group.admin"

Config.MedicBagProp            = "xm_prop_x17_bag_med_01a"
Config.MedicBagItem            = "medicalbag"

Config.HelpCommand             = "911"
Config.RemoveItemsOnRespawn    = true

Config.BaseInjuryReward        = 150 -- changes if the injury value is higher then 1
Config.ReviveReward            = 700

Config.ParamedicTreatmentPrice = 4000
Config.AllowAlways             = true        -- false if you want it to work only when there are only medics online

Config.AmbulanceStretchers     = 2           -- how many stretchers should an ambunalce have
Config.ConsumeItemPerUse       = 10          -- every time you use an item it gets used by 10%

Config.TimeToWaitForCommand    = 2           -- when player dies he needs to wait 2 minutes to do the ambulance command
Config.NpcReviveCommand        = "ambulance" -- this will work only when there are no medics online

Config.UsePedToDepositVehicle  = false       -- if false the vehicle will instantly despawns
Config.ExtraEffects            = true        -- false >> disables the screen shake and the black and white screen

Config.EmsVehicles             = {           -- vehicles that have access to the props (cones and ecc..)
	'ambulance',
	'ambulance2',
}

Config.DeathAnimations         = {
	["car"] = {
		dict = "veh@low@front_ps@idle_duck",
		clip = "sit"
	},
	["normal"] = {
		dict = "dead",
		clip = "dead_a"
	},
	["revive"] = {
		dict = "get_up@directional@movement@from_knees@action",
		clip = "getup_r_0"
	}
}


Config.Hospitals = {
	["Ocean"] = {
		paramedic = {
			model = "s_m_m_scientist_01",
			pos = vector4(-1865.459351, -322.259338, 48.449097, 331.653534),
		}, 
		--[[ origine :  312.0927 -596.1016 42.2918 338.7213
			 ma pose :  -1865.459351 -322.259338 49.449097 331.653534
		 ]]
		bossmenu = {
			pos = vector3(284.84, -615.6, 44.24),
			min_grade = 2
		},
		zone = {
			pos = vec3(-1852, -339, 49),
			size = vec3(300.0, 300.0, 300.0),
		},
		blip = {
			enable = true,
			name = 'Ocean EMS',
			type = 61,
			scale = 1.0,
			color = 2,
			pos = vector3(-1852, -339, 49),
		},
		--[[ origine :  308.96, -591.52, 43.28
			 ma pose :  -1852 -339 49
		 ]]
		respawn = {
			{
				bedPoint = vector4(-1868.637329, -329.960449, 50.173584, 323.149597),--[[ origine : 349.76, -583.44, 43.0, 150.04 ]]
				spawnPoint = vector4(-1872.276978, -321.151642, 48.000000, 136.062988) --[[ origine :  348.84, -583.36, 42.32, 68.24 ]]
			},
			-- {
			-- 	bedPoint = vector4(346.96, -590.64, 44.12, 338.0),
			-- 	spawnPoint = vector4(348.84, -583.36, 42.32, 68.24)
			-- },

		},
		stash = {
			['ems_stash_1'] = {
				slots = 100,
				weight = 100, -- kg
				min_grade = 0,
				label = 'Ems Coffre',
				shared = true, -- false if you want to make everyone has a personal stash
				pos = vector3(-1846.786865, -338.808777, 49.449097)
			}
		},
		pharmacy = {
			["ems_shop_1"] = {
				job = true,
				label = "Pharmacy",
				grade = 0, -- works only if job true
				pos = vector3(-1824.619751, -381.850555, 49.398560),
				blip = {
					enable = false,
					name = 'Pharmacy',
					type = 61,
					scale = 0.7,
					color = 2,
					pos = vector3(315.5516, -598.6013, 43.2918),
				},
				items = {
					{ name = 'medicalbag',    price = 10 },
					{ name = 'bandage',       price = 10 },
					{ name = 'defibrillator', price = 10 },
					{ name = 'tweezers',      price = 10 },
					{ name = 'burncream',     price = 10 },
					{ name = 'suturekit',     price = 10 },
					{ name = 'icepack',       price = 10 },
					{ name = 'medikit',       price = 10 },
				}
			},
			["ems_shop_2"] = {
				job = false,
				label = "Pharmacy",
				grade = 0, -- works only if job true
				pos = vector3(-1831.556030, -380.083496, 49.398560),
				blip = {
					enable = true,
					name = 'Pharmacy',
					type = 61,
					scale = 0.7,
					color = 2,
					pos = vector3(303.84, -597.6, 43.28),
				},
				items = {
					{ name = 'bandage', price = 10 },
				}
			},
		},
		garage = {
			['ems_garage_1'] = {
				pedPos = vector4(-1848.817627, -382.483521, 39.754639, 201.259842),
				model = 'a_m_m_hillbilly_01',
				spawn = vector4(-1847.195557, -388.048340, 40.737671, 323.149597),
				deposit = vector3(-1839.811035, -394.720886, 40.670288),
				driverSpawnCoords = vector3(297.56, -600.52, 43.32),

				vehicles = {
					{
						label = 'Ambulance',
						spawn_code = 'ambulance',
						min_grade = 3,
						modifications = {} -- es. {color1 = {255, 12, 25}}
					},
					{
						label = 'A Modifier',
						spawn_code = 'landstalker',
						min_grade = 3,
						modifications = {} -- es. {color1 = {255, 12, 25}}
					},
				}
			}
		},
		clothes = {
			enable = true,
			pos = vector4(300.7454, -597.4542, 42.2918, 298.0781),
			model = 'a_f_m_bevhills_01',
			male = {
				[1] = {
					['mask_1']    = 0,
					['mask_2']    = 0,
					['arms']      = 0,
					['tshirt_1']  = 15,
					['tshirt_2']  = 0,
					['torso_1']   = 86,
					['torso_2']   = 0,
					['bproof_1']  = 0,
					['bproof_2']  = 0,
					['decals_1']  = 0,
					['decals_2']  = 0,
					['chain_1']   = 0,
					['chain_2']   = 0,
					['pants_1']   = 10,
					['pants_2']   = 2,
					['shoes_1']   = 56,
					['shoes_2']   = 0,
					['helmet_1']  = 34,
					['helmet_2']  = 0,
					['glasses_1'] = 34,
					['glasses_2'] = 1,
				},
				[2] = {
					['mask_1']    = 0,
					['mask_2']    = 0,
					['arms']      = 0,
					['tshirt_1']  = 15,
					['tshirt_2']  = 0,
					['torso_1']   = 86,
					['torso_2']   = 0,
					['bproof_1']  = 0,
					['bproof_2']  = 0,
					['decals_1']  = 0,
					['decals_2']  = 0,
					['chain_1']   = 0,
					['chain_2']   = 0,
					['pants_1']   = 10,
					['pants_2']   = 2,
					['shoes_1']   = 56,
					['shoes_2']   = 0,
					['helmet_1']  = 34,
					['helmet_2']  = 0,
					['glasses_1'] = 34,
					['glasses_2'] = 1,
				},
			},
			female = {
				[1] = {
					['mask_1']    = 0,
					['mask_2']    = 0,
					['arms']      = 0,
					['tshirt_1']  = 15,
					['tshirt_2']  = 0,
					['torso_1']   = 86,
					['torso_2']   = 0,
					['bproof_1']  = 0,
					['bproof_2']  = 0,
					['decals_1']  = 0,
					['decals_2']  = 0,
					['chain_1']   = 0,
					['chain_2']   = 0,
					['pants_1']   = 10,
					['pants_2']   = 2,
					['shoes_1']   = 56,
					['shoes_2']   = 0,
					['helmet_1']  = 34,
					['helmet_2']  = 0,
					['glasses_1'] = 34,
					['glasses_2'] = 1,
				},
			},
		},
	},
}


Config.BodyParts = {

	-- ["0"] = { id = "hip", label = "Damaged Hipbone", levels = { ["default"] = "Damaged", ["10"] = "Damaged x2", ["20"] = "Damaged x3", ["30"] = "Damaged x3", ["40"] = "Damaged x3", ["50"] = "Damaged x3" } },
	["0"] = { id = "hip", label = "Damaged Hipbone", levels = { ["default"] = "Damaged", ["10"] = "Damaged x2", ["20"] = "Damaged x3", ["30"] = "Damaged x3", ["40"] = "Damaged x3" } }, -- hip bone,
	["10706"] = { id = "rclavicle", label = "Right Clavicle", levels = { ["default"] = "Damaged" } },                                                                                 --right clavicle
	["64729"] = { id = "lclavicle", label = "Left Clavicle", levels = { ["default"] = "Damaged" } },                                                                                  --right clavicle
	["14201"] = { id = "lfoot", label = "Left Foot", levels = { ["default"] = "Damaged" } },                                                                                          -- left foot
	["18905"] = { id = "lhand", label = "Left Hand", levels = { ["default"] = "Damaged" } },                                                                                          -- left hand
	["24816"] = { id = "lbdy", label = "Lower chest", levels = { ["default"] = "Damaged" } },                                                                                         -- lower chest
	["24817"] = { id = "ubdy", label = "Upper Chest", levels = { ["default"] = "Damaged" } },                                                                                         -- Upper chest
	["24818"] = { id = "shoulder", label = "Shoulder", levels = { ["default"] = "Damaged" } },                                                                                        -- shoulder
	["28252"] = { id = "rforearm", label = "Right Forearm", levels = { ["default"] = "Damaged" } },                                                                                   -- right forearm
	["36864"] = { id = "rleg", label = "Right leg", levels = { ["default"] = "Damaged" } },                                                                                           -- right lef
	["39317"] = { id = "neck", label = "Neck", levels = { ["default"] = "Damaged" } },                                                                                                -- neck
	["40269"] = { id = "ruparm", label = "Right Upper Arm", levels = { ["default"] = "Damaged" } },                                                                                   -- right upper arm
	["45509"] = { id = "luparm", label = "Left Upper Arm", levels = { ["default"] = "Damaged" } },                                                                                    -- left upper arm
	["51826"] = { id = "rthigh", label = "Right Thigh", levels = { ["default"] = "Damaged" } },                                                                                       -- right thigh
	["52301"] = { id = "rfoot", label = "Right Foot", levels = { ["default"] = "Damaged" } },                                                                                         -- right foot
	["57005"] = { id = "rhand", label = "Right Hand", levels = { ["default"] = "Damaged" } },                                                                                         -- right hand
	["57597"] = { id = "5lumbar", label = "5th Lumbar vertabra", levels = { ["default"] = "Damaged" } },                                                                              --waist
	["58271"] = { id = "lthigh", label = "Left Thigh", levels = { ["default"] = "Damaged" } },                                                                                        -- left thigh
	["61163"] = { id = "lforearm", label = "Left forearm", levels = { ["default"] = "Damaged" } },                                                                                    -- left forearm
	["63931"] = { id = "lleg", label = "Left Leg", levels = { ["default"] = "Damaged" } },                                                                                            -- left leg
	["31086"] = { id = "head", label = "Head", levels = { ["default"] = "Damaged" } },                                                                                                -- head
}

function Config.SendDistressCall(msg)
	--[--] -- Quasar

	-- TriggerServerEvent('qs-smartphone:server:sendJobAlert', {message = msg, location = GetEntityCoords(PlayerPedId())}, "ambulance")


	--[--] -- GKS
	-- local myPos = GetEntityCoords(PlayerPedId())
	-- local GPS = 'GPS: ' .. myPos.x .. ', ' .. myPos.y

	-- ESX.TriggerServerCallback('gksphone:namenumber', function(Races)
	--     local name = Races[2].firstname .. ' ' .. Races[2].lastname

	--     TriggerServerEvent('gksphone:jbmessage', name, Races[1].phone_number, msg, '', GPS, "ambulance")
	-- end)
end
