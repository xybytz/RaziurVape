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
local vapeInjected = true

table.insert(vapeconnections, workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	camera = workspace.CurrentCamera or Instance.new('Camera', workspace)
end))

run(function() 
    local vapemodule = {};
    local vapeslider = {};
    local vapetextbox = {};
    local vapetoggle = {};
    vapemodule = vape.windows.combat.CreateOptionsButton({
        Name = 'vapemodule',
        Function = function(call)
            if call then
                repeat
                    print('hi')
                    task.wait()
                until not vapemodule.Enabled
            end
        end,
        HoverText = 'a vape module.'
    })
    vapetoggle = vapemodule.CreateToggle({
        Name = 'vapetoggle',
        Function = function() end,
        Default = true
    })
    vapeslider = vapemodule.CreateSlider({
        Name = 'vapeslider',
        Min = 1,
        Max = 100,
        Function = function(val) end,
        Default = 50
    })
    vapetextbox = vapemodule.CreateTextBox({
        Name = 'vapetextbox',
        Function = function(enter)
            if not enter then return end
            print('Inserted')
        end
    })
end)