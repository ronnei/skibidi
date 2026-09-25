-- [[ RONNEI HUB - BRIGHT STARRY NIGHT SHADERS & DIRECT LAUNCH ]] --

-- 1. CHẠY SCRIPT CHÍNH (ĐƯỜNG DẪN GỐC NGUYÊN BẢN, KHÔNG MÃ HÓA)
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/robvxs24/freemium/refs/heads/main/lennonviethoa.lua"))()
    end)
end)

-- 2. TẠO ĐỒ HỌA ĐÊM TRĂNG SAO NHƯNG MẶT ĐẤT SÁNG RÕ
task.spawn(function()
    pcall(function()
        local Lighting = game:GetService("Lighting")

        -- Giữ bầu trời đêm nhưng tăng mạnh độ sáng môi trường
        Lighting.ClockTime = 0
        Lighting.GeographicLatitude = 35
        Lighting.GlobalShadows = true -- Đổ bóng ánh trăng nhẹ dưới đất
        Lighting.Brightness = 2.2 -- Tăng độ sáng không gian
        Lighting.OutdoorAmbient = Color3.fromRGB(175, 190, 220) -- Ánh sáng ngoài trời sáng dịu, rõ nét
        Lighting.Ambient = Color3.fromRGB(135, 145, 165) -- Ánh sáng tổng thể sáng rõ
        Lighting.FogEnd = 9e9

        -- Dọn dẹp Sky & Effect cũ
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") then
                v:Destroy()
            end
        end

        -- Bầu trời đêm có Sao lấp lánh & Trăng tròn
        local Sky = Instance.new("Sky")
        Sky.Name = "RonneiBrightNightSky"
        Sky.StarCount = 5000 -- Bầu trời đầy sao lấp lánh
        Sky.MoonAngularSize = 24 -- Trăng tròn to sáng
        Sky.MoonTextureId = "rbxassetid://644432059"
        Sky.SunTextureId = ""
        Sky.SkyboxBk = "rbxassetid://644488313"
        Sky.SkyboxDn = "rbxassetid://644488313"
        Sky.SkyboxFt = "rbxassetid://644488313"
        Sky.SkyboxLf = "rbxassetid://644488313"
        Sky.SkyboxRt = "rbxassetid://644488313"
        Sky.SkyboxUp = "rbxassetid://644488313"
        Sky.Parent = Lighting

        -- Bộ lọc màu giữ cảnh quan rực rỡ, không bị mờ tối
        local CC = Instance.new("ColorCorrectionEffect")
        CC.Name = "RonneiNightCC"
        CC.Brightness = 0.03
        CC.Contrast = 0.08
        CC.Saturation = 0.25
        CC.Parent = Lighting

        -- Tỏa sáng dịu nhẹ cho sao và ánh trăng
        local Bloom = Instance.new("BloomEffect")
        Bloom.Name = "RonneiNightBloom"
        Bloom.Intensity = 0.3
        Bloom.Size = 20
        Bloom.Threshold = 0.8
        Bloom.Parent = Lighting

        -- Tắt hiệu ứng hạt thừa để giữ mượt FPS khi chơi
        local function CleanParticles(obj)
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end

        for _, obj in ipairs(workspace:GetDescendants()) do CleanParticles(obj) end
        workspace.DescendantAdded:Connect(CleanParticles)
    end)
end)
