-- Minimal global state container powered by React hooks
local React = require("@Packages/React")
local Network = require("@Network")

type InventoryItem = {
    market_hash_name: string,
    name: string,
    stattrak: boolean?,
    wear: string?,
    rarity: string?,
    image: string,
}

local InventoryState = {}

local context: any = React.createContext(nil)

local function provider(props)
    local autoSellMinimumCents, setAutoSellMinimumCents = React.useState(0)
    local sort, setSort = React.useState("newest")
    local prices, setPrices = React.useState({} :: any)
    local inventoryItems, setInventoryItems = React.useState({} :: {InventoryItem})

    React.useEffect(function()
        -- Fetch initial data from server services
        task.spawn(function()
            local ok1, serverPrices = pcall(function() return (Network.GetPrices :: any):InvokeServer() end)
            if ok1 and typeof(serverPrices) == "table" then
                setPrices(serverPrices)
            end
        end)
        task.spawn(function()
            local ok2, skins = pcall(function() return (Network.GetSkins :: any):InvokeServer() end)
            if ok2 and typeof(skins) == "table" then
                -- For demo purposes, take a subset as the player's inventory
                local items: {InventoryItem} = {}
                local count = 0
                for _, s in skins do
                    if typeof(s) == "table" and s.name and s.image and s.market_hash_name then
                        table.insert(items, {
                            market_hash_name = tostring(s.market_hash_name),
                            name = tostring(s.name),
                            stattrak = (s.stattrak == true),
                            wear = if s.wear then tostring(s.wear) else "",
                            rarity = if s.rarity then tostring(s.rarity) else "",
                            image = tostring(s.image),
                        } :: InventoryItem)
                        count += 1
                        if count >= 24 then break end
                    end
                end
                setInventoryItems(items)
            end
        end)
    end, {})

    return React.createElement(context.Provider, {
        value = {
            autoSellMinimumCents = autoSellMinimumCents,
            setAutoSellMinimumCents = setAutoSellMinimumCents,
            sort = sort,
            setSort = setSort,
            prices = prices,
            inventoryItems = inventoryItems,
        },
    }, props["children"])
end

function InventoryState.Provider(props)
    return provider(props)
end

function InventoryState.Wrap(child: any)
    return provider({ children = child })
end

function InventoryState.use()
    local value = React.useContext(context)
    if value == nil then
        error("InventoryState must be used within Provider")
    end
    return value
end

return InventoryState


