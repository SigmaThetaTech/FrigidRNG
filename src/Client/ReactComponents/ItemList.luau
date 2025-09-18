local React = require("@Packages/React")
local ItemCard = require("@Client/ReactComponents/ItemCard")
local Types = require("@SharedModules/Types")

type Props = {
    -- pass a hook so this list can be reused with different stores
    getState: (() -> any)?,
}

local function getPriceFor(prices: any, marketHashName: string): number
    local entry: any = (prices :: any)[marketHashName]
    if typeof(entry) == "table" then
        -- Prefer csfloat vendor when available
        local csfloat: any = (entry :: any)["csfloat"]
        if typeof(csfloat) == "table" then
            local cents: any = csfloat["min_price"]
            if typeof(cents) == "number" then
                return cents
            end
        end
        -- Fallback to steam vendor
        local steam: any = entry["steam"]
        if typeof(steam) == "table" then
            local v: any = steam["last_ever"]
            if typeof(v) == "number" then
                return v
            end
        end
    end
    return 0
end

local RARITY_WEIGHT_BY_HEX: { [string]: number } = {
    ["#b0c3d9"] = 1, -- Consumer Grade (Grey)
    ["#5e98d9"] = 2, -- Industrial Grade (Light Blue)
    ["#4b69ff"] = 3, -- Mil-Spec (Blue)
    ["#8847ff"] = 4, -- Restricted (Purple)
    ["#d32ce6"] = 5, -- Classified (Pink)
    ["#eb4b4b"] = 6, -- Covert (Red)
    ["#e4ae33"] = 7, -- Contraband (Gold)
}

return function(props: Props)
    local state: any = if props and props.getState then props.getState() else error("ItemList requires getState prop")

    local items: { Types.SkinItem } = {}
    for _, item in (state.inventoryItems) do
        table.insert(items, item :: Types.SkinItem)
    end

    local prices: any = state.prices

    if state.sort == "price" then
        table.sort(items, function(a: any, b: any)
            return getPriceFor(prices, (a :: any).market_hash_name) > getPriceFor(prices, (b :: any).market_hash_name)
        end)
    elseif state.sort == "cheapest" then
        table.sort(items, function(a: any, b: any)
            return getPriceFor(prices, (a :: any).market_hash_name) < getPriceFor(prices, (b :: any).market_hash_name)
        end)
    elseif state.sort == "rarity" then
        table.sort(items, function(a: any, b: any)
            local hexA = if a.rarity and typeof(a.rarity.color) == "string" then string.lower(a.rarity.color) else ""
            local hexB = if b.rarity and typeof(b.rarity.color) == "string" then string.lower(b.rarity.color) else ""
            local wa = RARITY_WEIGHT_BY_HEX[hexA] or 0
            local wb = RARITY_WEIGHT_BY_HEX[hexB] or 0
            if wa ~= wb then
                return wa > wb
            end
            -- tiebreaker by price desc
            return getPriceFor(prices, (a :: any).market_hash_name) > getPriceFor(prices, (b :: any).market_hash_name)
        end)
    else
        -- newest: keep original order (no sorting)
    end

    local children: { [string]: any } = {
        uIGridLayout = React.createElement("UIGridLayout", {
            CellPadding = UDim2.fromOffset(10, 50),
            CellSize = UDim2.fromOffset(176, 146),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
    }

    for i = 1, #items do
        local item = items[i]
        local key = tostring(i)
        children[key] = React.createElement(ItemCard :: any, {
            item = item,
            layoutOrder = i,
            getState = props.getState,
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


