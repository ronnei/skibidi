-- =========================================================================
--             ★ HỆ THỐNG GETKEY VXEZEHUB (TỰ ĐỘNG CHẠY SCRIPT GỐC) ★
-- =========================================================================

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local KeyUrl = "https://link4m.org/tO35K5"
local TutorialUrl = "https://cbrowse.github.io/browse/getkey.html"

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

    return "Vxeze-" .. hex1 .. "-" .. hex2
end

local TodayKey = GenerateKey(0)

-- Hàm khởi chạy Script chính Vxeze Hub
local function LaunchMainScript()
    task.spawn(function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://vxezestudio.online/api/scripts/script_G5CGjqj2X3rOS/stream/init"))()
        end)
        if not success then
            warn("[Vxeze Hub Error]:", result)
        end
    end)
end

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

-- Dọn dẹp UI cũ nếu có
if CoreGui:FindFirstChild("VxezeHub_GetKeyUI") then
    CoreGui.VxezeHub_GetKeyUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VxezeHub_GetKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Khung chính: #0B0813 (Tím đen tối)
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

-- Khung viền cầu vồng chạy màu mượt
local RainbowStroke = Instance.new("UIStroke")
RainbowStroke.Thickness = 1.8
RainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RainbowStroke.Parent = MainFrame

RunService.RenderStepped:Connect(function()
    local hue = (tick() * 0.2) % 1
    RainbowStroke.Color = Color3.fromHSV(hue, 0.75, 1)
end)

-- Tiêu đề
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -30, 0, 22)
TitleLabel.Position = UDim2.new(0, 15, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "★ HỆ THỐNG GETKEY VXEZEHUB ★"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 13.5
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

-- Ô nhập Key: #161224 (Tím xám trung tính)
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -30, 0, 34)
InputBox.Position = UDim2.new(0, 15, 0, 36)
InputBox.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
InputBox.TextColor3 = Color3.fromRGB(245, 245, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(120, 115, 140)
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
InputStroke.Color = Color3.fromRGB(45, 38, 70)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

-- Hàng 1: Nút GET KEY & KIỂM TRA KEY
local ButtonsRow = Instance.new("Frame")
ButtonsRow.Size = UDim2.new(1, -30, 0, 34)
ButtonsRow.Position = UDim2.new(0, 15, 0, 76)
ButtonsRow.BackgroundTransparency = 1
ButtonsRow.Parent = MainFrame

-- Nút GET KEY: #00F0FF (Xanh Cyan Neon - chữ đen)
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
GetKeyBtn.Text = "🔗 LẤY LINK KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = ButtonsRow

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
CheckKeyBtn.Position = UDim2.new(0.5, 5, 0, 0)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(38, 30, 62)
CheckKeyBtn.Text = "✔ KIỂM TRA KEY"
CheckKeyBtn.TextColor3 = Color3.fromRGB(245, 245, 255)
CheckKeyBtn.TextSize = 12
CheckKeyBtn.Font = Enum.Font.GothamBold
CheckKeyBtn.AutoButtonColor = false
CheckKeyBtn.Parent = ButtonsRow

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckKeyBtn

-- Hàng 2: Nút Hướng Dẫn Lấy Key
local TutorialBtn = Instance.new("TextButton")
TutorialBtn.Size = UDim2.new(1, -30, 0, 30)
TutorialBtn.Position = UDim2.new(0, 15, 0, 116)
TutorialBtn.BackgroundColor3 = Color3.fromRGB(14, 28, 48)
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
TutorialStroke.Color = Color3.fromRGB(2, 132, 199)
TutorialStroke.Thickness = 1
TutorialStroke.Parent = TutorialBtn

-- Banner trạng thái
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
NoteLabel.TextColor3 = Color3.fromRGB(246, 173, 85)
NoteLabel.TextSize = 10
NoteLabel.Font = Enum.Font.Gotham
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
    
    StatusBanner.BackgroundColor3 = Color3.fromRGB(14, 40, 65)
    StatusMsg.TextColor3 = Color3.fromRGB(56, 189, 248)
    StatusMsg.Text = "🎬 Đã sao chép link video hướng dẫn!"
    
    TutorialBtn.Text = "✔ ĐÃ SAO CHÉP LINK VIDEO"
    task.delay(2.5, function()
        if TutorialBtn and TutorialBtn.Parent then
            TutorialBtn.Text = "▶ Hướng Dẫn Lấy Key | Video Tutorial"
        end
    end)
end)

-- Bấm Kiểm Tra Key -> Tự động chạy luôn Script gốc
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
        StatusMsg.Text = "✔ Key hợp lệ! Đang khởi chạy Vxeze Hub..."
        CheckKeyBtn.Text = "✔ THÀNH CÔNG"
        CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 70)
        
        -- Kích hoạt script gốc trực tiếp
        LaunchMainScript()
        
        task.wait(0.4)
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 1.2, 0),
            BackgroundTransparency = 1
        }):Play()
        
        task.wait(0.25)
        ScreenGui:Destroy()
    else
        isChecking = false
        CheckKeyBtn.Text = "✔ KIỂM TRA KEY"
        StatusBanner.BackgroundColor3 = Color3.fromRGB(65, 15, 20)
        StatusMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
        StatusMsg.Text = "✖ Key không hợp lệ hoặc đã hết hạn! Vui lòng vượt link lấy Key mới."
        
        InputStroke.Color = Color3.fromRGB(255, 70, 70)
        task.wait(0.6)
        InputStroke.Color = Color3.fromRGB(45, 38, 70)
    end
end)
