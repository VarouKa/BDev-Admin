ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end

reportlistesql = {}

RMenu.Add('menu', 'main', RageUI.CreateMenu("Admin", " "))
RMenu.Add('menu', 'options', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'joueurs', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'warn', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'sanction', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'actionstaff', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'perso', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'world', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'options', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'veh', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'customcolor', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'ped', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'lister', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "BDev", " "))
RMenu.Add('menu', 'gestr', RageUI.CreateSubMenu(RMenu:Get('menu', 'lister'), "BDev", " "))
RMenu:Get('menu', 'main'):SetSubtitle(" ")
RMenu:Get('menu', 'main').EnableMouse = false
RMenu:Get('menu', 'main').Closed = function()

VM.Staff = false
    end
end)

VM = {
    Staff = false,
}

superadmin = nil
local invincible = false
local crossthemap = false
local affichername = false
local afficherblips = false
local pris = false
local Freeze = false
local superJump = false
local fastSprint = false
local infStamina = false
local Frigo = false
local Frigo2 = false
local godmode = true
local fastSwim = false
local blipsStatus = 0
local ademo26 = false
local StaffMod = false
local NoClip = false
local NoClipSpeed = 2.0
local invisible = false
local PlayerInZone = 0
local ShowName = false
local gamerTags = {}
local GetBlips = false
local pBlips = {}
local armor = 0
local InStaff = false
local pris = false
local Spectating = false
local WarnType = {
    "Freekill",
    "ForceRP",
    "HRP-Vocal",
    "Conduite-HRP",
    "No Fear RP",
    "No Pain RP",
    "Troll",
    "Power Gaming",
    "Insultes",
    "Non respect du staff",
    "Meta Gaming",
    "Force RP",
    "Free Shoot",
    "Free Punch",
    "Tire en zone safe",
    "Non respect du mass RP",
    "Autre...(Entrer la raison)",
}

if pris then
	label = "~g~Appel pris"
else
	couscous = "~r~Non traité"
end	

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end


function GetTargetedVehicle(pCoords, ply)
    for i = 1, 200 do
        coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, (6.281)/i, 0.0)
        targetedVehicle = GetVehicleInDirection(pCoords, coordB)
        if(targetedVehicle ~= nil and targetedVehicle ~= 0)then
            return targetedVehicle
        end
    end
    return
end

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function ShowMarker()
	local ply = GetPlayerPed(-1)
	local pCoords = GetEntityCoords(ply, true)
    local veh = GetTargetedVehicle(pCoords, ply)
    if veh ~= 0 and GetEntityType(veh) == 2 then
        local coords = GetEntityCoords(veh)
        local x,y,z = table.unpack(coords)
        DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
    end
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(GetPlayerPed(-1))
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end

Citizen.CreateThread(function()
    while true do
    	if Admin.showcoords then
            x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
            roundx=tonumber(string.format("%.2f",x))
            roundy=tonumber(string.format("%.2f",y))
            roundz=tonumber(string.format("%.2f",z))
            DrawTxt("~r~X:~s~ "..roundx,0.05,0.00)
            DrawTxt("     ~r~Y:~s~ "..roundy,0.11,0.00)
            DrawTxt("        ~r~Z:~s~ "..roundz,0.17,0.00)
            DrawTxt("             ~r~Angle:~s~ "..GetEntityHeading(PlayerPedId()),0.21,0.00)
        end
        if Admin.showcrosshair then
            DrawTxt('+', 0.495, 0.484, 1.0, 0.3, MainColor)
        end
    	Citizen.Wait(0)
    end
end)

Admin = {
	showcoords = false,
}
MainColor = {
	r = 225, 
	g = 55, 
	b = 55,
	a = 255
}

function DrawTxt(text,r,z)
    SetTextColour(MainColor.r, MainColor.g, MainColor.b, 255)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(r,z)
 end

RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze",function()

    FreezeEntityPosition(GetPlayerPed(-1), not Freeze)
    Freeze = not Freeze
end)

RegisterNetEvent("admin:tp")
AddEventHandler("admin:tp",function(coords)
    SetEntityCoords(GetPlayerPed(-1),coords)
end)


Citizen.CreateThread(function()

    while true do
      Citizen.Wait(1)

     
      if infStamina then
        RestorePlayerStamina(source, 1.0)
      end

      if superJump then
        SetSuperJumpThisFrame(PlayerId())
	  end
    end
  
  end)

function SpectatePlayer(player)
	--local playerPed = PlayerPedId()
	Spectating = not Spectating
	local targetPed = GetPlayerPed(player)

	if(Spectating)then

		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(true, targetPed)

		drawNotification('Spectating '..GetPlayerName(player))
	else

		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(false, targetPed)

		drawNotification('Stopped Spectating '..GetPlayerName(player))
	end
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent("CA")
AddEventHandler("CA", function()
  local pos = GetEntityCoords(GetPlayerPed(-1), true)
  ClearAreaOfObjects(pos.x, pos.y, pos.z, 50.0, 0)
end)

function soufle()
    infStamina = not infStamina
      if infStamina then
        Notify("Endurance infini ~g~activé")
      else
        Notify("Endurance infini ~r~desactivé")
      end
   end

   function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

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

function superman()
	superJump = not superJump	  
end

RegisterNetEvent("hAdmin:envoyer")
AddEventHandler("hAdmin:envoyer", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if StaffMod then

            if invisible then
                SetEntityVisible(GetPlayerPed(-1), 0, 0)
                NetworkSetEntityInvisibleToNetwork(pPed, 1)
            else
                SetEntityVisible(GetPlayerPed(-1), 1, 0)
                NetworkSetEntityInvisibleToNetwork(pPed, 0)
			end

            if ShowName then
                local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
                for _, v in pairs(GetActivePlayers()) do
                    local otherPed = GetPlayerPed(v)
                
                    if otherPed ~= pPed then
                        if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
                            SetMpGamerTagVisibility(gamerTags[v], 4, 1)
                        else
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
            else
                for _, v in pairs(GetActivePlayers()) do
                    RemoveMpGamerTag(gamerTags[v])
                end
            end

            for k,v in pairs(GetActivePlayers()) do
                if NetworkIsPlayerTalking(v) then
                    local pPed = GetPlayerPed(v)
                    local pCoords = GetEntityCoords(pPed)
                    DrawMarker(32, pCoords.x, pCoords.y, pCoords.z+1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1, 2, 0, nil, nil, 0)
                end
			end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if GetBlips then
            local players = GetActivePlayers()
            for k,v in pairs(players) do
                local ped = GetPlayerPed(v)
                local blip = AddBlipForEntity(ped)
                table.insert(pBlips, blip)
                SetBlipScale(blip, 0.85)
                if IsPedOnAnyBike(ped) then
                    SetBlipSprite(blip, 226)
                elseif IsPedInAnyHeli(ped) then
                    SetBlipSprite(blip, 422)
                elseif IsPedInAnyPlane(ped) then
                    SetBlipSprite(blip, 307)
                elseif IsPedInAnyVehicle(ped, false) then
                    SetBlipSprite(blip, 523)
                else
                    SetBlipSprite(blip, 1)
                end

                if IsPedInAnyPoliceVehicle(ped) then
                    SetBlipSprite(blip, 56)
                    SetBlipColour(blip, 3)
                end
                SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
			end
		else
			for k,v in pairs(pBlips) do
                RemoveBlip(v)
            end
        end
    end
end)

local ServersIdSession = {}

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

function openStaffMenu()
    if VM.Staff then
        VM.Staff = false
    else
		VM.Staff = true
        RageUI.Visible(RMenu:Get('menu', 'main'), true)

        Citizen.CreateThread(function()
			while VM.Staff do
				RageUI.IsVisible(RMenu:Get('menu', 'main'), true, true, true, function()
					RageUI.Checkbox("Mode ~b~Admin$", "", InStaff, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						InStaff = Checked;
						if Selected then
							if Checked then							
								InStaff = true
								StaffMod = true
							else
								InStaff = false
								StaffMod = false
				
								FreezeEntityPosition(GetPlayerPed(-1), false)
								NoClip = false
				
								SetEntityVisible(GetPlayerPed(-1), 1, 0)
								NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
								SetEntityCollision(GetPlayerPed(-1), 1, 1)
				
								for _, v in pairs(GetActivePlayers()) do
									RemoveMpGamerTag(gamerTags[v])
								end
								-- Go Webhook Inactive
							end
						end
					end)
					if InStaff then
						RageUI.Separator("↓ ~c~-------[ Action ]------- ~s~↓")
						RageUI.Button("~g~Annonce Staff~s~ (~r~En Dev~s~)", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'perso'))
						RageUI.Button("~g~Actions perso", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'perso'))
						RageUI.Button("~g~Actions staff", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'actionstaff'))
						RageUI.Separator("↓ ~c~-------[ Utilitaire ]------- ~s~↓")
						RageUI.Button("~b~Actions véhicule", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'veh'))
						RageUI.Button("~b~Liste des joueurs", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'joueurs'))
						RageUI.Button("~b~Options HRP", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'world'))
						RageUI.Button("~b~Menu Peds", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'ped'))
						RageUI.Separator("↓ ~c~-------[ Sanction ]------- ~s~↓")
						RageUI.Button("~r~Warn", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'warn')) 
						RageUI.Button("~r~Reports", "", { RightLabel = "→" },true, function()
						end, RMenu:Get('menu', 'lister')) 
					end
				end, function()
				end, 1)
		
				
				RageUI.IsVisible(RMenu:Get('menu', 'perso'), true, true, true, function()

					RageUI.Button("Téléporter sur son marqueur", nil, {
					}, true, function(_, _, Selected)
					if Selected then
						local playerPed = GetPlayerPed(-1)
						local WaypointHandle = GetFirstBlipInfoId(8)
						if DoesBlipExist(WaypointHandle) then
							local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
							--SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
							SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.9, false, false, false, true)
		
						end
					end
					end)

					RageUI.Button("Afficher/Cacher coordonnées",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then   
							Admin.showcoords = not Admin.showcoords    
							end   
						end)

					RageUI.Button("S'octroyer du Heal",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							SetEntityHealth(GetPlayerPed(-1), 200)
							Notify("~g~Heal effectué~w~")
						end
					end)

					RageUI.Button("S'octroyer du Blindage",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							SetPedArmour(GetPlayerPed(-1), 200)
							Notify("~g~Blindage effectué~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~g~l'argent cash",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveCash()
							Notify("~g~Give cash effectué~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~b~l'argent banque",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveBanque()
							Notify("~g~Give banque effectué~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~r~l'argent sale",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveND()
							Notify("~g~Give argent sale effectué~w~")
						end
					end)

					RageUI.Checkbox("Noclip", nil, crossthemap,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							crossthemap = Checked
							if Checked then
								news_no_clip()
							else
								news_no_clip()
							end
						end
					end)

					RageUI.Checkbox("Nage rapide", description, fastSwim,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							fastSwim = Checked
							if Checked then
								SetSwimMultiplierForPlayer(PlayerId(), 1.49)
							else
								SetSwimMultiplierForPlayer(PlayerId(), 1.0)
							end
						end
					end)

					RageUI.Checkbox("Super Sprint", description, fastSprint,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							fastSprint = Checked
							if Checked then
								SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
							else
								SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
							end
						end
					end)
					
				end, function()
				end)

				RageUI.Checkbox("Super Punch", description, fastPunch,{},function(Hovered,Ative,Selected,Checked)
					if Selected then
						fastSprint = Checked
						if Checked then
							SetPunchMultiplierForPlayer(PlayerId(), 1.49)
						else
							SetPunchMultiplierForPlayer(PlayerId(), 1.0)
						end
					end
				end)
				
			end, function()
			end)
		
				RageUI.IsVisible(RMenu:Get('menu', 'joueurs'), true, true, true, function()
					for k,v in ipairs(ServersIdSession) do
						if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
						RageUI.Button(v.." : " ..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdSelected = v
							end
						end, RMenu:Get('menu', 'options'))
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'actionstaff'), true, true, true, function()
					RageUI.Separator("↓ ~b~Intéraction possible sur un joueur ~s~↓", nil, {}, true, function(_, _, _)
                    end)
					RageUI.Button("Envoyer un message", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 100)
							local msg = KeyboardInput("Raison", "", 100)

							if msg ~= nil then
								msg = tostring(msg)
						
								if type(msg) == 'string' then
									TriggerServerEvent("hAdmin:Message", quelid, msg)
									RageUI.CloseAll()
								end
							end
							ESX.ShowNotification("Vous venez d'envoyer le message à  l'ID : ~r~ " ..quelid)
						end
					end)
					RageUI.Button("Téléporter sur joueur", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 100)
							ExecuteCommand("goto "..quelid)
							ESX.ShowNotification("~b~Vous venez de vous téléporter à l\'ID : ~s~ " ..quelid)
						end
					end)
					RageUI.Button("Téléporter à vous", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected, target)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 100)
							ExecuteCommand("bring "..quelid)
							ESX.ShowNotification("~b~Vous venez de téléporter l\'ID :~s~ " ..quelid.. " ~b~à vous~s~ !")
						end
					end)
					if superadmin then
						RageUI.Button("Setjob une personne", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local quelid = KeyboardInput("ID", "", 10)
								local job = KeyboardInput("Job", "", 10)
								local grade = KeyboardInput("Grade", "", 10)
								if job and grade and quelid then
									ExecuteCommand("setjob "..quelid.. " " ..job.. " " ..grade)
									ESX.ShowNotification("Vous venez de setjob ~g~"..job.. " " .. grade .. " l\'ID : " ..quelid)
								else
									RageUI.CloseAll()	
								end	
							end
						end)
					end

					RageUI.Button("Heal une personne", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 3)
							if quelid then
								ExecuteCommand("heal "..quelid)
								Notify("~g~Heal de l'ID "..quelid.." effectué~w~")
							else
								RageUI.CloseAll()	
							end
						end
					end)

					RageUI.Button("Revive une personne",description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then   
							local previve = KeyboardInput('ID du Joueur', '', 3)
							ExecuteCommand('revive', previve)
							end      
						end)

					RageUI.Button("Give un item", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 3)
							local item = KeyboardInput("Item", "", 10)
							local amount = KeyboardInput("Nombre", "", 10)
							if item and quelid and amount then
								ExecuteCommand("giveitem "..quelid.. " " ..item.. " " ..amount)
								ESX.ShowNotification("Vous venez de donner ~g~"..amount.. " " .. item .. " ~w~à l'ID :" ..quelid)	
							else
								RageUI.CloseAll()	
							end			
						end
					end)

					if superadmin then
						RageUI.Button("Give une arme", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local quelid = KeyboardInput("ID", "", 3)
								local weapon = KeyboardInput("WEAPON_...", "", 50)
								local ammo = KeyboardInput("Munitions", "", 100)
								if weapon and ammo and quelid then
									ExecuteCommand("giveweapon "..quelid.. " " ..weapon.. " " ..ammo)
									ESX.ShowNotification("Vous venez de donner ~g~"..weapon.. " avec " .. ammo .. " munitions ~w~à l'ID :" ..quelid)
								else
									RageUI.CloseAll()	
								end
							end
						end)

					RageUI.Button("~o~Kick", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 3)
							local reason = KeyboardInput("Raison du kick", "", 100)
							ExecuteCommand("kick "..quelid.. "" ..reason)
							if quelid and reason then
								ExecuteCommand("kick "..quelid.. " " ..reason)
								ESX.ShowNotification("Vous venez de kick l\'ID :"..quelid.. " pour la raison suivante : " ..reason)
							else
								RageUI.CloseAll()	
							end	
						end
					end)

					RageUI.Button("~r~Bannir", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local quelid = KeyboardInput("ID", "", 3)
							local day = KeyboardInput("Jours", "", 100)
							local raison = KeyboardInput("Raison du kick", "", 100)
							if quelid and day and raison then
								ExecuteCommand("sqlban "..quelid.. " " ..day.. " " ..raison)
								ESX.ShowNotification("Vous venez de ban l\'ID :"..quelid.. " " ..day.. " pour la raison suivante : " ..raison)
							else
								RageUI.CloseAll()	
							end
						end
					end)

					RageUI.Button("~g~Faire un déban", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local name = KeyboardInput("Nom Steam", "", 100)
							if name then
								ExecuteCommand("sqlunban "..name)
								ESX.ShowNotification("Vous venez de déban : "..name)
							else
								RageUI.CloseAll()	
							end
						end
					end)
				    end
				end, function()
				end)
		
				RageUI.IsVisible(RMenu:Get('menu', 'options'), true, true, true, function()
					RageUI.Separator("↓ ~r~Actions possible sur ~s~↓", nil, {}, true, function(_, _, _)
					end)
					RageUI.Separator(GetPlayerName(GetPlayerFromServerId(IdSelected)))
					RageUI.Button("Envoyer un message", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local msg = KeyboardInput("Raison", "", 100)

							if msg ~= nil then
								msg = tostring(msg)
						
								if type(msg) == 'string' then
									TriggerServerEvent("hAdmin:Message", IdSelected, msg)
									RageUI.CloseAll()
								end
							end
							ESX.ShowNotification("Vous venez d'envoyer le message à ~b~" .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
						end
					end)

					if superadmin then
						RageUI.Button("Setjob", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local job = KeyboardInput("Job", "", 10)
								local grade = KeyboardInput("Grade", "", 10)
								if job and grade then
									ExecuteCommand("setjob "..IdSelected.. " " ..job.. " " ..grade)
									ESX.ShowNotification("Vous venez de setjob ~g~"..job.. " " .. grade .. " " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
								else
									RageUI.CloseAll()	
								end	
							end
						end)
					end

					RageUI.Button("Téléporter sur joueur", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(IdSelected))))
							ESX.ShowNotification('~b~Vous venez de vous Téléporter à~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'')
						end
					end)

					RageUI.Button("Téléporter à vous", nil, {}, true, function(Hovered, Active, Selected, target)
						if (Selected) then
							ExecuteCommand("bring "..IdSelected)
							ESX.ShowNotification('~b~Vous venez de Téléporter ~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' ~b~à vous~s~ !')
						end
					end)

					RageUI.Checkbox("Freeze / Defreeze", description, Frigo,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							Frigo = Checked
							if Checked then
								ESX.ShowNotification("~r~Joueur Freeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
								TriggerEvent("admin:Freeze",IdSelected)
							else
								ESX.ShowNotification("~r~Joueur Defreeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
								TriggerEvent("admin:Freeze",IdSelected)
							end
						end
					end)

					RageUI.Button("Heal", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("heal "..IdSelected)
							Notify("~g~Heal de ".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .." effectué~w~")
						end
					end)

					if superadmin then
						RageUI.Button("Wipe l'inventaire", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								ExecuteCommand("clearinventory "..IdSelected)
								ESX.ShowNotification("Vous venez d'enlever tout les items de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !")
							end
						end)
					end

					if superadmin then
						RageUI.Button("Wipe les armes", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								ExecuteCommand("clearloadout "..IdSelected)
								ESX.ShowNotification("Vous venez de enlever toutes les armes de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !")
							end
						end)
					end

					RageUI.Button("Give un item", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local item = KeyboardInput("Item", "", 10)
							local amount = KeyboardInput("Nombre", "", 10)
							if item and amount then
								ExecuteCommand("giveitem "..IdSelected.. " " ..item.. " " ..amount)
								ESX.ShowNotification("Vous venez de donner ~g~"..amount.. " " .. item .. " ~w~à " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))	
							else
								RageUI.CloseAll()	
							end			
						end
					end)

					if superadmin then
						RageUI.Button("Give une arme", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local weapon = KeyboardInput("WEAPON_...", "", 100)
								local ammo = KeyboardInput("Munitions", "", 100)
								if weapon and ammo then
									ExecuteCommand("giveweapon "..IdSelected.. " " ..weapon.. " " ..ammo)
									ESX.ShowNotification("Vous venez de donner ~g~"..weapon.. " avec " .. ammo .. " munitions ~w~à " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
								else
									RageUI.CloseAll()	
								end
							end
						end)
						RageUI.Button("~o~Kick", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local kick = KeyboardInput("Raison du kick", "", 100)
								TriggerServerEvent('vStaff:KickPerso', kick)
							end
						end)

						RageUI.Button("~r~Bannir", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local quelid = KeyboardInput("ID", "", 100)
								local day = KeyboardInput("Jours", "", 100)
								local raison = KeyboardInput("Raison du kick", "", 100)
								if quelid and day and raison then
									ExecuteCommand("sqlban "..quelid.. " " ..day.. " " ..raison)
									ESX.ShowNotification("Vous venez de ban l\'ID :"..quelid.. " " ..day.. " pour la raison suivante : " ..raison)
								else
									RageUI.CloseAll()	
								end
							end
						end)

				    end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'warn'), true, true, true, function()
					for k,v in ipairs(ServersIdSession) do
						if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
						RageUI.Button("["..v.."] - "..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdSelected = v
							end
						end, RMenu:Get('menu', 'sanction'))
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'sanction'), true, true, true, function()
					RageUI.Separator("ID : ["..IdSelected.."]", nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Separator("Joueur : "..GetPlayerName(GetPlayerFromServerId(IdSelected)), nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Separator(" (3 Warn = Ban) ", nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Separator(" ↓ ~r~Raison du warn ~s~↓ ", nil, {}, true, function(Hovered, Active, Selected)
					end)
		
					for k,v in pairs(WarnType) do
						RageUI.Button(""..v, nil, {}, true, function(Hovered, Active, Selected)
							if Selected then
								if v == "Autre...(Entrer la raison)" then
									AddTextEntry("Entrer la raison", "")
									DisplayOnscreenKeyboard(1, "Entrer la raison", '', "", '', '', '', 128)
								
									while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
										Citizen.Wait(0)
									end
								
									if UpdateOnscreenKeyboard() ~= 2 then
										raison = GetOnscreenKeyboardResult()
										Citizen.Wait(1)
									else
										Citizen.Wait(1)
									end
									TriggerServerEvent("STAFFMOD:RegisterWarn", IdSelected, raison)
								else
									TriggerServerEvent("STAFFMOD:RegisterWarn", IdSelected, v)
								end
							end
						end)
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'veh'), true, true, true, function()

					RageUI.Button("Faire apparaître un véhicule", nil, {}
					, true, function(_, _, Selected)
					if Selected then
		
						local ped = GetPlayerPed(tgt)
						local ModelName = KeyboardInput("Véhicule", "", 100)
		
						if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
							RequestModel(ModelName)
							while not HasModelLoaded(ModelName) do
								Citizen.Wait(0)
							end
								local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), true, true)
								TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
								Wait(50)
						else
							ShowNotification("Erreur !")
						end
					end
					end)

					RageUI.Button("Réparer", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
					SetVehicleFixed(plyVeh)
					SetVehicleDirtLevel(plyVeh, 0.0) 
						end   
					end)   
					
					RageUI.Button("Custom au maximum", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						FullVehicleBoost()
						end   
					end) 

					RageUI.Button("Changer la plaque", nil, {}, true, function(_, Active, Selected)
					if Selected then
						if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
							local plaqueVehicule = KeyboardInput("Plaque", "", 8)
							SetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false) , plaqueVehicule)
							ESX.ShowNotification("La plaque du véhicule est désormais : ~g~"..plaqueVehicule)
						else
							ESX.ShowNotification("~r~Erreur\n~s~Vous n'êtes pas dans un véhicule !")
						end
					end
					end)

					RageUI.Button("Mettre en Fourrière", nil, {}, true, function(_, Active, Selected)
					if Active then
						ShowMarker()
					end
					if Selected then
						TriggerEvent("esx:deleteVehicle")
					end
					end)

					RageUI.Button("Changer la couleur", nil, {RightLabel = "→"},true, function()
					end, RMenu:Get('menu', 'customcolor'))

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'customcolor'), true, true, true, function()
					RageUI.Button("Bleu", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 0, 0, 255)
						SetVehicleCustomSecondaryColour(vehicle, 0, 0, 255)
						end      
					end)
					RageUI.Button("Rouge", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 255, 0, 0)
						SetVehicleCustomSecondaryColour(vehicle, 255, 0, 0)
						end      
					end)
					RageUI.Button("Vert", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 0, 255, 0)
						SetVehicleCustomSecondaryColour(vehicle, 0, 255, 0)
						end      
					end)
					RageUI.Button("Noir", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
						SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
						end      
					end)
					RageUI.Button("Rose", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 100, 0, 60)
						SetVehicleCustomSecondaryColour(vehicle, 100, 0, 60)
						end      
					end)
					RageUI.Button("Blanc", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
						SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
						end      
					end)
				 
			   end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'ped'), true, true, true, function()
					RageUI.Button("Reprendre son personnage", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local isMale = skin.sex == 0
		
		
							TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
									TriggerEvent('skinchanger:loadSkin', skin)
									TriggerEvent('esx:restoreLoadout')
							end)
							end)
							end)
					end
					end)

					RageUI.Button("Entrer un ped custom", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local newped = KeyboardInput('Entrer le nom de votre Ped', '', 45)
						local p1 = GetHashKey(newped)
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.Separator("↓ ~g~Sélection rapide ~s~↓")
				
					RageUI.Button("Singe", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_chimp')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.Button("Danseuse", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('csb_stripper_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.Button("Cosmonaute", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('s_m_m_movspace_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.Button("Alien", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('s_m_m_movalien_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.Button("Chat", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_cat_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.Button("Aigle", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_chickenhawk')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.Button("Coyote", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_coyote')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'lister'), true, true, true, function()
			
					for numreport = 1, #reportlistesql, 1 do
					  RageUI.Button("[Joueur : "..reportlistesql[numreport].reporteur.."~s~] - "..reportlistesql[numreport].type, "Numéro : "..reportlistesql[numreport].id, { RightLabel = label or couscous }, true, function(Hovered, Active, Selected)
						  if (Selected) then
							pris = true
							  typereport = reportlistesql[numreport].type
							  sonid = reportlistesql[numreport].sonid
							  reportjoueur = reportlistesql[numreport].reporteur
							  raisonreport = reportlistesql[numreport].raison
							  joueurreporter = reportlistesql[numreport].nomreporter
							  supprimer = reportlistesql[numreport].id
						  end
					  end, RMenu:Get('menu', 'gestr'))
				  end
			  
			 end, function()
			  end)
			  
		  RageUI.IsVisible(RMenu:Get('menu', 'gestr'), true, true, true, function()

			RageUI.Separator("~b~Joueur qui report~s~ : ".. reportjoueur)

			RageUI.Separator("~b~ID ~s~: " ..sonid)

			RageUI.Separator("~r~Type de report~s~ : ".. typereport)
  
			RageUI.Separator("~r~Joueur qui est reporté~s~ : ".. joueurreporter)

			RageUI.Separator("~r~Raison du report~s~ : ".. raisonreport)

			RageUI.Button("Se téléporter", nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					ExecuteCommand("goto "..sonid)
				end
			end)

			RageUI.Button("Spectate (Bêta)", nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
                    ----- Fait le ou attend la V2
				end
			end)

			RageUI.Button("~r~Supprimer le report", nil, {}, true, function(Hovered, Active, Selected)
				if (Selected) then
					TriggerServerEvent('h4ci_report:supprimereport', supprimer)
					ESX.ShowNotification("~o~Le report de ~s~".. reportjoueur .. " ~o~a bien été supprimé, pensez à relancer le menu")
				end
			end)
			  
	  
			 end, function()
			  end)

				RageUI.IsVisible(RMenu:Get('menu', 'world'), true, true, true, function()
					RageUI.Checkbox("Afficher les Noms", description, affichername,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							affichername = Checked
							if Checked then
								ShowName = true
							else
								ShowName = false
							end
						end
					end)

					RageUI.Checkbox("Afficher les Blips", description, afficherblips,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							afficherblips = Checked
							if Checked then
								GetBlips = true
							else
								GetBlips = false
							end
						end
					end)
				end, function()
				end)
				Wait(0)
			end
		end)
	end
end

TriggerEvent('chat:addSuggestion', '/report', 'Faire un appel staff', {
    { name="Raison", help="Merci de détailler votre demande" },
})

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
				if IsControlJustPressed(0, 82) then
					ESX.TriggerServerCallback('RubyMenu:getUsergroup', function(group)
						playergroup = group
						if playergroup == 'superadmin' or playergroup == 'owner' then
							superadmin = true
							openStaffMenu()
							ESX.TriggerServerCallback('h4ci_report:affichereport', function(keys)
								reportlistesql = keys
								end)
						elseif playergroup == 'dev' or playergroup == 'mod' or playergroup == 'admin' then
							superadmin = false
							openStaffMenu()
						end
					end)
			end
		end
	end)

function GetPlayers()
	local players = {}

	for _, i in ipairs(GetActivePlayers()) do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end

	return players
end

function GiveCash()
	local amount = KeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('vAdmin:GiveCash', amount)
		end
	end
end


function GiveBanque()
	local amount = KeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('vAdmin:GiveBanque', amount)
		end
	end
end


function GiveND()
	local amount = KeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('vAdmin:GiveND', amount)
		end
	end
end

function admin_heal_player()
	local plyId = KeyboardInput1("N_BOX_ID", "", "", 8)
	if plyId ~= nil then
		plyId = tonumber(plyId)
		if type(plyId) == 'number' then
			TriggerServerEvent('esx_ambulancejob:revive', plyId)
		end
	end
end

function FullVehicleBoost()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 14, 0, true)
		SetVehicleNumberPlateTextIndex(vehicle, 5)
		ToggleVehicleMod(vehicle, 18, true)
		SetVehicleColours(vehicle, 0, 0)
		SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
		SetVehicleModColor_2(vehicle, 5, 0)
		SetVehicleExtraColours(vehicle, 111, 111)
		SetVehicleWindowTint(vehicle, 2)
		ToggleVehicleMod(vehicle, 22, true)
		SetVehicleMod(vehicle, 23, 11, false)
		SetVehicleMod(vehicle, 24, 11, false)
		SetVehicleWheelType(vehicle, 12) 
		SetVehicleWindowTint(vehicle, 3)
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
		LowerConvertibleRoof(vehicle, true)
		SetVehicleIsStolen(vehicle, false)
		SetVehicleIsWanted(vehicle, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetCanResprayVehicle(vehicle, true)
		SetPlayersLastVehicle(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleTyresCanBurst(vehicle, false)
		SetVehicleWheelsCanBreak(vehicle, false)
		SetVehicleCanBeTargetted(vehicle, false)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		SetVehicleHasStrongAxles(vehicle, true)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleCanBeVisiblyDamaged(vehicle, false)
		IsVehicleDriveable(vehicle, true)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleStrong(vehicle, true)
		RollDownWindow(vehicle, 0)
		RollDownWindow(vehicle, 1)
		SetVehicleNeonLightEnabled(vehicle, 0, true)
		SetVehicleNeonLightEnabled(vehicle, 1, true)
		SetVehicleNeonLightEnabled(vehicle, 2, true)
		SetVehicleNeonLightEnabled(vehicle, 3, true)
		SetVehicleNeonLightsColour(vehicle, 0, 0, 255)
		SetPedCanBeDraggedOut(PlayerPedId(), false)
		SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
		SetPedRagdollOnCollision(PlayerPedId(), false)
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedDecorations(PlayerPedId())
		SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
		for i = 0,14 do
			SetVehicleExtra(veh, i, 0)
		end
		SetVehicleModKit(veh, 0)
		for i = 0,49 do
			local custom = GetNumVehicleMods(veh, i)
			for j = 1,custom do
				SetVehicleMod(veh, i, math.random(1,j), 1)
			end
		end
	end
end

RegisterNetEvent("STAFFMOD:RegisterWarn")
AddEventHandler("STAFFMOD:RegisterWarn", function(reason)
	SetAudioFlag("LoadMPData", 1)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	ShowFreemodeMessage("WARNED", "Tu à été warn pour: "..reason, 5)
end)

function ShowFreemodeMessage(title, msg, sec)
	local scaleform = _RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

	BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	PushScaleformMovieMethodParameterString(title)
	PushScaleformMovieMethodParameterString(msg)
	EndScaleformMovieMethod()

	while sec > 0 do
		Citizen.Wait(1)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

function _RequestScaleformMovie(movie)
	local scaleform = RequestScaleformMovie(movie)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	return scaleform
end

function Popup(txt)
	ClearPrints()
	SetNotificationBackgroundColor(140)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(txt)
	DrawNotification(false, true)
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(pPed)
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end

-------------------------------------

-- FONCTION NEWS NOCLIP 

local noclip = false
local noclip_speed = 1.0

function news_no_clip()
  noclip = not noclip
  local ped = GetPlayerPed(-1)
  if noclip then -- activé
    SetEntityInvincible(ped, true)
	SetEntityVisible(ped, false, false)
	invisible = true
	Notify("Noclip ~g~activé")
  else -- désactivé
    SetEntityInvincible(ped, false)
	SetEntityVisible(ped, true, false)
	invisible = false
	Notify("Noclip ~r~désactivé")
  end
end

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

function isNoclip()
  return noclip
end

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  if noclip then
		local ped = GetPlayerPed(-1)
		local x,y,z = getPosition()
		local dx,dy,dz = getCamDirection()
		local speed = noclip_speed
  
		-- reset du velocity
		SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
  
		-- aller vers le haut
		if IsControlPressed(0,32) then -- MOVE UP
		  x = x+speed*dx
		  y = y+speed*dy
		  z = z+speed*dz
		end
  
		-- aller vers le bas
		if IsControlPressed(0,269) then -- MOVE DOWN
		  x = x-speed*dx
		  y = y-speed*dy
		  z = z-speed*dz
		end
  
		SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
	  end
	end
  end)

-- FIN NEWS NOCLIP