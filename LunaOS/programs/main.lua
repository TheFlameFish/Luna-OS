args = {...}
local user = args[1]
local userDir = ("users/"..user)
local openWins = {}

local session = "LunaOS/Session/"




local basalt = require("../../basalt")

local main = basalt.createFrame("main")
    :setBackground(colors.lightGray)

local termX,termY = term.getSize()
main:show()

  -- create taskbar
taskbar = main:addMenubar()
    :setSize(termX - 5, 1)
    :setPosition(6,termY)
    :setBackground(colors.lightBlue)
    :setScrollable(true)
    --:setSpace(3)
local onChangeActive = true
home = main:addButton()
    :setPosition(1,termY)
    :setSize(8, 1)
    :setText("Home")
    :setBackground(colors.blue)


function fillTaskbar()
    local pinnedFile = fs.open(userDir.."/userSettings/pinnedFiles.txt","r")
    taskbar:clear()

    local pinned = {}
    while true do
        local line = pinnedFile.readLine()
        pinnedFile.readLine()


        if not line then break end

        pinned[#pinned + 1] = line


    end
    pinnedFile.close()
    taskbar:addItem("x")
    for i, o in ipairs(pinned) do
        taskbar:addItem(o,colors.green)
    end



end
fillTaskbar()



function windowHandler(program, name, sizeX, sizeY)
    sizeX = sizeX or 30
    sizeY = sizeY or 13



    local programOpen = false
    
    if openWins[program] then
        programOpen = true
    end
    
    if programOpen == true then
        main.setFocusedObject(_G[program])
        _G[program]:show()
        onChangeActive = false
        fillTaskbar()
        onChangeActive = true
    else
        _G[program] = main:addFrame()
            :setSize(sizeX,sizeY)
            :setBar(name or program)
            :showBar()
            :setPosition(10,7)
            :setMovable(true)
        onChangeActive = false
        fillTaskbar()
        onChangeActive = true
        --programFile = fs.open(program,"r")
        --local programFirst = programFile.readLine()

        --if programFirst == "--madeForLuna" then
        --    local programName = programFile.readLine()
        --    _G[program]:setBar(programName)
        --end 
        --programFile.close()

        local programObj = _G[program]:addProgram()
            :setSize(sizeX, sizeY - 1)
            :setPosition(1,2)
            :execute(program)
        openWins[program] = true
        local closeBut = _G[program]:addButton()
            :onClick(function ()
                _G[program]:remove()

                if openWins[program] ~= nil then
                    openWins[program] = nil
                end
                _G[program] = nil

            end)
            :setText("X")
            :setBackground(colors.red)
            :setForeground(colors.black)
            :setPosition(sizeX, 1)
            :setSize(1,1)
        local miniBut = _G[program]:addButton()
            :onClick(function ()
                _G[program]:hide()
            end)
            :setText("-")
            :setBackground(colors.blue)
            :setForeground(colors.black)
            :setPosition(sizeX - 1, 1)
            :setSize(1,1)


        do return(_G[program]) end
        do return(sizeX..","..sizeY) end
        return(name or program)
    end


end

taskbar:onChange(function (self, val)
    if onChangeActive == false then
        return
    else
        local selectedIndex = (self:getItemIndex() - 1)
        local pinnedFile = fs.open(userDir.."/userSettings/pinnedFiles.txt","r")
        --local allPinned = {}
        --allPinned = pinnedFile.readAll()
        local pinned = {}
        local i = 1
        while true do
            pinnedFile.readLine()
            local line = pinnedFile.readLine()


            if not line then break end

            pinned[i] = line

            i = i + 1
        end
        pinnedFile.close()
        local dir = pinned[selectedIndex]
        local window,size,name = windowHandler(dir)
        --basalt.debug(size or "nil") nil
        --basalt.debug(name or "nil") nil
        --basalt.debug(dir) wrong directory but still spawning frame?
    end
end)


-- luna api functions --
local luna = {}

function luna.changeSize(sizeX,sizeY)
    
end

basalt.autoUpdate()

basalt.autoUpdate()
