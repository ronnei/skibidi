local sg = Instance.new("ScreenGui")
sg.Name = "RonneiSparkleRainbow3D"
sg.ResetOnSpawn = false
sg.Parent = game:GetService("CoreGui")

local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 370, 0, 160)
MainContainer.Position = UDim2.new(0.5, -185, 0.5, -80)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = sg

-- LỚP 1: Bóng đổ sâu
local LayerShadow = Instance.new("Frame")
LayerShadow.Size = UDim2.new(1, 0, 1, 0)
LayerShadow.Position = UDim2.new(0, 0, 0, 8)
LayerShadow.BackgroundColor3 = Color3.fromRGB(8, 5, 18)
LayerShadow.BorderSizePixel = 0
LayerShadow.Parent = MainContainer

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 16)
ShadowCorner.Parent = LayerShadow

-- LỚP 2: Khối chân Cầu Vồng 3D
local Layer3DBorder = Instance.new("Frame")
Layer3DBorder.Size = UDim2.new(1, 0, 1, 0)
Layer3DBorder.Position = UDim2.new(0, 0, 0, 4)
Layer3DBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Layer3DBorder.BorderSizePixel = 0
Layer3DBorder.Parent = MainContainer

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 16)
BorderCorner.Parent = Layer3DBorder

local BorderGradient = Instance.new("UIGradient")
BorderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})
BorderGradient.Parent = Layer3DBorder

-- LỚP 3: Mặt chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 15, 32)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainContainer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Viền phát sáng Cầu Vồng Lấp Lánh
local FrontStroke = Instance.new("UIStroke")
FrontStroke.Thickness = 3.5
FrontStroke.Color = Color3.fromRGB(255, 255, 255)
FrontStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FrontStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 200, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(180, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 100))
})
StrokeGradient.Parent = FrontStroke

-- TEXT: TIKTOK
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0.35, 0)
label.Position = UDim2.new(0, 0, 0.08, 0)
label.BackgroundTransparency = 1
label.Text = "TIKTOK: ronnei7.htk"
label.TextColor3 = Color3.fromRGB(0, 255, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 22
label.TextStrokeTransparency = 0.4
label.Parent = MainFrame

-- TEXT: NOTE
local noteLabel = Instance.new("TextLabel")
noteLabel.Size = UDim2.new(1, -24, 0.28, 0)
noteLabel.Position = UDim2.new(0, 12, 0.42, 0)
noteLabel.BackgroundTransparency = 1
noteLabel.Text = "script nokey mà còn chưa follow nữa ✂️ 🐦"
noteLabel.TextColor3 = Color3.fromRGB(255, 85, 115)
noteLabel.Font = Enum.Font.GothamMedium
noteLabel.TextSize = 15
noteLabel.TextWrapped = true
noteLabel.TextStrokeTransparency = 0.8
noteLabel.Parent = MainFrame

-- TEXT: TIMER
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(1, 0, 0.2, 0)
timerLabel.Position = UDim2.new(0, 0, 0.75, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "Khởi chạy sau 10 giây..."
timerLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextSize = 12
timerLabel.Parent = MainFrame

-- HIỆU ỨNG CẦU VỒNG XOAY VÀ LẤP LÁNH (SPARKLE RAINBOW)
task.spawn(function()
    local rot = 0
    while sg and sg.Parent do
        rot = (rot + 3) % 360
        StrokeGradient.Rotation = rot
        BorderGradient.Rotation = rot
        
        -- Tạo hiệu ứng chớp nháy độ dầy viền (Sparkle effect)
        FrontStroke.Thickness = 3 + math.sin(tick() * 10) * 1.2
        task.wait(0.01)
    end
end)

-- Đếm ngược 10 giây
for i = 10, 1, -1 do
    timerLabel.Text = "✨ Khởi chạy sau " .. i .. " giây..."
    task.wait(1)
end

timerLabel.Text = "Đang tải Script..."

-- Hiệu ứng lún chìm 3D khi biến mất
for opacity = 0, 1, 0.1 do
    MainFrame.BackgroundTransparency = opacity
    LayerShadow.BackgroundTransparency = opacity
    Layer3DBorder.BackgroundTransparency = opacity
    label.TextTransparency = opacity
    noteLabel.TextTransparency = opacity
    timerLabel.TextTransparency = opacity
    FrontStroke.Transparency = opacity
    MainContainer.Position = MainContainer.Position + UDim2.new(0, 0, 0, 1)
    task.wait(0.02)
end

sg:Destroy()

-- ==========================================
-- KHỞI CHẠY SCRIPT
-- ==========================================
loadstring(game:HttpGet("https://vxezestudio.online/api/scripts/script_G5CGjqj2X3rOS/stream/init"))()
