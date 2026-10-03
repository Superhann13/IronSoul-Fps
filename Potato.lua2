--// IRON SOUL: DUNGEON - POTATO MODE
--// FPS / Visual Optimizer
--// Toggle ON / OFF
--// Only runs in Iron Soul: Dungeon

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local MarketplaceService = game:GetService("MarketplaceService")

local Player = Players.LocalPlayer

--==================================================
-- GAME CHECK
--==================================================

local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if not success or not gameInfo then
    warn("[IronSoul FPS] Cannot identify game.")
    return
end

local gameName = string.lower(gameInfo.Name or "")

if not string.find(gameName, "iron soul") then
    warn("[IronSoul FPS] This script only runs in Iron Soul: Dungeon.")
    return
end

--==================================================
-- SETTINGS
--==================================================

local PotatoEnabled = false
local Saved = {}

--==================================================
-- SAVE / SET
--==================================================

local function saveProperty(obj, property)
    Saved[obj] = Saved[obj] or {}

    if Saved[obj][property] == nil then
        local success, value = pcall(function()
            return obj[property]
        end)

        if success then
            Saved[obj][property] = value
        end
    end
end

local function setProperty(obj, property, value)
    saveProperty(obj, property)

    pcall(function()
        obj[property] = value
    end)
end

--==================================================
-- RESTORE
--==================================================

local function restore()
    for obj, properties in pairs(Saved) do
        if obj and obj.Parent then
            for property, value in pairs(properties) do
                pcall(function()
                    obj[property] = value
                end)
            end
        end
    end

    table.clear(Saved)
end

--==================================================
-- OPTIMIZE VISUALS
--==================================================

local function optimize(obj)

    if obj:IsA("ParticleEmitter") then
        setProperty(obj, "Enabled", false)

    elseif obj:IsA("Trail") then
        setProperty(obj, "Enabled", false)

    elseif obj:IsA("Beam") then
        setProperty(obj, "Enabled", false)

    elseif obj:IsA("Fire") then
        setProperty(obj, "Enabled", false)

    elseif obj:IsA("Smoke") then
        setProperty(obj, "Enabled", false)

    elseif obj:IsA("Sparkles") then
        setProperty(obj, "Enabled", false)

    elseif obj:IsA("BloomEffect")
        or obj:IsA("BlurEffect")
        or obj:IsA("ColorCorrectionEffect")
        or obj:IsA("DepthOfFieldEffect")
        or obj:IsA("SunRaysEffect") then

        setProperty(obj, "Enabled", false)
    end
end

--==================================================
-- POTATO ON
--==================================================

local function potatoOn()

    if PotatoEnabled then
        return
    end

    PotatoEnabled = true

    for _, obj in ipairs(game:GetDescendants()) do
        optimize(obj)
    end

    setProperty(Lighting, "GlobalShadows", false)

    print("[IronSoul FPS] Potato Mode: ON")
end

--==================================================
-- POTATO OFF
--==================================================

local function potatoOff()

    if not PotatoEnabled then
        return
    end

    PotatoEnabled = false

    restore()

    print("[IronSoul FPS] Potato Mode: OFF")
end

--==================================================
-- NEW EFFECT DETECTOR
--==================================================

game.DescendantAdded:Connect(function(obj)

    if not PotatoEnabled then
        return
    end

    task.defer(function()

        if obj and obj.Parent then
            optimize(obj)
        end

    end)

end)

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "IronSoulFPS"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Button = Instance.new("TextButton")

Button.Size = UDim2.fromOffset(170, 48)
Button.Position = UDim2.new(0, 20, 0.5, 0)

Button.BackgroundTransparency = 0.15
Button.TextColor3 = Color3.new(1, 1, 1)

Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.Text = "POTATO : OFF"

Button.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Button

--==================================================
-- TOGGLE
--==================================================

Button.MouseButton1Click:Connect(function()

    if PotatoEnabled then

        potatoOff()
        Button.Text = "POTATO : OFF"

    else

        potatoOn()
        Button.Text = "POTATO : ON"

    end

end)

print("[IronSoul FPS] Potato Mode loaded successfully.")
