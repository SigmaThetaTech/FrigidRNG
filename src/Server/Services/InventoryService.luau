--!strict
-- Authors: ΣTΞCH (SigmaTech)
-- September 17, 2025
--[[
	InventoryService.server.luau

	Description:
		Listens for SellItem events and handles selling logic. For now this
		example just prints; integrate with your economy as needed.
]]

--Σ Requires Σ--
local Network = require("@Network")

local InventoryService = {}

function InventoryService:InterlaceInit()
    (Network.SellItem :: any).OnServerEvent:Connect(function(player: Player, marketHashName: string)
        print(string.format("[SellItem] %s requested sale of %s", player.Name, tostring(marketHashName)))
        -- TODO: integrate with inventory/economy systems
    end)
end

function InventoryService:InterlaceStart()
end

return InventoryService


