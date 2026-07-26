-- Меню для КАТАСТРОФИЯ ☢️ Пережить! ☢️
-- Версия: Xeno Private v1.0
-- Каждый запуск — уникальные сигнатуры

local function genName(len)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local name = ""
    for i = 1, len do name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars)) end
    return name
end

-- Случайные имена для защиты от античита
local libName = genName(16)
local guiName = genName(12)
local mainFunc = genName(20)

-- Создаём GUI
local gui = Instance.new("ScreenGui")
gui.Name = guiName
gui.Parent = game.CoreGui

-- Главное окно
local main = Instance.new("Frame")
main.Name = genName(8)
main.Size = UDim2.new(0, 250, 0, 350)
main.Position = UDim2.new(0.5, -125, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

-- Заголовок
local title = Instance.new("TextLabel")
title.Name = genName(6)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "☢️ Catastrophe Menu ☢️"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.Parent = main

-- Вкладки
local tabs = {"🌀 Фарм", "👁 ESP", "⚡ Статы", "🚗 Транспорт"}
local tabButtons = {}
local currentTab = nil
local contentFrame = Instance.new("Frame")
contentFrame.Name = genName(7)
contentFrame.Size = UDim2.new(1, 0, 1, -75)
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = main

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = genName(5)
    btn.Size = UDim2.new(0.25, 0, 0, 30)
    btn.Position = UDim2.new((i-1)*0.25, 0, 1, -40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = tabName
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = main
    
    local content = Instance.new("Frame")
    content.Name = genName(6)
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.Visible = false
    content.Parent = contentFrame
    
    if i == 1 then
        content.Visible = true
        currentTab = content
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
    
    btn.MouseButton1Click:Connect(function()
        if currentTab then currentTab.Visible = false end
        for _, b in pairs(tabButtons) do b.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end
        content.Visible = true
        currentTab = content
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    tabButtons[btn] = true
    content.Name = tabName
end

-- Функция создания кнопки
local function createButton(parent, text, yPos, callback, toggle)
    local btn = Instance.new("TextButton")
    btn.Name = genName(7)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    if toggle then
        local toggled = false
        btn.MouseButton1Click:Connect(function()
            toggled = not toggled
            btn.BackgroundColor3 = toggled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
            btn.Text = (toggled and "✅ " or "❌ ") .. text:gsub("[✅❌] ", "")
            callback(toggled)
        end)
    else
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

-- ===== ВКЛАДКА ФАРМ =====
local farmTab = contentFrame:FindFirstChild("🌀 Фарм")

createButton(farmTab, "Авто-сбор лута", 10, function(toggled)
    _G.AutoFarm = toggled
    if toggled then
        spawn(function()
            while _G.AutoFarm do
                local p = game.Players.LocalPlayer
                local c = p.Character
                if c then
                    local root = c:FindFirstChild("HumanoidRootPart")
                    local hum = c:FindFirstChild("Humanoid")
                    if root and hum then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v:IsA("BasePart") and v:FindFirstChild("ProximityPrompt") then
                                local dist = (root.Position - v.Position).Magnitude
                                if dist < 50 then
                                    hum:MoveTo(v.Position)
                                    wait(math.random(0.3, 0.8))
                                    if v:FindFirstChild("ProximityPrompt") and v.ProximityPrompt.Enabled then
                                        fireproximityprompt(v.ProximityPrompt)
                                    end
                                    wait(math.random(1.5, 3))
                                end
                            end
                        end
                    end
                end
                wait(math.random(0.5, 1))
            end
        end)
    end
end, true)

createButton(farmTab, "Авто-подбор редкого лута", 55, function(toggled)
    _G.AutoRare = toggled
    if toggled then
        spawn(function()
            local rareItems = {"AK47", "M16", "Shotgun", "Sniper", "GasMask", "RadSuit", "Medkit", "Backpack", "MRE", "WaterBottle"}
            while _G.AutoRare do
                local p = game.Players.LocalPlayer
                local c = p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v:FindFirstChild("ProximityPrompt") then
                            for _, rare in pairs(rareItems) do
                                if v.Name:lower():find(rare:lower()) then
                                    c.Humanoid:MoveTo(v.Position)
                                    wait(0.5)
                                    fireproximityprompt(v.ProximityPrompt)
                                    wait(1)
                                end
                            end
                        end
                    end
                end
                wait(3)
            end
        end)
    end
end, true)

createButton(farmTab, "Телепорт к точке на карте", 100, function()
    local p = game.Players.LocalPlayer
    local c = p.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        local mouse = p:GetMouse()
        mouse.KeyDown:Connect(function(key)
            if key == "t" then
                c.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
            end
        end)
    end
end, false)

-- ===== ВКЛАДКА ESP =====
local espTab = contentFrame:FindFirstChild("👁 ESP")

createButton(espTab, "ESP предметов", 10, function(toggled)
    _G.ESPItems = toggled
    if toggled then
        spawn(function()
            while _G.ESPItems do
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v:FindFirstChild("ProximityPrompt") then
                        if not v:FindFirstChild("ESP_Highlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "ESP_Highlight"
                            hl.FillColor = Color3.fromRGB(0, 255, 0)
                            hl.OutlineColor = Color3.fromRGB(0, 200, 0)
                            hl.FillTransparency = 0.5
                            hl.Parent = v
                        end
                    end
                end
                wait(2)
            end
            -- Очистка при выключении
            for _, v in pairs(workspace:GetDescendants()) do
                if v:FindFirstChild("ESP_Highlight") then
                    v.ESP_Highlight:Destroy()
                end
            end
        end)
    end
end, true)

createButton(espTab, "ESP игроков", 55, function(toggled)
    _G.ESPPlayers = toggled
    if toggled then
        spawn(function()
            while _G.ESPPlayers do
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not p.Character.HumanoidRootPart:FindFirstChild("PlayerESP") then
                            local bg = Instance.new("BillboardGui")
                            bg.Name = "PlayerESP"
                            bg.Size = UDim2.new(0, 100, 0, 30)
                            bg.StudsOffset = Vector3.new(0, 3, 0)
                            bg.AlwaysOnTop = true
                            bg.Parent = p.Character.HumanoidRootPart
                            
                            local txt = Instance.new("TextLabel")
                            txt.Size = UDim2.new(1, 0, 1, 0)
                            txt.BackgroundTransparency = 1
                            txt.TextColor3 = Color3.fromRGB(255, 0, 0)
                            txt.TextStrokeTransparency = 0
                            txt.Text = p.Name .. "\n" .. math.floor((p.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m"
                            txt.Font = Enum.Font.SourceSans
                            txt.TextSize = 12
                            txt.Parent = bg
                        end
                    end
                end
                wait(1)
            end
            -- Очистка
            for _, p in pairs(game.Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local esp = p.Character.HumanoidRootPart:FindFirstChild("PlayerESP")
                    if esp then esp:Destroy() end
                end
            end
        end)
    end
end, true)

-- ===== ВКЛАДКА СТАТЫ =====
local statsTab = contentFrame:FindFirstChild("⚡ Статы")

createButton(statsTab, "Бесконечная выносливость", 10, function(toggled)
    _G.InfStamina = toggled
    if toggled then
        spawn(function()
            while _G.InfStamina do
                local p = game.Players.LocalPlayer
                if p.Character then
                    for _, v in pairs(p.Character:GetDescendants()) do
                        if v:IsA("NumberValue") and (v.Name:lower():find("stamina") or v.Name:lower():find("energy")) then
                            v.Value = 100
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end, true)

createButton(statsTab, "Скрытая регенерация HP", 55, function(toggled)
    _G.Regen = toggled
    if toggled then
        spawn(function()
            while _G.Regen do
                local p = game.Players.LocalPlayer
                if p.Character then
                    local hum = p.Character:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 and hum.Health < hum.MaxHealth then
                        hum.Health = math.min(hum.Health + 2, hum.MaxHealth)
                    end
                end
                wait(1)
            end
        end)
    end
end, true)

createButton(statsTab, "Анти-радиация", 100, function(toggled)
    _G.AntiRad = toggled
    if toggled then
        spawn(function()
            while _G.AntiRad do
                local p = game.Players.LocalPlayer
                if p.Character then
                    for _, v in pairs(p.Character:GetDescendants()) do
                        if v:IsA("Script") and v.Name:lower():find("rad") then
                            v.Disabled = true
                        end
                        if v:IsA("ParticleEmitter") or v:IsA("Beam") then
                            v.Enabled = false
                        end
                    end
                end
                wait(3)
            end
        end)
    end
end, true)

-- ===== ВКЛАДКА ТРАНСПОРТ =====
local vehicleTab = contentFrame:FindFirstChild("🚗 Транспорт")

createButton(vehicleTab, "Бесконечный бензин", 10, function(toggled)
    _G.InfFuel = toggled
    if toggled then
        spawn(function()
            while _G.InfFuel do
                local p = game.Players.LocalPlayer
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local car = nil
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v:FindFirstChild("Engine") then
                            if (v:GetPivot().Position - p.Character.HumanoidRootPart.Position).Magnitude < 10 then
                                car = v
                                break
                            end
                        end
                    end
                    if car and car:FindFirstChild("Engine") then
                        car.Engine.Value = 999
                    end
                end
                wait(0.5)
            end
        end)
    end
end, true)

createButton(vehicleTab, "Увеличенная скорость машины", 55, function(toggled)
    _G.SpeedBoost = toggled
    if toggled then
        spawn(function()
            while _G.SpeedBoost do
                local p = game.Players.LocalPlayer
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v:FindFirstChild("Engine") and v:FindFirstChild("MaxSpeed") then
                            v.MaxSpeed.Value = 200
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end, true)

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Name = genName(5)
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 12
closeBtn.BorderSizePixel = 0
closeBtn.Parent = main
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Сворачивание
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = genName(5)
minimizeBtn.Size = UDim2.new(0, 20, 0, 20)
minimizeBtn.Position = UDim2.new(1, -50, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 12
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = main

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    for _, btn in pairs(main:GetChildren()) do
        if btn:IsA("TextButton") and btn ~= closeBtn and btn ~= minimizeBtn then
            btn.Visible = not minimized
        end
    end
    main.Size = minimized and UDim2.new(0, 250, 0, 35) or UDim2.new(0, 250, 0, 350)
end)

print("☢️ Catastrophe Menu loaded! Press T to teleport to mouse position.")
