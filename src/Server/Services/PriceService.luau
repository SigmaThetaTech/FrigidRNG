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
local BYMYKEL_URL = "https://raw.githubusercontent.com/ByMykel/counter-strike-price-tracker/main/static/prices/latest.json"
local CSFLOAT_URL = "https://csfloat.com/api/v1/listings/price-list"

--Σ Volatiles Σ--
local _prices: PricesTable = {}

--------------------------------------------------------------------------------
--MARK: Private Functions
--------------------------------------------------------------------------------

local function safeGetJson(url: string): any?
    local ok, body = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if not ok then
        warn("PriceService: Failed to fetch url:", url)
        return nil
    end

    local decodedOk, decoded = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if not decodedOk then
        warn("PriceService: Failed to decode json from:", url)
        return nil
    end
    return decoded
end

local function fetchByMykel(): PricesTable
    local json = safeGetJson(BYMYKEL_URL)
    if typeof(json) == "table" then
        return json :: any
    end
    return {}
end

-- CSFloat returns an array with min_price in cents; convert to dollars
local function fetchCSFloat(): PricesTable
    local json = safeGetJson(CSFLOAT_URL)
    local map: PricesTable = {}
    if typeof(json) == "table" then
        for _, entry in (json :: any) do
            if typeof(entry) == "table" then
                local name: any = (entry :: any)["market_hash_name"]
                local minCents: any = (entry :: any)["min_price"]
                if typeof(name) == "string" and typeof(minCents) == "number" then
                    local dollars = (minCents :: number) / 100
                    local existing = map[name]
                    if typeof(existing) ~= "table" then
                        existing = {}
                        map[name] = existing
                    end
                    (existing :: any)["csfloat"] = { min_price = dollars }
                end
            end
        end
    end
    return map
end

local function mergeVendorPrices(into: PricesTable, from: PricesTable)
    for name, vendorEntry in pairs(from) do
        local dest = into[name]
        if typeof(dest) ~= "table" then
            into[name] = vendorEntry
        else
            if typeof(vendorEntry) == "table" then
                for vendorKey, vendorData in pairs(vendorEntry :: any) do
                    (dest :: any)[vendorKey] = vendorData
                end
            end
        end
    end
end

local function fetchAllVendors(): PricesTable
    local csfloat = fetchCSFloat()
    local bymykel = fetchByMykel()
    local combined: PricesTable = {}
    mergeVendorPrices(combined, bymykel)
    mergeVendorPrices(combined, csfloat)
    return combined
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
        _prices = fetchAllVendors()
        -- Refresh every 10 minutes
        while true do
            task.wait(600)
            local new = fetchAllVendors()
            if typeof(new) == "table" then
                _prices = new
            end
        end
    end)
end

return PriceService


