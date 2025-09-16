local React = require("@Packages/React")

local Sidebar = require(script.Parent.Sidebar)
local Grid = require(script.Parent.Grid)

export type Skin = {
    id: string,
    name: string,
    image: string?,
    price: number?,
    wearShort: string?,
    rarityColor: Color3?,
    rarityName: string?,
    patternName: string?,
    subPatternName: string?,
}

export type SortMode = "Newest" | "Price" | "Rarity" | "Cheapest"

return function()
    local sortMode, setSortMode = React.useState("Newest" :: SortMode)
    local autoSell, setAutoSell = React.useState(0)
    local quickSellColor, setQuickSellColor = React.useState(nil :: string?)

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
    }, {
        layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 16),
        }),

        sidebar = React.createElement(Sidebar :: any, {
            sortMode = sortMode,
            onSortModeChanged = setSortMode,
            autoSell = autoSell,
            onAutoSellChanged = setAutoSell,
            onQuickSellColor = setQuickSellColor,
        }),

        grid = React.createElement(Grid :: any, {
            LayoutOrder = 2,
            sortMode = sortMode,
            quickSellColor = quickSellColor,
            autoSell = autoSell,
        }),
    })
end


