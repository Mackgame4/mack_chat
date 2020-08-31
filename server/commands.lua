ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

RegisterCommand('ooc', function(source, args, rawCommand, suggestions)
    local src = source
    local msg = rawCommand:sub(5)
    local suggestions = {}
	local source = tonumber(source)
    if player ~= false then
        local user = GetPlayerName(src)
        GetRPName(source, function(Firstname, Lastname)
            TriggerClientEvent('chat:addMessageOOC', -1, {
            template = '<div class="chat-message"><b> [' .. source .. '] ' .. Firstname.. ' '.. Lastname.. ':</b> {1}</div>',
            args = { user, msg }
        })
    end)
    end
end, false)

RegisterCommand('twt', function(source, args, rawCommand, suggestions)
    local src = source
    local msg = rawCommand:sub(5)
    local suggestions = {}
	local source = tonumber(source)
    if player ~= false then
        local user = GetPlayerName(src)
        GetRPName(source, function(Firstname, Lastname)
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message advert"><b>' .. Firstname.. ' '.. Lastname.. ':</b> {1}</div>',
            args = { user, msg }
        })
    end)
    end
end, false)

--[[RegisterCommand('announce', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(7)
    if player ~= false then
        local user = GetPlayerName(src)
            TriggerClientEvent('chat:addMessages', -1, {
            template = '<div class="chat-message server"><b>Anúncio:</b> {0}</div>',
            args = { msg }
        })
    end
end, false)
]]--

RegisterCommand('say', function(source, args, rawCommand)
    --TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
	local message = rawCommand:sub(5)
	local source = tonumber(source)
	if (source == 0) then
	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message server"><b>SERVIDOR</b>: ' .. message .. '</div>',
        args = { message }
    })
	end
end)

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier
	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
		data(result[1].firstname, result[1].lastname)
	end)
end