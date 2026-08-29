-- =========================================================================
--   ★ HỆ THỐNG GETKEY OMG HUB - THỜI HẠN 24H & THÔNG BÁO THỜI GIAN CÒN LẠI ★
-- =========================================================================

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local KeyUrl = "https://link4m.org/TnmLxjP"
local TutorialUrl = "https://cbrowse.github.io/browse/getkey.html"
local TargetScriptUrl = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"
local KeyFileName = "OMGHub_KeyData.json"

-- Từ điển 2 ngôn ngữ: Tiếng Việt & English
local Languages = {
    VI = {
        LangBtnText = "🇻🇳 VN ▾",
        SelectLangTitle = "CHỌN NGÔN NGỮ / SELECT LANGUAGE",
        Title = "★ HỆ THỐNG GETKEY OMG HUB ★",
        SubTitle = "Hệ thống xác thực bản quyền OMG Studio",
        Placeholder = "Nhập Key xác thực vào đây...",
        GetKey = "🔗 LẤY LINK KEY",
        CheckKey = "✔ KIỂM TRA KEY",
        Tutorial = "▶ Hướng Dẫn Lấy Key | Video Tutorial",
        StatusDaily = "⚡ Thời hạn Key: 24 tiếng tính từ lúc kích hoạt",
        CopiedLink = "📋 Đã sao chép link! Dán lên trình duyệt để getkey.",
        CopiedVideo = "🎬 Đã sao chép link video hướng dẫn!",
        BtnCopied = "✔ ĐÃ SAO CHÉP",
        Checking = "⏳ Đang duyệt...",
        CheckingMsg = "Đang kiểm tra tính hợp lệ của Key...",
        Success = "✔ Key hợp lệ! Đang khởi chạy OMG Hub...",
        SuccessBtn = "✔ THÀNH CÔNG",
        Error = "✖ Key không hợp lệ hoặc đã hết hạn! Vui lòng vượt link lấy Key mới.",
        Note = "📌 Lưu ý quan trọng:\n• Mỗi Key có giá trị sử dụng trọn vẹn 24 tiếng trên máy này 🥰\n• Lấy Key chỉ mất 1-2 phút qua link vượt. Chúc các bạn chơi game vui vẻ!"
    },
    EN = {
        LangBtnText = "🇺🇸 EN ▾",
        SelectLangTitle = "SELECT LANGUAGE / CHỌN NGÔN NGỮ",
        Title = "★ OMG HUB GETKEY SYSTEM ★",
        SubTitle = "Official OMG Studio Verification System",
        Placeholder = "Enter verification key here...",
        GetKey = "🔗 GET KEY LINK",
        CheckKey = "✔ CHECK KEY",
        Tutorial = "▶ How to Get Key | Video Tutorial",
        StatusDaily = "⚡ Key Validity: 24 hours from activation",
        CopiedLink = "📋 Copied! Paste link into browser to get key.",
        CopiedVideo = "🎬 Tutorial video link copied!",
        BtnCopied = "✔ COPIED",
        Checking = "⏳ Checking...",
        CheckingMsg = "Validating key, please wait...",
        Success = "✔ Valid Key! Launching OMG Hub...",
        SuccessBtn = "✔ SUCCESS",
        Error = "✖ Invalid or expired Key! Please bypass link for a new Key.",
        Note = "📌 Important Notice:\n• Each Key is valid for a full 24 hours on this device 🥰\n• Getting key takes only 1-2 minutes. Enjoy your game!"
    }
}

local CurrentLang = "VI"

-- Thuật toán sinh Key theo ngày (00:00 GMT+7)
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

-- Hàm khởi chạy Script chính
local function LaunchMainScript()
    task.spawn(function()
        local success, result = pcall(function()
            return loadstring(game:HttpGet(TargetScriptUrl))()
        end)
        if not success then
            warn("[OMG Hub Error]:", result)
        end
    end)
end

-- Hàm định dạng thời gian còn lại (giờ, phút, giây)
local function FormatRemainingTime(seconds)
    local hours = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    if hours > 0 then
        return string.format("%d giờ %d phút", hours, mins)
    elseif mins > 0 then
        return string.format("%d phút %d giây", mins, secs)
    else
        return string.format("%d giây", secs)
    end
end

-- Bảng thông báo nổi 5 giây hiển thị thời gian Key còn lại
local function ShowRemainingToast(secondsLeft)
    local ToastGui = Instance.new("ScreenGui")
    ToastGui.Name = "OMGHub_KeyRemainingToast"
    ToastGui.ResetOnSpawn = false
    pcall(function() ToastGui.Parent = CoreGui end)
    if not ToastGui.Parent then ToastGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local ToastFrame = Instance.new("Frame")
    ToastFrame.Size = UDim2.new(0, 360, 0, 72)
    ToastFrame.Position = UDim2.new(0.5, -180, 0, -100)
    ToastFrame.BackgroundColor3 = Color3.fromRGB(11, 8, 19)
    ToastFrame.BorderSizePixel = 0
    ToastFrame.Parent = ToastGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = ToastFrame

    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1.8
    Stroke.Color = Color3.fromRGB(0, 240, 255)
    Stroke.Parent = ToastFrame

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 42, 1, -8)
    Icon.Position = UDim2.new(0, 4, 0, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "⏳"
    Icon.TextSize = 22
    Icon.Parent = ToastFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -55, 0, 20)
    Title.Position = UDim2.new(0, 46, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "★ OMG HUB - KEY CÒN HIỆU LỰC ★"
    Title.TextColor3 = Color3.fromRGB(0, 240, 255)
    Title.TextSize = 11.5
    Title.Font = Enum.Font.GothamBlack
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ToastFrame

    local Msg = Instance.new("TextLabel")
    Msg.Size = UDim2.new(1, -55, 0, 20)
    Msg.Position = UDim2.new(0, 46, 0, 30)
    Msg.BackgroundTransparency = 1
    Msg.Text = "Thời gian còn lại: " .. FormatRemainingTime(secondsLeft)
    Msg.TextColor3 = Color3.fromRGB(74, 222, 128)
    Msg.TextSize = 11
    Msg.Font = Enum.Font.GothamBold
    Msg.TextXAlignment = Enum.TextXAlignment.Left
    Msg.Parent = ToastFrame

    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, -16, 0, 3)
    BarBg.Position = UDim2.new(0, 8, 1, -6)
    BarBg.BackgroundColor3 = Color3.fromRGB(24, 18, 38)
    BarBg.BorderSizePixel = 0
    BarBg.Parent = ToastFrame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, 0, 1, 0)
    Bar.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
    Bar.BorderSizePixel = 0
    Bar.Parent = BarBg

    TweenService:Create(ToastFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -180, 0, 25)
    }):Play()

    TweenService:Create(Bar, TweenInfo.new(5, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 1, 0)
    }):Play()

    task.delay(5, function()
        local t = TweenService:Create(ToastFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -180, 0, -100),
            BackgroundTransparency = 1
        })
        t:Play()
        t.Completed:Connect(function()
            ToastGui:Destroy()
        end)
    end)
end

-- Kiểm tra thời gian còn lại của Key 24h
local function GetKeyRemainingTime()
    if isfile and readfile and isfile(KeyFileName) then
        local success, content = pcall(readfile, KeyFileName)
        if success and content then
            local decodeSuccess, data = pcall(function()
                return HttpService:JSONDecode(content)
            end)
            if decodeSuccess and type(data) == "table" and data.ExpireTimestamp then
                local timeLeft = data.ExpireTimestamp - os.time()
                if timeLeft > 0 then
                    return timeLeft
                end
            end
        end
    end
    return nil
end

-- Lưu mốc 24 tiếng kể từ lúc nhập
local function Save24hKey()
    if writefile then
        local data = {
            ExpireTimestamp = os.time() + 86400
        }
        pcall(function()
            writefile(KeyFileName, HttpService:JSONEncode(data))
        end)
    end
end

-- Nếu còn hạn 24h: Hiện thông báo 5 giây & Chạy thẳng script game
local remainingTime = GetKeyRemainingTime()
if remainingTime and remainingTime > 0 then
    ShowRemainingToast(remainingTime)
    LaunchMainScript()
    return
end

local function SetClipboardSafe(text)
    if setclipboard then
        setclipboard(text)
    elseif toclipboard then
        toclipboard(text)
    end
end

local function PlayBounce(btn)
    local origSize = btn.Size
    local origPos = btn.Position
    local shrinkSize = UDim2.new(origSize.X.Scale, origSize.X.Offset - 4, origSize.Y.Scale, origSize.Y.Offset - 4)
    local shrinkPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 2, origPos.Y.Scale, origPos.Y.Offset + 2)
    
    local t1 = TweenService:Create(btn, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = shrinkSize, Position = shrinkPos})
    local t2 = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = origSize, Position = origPos})
    
    t1:Play()
    t1.Completed:Connect(function() t2:Play() end)
end

-- Dọn dẹp UI cũ nếu có
if CoreGui:FindFirstChild("OMGHub_GetKeyUI") then
    CoreGui.OMGHub_GetKeyUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OMGHub_GetKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Khung chính cố định (Draggable = false)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 410, 0, 410)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 8, 19)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainScale = Instance.new("UIScale")
MainScale.Scale = 0.5
MainScale.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local RainbowStroke = Instance.new("UIStroke")
RainbowStroke.Thickness = 2
RainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RainbowStroke.Parent = MainFrame

RunService.RenderStepped:Connect(function()
    local hue = (tick() * 0.2) % 1
    RainbowStroke.Color = Color3.fromHSV(hue, 0.75, 1)
end)
-- Header Bar
local HeaderBar = Instance.new("Frame")
HeaderBar.Size = UDim2.new(1, -30, 0, 36)
HeaderBar.Position = UDim2.new(0, 15, 0, 10)
HeaderBar.BackgroundTransparency = 1
HeaderBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -110, 0, 20)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = Languages[CurrentLang].Title
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 12.5
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = HeaderBar

local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(1, -110, 0, 14)
SubTitleLabel.Position = UDim2.new(0, 0, 0, 20)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = Languages[CurrentLang].SubTitle
SubTitleLabel.TextColor3 = Color3.fromRGB(140, 130, 165)
SubTitleLabel.TextSize = 9
SubTitleLabel.Font = Enum.Font.GothamMedium
SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubTitleLabel.Parent = HeaderBar

-- Nút mở Bảng Chọn Ngôn Ngữ
local OpenLangBtn = Instance.new("TextButton")
OpenLangBtn.Size = UDim2.new(0, 100, 0, 28)
OpenLangBtn.Position = UDim2.new(1, -100, 0, 3)
OpenLangBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 34)
OpenLangBtn.Text = Languages[CurrentLang].LangBtnText
OpenLangBtn.TextColor3 = Color3.fromRGB(0, 230, 255)
OpenLangBtn.TextSize = 11
OpenLangBtn.Font = Enum.Font.GothamBold
OpenLangBtn.AutoButtonColor = false
OpenLangBtn.Parent = HeaderBar

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 8)
LangCorner.Parent = OpenLangBtn

local LangStroke = Instance.new("UIStroke")
LangStroke.Color = Color3.fromRGB(0, 180, 255)
LangStroke.Thickness = 1
LangStroke.Parent = OpenLangBtn

-- Ô nhập Key: #161224
local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, -30, 0, 36)
InputBox.Position = UDim2.new(0, 15, 0, 56)
InputBox.BackgroundColor3 = Color3.fromRGB(22, 18, 36)
InputBox.TextColor3 = Color3.fromRGB(245, 245, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(130, 125, 150)
InputBox.PlaceholderText = Languages[CurrentLang].Placeholder
InputBox.Text = ""
InputBox.TextSize = 12
InputBox.Font = Enum.Font.GothamMedium
InputBox.ClearTextOnFocus = false
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 9)
InputCorner.Parent = InputBox

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(50, 42, 80)
InputStroke.Thickness = 1
InputStroke.Parent = InputBox

-- Hàng nút 1: Lấy Link Key & Kiểm Tra Key
local ButtonsRow = Instance.new("Frame")
ButtonsRow.Size = UDim2.new(1, -30, 0, 36)
ButtonsRow.Position = UDim2.new(0, 15, 0, 100)
ButtonsRow.BackgroundTransparency = 1
ButtonsRow.Parent = MainFrame

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 240, 255)
GetKeyBtn.Text = Languages[CurrentLang].GetKey
GetKeyBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBlack
GetKeyBtn.AutoButtonColor = false
GetKeyBtn.Parent = ButtonsRow

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 9)
GetKeyCorner.Parent = GetKeyBtn

local CheckKeyBtn = Instance.new("TextButton")
CheckKeyBtn.Size = UDim2.new(0.5, -5, 1, 0)
CheckKeyBtn.Position = UDim2.new(0.5, 5, 0, 0)
CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(42, 32, 70)
CheckKeyBtn.Text = Languages[CurrentLang].CheckKey
CheckKeyBtn.TextColor3 = Color3.fromRGB(245, 245, 255)
CheckKeyBtn.TextSize = 12
CheckKeyBtn.Font = Enum.Font.GothamBlack
CheckKeyBtn.AutoButtonColor = false
CheckKeyBtn.Parent = ButtonsRow

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 9)
CheckCorner.Parent = CheckKeyBtn

-- Hàng nút 2: Nút Video Hướng Dẫn
local TutorialBtn = Instance.new("TextButton")
TutorialBtn.Size = UDim2.new(1, -30, 0, 30)
TutorialBtn.Position = UDim2.new(0, 15, 0, 144)
TutorialBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
TutorialBtn.Text = Languages[CurrentLang].Tutorial
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

-- Banner trạng thái
local StatusBanner = Instance.new("Frame")
StatusBanner.Size = UDim2.new(1, -30, 0, 28)
StatusBanner.Position = UDim2.new(0, 15, 0, 182)
StatusBanner.BackgroundColor3 = Color3.fromRGB(16, 12, 28)
StatusBanner.Parent = MainFrame

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 7)
StatusCorner.Parent = StatusBanner

local StatusMsg = Instance.new("TextLabel")
StatusMsg.Size = UDim2.new(1, -12, 1, 0)
StatusMsg.Position = UDim2.new(0, 6, 0, 0)
StatusMsg.BackgroundTransparency = 1
StatusMsg.Text = Languages[CurrentLang].StatusDaily
StatusMsg.TextColor3 = Color3.fromRGB(180, 175, 205)
StatusMsg.TextSize = 10
StatusMsg.Font = Enum.Font.GothamMedium
StatusMsg.TextWrapped = true
StatusMsg.Parent = StatusBanner

-- Card Lưu ý
local NoteCard = Instance.new("Frame")
NoteCard.Size = UDim2.new(1, -30, 0, 182)
NoteCard.Position = UDim2.new(0, 15, 0, 218)
NoteCard.BackgroundColor3 = Color3.fromRGB(17, 13, 29)
NoteCard.Parent = MainFrame

local NoteCardCorner = Instance.new("UICorner")
NoteCardCorner.CornerRadius = UDim.new(0, 10)
NoteCardCorner.Parent = NoteCard

local NoteStroke = Instance.new("UIStroke")
NoteStroke.Color = Color3.fromRGB(65, 38, 48)
NoteStroke.Thickness = 1
NoteStroke.Parent = NoteCard

local NoteLabel = Instance.new("TextLabel")
NoteLabel.Size = UDim2.new(1, -18, 1, -12)
NoteLabel.Position = UDim2.new(0, 9, 0, 6)
NoteLabel.BackgroundTransparency = 1
NoteLabel.TextColor3 = Color3.fromRGB(246, 173, 85)
NoteLabel.TextSize = 10
NoteLabel.Font = Enum.Font.GothamMedium
NoteLabel.TextWrapped = true
NoteLabel.TextYAlignment = Enum.TextYAlignment.Top
NoteLabel.TextXAlignment = Enum.TextXAlignment.Left
NoteLabel.Text = Languages[CurrentLang].Note
NoteLabel.Parent = NoteCard
-- Modal Popup Chọn Ngôn Ngữ
local LangModal = Instance.new("Frame")
LangModal.Name = "LangModal"
LangModal.Size = UDim2.new(1, 0, 1, 0)
LangModal.Position = UDim2.new(0, 0, 1, 0)
LangModal.BackgroundColor3 = Color3.fromRGB(7, 5, 12)
LangModal.BackgroundTransparency = 0.05
LangModal.ZIndex = 20
LangModal.Parent = MainFrame

local ModalCorner = Instance.new("UICorner")
ModalCorner.CornerRadius = UDim.new(0, 16)
ModalCorner.Parent = LangModal

local ModalTitle = Instance.new("TextLabel")
ModalTitle.Size = UDim2.new(1, -60, 0, 30)
ModalTitle.Position = UDim2.new(0, 20, 0, 18)
ModalTitle.BackgroundTransparency = 1
ModalTitle.Text = Languages[CurrentLang].SelectLangTitle
ModalTitle.TextColor3 = Color3.fromRGB(0, 240, 255)
ModalTitle.TextSize = 12
ModalTitle.Font = Enum.Font.GothamBlack
ModalTitle.TextXAlignment = Enum.TextXAlignment.Left
ModalTitle.ZIndex = 21
ModalTitle.Parent = LangModal

local CloseModalBtn = Instance.new("TextButton")
CloseModalBtn.Size = UDim2.new(0, 28, 0, 28)
CloseModalBtn.Position = UDim2.new(1, -40, 0, 18)
CloseModalBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
CloseModalBtn.Text = "✕"
CloseModalBtn.TextColor3 = Color3.fromRGB(240, 80, 80)
CloseModalBtn.TextSize = 13
CloseModalBtn.Font = Enum.Font.GothamBold
CloseModalBtn.ZIndex = 21
CloseModalBtn.Parent = LangModal

local CloseModalCorner = Instance.new("UICorner")
CloseModalCorner.CornerRadius = UDim.new(0, 6)
CloseModalCorner.Parent = CloseModalBtn

local LangList = Instance.new("Frame")
LangList.Size = UDim2.new(1, -40, 0, 150)
LangList.Position = UDim2.new(0, 20, 0, 60)
LangList.BackgroundTransparency = 1
LangList.ZIndex = 21
LangList.Parent = LangModal

-- Nút Tiếng Việt
local OptViBtn = Instance.new("TextButton")
OptViBtn.Size = UDim2.new(1, 0, 0, 56)
OptViBtn.Position = UDim2.new(0, 0, 0, 0)
OptViBtn.BackgroundColor3 = Color3.fromRGB(20, 16, 36)
OptViBtn.Text = "🇻🇳  Tiếng Việt (Vietnamese)  ✓"
OptViBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
OptViBtn.TextSize = 13
OptViBtn.Font = Enum.Font.GothamBlack
OptViBtn.ZIndex = 22
OptViBtn.AutoButtonColor = false
OptViBtn.Parent = LangList

local OptViCorner = Instance.new("UICorner")
OptViCorner.CornerRadius = UDim.new(0, 10)
OptViCorner.Parent = OptViBtn

local OptViStroke = Instance.new("UIStroke")
OptViStroke.Color = Color3.fromRGB(0, 180, 255)
OptViStroke.Thickness = 1.5
OptViStroke.Parent = OptViBtn

-- Nút English
local OptEnBtn = Instance.new("TextButton")
OptEnBtn.Size = UDim2.new(1, 0, 0, 56)
OptEnBtn.Position = UDim2.new(0, 0, 0, 68)
OptEnBtn.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
OptEnBtn.Text = "🇺🇸  English (Global)"
OptEnBtn.TextColor3 = Color3.fromRGB(180, 175, 200)
OptEnBtn.TextSize = 13
OptEnBtn.Font = Enum.Font.GothamMedium
OptEnBtn.ZIndex = 22
OptEnBtn.AutoButtonColor = false
OptEnBtn.Parent = LangList

local OptEnCorner = Instance.new("UICorner")
OptEnCorner.CornerRadius = UDim.new(0, 10)
OptEnCorner.Parent = OptEnBtn

local OptEnStroke = Instance.new("UIStroke")
OptEnStroke.Color = Color3.fromRGB(45, 38, 65)
OptEnStroke.Thickness = 1
OptEnStroke.Parent = OptEnBtn

-- Hàm cập nhật ngôn ngữ
local function SetLanguage(code)
    CurrentLang = code
    local data = Languages[code]
    
    OpenLangBtn.Text = data.LangBtnText
    TitleLabel.Text = data.Title
    SubTitleLabel.Text = data.SubTitle
    InputBox.PlaceholderText = data.Placeholder
    GetKeyBtn.Text = data.GetKey
    CheckKeyBtn.Text = data.CheckKey
    TutorialBtn.Text = data.Tutorial
    StatusMsg.Text = data.StatusDaily
    NoteLabel.Text = data.Note
    ModalTitle.Text = data.SelectLangTitle

    if code == "VI" then
        OptViBtn.Text = "🇻🇳  Tiếng Việt (Vietnamese)  ✓"
        OptViBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
        OptViBtn.Font = Enum.Font.GothamBlack
        OptViStroke.Color = Color3.fromRGB(0, 180, 255)
        OptViBtn.BackgroundColor3 = Color3.fromRGB(20, 16, 36)

        OptEnBtn.Text = "🇺🇸  English (Global)"
        OptEnBtn.TextColor3 = Color3.fromRGB(180, 175, 200)
        OptEnBtn.Font = Enum.Font.GothamMedium
        OptEnStroke.Color = Color3.fromRGB(45, 38, 65)
        OptEnBtn.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
    else
        OptEnBtn.Text = "🇺🇸  English (Global)  ✓"
        OptEnBtn.TextColor3 = Color3.fromRGB(0, 240, 255)
        OptEnBtn.Font = Enum.Font.GothamBlack
        OptEnStroke.Color = Color3.fromRGB(0, 180, 255)
        OptEnBtn.BackgroundColor3 = Color3.fromRGB(20, 16, 36)

        OptViBtn.Text = "🇻🇳  Tiếng Việt (Vietnamese)"
        OptViBtn.TextColor3 = Color3.fromRGB(180, 175, 200)
        OptViBtn.Font = Enum.Font.GothamMedium
        OptViStroke.Color = Color3.fromRGB(45, 38, 65)
        OptViBtn.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
    end
end

local function OpenLanguageModal()
    TweenService:Create(LangModal, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end

local function CloseLanguageModal()
    TweenService:Create(LangModal, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(0, 0, 1, 0)
    }):Play()
end

OpenLangBtn.MouseButton1Click:Connect(function()
    PlayBounce(OpenLangBtn)
    OpenLanguageModal()
end)

CloseModalBtn.MouseButton1Click:Connect(function()
    PlayBounce(CloseModalBtn)
    CloseLanguageModal()
end)

OptViBtn.MouseButton1Click:Connect(function()
    PlayBounce(OptViBtn)
    SetLanguage("VI")
    task.wait(0.15)
    CloseLanguageModal()
end)

OptEnBtn.MouseButton1Click:Connect(function()
    PlayBounce(OptEnBtn)
    SetLanguage("EN")
    task.wait(0.15)
    CloseLanguageModal()
end)

-- Hiệu ứng Intro khởi động
local function PlayStartupIntro()
    MainFrame.BackgroundTransparency = 1
    MainScale.Scale = 0.4
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play()
    
    TweenService:Create(MainScale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play()
end

PlayStartupIntro()

-- Bấm Lấy Link Key
GetKeyBtn.MouseButton1Click:Connect(function()
    PlayBounce(GetKeyBtn)
    SetClipboardSafe(KeyUrl)
    
    StatusBanner.BackgroundColor3 = Color3.fromRGB(0, 50, 60)
    StatusMsg.TextColor3 = Color3.fromRGB(0, 240, 255)
    StatusMsg.Text = Languages[CurrentLang].CopiedLink
    
    GetKeyBtn.Text = Languages[CurrentLang].BtnCopied
    task.delay(2.5, function()
        if GetKeyBtn and GetKeyBtn.Parent then
            GetKeyBtn.Text = Languages[CurrentLang].GetKey
        end
    end)
end)

-- Bấm Video Hướng Dẫn
TutorialBtn.MouseButton1Click:Connect(function()
    PlayBounce(TutorialBtn)
    SetClipboardSafe(TutorialUrl)
    
    StatusBanner.BackgroundColor3 = Color3.fromRGB(10, 35, 60)
    StatusMsg.TextColor3 = Color3.fromRGB(56, 189, 248)
    StatusMsg.Text = Languages[CurrentLang].CopiedVideo
    
    TutorialBtn.Text = Languages[CurrentLang].BtnCopied
    task.delay(2.5, function()
        if TutorialBtn and TutorialBtn.Parent then
            TutorialBtn.Text = Languages[CurrentLang].Tutorial
        end
    end)
end)

-- Bấm Kiểm Tra Key
local isChecking = false
CheckKeyBtn.MouseButton1Click:Connect(function()
    if isChecking then return end
    isChecking = true
    PlayBounce(CheckKeyBtn)
    
    CheckKeyBtn.Text = Languages[CurrentLang].Checking
    StatusBanner.BackgroundColor3 = Color3.fromRGB(26, 20, 45)
    StatusMsg.TextColor3 = Color3.fromRGB(240, 240, 255)
    StatusMsg.Text = Languages[CurrentLang].CheckingMsg
    
    task.wait(0.35)
    local enteredKey = string.gsub(InputBox.Text, "%s+", "")
    
    if enteredKey == TodayKey then
        -- Lưu mốc thời hạn 24h vào file máy
        Save24hKey()
        
        StatusBanner.BackgroundColor3 = Color3.fromRGB(15, 60, 30)
        StatusMsg.TextColor3 = Color3.fromRGB(80, 255, 140)
        StatusMsg.Text = Languages[CurrentLang].Success
        CheckKeyBtn.Text = Languages[CurrentLang].SuccessBtn
        CheckKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 70)
        
        -- Kích hoạt trực tiếp script gốc
        LaunchMainScript()
        
        task.wait(0.4)
        TweenService:Create(MainScale, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = 0.5
        }):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 1.2, 0)
        }):Play()
        
        task.wait(0.25)
        ScreenGui:Destroy()
    else
        isChecking = false
        CheckKeyBtn.Text = Languages[CurrentLang].CheckKey
        StatusBanner.BackgroundColor3 = Color3.fromRGB(65, 15, 20)
        StatusMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
        StatusMsg.Text = Languages[CurrentLang].Error
        
        InputStroke.Color = Color3.fromRGB(255, 70, 70)
        task.wait(0.6)
        InputStroke.Color = Color3.fromRGB(50, 42, 80)
    end
end)
