do
    local function runBadbois()
        local body
        if type(readfile) == "function" and type(isfile) == "function" then
            for _, path in ipairs({ "badbois.txt", "paygorn/badbois.txt", "Badbois.txt" }) do
                if isfile(path) then
                    body = readfile(path)
                    break
                end
            end
        end
        if not body then
            body = [=[
do
	local ok, err = pcall(function()
		if type(getgc) ~= "function" or type(hookfunction) ~= "function" then return end
		local x, y
		if getthreadidentity then pcall(getthreadidentity, 2) end
		for _, v in pairs(getgc(true)) do
			if typeof(v) == "table" then
				local a, b = rawget(v, "Detected"), rawget(v, "Kill")
				if typeof(a) == "function" and not x then
					x = a
					hookfunction(x, function() return true end)
				end
				if typeof(b) == "function" and rawget(v, "Variables") and not y then
					y = b
					hookfunction(y, function() end)
				end
			end
		end
		local renv = getrenv and getrenv()
		if renv and renv.debug and renv.debug.info and x then
			local o
			o = hookfunction(renv.debug.info, newcclosure(function(a, ...)
				if a == x then return coroutine.yield(coroutine.running()) end
				return o(a, ...)
			end))
		end
		if getthreadidentity then pcall(getthreadidentity, 7) end
	end)
	if ok then
		print("[Ling Ling v6] AC bypass applied")
	else
		warn("[Ling Ling v6] AC bypass failed:", err)
	end
end
]=]
        end
        local fn, err = loadstring(body, "badbois")
        if fn then
            fn()
        else
            warn("[GetBetter Premium] badbois load failed:", err)
        end
    end
    runBadbois()
end

function oneoverone()
    local httpRequest = (syn and syn.request) or (http and http.request) or request
    if not isfile('invitegetbetter.dat') and httpRequest then
        writefile('invitegetbetter.dat', '')
        local payload = {
            cmd = 'INVITE_BROWSER',
            args = { code = 'eMpUQzFrNG' },
            nonce = game:GetService('HttpService'):GenerateGUID(false)
        }
        local requestData = {
            Url = 'http://127.0.0.1:6463/rpc?v=1',
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json',
                Origin = 'https://discord.com'
            },
            Body = game:GetService('HttpService'):JSONEncode(payload)
        }
        pcall(function() httpRequest(requestData) end)
    end
end

task.spawn(oneoverone)

repeat task["wait"]() until game:IsLoaded()

if (identifyexecutor() == "AWP" or identifyexecutor() == "Nihon") then
    cleardrawcache()
end

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = Workspace.CurrentCamera

repeat task.wait() until Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

local _56 = Players.LocalPlayer
if not _56 then
    repeat wait() until Players.LocalPlayer
    _56 = Players.LocalPlayer
end

Workspace.FallenPartsDestroyHeight = -0 / 0

local repo = 'https://raw.githubusercontent.com/imcomingforyou6959-gif/UR4/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Spotify = loadstring(game:HttpGet(repo .. 'addons/Spotify.lua'))()

Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true
Library.NotifySide = 'Right'

local Window = Library:CreateWindow({
    Title = 'GetBetter.cc | Premium',
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    UnlockMouseWhileOpen = true,
    NotifySide = 'Right',
    TabPadding = 2,
    MenuFadeTime = 0.2,
})

local Boxes = {
    Combat = Window:AddTab('Main'),
    Visuals = Window:AddTab('Visuals'),
    World = Window:AddTab('World'),
    UISettings = Window:AddTab('UI Settings'),
}

Library.Directory = "spotifyforRawr"
Spotify:SetLibrary(Library)
Spotify:SetFolder('spotifyforrawr/Spotify')
Spotify:BuildSpotifySection(Boxes.UISettings)

local _main = Boxes.Combat:AddLeftGroupbox('Main')
local _visual = Boxes.Visuals:AddLeftGroupbox('Visuals')

local CamlockToggle = _main:AddToggle('Camlock', {
    Text = 'Camlock',
    Default = false,
})

_visual:AddLabel('Player ESP')
local _ESPEnabled = _visual:AddToggle('ESPEnabled', {
    Text = 'ESP Enabled',
    Default = true,
})
_visual:AddToggle('ESPShowNames', {
    Text = 'Player Names',
    Default = true,
})
_visual:AddToggle('ESPShowDistance', {
    Text = 'Distance',
    Default = false,
})
_visual:AddToggle('ESPShowHealth', {
    Text = 'Health',
    Default = false,
})
_visual:AddToggle('ESPShowTool', {
    Text = 'Held Tool',
    Default = false,
})
_visual:AddToggle('ESPTracers', {
    Text = 'Tracers',
    Default = false,
})
_visual:AddToggle('ESPHeadDot', {
    Text = 'Head Dot',
    Default = false,
})
local _HeadDotToggle = _visual:AddToggle('ESPChinaHat', {
    Text = 'China Hat',
    Default = false,
})
_HeadDotToggle:AddColorPicker('ESPChinaHatColor1', {
    Default = Color3.fromRGB(255, 0, 120),
    Title = 'Hat Color A',
})
_HeadDotToggle:AddColorPicker('ESPChinaHatColor2', {
    Default = Color3.fromRGB(0, 170, 255),
    Title = 'Hat Color B',
})

_G.box_esp_connection = nil
_G.box_esp_boxes = {}
_G.box_esp_color = Color3.fromRGB(255, 255, 255)
_G.box_esp_thickness = 2
_G.box_esp_filled = false
_G.box_esp_fill_color = Color3.fromRGB(255, 255, 255)
_G.box_esp_fill_transparency = 0.5
_G.box_esp_bar_types = {}

BoxESPToggle = _visual:AddToggle('BoxESPEnabled', {
    Text = 'Box ESP',
    Default = false,
})

BoxESPColor = BoxESPToggle:AddColorPicker('BoxESPColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Box Color',
})

BoxESPFilledToggle = _visual:AddToggle('BoxESPFilled', {
    Text = 'Filled Box',
    Default = false,
})

BoxESPFillColor = BoxESPFilledToggle:AddColorPicker('BoxESPFillColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Fill Color',
})

_visual:AddDropdown('BoxESPBarType', {
    Values = {"Health", "Armor"},
    Default = {"Health"},
    Multi = true,
    Text = 'Bar Type',
})

local _SkeletonToggle = _visual:AddToggle('ESPShowSkeleton', {
    Text = 'Skeleton',
    Default = false,
})
local _SkeletonColor = _SkeletonToggle:AddColorPicker('SkeletonColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Skeleton Color',
    Transparency = 0
})

CamlockToggle:AddKeyPicker('CamlockKey', {
    Default = 'C',
    Text = 'Camlock',
    Mode = 'Toggle',
    SyncToggleState = false,
})

_main:AddToggle('UnlockOnKO', {
    Text = 'Unlock on K.O',
    Default = false,
})

_main:AddSlider('CamlockSmoothness', {
    Text = 'Smoothness',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
})

_main:AddDropdown('CamlockHitPart', {
    Text = 'AimPart',
    Values = {'Head', 'UpperTorso', 'HumanoidRootPart'},
    Default = 'Head',
    Multi = false,
})

_main:AddDropdown('CamlockMode', {
    Text = 'Target Mode',
    Values = {'Sticky', 'Auto Select'},
    Default = 'Sticky',
    Multi = false,
})

local _79 = Boxes.Combat:AddLeftTabbox()
local _80 = _79:AddTab('Target')

local _HighlightToggle = _80:AddToggle('TargetHighlight', {
    Text = 'Character Highlight',
    Default = false,
})

_HighlightToggle:AddColorPicker('TargetHighlightFill', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Fill Color',
    Transparency = 0.5,
})

_HighlightToggle:AddColorPicker('TargetHighlightOutline', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Outline Color',
    Transparency = 0,
})

local _LineToggle = _80:AddToggle('TargetLine', {
    Text = 'Target Line',
    Default = false,
})

_LineToggle:AddColorPicker('TargetLineColor', {
    Default = Color3.fromRGB(255, 255, 255),
    Title = 'Line Color',
    Transparency = 0,
})

local _InfoToggle = _80:AddToggle('TargetInfo', {
    Text = 'Target Info Panel',
    Default = false,
})

local _75 = Boxes.Combat:AddLeftTabbox()
local _76 = _75:AddTab('Checks')

_76:AddToggle('KnockCheck', {
    Text = 'Skip Knocked Players',
    Default = true,
})

_76:AddToggle('ProtectedCheck', {
    Text = 'Skip Protected Players',
    Default = true,
})

_76:AddToggle('WallCheck', {
    Text = 'Skip Players Behind Walls',
    Default = true,
})

_76:AddToggle('SilentTeamCheck', {
    Text = 'Team Check (Silent)',
    Default = false,
})

_76:AddToggle('SilentFriendCheck', {
    Text = 'Friend Check (Silent)',
    Default = false,
})

local _silentBox = Boxes.Combat:AddRightGroupbox('Silent Aim')
local SilentToggle = _silentBox:AddToggle('SilentAim', {
    Text = 'Silent Aim',
    Default = false,
})
SilentToggle:AddKeyPicker('SilentAimKey', {
    Default = 'V',
    Text = 'Silent Aim',
    Mode = 'Toggle',
    SyncToggleState = true,
})
_silentBox:AddDropdown('SilentHitPart', {
    Text = 'Aim Part',
    Values = {'Head', 'Body', 'Closest Part'},
    Default = 'Head',
})
_silentBox:AddDropdown('SilentMode', {
    Text = 'Target Mode',
    Values = {'Sticky'},
    Default = 'Sticky',
})
_silentBox:AddSlider('SilentHitchance', {
    Text = 'Hit Chance',
    Default = 100,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
})
_silentBox:AddSlider('SilentFOV', {
    Text = 'FOV Radius',
    Default = 100,
    Min = 40,
    Max = 500,
    Rounding = 0,
})
_silentBox:AddSlider('SilentMaxDistance', {
    Text = 'Max Distance',
    Default = 0,
    Min = 0,
    Max = 2500,
    Rounding = 50,
    Suffix = 'm',
})
local _77 = Boxes.Combat:AddRightTabbox()
local _78 = _77:AddTab('Misc')

local _WSToggle = _78:AddToggle('WalkSpeedEnabled', {
    Text = 'Walk Speed',
    Default = false,
})

_WSToggle:AddKeyPicker('WalkSpeedKeybind', {
    Default = 'Z',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Bind',
    NoUI = false
})

_78:AddSlider('WalkSpeed', {
    Text = 'Speed',
    Default = 16,
    Min = 16,
    Max = 1000,
    Rounding = 0,
    Suffix = '',
})

local _NoclipToggle = _78:AddToggle('Noclip', {
    Text = 'NoClip',
    Default = false,
})

local _JPToggle = _78:AddToggle('JumpPowerEnabled', {
    Text = 'Jump Power',
    Default = false,
})

_JPToggle:AddKeyPicker('JumpPowerKeybind', {
    Default = 'X',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Bind',
    NoUI = false
})

_78:AddSlider('JumpPower', {
    Text = 'Power',
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Suffix = '',
})

local _CFWSToggle = _78:AddToggle('CFrameWalkSpeed', {
    Text = 'CFrame Walk Speed',
    Default = false,
})
_CFWSToggle:AddKeyPicker('CFrameWalkSpeedKey', {
    Default = 'B',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Bind',
})
_78:AddSlider('CFrameWalkSpeedValue', {
    Text = 'CFrame Speed',
    Default = 24,
    Min = 16,
    Max = 500,
    Rounding = 0,
})

local _CFFlyToggle = _78:AddToggle('CFrameFly', {
    Text = 'CFrame Fly',
    Default = false,
})
_CFFlyToggle:AddKeyPicker('CFrameFlyKey', {
    Default = 'T',
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Fly Bind',
})
_78:AddSlider('CFrameFlySpeed', {
    Text = 'Fly Speed',
    Default = 80,
    Min = 10,
    Max = 500,
    Rounding = 0,
})

local _96 = Boxes.UISettings:AddLeftGroupbox('Menu')

_96:AddButton('Rejoin', function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

_96:AddButton('Server Hop', function()
    local TeleportService = game:GetService("TeleportService")
    local PlaceId = game.PlaceId
    local CurrentJobId = game.JobId
    local success, response = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?limit=100")
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        local availableServers = {}
        if data and data.data then
            for _, server in ipairs(data.data) do
                if server.id ~= CurrentJobId and server.playing and server.playing < server.maxPlayers then
                    table.insert(availableServers, server.id)
                end
            end
        end
        if #availableServers > 0 then
            local targetJobId = availableServers[math.random(#availableServers)]
            TeleportService:TeleportToPlaceInstance(PlaceId, targetJobId, LocalPlayer)
            return
        end
    end
    TeleportService:Teleport(PlaceId, LocalPlayer)
end)

_96:AddLabel('Menu Bind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu Toggle',
})

local _WatermarkToggle = _96:AddToggle('Watermark', {
    Text = 'Watermark',
    Default = true,
})

local WatermarkConnection = nil

local function GetPing()
    local ok, ping = pcall(function()
        local item = game:GetService('Stats').Network.ServerStatsItem:FindFirstChild('Data Ping')
        if item then
            return math.floor(item:GetValue())
        end
        return nil
    end)
    return ok and ping or nil
end
CanDoPing = GetPing() ~= nil

local function enabledwater()
    if WatermarkConnection then return end
    WatermarkConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if CanDoPing then
            Library:SetWatermark(("GetBetter.cc Premium | %d ms"):format(GetPing() or 0))
        else
            Library:SetWatermark("GetBetter.cc Premium")
        end
    end)
end

local function nowater()
    if WatermarkConnection then
        WatermarkConnection:Disconnect()
        WatermarkConnection = nil
    end
    Library:SetWatermarkVisibility(false)
end

_WatermarkToggle:OnChanged(function(value)
    if value then
        Library:SetWatermarkVisibility(true)
        enabledwater()
    else
        nowater()
    end
end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('GetBetter.cc')
SaveManager:SetFolder('GetBetter.cc/premium')
SaveManager:BuildConfigSection(Boxes['UI Settings'])
ThemeManager:ApplyToTab(Boxes['UI Settings'])
SaveManager:LoadAutoloadConfig()

local EmoteTabBox = Boxes.World:AddRightTabbox()
local EmoteTab = EmoteTabBox:AddTab('Emotes')
local Emotes = {
    Enabled = false,
    CurrentAnimation = nil,
    Anims = {
        zerotwodance = 95385842020103, laughingitupemote = 122240620529815, tf2laughingspyr6 = 76507949699963,
        billybounce = 93450937830334, catgirlsittingdown = 124682757478598, celebratoryapplauseclap = 71112576712945,
        happyhappyhappy = 99066466026711, gayemote2 = 104918870934219, flossemote = 123783175775850,
        scubanickwilde = 70919402339484, Salsa = 100319995972885, hipsway = 80963950541052,
        nonchalantaurafilleddance = 80035199697503, kickinglegs = 112540347880956, twerkyoassoff = 85115037529002,
        Scenario = 111901279618983, slowclaps = 122162023523653, heyyamove = 119734573196374,
        Caramelldansen = 97847706148165, Sleeply = 105016815489641, griddy = 106715239721951,
        creepindance = 80985588930231, upsidedownclapping = 135648992354309, OrangeJustice = 129748377368660,
        spiceclapslay = 76426815825663, evillaugh = 73856013353080, coffinwalkout = 117302755748327,
        facepalm = 116894206473799, ldance = 114846964045392, smugdance = 136079923684452,
        jabbaswitchway = 77791964179635, thisdancegoeshard = 109910154206713, spinspinspin = 100677848413238,
        Druski = 98405298116702, gayidle = 135210847181660, NLECHOPPA = 133293268056643,
        mjpytprettyyoungthing = 137234266130963, worm = 112153137737330, gayclap = 108147171194405,
        ratdance = 98603994713783, gayemote = 130781901105365, iwantmoney = 128258195574116,
        kawaiisit = 71952737697877,
    },
}
Emotes.FullList = {}
for emoteName in next, Emotes.Anims do
    table.insert(Emotes.FullList, emoteName)
end
table.sort(Emotes.FullList)
_G.Emotes = Emotes
if getgenv then
    getgenv().Emotes = Emotes
end

local function getSelectedEmoteName()
    local name = Options.EmoteSelect and Options.EmoteSelect.Value
    if type(name) ~= 'string' or name == '' or name == '(no matches)' then
        return Emotes.FullList[1] or 'griddy'
    end
    if not Emotes.Anims[name] then
        return Emotes.FullList[1] or 'griddy'
    end
    return name
end

local function getEmoteAnimator(char, hum)
    hum = hum or char:FindFirstChildOfClass('Humanoid')
    if not hum then
        return nil
    end
    local animator = hum:FindFirstChildOfClass('Animator')
    if not animator then
        animator = Instance.new('Animator')
        animator.Parent = hum
    end
    return hum, animator
end

local function loadEmoteAnimationTrack(hum, animator, assetNum)
    local assetId = 'rbxassetid://' .. tostring(assetNum)

    local function tryLoadAnimation(animInstance)
        if not animInstance or not animInstance:IsA('Animation') then
            return nil
        end
        local ok, track = pcall(function()
            return animator:LoadAnimation(animInstance)
        end)
        if ok and track then
            return track
        end
        ok, track = pcall(function()
            return hum:LoadAnimation(animInstance)
        end)
        if ok and track then
            return track
        end
        return nil
    end

    local okObjects, objects = pcall(function()
        return game:GetObjects(assetId)
    end)
    if okObjects and objects then
        for _, obj in ipairs(objects) do
            local track = tryLoadAnimation(obj)
            if track then
                return track
            end
        end
    end

    local anim = Instance.new('Animation')
    anim.AnimationId = assetId
    local track = tryLoadAnimation(anim)
    if track then
        return track
    end

    local okInsert, model = pcall(function()
        return game:GetService('InsertService'):LoadAsset(assetNum)
    end)
    if okInsert and model then
        local found = model:FindFirstChildWhichIsA('Animation', true)
        track = tryLoadAnimation(found)
        pcall(function()
            model:Destroy()
        end)
        if track then
            return track
        end
    end

    return nil
end

local function playEmoteTrack(track, speed)
    track.Priority = Enum.AnimationPriority.Action4
    track.Looped = true
    pcall(function()
        track:Play(0.1, 1, speed)
    end)
    pcall(function()
        track:AdjustSpeed(speed)
    end)
    Emotes.CurrentAnimation = track
end

_G.PlayEmote = function(name, speed)
    speed = tonumber(speed) or 1
    if speed <= 0 then
        speed = 1
    end
    name = name or getSelectedEmoteName()
    if not Emotes.Anims[name] then
        name = getSelectedEmoteName()
    end
    local assetNum = Emotes.Anims[name]
    if not assetNum then
        return false
    end

    local char = LocalPlayer.Character
    if not char then
        char = LocalPlayer.CharacterAdded:Wait()
    end
    local hum = char:WaitForChild('Humanoid', 8)
    if not hum or hum.Health <= 0 then
        return false
    end
    local _, animator = getEmoteAnimator(char, hum)
    if not animator then
        return false
    end

    if Emotes.CurrentAnimation then
        pcall(function()
            Emotes.CurrentAnimation:Stop(0)
        end)
        Emotes.CurrentAnimation = nil
    end

    local track = loadEmoteAnimationTrack(hum, animator, assetNum)
    if not track then
        if Library and Library.Notify then
            Library:Notify('Emote failed to load: ' .. tostring(name))
        end
        return false
    end

    playEmoteTrack(track, speed)
    return true
end

_G.StopEmote = function()
    if Emotes.CurrentAnimation then
        pcall(function()
            Emotes.CurrentAnimation:Stop(0)
        end)
        Emotes.CurrentAnimation = nil
    end
end

local function runEmoteFromUI()
    task.spawn(function()
        local spd = (Options.EmoteSpeed and Options.EmoteSpeed.Value or 10) / 10
        _G.PlayEmote(getSelectedEmoteName(), spd > 0 and spd or 1)
    end)
end

EmoteTab:AddToggle('EmotesEnabled', { Text = 'Enabled', Default = false })
EmoteTab:AddDropdown('EmoteSelect', {
    Values = Emotes.FullList,
    Default = Emotes.FullList[1] or 'griddy',
    Text = 'Selected Emote',
})
EmoteTab:AddInput('EmoteSearch', {
    Text = 'Search Emotes',
    Default = '',
    Placeholder = 'type to filter...',
})
EmoteTab:AddSlider('EmoteSpeed', {
    Text = 'Emote Speed',
    Default = 10,
    Min = 1,
    Max = 100,
    Rounding = 0,
})

Options.EmoteSearch:OnChanged(function(query)
    query = string.lower(query or '')
    if query == '' then
        Options.EmoteSelect:SetValues(Emotes.FullList)
        return
    end
    local matches = {}
    for _, name in ipairs(Emotes.FullList) do
        if string.find(string.lower(name), query, 1, true) then
            table.insert(matches, name)
        end
    end
    if #matches == 0 then matches = { '(no matches)' } end
    Options.EmoteSelect:SetValues(matches)
end)

Toggles.EmotesEnabled:OnChanged(function()
    Emotes.Enabled = Toggles.EmotesEnabled.Value
    if not Emotes.Enabled then
        _G.StopEmote()
        return
    end
    runEmoteFromUI()
end)

Options.EmoteSelect:OnChanged(function()
    if Emotes.Enabled then
        runEmoteFromUI()
    end
end)

Options.EmoteSpeed:OnChanged(function()
    if Emotes.Enabled and Emotes.CurrentAnimation then
        pcall(function()
            Emotes.CurrentAnimation:AdjustSpeed(Options.EmoteSpeed.Value / 10)
        end)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.delay(1.5, function()
        if Emotes.Enabled then
            runEmoteFromUI()
        end
    end)
end)

task.wait(1)

setfflag("DebugRunParallelLuaOnMainThread", "true")

local function _Palette()
    if not Library then
        return {
            Font = Enum.Font.Code,
            MainColor = Color3.fromRGB(28, 28, 28),
            BackgroundColor = Color3.fromRGB(20, 20, 20),
            AccentColor = Color3.fromRGB(0, 85, 255),
            OutlineColor = Color3.fromRGB(50, 50, 50),
            FontColor = Color3.fromRGB(255, 255, 255),
            AccentColorDark = Color3.fromRGB(0, 57, 170),
        }
    end
    return Library
end

local function _Darker(Color, Factor)
    local H, S, V = Color3.toHSV(Color)
    return Color3.fromHSV(H, S, math.clamp(V / (Factor or 1.5), 0, 1))
end

local _NoclipConnection = nil
local _WSConnection = nil
local _JPConnection = nil

local function _WalkSpeedLoop()
    if not Toggles.WalkSpeedEnabled.Value then
        return
    end

    local char = LocalPlayer.Character
    if not char then
        return
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = Options.WalkSpeed.Value
    end
end

local function _WalkSpeedChanged()
    if _WSConnection then
        _WSConnection:Disconnect()
        _WSConnection = nil
    end

    if Toggles.WalkSpeedEnabled.Value then
        _WSConnection = RunService.RenderStepped:Connect(_WalkSpeedLoop)
    end
end

Options.WalkSpeed:OnChanged(_WalkSpeedChanged)
Toggles.WalkSpeedEnabled:OnChanged(_WalkSpeedChanged)
task.spawn(_WalkSpeedChanged)

local function _NoclipLoop()
    if not Toggles.Noclip.Value then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end

local function _NoclipRestore()
    local char = LocalPlayer.Character
    if not char then return end

    local collidable = {
        Head = true,
        Torso = true,
        UpperTorso = true,
        LowerTorso = true,
    }

    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = collidable[v.Name] == true
        end
    end
end

local function _NoclipToggleChanged()
    if Toggles.Noclip.Value then
        if not _NoclipConnection then
            _NoclipConnection = RunService.RenderStepped:Connect(_NoclipLoop)
        end
    else
        if _NoclipConnection then
            _NoclipConnection:Disconnect()
            _NoclipConnection = nil
        end
        _NoclipRestore()
    end
end

Toggles.Noclip:OnChanged(_NoclipToggleChanged)
task.spawn(_NoclipToggleChanged)

_njp = 50

local function _JumpPowerLoop()
    if not Toggles.JumpPowerEnabled.Value then
        return
    end
    local char = LocalPlayer.Character
    if not char then
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.JumpPower = Options.JumpPower.Value
    end
end

local function _JumpPowerChanged()
    if _JPConnection then
        _JPConnection:Disconnect()
        _JPConnection = nil
    end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if Toggles.JumpPowerEnabled.Value then
        _JPConnection = RunService.RenderStepped:Connect(_JumpPowerLoop)
        if hum then
            hum.JumpPower = Options.JumpPower.Value
        end
    else
        if hum then
            hum.JumpPower = _njp
        end
    end
end

Options.JumpPower:OnChanged(_JumpPowerChanged)
Toggles.JumpPowerEnabled:OnChanged(_JumpPowerChanged)
task.spawn(_JumpPowerChanged)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    _JumpPowerChanged()
end)

skeletonLines = {}
skeletonConnections = {}
bones = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

partNames = {
    "Head", "UpperTorso", "LowerTorso", 
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot"
}

screenSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
screenPadding = 100

function isOnScreen(position)
    return position.X > -screenPadding and position.X < screenSize.X + screenPadding and
           position.Y > -screenPadding and position.Y < screenSize.Y + screenPadding
end

function getJoints(character)
    joints = {}
    root = character:FindFirstChild("HumanoidRootPart")
    if not root then return joints end
    
    for _, partName in ipairs(partNames) do
        part = character:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            joints[partName] = part
        end
    end
    
    return joints
end

function createSkeletonLine(color)
    line = Drawing.new("Line")
    line.Color = color
    line.Thickness = 1.5
    line.Transparency = 1
    line.ZIndex = 5
    line.Visible = false
    return line
end

fromVec = Vector2.new()
toVec = Vector2.new()

function updateSkeleton(player)
    if not Toggles.ESPShowSkeleton.Value then 
        lines = skeletonLines[player]
        if lines then
            for _, line in ipairs(lines) do
                line.Visible = false
            end
        end
        return 
    end
    
    character = player.Character
    if not character then return end
    
    joints = getJoints(character)
    if not joints or not next(joints) then return end
    
    camera = workspace.CurrentCamera
    if not camera then return end
    
    screenSize = camera.ViewportSize

    rootPart = joints["HumanoidRootPart"] or character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
        if not onScreen or not isOnScreen(rootPos) then
            lines = skeletonLines[player]
            if lines then
                for _, line in ipairs(lines) do
                    line.Visible = false
                end
            end
            return
        end
    end
    
    color = Options.SkeletonColor.Value
    
    lines = skeletonLines[player]
    if not lines then
        lines = {}
        for i = 1, #bones do
            lines[i] = createSkeletonLine(color)
        end
        skeletonLines[player] = lines
    end
    
    anyVisible = false
    
    for i, bone in ipairs(bones) do
        part1 = joints[bone[1]]
        part2 = joints[bone[2]]
        line = lines[i]
        
        if part1 and part2 and line then
            pos1, onScreen1 = camera:WorldToViewportPoint(part1.Position)
            pos2, onScreen2 = camera:WorldToViewportPoint(part2.Position)
            
            if (onScreen1 or onScreen2) and (isOnScreen(pos1) or isOnScreen(pos2)) then
                fromVec = Vector2.new(pos1.X, pos1.Y)
                toVec = Vector2.new(pos2.X, pos2.Y)
                line.From = fromVec
                line.To = toVec
                line.Visible = true
                line.Color = color
                anyVisible = true
            else
                line.Visible = false
            end
        else
            if line then line.Visible = false end
        end
    end
end

function cleanupSkeleton(player)
    lines = skeletonLines[player]
    if lines then
        for _, line in ipairs(lines) do
            line:Remove()
        end
        skeletonLines[player] = nil
    end
    
    conn = skeletonConnections[player]
    if conn then
        conn:Disconnect()
        skeletonConnections[player] = nil
    end
end

function cleanupAllSkeletons()
    for player, lines in pairs(skeletonLines) do
        for _, line in ipairs(lines) do
            line:Remove()
        end
    end
    skeletonLines = {}
    
    for player, conn in pairs(skeletonConnections) do
        if conn then
            conn:Disconnect()
        end
    end
    skeletonConnections = {}
    
    if skeletonRenderConnection then
        skeletonRenderConnection:Disconnect()
        skeletonRenderConnection = nil
    end
    
    if skeletonPlayerRemovingConnection then
        skeletonPlayerRemovingConnection:Disconnect()
        skeletonPlayerRemovingConnection = nil
    end
end

Toggles.ESPShowSkeleton:OnChanged(function(value)
    if not value then
        for player, lines in pairs(skeletonLines) do
            for _, line in ipairs(lines) do
                line.Visible = false
            end
        end
    end
end)

Options.SkeletonColor:OnChanged(function()
    for _, lines in pairs(skeletonLines) do
        for _, line in ipairs(lines) do
            line.Color = Options.SkeletonColor.Value
        end
    end
end)

skeletonRenderConnection = RunService.RenderStepped:Connect(function()
    if not Toggles.ESPShowSkeleton.Value then return end
    
    camera = Workspace.CurrentCamera
    if not camera then return end
    
    players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player ~= _56 then
            character = player.Character
            if character then
                rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen and isOnScreen(rootPos) then
                        updateSkeleton(player)
                    else
                        lines = skeletonLines[player]
                        if lines then
                            for _, line in ipairs(lines) do
                                line.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
end)

skeletonPlayerRemovingConnection = Players.PlayerRemoving:Connect(function(player)
    cleanupSkeleton(player)
end)

local function base64_decode(data)
    if type(base64decode) == 'function' then
        return base64decode(data)
    end
    if type(crypt) == 'table' and type(crypt.base64decode) == 'function' then
        return crypt.base64decode(data)
    end
    return 'rbxassetid://0'
end

local box_gradient_data = base64_decode("iVBORw0KGgoAAAANSUhEUgAAAAEAAABkCAYAAABHLFpgAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABTSURBVChTdU/LDsAwCGJu1/3/59rUC5HAhaA8bNHdfwF4LrwbagN3wgakwMVc4ttCTLhxmKjOIma5S5VfiC0TE180R8aRIAJvuJfGGHcsoHoZ6gCUSgTCpTUDpwAAAABJRU5ErkJggg==")

Options.BoxESPColor:OnChanged(function()
    _G.box_esp_color = Options.BoxESPColor.Value
end)

Options.BoxESPFillColor:OnChanged(function()
    _G.box_esp_fill_color = Options.BoxESPFillColor.Value
end)

Options.BoxESPBarType:OnChanged(function()
    _G.box_esp_bar_types = {}
    for barType, enabled in pairs(Options.BoxESPBarType.Value) do
        if enabled then
            _G.box_esp_bar_types[barType] = true
        end
    end
end)

Toggles.BoxESPFilled:OnChanged(function(value)
    _G.box_esp_filled = value
end)

function getArmorValue(character)
    local bodyEffects = character:FindFirstChild("BodyEffects")
    if bodyEffects then
        local armor = bodyEffects:FindFirstChild("Armor")
        if armor then
            return armor.Value or 0
        end
    end
    return 0
end

function createBoxESP(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "\0"
    screenGui.Parent = game.CoreGui
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true

    local boxContainer = Instance.new("Frame")
    boxContainer.Name = "\0"
    boxContainer.BackgroundTransparency = 1
    boxContainer.Size = UDim2.new(1, 0, 1, 0)
    boxContainer.Parent = screenGui

    local topLine = Instance.new("Frame")
    topLine.Name = "Top"
    topLine.BackgroundColor3 = _G.box_esp_color
    topLine.BorderSizePixel = 0
    topLine.Parent = boxContainer

    local bottomLine = Instance.new("Frame")
    bottomLine.Name = "Bottom"
    bottomLine.BackgroundColor3 = _G.box_esp_color
    bottomLine.BorderSizePixel = 0
    bottomLine.Parent = boxContainer

    local leftLine = Instance.new("Frame")
    leftLine.Name = "Left"
    leftLine.BackgroundColor3 = _G.box_esp_color
    leftLine.BorderSizePixel = 0
    leftLine.Parent = boxContainer

    local rightLine = Instance.new("Frame")
    rightLine.Name = "Right"
    rightLine.BackgroundColor3 = _G.box_esp_color
    rightLine.BorderSizePixel = 0
    rightLine.Parent = boxContainer

    local fillBox = Instance.new("Frame")
    fillBox.Name = "Fill"
    fillBox.BackgroundColor3 = _G.box_esp_fill_color
    fillBox.BorderSizePixel = 0
    fillBox.BackgroundTransparency = _G.box_esp_fill_transparency
    fillBox.Visible = _G.box_esp_filled
    fillBox.Parent = boxContainer

    local gradientImage = Instance.new("ImageLabel")
    gradientImage.Name = "Gradient"
    gradientImage.BackgroundTransparency = 1
    gradientImage.Image = box_gradient_data
    gradientImage.ImageTransparency = 0
    gradientImage.ImageColor3 = _G.box_esp_fill_color
    gradientImage.ScaleType = Enum.ScaleType.Stretch
    gradientImage.ZIndex = 5
    gradientImage.Visible = _G.box_esp_filled
    gradientImage.Parent = boxContainer

    local healthBarBackground = Instance.new("Frame")
    healthBarBackground.Name = "HealthBG"
    healthBarBackground.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    healthBarBackground.BackgroundTransparency = 0.45
    healthBarBackground.BorderSizePixel = 0
    healthBarBackground.Visible = false
    healthBarBackground.Parent = screenGui

    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Visible = false
    healthBar.Parent = screenGui

    local healthBarGradient = Instance.new("UIGradient")
    healthBarGradient.Rotation = 90
    healthBarGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    healthBarGradient.Parent = healthBar

    local armorBarBackground = Instance.new("Frame")
    armorBarBackground.Name = "ArmorBG"
    armorBarBackground.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
    armorBarBackground.BackgroundTransparency = 0.45
    armorBarBackground.BorderSizePixel = 0
    armorBarBackground.Visible = false
    armorBarBackground.Parent = screenGui

    local armorBar = Instance.new("Frame")
    armorBar.Name = "ArmorBar"
    armorBar.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    armorBar.BorderSizePixel = 0
    armorBar.Visible = false
    armorBar.Parent = screenGui

    local armorBarGradient = Instance.new("UIGradient")
    armorBarGradient.Rotation = 90
    armorBarGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 206, 235)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    armorBarGradient.Parent = armorBar

    return screenGui, boxContainer, topLine, bottomLine, leftLine, rightLine, fillBox, gradientImage,
           healthBarBackground, healthBar, armorBarBackground, armorBar
end

function updateBoxESP(player, boxData)
    local screenGui = boxData.screenGui
    local boxContainer = boxData.boxContainer
    local topLine = boxData.topLine
    local bottomLine = boxData.bottomLine
    local leftLine = boxData.leftLine
    local rightLine = boxData.rightLine
    local fillBox = boxData.fillBox
    local gradientImage = boxData.gradientImage
    local healthBarBackground = boxData.healthBarBackground
    local healthBar = boxData.healthBar
    local armorBarBackground = boxData.armorBarBackground
    local armorBar = boxData.armorBar

    local character = player.Character
    if not character then
        screenGui.Enabled = false
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        screenGui.Enabled = false
        return
    end

    local camera = Workspace.CurrentCamera
    if not camera then
        screenGui.Enabled = false
        return
    end

    local headPart = character:FindFirstChild("Head")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not headPart or not rootPart then
        screenGui.Enabled = false
        return
    end

    local sizeX, sizeY, sizeZ = 2.5, 6, 1.5
    local corners = {
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(-sizeX / 2, -sizeY / 2, -sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(sizeX / 2, -sizeY / 2, -sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(-sizeX / 2, sizeY / 2, -sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(sizeX / 2, sizeY / 2, -sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(-sizeX / 2, -sizeY / 2, sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(sizeX / 2, -sizeY / 2, sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(-sizeX / 2, sizeY / 2, sizeZ / 2)).Position),
        camera:WorldToViewportPoint((rootPart.CFrame * CFrame.new(sizeX / 2, sizeY / 2, sizeZ / 2)).Position),
    }

    local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge

    for i = 1, 8 do
        local corner = corners[i]
        minX = math.min(minX, corner.X)
        minY = math.min(minY, corner.Y)
        maxX = math.max(maxX, corner.X)
        maxY = math.max(maxY, corner.Y)
    end

    local anyOnScreen = false
    for i = 1, 8 do
        if corners[i].Z > 0 then
            anyOnScreen = true
            break
        end
    end

    if not anyOnScreen then
        screenGui.Enabled = false
        return
    end

    screenGui.Enabled = true
    boxContainer.Visible = true

    local boxWidth = maxX - minX
    local boxHeight = maxY - minY
    local boxX = minX
    local boxY = minY

    local thickness = _G.box_esp_thickness
    local fillInset = 1

    local boxColor = _G.box_esp_color
    topLine.BackgroundColor3 = boxColor
    bottomLine.BackgroundColor3 = boxColor
    leftLine.BackgroundColor3 = boxColor
    rightLine.BackgroundColor3 = boxColor
    fillBox.BackgroundColor3 = _G.box_esp_fill_color
    fillBox.BackgroundTransparency = _G.box_esp_fill_transparency
    fillBox.Visible = _G.box_esp_filled
    gradientImage.ImageColor3 = _G.box_esp_fill_color
    gradientImage.ImageTransparency = 0
    gradientImage.Visible = _G.box_esp_filled

    topLine.Size = UDim2.new(0, boxWidth, 0, thickness)
    topLine.Position = UDim2.new(0, boxX, 0, boxY)

    bottomLine.Size = UDim2.new(0, boxWidth, 0, thickness)
    bottomLine.Position = UDim2.new(0, boxX, 0, boxY + boxHeight - thickness)

    leftLine.Size = UDim2.new(0, thickness, 0, boxHeight)
    leftLine.Position = UDim2.new(0, boxX, 0, boxY)

    rightLine.Size = UDim2.new(0, thickness, 0, boxHeight)
    rightLine.Position = UDim2.new(0, boxX + boxWidth - thickness, 0, boxY)

    fillBox.Size = UDim2.new(0, boxWidth - fillInset * 2, 0, boxHeight - fillInset * 2)
    fillBox.Position = UDim2.new(0, boxX + fillInset, 0, boxY + fillInset)

    gradientImage.Size = UDim2.new(0, boxWidth - fillInset * 2, 0, boxHeight - fillInset * 2)
    gradientImage.Position = UDim2.new(0, boxX + fillInset, 0, boxY + fillInset)

    local barX = boxX - 5
    local barY = boxY

    if _G.box_esp_bar_types["Health"] then
        local health_per = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
        local barHeight = boxHeight * (health_per / 100)
        
        healthBar.Size = UDim2.new(0, 2, 0, barHeight)
        healthBar.Position = UDim2.new(0, barX, 0, barY + boxHeight - barHeight)
        healthBar.Visible = true
        
        healthBarBackground.Size = UDim2.new(0, 2, 0, boxHeight)
        healthBarBackground.Position = UDim2.new(0, barX, 0, barY)
        healthBarBackground.Visible = true
    else
        healthBar.Visible = false
        healthBarBackground.Visible = false
    end

    if _G.box_esp_bar_types["Armor"] then
        local armorVal = getArmorValue(character)
        local armor_per = math.floor((armorVal / 200) * 100)
        local armor_bar_x = barX - 5.4
        local armor_bar_height = boxHeight * (armor_per / 100)
        
        armorBar.Size = UDim2.new(0, 2, 0, armor_bar_height)
        armorBar.Position = UDim2.new(0, armor_bar_x, 0, barY + boxHeight - armor_bar_height)
        armorBar.Visible = true
        
        armorBarBackground.Size = UDim2.new(0, 2, 0, boxHeight)
        armorBarBackground.Position = UDim2.new(0, armor_bar_x, 0, barY)
        armorBarBackground.Visible = true
    else
        armorBar.Visible = false
        armorBarBackground.Visible = false
    end
end

Toggles.BoxESPEnabled:OnChanged(function(value)
    if _G.box_esp_connection then
        _G.box_esp_connection:Disconnect()
        _G.box_esp_connection = nil
    end

    for _, boxData in pairs(_G.box_esp_boxes) do
        if boxData.screenGui then
            boxData.screenGui:Destroy()
        end
    end
    _G.box_esp_boxes = {}

    if value then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local screenGui, boxContainer, topLine, bottomLine, leftLine, rightLine, fillBox, gradientImage,
                      healthBarBackground, healthBar, armorBarBackground, armorBar = createBoxESP(player)
                _G.box_esp_boxes[player] = {
                    screenGui = screenGui,
                    boxContainer = boxContainer,
                    topLine = topLine,
                    bottomLine = bottomLine,
                    leftLine = leftLine,
                    rightLine = rightLine,
                    fillBox = fillBox,
                    gradientImage = gradientImage,
                    healthBarBackground = healthBarBackground,
                    healthBar = healthBar,
                    armorBarBackground = armorBarBackground,
                    armorBar = armorBar
                }
            end
        end

        _G.box_esp_connection = game:GetService("RunService").RenderStepped:Connect(function()
            for player, boxData in pairs(_G.box_esp_boxes) do
                if player and player.Parent then
                    updateBoxESP(player, boxData)
                end
            end
        end)
    end
end)

Players.PlayerAdded:Connect(function(player)
    if Toggles.BoxESPEnabled.Value then
        local screenGui, boxContainer, topLine, bottomLine, leftLine, rightLine, fillBox, gradientImage,
              healthBarBackground, healthBar, armorBarBackground, armorBar = createBoxESP(player)
        _G.box_esp_boxes[player] = {
            screenGui = screenGui,
            boxContainer = boxContainer,
            topLine = topLine,
            bottomLine = bottomLine,
            leftLine = leftLine,
            rightLine = rightLine,
            fillBox = fillBox,
            gradientImage = gradientImage,
            healthBarBackground = healthBarBackground,
            healthBar = healthBar,
            armorBarBackground = armorBarBackground,
            armorBar = armorBar
        }
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if _G.box_esp_boxes[player] then
        if _G.box_esp_boxes[player].screenGui then
            _G.box_esp_boxes[player].screenGui:Destroy()
        end
        _G.box_esp_boxes[player] = nil
    end
end)

function getPlayerTeam(player)
    if not player or not player.Character then return nil end
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        local teamValue = humanoid:FindFirstChild("Team")
        if teamValue then
            return teamValue.Value
        end
    end
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    if torso then
        local teamValue = torso:FindFirstChild("Team")
        if teamValue then
            return teamValue.Value
        end
    end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Accessory") then
            local handle = child:FindFirstChild("Handle")
            if handle then
                local teamValue = handle:FindFirstChild("Team")
                if teamValue then
                    return teamValue.Value
                end
            end
        end
        local teamValue = child:FindFirstChild("Team")
        if teamValue and type(teamValue.Value) == "string" then
            return teamValue.Value
        end
    end
    local characterTeam = character:GetAttribute("Team")
    if characterTeam then
        return characterTeam
    end
    return nil
end

function isSameTeam(player)
    local localTeam = getPlayerTeam(ESPLocalPlayer)
    local playerTeam = getPlayerTeam(player)
    if not localTeam or not playerTeam then return false end
    return localTeam == playerTeam
end

function isFriend(player)
    if not player or not player.UserId then return false end
    return shared.FriendsCache[player.UserId] ~= nil
end

function updateAllESPLabels()
    for player, label in pairs(names) do
        if label and label.Parent and player and player.Parent then
            updateLabelStyle(label, player)
        elseif label and not label.Parent then
            names[player] = nil
        end
    end
end

function espToggleOn(toggleName)
    return Toggles and Toggles[toggleName] and Toggles[toggleName].Value
end

function buildESPText(player, nameText)
    local parts = {}
    
    if espToggleOn("ESPShowNames") then
        local displayName = nameText
        if _G.j2h5g8f1 and _G.j2h5g8f1[player.UserId] then
            displayName = displayName .. " [MOD]"
        end
        table.insert(parts, displayName)
    end
    
    local character = player.Character
    local head = character and character:FindFirstChild("Head")
    if espToggleOn("ESPShowDistance") and head then
        local dist = math.floor((Camera.CFrame.Position - head.Position).Magnitude)
        table.insert(parts, "[" .. dist .. "m]")
    end
    if espToggleOn("ESPShowHealth") and character then
        local hum = character:FindFirstChild("Humanoid")
        if hum then
            table.insert(parts, math.floor(hum.Health) .. " HP")
        end
    end
    
    if #parts == 0 then return "" end
    return table.concat(parts, " ")
end

function setAllESPVisible(visible)
    for _, label in pairs(names) do
        if label and label.Parent then
            label.Visible = visible
        end
    end
end

function updateLabelStyle(label, player)
    if not label or not player or not isRunning then return end
    if not espToggleOn("ESPEnabled") then return end
    updateCurrentTarget()
    local isPlayerFriend = isFriend(player)
    local isTeammate = isSameTeam(player)
    local isTargeted = (currentTargetPlayer == player)
    local displayName = player.DisplayName or player.Name
    if isTargeted then
        label.Text = buildESPText(player, " " .. displayName .. " ")
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextStrokeTransparency = 0
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
    elseif isTeammate then
        label.Text = buildESPText(player, "◉ " .. displayName .. " ◉")
        label.TextColor3 = Color3.fromRGB(0, 255, 0)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextStrokeTransparency = 0
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
    elseif isPlayerFriend then
        label.Text = buildESPText(player, "★ " .. displayName .. " ★")
        label.TextColor3 = Color3.fromRGB(0, 200, 255)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextStrokeTransparency = 0
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
    else
        label.Text = buildESPText(player, displayName)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextStrokeTransparency = 0
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
    end
end

local ESP = {
    labels = {},
    cache = {},
    lastUpdate = 0,
    interval = 0.01
}

function createLabel(player)
    if not ESPGui then
        ESPGui = Instance.new("ScreenGui")
        ESPGui.Name = "ESPGui"
        ESPGui.ResetOnSpawn = false
        ESPGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        ESPGui.Parent = game:GetService("CoreGui")
    end
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.BorderSizePixel = 0
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Visible = false
    label.ZIndex = 10
    label.Parent = ESPGui
    ESP.labels[player] = label
    return label
end

function removeLabel(player)
    if ESP.labels[player] then
        ESP.labels[player]:Destroy()
        ESP.labels[player] = nil
    end
    ESP.cache[player] = nil
end

function getHeadPos(head)
    if not head then return end
    local pos, onScreen = Camera:WorldToScreenPoint(head.Position + Vector3.new(0, head.Size.Y/2, 0))
    if onScreen and pos.Z > 0 then
        local dist = (Camera.CFrame.Position - head.Position).Magnitude
        local yOffset = 22
        if dist > 150 then yOffset = 12 end
        return Vector2.new(pos.X, pos.Y - yOffset), dist, true
    end
end

function buildText(player)
    local parts = {}
    if Toggles.ESPShowNames and Toggles.ESPShowNames.Value then
        table.insert(parts, player.DisplayName)
    end
    if Toggles.ESPShowDistance and Toggles.ESPShowDistance.Value then
        local char = player.Character
        local head = char and char:FindFirstChild("Head")
        if head then
            local dist = math.floor((Camera.CFrame.Position - head.Position).Magnitude)
            table.insert(parts, "[" .. dist .. "m]")
        end
    end
    if Toggles.ESPShowHealth and Toggles.ESPShowHealth.Value then
        local char = player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            table.insert(parts, math.floor(hum.Health) .. " HP")
        end
    end
    if Toggles.ESPShowTool and Toggles.ESPShowTool.Value then
        local char = player.Character
        local tool = char and char:FindFirstChildOfClass('Tool')
        if tool then
            table.insert(parts, '[' .. tool.Name .. ']')
        end
    end
    return #parts > 0 and table.concat(parts, " ") or ""
end

function updateLabel(player)
    local label = ESP.labels[player]
    if not label then return end
    
    local char = player.Character
    if not char or not char.Parent then
        label.Visible = false
        return
    end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then
        label.Visible = false
        return
    end
    
    local head = char:FindFirstChild("Head")
    if not head then
        label.Visible = false
        return
    end
    
    local text = buildText(player)
    if text == "" then
        label.Visible = false
        return
    end
    
    local pos, dist, onScreen = getHeadPos(head)
    if not onScreen then
        label.Visible = false
        return
    end
    
    if label.Text ~= text then
        label.Text = text
    end
    
    local posX, posY = math.floor(pos.X + 0.5), math.floor(pos.Y + 0.5)
    if label.Position.X.Offset ~= posX or label.Position.Y.Offset ~= posY then
        label.Position = UDim2.new(0, posX, 0, posY)
    end
    
    local size = 13
    if dist > 150 then
        size = math.clamp(13 - ((dist - 150) / 200), 8, 13)
    end
    if label.TextSize ~= size then
        label.TextSize = size
    end
    
    if ESP.cache[player] and ESP.cache[player] == char then
        if not label.Visible then label.Visible = true end
        return
    end
    
    local isFriend = shared.FriendsCache and shared.FriendsCache[player.UserId]
    local isTarget = (SilentState and SilentState.active and SilentState.target == player)
        or (Camlockon and CamlockTarget == player)
    
    if isTarget then
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
    elseif isFriend then
        label.TextColor3 = Color3.fromRGB(0, 200, 255)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.GothamBold
    else
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.Font = Enum.Font.GothamBold
    end
    
    ESP.cache[player] = char
    label.Visible = true
end

function updateAllLabels()
    if not Toggles.ESPEnabled or not Toggles.ESPEnabled.Value then
        for _, label in pairs(ESP.labels) do
            if label then label.Visible = false end
        end
        return
    end
    
    local now = tick()
    if now - ESP.lastUpdate < ESP.interval then return end
    ESP.lastUpdate = now
    
    for player in pairs(ESP.labels) do
        if player and player.Parent then
            updateLabel(player)
        else
            removeLabel(player)
        end
    end
end

function setupESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= _56 then
            createLabel(player)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        if player ~= _56 then
            createLabel(player)
            task.wait(0.1)
            if shared.FriendsCache and shared.FriendsCache[player.UserId] then
                updateLabel(player)
            end
        end
    end)
    
    Players.PlayerRemoving:Connect(removeLabel)
    
    _56.CharacterAdded:Connect(function()
        for player in pairs(ESP.labels) do
            ESP.cache[player] = nil
        end
    end)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= _56 then
            player.CharacterAdded:Connect(function()
                ESP.cache[player] = nil
                updateLabel(player)
            end)
        end
    end
    
    RunService.RenderStepped:Connect(updateAllLabels)
    
    Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        Camera = Workspace.CurrentCamera
    end)
end

Toggles.ESPEnabled:OnChanged(function(v)
    if not v then
        for _, label in pairs(ESP.labels) do
            if label then label.Visible = false end
        end
    end
end)

Toggles.ESPShowNames:OnChanged(updateAllLabels)
Toggles.ESPShowDistance:OnChanged(updateAllLabels)
Toggles.ESPShowHealth:OnChanged(updateAllLabels)

setupESP()

if not espToggleOn("ESPEnabled") then
    setAllESPVisible(false)
end

local CamlockConnection = nil
local Camlockon = false
local CamlockTarget = nil
SilentState = SilentState or {
    enabled = false,
    active = false,
    target = nil,
    part = nil,
    position = nil,
    manualTarget = nil,
}

local function getVisualTargetPlayer()
    if Toggles.SilentAim and Toggles.SilentAim.Value then
        if Camlockon and CamlockTarget and CamlockTarget.Parent and CamlockTarget.Character then
            return CamlockTarget
        end
        if SilentState.manualTarget and SilentState.manualTarget.Parent and SilentState.manualTarget.Character then
            return SilentState.manualTarget
        end
        if SilentState.target and SilentState.target.Parent then
            return SilentState.target
        end
    end
    if CamlockTarget and CamlockTarget.Parent and CamlockTarget.Character then
        return CamlockTarget
    end
    return nil
end

local function resetPlayerCamera()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    cam.CameraType = Enum.CameraType.Custom
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
    if hum then
        cam.CameraSubject = hum
    end
end

local function getAimPosition()
    if UserInputService.TouchEnabled then
        return Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
    end
    return UserInputService:GetMouseLocation()
end

local function isKnocked(plr)
    if not Toggles.KnockCheck.Value then return false end
    local char = plr.Character
    if not char then return false end
    local bodyEffects = char:FindFirstChild("BodyEffects")
    if not bodyEffects then return false end
    local ko = bodyEffects:FindFirstChild("K.O")
    if ko and ko.Value == true then return true end
    return false
end

local function isDead(plr)
    local char = plr.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return true end
    local bodyEffects = char:FindFirstChild("BodyEffects")
    if bodyEffects then
        local dead = bodyEffects:FindFirstChild("Dead")
        if dead and dead.Value == true then return true end
    end
    return false
end

local function isProtected(plr)
    if not Toggles.ProtectedCheck.Value then return false end
    local char = plr.Character
    if not char then return true end
    if char:FindFirstChildOfClass("ForceField") then return true end
    return false
end

local function isVisible(plr, part)
    if not Toggles.WallCheck.Value then return true end
    local char = plr.Character
    if not char or not part then return true end
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = part.Position - origin
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = { LocalPlayer.Character, char }
    local result = workspace:Raycast(origin, direction, rayParams)
    return not result
end

local function isValidTarget(plr, part)
    if plr == LocalPlayer then return false end
    if not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then return false end
    if isKnocked(plr) then return false end
    if isProtected(plr) then return false end
    if not isVisible(plr, part) then return false end
    return true
end

local function getclosest()
    local closest, closestPlr, closestDist = nil, nil, math.huge
    local aimPos = getAimPosition()
    local hitPartName = Options.CamlockHitPart.Value
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass('Humanoid')
            local part = plr.Character:FindFirstChild(hitPartName)
            if hum and hum.Health > 0 and part then
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < closestDist then
                        if isValidTarget(plr, part) then
                            closestDist = dist
                            closest = part
                            closestPlr = plr
                        end
                    end
                end
            end
        end
    end
    return closest, closestPlr
end

local function canLock(plr)
    if not plr or not plr.Parent or not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then return false end
    if isKnocked(plr) then return false end
    if isProtected(plr) then return false end
    local part = plr.Character:FindFirstChild(Options.CamlockHitPart.Value)
    if not part then return false end
    if not isVisible(plr, part) then return false end
    return true, part
end

local function shouldUnlockKO(plr)
    return Toggles.UnlockOnKO and Toggles.UnlockOnKO.Value and isKnocked(plr)
end

local function resolveplayer()
    if Options.CamlockMode.Value == 'Sticky' then
        if not CamlockTarget then
            local part, plr = getclosest()
            if plr then
                CamlockTarget = plr
                return part, plr
            end
            return nil, nil
        end

        if shouldUnlockKO(CamlockTarget) then
            CamlockTarget = nil
            return nil, nil
        end
        local ok, part = canLock(CamlockTarget)
        if ok then
            return part, CamlockTarget
        end
        return nil, nil
    end

    local part, plr = getclosest()
    if plr then CamlockTarget = plr end
    if plr then
        local ok, vpart = canLock(plr)
        if ok then return vpart, plr end
    end
    return nil, nil
end

local function updatecamera()
    local target = resolveplayer()
    if target then
        local cam = workspace.CurrentCamera
        local goal = CFrame.new(cam.CFrame.Position, target.Position)
        local smooth = Options.CamlockSmoothness.Value

        if smooth <= 0 then
            cam.CFrame = goal
        else
            cam.CFrame = cam.CFrame:Lerp(goal, 1 - (smooth / 10))
        end
    end
end

local function enabledcam()
    if CamlockConnection then return end
    Camlockon = true
    CamlockConnection = RunService.RenderStepped:Connect(updatecamera)
end

function noenablecam()
    Camlockon = false
    CamlockTarget = nil
    if CamlockConnection then
        CamlockConnection:Disconnect()
        CamlockConnection = nil
    end
end

Toggles.Camlock:OnChanged(function(value)
    if not value then
        noenablecam()
    elseif Options.CamlockKey:GetState() then
        enabledcam()
    end
end)

Options.CamlockKey:OnClick(function()
    if not Toggles.Camlock.Value then
        noenablecam()
        return
    end

    if Camlockon then
        noenablecam()
    else
        enabledcam()
    end
end)

_96:AddButton('Fix Camera', function()
    pcall(noenablecam)
    pcall(resetPlayerCamera)
    Library:Notify('Camera reset')
end)

local _TargetHighlightObject = nil
local _TargetHighlightPlayer = nil

local function _TargetHighlightCleanup()
    if _TargetHighlightObject then
        _TargetHighlightObject:Destroy()
        _TargetHighlightObject = nil
    end
    _TargetHighlightPlayer = nil
end

local function _TargetHighlightUpdate()
    if not Toggles.TargetHighlight.Value then
        if _TargetHighlightObject then
            _TargetHighlightCleanup()
        end
        return
    end

    local target = getVisualTargetPlayer()
    if not target then
        _TargetHighlightCleanup()
        return
    end

    local character = target.Character
    if not character then
        _TargetHighlightCleanup()
        return
    end

    if _TargetHighlightPlayer ~= target or _TargetHighlightObject == nil or not _TargetHighlightObject.Parent then
        if _TargetHighlightObject then _TargetHighlightObject:Destroy() end
        _TargetHighlightPlayer = target

        local highlight = Instance.new("Highlight")
        highlight.Name = "GetBetterTargetHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = Options.TargetHighlightFill.Value
        highlight.FillTransparency = Options.TargetHighlightFill.Transparency
        highlight.OutlineColor = Options.TargetHighlightOutline.Value
        highlight.OutlineTransparency = Options.TargetHighlightOutline.Transparency
        highlight.Adornee = character
        highlight.Parent = character
        _TargetHighlightObject = highlight
    else
        _TargetHighlightObject.FillColor = Options.TargetHighlightFill.Value
        _TargetHighlightObject.FillTransparency = Options.TargetHighlightFill.Transparency
        _TargetHighlightObject.OutlineColor = Options.TargetHighlightOutline.Value
        _TargetHighlightObject.OutlineTransparency = Options.TargetHighlightOutline.Transparency
    end
end

local _TargetLineDrawing = nil

local function _TargetLineUpdate()
    if not Toggles.TargetLine.Value then
        if _TargetLineDrawing then
            _TargetLineDrawing.Visible = false
        end
        return
    end

    if not _TargetLineDrawing then
        _TargetLineDrawing = Drawing.new("Line")
        _TargetLineDrawing.Thickness = 1.5
        _TargetLineDrawing.Transparency = 1
        _TargetLineDrawing.ZIndex = 10
        _TargetLineDrawing.Visible = false
    end

    _TargetLineDrawing.Color = Options.TargetLineColor.Value
    _TargetLineDrawing.Transparency = 1 - Options.TargetLineColor.Transparency

    local target = getVisualTargetPlayer()
    if not target or not target.Character then
        _TargetLineDrawing.Visible = false
        return
    end

    local hrp = target.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        _TargetLineDrawing.Visible = false
        return
    end

    local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
    if not onScreen or screenPos.Z <= 0 then
        _TargetLineDrawing.Visible = false
        return
    end

    _TargetLineDrawing.From = getAimPosition()
    _TargetLineDrawing.To = Vector2.new(screenPos.X, screenPos.Y)
    _TargetLineDrawing.Visible = true
end

local _GUI = nil
local _TargetInfoFrame = nil
local _TargetInfoAvatar = nil
local _TargetInfoName = nil
local _TargetInfoArmor = nil
local _TargetInfoHealth = nil
local _TargetInfoStatus = nil

local function _TargetInfoCreate()
    local P = _Palette()

    _GUI = Instance.new("ScreenGui")
    _GUI.Name = "getbetter.cc"
    _GUI.ResetOnSpawn = false
    _GUI.IgnoreGuiInset = true
    _GUI.ZIndexBehavior = Enum.ZIndexBehavior.Global

    if syn and syn.protect_gui then
        syn.protect_gui(_GUI)
        _GUI.Parent = game:GetService("CoreGui")
    elseif gethui then
        _GUI.Parent = gethui()
    else
        _GUI.Parent = game:GetService("CoreGui")
    end

    local Outer = Instance.new("Frame")
    Outer.Name = "TargetInfoOuter"
    Outer.AnchorPoint = Vector2.new(0.5, 5)
    Outer.Position = UDim2.new(0.5, 0, 1, -100)
    Outer.Size = UDim2.new(0, 280, 0, 78)
    Outer.BackgroundColor3 = Color3.new(0, 0, 0)
    Outer.BackgroundTransparency = 0.55
    Outer.BorderSizePixel = 0
    Outer.Visible = false
    Outer.ZIndex = 100
    Outer.Parent = _GUI

    local Inner = Instance.new("Frame")
    Inner.Name = "Inner"
    Inner.BackgroundColor3 = P.BackgroundColor
    Inner.BackgroundTransparency = 0.55
    Inner.BorderColor3 = P.OutlineColor
    Inner.BorderMode = Enum.BorderMode.Inset
    Inner.Position = UDim2.new(0, 1, 0, 1)
    Inner.Size = UDim2.new(1, -2, 1, -2)
    Inner.ZIndex = 101
    Inner.Parent = Outer

    local Highlight = Instance.new("Frame")
    Highlight.Name = "Highlight"
    Highlight.BackgroundColor3 = P.AccentColor
    Highlight.BackgroundTransparency = 0.4
    Highlight.BorderSizePixel = 0
    Highlight.Size = UDim2.new(1, 0, 0, 2)
    Highlight.ZIndex = 103
    Highlight.Parent = Inner

    local Header = Instance.new("TextLabel")
    Header.Name = "Header"
    Header.BackgroundTransparency = 1
    Header.Position = UDim2.new(0, 6, 0, 3)
    Header.Size = UDim2.new(1, -12, 0, 14)
    Header.Font = P.Font
    Header.Text = "target"
    Header.TextSize = 13
    Header.TextColor3 = P.AccentColor
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.TextYAlignment = Enum.TextYAlignment.Top
    Header.TextStrokeTransparency = 1
    Header.ZIndex = 104
    Header.Parent = Inner

    local HeaderLine = Instance.new("Frame")
    HeaderLine.Name = "HeaderLine"
    HeaderLine.BackgroundColor3 = P.AccentColor
    HeaderLine.BackgroundTransparency = 0.5
    HeaderLine.BorderSizePixel = 0
    HeaderLine.Position = UDim2.new(0, 6, 0, 17)
    HeaderLine.Size = UDim2.new(1, -12, 0, 1)
    HeaderLine.ZIndex = 104
    HeaderLine.Parent = Inner

    local HeaderLineFade = Instance.new("UIGradient")
    HeaderLineFade.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, P.AccentColor),
        ColorSequenceKeypoint.new(1, P.BackgroundColor),
    })
    HeaderLineFade.Parent = HeaderLine

    _TargetInfoAvatar = Instance.new("ImageLabel")
    _TargetInfoAvatar.Name = "Avatar"
    _TargetInfoAvatar.Position = UDim2.new(0, 6, 0, 24)
    _TargetInfoAvatar.Size = UDim2.new(0, 48, 0, 48)
    _TargetInfoAvatar.BackgroundColor3 = P.MainColor
    _TargetInfoAvatar.BackgroundTransparency = 0.55
    _TargetInfoAvatar.BorderColor3 = P.OutlineColor
    _TargetInfoAvatar.BorderMode = Enum.BorderMode.Inset
    _TargetInfoAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    _TargetInfoAvatar.ZIndex = 105
    _TargetInfoAvatar.Parent = Inner

    _TargetInfoName = Instance.new("TextLabel")
    _TargetInfoName.Name = "Name"
    _TargetInfoName.BackgroundTransparency = 1
    _TargetInfoName.Position = UDim2.new(0, 60, 0, 24)
    _TargetInfoName.Size = UDim2.new(1, -70, 0, 15)
    _TargetInfoName.Font = P.Font
    _TargetInfoName.TextSize = 14
    _TargetInfoName.TextColor3 = P.FontColor
    _TargetInfoName.TextStrokeTransparency = 1
    _TargetInfoName.TextXAlignment = Enum.TextXAlignment.Left
    _TargetInfoName.TextYAlignment = Enum.TextYAlignment.Top
    _TargetInfoName.Text = "no target"
    _TargetInfoName.ZIndex = 105
    _TargetInfoName.Parent = Inner

    _TargetInfoArmor = Instance.new("TextLabel")
    _TargetInfoArmor.Name = "Armor"
    _TargetInfoArmor.BackgroundTransparency = 1
    _TargetInfoArmor.Position = UDim2.new(0, 60, 0, 40)
    _TargetInfoArmor.Size = UDim2.new(1, -70, 0, 13)
    _TargetInfoArmor.Font = P.Font
    _TargetInfoArmor.TextSize = 12
    _TargetInfoArmor.TextColor3 = P.FontColor
    _TargetInfoArmor.TextTransparency = 0.35
    _TargetInfoArmor.TextStrokeTransparency = 1
    _TargetInfoArmor.TextXAlignment = Enum.TextXAlignment.Left
    _TargetInfoArmor.TextYAlignment = Enum.TextYAlignment.Top
    _TargetInfoArmor.Text = "armor: --"
    _TargetInfoArmor.ZIndex = 105
    _TargetInfoArmor.Parent = Inner

    _TargetInfoHealth = Instance.new("TextLabel")
    _TargetInfoHealth.Name = "Health"
    _TargetInfoHealth.BackgroundTransparency = 1
    _TargetInfoHealth.Position = UDim2.new(0, 60, 0, 54)
    _TargetInfoHealth.Size = UDim2.new(1, -70, 0, 13)
    _TargetInfoHealth.Font = P.Font
    _TargetInfoHealth.TextSize = 12
    _TargetInfoHealth.TextColor3 = P.FontColor
    _TargetInfoHealth.TextTransparency = 0.35
    _TargetInfoHealth.TextStrokeTransparency = 1
    _TargetInfoHealth.TextXAlignment = Enum.TextXAlignment.Left
    _TargetInfoHealth.TextYAlignment = Enum.TextYAlignment.Top
    _TargetInfoHealth.Text = "health: --"
    _TargetInfoHealth.ZIndex = 105
    _TargetInfoHealth.Parent = Inner

    _TargetInfoStatus = Instance.new("TextLabel")
    _TargetInfoStatus.Name = "Status"
    _TargetInfoStatus.BackgroundTransparency = 1
    _TargetInfoStatus.AnchorPoint = Vector2.new(1, 0)
    _TargetInfoStatus.Position = UDim2.new(1, -6, 0, 24)
    _TargetInfoStatus.Size = UDim2.new(0, 90, 0, 14)
    _TargetInfoStatus.Font = P.Font
    _TargetInfoStatus.TextSize = 12
    _TargetInfoStatus.TextColor3 = P.AccentColor
    _TargetInfoStatus.TextStrokeTransparency = 1
    _TargetInfoStatus.TextXAlignment = Enum.TextXAlignment.Right
    _TargetInfoStatus.TextYAlignment = Enum.TextYAlignment.Top
    _TargetInfoStatus.Text = "alive"
    _TargetInfoStatus.ZIndex = 105
    _TargetInfoStatus.Parent = Inner

    _TargetInfoFrame = Outer
end

local function _TargetInfoDestroy()
    if _GUI then
        _GUI:Destroy()
        _GUI = nil
    end
    _TargetInfoFrame = nil
    _TargetInfoAvatar = nil
    _TargetInfoName = nil
    _TargetInfoArmor = nil
    _TargetInfoHealth = nil
    _TargetInfoStatus = nil
end

local _TargetInfoAvatarCache = {}
local _TargetInfoAvatarPending = {}

local function _TargetInfoLoadAvatar(userId)
    if _TargetInfoAvatarCache[userId] then
        return _TargetInfoAvatarCache[userId]
    end
    if _TargetInfoAvatarPending[userId] then
        return nil
    end
    _TargetInfoAvatarPending[userId] = true

    task.spawn(function()
        local success, url = pcall(function()
            return Players:GetUserThumbnailAsync(
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size100x100
            )
        end)
        if success and url then
            _TargetInfoAvatarCache[userId] = url
        end
        _TargetInfoAvatarPending[userId] = nil
    end)
    return nil
end

local function _TargetInfoRefreshColors()
    if not _TargetInfoFrame then return end
    local P = _Palette()

    local Inner = _TargetInfoFrame:FindFirstChild("Inner")
    if Inner then
        Inner.BackgroundColor3 = P.BackgroundColor
        Inner.BorderColor3 = P.OutlineColor

        local Highlight = Inner:FindFirstChild("Highlight")
        if Highlight then Highlight.BackgroundColor3 = P.AccentColor end

        local Header = Inner:FindFirstChild("Header")
        if Header then
            Header.TextColor3 = P.AccentColor
            Header.Font = P.Font
        end

        local HeaderLine = Inner:FindFirstChild("HeaderLine")
        if HeaderLine then
            HeaderLine.BackgroundColor3 = P.AccentColor
            local grad = HeaderLine:FindFirstChildOfClass("UIGradient")
            if grad then
                grad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, P.AccentColor),
                    ColorSequenceKeypoint.new(1, P.BackgroundColor),
                })
            end
        end
    end

    if _TargetInfoAvatar then
        _TargetInfoAvatar.BackgroundColor3 = P.MainColor
        _TargetInfoAvatar.BorderColor3 = P.OutlineColor
    end
    if _TargetInfoName then
        _TargetInfoName.TextColor3 = P.FontColor
        _TargetInfoName.Font = P.Font
    end
    if _TargetInfoArmor then
        _TargetInfoArmor.TextColor3 = P.FontColor
        _TargetInfoArmor.Font = P.Font
    end
    if _TargetInfoHealth then
        _TargetInfoHealth.TextColor3 = P.FontColor
        _TargetInfoHealth.Font = P.Font
    end
end

local function _TargetInfoUpdate()
    if not Toggles.TargetInfo.Value then
        if _TargetInfoFrame then
            _TargetInfoFrame.Visible = false
        end
        return
    end

    if not _GUI then
        _TargetInfoCreate()
    end

    local target = getVisualTargetPlayer()
    if not target then
        _TargetInfoFrame.Visible = false
        return
    end

    local character = target.Character
    if not character then
        _TargetInfoFrame.Visible = false
        return
    end

    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then
        _TargetInfoFrame.Visible = false
        return
    end

    _TargetInfoFrame.Visible = true
    _TargetInfoName.Text = target.DisplayName or target.Name

    local cached = _TargetInfoAvatarCache[target.UserId]
    if cached then
        _TargetInfoAvatar.Image = cached
    else
        local url = _TargetInfoLoadAvatar(target.UserId)
        if url then
            _TargetInfoAvatar.Image = url
        end
    end

    local armor = 0
    local bodyEffects = character:FindFirstChild("BodyEffects")
    if bodyEffects then
        local armorValue = bodyEffects:FindFirstChild("Armor")
        if armorValue and typeof(armorValue.Value) == "number" then
            armor = math.floor(armorValue.Value)
        end
    end
    _TargetInfoArmor.Text = "Armor: " .. armor

    _TargetInfoHealth.Text = string.format("Health: %d/%d", math.floor(hum.Health), math.floor(hum.MaxHealth))

    local knocked = false
    local dead = false
    if bodyEffects then
        local koValue = bodyEffects:FindFirstChild("K.O")
        if koValue and koValue.Value == true then knocked = true end
        local deadValue = bodyEffects:FindFirstChild("Dead")
        if deadValue and deadValue.Value == true then dead = true end
    end

    if hum.Health <= 0 or dead then
        _TargetInfoStatus.Text = "dead"
        _TargetInfoStatus.TextColor3 = Color3.fromRGB(220, 90, 90)
    elseif knocked then
        _TargetInfoStatus.Text = "k.o"
        _TargetInfoStatus.TextColor3 = Color3.fromRGB(230, 190, 80)
    else
        _TargetInfoStatus.Text = "alive"
        _TargetInfoStatus.TextColor3 = _Palette().AccentColor
    end
    _TargetInfoStatus.TextTransparency = 0
end

local _TargetInfoLastPaletteTick = 0
local _refreshSilentTargetForVisuals = nil

RunService.RenderStepped:Connect(function()
    if _refreshSilentTargetForVisuals then
        _refreshSilentTargetForVisuals()
    end
    _TargetHighlightUpdate()
    _TargetLineUpdate()
    _TargetInfoUpdate()

    if _TargetInfoFrame and _TargetInfoFrame.Visible then
        local now = tick()
        if now - _TargetInfoLastPaletteTick > 0.25 then
            _TargetInfoLastPaletteTick = now
            _TargetInfoRefreshColors()
        end
    end
end)

Toggles.TargetInfo:OnChanged(function(value)
    if not value then
        if _TargetInfoFrame then
            _TargetInfoFrame.Visible = false
        end
    end
end)

Library:OnUnload(function()
    _TargetInfoDestroy()
    _G.StopEmote()
    pcall(noenablecam)
    pcall(resetPlayerCamera)
end)

local CFrameFlyKeys = {}
local CFrameFlyConn = nil
local CFrameWSConn = nil

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    CFrameFlyKeys[input.KeyCode] = true
end)
UserInputService.InputEnded:Connect(function(input)
    CFrameFlyKeys[input.KeyCode] = false
end)

local function getMoveVector()
    local cam = Workspace.CurrentCamera
    if not cam then return Vector3.zero end
    local move = Vector3.zero
    if CFrameFlyKeys[Enum.KeyCode.W] then move += cam.CFrame.LookVector end
    if CFrameFlyKeys[Enum.KeyCode.S] then move -= cam.CFrame.LookVector end
    if CFrameFlyKeys[Enum.KeyCode.A] then move -= cam.CFrame.RightVector end
    if CFrameFlyKeys[Enum.KeyCode.D] then move += cam.CFrame.RightVector end
    if CFrameFlyKeys[Enum.KeyCode.Space] then move += Vector3.yAxis end
    if CFrameFlyKeys[Enum.KeyCode.LeftControl] then move -= Vector3.yAxis end
    if move.Magnitude > 0 then move = move.Unit end
    return move
end

local function cframeWalkStep(dt)
    if not Toggles.CFrameWalkSpeed or not Toggles.CFrameWalkSpeed.Value then return end
    if not Options.CFrameWalkSpeedKey:GetState() then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild('HumanoidRootPart')
    local hum = char and char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return end
    local dir = hum.MoveDirection
    if dir.Magnitude <= 0 then return end
    hrp.CFrame = hrp.CFrame + dir * (Options.CFrameWalkSpeedValue.Value * dt)
end

local _FlyWasActive = false

local function cframeFlyStep(dt)
    if not Toggles.CFrameFly or not Toggles.CFrameFly.Value then return end
    if not Options.CFrameFlyKey:GetState() then
        if _FlyWasActive then
            _FlyWasActive = false
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
        return
    end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild('HumanoidRootPart')
    local hum = char and char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return end
    _FlyWasActive = true
    hum:ChangeState(Enum.HumanoidStateType.Freefall)
    local move = getMoveVector()
    if move.Magnitude > 0 then
        hrp.CFrame = hrp.CFrame + move * (Options.CFrameFlySpeed.Value * dt)
    end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end

local function refreshCFrameMovement()
    if CFrameWSConn then CFrameWSConn:Disconnect() CFrameWSConn = nil end
    if CFrameFlyConn then CFrameFlyConn:Disconnect() CFrameFlyConn = nil end
    if not Toggles.CFrameFly or not Toggles.CFrameFly.Value then
        _FlyWasActive = false
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    if Toggles.CFrameWalkSpeed and Toggles.CFrameWalkSpeed.Value then
        CFrameWSConn = RunService.RenderStepped:Connect(cframeWalkStep)
    end
    if Toggles.CFrameFly and Toggles.CFrameFly.Value then
        CFrameFlyConn = RunService.RenderStepped:Connect(cframeFlyStep)
    end
end

if Toggles.CFrameWalkSpeed then
    Toggles.CFrameWalkSpeed:OnChanged(refreshCFrameMovement)
    Options.CFrameWalkSpeedKey:OnClick(refreshCFrameMovement)
    task.spawn(refreshCFrameMovement)
end
if Toggles.CFrameFly then
    Toggles.CFrameFly:OnChanged(refreshCFrameMovement)
    Options.CFrameFlyKey:OnClick(refreshCFrameMovement)
end

local TracerDrawings = {}
local HeadDotDrawings = {}
local ChinaHatDrawings = {}
local ChinaHatSides = 20

local function ensureDrawing(pool, player, factory)
    if not pool[player] then pool[player] = factory() end
    return pool[player]
end

local function cleanupDrawingPool(pool)
    for plr, obj in pairs(pool) do
        if typeof(obj) == 'table' then
            for _, d in ipairs(obj) do pcall(function() d:Remove() end) end
        else
            pcall(function() obj:Remove() end)
        end
        pool[plr] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if typeof(Drawing) ~= 'table' or type(Drawing.new) ~= 'function' then return end
    local cam = Workspace.CurrentCamera
    if not cam or not Players or not Players.GetPlayers then return end
    local origin = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then
        else
        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass('Humanoid')
        local head = char and char:FindFirstChild('Head')
        local hrp = char and char:FindFirstChild('HumanoidRootPart')
        local alive = char and hum and hum.Health > 0 and head and hrp

        if Toggles.ESPTracers and Toggles.ESPTracers.Value and alive then
            local line = ensureDrawing(TracerDrawings, plr, function()
                local l = Drawing.new('Line')
                l.Thickness = 1.2
                l.ZIndex = 2
                return l
            end)
            local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
            if onScreen and pos.Z > 0 then
                line.From = origin
                line.To = Vector2.new(pos.X, pos.Y)
                line.Color = (SilentState and SilentState.active and SilentState.target == plr) and Color3.fromRGB(255, 80, 120) or Color3.fromRGB(255, 255, 255)
                line.Visible = true
            else
                line.Visible = false
            end
        elseif TracerDrawings[plr] then
            TracerDrawings[plr].Visible = false
        end

        if Toggles.ESPHeadDot and Toggles.ESPHeadDot.Value and alive then
            local dot = ensureDrawing(HeadDotDrawings, plr, function()
                local c = Drawing.new('Circle')
                c.Filled = true
                c.Radius = 4
                c.NumSides = 12
                c.ZIndex = 6
                return c
            end)
            local pos, onScreen = cam:WorldToViewportPoint(head.Position)
            if onScreen and pos.Z > 0 then
                dot.Position = Vector2.new(pos.X, pos.Y)
                dot.Color = Color3.fromRGB(255, 255, 255)
                dot.Visible = true
            else
                dot.Visible = false
            end
        elseif HeadDotDrawings[plr] then
            HeadDotDrawings[plr].Visible = false
        end
        end
    end

    if Toggles.ESPChinaHat and Toggles.ESPChinaHat.Value then
        local c1 = Options.ESPChinaHatColor1 and Options.ESPChinaHatColor1.Value or Color3.fromRGB(255, 0, 120)
        local c2 = Options.ESPChinaHatColor2 and Options.ESPChinaHatColor2.Value or Color3.fromRGB(0, 170, 255)
        local t = tick() * 0.35
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == LocalPlayer then continue end
            local char = plr.Character
            local head = char and char:FindFirstChild('Head')
            local hum = char and char:FindFirstChildOfClass('Humanoid')
            if not head or not hum or hum.Health <= 0 then continue end
            local hatLines = ensureDrawing(ChinaHatDrawings, plr, function()
                local lines = {}
                for _ = 1, ChinaHatSides do
                    local l = Drawing.new('Line')
                    l.Thickness = 1
                    l.ZIndex = 4
                    table.insert(lines, l)
                end
                return lines
            end)
            local base = head.Position + Vector3.new(0, 0.4, 0)
            local apex = base + Vector3.new(0, 1.1, 0)
            local apex2d, apexOk = cam:WorldToViewportPoint(apex)
            if not apexOk or apex2d.Z <= 0 then
                for _, l in ipairs(hatLines) do l.Visible = false end
                continue
            end
            for i = 1, ChinaHatSides do
                local a1 = (i / ChinaHatSides) * math.pi * 2
                local a2 = ((i % ChinaHatSides) + 1) / ChinaHatSides * math.pi * 2
                local p1 = base + Vector3.new(math.cos(a1), 0, math.sin(a1)) * 1.6
                local p2 = base + Vector3.new(math.cos(a2), 0, math.sin(a2)) * 1.6
                local s1, ok1 = cam:WorldToViewportPoint(p1)
                local s2, ok2 = cam:WorldToViewportPoint(p2)
                local line = hatLines[i]
                if ok1 and ok2 and s1.Z > 0 and s2.Z > 0 then
                    line.From = Vector2.new(s1.X, s1.Y)
                    line.To = Vector2.new(s2.X, s2.Y)
                    line.Color = Color3.new(c1.R + (c2.R - c1.R) * ((math.sin(t + i) + 1) / 2), c1.G + (c2.G - c1.G) * ((math.cos(t + i) + 1) / 2), c1.B + (c2.B - c1.B) * ((math.sin(t * 0.7 + i) + 1) / 2))
                    line.Visible = true
                else
                    line.Visible = false
                end
            end
        end
    else
        cleanupDrawingPool(ChinaHatDrawings)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if TracerDrawings[plr] then pcall(function() TracerDrawings[plr]:Remove() end) TracerDrawings[plr] = nil end
    if HeadDotDrawings[plr] then pcall(function() HeadDotDrawings[plr]:Remove() end) HeadDotDrawings[plr] = nil end
    if ChinaHatDrawings[plr] then
        for _, l in ipairs(ChinaHatDrawings[plr]) do pcall(function() l:Remove() end) end
        ChinaHatDrawings[plr] = nil
    end
end)

shared.hitman = shared.hitman or { silent = { enabled = false, mode = 'sticky' } }

local _silentRayParams = RaycastParams.new()
_silentRayParams.FilterType = Enum.RaycastFilterType.Exclude
_silentRayParams.IgnoreWater = true
local _silentRayExclude = {}
local _silentFriendCache = {}
local _silentOriginalGetAim = nil

local function silentIsActive()
    return Toggles.SilentAim and Toggles.SilentAim.Value == true
end

local function silentIsFriend(plr)
    local uid = plr.UserId
    local cached = _silentFriendCache[uid]
    if cached == nil then
        _silentFriendCache[uid] = false
        task.spawn(function()
            local ok, res = pcall(function()
                return LocalPlayer:IsFriendsWith(uid)
            end)
            _silentFriendCache[uid] = (ok and res) or false
        end)
        return false
    end
    return cached
end

local function silentPassesChecks(plr, char, part, cam)
    if Toggles.SilentTeamCheck and Toggles.SilentTeamCheck.Value and isSameTeam(plr) then
        return false
    end
    if Toggles.SilentFriendCheck and Toggles.SilentFriendCheck.Value and silentIsFriend(plr) then
        return false
    end
    if Toggles.ProtectedCheck and Toggles.ProtectedCheck.Value and char:FindFirstChildOfClass('ForceField') then
        return false
    end
    if Toggles.KnockCheck and Toggles.KnockCheck.Value then
        local be = char:FindFirstChild('BodyEffects')
        if be then
            local ko = be:FindFirstChild('K.O')
            if ko and ko.Value then
                return false
            end
        end
    end
    local maxDist = Options.SilentMaxDistance and Options.SilentMaxDistance.Value or 0
    if maxDist > 0 and (part.Position - cam.CFrame.Position).Magnitude > maxDist then
        return false
    end
    if Toggles.WallCheck and Toggles.WallCheck.Value then
        local lc = LocalPlayer.Character
        _silentRayExclude[1] = lc
        _silentRayParams.FilterDescendantsInstances = _silentRayExclude
        local dir = part.Position - cam.CFrame.Position
        local hit = Workspace:Raycast(cam.CFrame.Position, dir, _silentRayParams)
        if hit and not hit.Instance:IsDescendantOf(char) then
            return false
        end
    end
    return true
end

local function silentAimPartOnCharacter(char, partMode, cam, center)
    local head = char:FindFirstChild('Head')
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if partMode == 'Body' then
        return hrp or head
    end
    if partMode == 'Closest Part' then
        local candidates = {}
        if head then candidates[#candidates + 1] = head end
        if hrp then candidates[#candidates + 1] = hrp end
        local bestLocal, bestLocalScore = nil, math.huge
        for _, cand in ipairs(candidates) do
            local sp2 = cam:WorldToViewportPoint(cand.Position)
            if sp2.Z > 0 then
                local s2 = (Vector2.new(sp2.X, sp2.Y) - center).Magnitude
                if s2 < bestLocalScore then
                    bestLocal = cand
                    bestLocalScore = s2
                end
            end
        end
        return bestLocal
    end
    return head or hrp
end

local function silentCanLock(plr, partMode)
    if not plr or not plr.Parent or not plr.Character then
        return false
    end
    local hum = plr.Character:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then
        return false
    end
    local cam = Camera
    if not cam then
        return false
    end
    local part = silentAimPartOnCharacter(plr.Character, partMode, cam, getAimPosition())
    if not part then
        return false
    end
    if not silentPassesChecks(plr, plr.Character, part, cam) then
        return false
    end
    return true, part
end

local function silentPickPart(radius, partMode)
    local cam = Camera
    if not cam then return nil end
    local vp = cam.ViewportSize
    local center = getAimPosition()
    local cap = math.max(40, math.min(vp.X, vp.Y) * 0.5 - 10)
    local cutoff = math.clamp(radius, 40, cap)
    local best, bestScore = nil, math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            local hum = char and char:FindFirstChildOfClass('Humanoid')
            if char and hum and hum.Health > 0 then
                local part = silentAimPartOnCharacter(char, partMode, cam, center)
                if part and silentPassesChecks(plr, char, part, cam) then
                    local sp = cam:WorldToViewportPoint(part.Position)
                    if sp.Z > 0 then
                        local score = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if score < bestScore then
                            best = part
                            bestScore = score
                        end
                    end
                end
            end
        end
    end

    if best and bestScore <= cutoff then
        return best
    end
    return nil
end

local function assignSilentManualTargetFromFOV()
    if Camlockon and CamlockTarget and CamlockTarget.Parent then
        return
    end
    local radius = Options.SilentFOV and Options.SilentFOV.Value or 100
    local aimPart = Options.SilentHitPart and Options.SilentHitPart.Value or 'Head'
    local part = silentPickPart(radius, aimPart)
    if part then
        SilentState.manualTarget = Players:GetPlayerFromCharacter(part.Parent)
    else
        SilentState.manualTarget = nil
    end
end

local function resolveSilentTargetPlayer(partMode)
    if Camlockon and CamlockTarget and CamlockTarget.Parent then
        if shouldUnlockKO(CamlockTarget) then
            return nil
        end
        local ok, _ = silentCanLock(CamlockTarget, partMode)
        if ok then
            return CamlockTarget
        end
        return nil
    end

    local manual = SilentState.manualTarget
    if not manual or not manual.Parent then
        return nil
    end

    if shouldUnlockKO(manual) then
        SilentState.manualTarget = nil
        return nil
    end

    local okManual, _ = silentCanLock(manual, partMode)
    if okManual then
        return manual
    end

    return nil
end

local function resolveSilentPart(_radius, partMode)
    local plr = resolveSilentTargetPlayer(partMode)
    if not plr then
        return nil
    end
    local ok, part = silentCanLock(plr, partMode)
    if ok then
        return part
    end
    return nil
end

local function syncSilentStateFromPart(part)
    if not part then
        SilentState.target = nil
        SilentState.part = nil
        SilentState.position = nil
        return
    end
    SilentState.part = part
    SilentState.target = Players:GetPlayerFromCharacter(part.Parent)
    SilentState.position = part.Position
end

local function refreshSilentTarget()
    if not silentIsActive() then
        SilentState.active = false
        SilentState.target = nil
        SilentState.part = nil
        SilentState.position = nil
        return
    end
    SilentState.active = true
    local radius = Options.SilentFOV and Options.SilentFOV.Value or 100
    local aimPart = Options.SilentHitPart and Options.SilentHitPart.Value or 'Head'
    syncSilentStateFromPart(resolveSilentPart(radius, aimPart))
end

_refreshSilentTargetForVisuals = function()
    if silentIsActive() then
        refreshSilentTarget()
    end
end

Toggles.SilentAim:OnChanged(function(v)
    SilentState.enabled = v
    SilentState.active = v
    shared.hitman.silent.enabled = v
    shared.hitman.silent.mode = 'sticky'
    if not v then
        SilentState.manualTarget = nil
        SilentState.target = nil
        SilentState.part = nil
        SilentState.position = nil
    else
        if not (Camlockon and CamlockTarget) then
            assignSilentManualTargetFromFOV()
        end
        refreshSilentTarget()
    end
end)

Options.SilentAimKey:OnClick(function()
    task.defer(function()
        if not Toggles.SilentAim.Value then
            return
        end
        assignSilentManualTargetFromFOV()
        refreshSilentTarget()
    end)
end)

Options.SilentMode:OnChanged(function()
    shared.hitman.silent.mode = 'sticky'
    refreshSilentTarget()
end)

task.spawn(function()
    local okm, gunHandler = pcall(function()
        return require(ReplicatedStorage:WaitForChild('Modules'):WaitForChild('GunHandler'))
    end)
    if not okm or type(gunHandler) ~= 'table' or type(gunHandler.GetAim) ~= 'function' then
        warn('[GetBetter Premium] GunHandler GetAim hook failed')
        return
    end

    _silentOriginalGetAim = gunHandler.GetAim
    gunHandler.GetAim = function(muzzlePos)
        if silentIsActive() and typeof(muzzlePos) == 'Vector3' then
            local hitchance = Options.SilentHitchance and Options.SilentHitchance.Value or 100
            if math.random(100) <= hitchance then
                local radius = Options.SilentFOV and Options.SilentFOV.Value or 100
                local aimPart = Options.SilentHitPart and Options.SilentHitPart.Value or 'Head'
                local target = resolveSilentPart(radius, aimPart)
                if target then
                    syncSilentStateFromPart(target)
                    local direction = target.Position - muzzlePos
                    if direction.Magnitude > 0 then
                        return direction.Unit, direction.Magnitude
                    end
                end
            end
        end
        return _silentOriginalGetAim(muzzlePos)
    end

    Library:Notify('Silent aim ready (GunHandler.GetAim)')
end)

local function toggleSilentAim()
    if Toggles.SilentAim then
        Toggles.SilentAim:SetValue(not Toggles.SilentAim.Value)
    end
end

local CamlockDropped = false

Library:OnUnload(function()
    if CFrameWSConn then CFrameWSConn:Disconnect() end
    if CFrameFlyConn then CFrameFlyConn:Disconnect() end
    _FlyWasActive = false
    pcall(noenablecam)
    pcall(resetPlayerCamera)
    if _silentOriginalGetAim then
        pcall(function()
            local gh = require(ReplicatedStorage.Modules.GunHandler)
            if type(gh) == 'table' then
                gh.GetAim = _silentOriginalGetAim
            end
        end)
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/sleeplyy/Main/refs/heads/main/Core/Cleaner.lua"))()

return {
    camlock = {
        enable  = enabledcam,
        disable = noenablecam,
        ison    = function() return Camlockon end,
        target  = function() return CamlockTarget end,
        dropped = function() return CamlockDropped end,
        setmode = function(mode)
            if Options.CamlockMode then Options.CamlockMode:SetValue(mode) end
        end,
    },
    silent = {
        toggle = toggleSilentAim,
        ison   = function() return SilentState.active end,
        target = function() return SilentState.target end,
    },
    emotes = {
        play = _G.PlayEmote,
        stop = _G.StopEmote,
    },
    targetinfo = {
        show   = function() if Toggles.TargetInfo then Toggles.TargetInfo:SetValue(true)  end end,
        hide   = function() if Toggles.TargetInfo then Toggles.TargetInfo:SetValue(false) end end,
        toggle = function() if Toggles.TargetInfo then Toggles.TargetInfo:SetValue(not Toggles.TargetInfo.Value) end end,
    },
    watermark = {
        enable  = function()
            if _WatermarkToggle then _WatermarkToggle:SetValue(true) end
            Library:SetWatermarkVisibility(true)
            enabledwater()
        end,
        disable = nowater,
    },
}
