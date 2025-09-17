--!nocheck
local React = require("@Packages/React")

local SkinCard = require(script.Parent.SkinCard)
local SellActions = require(script.Parent.modules.SellActions)

type Props = {
    sortMode: string,
    quickSellColor: string?,
    autoSell: number,
    LayoutOrder: number?,
}

local mockSkins = table.create(30)
for i = 1, 30 do
    mockSkins[i] = {
        id = "skin-" .. i,
        name = "★ StatTrak | Butterfly Knife",
        price = 99999.99,
        wearShort = (i % 2 == 0) and "FN" or "FT",
        rarityColor = Color3.fromRGB(244, 197, 58),
        rarityName = "Covert",
        patternName = "Doppler",
        subPatternName = "Ruby",
    }
end

local function sortSkins(list, mode)
    local arr = table.clone(list)
    if mode == "Newest" then
        table.sort(arr, function(a, b): boolean
            return tostring(a.id) > tostring(b.id)
        end)
    elseif mode == "Price" then
        table.sort(arr, function(a, b): boolean
            return (a.price or 0) > (b.price or 0)
        end)
    elseif mode == "Cheapest" then
        table.sort(arr, function(a, b): boolean
            return (a.price or 0) < (b.price or 0)
        end)
    elseif mode == "Rarity" then
        table.sort(arr, function(a, b): boolean
            return (a.rarityName or "") < (b.rarityName or "")
        end)
    end
    return arr
end

return function(props: Props)
    local skins, _setSkins = React.useState(mockSkins)

    React.useEffect(function()
        if props.quickSellColor then
            SellActions.quickSellByColor(props.quickSellColor)
        end
    end, { props.quickSellColor })

    local sorted = React.useMemo(function()
        return sortSkins(skins, props.sortMode)
    end, { skins, props.sortMode })

    local children: any = {}
    for i, skin in sorted do
        children["skin_"..i] = React.createElement(SkinCard :: any, {
            skin = skin,
            onSell = function(s)
                SellActions.sellSkin(s)
            end,
        })
    end

    children.layout = React.createElement("UIGridLayout", {
        CellPadding = UDim2.fromOffset(16, 16),
        CellSize = UDim2.fromOffset(216, 166),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirectionMaxCells = 4,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
    })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.193495, 0.233879),
        Size = UDim2.fromScale(0.681656, 0.752311),
        LayoutOrder = props.LayoutOrder,
    }, {
        scrolling = React.createElement("ScrollingFrame", {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ScrollBarImageColor3 = Color3.new(),
            ScrollBarThickness = 10,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Selectable = false,
            Size = UDim2.fromScale(1, 1),
        }, table.clone(children))
    })
end


