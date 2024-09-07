local dir = (shared.VapePrivate and "vapeprivate/" or shared.catvape and 'catvape/' or "vape/")
loadfile = loadfile or function(file)
    return loadstring(readfile(file))
end
return loadfile(`{dir}NewMainScript.lua`)()