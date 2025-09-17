--!nocheck
-- Authors: ΣTΞCH (SigmaTech)
-- July 23, 2024
--[[
    ServerStartup.server.luau

    Description:
    
]]

--// Requires //--
local Loader = require("@Packages/Loader")

-- Make sure there is a Services folder
if not script.Parent:FindFirstChild("Services") then
    local controllersFolder: Folder = Instance.new("Folder")
    controllersFolder.Name = "Services"
    controllersFolder.Parent = script.Parent
end

--// Constants //--
local SERVICES_FOLDER: Folder = script.Parent.Services
local INIT_METHOD_NAME: string = "InterlaceInit"
local START_METHOD_NAME: string = "InterlaceStart"

--// Volatiles //--
local services: { [string]: any } = Loader.LoadDescendants(SERVICES_FOLDER, Loader.MatchesName("Service$"))

--// STARTUP //--

-- Signal that the Workspace is not loaded yet
workspace:SetAttribute("SERVER_LOADED", false)

-- Call :Init for all services synchronously
for name: string, mod: any in services do
    local method: any = mod[INIT_METHOD_NAME]
    if type(method) == "function" then 
        method(mod)
    end
end

-- Lazy load all modules that aren't services asynchronously
local modules = Loader.LoadDescendants(script.Parent)
-- Eject all modules that are controllers
for name: string, mod: any in services do
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

-- Call :Start for all services asynchronously
Loader.SpawnAll(services, START_METHOD_NAME) -- Call OnStart for all services

-- Signal that the Workspace is loaded
workspace:SetAttribute("SERVER_LOADED", true)