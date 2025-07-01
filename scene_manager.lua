local class = require 'middleclass'
local Scene = require 'scene'


-- Base Player Class
local SceneManager = class('SceneManager')

---@param start_scene Scene
---@param scenes Scene[]
function SceneManager:initialize()
    self.current_scene =
    self.scenes = scenes
end

function SceneManager:draw()
    self.current_scene:draw()
end

return Player