local class = require 'middleclass'


-- Base Player Class
local Player = class('Player')

---@param x number
---@param y number
---@param classname string
---@param deck any
function Player:initialize(x,y,classname,deck)
    self.x = x
    self.y = y
    self.classname = classname
    self.deck = {}
end

function Player:draw()
    love.graphics.circle("fill",self.x,self.y,20)
end

return Player