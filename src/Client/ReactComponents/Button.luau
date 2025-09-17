-- Reusable button component (Fusion 0.3 or React-like API via Roact17 shim)
-- Props:
-- - text: string
-- - color: Color3
-- - layoutOrder: number?
-- - position: UDim2?
-- - size: UDim2?
-- - onActivated: () -> ()

local React = require("@Packages/React")

type Props = {
    text: string,
    color: Color3?,
    layoutOrder: number?,
    position: UDim2?,
    size: UDim2?,
    visible: boolean?,
    onActivated: (() -> ())?,
}

return function(props: Props)
    return React.createElement("ImageButton", {
        Active = true,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = props.color or Color3.fromRGB(74, 122, 255),
        LayoutOrder = props.layoutOrder or 0,
        Position = props.position or UDim2.fromScale(0, 0),
        Selectable = true,
        Size = props.size or UDim2.fromScale(1, 0.2),
        Visible = if props.visible == nil then true else props.visible,
        [React.Event.MouseButton1Click] = function()
            if props.onActivated then props.onActivated() end
        end,
    }, {
        text = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            FontFace = Font.new(
                "rbxasset://fonts/families/SourceSansPro.json",
                Enum.FontWeight.Bold,
                Enum.FontStyle.Normal
            ),
            Position = UDim2.fromScale(0.171506, 0.176018),
            Size = UDim2.fromScale(0.652257, 0.61213),
            Text = props.text,
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
        }, {
            uIStroke = React.createElement("UIStroke", {
                Thickness = 1.5,
                Transparency = 0.5,
            }),
        }),
    })
end


