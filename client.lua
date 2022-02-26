-- local QBCore = exports['qb-core']:GetCoreObject()
local isInMenu = false
local sleep

local multiplier = Config.DefaultMultiplier
local timeCylcleModifier = ""

local menu = MenuV:CreateMenu(false, 'TimeCycle Preview', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'main')
local menu1 = MenuV:CreateMenu(false, 'Timecycles', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'timecycles')


RegisterNetEvent('blackout-timecyle-viewer:client:openMenu')
AddEventHandler('blackout-timecyle-viewer:openMenu', function()
  MenuV:OpenMenu(menu)
end)


local menu_button = menu:AddButton({
  icon = '📋',
  label = 'Select Timecycle',
  value = menu1,
  description = 'Select a Timecyle from the list'
})

local menu_button1 = menu:AddButton({
  icon = '➕',
  label = 'Increase Strength',
  value = nil,
  description = 'Increase strength of timecycle effect'
})
local menu_button2 = menu:AddButton({
  icon = '➖',
  label = 'Decrease Strength',
  value = nil,
  description = 'Decrease strength of timecycle effect'
})

local menu_button3 = menu:AddButton({
  icon = '🧼',
  label = 'Remove Effects',
  value = nil,
  description = 'Remove timecycle modifiers'
})

local menu_button5 = menu:AddButton({
  icon = '❌',
  label = 'Close Menu',
  value = nil,
  description = 'Closes the menu'
})

local timeCycleButtons = {}

for i = 1, Config.TimeCyclesLength + 1 do

  timeCycleButtons[i] = menu1:AddButton({
    icon = '',
    label = Config.TimeCycles[i],
    value = nil,
    description = 'Change Timecycle modifier'
  })

  timeCycleButtons[i]:On("select", function()
    
    SetTimecycleModifier(Config.TimeCycles[i])	
  end)
end



menu_button1:On("select", function()
  multiplier += 0.1
  if multiplier > 3 then multiplier = 3 end
  SetTimecycleModifierStrength(multiplier)
  QBCore.Functions.Notify("Timecyle Strength: " .. multiplier, 'success')
end)

menu_button2:On("select", function()
  multiplier -= 0.1
  if multiplier < 0 then multiplier = 0 end
  SetTimecycleModifierStrength(multiplier)
  QBCore.Functions.Notify("Timecyle Strength: " .. multiplier, 'success')
end)

-- Clear
menu_button3:On("select", function()
  ClearTimecycleModifier()
  ClearWeatherTypePersist()
end)

--close
menu_button5:On("select", function()
  MenuV:CloseMenu(menu)
end)



-- MAIN THREAD
CreateThread(function()

  while true do
    sleep = 100
    if IsControlPressed(1, Config.ActivationKey) then 
      MenuV:OpenMenu(menu)
      end
      Wait(sleep)
  end
end)