--!strict
-- Authors: ΣTΞCH (SigmaTech)
-- July 23, 2024
--[[
    ServerStartup.server.luau

    Description:

]]

--// Requires //--
local Loader = require("@Packages/Loader")

--// Types //--

--// Constants //--
local CONTROLLERS_FOLDER: Folder = script.Parent.Controllers
local INIT_METHOD_NAME: string = "Init"
local START_METHOD_NAME: string = "Start"

--// Volatiles //--
local controllers: { [string]: any } = Loader.LoadDescendants(CONTROLLERS_FOLDER, Loader.MatchesName("Controller$"))

--// STARTUP //--

-- Wait until the server is loaded!
if not workspace:GetAttribute("SERVER_LOADED") then
    workspace:GetAttributeChangedSignal("SERVER_LOADED"):Wait()
end

-- Call :Init for all controllers synchronously
for name: string, mod: any in controllers do
    local method: any = mod[INIT_METHOD_NAME]
    if type(method) == "function" then
        method(mod)
    end
end 

-- Lazy load all modules that aren't controllers asynchronously
local modules = Loader.LoadDescendants(script.Parent)
-- Eject all modules that are controllers
for name: string, mod: any in controllers do
    modules[name] = nil
end
for name: string, mod: ModuleScript in modules do
    if typeof(mod) ~= "Instance" then continue end
    if not mod:IsA("ModuleScript") then continue end
    assert(mod:IsA("ModuleScript"), "Expected ModuleScript")
    task.spawn(function()
        require(mod :: ModuleScript)
    end)
end

-- Call :Start for all controllers asynchronously
Loader.SpawnAll(controllers, START_METHOD_NAME) -- Call OnStart for all controllers