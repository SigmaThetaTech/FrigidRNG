local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local React = require(Packages:WaitForChild("React"))
local ReactRoblox = require(Packages:WaitForChild("ReactRoblox"))

local RojoClient = StarterPlayer:WaitForChild("StarterPlayerScripts"):WaitForChild("RojoClient")
local Sidebar = require(RojoClient:WaitForChild("ReactComponents"):WaitForChild("Sidebar"))
local ItemList = require(RojoClient:WaitForChild("ReactComponents"):WaitForChild("ItemList"))

local MockSkins = require(script.Parent:WaitForChild("MockData"):WaitForChild("MockSkins"))

local function mapSkinsToItems(skins: { any }): { any }
    local items = {}
    local count = 0
    for _, s in skins do
        if typeof(s) == "table" and s.name and s.image and s.market_hash_name then
            local wearObj = nil
            if typeof(s.wear) == "table" and s.wear.id and s.wear.name then
                wearObj = {
                    id = tostring(s.wear.id),
                    name = tostring(s.wear.name),
                }
            end

            local rarityObj = nil
            if typeof(s.rarity) == "table" and s.rarity.id and s.rarity.name then
                rarityObj = {
                    id = tostring(s.rarity.id),
                    name = tostring(s.rarity.name),
                    color = tostring(s.rarity.color or ""),
                }
            end

            table.insert(items, {
                market_hash_name = tostring(s.market_hash_name),
                name = tostring(s.name),
                stattrak = (s.stattrak == true),
                wear = wearObj,
                rarity = rarityObj,
                image = tostring(s.image),
            })
            count += 1
            if count >= 500 then break end
        end
    end
    return items
end

local initialItems = mapSkinsToItems(MockSkins)

-- Mock state provider to avoid using Network-backed InventoryState in plugin
local MockContext: any = React.createContext(nil)

local function MockProvider(props: any)
    local autoSellMinimumCents, setAutoSellMinimumCents = React.useState(0)
    local sort, setSort = React.useState("newest")
    local prices, _setPrices = React.useState({} :: any)
    local provided = if props then props.initialItems else nil
    local initial = if typeof(provided) == "table" then (provided :: { any }) else {}
    local inventoryItems, setInventoryItems = React.useState(initial)

    return React.createElement(MockContext.Provider, {
        value = {
            autoSellMinimumCents = autoSellMinimumCents,
            setAutoSellMinimumCents = setAutoSellMinimumCents,
            sort = sort,
            setSort = setSort,
            prices = prices,
            inventoryItems = inventoryItems,
            setInventoryItems = setInventoryItems,
        },
    }, props["children"])
end

local function useMockState()
    local value = React.useContext(MockContext)
    if value == nil then
        error("useMockState must be used within MockProvider")
    end
    return value
end

local _RARITY_WEIGHT_BY_HEX: { [string]: number } = {
    ["#b0c3d9"] = 1,
    ["#5e98d9"] = 2,
    ["#4b69ff"] = 3,
    ["#8847ff"] = 4,
    ["#d32ce6"] = 5,
    ["#eb4b4b"] = 6,
    ["#e4ae33"] = 7,
}

local function _getWearAbbreviation(wearName: string?): string
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

local function InventoryStoryView()
    return React.createElement("Frame", {
        Name = "Inventory",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
    }, {
        aspect = React.createElement("UIAspectRatioConstraint", {
            AspectRatio = 1.776,
            DominantAxis = Enum.DominantAxis.Height,
        }),

        sidebar = React.createElement(Sidebar :: any, { getState = useMockState }),
        itemList = React.createElement(ItemList :: any, { getState = useMockState }),

        title = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            FontFace = Font.new(
                "rbxasset://fonts/families/SourceSansPro.json",
                Enum.FontWeight.Heavy,
                Enum.FontStyle.Normal
            ),
            Text = "Inventory",
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = true,
            Size = UDim2.fromScale(0.157, 0.063),
            Position = UDim2.fromScale(0.419, 0.122)
        }, {
            uIStroke = React.createElement("UIStroke", {
                Thickness = 1.5,
                Transparency = 0.5,
            }),
        }),
    })
end

local controls = {
}

local story = {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		return React.createElement(MockProvider, { initialItems = initialItems }, React.createElement(InventoryStoryView))
	end,
}

return story


