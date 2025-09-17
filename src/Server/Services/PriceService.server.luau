--!strict
-- Authors: ΣTΞCH (SigmaTech)
-- September 17, 2025
--[[
	PriceService.server.luau

	Description:
		Fetches and caches Counter-Strike item prices from the public tracker.
		Exposes data to clients via typed remotes in `Network.luau`.
]]

--Σ Services Σ--
local HttpService = game:GetService("HttpService")

--Σ Requires Σ--
local Network = require("@Network")

--Σ Types Σ--
type PricesTable = { [string]: any }

--Σ Constants Σ--
local PRICES_URL = "https://raw.githubusercontent.com/ByMykel/counter-strike-price-tracker/main/static/prices/latest.json"

--Σ Volatiles Σ--
local _prices: PricesTable = {}

--------------------------------------------------------------------------------
--MARK: Private Functions
--------------------------------------------------------------------------------

local function fetchPrices(): PricesTable
    local ok, result = pcall(function()
        return HttpService:GetAsync(PRICES_URL)
    end)
    if not ok then
        warn("PriceService: Failed to fetch prices (network). Returning cached/empty.")
        return _prices
    end

    local decodedOk, decoded = pcall(function()
        return HttpService:JSONDecode(result)
    end)
    if not decodedOk then
        warn("PriceService: Failed to decode prices JSON. Returning cached/empty.")
        return _prices
    end
    return decoded :: PricesTable
end

--------------------------------------------------------------------------------
--MARK: Methods
--------------------------------------------------------------------------------

local PriceService = {}

function PriceService:GetPrices(): PricesTable
    return _prices
end

--------------------------------------------------------------------------------
--MARK: Lifecycle Methods
--------------------------------------------------------------------------------

function PriceService:InterlaceInit()
    -- Make data immediately available to clients
    (Network.GetPrices :: any).OnServerInvoke = function(_player)
        return _prices
    end
end

function PriceService:InterlaceStart()
    -- Initial fetch and periodic refresh
    task.spawn(function()
        _prices = fetchPrices()
        -- Refresh every 10 minutes
        while true do
            task.wait(600)
            local new = fetchPrices()
            if typeof(new) == "table" then
                _prices = new
            end
        end
    end)
end

return PriceService


