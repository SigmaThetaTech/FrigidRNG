local React = require("@Packages/React")
local InventoryActions = require("@Client/Actions/InventoryActions")

local Button = require("@Client/ReactComponents/Button")
local AutoSellInput = require("@Client/ReactComponents/AutoSellInput")

type Props = {
    getState: (() -> any)?,
}

return function(props: Props)
    local state: any = if props and props.getState then props.getState() else error("Sidebar requires getState prop")

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.0617022, 0.222222),
        Size = UDim2.fromScale(0.118503, 0.604645),
    }, {
        uIListLayout = React.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 25),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),

        sort = React.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 0.157269),
        }, {
            sortToggle = React.createElement(Button :: any, {
                text = (function()
                    local labelMap = {
                        newest = "Newest",
                        price = "Price",
                        rarity = "Rarity",
                        cheapest = "Cheapest",
                    }
                    return labelMap[state.sort] or "Newest"
                end)(),
                layoutOrder = 2,
                position = UDim2.fromScale(0.157637, 0.562059),
                size = UDim2.fromScale(0.687769, 0.437941),
                onActivated = function()
                    local order = { "newest", "price", "rarity", "cheapest" }
                    local current = state.sort
                    local nextIndex = 1
                    for i = 1, #order do
                        if order[i] == current then
                            nextIndex = if i == #order then 1 else (i + 1)
                            break
                        end
                    end
                    state.setSort(order[nextIndex])
                end,
            }),
            sortBy = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = Font.new(
                    "rbxasset://fonts/families/SourceSansPro.json",
                    Enum.FontWeight.Heavy,
                    Enum.FontStyle.Normal
                ),
                LayoutOrder = 1,
                Position = UDim2.fromScale(0.00300273, 0),
                Size = UDim2.fromScale(1, 0.4),
                Text = "Sort By",
                TextColor3 = Color3.new(1, 1, 1),
                TextScaled = true,
            }, {
                uIStroke = React.createElement("UIStroke", {
                    Thickness = 1.5,
                    Transparency = 0.5,
                }),
            }),
            uIListLayout = React.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }),
        }),

        autoSell = React.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 0.157269),
        }, {
            priceMinimum = React.createElement(AutoSellInput :: any, {
                layoutOrder = 2,
                position = UDim2.fromScale(0.157637, 0.562059),
                size = UDim2.fromScale(0.687769, 0.437941),
                valueCents = state.autoSellMinimumCents,
                onChanged = function(newValue)
                    state.setAutoSellMinimumCents(newValue)
                end,
            }),
            autoSellLabel = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = Font.new(
                    "rbxasset://fonts/families/SourceSansPro.json",
                    Enum.FontWeight.Heavy,
                    Enum.FontStyle.Normal
                ),
                LayoutOrder = 1,
                Position = UDim2.fromScale(0.00300273, 0),
                Size = UDim2.fromScale(1, 0.4),
                Text = "Auto Sell",
                TextColor3 = Color3.new(1, 1, 1),
                TextScaled = true,
            }, {
                uIStroke = React.createElement("UIStroke", {
                    Thickness = 1.5,
                    Transparency = 0.5,
                }),
            }),
            uIListLayout = React.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }),
        }),

        quickSell = React.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            Size = UDim2.fromScale(1, 0.157269),
        }, {
            quickSellLabel = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = Font.new(
                    "rbxasset://fonts/families/SourceSansPro.json",
                    Enum.FontWeight.Heavy,
                    Enum.FontStyle.Normal
                ),
                LayoutOrder = 1,
                Position = UDim2.fromScale(0.00300273, 0),
                Size = UDim2.fromScale(1, 0.4),
                Text = "Quick Sell",
                TextColor3 = Color3.new(1, 1, 1),
                TextScaled = true,
            }, {
                uIStroke = React.createElement("UIStroke", {
                    Thickness = 1.5,
                    Transparency = 0.5,
                }),
            }),
            uIListLayout = React.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }),
            grey = React.createElement(Button :: any, { text = "Grey", color = Color3.fromRGB(205,214,239), layoutOrder = 2, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#b0c3d9"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
            lightBlue = React.createElement(Button :: any, { text = "Light Blue", color = Color3.fromRGB(148,200,255), layoutOrder = 3, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#5e98d9"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
            blue = React.createElement(Button :: any, { text = "Blue", color = Color3.fromRGB(74,122,255), layoutOrder = 4, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#4b69ff"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
            purple = React.createElement(Button :: any, { text = "Purple", color = Color3.fromRGB(123,83,255), layoutOrder = 5, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#8847ff"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
            pink = React.createElement(Button :: any, { text = "Pink", color = Color3.fromRGB(231,49,255), layoutOrder = 6, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#d32ce6"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
            red = React.createElement(Button :: any, { text = "Red", color = Color3.fromRGB(255,65,68), layoutOrder = 7, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#eb4b4b"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
            gold = React.createElement(Button :: any, { text = "Gold", color = Color3.fromRGB(255,206,60), layoutOrder = 8, size = UDim2.fromScale(0.687769, 0.437941), onActivated = function()
                local hex = "#e4ae33"
                for _, item in state.inventoryItems do
                    if item.rarity and typeof(item.rarity.color) == "string" and string.lower(item.rarity.color) == hex then
                        InventoryActions.SellItem((item :: any).market_hash_name)
                    end
                end
            end }),
        }),
    })
end


