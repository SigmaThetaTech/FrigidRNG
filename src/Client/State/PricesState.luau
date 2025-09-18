--!strict
-- PricesState: provides shared prices map and global time ticks for "last updated" labels

local React = require("@Packages/React")
local Network = require("@Network")

type PriceMap = { [string]: any }

local PricesState = {}

local context: any = React.createContext(nil)

local function ProviderComponent(props: any)
    local prices, setPrices = React.useState({} :: PriceMap)
    local minuteTick, setMinuteTick = React.useState(0)
    local hourTick, setHourTick = React.useState(0)

    -- Fetch prices once at mount
    React.useEffect(function()
        task.spawn(function()
            local ok1, serverPrices = pcall(function()
                return (Network.GetPrices :: any):InvokeServer()
            end)
            if ok1 and typeof(serverPrices) == "table" then
                setPrices(serverPrices :: any)
            end
        end)
    end, {})

    -- Global minute tick
    React.useEffect(function()
        local cancelled = false
        local function loop()
            if cancelled then return end
            setMinuteTick(function(v: number): number return v + 1 end)
            task.delay(60, loop)
        end
        loop()
        return function()
            cancelled = true
        end
    end, {})

    -- Global hour tick
    React.useEffect(function()
        local cancelled = false
        local function loop()
            if cancelled then return end
            setHourTick(function(v: number): number return v + 1 end)
            task.delay(3600, loop)
        end
        loop()
        return function()
            cancelled = true
        end
    end, {})

    return React.createElement(context.Provider, {
        value = {
            prices = prices,
            setPrices = setPrices,
            minuteTick = minuteTick,
            hourTick = hourTick,
        },
    }, props["children"])
end

function PricesState.Provider(props)
    return React.createElement(ProviderComponent :: any, props)
end

function PricesState.Wrap(child: any)
    return React.createElement(ProviderComponent :: any, nil, child)
end

function PricesState.use()
    local value = React.useContext(context)
    if value == nil then
        error("PricesState must be used within Provider")
    end
    return value
end

return PricesState


