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
local Network = require("@Network")
local Types = require("@SharedModules/Types")

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

    -- Fetch skins from server and map them into inventory items
    local initialItems: { Types.SkinItem } = {}
    local skins = (Network.GetSkins :: any):InvokeServer()
    if typeof(skins) == "table" then
        local count = 0
        for _, skinItem: Types.SkinItem in skins do
            if typeof(skinItem) == "table" and skinItem.name and skinItem.image and skinItem.market_hash_name then
                print("Inserting skinItem", skinItem)
                table.insert(initialItems, skinItem)
                count += 1
                if count >= 2000 then break end
            end
        end
    end

    _root = ReactRoblox.createRoot(screenGui)
    -- Provide state with initial items and render the Inventory content as child
    local InventoryState = require("@Client/State/InventoryState")
    -- Compose the tree using the helper that wraps with the provider
    _root:render((InventoryState.Wrap(React.createElement(Inventory), initialItems)) :: any)
end

return InventoryController

