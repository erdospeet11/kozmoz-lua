local class = require 'middleclass'

-- Baes Class Scene
---@class Scene
local Scene = class('Scene')

function Scene:draw()
    love.graphics.setBackgroundColor(0.1,0.2,0.3,1)
end