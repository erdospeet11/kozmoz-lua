--[[

local class = require 'middleclass'

-- Base GameObject class
local GameObject = class('GameObject')

GameObject.static.speed = 100

---@param x number
---@param y number
---@param width number
---@param height number
---@param color any
function GameObject:initialize(x, y, width, height, color)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 32
    self.height = height or 32
    self.color = color or {1, 1, 1}
    self.speed = 100
end

function GameObject:update(dt)
    -- Override in subclasses
end

function GameObject:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function GameObject:getBounds()
    return self.x, self.y, self.width, self.height
end

function GameObject:checkCollision(other)
    local x1, y1, w1, h1 = self:getBounds()
    local x2, y2, w2, h2 = other:getBounds()
    
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

-- Player class
local Player = class('Player', GameObject)

function Player:initialize(x, y)
    GameObject.initialize(self, x, y, 32, 32, {0, 1, 0}) -- Green player
    self.speed = 200
end

function Player:update(dt)
    -- Movement controls
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.y = self.y + self.speed * dt
    end
    
    -- Keep player on screen
    self.x = math.max(0, math.min(love.graphics.getWidth() - self.width, self.x))
    self.y = math.max(0, math.min(love.graphics.getHeight() - self.height, self.y))
end

-- Enemy class
local Enemy = class('Enemy', GameObject)

function Enemy:initialize(x, y)
    GameObject.initialize(self, x, y, 24, 24, {1, 0, 0}) -- Red enemy
    self.speed = 50
    self.direction = math.random() * math.pi * 2
    self.changeDirectionTimer = 0
end

function Enemy:update(dt)
    -- Change direction occasionally
    self.changeDirectionTimer = self.changeDirectionTimer + dt
    if self.changeDirectionTimer > 2 then
        self.direction = math.random() * math.pi * 2
        self.changeDirectionTimer = 0
    end
    
    -- Move
    self.x = self.x + math.cos(self.direction) * self.speed * dt
    self.y = self.y + math.sin(self.direction) * self.speed * dt
    
    -- Bounce off edges
    if self.x < 0 or self.x > love.graphics.getWidth() - self.width then
        self.direction = math.pi - self.direction
        self.x = math.max(0, math.min(love.graphics.getWidth() - self.width, self.x))
    end
    if self.y < 0 or self.y > love.graphics.getHeight() - self.height then
        self.direction = -self.direction
        self.y = math.max(0, math.min(love.graphics.getHeight() - self.height, self.y))
    end
end

-- Collectible class
local Collectible = class('Collectible', GameObject)

function Collectible:initialize(x, y)
    GameObject.initialize(self, x, y, 16, 16, {1, 1, 0}) -- Yellow collectible
    self.bobOffset = math.random() * math.pi * 2
    self.originalY = y
end

function Collectible:update(dt)
    -- Bob up and down
    self.bobOffset = self.bobOffset + dt * 3
    self.y = self.originalY + math.sin(self.bobOffset) * 5
end

-- Game variables
local player
local enemies = {}
local collectibles = {}
local score = 0
local gameState = "playing" -- "playing" or "gameover"

function love.load()
    love.window.setTitle("Love2D + Middleclass Demo")
    love.graphics.setBackgroundColor(0.1, 0.1, 0.2)
    
    -- Create player
    player = Player:new(100, 100)
    
    -- Create enemies
    for i = 1, 5 do
        local enemy = Enemy:new(
            math.random(50, love.graphics.getWidth() - 50),
            math.random(50, love.graphics.getHeight() - 50)
        )
        table.insert(enemies, enemy)
    end
    
    -- Create collectibles
    for i = 1, 8 do
        local collectible = Collectible:new(
            math.random(20, love.graphics.getWidth() - 20),
            math.random(20, love.graphics.getHeight() - 20)
        )
        table.insert(collectibles, collectible)
    end
end

function love.update(dt)
    if gameState == "playing" then
        -- Update player
        player:update(dt)
        
        -- Update enemies
        for _, enemy in ipairs(enemies) do
            enemy:update(dt)
            
            -- Check collision with player
            if player:checkCollision(enemy) then
                gameState = "gameover"
            end
        end
        
        -- Update collectibles and check collection
        for i = #collectibles, 1, -1 do
            local collectible = collectibles[i]
            collectible:update(dt)
            
            if player:checkCollision(collectible) then
                table.remove(collectibles, i)
                score = score + 10
                
                -- Check win condition
                if #collectibles == 0 then
                    gameState = "win"
                end
            end
        end
    end
end

function love.draw()
    -- Draw game objects
    if gameState == "playing" or gameState == "win" then
        player:draw()
        
        for _, enemy in ipairs(enemies) do
            enemy:draw()
        end
        
        for _, collectible in ipairs(collectibles) do
            collectible:draw()
        end
    end
    
    -- Draw UI
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.print("Use WASD or Arrow Keys to move", 10, 30)
    love.graphics.print("Collect yellow squares, avoid red enemies!", 10, 50)
    
    if gameState == "gameover" then
        love.graphics.printf("GAME OVER! Press R to restart", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    elseif gameState == "win" then
        love.graphics.printf("YOU WIN! Press R to restart", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    end
end

function love.keypressed(key)
    if key == "r" and (gameState == "gameover" or gameState == "win") then
        -- Restart game
        score = 0
        gameState = "playing"
        love.load()
    elseif key == "escape" then
        love.event.quit()
    end
end

]]