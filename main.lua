local class = require 'middleclass'
local Player = require 'player'
local Card = require 'card'
local Scene = require 'scene'
local BattleScene = require 'battle'
local MenuScene = require 'menu'
local SceneManager = require 'scenemanager'

-- local player = Player:new(100, 100, "hello", {})
-- local card = Card:new(200,200,0)
local scene_manager = SceneManager:new()
local menu = MenuScene:new()
local battle = BattleScene:new()

function love.load()
    
end

function love.draw()
    scene_manager:draw()
    -- love.graphics.rectangle("fill", 0, 0, 100, 100)
    -- love.graphics.rectangle("fill", (love.graphics.getWidth()-200)/2, (love.graphics.getHeight()-100)/2, 200,100)

    -- player:draw()
    -- card:draw()
end