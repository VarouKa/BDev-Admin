ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('setreportadmin')
AddEventHandler('setreportadmin', function()
    reportadmingroup = true
end)    

Citizen.CreateThread(function()
    while true do
        Citizen.Wait( 2000 )

        if NetworkIsSessionStarted() then
            TriggerServerEvent("checkreportadmin")
        end
    end
end )

reportlistesql = {}

RMenu.Add('report', 'main', RageUI.CreateMenu("Report", " "))

Citizen.CreateThread(function()
	while true do
		
		RageUI.IsVisible(RMenu:Get('report', 'main'), true, true, true, function()
			
            RageUI.Button("Faire un appel staff", nil, {RightLabel = "📞"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                for _, i in ipairs(GetActivePlayers()) do
                local reasonResults = KeyboardInput("Raison de l'appel: ", "", 70)
                local playerName = GetPlayerName(PlayerId())
                local typereport = "Appel staff"
                local nameResults = "Staff"
                local sonid = GetPlayerServerId(i)

                TriggerEvent('chatMessage', "Appel Staff", {225, 29, 29}, " -  Votre appel admin a été envoyé pour \"" .. reasonResults.."\".")
                TriggerServerEvent('h4ci_report:ajoutreport', typereport, sonid, playerName, nameResults, reasonResults)
                end
            end
		end)
			
			RageUI.Button("Faire un report", nil, {RightLabel = "📋"}, true, function(Hovered, Active, Selected)
				if (Selected) then
                    for _, i in ipairs(GetActivePlayers()) do
                    local nameResults = KeyboardInput("Nom du Joueur:", "", 20)
                	local reasonResults = KeyboardInput("Raison du Report: ", "", 70)
                    local playerName = GetPlayerName(PlayerId())
                    local typereport = "Report"
                    local sonid = GetPlayerServerId(i)

                if nameResults == nil or nameResults == "" then
                    TriggerEvent('chatMessage', "Erreur Report", {255, 0, 0}, "Vous n'avez pas saisi de nom")
                else
                    TriggerEvent('chatMessage', "Report Staff", {225, 29, 29}, " -  Votre report a été envoyé contre \"".. nameResults .. "\" pour \"" .. reasonResults.."\".")
                    TriggerServerEvent('h4ci_report:ajoutreport', typereport, sonid, playerName, nameResults, reasonResults)
                    end
                end
                end
            end)

            end, function()
			end)
            Citizen.Wait(0)
        end
    end)

RegisterCommand("report", function() 
    ESX.TriggerServerCallback('h4ci_report:affichereport', function(keys)
    reportlistesql = keys
    end)
  RageUI.Visible(RMenu:Get('report', 'main'), not RageUI.Visible(RMenu:Get('report', 'main')))
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
    blockinput = true --Blocks new input while typing if **blockinput** is used

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() --Gets the result of the typing
        Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false --This unblocks new Input when typing is done
        return result --Returns the result
    else
        Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false --This unblocks new Input when typing is done
        return nil --Returns nil if the typing got aborted
    end
end