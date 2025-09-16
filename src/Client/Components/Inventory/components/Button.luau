local React = require("@Packages/React")

type Props = {
    text: string,
    onActivated: (() -> ())?,
    LayoutOrder: number?,
    color: Color3?,
}

return function(props: Props)
    local hovered, setHovered = React.useState(false)

    return React.createElement("ImageButton", {
        LayoutOrder = props.LayoutOrder,
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0.06),
        [React.Event.MouseEnter] = function()
            setHovered(true)
        end,
        [React.Event.MouseLeave] = function()
            setHovered(false)
        end,
        [React.Event.Activated] = props.onActivated,
    }, {
        container = React.createElement("Frame", {
            BackgroundColor3 = props.color or Color3.fromRGB(70, 70, 70),
            BackgroundTransparency = hovered and 0 or 0.2,
            Size = UDim2.fromScale(1, 1),
        }, {
            corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 6) }),
            aspect = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(math.huge, 60) }),
            text = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Text = props.text,
                TextColor3 = Color3.new(1,1,1),
                FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Heavy),
                TextScaled = true,
                Size = UDim2.fromScale(1, 1),
            }),
        }),
        scale = React.createElement("UIScale", { Scale = hovered and 1.02 or 1 }),
    })
end


