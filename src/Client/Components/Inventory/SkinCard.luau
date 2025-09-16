local React = require("@Packages/React")

local Button = require(script.Parent.components.Button)
local SkinFrameTemplate = require(script.Parent.Parent.SkinFrame)

type Props = {
    skin: any,
    onSell: (skin: any) -> (),
}

return function(props: Props)
    local hovered, setHovered = React.useState(false)

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0, 0), -- layout driven
        [React.Event.MouseEnter] = function()
            setHovered(true)
        end,
        [React.Event.MouseLeave] = function()
            setHovered(false)
        end,
    }, {
        card = SkinFrameTemplate,

        sell = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0, 0.826),
            Size = UDim2.fromScale(1, 0.29),
            Visible = hovered,
            ZIndex = 5,
        }, {
            btn = React.createElement(Button :: any, {
                text = "Sell for $99,999.99",
                onActivated = function()
                    props.onSell(props.skin)
                end,
            }),
        }),

        fade = React.createElement("UIStroke", { Transparency = hovered and 0 or 1 }),
        aspect = React.createElement("UIAspectRatioConstraint", { AspectRatio = 1.29991 }),
    })
end


