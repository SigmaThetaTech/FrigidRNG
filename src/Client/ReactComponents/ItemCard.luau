local React = require("@Packages/React")
local Button = require("@Client/ReactComponents/Button")
local InventoryActions = require("@Client/Actions/InventoryActions")

type Wear = { id: string, name: string }
type Rarity = { id: string, name: string, color: string }

type Props = {
    market_hash_name: string,
    name: string,
    stattrak: boolean?,
    wear: Wear?,
    rarity: Rarity?,
    image: string,
    layoutOrder: number?,
    getState: (() -> any)?,
}

local function getWearAbbreviation(wearName: string?): string
    if typeof(wearName) ~= "string" then
        return ""
    end
    local abbreviation = ""
    for i = 1, #wearName do
        local char = string.sub(wearName, i, i)
        if char:match("[A-Z]") then
            abbreviation ..= char
        end
    end
    return abbreviation
end

local function stripParenthetical(text: string?): string
    if typeof(text) ~= "string" then
        return ""
    end
    local stripped = string.gsub(text, "%s*%b()%s*", " ")
    stripped = string.gsub(stripped, "%s%s+", " ")
    stripped = string.gsub(stripped, "^%s+", "")
    stripped = string.gsub(stripped, "%s+$", "")
    return stripped
end

local function getPriceFor(state, marketHashName: string): number
    local entry: any = (state.prices :: any)[marketHashName]
    if typeof(entry) == "table" then
        local steam: any = entry["steam"]
        if typeof(steam) == "table" then
            local v: any = steam["last_ever"]
            if typeof(v) == "number" then
                return v
            end
        end
    end
    return 0
end

return function(props: Props)
    local state: any = if props and props.getState then props.getState() else nil

    local isHover, setIsHover = React.useState(false)
    local isToggled, setIsToggled = React.useState(false)

    local price = getPriceFor(state, props.market_hash_name)
    local priceLabel = if price > 0 then string.format("$%0.2f", price) else ""

    local showSell = isHover or isToggled

    return React.createElement("Frame", {
        Name = "ItemCard",
        BackgroundTransparency = 1,
        SelectionGroup = true,
        Size = UDim2.fromScale(0.114642, 0.132554),
        LayoutOrder = props.layoutOrder,
        [React.Event.MouseEnter] = function()
            setIsHover(true)
        end,
        [React.Event.MouseLeave] = function()
            setIsHover(false)
        end,
        [React.Event.InputBegan] = function(_, input)
            if input.UserInputType == Enum.UserInputType.Touch then
                setIsToggled(not isToggled)
            end
        end,
    }, {
        icon = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = props.image,
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
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -8, 0, 4),
            Size = UDim2.fromScale(0.65, 0.165792),
            Text = priceLabel,
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
            Text = getWearAbbreviation(if props.wear then props.wear.name else nil),
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
            Position = UDim2.new(0.01, 4, 0.01, 4),
            Selectable = false,
            Size = UDim2.fromScale(0.13, 0.168989),
            ZIndex = 3,
        }),

        background = React.createElement("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1),
            Position = UDim2.fromScale(0, 0),
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
                BackgroundColor3 = Color3.fromHex(if props.rarity and props.rarity.color then props.rarity.color else "#ffffff"),
                BorderSizePixel = 0,
                Position = UDim2.fromScale(0, 0.94),
                Size = UDim2.fromScale(1, 0.06),
            }),
        }),

        sellButton = React.createElement(Button :: any, {
            text = if price > 0 then string.format("Sell for $%0.2f", price) else "Sell",
            position = UDim2.fromScale(0, 0.826),
            size = UDim2.fromScale(1, 0.290347),
            visible = showSell,
            onActivated = function()
                InventoryActions.SellItem(props.market_hash_name)
            end,
        }),

        bottomFrame = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 1, 0.826, 0),
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
                Text = stripParenthetical(props.name),
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
                Text = if props.rarity then props.rarity.name else "",
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
end


