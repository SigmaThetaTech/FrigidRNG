local React = require("@Packages/React")

-- Main Inventory ScreenGui view
-- Contains a transparent frame named "Inventory" with full size and an aspect
-- ratio constraint, plus the Sidebar and ItemList components.

local Sidebar = require("@Client/ReactComponents/Sidebar")
local ItemList = require("@Client/ReactComponents/ItemList")
local InventoryState = require("@Client/State/InventoryState")

return function()
    local content = React.createElement("Frame", {
        Name = "Inventory",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
    }, {
        aspect = React.createElement("UIAspectRatioConstraint", {
            AspectRatio = 1.776,
            DominantAxis = Enum.DominantAxis.Height,
        }),

        sidebar = React.createElement(Sidebar :: any),
        itemList = React.createElement(ItemList :: any),

        title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            FontFace = Font.new(
                "rbxasset://fonts/families/SourceSansPro.json",
                Enum.FontWeight.Heavy,
                Enum.FontStyle.Normal
            ),
            Text = "Inventory",
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
            Size = UDim2.fromScale(0.157, 0.063),
            Position = UDim2.fromScale(0.419, 0.122)
        }, {
            uIStroke = React.createElement("UIStroke", {
                Thickness = 1.5,
                Transparency = 0.5,
            }),
        }),
    })
    -- Wrap with provider to supply global state
    return InventoryState.Wrap(content)
end


