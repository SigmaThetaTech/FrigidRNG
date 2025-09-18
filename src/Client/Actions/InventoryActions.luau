

local InventoryActions = {}

function InventoryActions.SellItem(marketHashName: string)
    local Network = require("@Network")
	Network.SellItem:FireServer(marketHashName)
end

return InventoryActions


