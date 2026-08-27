-- =========================================================================
--   ★ HỆ THỐNG GETKEY OMG HUB & MENU BLOX TỔNG HỢP (CYBER NEON EDITION) ★
-- =========================================================================

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local KeyUrl = "https://link4m.org/TnmLxjP"
local TutorialUrl = "https://cbrowse.github.io/browse/getkey.html"
local TargetScriptUrl = "https://raw.githubusercontent.com/ronnei/skibidi/refs/heads/main/omghub-stealanegg.lua"

-- Thuật toán sinh Key mã hóa theo ngày (Đồng bộ 100% với Web JS)
local function GenerateKey(offsetDays)
    offsetDays = offsetDays or 0
    local vnTime = os.time() + (7 * 3600) + (offsetDays * 86400)
    local dateTable = os.date("!*t", vnTime)
    
    local day = dateTable.day
    local month = dateTable.month
    local year = dateTable.year

    local val1 = (day * 1337 + month * 919 + year * 31) % 65535
    local val2 = (day * 4099 + month * 7919 + year * 101) % 65535

    local hex1 = string.format("%04X", val1)
    local hex2 = string.format("%04X", val2)

    return "OMG-" .. hex1 .. "-" .. hex2
end

local TodayKey = GenerateKey(0)

-- Hàm sao chép an toàn
local function SetClipboardSafe(text)
    if setclipboard then
        setclipboard(text)
    elseif toclipboard then
        toclipboard(text)
    end
end

-- Hiệu ứng nảy nút bấm
local function PlayBounce(btn)
    local origSize = btn.Size
    local origPos = btn.Position
    local shrinkSize = UDim2.new(origSize.X.Scale, origSize.X.Offset - 4, origSize.Y.Scale, origSize.Y.Offset - 4)
    local shrinkPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 2, origPos.Y.Scale, origPos.Y.Offset + 2)
    
    local t1 = TweenService:Create(btn, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = shrinkSize, Position = shrinkPos})
    local t2 = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize, Position = origPos})
    
    t1:Play()
    t1.Completed:Connect(function() t2:Play() end)
end

-- =========================================================================
--             1. MENU CHÍNH SAU KHI NHẬP KEY (CYBER OCEAN BLUE)
-- =========================================================================
local function OpenMainHubMenu()
    if CoreGui:FindFirstChild("OMGHub_MainBloxUI") then
        CoreGui.OMGHub_MainBloxUI:Destroy()
    end

    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "OMGHub_MainBloxUI"
    MainGui.ResetOnSpawn = false
    pcall(function() MainGui.Parent = CoreGui end)
    if not MainGui.Parent then MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    -- Khung Menu Phong Cách Cyber Ocean Sky
    local HubFrame = Instance.new("Frame")
    HubFrame.Name = "HubFrame"
    HubFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    HubFrame.Size = UDim2.new(0, 420, 0, 290)
    HubFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    HubFrame.BackgroundColor3 = Color3.fromRGB(5, 14, 28)
    HubFrame.BorderSizePixel = 0
    HubFrame.Active = true
    HubFrame.Draggable = true
    HubFrame.ClipsDescendants = true
    HubFrame.Parent = MainGui

    local HubCorner = Instance.new("UICorner")
    HubCorner.CornerRadius = UDim.new(0, 16)
    HubCorner.Parent = HubFrame

    local HubStroke = Instance.new("UIStroke")
    HubStroke.Thickness = 2
    HubStroke.Color = Color3.fromRGB(0, 225, 255)
    HubStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    HubStroke.Parent = HubFrame

    -- Header Menu
    local HeaderBar = Instance.new("Frame")
    HeaderBar.Size = UDim2.new(1, 0, 0, 44)
    HeaderBar.BackgroundColor3 = Color3.fromRGB(10, 26, 48)
    HeaderBar.BorderSizePixel = 0
    HeaderBar.Parent = HubFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = HeaderBar

    local HubTitle = Instance.new("TextLabel")
    HubTitle.Size = UDim2.new(1, -60, 1, 0)
    HubTitle.Position = UDim2.new(0, 16, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "★ OMG HUB - MENU BLOX SCRIPT TỔNG HỢP ★"
    HubTitle.TextColor3 = Color3.fromRGB(0, 230, 255)
    HubTitle.TextSize = 12.5
    HubTitle.Font = Enum.Font.GothamBlack
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    HubTitle.Parent = HeaderBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -36, 0, 8)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 38, 65)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    CloseBtn.TextSize = 13
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = HeaderBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn
    CloseBtn.MouseButton1Click:Connect(function() MainGui:Destroy() end)

    -- Status Bar
    local StatusCard = Instance.new("Frame")
    StatusCard.Size = UDim2.new(1, -30, 0, 32)
    StatusCard.Position = UDim2.new(0, 15, 0, 54)
    StatusCard.BackgroundColor3 = Color3.fromRGB(8, 22, 40)
    StatusCard.Parent = HubFrame

    local StatusCardCorner = Instance.new("UICorner")
    StatusCardCorner.CornerRadius = UDim.new(0, 8)
    StatusCardCorner.Parent = StatusCard

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, -20, 1, 0)
    StatusText.Position = UDim2.new(0, 10, 0, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Trạng thái: Đã Xác Thực Key VIP (OMG Hub Official)"
    StatusText.TextColor3 = Color3.fromRGB(56, 189, 248)
    StatusText.TextSize = 10.5
    StatusText.Font = Enum.Font.GothamBold
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = StatusCard

    -- Card Kích Hoạt Script
    local ScriptCard = Instance.new("Frame")
    ScriptCard.Size = UDim2.new(1, -30, 0, 126)
    ScriptCard.Position = UDim2.new(0, 15, 0, 94)
    ScriptCard.BackgroundColor3 = Color3.fromRGB(8, 20, 36)
    ScriptCard.Parent = HubFrame

    local ScriptCardCorner = Instance.new("UICorner")
    ScriptCardCorner.CornerRadius = UDim.new(0, 10)
    ScriptCardCorner.Parent = ScriptCard

    local ScriptStroke = Instance.new("UIStroke")
    ScriptStroke.Color = Color3.fromRGB(0, 180, 255)
    ScriptStroke.Thickness = 1
    ScriptStroke.Parent = ScriptCard

    local ScriptName = Instance.new("TextLabel")
    ScriptName.Size = UDim2.new(1, -20, 0, 24)
    ScriptName.Position = UDim2.new(0, 10, 0, 6)
    ScriptName.BackgroundTransparency = 1
    ScriptName.Text = "⚡ OMG HUB - STEAL AN EGG SCRIPT"
    ScriptName.TextColor3 = Color3.fromRGB(0, 230, 255)
    ScriptName.TextSize = 11.5
    ScriptName.Font = Enum.Font.GothamBlack
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    ScriptName.Parent = ScriptCard

    local ScriptDesc = Instance.new("TextLabel")
    ScriptDesc.Size = UDim2.new(1, -20, 0, 32)
    ScriptDesc.Position = UDim2.new(0, 10, 0, 28)
    ScriptDesc.BackgroundTransparency = 1
    ScriptDesc.Text = "Bấm nút bên dưới để nạp và khởi chạy trực tiếp Script OMG Hub vào game."
    ScriptDesc.TextColor3 = Color3.fromRGB(150, 190, 225)
    ScriptDesc.TextSize = 9.5
    ScriptDesc.Font = Enum.Font.GothamMedium
    ScriptDesc.TextWrapped = true
    ScriptDesc.TextXAlignment = Enum.TextXAlignment.Left
    ScriptDesc.Parent = ScriptCard

    local ExecuteBtn = Instance.new("TextButton")
    ExecuteBtn.Size = UDim2.new(1, -20, 0, 38)
    ExecuteBtn.Position = UDim2.new(0, 10, 0, 74)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 215, 255)
    ExecuteBtn.Text = "▶ KHỞI CHẠY SCRIPT NGAY"
    ExecuteBtn.TextColor3 = Color3.fromRGB(5, 15, 30)
    ExecuteBtn.TextSize = 12
    ExecuteBtn.Font = Enum.Font.GothamBlack
    ExecuteBtn.AutoButtonColor = false
    ExecuteBtn.Parent = ScriptCard

    local ExecCorner = Instance.new("UICorner")
    ExecCorner.CornerRadius = UDim.new(0, 8)
    ExecCorner.Parent = ExecuteBtn

    local HubStatus = Instance.new("TextLabel")
    HubStatus.Size = UDim2.new(1, -30, 0, 40)
    HubStatus.Position = UDim2.new(0, 15, 0, 230)
    HubStatus.BackgroundTransparency = 1
    HubStatus.Text = "Hệ thống sẵn sàng • OMG Hub System"
    HubStatus.TextColor3 = Color3.fromRGB(100, 150, 190)
    HubStatus.TextSize = 10
    HubStatus.Font = Enum.Font.GothamBold
    HubStatus.Parent = HubFrame

    ExecuteBtn.MouseButton1Click:Connect(function()
        PlayBounce(ExecuteBtn)
        ExecuteBtn.Text = "⏳ Đang tải Script..."
        HubStatus.TextColor3 = Color3.fromRGB(0, 230, 255)
        HubStatus.Text = "Đang kết nối tới máy chủ Script..."
        
        task.spawn(function()
            local success, result = pcall(function()
                return loadstring(game:HttpGet(TargetScriptUrl))()
            end)
            if success then
                ExecuteBtn.Text = "✔ ĐÃ KÍCH HOẠT THÀNH CÔNG"
                ExecuteBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
                HubStatus.TextColor3 = Color3.fromRGB(74, 222, 128)
                HubStatus.Text = "✔ Script đã được inject thành công vào Roblox!"
            else
                ExecuteBtn.Text = "✖ LỖI KẾT NỐI SCRIPT"
                ExecuteBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
                HubStatus.TextColor3 = Color3.fromRGB(248, 113, 113)
                HubStatus.Text = "Không thể tải Script, vui lòng thử lại sau."
                warn("[OMG Hub Error]:", result)
            end
        end)
    end)
end

-- =========================================================================
--             2. GIAO DIỆN GETKEY OMG HUB (KHUNG CẦU VỒNG NEON)
-- =========================================================================
if CoreGui:FindFirstChild("OMGHub_GetKeyUI") then
    CoreGui.OMGHub_GetKeyUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OMGHub_GetKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Nền Menu chính: #0B0813 | rgb(11, 8, 19)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 390, 0, 365)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 8, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Khung viền cầu vồng nháy màu
local RainbowStroke = Instance.new("UIStroke")
RainbowStroke.Thickness = 2
RainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RainbowStroke.Parent = MainFrame

RunService.RenderStepped:Connect(function()
    local hue = (tick() * 0.2) % 1
    RainbowStroke.Color = Color3.fromHSV(hue, 0.75, 1)
end)

-- Tiêu đề
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -30, 0, 24)
TitleLabel.Position = UDim2.new(0, 15, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "★ HỆ THỐNG GETKEY OMG HUB ★"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 13.5
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.Parent = MainFrame

-- Ô nhập Key: #161224 | rgb(22, 18, 36)
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -30, 0, 34)
InputBox.Position = UDim2.new(0, 15, 0, 36)
InputBox.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
InputBox.TextColor3 = Color3.fromRGB(245, 245, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(130, 125, 150)
InputBox.PlaceholderText = "Nhập Key xác thực vào đây..."
InputBox.Text = ""
InputBox.TextSize = 12
InputBox.Font = Enum.Font.GothamMedium
InputBox.ClearTextOnFocus = false
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(50, 42, 80)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

-- Hàng nút 1: Nút GET KEY & KIỂM TRA KEY
local ButtonsRow = Instance.new("Frame")
ButtonsRow.Size = UDim2.new(1, -30, 0, 34)
ButtonsRow.Position = UDim2.new(0, 15, 0, 76)
ButtonsRow.BackgroundTransparency = 1
ButtonsRow.Parent = MainFrame

-- Nút GET KEY: #00F0FF | rgb(0, 240, 255) (Xanh Cyan Neon - chữ đen)
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
GetKeyBtn.Text = "🔗 LẤY LINK KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBlack
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = ButtonsRow

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
CheckKeyBtn.Position = UDim2.new(0.5, 5, 0, 0)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(42, 32, 70)
CheckKeyBtn.Text = "✔ KIỂM TRA KEY"
CheckKeyBtn.TextColor3 = Color3.fromRGB(245, 245, 255)
CheckKeyBtn.TextSize = 12
CheckKeyBtn.Font = Enum.Font.GothamBlack
CheckKeyBtn.AutoButtonColor = false
CheckKeyBtn.Parent = ButtonsRow

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckKeyBtn

-- Hàng nút 2: Nút Video Hướng Dẫn
local TutorialBtn = Instance.new("TextButton")
TutorialBtn.Size = UDim2.new(1, -30, 0, 30)
TutorialBtn.Position = UDim2.new(0, 15, 0, 116)
TutorialBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
TutorialBtn.Text = "▶ Hướng Dẫn Lấy Key | Video Tutorial"
TutorialBtn.TextColor3 = Color3.fromRGB(56, 189, 248)
TutorialBtn.TextSize = 11
TutorialBtn.Font = Enum.Font.GothamBold
TutorialBtn.AutoButtonColor = false
TutorialBtn.Parent = MainFrame

local TutorialCorner = Instance.new("UICorner")
TutorialCorner.CornerRadius = UDim.new(0, 8)
TutorialCorner.Parent = TutorialBtn

local TutorialStroke = Instance.new("UIStroke")
TutorialStroke.Color = Color3.fromRGB(0, 160, 230)
TutorialStroke.Thickness = 1
TutorialStroke.Parent = TutorialBtn

-- Banner trạng thái hiển thị thông báo
local StatusBanner = Instance.new("Frame")
StatusBanner.Size = UDim2.new(1, -30, 0, 26)
StatusBanner.Position = UDim2.new(0, 15, 0, 152)
StatusBanner.BackgroundColor3 = Color3.fromRGB(16, 12, 28)
StatusBanner.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 6)
StatusCorner.Parent = StatusBanner

local StatusMsg = Instance.new("TextLabel")
StatusMsg.Size = UDim2.new(1, -12, 1, 0)
StatusMsg.Position = UDim2.new(0, 6, 0, 0)
StatusMsg.BackgroundTransparency = 1
StatusMsg.Text = "⚡ Key mã hóa tự động thay đổi sau 00:00 hàng ngày"
StatusMsg.TextColor3 = Color3.fromRGB(180, 175, 205)
StatusMsg.TextSize = 10
StatusMsg.Font = Enum.Font.GothamMedium
StatusMsg.TextWrapped = true
StatusMsg.Parent = StatusBanner

-- Card Lưu ý (Chữ vàng đỏ nhẹ)
local NoteCard = Instance.new("Frame")
NoteCard.Size = UDim2.new(1, -30, 0, 168)
NoteCard.Position = UDim2.new(0, 15, 0, 184)
NoteCard.BackgroundColor3 = Color3.fromRGB(17, 13, 29)
NoteCard.Parent = MainFrame

local NoteCardCorner = Instance.new("UICorner")
NoteCardCorner.CornerRadius = UDim.new(0, 8)
NoteCardCorner.Parent = NoteCard

local NoteStroke = Instance.new("UIStroke")
NoteStroke.Color = Color3.fromRGB(60, 35, 45)
NoteStroke.Thickness = 1
NoteStroke.Parent = NoteCard

local NoteLabel = Instance.new("TextLabel")
NoteLabel.Size = UDim2.new(1, -16, 1, -10)
NoteLabel.Position = UDim2.new(0, 8, 0, 6)
NoteLabel.BackgroundTransparency = 1
NoteLabel.TextColor3 = Color3.fromRGB(246, 173, 85) -- Vàng cam / vàng đỏ nhẹ
NoteLabel.TextSize = 10
NoteLabel.Font = Enum.Font.GothamMedium
NoteLabel.TextWrapped = true
NoteLabel.TextYAlignment = Enum.TextYAlignment.Top
NoteLabel.TextXAlignment = Enum.TextXAlignment.Left
NoteLabel.Text = "📌 Lưu ý:\n• script no key đã hết hạn.nên ronnei xin phép mọi người thêm key vào nhó 🥰\n• Việc lấy Key Chỉ mất 1-2 phút mong bạn đừng tức giận và tiếp tục ủng hộ ronnei nhé! Chúc các bạn chơi game vui vẻ!"
NoteLabel.Parent = NoteCard

-- Bấm Lấy Link Key
GetKeyBtn.MouseButton1Click:Connect(function()
    PlayBounce(GetKeyBtn)
    SetClipboardSafe(KeyUrl)
    
    StatusBanner.BackgroundColor3 = Color3.fromRGB(0, 50, 60)
    StatusMsg.TextColor3 = Color3.fromRGB(0, 240, 255)
    StatusMsg.Text = "📋 dán lên trình duyệt để getkey"
    
    GetKeyBtn.Text = "✔ ĐÃ SAO CHÉP"
    task.delay(2.5, function()
        if GetKeyBtn and GetKeyBtn.Parent then
            GetKeyBtn.Text = "🔗 LẤY LINK KEY"
        end
    end)
end)

-- Bấm Hướng Dẫn Lấy Key
TutorialBtn.MouseButton1Click:Connect(function()
    PlayBounce(TutorialBtn)
    SetClipboardSafe(TutorialUrl)
    
    StatusBanner.BackgroundColor3 = Color3.fromRGB(10, 35, 60)
    StatusMsg.TextColor3 = Color3.fromRGB(56, 189, 248)
    StatusMsg.Text = "🎬 Đã sao chép link video hướng dẫn!"
    
    TutorialBtn.Text = "✔ ĐÃ SAO CHÉP LINK VIDEO"
    task.delay(2.5, function()
        if TutorialBtn and TutorialBtn.Parent then
            TutorialBtn.Text = "▶ Hướng Dẫn Lấy Key | Video Tutorial"
        end
    end)
end)

-- Bấm Kiểm Tra Key -> Mở Menu Script Blox
local isChecking = false
CheckKeyBtn.MouseButton1Click:Connect(function()
    if isChecking then return end
    isChecking = true
    PlayBounce(CheckKeyBtn)
    
    CheckKeyBtn.Text = "⏳ Đang duyệt..."
    StatusBanner.BackgroundColor3 = Color3.fromRGB(26, 20, 45)
    StatusMsg.TextColor3 = Color3.fromRGB(240, 240, 255)
    StatusMsg.Text = "Đang kiểm tra tính hợp lệ..."
    
    task.wait(0.35)
    local enteredKey = string.gsub(InputBox.Text, "%s+", "")
    
    if enteredKey == TodayKey then
        StatusBanner.BackgroundColor3 = Color3.fromRGB(15, 60, 30)
        StatusMsg.TextColor3 = Color3.fromRGB(80, 255, 140)
        StatusMsg.Text = "✔ Key hợp lệ! Đang mở Menu OMG Hub..."
        CheckKeyBtn.Text = "✔ THÀNH CÔNG"
        CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 70)
        
        task.wait(0.4)
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 1.2, 0),
            BackgroundTransparency = 1
        }):Play()
        
        task.wait(0.25)
        ScreenGui:Destroy()
        
        -- Mở Menu Script Blox
        OpenMainHubMenu()
    else
        isChecking = false
        CheckKeyBtn.Text = "✔ KIỂM TRA KEY"
        StatusBanner.BackgroundColor3 = Color3.fromRGB(65, 15, 20)
        StatusMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
        StatusMsg.Text = "✖ Key không hợp lệ hoặc đã hết hạn! Vui lòng vượt link lấy Key mới."
        
        InputStroke.Color = Color3.fromRGB(255, 70, 70)
        task.wait(0.6)
        InputStroke.Color = Color3.fromRGB(50, 42, 80)
    end
end)
