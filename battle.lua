local class = require 'middleclass'
local Scene = require 'scene'

-- Baes Class Scene
local BattleScene = class('BattleScene', Scene)

function BattleScene:initialize()
    
end

function BattleScene:draw()
    love.graphics.print("Battle", 10, 10)
    love.graphics.setBackgroundColor(0.5,0.8,0.6,1)
end


return BattleScene