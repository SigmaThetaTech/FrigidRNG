local React = require("@Packages/React")

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
      Position = UDim2.fromScale(3.3559e-08, 0),
      Size = UDim2.fromScale(1, 0.157269),
    }, {
      sortByButton = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        LayoutOrder = 2,
        Position = UDim2.fromScale(0.157637, 0.562059),
        Selectable = false,
        Size = UDim2.fromScale(0.687769, 0.437941),
      }, {
        back = React.createElement("TextLabel", {
          BackgroundTransparency = 1,
          FontFace = Font.new(
            "rbxasset://fonts/families/SourceSansPro.json",
            Enum.FontWeight.Bold,
            Enum.FontStyle.Normal
          ),
          Position = UDim2.fromScale(0.171506, 0.176018),
          Size = UDim2.fromScale(0.652257, 0.61213),
          Text = "Newest",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      sortBy = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        FontFace = Font.new(
          "rbxasset://fonts/families/SourceSansPro.json",
          Enum.FontWeight.Heavy,
          Enum.FontStyle.Normal
        ),
        LayoutOrder = 1,
        Position = UDim2.fromScale(0.00300273, 5.9431e-07),
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
  
    quickSell = React.createElement("Frame", {
      BackgroundTransparency = 1,
      LayoutOrder = 3,
      Position = UDim2.fromScale(3.3559e-08, 0),
      Size = UDim2.fromScale(1, 0.157269),
    }, {
      grey = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = Color3.fromRGB(205, 214, 239),
        LayoutOrder = 2,
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
          Text = "Grey",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      quickSell = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        FontFace = Font.new(
          "rbxasset://fonts/families/SourceSansPro.json",
          Enum.FontWeight.Heavy,
          Enum.FontStyle.Normal
        ),
        LayoutOrder = 1,
        Position = UDim2.fromScale(0.00300273, 5.9431e-07),
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
  
      lightBlue = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = Color3.fromRGB(148, 200, 255),
        LayoutOrder = 3,
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
          Text = "Light Blue",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      blue = React.createElement("ImageButton", {
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
      }),
  
      purple = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = Color3.fromRGB(123, 83, 255),
        LayoutOrder = 5,
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
          Text = "Purple",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      pink = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = Color3.fromRGB(231, 49, 255),
        LayoutOrder = 6,
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
          Text = "Pink",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      red = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = Color3.fromRGB(255, 65, 68),
        LayoutOrder = 7,
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
          Text = "Red",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      gold = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        ImageColor3 = Color3.fromRGB(255, 206, 60),
        LayoutOrder = 8,
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
          Text = "Gold",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
    }),
  
    autoSell = React.createElement("Frame", {
      BackgroundTransparency = 1,
      LayoutOrder = 2,
      Position = UDim2.fromScale(3.3559e-08, 0),
      Size = UDim2.fromScale(1, 0.157269),
    }, {
      priceMinimum = React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        LayoutOrder = 2,
        Position = UDim2.fromScale(0.157637, 0.562059),
        Selectable = false,
        Size = UDim2.fromScale(0.687769, 0.437941),
      }, {
        back = React.createElement("TextBox", {
          BackgroundTransparency = 1,
          FontFace = Font.new(
            "rbxasset://fonts/families/SourceSansPro.json",
            Enum.FontWeight.Bold,
            Enum.FontStyle.Normal
          ),
          Position = UDim2.fromScale(0.171506, 0.176018),
          Size = UDim2.fromScale(0.652257, 0.61213),
          Text = "",
          TextColor3 = Color3.new(1, 1, 1),
          TextScaled = true,
        }, {
          uIStroke = React.createElement("UIStroke", {
            Thickness = 1.5,
            Transparency = 0.5,
          }),
        }),
      }),
  
      autoSell = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        FontFace = Font.new(
          "rbxasset://fonts/families/SourceSansPro.json",
          Enum.FontWeight.Heavy,
          Enum.FontStyle.Normal
        ),
        LayoutOrder = 1,
        Position = UDim2.fromScale(0.00300273, 5.9431e-07),
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
  })