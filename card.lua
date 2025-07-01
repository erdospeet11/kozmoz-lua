local class = require 'middleclass'

-- Base Card class
local Card = class('Card')

function Card:initialize(x,y,image,id)
    self.x = x
    self.y = y
    self.image = image
    self.id = id
end

function Card:draw()
    pass
end