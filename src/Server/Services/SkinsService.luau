--!strict
-- Authors: ΣTΞCH (SigmaTech)
-- September 17, 2025
--[[
	SkinsService.server.luau

	Description:
		Fetches and caches Counter-Strike skins JSON. Exposes to clients via
		typed remotes in `Network.luau`.
]]

--Σ Services Σ--
local HttpService = game:GetService("HttpService")

--Σ Requires Σ--
local Network = require("@Network")

--Σ Types Σ--
type SkinsArray = { any }

--Σ Constants Σ--
local SKINS_URL = "https://raw.githubusercontent.com/ByMykel/CSGO-API/main/public/api/en/skins_not_grouped.json"

--Σ Volatiles Σ--
local _skins: SkinsArray = {}
local _skinsInitialized = false

--------------------------------------------------------------------------------
--MARK: Private Functions
--------------------------------------------------------------------------------

local function fetchSkins(): SkinsArray
    local ok, result = pcall(function()
        return HttpService:GetAsync(SKINS_URL)
    end)
    if not ok then
        warn("SkinsService: Failed to fetch skins (network). Returning cached/empty.")
        return _skins
    end

    local decodedOk, decoded = pcall(function()
        return HttpService:JSONDecode(result)
    end)
    if not decodedOk then
        warn("SkinsService: Failed to decode skins JSON. Returning cached/empty.")
        return _skins
    end
    _skinsInitialized = true
    return decoded :: SkinsArray
end

--------------------------------------------------------------------------------
--MARK: Methods
--------------------------------------------------------------------------------

local SkinsService = {}

function SkinsService:GetSkins(): SkinsArray
    return _skins
end

--------------------------------------------------------------------------------
--MARK: Lifecycle Methods
--------------------------------------------------------------------------------

function SkinsService:InterlaceInit()
    Network.GetSkins.OnServerInvoke = function(_player)
        if not _skinsInitialized then
            while not _skinsInitialized do
                task.wait(0.1)
            end
        end
        return _skins
    end
end

function SkinsService:InterlaceStart()
    task.spawn(function()
        _skins = fetchSkins()
        -- Refresh daily
        while true do
            local new = fetchSkins()
            if typeof(new) == "table" then
                _skins = new
            end
            task.wait(86400)
        end
    end)
end

return SkinsService


