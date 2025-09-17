local React = require("@Packages/React")

return React.createElement("Frame", {
    Name = "ItemList",
    BackgroundTransparency = 1,
    Position = UDim2.fromScale(0.193495, 0.233879),
    Size = UDim2.fromScale(0.681656, 0.752311),
  }, {
    scrollingFrame = React.createElement("ScrollingFrame", {
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      BackgroundTransparency = 1,
      ScrollBarImageColor3 = Color3.new(),
      ScrollBarThickness = 10,
      ScrollingDirection = Enum.ScrollingDirection.Y,
      Selectable = false,
      Size = UDim2.fromScale(1, 1),
    }, {
      uIGridLayout = React.createElement("UIGridLayout", {
        CellPadding = UDim2.fromOffset(10, 50),
        CellSize = UDim2.fromOffset(176, 146),
        SortOrder = Enum.SortOrder.LayoutOrder,
      }),
    }),
  })