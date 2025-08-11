local class = require 'middleclass'

-- Base Card class
local Card = class('Card')

---@param x number
---@param y number
---@param id number
function Card:initialize(x,y,id)
    self.x = x
    self.y = y
    self.id = id
    self.image = love.graphics.newImage("test.png")
end

function Card:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.35, 0.35)
end

function Card:cursorinBounds()
    local mousePos = love.mouse.getPosition()
    print(mousePos)
end

return Card