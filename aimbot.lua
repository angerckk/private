gv = false
game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameprocess)
	    if (inputObject.KeyCode == getgenv().keyylol) and (not gameprocess) and gv == false then
	        gv = true
	        			game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
			game.Players.LocalPlayer.Character.Humz.WalkSpeed = getgenv().speed
			game.Players.LocalPlayer.Character.Humz.JumpPower = 50
	    else
	        	    if (inputObject.KeyCode == getgenv().keyylol) and (not gameprocess) and gv == true then
gv = false
			game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
			game.Players.LocalPlayer.Character.Humz.JumpPower = 50
			game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"	
			end end
	end)

    local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/angercc/hoodmodded/main/lib.lua"))()

    -- UI:Init(parent)
    -- Init:AddTab(title)
    -- AddTab:AddSection(title)
    -- AddSection:AddButton(text, callback)
    -- AddSection:AddSlider(text, default, callback)
    -- AddSection:AddKeybind(text, default, callback)
    -- AddSection:AddToggle(text, default, callback)
    
    local mainUI = ui:Init(game:GetService("CoreGui"))
    local homeTab = mainUI:AddTab("Headshot.me")
    local farmSection = homeTab:AddSection("Aimbot")
     farmSection:AddToggle("Enable", false, function(value)
        getgenv().Amt = not getgenv().Amt
    end)
     farmSection:AddKeybind("Keybind", Enum.KeyCode.Q, function(state)
        getgenv().aimlockkeyy = state
    end)
    local homeSettings = homeTab:AddSection("Settings")
    homeSettings:AddSlider("Radius", {min = 0, max = 60, def = 30}, function(value)
        Ar = value
        end)
        homeSettings:AddSlider("Prediction", {min = 0, max = 20, def = 6}, function(value)
            Pv = value
            end)
            local aimpart = homeTab:AddSection("Aim Parts")
            aimpart:AddButton("Head", function()
                getgenv().Ap = "Head"
                getgenv().Oamp = "Head"
                end)
                aimpart:AddButton("HumanoidRootPart", function()
                    getgenv().Ap = "HumanoidRootPart"
                    getgenv().Oamp = "HumanoidRootPart"
                    end)
                    aimpart:AddButton("Upper Torso", function()
                        getgenv().Ap = "UpperTorso"
                        getgenv().Oamp = "UpperTorso"
                        end)
                        aimpart:AddButton("Lower Torso", function()
                            getgenv().Ap = "LowerTorso"
                            getgenv().Oamp = "LowerTorso"
                            end)
            local lol = homeTab:AddSection("Extras")
            lol:AddKeybind("Keybind", Enum.KeyCode.Z, function(state)
                getgenv().keyylol = state
            end)
            lol:AddSlider("Walkspeed", {min = 16, max = 600, def = 16}, function(value)
                getgenv().speed = value
                end)
           

getgenv().Ap = "Head" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}
getgenv().Ar = 30 -- How far away from someones character you want to lock on at
getgenv().Tp = true 
getgenv().Fp = true
getgenv().Tc = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
getgenv().Pm = true -- Predicts if they are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed 
getgenv().Pv = 7
getgenv().Oamp = "HumanoidRootPart"
getgenv().Cij = true
getgenv().Ml = -0.27


for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("Script") and v.Name ~= "Health" and v.Name ~= "Sound" and v:FindFirstChild("LocalScript") then
        v:Destroy()
    end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    repeat
        wait()
    until game.Players.LocalPlayer.Character
    char.ChildAdded:Connect(function(child)
        if child:IsA("Script") then 
            wait(0.1)
            if child:FindFirstChild("LocalScript") then
                child.LocalScript:FireServer()
            end
        end
    end)
end)

repeat wait() until game:IsLoaded()

    getgenv().Amt = false

    local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
    local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
    local MousePressed, CanNotify = false, false;
    local AimlockTarget;
    local OldPre;

    getgenv().cIA = true

    getgenv().WorldToViewportPoint = function(P)
        return Camera:WorldToViewportPoint(P)
    end

    getgenv().WorldToScreenPoint = function(P)
        return Camera.WorldToScreenPoint(Camera, P)
    end

    getgenv().GetObscuringObjects = function(T)
        if T and T:FindFirstChild(getgenv().Ap) and Client and Client.Character:FindFirstChild("Head") then 
            local RayPos = workspace:FindPartOnRay(RNew(
                T[getgenv().Ap].Position, Client.Character.Head.Position)
            )
            if RayPos then return RayPos:IsDescendantOf(T) end
        end
    end

    getgenv().GetNearestTarget = function()
        -- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
        local players = {}
        local PLAYER_HOLD  = {}
        local DISTANCES = {}
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= Client then
                table.insert(players, v)
            end
        end
        for i, v in pairs(players) do
            if v.Character ~= nil then
                local AIM = v.Character:FindFirstChild("Head")
                if getgenv().Tc == true and v.Team ~= Client.Team then
                    local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                    local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                    local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i] = {}
                    PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr = v
                    PLAYER_HOLD[v.Name .. i].diff = DIFF
                    table.insert(DISTANCES, DIFF)
                elseif getgenv().Tc == false and v.Team == Client.Team then 
                    local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                    local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                    local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i] = {}
                    PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr = v
                    PLAYER_HOLD[v.Name .. i].diff = DIFF
                    table.insert(DISTANCES, DIFF)
                end
            end
        end
        
        if unpack(DISTANCES) == nil then
            return nil
        end
        
        local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
        if L_DISTANCE > getgenv().Ar then
            return nil
        end
        
        for i, v in pairs(PLAYER_HOLD) do
            if v.diff == L_DISTANCE then
                return v.plr
            end
        end
        return nil
    end

    game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameprocess)
        if not (Uis:GetFocusedTextBox()) then 
            if (inputObject.KeyCode == getgenv().aimlockkeyy) and (not gameprocess) and AimlockTarget == nil then
                pcall(function()
                    if MousePressed ~= true then MousePressed = true end 
                    local Target;Target = GetNearestTarget()
                    if Target ~= nil then 
                        AimlockTarget = Target
                    end
                end)
            elseif (inputObject.KeyCode == getgenv().aimlockkeyy) and (not gameprocess) and AimlockTarget ~= nil then
                if AimlockTarget ~= nil then AimlockTarget = nil end
                if MousePressed ~= false then 
                    MousePressed = false 
                end
            end
        end
    end)
    RService.RenderStepped:Connect(function()
        local AimPartOld = getgenv().Oamp
        if getgenv().Tp == true and getgenv().Fp == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif getgenv().Tp == true and getgenv().Fp == false then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        elseif getgenv().Tp == false and getgenv().Fp == true then 
            if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
                CanNotify = true 
            else 
                CanNotify = false 
            end
        end
        if getgenv().Amt == true and MousePressed == true then 
            if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().Ap) then 
                if getgenv().Fp == true then
                    if CanNotify == true then
                        if getgenv().Pm == true then 
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().Ap].Position + AimlockTarget.Character[getgenv().Ap].Velocity/Pv)
                        elseif getgenv().Pm == false then 
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().Ap].Position)
                        end
                    end
                elseif getgenv().Tp == true then 
                    if CanNotify == true then
                        if getgenv().Pm == true then 
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().Ap].Position + AimlockTarget.Character[getgenv().Ap].Velocity/Pv)
                        elseif getgenv().Pm == false then 
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().Ap].Position)
                        end
                    end 
                end
            end
        end
        if getgenv().Cij == true then
            if AimlockTarget.Character.Humanoid.FloorMaterial == Enum.Material.Air and AimlockTarget.Character.Humanoid.Jump == true then
                getgenv().Ap = "RightLowerLeg"
            else
                getgenv().Ap = AimPartOld
            end
        end
    end)


