local class = require 'middleclass'
local Player = require 'player'

local player = Player:new(100, 100, "hello", {})

function love.load()
    
end

function love.draw()
    player:draw()
end