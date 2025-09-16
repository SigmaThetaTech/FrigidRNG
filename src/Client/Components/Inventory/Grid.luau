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
        CellPadding = UDim2.fromOffset(12, 12),
        CellSize = UDim2.fromScale(0.23, 0.2),
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirectionMaxCells = 4,
    })

    return React.createElement("ScrollingFrame", {
        LayoutOrder = props.LayoutOrder,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0.78, 0.86),
        CanvasSize = UDim2.new(),
        ScrollBarImageColor3 = Color3.fromRGB(160, 160, 160),
    }, children)
end


