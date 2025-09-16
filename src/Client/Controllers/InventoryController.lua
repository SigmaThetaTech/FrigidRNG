--!nocheck
-- Authors: ΣTΞCH (SigmaTech)
-- InventoryController

local Players = game:GetService("Players")

local React = require("@Packages/React")
local ReactRoblox = require("@Packages/ReactRoblox")

local App = require(script.Parent.Parent.Components.Inventory.App)

local InventoryController = {}

local root: any? = nil

function InventoryController:InterlaceInit()
    -- no-op for now
end

function InventoryController:InterlaceStart()
    local playerGui: PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui

    local screen = Instance.new("ScreenGui")
    screen.Name = "Inventory"
    screen.ResetOnSpawn = false
    screen.IgnoreGuiInset = true
    screen.DisplayOrder = 10
    screen.Parent = playerGui

    root = ReactRoblox.createRoot(screen)
    root:render(React.createElement(App, {}))
end

return InventoryController


