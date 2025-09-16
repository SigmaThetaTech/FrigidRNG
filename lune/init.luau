--!nocheck

local process = require("@lune/process")
local task = require("@lune/task")
local fs = require("@lune/fs")

local divider =
	"————————————————————————————————————————————————————————————————————————————————————————————"

local function parseDependencies(toml)
	local dependencies = {}

	-- Find the [dependencies] section
	local dependenciesSection = toml:match("%[dependencies%](.-)%[.-%]")
	if not dependenciesSection then
		dependenciesSection = toml:match("%[dependencies%](.*)")
	end

	if dependenciesSection then
		-- Iterate over each line in the dependencies section
		for line in dependenciesSection:gmatch("[^\r\n]+") do
			-- Match the key=value pattern
			local key, value = line:match('(%S+)%s*=%s*"(.-)"')
			if key and value then
				dependencies[key] = value
			end
		end
	end

	return dependencies
end

-- Getting the current os and processor architecture
print("Initializing require() conversion proceses and serving Rojo...")
print(divider)

-- Check if all packages in wally.toml are installed. If not, run wally install
print("[STEP 0]: Checking if all packages in wally.toml are installed...")
if not fs.isFile("./wally.toml") then
	print("wally.toml not found. Please make sure your project is set up correctly.")
	return
end

-- Check if all packages listed in wally.toml are installed in Packages/
local allPackagesInstalled: boolean = true
local wallyContents: string = fs.readFile("./wally.toml")
local dependencies: { [string]: string } = parseDependencies(wallyContents)

local function verifyDependencies(): boolean
	for key: string, value: string in pairs(dependencies) do
		-- Normalize value string such that forward slashes are replaced with underscores
		value = value:gsub("/", "_")
		local version: string? = value:match("@(.+)")

		local isInstalled = fs.isDir("./Packages/_Index/" .. value)
		if not isInstalled then
			-- Get the version number after the @ symbol in the value string
			print(key .. " v" .. tostring(version) .. " ❌ [Not installed]")
			print(divider)
			return false
		else
			print(key .. " v" .. tostring(version) .. " ✅ [Installed]")
		end
	end
	return true
end

-- If there is no Packages folder, then no packages are installed
-- If a package is not found in the Packages folder, then it is not installed
if fs.isDir("./Packages/") then
	allPackagesInstalled = verifyDependencies()
else
	print("Packages folder missing.")
	allPackagesInstalled = false
end

if allPackagesInstalled then
	print("All packages are installed.")
	print(divider)
else
	print("Not all packages are installed. Running wally install...")
	print(divider)
	process.spawn("wally", { "install" }, {
		-- Redirect the output to the console
		stdio = "inherit",
	})
	print(divider)
	verifyDependencies()
	print(divider)
end

-- Check if there's an out directory. If not, create one
if not fs.isDir("./out") then
	print("Creating out directory...")
	fs.writeDir("./out")
else
	-- Clear the contents of the out directory to fix any file conflicts
	print("Resetting output directory...")
	for _, file in fs.readDir("./out") do
		local thisPath = "./out/" .. file
		if fs.isFile(thisPath) then
			fs.removeFile(thisPath)
		elseif fs.isDir(thisPath) then
			fs.removeDir(thisPath)
		end
	end
	task.wait(0.5) -- So user can visually see the output directory being reset
end

-- Ensure sourcemap.json exists before running Rojo
if not fs.isFile("./sourcemap.json") then
	print("sourcemap.json not found. Creating a blank sourcemap.json file...")
	fs.writeFile("./sourcemap.json", "{}")
end

-- Ensure ServerPackages folder exists
if not fs.isDir("./ServerPackages") then
	print("ServerPackages folder not found. Creating ServerPackages directory...")
	fs.writeDir("./ServerPackages")
end

task.spawn(function()
	print("[STEP 1]: Watching the source files and compiling them to the output directory...")
	process.spawn("darklua", { "process", "--watch", "src", "out" }, {
		-- Redirect the output to the console
		stdio = "inherit",
	})
end)
task.wait(0.5)

task.spawn(function()
	-- ...existing code...
	print("[STEP 2]: Watching the Rojo project to regenerate the sourcemap...")
	process.spawn("rojo", { "sourcemap", "--watch", "default.project.json", "--output", "sourcemap.json" }, {
		-- Redirect the output to the console
		stdio = "inherit",
	})
end)

-- wally-package-types --sourcemap sourcemap.json Packages/ Provide the sourcemap to wally-package-types to retrieve relevant types and append them to the top of the package thunk
task.spawn(function()
	print(
		"[STEP 3]: Watching the sourcemap to retrieve relevant types and append them to the top of the package thunk..."
	)
	process.spawn("wally-package-types", { "--sourcemap", "sourcemap.json", "Packages/" })
end)

--"rojo serve build.project.json", -- [Serve the Rojo project]
task.spawn(function()
	print("[STEP 4]: Serving the Rojo project...")
	print(divider)
	process.spawn("rojo", { "serve", "build.project.json" }, {
		-- Redirect the output to the console
		stdio = "inherit",
	})
end)

task.delay(1, function()
	print(divider)
	print("Initialization complete!")
	task.wait(1)
	print("You may now connect Rojo in Roblox Studio to the server!")
	task.wait(1)
	print("Press Ctrl + C to stop the processes.")
end)
