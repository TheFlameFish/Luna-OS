args = {...}
local user = args[1]
userDir = ("users/"..user)

local luna = {}

local basalt = require("../../basalt")

local main = basalt.createFrame("main")
    :setBackground(colors.lightGray)

local termX,termY = term.getSize()
main:show()

  -- create taskbar
taskbar = main:addMenubar()
    :setSize(termX - 6, 1)
    :setPosition(7,termY)
    :setBackground(colors.lightBlue)
    :setScrollable(true)
    :setSpace(3)
home = main:addButton()
    :setPosition(1,termY)
    :setSize(6, 1)
    :setText("Home")
    :setBackground(colors.blue)

function fillTaskbar()
    pinnedFile = fs.open(userDir.."/userSettings/pinnedFiles.txt","r")
   
    local pinned = {}
    while true do
        local line = pinnedFile.readLine()
        pinnedFile.readLine()
      
        -- If line is nil then we've reached the end of the file and should stop
        if not line then break end
      
        pinned[#pinned + 1] = line

        
    end
    taskbar:addItem("Term", colors.black, colors.green)
    for i, o in ipairs(pinned) do
        taskbar:addItem(o,colors.green)
    end
    


end
fillTaskbar()



-- luna api functions --

function luna.changeSize(sizeX,sizeY)
    
end

basalt.autoUpdate()
