local React = require("@Packages/React")

return React.createElement("Frame", {
  AnchorPoint = Vector2.new(0.5, 0),
  BackgroundTransparency = 1,
  Position = UDim2.fromScale(0.5, 0),
  Size = UDim2.fromOffset(1920, 1080),
}, {
  uIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", {
    AspectRatio = 1.77634,
  }),

  buttons = React.createElement("Frame", {
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
          Text = "$0 ",
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
  }),

  inventory = React.createElement("TextLabel", {
    BackgroundTransparency = 1,
    FontFace = Font.new(
      "rbxasset://fonts/families/SourceSansPro.json",
      Enum.FontWeight.Heavy,
      Enum.FontStyle.Normal
    ),
    Position = UDim2.fromScale(0.418896, 0.122469),
    Size = UDim2.fromScale(0.157029, 0.062536),
    Text = "Inventory",
    TextColor3 = Color3.new(1, 1, 1),
    TextScaled = true,
  }, {
    uIStroke = React.createElement("UIStroke", {
      Thickness = 1.5,
      Transparency = 0.5,
    }),
  }),

  skinBox = React.createElement("Frame", {
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

      skinFrame = React.createElement("Frame", {
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
            Text = "? StatTrak | Butterfly Knife",
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
            Text = "Doppler (<font color="rgb(207, 50, 53)">Ruby</font>)",
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
      }),

      skinFrame2 = React.createElement("ModuleScript", {
        Archivable = false,
      }),
    }),
  }),

  autoUIScale = React.createElement("UIScale"),
})