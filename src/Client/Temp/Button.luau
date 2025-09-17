--[[
    Button component

    Props:
    - text: string
    - color: Color3
    - layoutOrder: number
    - position: UDim2
    - size: UDim2
    - onActivated: () -> ()
    - onHover: () -> ()
]]

local React = require("@Packages/React")

return React.createElement("ImageButton", {
    Active = false,
    BackgroundTransparency = 1,
    HoverImage = "rbxassetid://89227138772404",
    Image = "rbxassetid://90073183858361",
    ImageColor3 = Color3.fromRGB(74, 122, 255),
    LayoutOrder = 4,
    Position = UDim2.fromScale(0.157637, 0.562059),
    Selectable = false,
    Size = UDim2.fromScale(0.687769, 0.437941),
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
      Text = "Blue",
      TextColor3 = Color3.new(1, 1, 1),
      TextScaled = true,
    }, {
      uIStroke = React.createElement("UIStroke", {
        Thickness = 1.5,
        Transparency = 0.5,
      }),
    }),
  })