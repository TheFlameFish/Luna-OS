local basalt = require("../../basalt")

local main = basalt.createFrame("main")
    :setBackground(colors.lightGray)

main:show()

taskbar = main:addMenubar()
    :setSize(45, 1)
    :setPosition(6,19)
    :setBackground(colors.lightBlue)
home = main:addButton()
    :setPosition(1,19)
    :setSize(6, 1)
    :setText("Home")
    :setBackground(colors.blue)
