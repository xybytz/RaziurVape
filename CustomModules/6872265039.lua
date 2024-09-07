local vape = vape
local GuiLibrary = vape.gui
local cloneref = cloneref or function(...) return (...) end
local players = cloneref(game.GetService(game, 'Players'))
local textservice = cloneref(game.GetService(game, 'TextService'))
local lighting = cloneref(game.GetService(game, 'Lighting'))
local textchat = cloneref(game.GetService(game, 'TextChatService'))
local inputservice = cloneref(game.GetService(game, 'UserInputService'))
local runservice = cloneref(game.GetService(game, 'RunService'))
local tweenservice = cloneref(game.GetService(game, 'TweenService'))
local collection = cloneref(game.GetService(game, 'CollectionService'))
local replicatedstorage = cloneref(game.GetService(game, 'ReplicatedStorage'))
local vapeconnections = {}
local camera = workspace.CurrentCamera or Instance.new('Camera', workspace)
local lplr = players.LocalPlayer

table.insert(vapeconnections, workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	camera = workspace.CurrentCamera or Instance.new('Camera', workspace)
end))

GuiLibrary.RemoveObject('SilentAimOptionsButton')
GuiLibrary.RemoveObject('MouseTPOptionsButton')
GuiLibrary.RemoveObject('ReachOptionsButton')
GuiLibrary.RemoveObject('HitBoxesOptionsButton')
GuiLibrary.RemoveObject('KillauraOptionsButton')
GuiLibrary.RemoveObject('LongJumpOptionsButton')
GuiLibrary.RemoveObject('HighJumpOptionsButton')
GuiLibrary.RemoveObject('SafeWalkOptionsButton')
GuiLibrary.RemoveObject('TriggerBotOptionsButton')
GuiLibrary.RemoveObject('AutoClickerOptionsButton')
GuiLibrary.RemoveObject('ClientKickDisablerOptionsButton')

local sprintcontroller
run(function()
	local knitgotten, knitclient
	repeat
		knitgotten, knitclient = pcall(function()
			return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
		end)
		if knitgotten then break end
		task.wait()
	until knitgotten
    sprintcontroller = knitclient.Controllers.SprintController
end)


run(function()
    local sprint = {}
    local old
    sprint = vape.windows.combat.CreateOptionsButton({
        Name = 'Sprint',
        Function = function(call)
            if call then
                old = getmetatable(sprintcontroller).stopSprinting
                getmetatable(sprintcontroller).stopSprinting = function() end
                table.insert(sprint.Connections, runservice.Stepped:Connect(function()
                    if not vape.istoggled('FOVChanger') then
                        getmetatable(sprintcontroller).startSprinting(sprintcontroller)
                    end
                end))
            else
                getmetatable(sprintcontroller).stopSprinting = old
            end
        end
    })
end)

run(function()
    local autogamble = {}
    local getattribute = function(id)
        local altar = workspace:FindFirstChild(`CrateAltar_{id}`)
        local model = altar:FindFirstChildWhichIsA('Model')
        if model then
            return tostring(model:GetAttribute('crateId'))
        else
            return nil and warningNotification('CatV5', 'Crate not found.', 5)
        end
    end
    local spawncrate = replicatedstorage.rbxts_include.node_modules['@rbxts'].net.out._NetManaged['RewardCrate/SpawnRewardCrate']
    local opencrate = replicatedstorage.rbxts_include.node_modules['@rbxts'].net.out._NetManaged['RewardCrate/OpenRewardCrate']
    autogamble = vape.windows.blatant.CreateOptionsButton({
        Name = 'AutoGamble',
        Function = function(call)
            if call then
                repeat
                    for i = 0,1 do
                        spawncrate:FireServer({
                            crateType = 'level_up_crate',
                            altarId = i
                        }) 
                        task.wait(2)
                        local attribute = getattribute(i)
                        opencrate:FireServer({
                            crateId = attribute
                        })
                    end
                    task.wait(1)
                until (not autogamble.Enabled)
            end
        end,
        HoverText = 'Automatically opens crate for you \n(inspired by vape rewrite)'
    })
end)