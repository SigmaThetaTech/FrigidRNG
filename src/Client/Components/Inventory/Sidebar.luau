local React = require("@Packages/React")
local Button = require(script.Parent.Parent.Button)

type Props = {
    sortMode: string,
    onSortModeChanged: (string) -> (),
    autoSell: number,
    onAutoSellChanged: (number) -> (),
    onQuickSellColor: (string) -> (),
}

local SORT_ORDER: { string } = { "Newest", "Price", "Rarity", "Cheapest" }

return function(props: Props)
    local sortIndex, setSortIndex = React.useState(1)

    local function cycleSort()
        local nextIdx = (sortIndex % #SORT_ORDER) + 1
        setSortIndex(nextIdx)
        props.onSortModeChanged(SORT_ORDER[nextIdx])
    end

    local autoSellText, setAutoSellText = React.useState(tostring(props.autoSell))

    React.useEffect(function()
        setAutoSellText(tostring(props.autoSell))
    end, { props.autoSell })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.0617022, 0.222222),
        Size = UDim2.fromScale(0.118503, 0.604645),
        LayoutOrder = 1,
    }, {
        list = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12),
        }),

        sortLabel = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = "Sort By",
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy),
            TextScaled = true,
            Size = UDim2.fromScale(1, 0.4),
        }),

        sortButton = React.createElement(Button :: any, { text = SORT_ORDER[sortIndex], LayoutOrder = 2, onActivated = cycleSort, position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941) }),

        autoSellLabel = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = "Auto Sell",
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy),
            TextScaled = true,
            Size = UDim2.fromScale(1, 0.4),
        }),

        autoSellField = React.createElement("TextBox", {
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            TextColor3 = Color3.new(1, 1, 1),
            Text = autoSellText,
            PlaceholderText = "$0",
            ClearTextOnFocus = false,
            Size = UDim2.fromScale(1, 0.06),
            [React.Change.Text] = function(rbx: TextBox)
                setAutoSellText(rbx.Text)
            end,
            [React.Event.FocusLost] = function(_rbx: TextBox, enterPressed: boolean)
                local value = tonumber(autoSellText:gsub("%$", ""):gsub(",", "")) or 0
                props.onAutoSellChanged(value)
                if enterPressed then
                    -- reflect formatted
                    setAutoSellText(tostring(value))
                end
            end,
        }),

        quickSellLabel = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = "Quick Sell",
            FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy),
            TextScaled = true,
            Size = UDim2.fromScale(1, 0.4),
        }),

        quickGrey = React.createElement(Button :: any, { text = "Grey", color = Color3.fromRGB(205,214,239), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#808080") end }),
        quickLightBlue = React.createElement(Button :: any, { text = "Light Blue", color = Color3.fromRGB(148,200,255), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#66ccff") end }),
        quickBlue = React.createElement(Button :: any, { text = "Blue", color = Color3.fromRGB(74, 122, 255), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#0077ff") end }),
        quickPurple = React.createElement(Button :: any, { text = "Purple", color = Color3.fromRGB(123, 83, 255), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#9933ff") end }),
        quickPink = React.createElement(Button :: any, { text = "Pink", color = Color3.fromRGB(231, 49, 255), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#ff66b2") end }),
        quickRed = React.createElement(Button :: any, { text = "Red", color = Color3.fromRGB(255, 65, 68), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#eb4b4b") end }),
        quickGold = React.createElement(Button :: any, { text = "Gold", color = Color3.fromRGB(255, 206, 60), position = UDim2.fromScale(0.157637, 0.562059), size = UDim2.fromScale(0.687769, 0.437941), onActivated = function() props.onQuickSellColor("#f4c53a") end }),
    })
end


