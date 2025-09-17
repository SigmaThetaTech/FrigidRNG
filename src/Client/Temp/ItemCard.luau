local React = require("@Packages/React")

return React.createElement("Frame", {
    Name = "ItemCard",
    BackgroundTransparency = 1,
    SelectionGroup = true,
    Size = UDim2.fromScale(0.114642, 0.132554),
  }, {
    icon = React.createElement("ImageLabel", {
      BackgroundTransparency = 1,
      Image = "rbxassetid://116543746496249",
      ScaleType = Enum.ScaleType.Fit,
      Size = UDim2.fromScale(1, 0.734765),
      ZIndex = 2,
    }),
  
    price = React.createElement("TextLabel", {
      BackgroundTransparency = 1,
      FontFace = Font.new(
        "rbxasset://fonts/families/SourceSansPro.json",
        Enum.FontWeight.Heavy,
        Enum.FontStyle.Normal
      ),
      Position = UDim2.fromScale(0.307653, 0.0131983),
      Size = UDim2.fromScale(0.65, 0.165792),
      Text = "$99,999.99",
      TextColor3 = Color3.fromRGB(60, 242, 36),
      TextScaled = true,
      TextXAlignment = Enum.TextXAlignment.Right,
      ZIndex = 3,
    }, {
      uIStroke = React.createElement("UIStroke", {
        Thickness = 1.5,
        Transparency = 0.5,
      }),
    }),
  
    floatValue = React.createElement("TextLabel", {
      BackgroundTransparency = 1,
      FontFace = Font.new(
        "rbxasset://fonts/families/SourceSansPro.json",
        Enum.FontWeight.Heavy,
        Enum.FontStyle.Normal
      ),
      Position = UDim2.fromScale(0.03, 0.54),
      Size = UDim2.fromScale(0.153323, 0.196574),
      Text = "FN",
      TextColor3 = Color3.new(1, 1, 1),
      TextScaled = true,
      ZIndex = 3,
    }, {
      uIStroke = React.createElement("UIStroke", {
        Thickness = 1.5,
        Transparency = 0.5,
      }),
    }),
  
    lockButton = React.createElement("ImageButton", {
      Active = false,
      BackgroundTransparency = 1,
      HoverImage = "rbxassetid://119465132139520",
      Image = "rbxassetid://124090224876766",
      Position = UDim2.fromScale(0.01, 0.01),
      Selectable = false,
      Size = UDim2.fromScale(0.13, 0.168989),
      ZIndex = 3,
    }),
  
    background = React.createElement("Frame", {
      BackgroundColor3 = Color3.new(1, 1, 1),
      Position = UDim2.fromScale(-0.0101523, -0.0131971),
      Size = UDim2.fromScale(1, 0.795704),
    }, {
      uICorner = React.createElement("UICorner", {
        CornerRadius = UDim.new(0, 7),
      }),
  
      uIGradient = React.createElement("UIGradient", {
        Color = ColorSequence.new({
          ColorSequenceKeypoint.new(0, Color3.fromRGB(137, 138, 138)),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(206, 206, 206)),
        }),
        Rotation = 90,
      }),
  
      uIStroke = React.createElement("UIStroke", {
        Color = Color3.fromRGB(234, 75, 77),
        Enabled = false,
        Thickness = 3,
      }),
  
      rarity = React.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(244, 197, 58),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0, 0.94),
        Size = UDim2.fromScale(1, 0.06),
      }),
    }),
  
    sellButton = React.createElement("ImageButton", {
      Active = false,
      BackgroundTransparency = 1,
      HoverImage = "rbxassetid://93997922963271",
      Image = "rbxassetid://71838811047678",
      Position = UDim2.fromScale(-0.0101523, 0.826),
      Selectable = false,
      Size = UDim2.fromScale(1, 0.290347),
      Visible = false,
      ZIndex = 3,
    }, {
      sellPrice = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        FontFace = Font.new(
          "rbxasset://fonts/families/SourceSansPro.json",
          Enum.FontWeight.Heavy,
          Enum.FontStyle.Normal
        ),
        Position = UDim2.fromScale(0.05, 0.25),
        Size = UDim2.fromScale(0.907827, 0.476607),
        Text = "Sell for $99,999.99",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
        ZIndex = 3,
      }, {
        uIStroke = React.createElement("UIStroke", {
          Thickness = 1.5,
          Transparency = 0.5,
        }),
      }),
    }),
  
    bottomFrame = React.createElement("Frame", {
      BackgroundTransparency = 1,
      Position = UDim2.fromScale(0, 0.826),
      Size = UDim2.fromScale(0.989848, 0.25),
    }, {
      line1 = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        FontFace = Font.new(
          "rbxasset://fonts/families/SourceSansPro.json",
          Enum.FontWeight.Heavy,
          Enum.FontStyle.Normal
        ),
        Position = UDim2.fromScale(0, -3.1516e-06),
        Size = UDim2.fromScale(1, 0.5),
        Text = "★ StatTrak | Butterfly Knife",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Left,
      }, {
        uIStroke = React.createElement("UIStroke", {
          Thickness = 1.5,
          Transparency = 0.5,
        }),
      }),
  
      line2 = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        FontFace = Font.new(
          "rbxasset://fonts/families/SourceSansPro.json",
          Enum.FontWeight.SemiBold,
          Enum.FontStyle.Normal
        ),
        Position = UDim2.fromScale(0, 0.791963),
        RichText = true,
        Size = UDim2.fromScale(1, 0.45),
        Text = "Doppler (<font color=\"rgb(207, 50, 53)\">Ruby</font>)",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
        TextXAlignment = Enum.TextXAlignment.Left,
      }, {
        uIStroke = React.createElement("UIStroke", {
          Thickness = 1.5,
          Transparency = 0.5,
        }),
      }),
  
      uIListLayout = React.createElement("UIListLayout", {
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
      }),
    }),
  
    uIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", {
      AspectRatio = 1.29991,
    }),
  })