print("IRON SOUL FPS TEST")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "IronSoulFPSTest"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(200, 60)
button.Position = UDim2.new(0.5, -100, 0.5, -30)
button.Text = "POTATO TEST"
button.TextScaled = true
button.Parent = gui

print("IRON SOUL FPS GUI CREATED")
