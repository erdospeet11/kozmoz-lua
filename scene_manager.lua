local class = require 'middleclass'
local MenuScene = require 'menu'
local BattleScene = require 'battle'

-- Base Player Class
local SceneManager = class('SceneManager')

function SceneManager:initialize()
    local battle = BattleScene:new()
    local menu = MenuScene:new()
    
    self.scenes = {
        battle = battle,
        menu = menu
    }

    self.current_scene = menu
    
end

function SceneManager:draw()
    self.current_scene:draw()
end

function SceneManager:change_scene(scene)
    if scene == "battle" then
        self.current_scene = self.scenes["battle"]
    end
end

return SceneManager