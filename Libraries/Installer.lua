local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Window = lib:MakeWindow({
  Title = "Cat Vape Installer",
  SubTitle = ""
})

local Tab1 = Window:MakeTab({"Installer", ""})

local Paragraph = Tab1:AddParagraph({"Progress Monitor", "This is a Paragraph"})

Paragraph:Set("Progress: 0%, Waiting")

local butt
butt = Tab1:AddButton({"Install", function()
    local hm = "Waiting"
    local prog = 0
    task.spawn(function()
        repeat
            task.wait(0.005)
            Paragraph:Set("Progress: "..prog.."%, "..hm)
        until false
    end)
    local cloneref = cloneref or function(instance) return instance end
    local baseDirectory = (shared.VapePrivate and "vapeprivate" or shared.catvape and 'catvape' or "vape")
    local httpservice = cloneref(game.GetService(game, 'HttpService'))
    local API = loadstring(game:HttpGet("https://raw.githubusercontent.com/qwertyui-is-back/CatV5/main/Libraries/API.lua", true))()
    
    local function WriteFiles(link) -- main, libraries, games, assets
        local files = "/"..link
        local gitfiles = "/"
        if link ~= "main" then gitfiles = "/"..link.."/" end
        if link == "games" then gitfiles = "/CustomModules/" end
        if link == "libraries" then gitfiles = "/Libraries/" end
        API.New("files"..files,"GET",true)
        for i,v in API.Get("files") do
            pcall(function() 
                writefile(baseDirectory..gitfiles..v, game:HttpGet("https://raw.githubusercontent.com/qwertyui-is-back/CatV5/main"..gitfiles..v, true))
                task.wait(0.1)
                prog = prog + 1
            end)
        end
    end

    WriteFiles("main")
    hm = "Installing main files"
    for i = 0, 40 do prog = prog + 1 task.wait(0.05) end
    hm = "Installing libraries"
    WriteFiles("libraries")
    for i = 0, 20 do prog = prog + 1 task.wait(0.05) end
    hm = "Installing games"
    WriteFiles("games")
    for i = 0, 10 do prog = prog + 1 task.wait(0.05) end
    hm = "Installing assets"
    WriteFiles("assets")
    for i = 0, 5 do prog = prog + 1 task.wait(0.05) end
    task.wait(0.75)
    hm = "Finished! You may now close this window."
    butt:Destroy()
end})