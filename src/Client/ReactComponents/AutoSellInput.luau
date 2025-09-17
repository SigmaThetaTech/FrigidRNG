-- Auto-sell input based on Button visuals; allows numeric entry building a
-- currency value by pushing digits (e.g., typing 1 then 2 shows $0.12).
-- Props:
-- - valueCents: number
-- - onChanged: (newValueCents: number) -> ()

local React = require("@Packages/React")

type Props = {
    valueCents: number,
    onChanged: (number) -> (),
    layoutOrder: number?,
    position: UDim2?,
    size: UDim2?,
}

local function centsToLabel(cents: number): string
    local dollars = math.floor(cents / 100)
    local remainder = math.abs(cents % 100)
    return string.format("$%d.%02d", dollars, remainder)
end

return function(props: Props)
    -- Maintain focus visuals; TextBox handles key input
    local displayText = centsToLabel(props.valueCents)

    return React.createElement("ImageButton", {
        Active = false,
        BackgroundTransparency = 1,
        HoverImage = "rbxassetid://89227138772404",
        Image = "rbxassetid://90073183858361",
        LayoutOrder = props.layoutOrder or 0,
        Position = props.position or UDim2.fromScale(0, 0),
        Selectable = true,
        Size = props.size or UDim2.fromScale(0.687769, 0.437941),
    }, {
        back = React.createElement("TextBox" :: any, {
            BackgroundTransparency = 1,
            ClearTextOnFocus = false,
            FontFace = Font.new(
                "rbxasset://fonts/families/SourceSansPro.json",
                Enum.FontWeight.Bold,
                Enum.FontStyle.Normal
            ),
            Position = UDim2.fromScale(0.171506, 0.176018),
            Size = UDim2.fromScale(0.652257, 0.61213),
            Text = displayText,
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
            [React.Event.Focused] = function(tb: any)
                tb.CursorPosition = #tb.Text + 1
            end,
            [React.Event.FocusLost] = function()
                -- noop; value already updated on key input
            end,
            [React.Event.FocusLost] = function(tb: any)
                -- Build by digit-only; remove non-digits and push
                local txt: string = tb.Text
                local raw = string.gsub(txt, "%D", "")
                if raw == "" then
                    props.onChanged(0)
                    return
                end
                -- Keep only last up to 9 digits to avoid overflow
                if #raw > 9 then raw = string.sub(raw, #raw - 8) end
                local num = tonumber(raw) or 0
                -- Interpret as cents
                props.onChanged(num)
                tb.Text = centsToLabel(num)
                tb.CursorPosition = #tb.Text + 1
            end,
        }, {
            uIStroke = React.createElement("UIStroke", {
                Thickness = 1.5,
                Transparency = 0.5,
            }),
        }),
    })
end


