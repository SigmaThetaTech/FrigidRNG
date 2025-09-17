local React = require("@Packages/React")

type Props = {
    text: string,
    color: Color3?,
    LayoutOrder: number?,
    onActivated: (() -> ())?,
    size: UDim2?,
    position: UDim2?,
}

return function(props: Props)
    return React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = props.color or Color3.fromRGB(74, 122, 255),
        LayoutOrder = props.LayoutOrder,
        Selectable = false,
        Size = props.size or UDim2.fromScale(1, 0.06),
        Position = props.position,
        [React.Event.Activated] = props.onActivated,
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

