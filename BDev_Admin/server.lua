ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('RubyMenu:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	print(GetPlayerName(source).." - "..group)
	cb(group)
end)

platenum = math.random(00001, 99998)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local r = math.random(00001, 99998)
		platenum = r
	end
end)

RegisterServerEvent("vAdmin:GiveCash")
AddEventHandler("vAdmin:GiveCash", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addMoney((total))
end)

RegisterServerEvent("vAdmin:GiveBanque")
AddEventHandler("vAdmin:GiveBanque", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('bank', total)
end)

RegisterServerEvent("vAdmin:GiveND")
AddEventHandler("vAdmin:GiveND", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('black_money', total)
end)



RegisterNetEvent("hAdmin:Message")
AddEventHandler("hAdmin:Message", function(id, type)
	TriggerClientEvent("hAdmin:envoyer", id, type)
end)

KickPerso = "ADMIN SYSTEM -"

RegisterServerEvent('vStaff:KickPerso')
AddEventHandler('vStaff:KickPerso', function(target, msg)
    name = GetPlayerName(source)
    DropPlayer(source,target, msg)
end)


function NoIdent(ident)
    if ident == 'steam:11' then
        return true
    else
        return false
    end
end

function SendWebhookMessageMenuStaff(webhook,message)
	webhook = "https://discord.com/api/webhooks/777266055369588736/PCtWR7wjL6Z-zfBjkn1FeFcdNHkXK67rT_95WtBudBnExxNkxzqjaWn3NUSax5RMB7Gv"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent("AdminMenu:StaffOnOff")
AddEventHandler("AdminMenu:StaffOnOff", function(status)

	local xPlayers	= ESX.GetPlayers()
    local xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.getIdentifier()

	for i=1, #xPlayers, 1 do
          local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if NoIdent(ident) == false then
              if status == true then
                   TriggerClientEvent('chatMessage', xPlayers[i], 'BlueVinity Modération', {255, 0, 0}, "Un staff vient de passer un mode modération : "..source..".")
                   print(status)
              elseif status == false then
                   TriggerClientEvent('chatMessage', xPlayers[i], 'BlueVinity Modération', {255, 0, 0}, "Un staff vient de quitter le mode modération : "..source..".")
                   print(status)
              end
		 end
	end
end)


RegisterServerEvent("logMenuAdmin")
AddEventHandler("logMenuAdmin", function(option)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.getIdentifier()
    	local date = os.date('*t')

    	if date.day < 10 then date.day = '0' .. tostring(date.day) end
    	if date.month < 10 then date.month = '0' .. tostring(date.month) end
    	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    	if date.min < 10 then date.min = '0' .. tostring(date.min) end
    	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    	name = GetPlayerName(source)
    	if ident == 'steam:11' then--Special character in username just crash the server
			print('Ignoring error.')
    	else
    		print('Staff: '..name.." used "..option..".")
    		SendWebhookMessageMenuStaff(webhook,"**Menu Admin Utilisé** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.." \nOption activé: "..option.."\n+ Date: " .. date.day .. "." .. date.month .. "." .. date.year .. " - " .. date.hour .. ":" .. date.min .. ":" .. date.sec .. "\n[Detection #".. platenum .."].```")
    	end
end)


RegisterServerEvent("kickAllPlayer2")
AddEventHandler("kickAllPlayer2", function()
	local message = money
	print(message)
	local xPlayers	= ESX.GetPlayers()
	TriggerEvent('SavellPlayerAuto')
	Citizen.Wait(2000)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		DropPlayer(xPlayers[i], 'BlueVinity Administration | RESTART DU SERVEUR. Vous avez été exlus du serveur avant son restart pour sauvgarder votre personnage\nMerci d\'attendre le message comme quoi le serveur à restart sur le discord avant de vous connecté')
	end


end)


RegisterServerEvent("ReviveAll")
AddEventHandler("ReviveAll", function()
	name = GetPlayerName(source)
	local xPlayers	= ESX.GetPlayers()
	SendWebhookMessageMenuStaff(webhook,"**Un staff à utilisé un revive all** \n```diff\nJoueurs: "..name.."\nID du joueurs: "..source.." \n[Detection #".. platenum .."].```")
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerEvent('esx_ambulancejob:revive2', xPlayers[i])
	end
end)

RegisterServerEvent("deleteVehAll")
AddEventHandler("deleteVehAll", function()
	TriggerClientEvent("RemoveAllVeh", -1)
end)

RegisterServerEvent("spawnVehAll")
AddEventHandler("spawnVehAll", function()
	TriggerClientEvent("SpawnAllVeh", -1)
end)



--RegisterServerEvent("SavellPlayer")
--AddEventHandler("SavellPlayer", function(source)
--	local _source = source
--	local xPlayer = ESX.GetPlayerFromId(_source)
--	--ESX.SavePlayers(cb)
--	ESX.SavePlayer(xPlayer, cb)
--	print('^2Save de '..xPlayer..' ^3Effectué')
--	--for i=1, #xPlayers, 1 do
--	--	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
--	--	--TriggerClientEvent('esx:showNotification', xPlayers[i], '✅ Synchronisation inventaire effectuée.')
--	--end
--
--
--end)


RegisterServerEvent("SavellPlayerAuto")
AddEventHandler("SavellPlayerAuto", function()
	ESX.SavePlayers(cb)
	print('^2Save des joueurs ^3Effectué')
end)


count = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		count = count + 1

		if count >= 240 then
			ESX.SavePlayers(cb)
			print('^2Save des joueurs ^3Effectué')
			count = 0
		end
	end
end)

-----------------------------

-- Warn system
local warns = {}

RegisterNetEvent("STAFFMOD:RegisterWarn")
AddEventHandler("STAFFMOD:RegisterWarn", function(id, type)
	local steam = GetPlayerIdentifier(id, 1)
	local warnsGet = 0
	local found = false
	for k,v in pairs(warns) do
		if v.id == steam then
			found = true
			warnsGet = v.warns
			table.remove(warns, k)
			break
		end
	end
	if not found then
		table.insert(warns, {
			id = steam,
			warns = 1
		})
	else
		table.insert(warns, {
			id = steam,
			warns = warnsGet + 1
		})
	end
	print(warnsGet+1)
	if warnsGet+1 >= 3 then
		SessionBanPlayer(id, steam, source, type)
	else
		WarnsLog(id, source, type, false)
		TriggerClientEvent("STAFFMOD:RegisterWarn", id, type)
	end
end)

local SessionBanned = {}
local SessionBanMsg = "Vous avez été banni de la session de jeux pour une accumulation de warn. Merci de lire le règlement de nouveau et d'attendre la prochaine session de jeux pour jouer de nouveau."

function SessionBanPlayer(id, steam, source, type)
	table.insert(SessionBanned, steam)
	WarnsLog(id, source, type, true)
	DropPlayer(id, SessionBanMsg)
end

local webhook = ""
function WarnsLog(IdWarned, IdSource, Reason, banned)
	if not banned then
		message = GetPlayerName(IdSource).." à warn "..GetPlayerName(IdWarned).." pour "..Reason
	else
		message = GetPlayerName(IdSource).." à warn "..GetPlayerName(IdWarned).." pour "..Reason.." et à été banni de la session pour accumulation de warn."
	end

	local discordInfo = {
			["color"] = "15158332",
			["type"] = "rich",
			["title"] = "**WARN**",
			["description"] = message,
			["footer"] = {
			["text"] = 'WARN SYSTEM' 
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'RUBY WARN', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end


---------------------------------------------------------


----- Reports


function reportadminok(player)
    local allowed = false
    for i,id in ipairs(reportadmin) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

ESX.RegisterServerCallback('h4ci_report:affichereport', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local keys = {}

    MySQL.Async.fetchAll('SELECT * FROM report', {}, 
        function(result)
        for numreport = 1, #result, 1 do
            table.insert(keys, {
                id = result[numreport].id,
                type = result[numreport].type,
                sonid = result[numreport].sonid,
                reporteur = result[numreport].reporteur,
                nomreporter = result[numreport].nomreporter,
                raison = result[numreport].raison
            })
        end
        cb(keys)

    end)
end)

RegisterServerEvent('h4ci_report:ajoutreport')
AddEventHandler('h4ci_report:ajoutreport', function(typereport, sonid, reporteur, nomreporter, raison)
    MySQL.Async.execute('INSERT INTO report (type, sonid, reporteur, nomreporter, raison) VALUES (@type, @sonid, @reporteur, @nomreporter, @raison)', {
        ['@type'] = typereport,
        ['@sonid'] = sonid,
        ['@reporteur'] = reporteur,
        ['@nomreporter'] = nomreporter,
        ['@raison'] = raison
    })
end)

RegisterServerEvent('h4ci_report:supprimereport')
AddEventHandler('h4ci_report:supprimereport', function(supprimer)
    MySQL.Async.execute('DELETE FROM report WHERE id = @id', {
            ['@id'] = supprimer
    })
end)