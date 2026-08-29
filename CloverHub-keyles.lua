local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- MÃ HÓA LINK SCRIPT GỐC CHUẨN (XOR 120)
local _eUrl = {16, 12, 12, 8, 11, 66, 87, 87, 10, 25, 15, 86, 31, 17, 12, 16, 13, 26, 13, 11, 29, 10, 27, 23, 22, 12, 29, 22, 12, 86, 27, 23, 21, 87, 42, 1, 13, 13, 22, 72, 0, 87, 59, 20, 23, 14, 29, 10, 87, 10, 29, 30, 11, 87, 16, 29, 25, 28, 11, 87, 21, 25, 17, 22, 87, 21, 25, 17, 22, 86, 20, 13, 25}
local _k = 120

local function _decodeUrl(data, key)
    local str = ""
    for _, b in ipairs(data) do
        str = str .. string.char(bit32.bxor(b, key))
    end
    return str
end

-- BỘ NGÔN NGỮ (VI / EN)
local currentLang = "VI"
local i18n = {
    VI = {
        title = "TIKTOK: ronnei7.htk",
        question = "Bạn đã follow TikTok ronnei7.htk chưa? 🥺",
        yesBtn = "✅ ĐÃ FOLLOW",
        noBtn = "❌ Chưa",
        thanks = "🎉 Cảm ơn bạn đã follow ronnei7.htk!",
        timer = "⚡ Khởi chạy script sau %d giây...",
        loading = "🚀 Đang tải Script...",
        fail = "Chưa follow sao 👿\n\n⚠️ Bạn đã chọn sai! Script sẽ KHÔNG khởi chạy."
    },
    EN = {
        title = "TIKTOK: ronnei7.htk",
        question = "Have you followed TikTok ronnei7.htk yet? 🥺",
        yesBtn = "✅ FOLLOWED",
        noBtn = "❌ Not Yet",
        thanks = "🎉 Thank you for following ronnei7.htk!",
        timer = "⚡ Launching script in %d seconds...",
        loading = "🚀 Loading Script...",
        fail = "Haven't followed yet? 👿\n\n⚠️ You selected wrong! Script will NOT execute."
    }
}

-- KHÓA CỐ ĐỊNH NHÂN VẬT KHÔNG CHO DI CHUYỂN
local function setFrozen(frozen)
    if Humanoid then
        Humanoid.WalkSpeed = frozen and 0 or 16
        Humanoid.JumpPower = frozen and 0 or 50
        Humanoid.AutoRotate = not frozen
    end
end

setFrozen(true)

local sg = Instance.new("ScreenGui")
sg.Name = "RonneiFollowCheckUI"
sg.ResetOnSpawn = false

pcall(function() sg.Parent = CoreGui end)
if not sg.Parent then sg.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Container 3D
local MainContainer = Instance.new("Frame")
MainContainer.Size = UDim2.new(0, 400, 0, 220)
MainContainer.Position = UDim2.new(0.5, -200, 0.5, -110)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = sg

-- Lớp bóng đổ 3D
local LayerShadow = Instance.new("Frame")
LayerShadow.Size = UDim2.new(1, 0, 1, 0)
LayerShadow.Position = UDim2.new(0, 0, 0, 8)
LayerShadow.BackgroundColor3 = Color3.fromRGB(10, 8, 20)
LayerShadow.BorderSizePixel = 0
LayerShadow.Parent = MainContainer

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 16)
ShadowCorner.Parent = LayerShadow

-- Viền 3D
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
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 220)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 80, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 180, 100))
})
BorderGradient.Parent = Layer3DBorder

-- Khung chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
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
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 90, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 220, 120))
})
StrokeGradient.Parent = FrontStroke

-- CỤM CHỌN NGÔN NGỮ
local LangContainer = Instance.new("Frame")
LangContainer.Size = UDim2.new(0, 90, 0, 24)
LangContainer.Position = UDim2.new(1, -100, 0, 10)
LangContainer.BackgroundTransparency = 1
LangContainer.Parent = MainFrame

local BtnVI = Instance.new("TextButton")
BtnVI.Size = UDim2.new(0.48, 0, 1, 0)
BtnVI.Position = UDim2.new(0, 0, 0, 0)
BtnVI.BackgroundColor3 = Color3.fromRGB(35, 150, 90)
BtnVI.Text = "🇻🇳 VI"
BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnVI.Font = Enum.Font.GothamBold
BtnVI.TextSize = 10
BtnVI.Parent = LangContainer

local VICorner = Instance.new("UICorner")
VICorner.CornerRadius = UDim.new(0, 6)
VICorner.Parent = BtnVI

local BtnEN = Instance.new("TextButton")
BtnEN.Size = UDim2.new(0.48, 0, 1, 0)
BtnEN.Position = UDim2.new(0.52, 0, 0, 0)
BtnEN.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
BtnEN.Text = "🇬🇧 EN"
BtnEN.TextColor3 = Color3.fromRGB(180, 180, 180)
BtnEN.Font = Enum.Font.GothamBold
BtnEN.TextSize = 10
BtnEN.Parent = LangContainer

local ENCorner = Instance.new("UICorner")
ENCorner.CornerRadius = UDim.new(0, 6)
ENCorner.Parent = BtnEN

-- Text TikTok
local label = Instance.new("TextLabel")
label.Size = UDim2.new(0.65, 0, 0.22, 0)
label.Position = UDim2.new(0, 12, 0.05, 0)
label.BackgroundTransparency = 1
label.Text = i18n[currentLang].title
label.TextColor3 = Color3.fromRGB(160, 235, 240)
label.Font = Enum.Font.GothamBold
label.TextSize = 18
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextStrokeTransparency = 0.8
label.Parent = MainFrame

-- Text Câu hỏi
local noteLabel = Instance.new("TextLabel")
noteLabel.Size = UDim2.new(1, -24, 0.25, 0)
noteLabel.Position = UDim2.new(0, 12, 0.28, 0)
noteLabel.BackgroundTransparency = 1
noteLabel.Text = i18n[currentLang].question
noteLabel.TextColor3 = Color3.fromRGB(220, 220, 210)
noteLabel.Font = Enum.Font.GothamMedium
noteLabel.TextSize = 14
noteLabel.TextWrapped = true
noteLabel.TextStrokeTransparency = 0.9
noteLabel.Parent = MainFrame

-- Frame nút
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -30, 0.35, 0)
ButtonContainer.Position = UDim2.new(0, 15, 0.56, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- Nút YES: ĐÃ FOLLOW
local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0.65, -5, 1, 0)
YesBtn.Position = UDim2.new(0, 0, 0, 0)
YesBtn.BackgroundColor3 = Color3.fromRGB(35, 150, 90)
YesBtn.Text = i18n[currentLang].yesBtn
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.Font = Enum.Font.GothamBold
YesBtn.TextSize = 13
YesBtn.Parent = ButtonContainer

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 10)
YesCorner.Parent = YesBtn

local YesStroke = Instance.new("UIStroke")
YesStroke.Thickness = 2
YesStroke.Color = Color3.fromRGB(100, 245, 160)
YesStroke.Parent = YesBtn

-- Nút NO: CHƯA FOLLOW
local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0.35, -5, 1, 0)
NoBtn.Position = UDim2.new(0.65, 5, 0, 0)
NoBtn.BackgroundColor3 = Color3.fromRGB(140, 45, 55)
NoBtn.Text = i18n[currentLang].noBtn
NoBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
NoBtn.Font = Enum.Font.Gotham
NoBtn.TextSize = 12
NoBtn.Parent = ButtonContainer

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 10)
NoCorner.Parent = NoBtn

-- HÀM CẬP NHẬT NGÔN NGỮ KHI SWITCH
local function updateLanguage(lang)
    currentLang = lang
    noteLabel.Text = i18n[lang].question
    YesBtn.Text = i18n[lang].yesBtn
    NoBtn.Text = i18n[lang].noBtn
    
    if lang == "VI" then
        BtnVI.BackgroundColor3 = Color3.fromRGB(35, 150, 90)
        BtnVI.TextColor3 = Color3.fromRGB(255, 255, 255)
        BtnEN.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        BtnEN.TextColor3 = Color3.fromRGB(180, 180, 180)
    else
        BtnEN.BackgroundColor3 = Color3.fromRGB(35, 150, 90)
        BtnEN.TextColor3 = Color3.fromRGB(255, 255, 255)
        BtnVI.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        BtnVI.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end

BtnVI.MouseButton1Click:Connect(function() updateLanguage("VI") end)
BtnEN.MouseButton1Click:Connect(function() updateLanguage("EN") end)

-- Hiệu ứng xoay viền
task.spawn(function()
    local rot = 0
    while sg and sg.Parent do
        rot = (rot + 2) % 360
        StrokeGradient.Rotation = rot
        BorderGradient.Rotation = rot
        YesStroke.Thickness = 2 + math.sin(tick() * 5) * 1
        task.wait(0.01)
    end
end)

-- Hiệu ứng click nút
local function playClickEffect(btn, callback)
    local origSize = btn.Size
    local tweenDown = TweenService:Create(btn, TweenInfo.new(0.08), {Size = UDim2.new(origSize.X.Scale * 0.9, origSize.X.Offset, origSize.Y.Scale * 0.9, origSize.Y.Offset)})
    local tweenUp = TweenService:Create(btn, TweenInfo.new(0.12, Enum.EasingStyle.Back), {Size = origSize})
    
    tweenDown:Play()
    tweenDown.Completed:Connect(function()
        tweenUp:Play()
        tweenUp.Completed:Connect(function()
            if callback then callback() end
        end)
    end)
end

-- BẤM "ĐÃ FOLLOW"
YesBtn.MouseButton1Click:Connect(function()
    playClickEffect(YesBtn, function()
        ButtonContainer:Destroy()
        LangContainer:Destroy()
        noteLabel.Text = i18n[currentLang].thanks
        noteLabel.TextColor3 = Color3.fromRGB(140, 230, 170)
        
        local timerLabel = Instance.new("TextLabel")
        timerLabel.Size = UDim2.new(1, 0, 0.2, 0)
        timerLabel.Position = UDim2.new(0, 0, 0.65, 0)
        timerLabel.BackgroundTransparency = 1
        timerLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
        timerLabel.Font = Enum.Font.GothamMedium
        timerLabel.TextSize = 13
        timerLabel.Parent = MainFrame

        for i = 5, 1, -1 do
            timerLabel.Text = string.format(i18n[currentLang].timer, i)
            task.wait(1)
        end
        
        timerLabel.Text = i18n[currentLang].loading

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
        
        setFrozen(false)
        sg:Destroy()
        
        -- GIẢI MÃ VÀ KHỞI CHẠY SCRIPT GỐC
        local rawScriptUrl = _decodeUrl(_eUrl, _k)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(rawScriptUrl))()
        end)
        
        if not success then
            warn("Lỗi khi chạy script:", err)
        end
    end)
end)

-- BẤM "CHƯA FOLLOW"
NoBtn.MouseButton1Click:Connect(function()
    playClickEffect(NoBtn, function()
        ButtonContainer:Destroy()
        LangContainer:Destroy()
        noteLabel.Text = i18n[currentLang].fail
        noteLabel.TextColor3 = Color3.fromRGB(230, 90, 90)
        noteLabel.Size = UDim2.new(1, -20, 0.5, 0)
        
        task.wait(4)
        setFrozen(false)
        sg:Destroy()
    end)
end)
