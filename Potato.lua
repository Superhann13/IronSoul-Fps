--// IRON SOUL: DUNGEON - POTATO MODE
--// Visual FPS Optimizer
--// Toggle ON / OFF

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

--==================================================
-- GAME CHECK
--==================================================

local GAME_NAME = "Iron Soul: Dungeon"

if not game:IsLoaded() then
    game.Loaded:Wait()
end

print("[Potato] Loaded for:", game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

--==================================================
-- SETTINGS
--==================================================

local PotatoEnabled = false
local Saved = {}

--==================================================
-- SAVE PROPERTY
--==================================================

local function save(obj, property)
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

local function set(obj, property, value)
    save(obj, property)

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
-- DISABLE VISUAL EFFECT
--==================================================

local function optimize(obj)

    -- Particle effects
    if obj:IsA("ParticleEmitter") then
        set(obj, "Enabled", false)

    -- Weapon / skill trails
    elseif obj:IsA("Trail") then
        set(obj, "Enabled", false)

    -- Beams / laser effects
    elseif obj:IsA("Beam") then
        set(obj, "Enabled", false)

    -- Fire
    elseif obj:IsA("Fire") then
        set(obj, "Enabled", false)

    -- Smoke
    elseif obj:IsA("Smoke") then
        set(obj, "Enabled", false)

    -- Sparkles
    elseif obj:IsA("Sparkles") then
        set(obj, "Enabled", false)

    -- Post processing
    elseif obj:IsA("BloomEffect")
        or obj:IsA("BlurEffect")
        or obj:IsA("ColorCorrectionEffect")
        or obj:IsA("DepthOfFieldEffect")
        or obj:IsA("SunRaysEffect") then

        set(obj, "Enabled", false)
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

    -- Existing effects
    for _, obj in ipairs(game:GetDescendants()) do
        optimize(obj)
    end

    -- Disable global shadows
    set(Lighting, "GlobalShadows", false)

    print("[Potato] ON")
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

    print("[Potato] OFF")
end

--==================================================
-- CATCH NEW EFFECTS
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
Gui.Name = "IronSoulPotato"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Button = Instance.new("TextButton")

Button.Size = UDim2.fromOffset(170, 48)
Button.Position = UDim2.new(0, 20, 0.5, 0)

Button.BackgroundTransparency = 0.15
Button.TextColor3 = Color3.new(1,1,1)

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

print("================================")
print(" IRON SOUL POTATO MODE READY")
print("================================")
