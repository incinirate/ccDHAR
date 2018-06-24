local pproc = loadfile("pproc.lua")

local function processFile(fileName)
  return pproc(fileName, "--sout")
end

local out = processFile("src/api.lua")
local handle = io.open("ccdhar.lua", "w")
handle:write(out)
handle:close()

print("Built ccDHAR to ./ccdhar.lua")
