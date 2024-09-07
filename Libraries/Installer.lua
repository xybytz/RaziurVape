local cloneref = cloneref or function(instance) return instance end
local baseDirectory = (shared.VapePrivate and "vapeprivate/" or shared.catvape and 'catvape/' or "vape/")
local httpservice = cloneref(game.GetService(game, 'HttpService'))
local API = loadfile(baseDirectory.."Libraries/API.lua")

local function WriteFiles(link) -- main, libraries, games, assets
    local files = "/"..link
    local gitfiles = "/"
    if link ~= "main" then gitfiles = "/"..link.."/" end
    if link == "games" then gitfiles = "/CustomModules/" end
    if link == "libraries" then gitfiles = "/Libraries/" end
    API.New("files"..files,"GET",true)
    for i,v in API.Get("files") do
        pcall(function() 
            writefile("installer/"..v, game:HttpGet("https://raw.githubusercontent.com/qwertyui-is-back/CatV5/main"..gitfiles..v, true))
        end)
    end
end

WriteFiles("main")
WriteFiles("libraries")
WriteFiles("games")
WriteFiles("assets")