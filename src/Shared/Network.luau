--!strict
-- Authors: ΣTΞCH (SigmaTech)
-- July 23, 2024
--[[
    Network.luau

    Description:
        Simple networking package that helps create typed RemoteEvents and RemoteFunctions.

    Example usage:
        ```lua
        local Network = require("@Network")

        -- If you type this out, intellisense will help with what the function signature should be:
        Network.MyEvent.OnClientEvent:Connect(function(player, str, num) -- ALWAYS INCLUDE PLAYER AS FIRST ARGUMENT
            -- Foo
        end)
        ```
    Remote Function type format:
        RF<(parameter types), (return types)>,
    ```lua
    MyFunction = Get_RF
]]

--// Requires //--
local TypedRemote = require("@Packages/TypedRemote")

--// Types //--
type RF<T..., R...> = TypedRemote.Function<T..., R...>
type RE<T...> = TypedRemote.Event<T...>

--// Volatiles //--
local Create_RF, Create_RE = TypedRemote.parent(script)

-- Define network table:
return {
    --[[
	-- RemoteEvent that takes two arguments - a string and a number:
    MyEvent = Get_RE("MyEvent") :: RE<(string, number)>,

	-- RemoteFunction that takes two arguments (boolean, string) and returns a number:
	MyFunction = Get_RF("MyRemoteFunctionLol") :: RF<(boolean, string), (number)>,
    ]]

    ProximityPromptTriggered = Create_RE("ProximityPromptTriggered") :: RE<(number)>,

    -- Inventory / Catalog remotes
    GetPrices = Create_RF("GetPrices") :: RF<(), ({ [string]: any })>,
    GetSkins = Create_RF("GetSkins") :: RF<(), ({ any })>,
    SellItem = Create_RE("SellItem") :: RE<(string)>,
}