-- Minimal global state container powered by React hooks
local React = require("@Packages/React")
local Network = require("@Network")
local Types = require("@SharedModules/Types")

type Wear = {
    id: string,
    name: string,
}

type Rarity = {
    id: string,
    name: string,
    color: string,
}

type SkinItem = Types.SkinItem

local InventoryState = {}

local context: any = React.createContext(nil)

-- React function component that hosts stateful hooks
local function ProviderComponent(props: any)
    local autoSellMinimumCents, setAutoSellMinimumCents = React.useState(0)
    local sort, setSort = React.useState("newest")
    local prices, setPrices = React.useState({} :: any)
    local provided = if props then props.initialInventoryItems else nil
    local initialItems: {SkinItem} = if typeof(provided) == "table" then (provided :: {SkinItem}) else {}
    local inventoryItems: {SkinItem}, setInventoryItems = React.useState(initialItems :: {SkinItem})

    React.useEffect(function()
        -- Fetch initial data from server services
        task.spawn(function()
            local ok1, serverPrices = pcall(function() return (Network.GetPrices :: any):InvokeServer() end)
            if ok1 and typeof(serverPrices) == "table" then
                setPrices(serverPrices)
            end
        end)
        -- Skins are seeded by the controller; no fetch here
    end, {})

    return React.createElement(context.Provider, {
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

function InventoryState.Provider(props)
    return React.createElement(ProviderComponent :: any, props)
end

function InventoryState.Wrap(child: any, initial: {SkinItem}?)
    return React.createElement(ProviderComponent :: any, { initialInventoryItems = initial }, child)
end

function InventoryState.use()
    local value = React.useContext(context)
    if value == nil then
        error("InventoryState must be used within Provider")
    end
    return value
end

return InventoryState


