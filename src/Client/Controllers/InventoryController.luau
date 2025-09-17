--!strict
-- Authors: ΣTΞCH (SigmaTech)
-- September 17, 2025
--[[
	InventoryController.luau

	Description:
		Mounts the Inventory React app into PlayerGui using ReactRoblox.
]]

local InventoryController = {}

--Σ Services Σ--
local Players = game:GetService("Players")

--Σ Requires Σ--
local React = require("@Packages/React")
local ReactRoblox = require("@Packages/ReactRoblox")

--Σ Constants Σ--
local LOCAL_PLAYER: Player = Players.LocalPlayer

--Σ Volatiles Σ--
local _root: any? = nil

--------------------------------------------------------------------------------
--MARK: Lifecycle Methods
--------------------------------------------------------------------------------

function InventoryController:InterlaceInit()
end

function InventoryController:InterlaceStart()
    local playerGui = LOCAL_PLAYER:WaitForChild("PlayerGui") :: PlayerGui

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "InventoryScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local Inventory = require("@Client/Views/Inventory") :: any

    _root = ReactRoblox.createRoot(screenGui)
    _root:render(React.createElement(Inventory))
end

return InventoryController

