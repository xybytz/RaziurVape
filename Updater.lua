local cloneref = cloneref or function(instance) return instance end
local baseDirectory = (shared.VapePrivate and "vapeprivate/" or shared.catvape and 'catvape/' or "vape/")
local httpservice = cloneref(game.GetService(game, 'HttpService'))

local function run(func)
    func()
end

local latest = false

local API = loadfile(baseDirectory.."Libraries/API.lua")

run(function()
    API.New("version", "GET", true)
    if not isfile(baseDirectory.."version.txt") then
        writefile(baseDirectory.."version.txt", API.Get("version"))
        latest = true
    else
        local version = readfile(baseDirectory.."version.txt")
        if API.Get("version") >= version then
            latest = false
            warn("Old version detected!")
        end
    end
end)

return latest