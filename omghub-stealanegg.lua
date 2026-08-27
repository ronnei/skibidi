local sg = Instance.new("ScreenGui")
sg.Name = "RonneiFollowCheckUI"
sg.ResetOnSpawn = false
sg.Parent = game:GetService("CoreGui")

local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 380, 0, 200)
MainContainer.Position = UDim2.new(0.5, -190, 0.5, -100)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = sg

-- LỚP 1: Bóng đổ 3D
local LayerShadow = Instance.new("Frame")
LayerShadow.Size = UDim2.new(1, 0, 1, 0)
LayerShadow.Position = UDim2.new(0, 0, 0, 8)
LayerShadow.BackgroundColor3 = Color3.fromRGB(8, 5, 18)
LayerShadow.BorderSizePixel = 0
LayerShadow.Parent = MainContainer

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 16)
ShadowCorner.Parent = LayerShadow

-- LỚP 2: Viền Cầu Vồng 3D
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
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})
BorderGradient.Parent = Layer3DBorder

-- LỚP 3: Mặt bảng chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 15, 32)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainContainer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local FrontStroke = Instance.new("UIStroke")
FrontStroke.Thickness = 2.5
FrontStroke.Color = Color3.fromRGB(255, 255, 255)
FrontStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
FrontStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 100))
})
StrokeGradient.Parent = FrontStroke

-- TEXT: TIKTOK (Chuyển sang màu Pastel dịu mắt, giảm viền chói)
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0.22, 0)
label.Position = UDim2.new(0, 0, 0.06, 0)
label.BackgroundTransparency = 1
label.Text = "TIKTOK: ronnei7.htk"
label.TextColor3 = Color3.fromRGB(160, 235, 240) -- Xanh pastel dịu mắt
label.Font = Enum.Font.GothamBold
label.TextSize = 20
label.TextStrokeTransparency = 0.8
label.Parent = MainFrame

-- TEXT: QUESTION NOTE (Trắng Kem dịu mắt)
local noteLabel = Instance.new("TextLabel")
noteLabel.Size = UDim2.new(1, -20, 0.22, 0)
noteLabel.Position = UDim2.new(0, 10, 0.28, 0)
noteLabel.BackgroundTransparency = 1
noteLabel.Text = "Bạn đã follow TikTok ronnei7.htk chưa? 🥺"
noteLabel.TextColor3 = Color3.fromRGB(220, 220, 210) -- Trắng kem nhẹ nhàng
noteLabel.Font = Enum.Font.GothamMedium
noteLabel.TextSize = 14
noteLabel.TextWrapped = true
noteLabel.TextStrokeTransparency = 0.9
noteLabel.Parent = MainFrame

-- CONTAINERS BẢNG NÚT BẤM
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -30, 0.33, 0)
ButtonContainer.Position = UDim2.new(0, 15, 0.56, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- NÚT XANH LÁ: ĐÃ FOLLOW
local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0.6, -5, 1, 0)
YesBtn.Position = UDim2.new(0, 0, 0, 0)
YesBtn.BackgroundColor3 = Color3.fromRGB(35, 150, 90) -- Xanh lá trầm hơn không bị chói
YesBtn.Text = "✅ ĐÃ FOLLOW"
YesBtn.TextColor3 = Color3.fromRGB(240, 255, 240)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.TextSize = 13
YesBtn.Parent = ButtonContainer

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 10)
YesCorner.Parent = YesBtn

local YesStroke = Instance.new("UIStroke")
YesStroke.Thickness = 1.5
YesStroke.Color = Color3.fromRGB(80, 200, 130)
YesStroke.Parent = YesBtn

-- NÚT ĐỎ: CHƯA FOLLOW
local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0.4, -5, 1, 0)
NoBtn.Position = UDim2.new(0.6, 5, 0, 0)
NoBtn.BackgroundColor3 = Color3.fromRGB(140, 45, 55) -- Đỏ đô trấm dịu mắt
NoBtn.Text = "❌ Chưa follow"
NoBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
NoBtn.Font = Enum.Font.Gotham
NoBtn.TextSize = 12
NoBtn.Parent = ButtonContainer

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 10)
NoCorner.Parent = NoBtn

-- HIỆU ỨNG XOAY VIỀN
task.spawn(function()
    local rot = 0
    while sg and sg.Parent do
        rot = (rot + 2) % 360
        StrokeGradient.Rotation = rot
        BorderGradient.Rotation = rot
        task.wait(0.01)
    end
end)

-- XỬ LÝ SỰ KIỆN NÚT BẤM
YesBtn.MouseButton1Click:Connect(function()
    ButtonContainer:Destroy()
    noteLabel.Text = "🎉 Cảm ơn bạn đã follow ronnei7.htk!"
    noteLabel.TextColor3 = Color3.fromRGB(140, 230, 170)
    
    local timerLabel = Instance.new("TextLabel")
    timerLabel.Size = UDim2.new(1, 0, 0.2, 0)
    timerLabel.Position = UDim2.new(0, 0, 0.65, 0)
    timerLabel.BackgroundTransparency = 1
    timerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    timerLabel.Font = Enum.Font.Gotham
    timerLabel.TextSize = 13
    timerLabel.Parent = MainFrame

    for i = 5, 1, -1 do
        timerLabel.Text = "⚡ Khởi chạy script sau " .. i .. " giây..."
        task.wait(1)
    end
    
    timerLabel.Text = "Đang tải Script..."

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
    
    -- KHỞI CHẠY SCRIPT
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
end)

NoBtn.MouseButton1Click:Connect(function()
    ButtonContainer:Destroy()
    noteLabel.Text = "Chưa follow sao 👿\n\n⚠️ Bạn đã chọn sai! Script sẽ KHÔNG khởi chạy."
    noteLabel.TextColor3 = Color3.fromRGB(230, 90, 90)
    noteLabel.Size = UDim2.new(1, -20, 0.5, 0)
    
    task.wait(4)
    sg:Destroy()
end)
