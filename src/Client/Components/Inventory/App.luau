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
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromOffset(1920, 1080),
    }, {
        aspect = React.createElement("UIAspectRatioConstraint", { AspectRatio = 1920/1080 }),

        title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy),
            Position = UDim2.fromScale(0.418896, 0.122469),
            Size = UDim2.fromScale(0.157029, 0.062536),
            Text = "Inventory",
            TextColor3 = Color3.new(1,1,1),
            TextScaled = true,
        }, { stroke = React.createElement("UIStroke", { Thickness = 1.5, Transparency = 0.5 }) }),

        buttons = React.createElement(Sidebar :: any, {
            sortMode = sortMode,
            onSortModeChanged = setSortMode,
            autoSell = autoSell,
            onAutoSellChanged = setAutoSell,
            onQuickSellColor = setQuickSellColor,
        }),

        skinBox = React.createElement(Grid :: any, {
            LayoutOrder = 2,
            sortMode = sortMode,
            quickSellColor = quickSellColor,
            autoSell = autoSell,
        }),
    })
end


