-- Make directories
print("creating directories...")
os.sleep(1)
print("LunaOS/programs")
fs.makeDir("LunaOS/programs")
print("LunaOS/adminOnly")
fs.makeDir("LunaOS/adminOnly")
print("LunaOS/Sattelyte")
print("LunaOS/Sattelyte/local")
fs.makeDir("LunaOS/Sattelyte/local")
print("LunaOS/Sattelyte/local/Cache")
fs.makeDir("LunaOS/Sattelyte/local/Cache")
print("LunaOS/Sattelyte/local/home")
fs.makeDir("LunaOS/Sattelyte/local/home")
print("users")
fs.makeDir("users")
os.sleep(2)

-- create some files
print("Creating files...")
os.sleep(3)

local nextId = fs.open("users/nextId.txt","w")
nextId.writeLine("0")
nextId.close()
print("nextId.txt")

local cachedSites = fs.open("LunaOS/Sattelyte/local/Cache/cachedSites.txt", "w")
cachedSites.close()
print("cachedSites.txt")

local visitedSites = fs.open("LunaOS/Sattelyte/local/Cache/chachedSites.txt", "w")
visitedSites.close()
print("visitedSites.txt")
os.sleep(1)
-- Grab other files from Github
print("Getting remaining files from Github...")
os.sleep(3)

local mainRequest = http.get("https://raw.githubusercontent.com/TheFlameFish/Luna-OS/Dev/LunaOS/programs/main.lua")

local mainFile = fs.open("LunaOS/programs/main.lua", "w")

local main = {}
--print(mainRequest.readAll())
main.insert(mainRequest.readAll())

for i,o in ipairs(main) do
    mainFile.writeLine(o)
    print(o)
    os.sleep(0.1)
end

mainRequest.close()