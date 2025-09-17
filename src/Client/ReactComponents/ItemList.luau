local React = require("@Packages/React")
local ItemCard = require("@Client/ReactComponents/ItemCard")
local InventoryState = require("@Client/State/InventoryState")

return function()
    local state = InventoryState.use()

    local children: { [string]: any } = {
        uIGridLayout = React.createElement("UIGridLayout", {
            CellPadding = UDim2.fromOffset(10, 50),
            CellSize = UDim2.fromOffset(176, 146),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
    }

    for index, item in state.inventoryItems do
        local key = tostring(index)
        children[key] = React.createElement(ItemCard :: any, {
            market_hash_name = item.market_hash_name,
            name = item.name,
            stattrak = item.stattrak,
            wear = item.wear,
            rarity = item.rarity,
            image = item.image,
        })
    end

    return React.createElement("Frame", {
        Name = "ItemList",
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.193495, 0.233879),
        Size = UDim2.fromScale(0.681656, 0.752311),
    }, {
        scrollingFrame = React.createElement("ScrollingFrame", {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarImageColor3 = Color3.new(),
            ScrollBarThickness = 10,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Selectable = false,
            Size = UDim2.fromScale(1, 1),
        }, children :: any),
    })
end


