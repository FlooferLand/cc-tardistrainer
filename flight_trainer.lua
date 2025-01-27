-- Launcher and installer for the software
-- Has to be regularly updated over on (INSERT LINK)

-- Paths
local paths = {}
paths.folders = {}
paths.folders.install = "/flight_trainer/"
paths.folders.libs = fs.combine(paths.folders.install, "lib/")
paths.program = fs.combine(paths.folders.install, "program.lua")
paths.library = fs.combine(paths.folders.install, "library.lua")
paths.combine = function(...)
    local result = ""
    for i, a in ipairs(arg) do
        result = result .. "/" .. a
    end
    return result
end

-- Utility
local function install(path, link)
    local req = http.get(link)
    local f = fs.open(path, 'w')
    f.write(req.readAll())
    f.close()
    req.close()
end

-- Making the folders
for i, path in pairs(paths.folders) do
    if not fs.isDir(path) then
        print("Making '"..path.."' folder..")
        fs.makeDir(path)
    end
end

-- Extra files
local f = fs.open(fs.combine(paths.folders.localSongs, "PUT FILES HERE.txt"), 'w')
f.close()

-- Install libraries
if not (fs.exists(".devenv") or fs.exists(paths.combine(paths.folders.install, ".devenv"))) then
    install(paths.program, "https://raw.githubusercontent.com/FlooferLand/cc-media/main/media/program.lua")
    install(paths.library, "https://raw.githubusercontent.com/FlooferLand/cc-media/main/media/library.lua")
else
    print("Developer environment detected")
end
install(paths.jsonlib, "https://gist.githubusercontent.com/tylerneylon/59f4bcf316be525b30ab/raw/7f69cc2cea38bf68298ed3dbfc39d197d53c80de/json.lua")
install(paths.youcubelib, "https://raw.githubusercontent.com/FlooferLand/youcube-client/main/src/lib/youcubeapi.lua")
install(paths.stringpacklib, "https://raw.githubusercontent.com/FlooferLand/youcube-client/main/src/lib/string_pack.lua")

-- Running the program
if not (fs.exists(".owner") or fs.exists(paths.combine(paths.folders.install, ".owner"))) then
    print("Running cc-media (by FlooferLand)")
    sleep(0.8)
end
shell.run(paths.program)

