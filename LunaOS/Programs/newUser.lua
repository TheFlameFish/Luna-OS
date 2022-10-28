args = {...}
username = args[1]
password = args[2]
isTerminal = args[3]

if not fs.exists("users/"..username) then

	fs.makeDir("users/"..username)
	local userDir = "users/"..username

	fs.makeDir(userDir.."/userSettings")
	local userSettings = userDir.."/userSettings"
	
	-- Create user accessible userData stores 
	local passFile = fs.open(userSettings.."/password.txt", "w")
	passFile.writeLine(password)
	passFile.close()

	local otherFile = fs.open(userSettings.."/otherSettings.txt", "w")
	
	otherFile.close()

	local pinnedFiles = fs.open(userSettings.."/pinnedFiles.txt", "w")
	pinnedFiles.close()


	-- Create local directories
	downloads = fs.makeDir(userDir.."/Downloads")
	programs = fs.makeDir(userDir.."/Programs")
	docs = fs.makeDir(userDir.."/Documents")
	desktop = fs.makeDir(userDir.."/Desktop")

	-- Set up non-user accessible userData stores
	aUserData = "LunaOS/adminOnly/userData"

	local userList = fs.open(aUserData.."/userList.txt", "a")
	userList.writeLine(username)
	userList.close()
	-- Gets the userID and then sets it up for the next user.
	local nextIdFile = fs.open("users/nextId.txt", "r")
	local userID = nextIdFile.readLine()
	nextIdFile.close()

	local nextIdFile = fs.open("users/nextId.txt", "w")
	nextIdFile.writeLine(userID + 1)
	nextIdFile.close()
	
	-- Now back to setting up non-user accessible userData stores
	local userIds = fs.open(aUserData.."/userIds.txt", "a")
	userIds.writeLine(userID)
	userIds.close()
	
	-- Check if this is the first user and if so make them an admin
	if userID == "0" then
		local admins = fs.open(aUserData.."/admins.txt", "a")
		admins.writeLine(userID)
		admins.close()
	end

	if not isTerminal == nil then
		if isTerminal == true then
			print("User has been created!")
		end
	end



else
	if not isTerminal == nil then
		if isTerminal == true then
			print("That username is already taken!")
		end
	end
end