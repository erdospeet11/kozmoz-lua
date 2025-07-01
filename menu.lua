local class = require 'middleclass'
local Scene = require 'scene'

-- Base Class Scene
local MenuScene = class('MenuScene', Scene)

function MenuScene:initialize()
    
end

function MenuScene:draw()
    love.graphics.print("Menu", 10, 10)
    love.graphics.rectangle("fill", (love.graphics.getWidth()-400)/2, (love.graphics.getHeight()-120)/2, 400, 120)
end

return MenuScene