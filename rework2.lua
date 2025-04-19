local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local players = game:GetService("Players")
local coregui = players.LocalPlayer.PlayerGui

local player = players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera

local lib = {}

function lib:CreateWindow(name)
    local types = {}
    name = name or "<b>INTERN</b> Library"

    -- Remove any existing GUI windows with the same name
    for _, v in pairs(coregui:GetChildren()) do
        if v.Name == "intern" then
            v:Destroy()
        end
    end

    -- Create the main ScreenGui
    local intern_hub = Instance.new("ScreenGui")
    intern_hub.Name = "intern"
    intern_hub.Parent = coregui
    intern_hub.ResetOnSpawn = false

    -- Main container frame
    local main_holder = Instance.new("Frame")
    main_holder.Name = "main_holder"
    main_holder.Parent = intern_hub
    main_holder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    main_holder.BackgroundTransparency = 1
    main_holder.Position = UDim2.new(0.5, -200, 0.5, -150)
    main_holder.Size = UDim2.new(0, 400, 0, 300)

    -- Glow effect
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Parent = main_holder
    Glow.BackgroundTransparency = 1
    Glow.Position = UDim2.new(0, -15, 0, -15)
    Glow.Size = UDim2.new(1, 30, 1, 30)
    Glow.ZIndex = 0
    Glow.Image = "rbxassetid://4996891970"
    Glow.ImageColor3 = Color3.fromRGB(15, 15, 15)
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(20, 20, 280, 280)

    -- Background frame
    local main_bg = Instance.new("Frame")
    main_bg.Name = "main_bg"
    main_bg.Parent = main_holder
    main_bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main_bg.BorderSizePixel = 0
    main_bg.ClipsDescendants = true
    main_bg.Position = UDim2.new(0.5, -200, 0.5, -150)
    main_bg.Size = UDim2.new(0, 400, 0, 300)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = main_bg

    -- Section text
    local ui_name = Instance.new("TextLabel")
    ui_name.Name = "ui_name"
    ui_name.Parent = main_bg
    ui_name.AnchorPoint = Vector2.new(0.5, 0.5)
    ui_name.BackgroundTransparency = 1
    ui_name.Position = UDim2.new(0.157, 0, 0.12, -17)
    ui_name.Size = UDim2.new(0, 125, 0, 35)
    ui_name.Font = Enum.Font.Gotham
    ui_name.Text = tostring(name)
    ui_name.TextColor3 = Color3.fromRGB(117, 117, 117)
    ui_name.TextSize = 14
    ui_name.RichText = true

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))}
    UIGradient.Rotation = 270
    UIGradient.Parent = ui_name

    -- Tab frame
    local tab = Instance.new("ScrollingFrame")
    tab.Name = "tab"
    tab.Parent = main_bg
    tab.Active = true
    tab.BackgroundTransparency = 1
    tab.Position = UDim2.new(0.5, -195, 0.12, 0)
    tab.Size = UDim2.new(0, 390, 0, 263)
    tab.ScrollBarThickness = 0

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = tab
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 6)

    -- Automatically adjust the size of the tab's content
    tab.CanvasSize = UDim2.new(0, 0, 0, tab.ListLayout.AbsoluteContentSize.Y)
    tab.ChildAdded:Connect(function()
        tab.CanvasSize = UDim2.new(0, 0, 0, tab.ListLayout.AbsoluteContentSize.Y + 55 + tab.ListLayout.Padding.Offset)
    end)

    -- Dragger functionality
    local dragger = {}
    function dragger.new(frame)
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        local inputService = game:GetService('UserInputService')
        local heartbeat = game:GetService("RunService").Heartbeat

        function dragger.new(frame)
            local s, event = pcall(function()
                return frame.MouseEnter
            end)

            if s then
                frame.Active = true

                event:Connect(function()
                    local input = frame.InputBegan:Connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 then
                            local objectPosition = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y)
                            while heartbeat:Wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                pcall(function()
                                    frame:TweenPosition(UDim2.new(0, mouse.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X), 0, mouse.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true)
                                end)
                            end
                        end
                    end)

                    local leave
                    leave = frame.MouseLeave:Connect(function()
                        input:Disconnect()
                        leave:Disconnect()
                    end)
                end)
            end
        end
    end

    dragger.new(main_holder)

    -- Button creation function
    local c = 0
    function lib:Button(text, callback)
        callback = callback or function() end
        text = text or "Button"
        c = c + 1

        local Button = Instance.new("TextButton")
        Button.Name = "Button"
        Button.Parent = tab
        Button.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Button.Size = UDim2.new(0, 375, 0, 42)
        Button.AutoButtonColor = false
        Button.Font = Enum.Font.SourceSans
        Button.Text = ""
        Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Button.TextSize = 14
        Button.LayoutOrder = c

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 5)
        ButtonCorner.Parent = Button

        local ButtonTitle = Instance.new("TextLabel")
        ButtonTitle.Name = "ButtonTitle"
        ButtonTitle.Parent = Button
        ButtonTitle.BackgroundTransparency = 1
        ButtonTitle.Position = UDim2.new(0.035, 0, 0, 0)
        ButtonTitle.Size = UDim2.new(0, 187, 0, 42)
        ButtonTitle.Font = Enum.Font.Gotham
        ButtonTitle.Text = text
        ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonTitle.TextSize = 14
        ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

        Button.MouseButton1Down:Connect(function()
            pcall(callback)
        end)

        -- Button hover effects
        local script = Instance.new('LocalScript', Button)
        script.Parent.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(38,38,38)
            }):Play()
        end)

        script.Parent.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(34,34,34)
            }):Play()
        end)
    end
end

    function types:Section(text)
        text = text or "Section"
        c = c + 1
        
        local Section = Instance.new("TextLabel")
        local UIGradient = Instance.new("UIGradient")
    
        Section.Name = "Section"
        Section.Parent = tab
        Section.AnchorPoint = Vector2.new(0.5, 0.5)
        Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Section.BackgroundTransparency = 1.000
        Section.BorderSizePixel = 0
        Section.LayoutOrder = c
        Section.Position = UDim2.new(0.157270208, 0, 0.119999997, -17)
        Section.Size = UDim2.new(0, 375, 0, 20)
        Section.Font = Enum.Font.GothamBold
        Section.Text = text
        Section.TextColor3 = Color3.fromRGB(180,180,180)
        Section.TextSize = 14.000
        Section.TextXAlignment = "Left"
        Section.TextYAlignment = "Bottom"
    
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
        UIGradient.Offset = Vector2.new(0.200000003, 0.400000006)
        UIGradient.Rotation = 270
        UIGradient.Parent = Section
    end

    function types:Toggle(text, default, callback)
        local toggled = false
        
        text = text or "Toggle"
        callback = callback or function() end

        c = c + 1
        
        local Toggle = Instance.new("TextButton")
        local ToggleCorner = Instance.new("UICorner")
        local ToggleTitle = Instance.new("TextLabel")
        local FrameToggle1 = Instance.new("Frame")
        local FrameToggle1Corner = Instance.new("UICorner")
        local UIStrokeToggle = Instance.new("UIStroke")
    
        Toggle.Name = "Toggle"
        Toggle.Parent = tab
        Toggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Toggle.Position = UDim2.new(0.215625003, 0, 0.446271926, 0)
        Toggle.Size = UDim2.new(0, 375, 0, 42)
        Toggle.AutoButtonColor = false
        Toggle.Font = Enum.Font.SourceSans
        Toggle.Text = ""
        Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        Toggle.TextSize = 14.000
        Toggle.LayoutOrder = c
    
        ToggleCorner.CornerRadius = UDim.new(0, 5)
        ToggleCorner.Name = "ToggleCorner"
        ToggleCorner.Parent = Toggle
    
        ToggleTitle.Name = "ToggleTitle"
        ToggleTitle.Parent = Toggle
        ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleTitle.BackgroundTransparency = 1.000
        ToggleTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
        ToggleTitle.Size = UDim2.new(0, 187, 0, 42)
        ToggleTitle.Font = Enum.Font.Gotham
        ToggleTitle.Text = text
        ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleTitle.TextSize = 14.000
        ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
    
        FrameToggle1.Name = "FrameToggle1"
        FrameToggle1.Parent = Toggle
        FrameToggle1.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
        FrameToggle1.Position = UDim2.new(0.902170777, 0, 0.5, -9)
        FrameToggle1.Size = UDim2.new(0, 20, 0, 18)
        
        UIStrokeToggle.Parent = FrameToggle1
        UIStrokeToggle.Thickness = 1
        UIStrokeToggle.Color = Color3.fromRGB(52, 52, 52)
        UIStrokeToggle.ApplyStrokeMode = "Contextual"
    
        FrameToggle1Corner.CornerRadius = UDim.new(0, 3)
        FrameToggle1Corner.Name = "FrameToggle1Corner"
        FrameToggle1Corner.Parent = FrameToggle1
        
        
            local script = Instance.new('LocalScript', Toggle)
    
            script.Parent.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(38,38,38)
                }):Play()
            end)
            script.Parent.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                }):Play()
            end)
        end
        

        Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(44, 120, 224)}
                        ):Play()
                    else
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(38,38,38)}
                        ):Play()
                    end
                    toggled = not toggled
                    pcall(callback, toggled)
                end
            )
            if default == true then
                TweenService:Create(
                    FrameToggle1,
                    TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(44, 120, 224)}
                ):Play()
                toggled = not toggled
            end
    end

    function types:Bind(text, keypreset, callback)
        c = c + 1

        text = text or "Keybind"
        calback = calback or function() end
        
        local binding = false
        local Key = keypreset.Name
        local Bind = Instance.new("TextButton")
        local BindCorner = Instance.new("UICorner")
        local BindTitle = Instance.new("TextLabel")
        local BindText = Instance.new("TextLabel")

        Bind.Name = "Bind"
        Bind.Parent = tab
        Bind.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Bind.Size = UDim2.new(0, 375, 0, 42)
        Bind.AutoButtonColor = false
        Bind.Font = Enum.Font.SourceSans
        Bind.Text = ""
        Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
        Bind.TextSize = 14.000
        Bind.LayoutOrder = c

        BindCorner.CornerRadius = UDim.new(0, 5)
        BindCorner.Name = "BindCorner"
        BindCorner.Parent = Bind

        BindTitle.Name = "BindTitle"
        BindTitle.Parent = Bind
        BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BindTitle.BackgroundTransparency = 1.000
        BindTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
        BindTitle.Size = UDim2.new(0, 187, 0, 42)
        BindTitle.Font = Enum.Font.Gotham
        BindTitle.Text = text
        BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        BindTitle.TextSize = 14.000
        BindTitle.TextXAlignment = Enum.TextXAlignment.Left

        BindText.Name = "BindText"
        BindText.Parent = Bind
        BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BindText.BackgroundTransparency = 1.000
        BindText.Position = UDim2.new(0.0358126722, 0, 0, 0)
        BindText.Size = UDim2.new(0, 337, 0, 42)
        BindText.Font = Enum.Font.Gotham
        BindText.Text = Key
        BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
        BindText.TextSize = 14.000
        BindText.TextXAlignment = Enum.TextXAlignment.Right


        Bind.MouseButton1Click:Connect(
            function()
                BindText.Text = "[ ... ]"
                binding = true
                local inputwait = game:GetService("UserInputService").InputBegan:wait()
                if inputwait.KeyCode.Name ~= "Unknown" then
                    BindText.Text = inputwait.KeyCode.Name
                    Key = inputwait.KeyCode.Name
                    binding = false
                else
                    binding = false
                end
            end
        )

        game:GetService("UserInputService").InputBegan:connect(
            function(current, pressed)
                if not pressed then
                    if current.KeyCode.Name == Key and binding == false then
                        pcall(callback)
                    end
                end
            end
        )

        
            local script = Instance.new('LocalScript', Bind)
    
            script.Parent.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(38,38,38)
                }):Play()
            end)
            script.Parent.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                }):Play()
            end)
        end
        
    end

    function types:TextBox(text, disapear, callback)
        text = text or "Textbox"
        c = c + 1
        
            local Textbox1 = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local UIStrokeTextbox = Instance.new("UIStroke")

            Textbox1.Name = "Textbox"
            Textbox1.LayoutOrder = c
            Textbox1.Parent = tab
            Textbox1.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Textbox1.ClipsDescendants = true
            Textbox1.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Textbox1.Size = UDim2.new(0, 375, 0, 42)

            TextboxCorner.CornerRadius = UDim.new(0, 5)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox1

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox1
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 187, 0, 42)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = TextboxTitle
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
            TextboxFrame.Position = UDim2.new(1.305, 0, 0.5, -11)
            TextboxFrame.Size = UDim2.new(0, 100, 0, 23)

            UIStrokeTextbox.Parent = TextboxFrame
            UIStrokeTextbox.Thickness = 1
            UIStrokeTextbox.Color = Color3.fromRGB(52, 52, 52)
            UIStrokeTextbox.ApplyStrokeMode = "Contextual"

            TextboxFrameCorner.CornerRadius = UDim.new(0, 5)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 100, 0, 23)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000

            TextBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                            if disapear then
                                TextBox.Text = ""
                            end
                        end
                    end
                end
            )
        
        
            local script = Instance.new('LocalScript', Textbox1)
    
            script.Parent.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(38,38,38)
                }):Play()
            end)
            script.Parent.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                }):Play()
            end)
        end
        
    end

    function types:Dropdown(text, list, callback)
        local DropFunction = {}
        local droptog = false
        local framesize = 0
        local itemcount = 0

        callback = callback or function() end
        text = text or "Dropdown"
        c = c + 1

        local Dropdown = Instance.new("Frame")
            local DropdownCorner = Instance.new("UICorner")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropLayout = Instance.new("UIListLayout")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Dropdown.ClipsDescendants = true
            Dropdown.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Dropdown.Size = UDim2.new(0, 375, 0, 42)
            Dropdown.LayoutOrder = c

            DropdownCorner.CornerRadius = UDim.new(0, 5)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 375, 0, 42)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 187, 0, 42)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(1.701, 0, 0.5, -13)
            ArrowImg.Size = UDim2.new(0, 26, 0, 26)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818375"

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = DropdownTitle
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropItemHolder.BackgroundTransparency = 1.000
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(-0.00400000019, 0, 1.04999995, 0)
            DropItemHolder.Size = UDim2.new(0, 342, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder

            function DropFunction:Refresh(newList)
                newList = newList or {}
                    for i,v in next, DropItemHolder:GetChildren() do
                        if v.Name == "Item" then
                            v:Destroy()
                        end
                    end
                    for i, v in next, list do
                        itemcount = itemcount + 1
                        if itemcount <= 3 then
                            framesize = framesize + 26
                            DropItemHolder.Size = UDim2.new(0, 375, 0, framesize)
                        end
                        local Item = Instance.new("TextButton")
                        local ItemCorner = Instance.new("UICorner")
        
                        Item.Name = "Item"
                        Item.Parent = DropItemHolder
                        Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                        Item.ClipsDescendants = true
                        Item.Size = UDim2.new(0, 350, 0, 25)
                        Item.AutoButtonColor = false
                        Item.Font = Enum.Font.Gotham
                        Item.Text = v
                        Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Item.TextSize = 15.000
        
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Name = "ItemCorner"
                        ItemCorner.Parent = Item
        
                        Item.MouseEnter:Connect(
                            function()
                                TweenService:Create(
                                    Item,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {BackgroundColor3 = Color3.fromRGB(38, 38, 38)}
                                ):Play()
                            end
                        )
        
                        Item.MouseLeave:Connect(
                            function()
                                TweenService:Create(
                                    Item,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                                ):Play()
                            end
                        )
        
                        Item.MouseButton1Click:Connect(
                            function()
                                droptog = not droptog
                                DropdownTitle.Text = text .. " - " .. v
                                pcall(callback, v)
                                Dropdown:TweenSize(
                                    UDim2.new(0, 375, 0, 42),
                                    Enum.EasingDirection.Out,
                                    Enum.EasingStyle.Quart,
                                    .2,
                                    true
                                )
                                TweenService:Create(
                                    ArrowImg,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {Rotation = 0}
                                ):Play()
                                wait(.2)
                                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
                                tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
                            end
                        )
        
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
                        tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
                    end
                end

        DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        Dropdown:TweenSize(
                            UDim2.new(0, 375, 0, 55 + framesize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 270}
                        ):Play()
                        wait(.2)
                        tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
                    else
                        Dropdown:TweenSize(
                            UDim2.new(0, 375, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
                    end
                    droptog = not droptog
                end
            )

            for i, v in next, list do
                itemcount = itemcount + 1
                if itemcount <= 3 then
                    framesize = framesize + 26
                    DropItemHolder.Size = UDim2.new(0, 375, 0, framesize)
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Item.ClipsDescendants = true
                Item.Size = UDim2.new(0, 350, 0, 25)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 15.000

                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(38, 38, 38)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = not droptog
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(0, 375, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
                        tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
                    end
                )

                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
                tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
            end
            return DropFunction
        end

        function types:Slider(text, min, max, start, callback)
            text = text or "Slider"
            min = min or 0
            max = max or 100
            callback = callback or function() end
            c = c + 1

            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local CurrentValueFrame = Instance.new("Frame")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = tab
            Slider.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Slider.Position = UDim2.new(-0.48035714, 0, -0.570532918, 0)
            Slider.Size = UDim2.new(0, 375, 0, 60)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000
            Slider.LayoutOrder = c

            SliderCorner.CornerRadius = UDim.new(0, 5)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 187, 0, 42)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 335, 0, 42)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.0342647657, 0, 0.686091602, 0)
            SlideFrame.Size = UDim2.new(0, 335, 0, 3)

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 3)

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or 0) / max, -6, -1.30499995, 0)
            SlideCircle.Size = UDim2.new(0, 11, 0, 11)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = Color3.fromRGB(44, 120, 224)

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -6,
                    -1.30499995,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    3
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end
            )
            SlideCircle.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end
            )
            game:GetService("UserInputService").InputChanged:Connect(
                function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        move(input)
                    end
                end
            )
            
                local script = Instance.new('LocalScript', Slider)
        
                script.Parent.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(38,38,38)
                    }):Play()
                end)
                script.Parent.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(0.15), {
                        BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                    }):Play()
                end)
            end
            
        end

        function types:Label(text)
            text = text or "Label"
            c = c + 1

            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Button"
            Label.Parent = tab
            Label.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Label.Size = UDim2.new(0, 375, 0, 42)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000
            Label.LayoutOrder = c

            LabelCorner.CornerRadius = UDim.new(0, 5)
            LabelCorner.Name = "ButtonCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "ButtonTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            LabelTitle.Size = UDim2.new(0, 187, 0, 42)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 14.000
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
        end
    return types
end

return lib
