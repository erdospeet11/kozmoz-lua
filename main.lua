local class = require 'middleclass'
local SceneManager = require 'scene_manager'
--local Player = require 'player'
local Card = require 'card'
--local Scene = require 'scene'

local scene_manager = SceneManager:new()
local card = Card:new()

function love.load()
end

function love.update(dt)
    print("current scene:", scene_manager.current_scene)    
end


function love.draw()
    scene_manager:draw()
    --card:draw()
    card:draw()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        scene_manager:change_scene("battle")
   end
end