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

    -- Fetch first 50 skins from server and map them into inventory items
    local initialItems = {}
    local skins = (Network.GetSkins :: any):InvokeServer()
    if typeof(skins) == "table" then
        local count = 0
        for _, s in skins do
            if typeof(s) == "table" and s.name and s.image and s.market_hash_name then
                local wearObj = nil
                if typeof(s.wear) == "table" and s.wear.id and s.wear.name then
                    wearObj = {
                        id = tostring(s.wear.id),
                        name = tostring(s.wear.name),
                    }
                end

                local rarityObj = nil
                if typeof(s.rarity) == "table" and s.rarity.id and s.rarity.name then
                    rarityObj = {
                        id = tostring(s.rarity.id),
                        name = tostring(s.rarity.name),
                        color = tostring(s.rarity.color or ""),
                    }
                end

                table.insert(initialItems, {
                    market_hash_name = tostring(s.market_hash_name),
                    name = tostring(s.name),
                    stattrak = (s.stattrak == true),
                    wear = wearObj,
                    rarity = rarityObj,
                    image = tostring(s.image),
                })
                count += 1
                if count >= 50 then break end
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

