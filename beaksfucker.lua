local lib = loadstring([[
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
    name = name or "<b>INTERN</b> Library"
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local players = game:GetService("Players")
    local coregui = players.LocalPlayer.PlayerGui
    local player = players.LocalPlayer
    local mouse = player:GetMouse()
    local camera = game.Workspace.CurrentCamera

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
    
    -- Create close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseButton"
    CloseBtn.Parent = main_bg
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "–"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.ZIndex = 10
    
    local CloseBtnCorner = Instance.new("UICorner")
    CloseBtnCorner.CornerRadius = UDim.new(0, 3)
    CloseBtnCorner.Parent = CloseBtn
    
    -- Create reopen button (initially hidden)
    local ReopenBtn = Instance.new("TextButton")
    ReopenBtn.Name = "ReopenButton"
    ReopenBtn.Parent = intern_hub
    ReopenBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ReopenBtn.Position = UDim2.new(0, 10, 0.5, -15)
    ReopenBtn.Size = UDim2.new(0, 30, 0, 30)
    ReopenBtn.Font = Enum.Font.GothamBold
    ReopenBtn.Text = "+"
    ReopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ReopenBtn.TextSize = 16
    ReopenBtn.Visible = false
    ReopenBtn.ZIndex = 10
    
    local ReopenBtnCorner = Instance.new("UICorner")
    ReopenBtnCorner.CornerRadius = UDim.new(0, 5)
    ReopenBtnCorner.Parent = ReopenBtn

    -- Section text
    local ui_name = Instance.new("TextLabel")
    ui_name.Name = "ui_name"
    ui_name.Parent = main_bg
    ui_name.AnchorPoint = Vector2.new(0.5, 0.5)
    ui_name.BackgroundTransparency = 1
    ui_name.Position = UDim2.new(0.145, 0, 0.12, -17)
    ui_name.Size = UDim2.new(0, 125, 0, 35)
    ui_name.Font = Enum.Font.Gotham
    ui_name.Text = tostring(name)
    ui_name.TextColor3 = Color3.fromRGB(170,170,170)
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
    ListLayout.Name = "ListLayout"
    ListLayout.Parent = tab
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 6)

    -- Automatically adjust the size of the tab's content
    tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    tab.ChildAdded:Connect(function()
        tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 55 + ListLayout.Padding.Offset)
    end)
    
    -- Create a shared dragging state variable that both dragger and buttons can access
    local isDraggingEnabled = true
    
    local dragger = {}
    
    function dragger.new(frame)
        frame.Active = true
        
        -- Variables to track the drag status
        local dragToggle = nil
        local dragStart = nil
        local startPos = nil
        
        -- Function to check if touch is on a ScrollingFrame
        local function isTouchOnScrollingFrame(input)
            -- Convert touch position to UI coordinates
            local elements = game:GetService("Players").LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(input.Position.X, input.Position.Y)
            
            for _, element in pairs(elements) do
                -- Check if the element is a ScrollingFrame or is inside one
                if element:IsA("ScrollingFrame") or element:FindFirstAncestorWhichIsA("ScrollingFrame") then
                    return true
                end
            end
            
            return false
        end
        
        -- Handle mobile touch input
        local touchConnection
        touchConnection = UserInputService.TouchStarted:Connect(function(touch)
            -- Only proceed if dragging is enabled
            if not isDraggingEnabled then return end
            
            local touchPosition = touch.Position
            local objectPosition = frame.AbsolutePosition
            local objectSize = frame.AbsoluteSize
            
            -- Check if touch is within the frame
            if touchPosition.X >= objectPosition.X and touchPosition.X <= objectPosition.X + objectSize.X and
               touchPosition.Y >= objectPosition.Y and touchPosition.Y <= objectPosition.Y + objectSize.Y then
                
                -- Only start drag if NOT on a ScrollingFrame
                if not isTouchOnScrollingFrame(touch) then
                    dragToggle = true
                    dragStart = touch.Position
                    startPos = frame.Position
                    
                    -- Track touch and update until it ends
                    local connection
                    connection = touch.Changed:Connect(function()
                        if touch.UserInputState == Enum.UserInputState.End then
                            dragToggle = false
                            connection:Disconnect()
                        end
                    end)
                end
            end
        end)
        
        -- Handle PC mouse input
        local mouseConnection
        mouseConnection = frame.InputBegan:Connect(function(input)
            -- Only proceed if dragging is enabled
            if not isDraggingEnabled then return end
            
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                -- Ignore if on ScrollingFrame
                if not isTouchOnScrollingFrame(input) then
                    dragToggle = true
                    dragStart = input.Position
                    startPos = frame.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragToggle = false
                        end
                    end)
                end
            end
        end)
        
        -- Update position based on input changes
        local inputChangedConnection
        inputChangedConnection = UserInputService.InputChanged:Connect(function(input)
            -- Only proceed if dragging is enabled
            if not isDraggingEnabled then return end
            
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragToggle then
                    -- Calculate new position
                    local delta = input.Position - dragStart
                    local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                              startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                    
                    -- Smooth movement with Tween
                    frame:TweenPosition(position, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
                end
            end
        end)
        
        -- Clean up connections when frame is destroyed
        frame.AncestryChanged:Connect(function(_, parent)
            if not parent then
                if touchConnection then touchConnection:Disconnect() end
                if mouseConnection then mouseConnection:Disconnect() end
                if inputChangedConnection then inputChangedConnection:Disconnect() end
            end
        end)
    end

    -- Apply the updated dragger
    dragger.new(main_holder)

    -- Close button functionality - now properly disables dragging
    CloseBtn.MouseButton1Click:Connect(function()
        main_holder.Visible = false
        isDraggingEnabled = false  -- Disable dragging when hidden
        ReopenBtn.Visible = true
    end)
    
    -- Reopen button functionality - now properly re-enables dragging
    ReopenBtn.MouseButton1Click:Connect(function()
        main_holder.Visible = true
        isDraggingEnabled = true  -- Re-enable dragging when shown
        ReopenBtn.Visible = false
    end)

    -- Create the different UI element types
    local types = {}
    local c = 0
    
    -- Button creation function
    function types:Button(text, callback)
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
            TweenService:Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(38,38,38)
            }):Play()
        end)

        script.Parent.MouseLeave:Connect(function()
            TweenService:Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(34,34,34)
            }):Play()
        end)
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
    text = text or "Toggle"
    callback = callback or function() end
    local toggled = default or false
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
    FrameToggle1.BackgroundColor3 = toggled and Color3.fromRGB(44, 120, 224) or Color3.fromRGB(37, 37, 37)
    FrameToggle1.Position = UDim2.new(0.902170777, 0, 0.5, -9)
    FrameToggle1.Size = UDim2.new(0, 20, 0, 18)
    
    UIStrokeToggle.Parent = FrameToggle1
    UIStrokeToggle.Thickness = 1
    UIStrokeToggle.Color = Color3.fromRGB(52, 52, 52)
    UIStrokeToggle.ApplyStrokeMode = "Contextual"

    FrameToggle1Corner.CornerRadius = UDim.new(0, 3)
    FrameToggle1Corner.Name = "FrameToggle1Corner"
    FrameToggle1Corner.Parent = FrameToggle1
    
    -- Toggle hover effect
    local script = Instance.new('LocalScript', Toggle)
    script.Parent.MouseEnter:Connect(function()
        TweenService:Create(script.Parent, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(38,38,38)
        }):Play()
    end)
    script.Parent.MouseLeave:Connect(function()
        TweenService:Create(script.Parent, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        }):Play()
    end)
    
    Toggle.MouseButton1Click:Connect(function()
        -- Toggle the state FIRST
        toggled = not toggled
        
        -- THEN update UI based on new state
        if toggled then
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
        
        -- FINALLY call the callback with the new state
        pcall(function()
            callback(toggled)
        end)
    end)
    
    -- Set initial state if default is true
    if default == true then
        FrameToggle1.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
        pcall(function()
            callback(true)
        end)
    end
end

    function types:Bind(text, keypreset, callback)
        c = c + 1

        text = text or "Keybind"
        callback = callback or function() end
        
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
                local inputwait = UserInputService.InputBegan:wait()
                if inputwait.KeyCode.Name ~= "Unknown" then
                    BindText.Text = inputwait.KeyCode.Name
                    Key = inputwait.KeyCode.Name
                    binding = false
                else
                    binding = false
                end
            end
        )

        UserInputService.InputBegan:connect(
            function(current, pressed)
                if not pressed then
                    if current.KeyCode.Name == Key and binding == false then
                        pcall(callback)
                    end
                end
            end
        )

        -- Hover effect
        local script = Instance.new('LocalScript', Bind)
        script.Parent.MouseEnter:Connect(function()
            TweenService:Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(38,38,38)
            }):Play()
        end)
        script.Parent.MouseLeave:Connect(function()
            TweenService:Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            }):Play()
        end)
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
    
        -- Hover effect
        local script = Instance.new('LocalScript', Textbox1)
        script.Parent.MouseEnter:Connect(function()
            TweenService:Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(38,38,38)
            }):Play()
        end)
        script.Parent.MouseLeave:Connect(function()
            TweenService:Create(script.Parent, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            }):Play()
        end)
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
    DropdownTitle.Position = UDim2.new(0.0358126722, 0, 0)
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

    -- Track dropdown state
    local isDropdownOpen = false

    function DropFunction:Refresh(newList)
        newList = newList or {}
        for i,v in next, DropItemHolder:GetChildren() do
            if v.Name == "Item" then
                v:Destroy()
            end
        end
        
        framesize = 0
        itemcount = 0
        
        for i, v in next, newList do
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

            Item.MouseEnter:Connect(function()
                TweenService:Create(
                    Item,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(38, 38, 38)}
                ):Play()
            end)

            Item.MouseLeave:Connect(function()
                TweenService:Create(
                    Item,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                ):Play()
            end)

            -- Fixed Item click behavior
            Item.MouseButton1Click:Connect(function()
                DropdownTitle.Text = text .. " - " .. v
                pcall(callback, v)
                
                -- Close dropdown and update state
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
                
                -- Important: Update dropdown state
                isDropdownOpen = false
                
                wait(.2)
                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
                tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
            end)

            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
            tab.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
        end
        return DropFunction
    end

    DropFunction:Refresh(list)
    
    -- Fixed dropdown button click behavior
    DropdownBtn.MouseButton1Click:Connect(function()
        isDropdownOpen = not isDropdownOpen
        
        if isDropdownOpen then
            -- Open dropdown
            Dropdown:TweenSize(
                UDim2.new(0, 375, 0, 42 + framesize),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                .2,
                true
            )
            TweenService:Create(
                ArrowImg,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 180}
            ):Play()
        else
            -- Close dropdown
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
        end
    end)

    -- Hover effect
    local script = Instance.new('LocalScript', Dropdown)
    script.Parent.MouseEnter:Connect(function()
        TweenService:Create(script.Parent, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(38,38,38)
        }):Play()
    end)
    script.Parent.MouseLeave:Connect(function()
        TweenService:Create(script.Parent, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        }):Play()
    end)
    
    return DropFunction
end

function types:Slider(text, min, max, start, callback)
    text = text or "Slider"
    min = min or 0
    max = max or 100
    start = start or min -- Default to min if not provided
    callback = callback or function() end
    c = c + 1

    -- Clamp the start value between min and max
    start = math.clamp(start, min, max)

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
    SliderValue.Text = tostring(start)
    SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderValue.TextSize = 14.000
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right

    SlideFrame.Name = "SlideFrame"
    SlideFrame.Parent = Slider
    SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SlideFrame.BorderSizePixel = 0
    SlideFrame.Position = UDim2.new(0.0342647657, 0, 0.686091602, 0)
    SlideFrame.Size = UDim2.new(0, 335, 0, 3)

    -- Calculate initial position for negative ranges
    local startPercent = (start - min) / (max - min)
    
    CurrentValueFrame.Name = "CurrentValueFrame"
    CurrentValueFrame.Parent = SlideFrame
    CurrentValueFrame.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
    CurrentValueFrame.BorderSizePixel = 0
    CurrentValueFrame.Size = UDim2.new(startPercent, 0, 0, 3)

    -- Make the slide circle larger for mobile users (easier to tap)
    SlideCircle.Name = "SlideCircle"
    SlideCircle.Parent = SlideFrame
    SlideCircle.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
    SlideCircle.BackgroundTransparency = 1.000
    SlideCircle.Position = UDim2.new(startPercent, -6, -1.30499995, 0)
    SlideCircle.Size = UDim2.new(0, 11, 0, 11) -- Larger size for better mobile interaction
    SlideCircle.Image = "rbxassetid://3570695787"
    SlideCircle.ImageColor3 = Color3.fromRGB(44, 120, 224)
    
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    
    -- Universal function to handle both mouse and touch input
    local function updateSlider(inputPosition)
        local sliderPosition = SlideFrame.AbsolutePosition
        local sliderSize = SlideFrame.AbsoluteSize
        
        -- Calculate percentage position (clamped between 0 and 1)
        local percentage = math.clamp((inputPosition.X - sliderPosition.X) / sliderSize.X, 0, 1)
        
        -- Set circle position
        local pos = UDim2.new(percentage, -6, -1.30499995, 0)
        local pos1 = UDim2.new(percentage, 0, 0, 3)
        
        CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
        SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
        
        -- Calculate value using the proper range (including negative values)
        local value = math.floor(((percentage) * (max - min)) + min)
        SliderValue.Text = tostring(value)
        pcall(callback, value)
        
        return value
    end
    
    -- Mouse click on slider bar
    SlideFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
            input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
            updateSlider(input.Position)
        end
    end)
    
    SlideFrame.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
            input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)
    
    -- Circle drag start
    SlideCircle.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
            input.UserInputType == Enum.UserInputType.Touch) then
            dragging = true
        end
    end)
    
    -- Circle drag end
    SlideCircle.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
            input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)
    
    -- Handle movement while dragging (both mouse and touch)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and 
           (input.UserInputType == Enum.UserInputType.MouseMovement or 
            input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input.Position)
        end
    end)
    
    -- Additional touch support (tap and drag)
    Slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input.Position)
        end
    end)
    
    Slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Hover effect for PC
    local hoverEffect = Instance.new('LocalScript', Slider)
    
    hoverEffect.Parent.MouseEnter:Connect(function()
        TweenService:Create(hoverEffect.Parent, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(38,38,38)
        }):Play()
    end)
    
    hoverEffect.Parent.MouseLeave:Connect(function()
        TweenService:Create(hoverEffect.Parent, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        }):Play()
    end)
    
    -- Call the callback with the initial value
    pcall(callback, start)
    
    -- Add method to set value programmatically
    local SliderObject = {}
    
    function SliderObject:SetValue(newValue)
        newValue = math.clamp(newValue, min, max)
        local percentage = (newValue - min) / (max - min)
        
        -- Update UI
        CurrentValueFrame:TweenSize(UDim2.new(percentage, 0, 0, 3), "Out", "Sine", 0.1, true)
        SlideCircle:TweenPosition(UDim2.new(percentage, -6, -1.30499995, 0), "Out", "Sine", 0.1, true)
        SliderValue.Text = tostring(newValue)
        
        -- Call callback
        pcall(callback, newValue)
    end
    
    return SliderObject
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
]])()

local main = lib:CreateWindow()

--// frames
main:Section("Utility")

local hitboxToggled = false
local originalScales = {}

main:Toggle("Extend Hitbox", false, function(state)
    hitboxToggled = state

    for _, m in pairs(workspace:GetDescendants()) do
        if m:IsA("Model") and m.Name == "Normal" then
            local p = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart")
            if p then
                if hitboxToggled then
                    -- Save original size if not already saved
                    if not originalScales[m] then
                        originalScales[m] = m:GetScale()
                    end
                    m:ScaleTo(3.5)
                else
                    -- Restore original size if known
                    if originalScales[m] then
                        m:ScaleTo(originalScales[m])
                    end
                end
            end
        end
    end

    -- Clear saved data if toggled off
    if not hitboxToggled then
        originalScales = {}
    end
end)

local hitboxToggled1 = false
local originalScales1 = {}

main:Button("Redeem Codes", function()
    local args = {
    [1] = "UPDATE1"
}
game:GetService("ReplicatedStorage"):WaitForChild("Util"):WaitForChild("Net"):WaitForChild("RE/RedeemCode"):FireServer(unpack(args))

local args = {
    [1] = "SECRET"
}
game:GetService("ReplicatedStorage"):WaitForChild("Util"):WaitForChild("Net"):WaitForChild("RE/RedeemCode"):FireServer(unpack(args))
end)

main:Section("Autofarm")

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local rootPart = nil
local camera = workspace.CurrentCamera

local followDistance = 10
local heightOffset = -2
local tweenTime = 0.2

local autofollow = false
local followConnection = nil
local currentBird = nil

local selectedBirdType = "All"
local selectedMutation = "Any"
local selectedRarity = "All"
local selectedRegion = "All"
local prioritizeByValue = true

local regions = {
    "All",
    "Beakwoods",
    "Quill Lake",
    "Mount Beaks",
    "Deadlands"
}

local rarityLevels = {
    "All",
    "Common",
    "Uncommon",
    "Rare",
    "Legendary",
    "Mythic"
}

local birdTypes = {
    "All",
    "Normal",
    "Shiny", 
    "Gold",
    "Ghost Hawk",
    "Red Tailed Hawk",
    "Great Egret",
    "Ashwing",
    "Stork",
    "Pelican",
    "Flamingo",
    "Sandhill Crane",
    "Parrot",
    "Crow",
    "Pidgeon",
    "Sparrow",
    "Goldflinch",
    "Bulbul",
    "Hummingbird",
    "Crossbill",
    "Woodpecker",
    "Duck",
    "Black Duck",
    "Black Swan",
    "Swan",
    "Grebes",
    "Shelduck",
    "Mallard Duck",
    "Harris Hawk",
    "Mountain Bluebird",
    "Brown Creeper",
    "Chickadee",
    "Snowfinch",
    "Buzzard",
    "Sparrowhawk",
    "Harpy Eagle",
    "Falcon",
    "Goshawk",
    "Ghost Crow",
    "Skeleton Crow",
    "Raven",
    "Zombie Bird",
    "Skeleton Pidgeon",
    "Skeletal Eagle",
    "Mutant Eagle",
    "Possessed Eagle"
}

local mutationTypes = {
    "Any",
    "None",
    "Albino",
    "Spotted",
    "Gold-Spotted",
    "Rusty",
    "B&W",
    "Two-Toned",
    "Mossy",
    "Stone",
    "Tin",
    "Cherry",
    "Confetti",
    "Clown",
    "Frost",
    "Berserk",
    "Human",
    "Shadow",
    "Striped",
    "Marble",
    "Metallic",
    "Leafy",
    "Purple-Crystal",
    "Green-Crystal",
    "Yellow-Crystal",
    "Zombie",
    "Bio-Luminous",
    "Ruby",
    "Mythical",
    "Timeworm",
    "Lava",
    "Ember",
    "Da Neily",
    "Blossom",
    "Firefly",
    "Cosmic",
    "Angelic"
}

local mutationData = {
    Albino = { PriceMultiplier = 1.1, Rarity = "Common", Chance = 5 },
    Spotted = { PriceMultiplier = 1.1, Rarity = "Common", Chance = 5 },
    ["Gold-Spotted"] = { PriceMultiplier = 1.1, Rarity = "Common", Chance = 3 },
    Rusty = { PriceMultiplier = 1.1, Rarity = "Common", Chance = 3 },
    ["B&W"] = { PriceMultiplier = 1.1, Rarity = "Common", Chance = 3 },
    ["Two-Toned"] = { PriceMultiplier = 1.2, Rarity = "Common", Chance = 3 },
    Mossy = { PriceMultiplier = 1.2, Rarity = "Common", Chance = 3 },
    Stone = { PriceMultiplier = 1.2, Rarity = "Common", Chance = 3 },
    Tin = { PriceMultiplier = 1.2, Rarity = "Common", Chance = 3 },
    Cherry = { PriceMultiplier = 1.3, Rarity = "Common", Chance = 2 },
    Confetti = { PriceMultiplier = 1.3, Rarity = "Common", Chance = 2 },
    Clown = { PriceMultiplier = 1.3, Rarity = "Common", Chance = 2, EventOnly = true },
    Frost = { PriceMultiplier = 1.3, Rarity = "Common", Chance = 2 },
    Berserk = { PriceMultiplier = 2, Rarity = "Rare", Chance = 1 },
    Human = { PriceMultiplier = 2, Rarity = "Rare", Chance = 1 },
    Shadow = { PriceMultiplier = 2, Rarity = "Rare", Chance = 1, EventOnly = true },
    Striped = { PriceMultiplier = 2, Rarity = "Rare", Chance = 1 },
    Marble = { PriceMultiplier = 2.5, Rarity = "Rare", Chance = 0.75 },
    Metallic = { PriceMultiplier = 2.5, Rarity = "Rare", Chance = 0.75 },
    Leafy = { PriceMultiplier = 2.5, Rarity = "Rare", Chance = 0.75 },
    ["Purple-Crystal"] = { PriceMultiplier = 3, Rarity = "Rare", Chance = 0.6 },
    ["Green-Crystal"] = { PriceMultiplier = 3, Rarity = "Rare", Chance = 0.6 },
    ["Yellow-Crystal"] = { PriceMultiplier = 3, Rarity = "Rare", Chance = 0.6 },
    Zombie = { PriceMultiplier = 3, Rarity = "Rare", Chance = 0.6 },
    ["Bio-Luminous"] = { PriceMultiplier = 3.5, Rarity = "Rare", Chance = 0.4 },
    Ruby = { PriceMultiplier = 4, Rarity = "Legendary", Chance = 0.15 },
    Mythical = { PriceMultiplier = 4.5, Rarity = "Legendary", Chance = 0.1 },
    Timeworm = { PriceMultiplier = 4.5, Rarity = "Legendary", Chance = 0.1 },
    Lava = { PriceMultiplier = 5, Rarity = "Legendary", Chance = 0.08 },
    Ember = { PriceMultiplier = 6, Rarity = "Mythic", Chance = 0.05 },
    ["Da Neily"] = { PriceMultiplier = 6, Rarity = "Mythic", Chance = 0.05 },
    Blossom = { PriceMultiplier = 6, Rarity = "Mythic", Chance = 0.01, EventOnly = true },
    Firefly = { PriceMultiplier = 6, Rarity = "Mythic", Chance = 0.01, EventOnly = true },
    Cosmic = { PriceMultiplier = 6.5, Rarity = "Mythic", Chance = 0.01 },
    Angelic = { PriceMultiplier = 7, Rarity = "Mythic", Chance = 0.01, EventOnly = true }
}

local birdData = {}

-- Updated Dropdowns to match the first script's implementation
main:Dropdown("Select Region", regions, function(selected)
    selectedRegion = selected
end)

main:Dropdown("Select Rarity", rarityLevels, function(selected)
    selectedRarity = selected
end)

main:Dropdown("Select Bird Type", birdTypes, function(selected)
    selectedBirdType = selected
end)

main:Dropdown("Select Mutation", mutationTypes, function(selected)
    selectedMutation = selected
end)

-- For toggle, we might need to modify this based on the first script
-- But there was no toggle implementation in the first script
main:Toggle("Prioritize Value", true, function(state)
    prioritizeByValue = state
end)

local function calculateBirdValue(serverBird)
    local basePrice = serverBird:GetAttribute("SellPrice") or 10
    local mutation = serverBird:GetAttribute("Mutation")
    
    if mutation and mutation ~= "None" and mutationData[mutation] then
        return basePrice * mutationData[mutation].PriceMultiplier
    end
    
    return basePrice
end

local function matchesRarityFilter(serverBird)
    if selectedRarity == "All" then
        return true
    end
    
    local birdRarity = serverBird:GetAttribute("Rarity")
    return birdRarity == selectedRarity
end

local function matchesMutationFilter(serverBird)
    if selectedMutation == "Any" then
        return true
    elseif selectedMutation == "None" then
        local mutation = serverBird:GetAttribute("Mutation")
        return mutation == nil or mutation == "None"
    else
        local mutation = serverBird:GetAttribute("Mutation")
        return mutation == selectedMutation
    end
end

local function matchesTypeFilter(serverBird)
    if selectedBirdType == "All" then
        return true
    elseif selectedBirdType == "Normal" then
        local isShiny = serverBird:GetAttribute("Shiny")
        local isGolden = serverBird:GetAttribute("Golden")
        return not isShiny and not isGolden
    elseif selectedBirdType == "Shiny" then
        return serverBird:GetAttribute("Shiny") == true
    elseif selectedBirdType == "Gold" then
        return serverBird:GetAttribute("Golden") == true
    else
        return serverBird:GetAttribute("BirdName") == selectedBirdType
    end
end

local function matchesRegionFilter(region)
    if selectedRegion == "All" then
        return true
    else
        return region.Name == selectedRegion
    end
end

local function getFilteredBirds()
    local filteredBirds = {}
    local birdValues = {}
    
    for _, region in pairs(workspace:WaitForChild("Regions"):GetChildren()) do
        if not matchesRegionFilter(region) then
            continue
        end
        
        local serverFolder = region:FindFirstChild("ServerBirds")
        local clientFolder = region:FindFirstChild("ClientBirds")
        
        if serverFolder and clientFolder then
            for _, serverBird in ipairs(serverFolder:GetChildren()) do
                if matchesTypeFilter(serverBird) and matchesMutationFilter(serverBird) and matchesRarityFilter(serverBird) then
                    local id = serverBird:GetAttribute("Id")
                    if id then
                        for _, clientBird in ipairs(clientFolder:GetChildren()) do
                            if clientBird:GetAttribute("Id") == id then
                                table.insert(filteredBirds, clientBird)
                                
                                if prioritizeByValue then
                                    birdValues[clientBird] = calculateBirdValue(serverBird)
                                end
                                
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    
    if prioritizeByValue and #filteredBirds > 0 then
        table.sort(filteredBirds, function(a, b)
            return (birdValues[a] or 0) > (birdValues[b] or 0)
        end)
    end
    
    return filteredBirds
end

local function findBestBird()
    local birds = getFilteredBirds()
    
    if #birds > 0 then
        return birds[1]
    end
    
    return nil
end

main:Toggle("Auto Catch", false, function(state)
    autofollow = state

    if autofollow then
        local character = player.Character or player.CharacterAdded:Wait()
        rootPart = character:WaitForChild("HumanoidRootPart")
        rootPart.Anchored = true
        
        if followConnection then
            followConnection:Disconnect()
        end

        followConnection = RunService.Heartbeat:Connect(function()
            if not currentBird or not currentBird.Parent then
                currentBird = findBestBird()
                
                if currentBird then
                    local birdRegion = "Unknown"
                    local birdType = "Unknown"
                    local birdMutation = "None"
                    
                    for _, region in pairs(workspace:WaitForChild("Regions"):GetChildren()) do
                        local clientFolder = region:FindFirstChild("ClientBirds")
                        if clientFolder and currentBird:IsDescendantOf(clientFolder) then
                            birdRegion = region.Name
                            break
                        end
                    end
                    
                    local id = currentBird:GetAttribute("Id")
                    if id then
                        for _, region in pairs(workspace:WaitForChild("Regions"):GetChildren()) do
                            local serverFolder = region:FindFirstChild("ServerBirds")
                            if serverFolder then
                                for _, serverBird in ipairs(serverFolder:GetChildren()) do
                                    if serverBird:GetAttribute("Id") == id then
                                        birdType = serverBird:GetAttribute("BirdName") or "Unknown"
                                        birdMutation = serverBird:GetAttribute("Mutation") or "None"
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if currentBird then
                local birdPos = currentBird:IsA("Model") and currentBird:GetPivot().Position or currentBird.Position
                local dir = (birdPos - rootPart.Position).Unit
                local followPos = birdPos - (dir * followDistance)
                followPos = Vector3.new(followPos.X, birdPos.Y + heightOffset, followPos.Z)

                local tweenGoal = {CFrame = CFrame.new(followPos, birdPos)}
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                TweenService:Create(rootPart, tweenInfo, tweenGoal):Play()

                local cameraLookAt = birdPos
                camera.CFrame = CFrame.new(camera.CFrame.Position, cameraLookAt)
            end
        end)
    else
        if followConnection then
            followConnection:Disconnect()
            followConnection = nil
        end
        
        if rootPart then
            rootPart.Anchored = false
        end
        
        currentBird = nil
    end
end)

main:Section("Configuration")

-- Updated Sliders to match the first script's implementation
main:Slider("Follow Distance", 10, 20, followDistance, function(value)
    followDistance = value
end)

main:Slider("Height Offset", -2, 10, heightOffset, function(value)
    heightOffset = value
end)

main:Slider("Tween Speed", 0.2, 2, tweenTime, function(value)
    tweenTime = value
end)

local excludeEventMutations = false
main:Toggle("Exclude Event Mutations", false, function(state)
    excludeEventMutations = state
end)

local function isValidBird(bird)
    if not bird or not bird.Parent then
        return false
    end
    
    if not bird:GetAttribute("Id") then
        return false
    end
    
    if excludeEventMutations then
        local id = bird:GetAttribute("Id")
        for _, region in pairs(workspace:WaitForChild("Regions"):GetChildren()) do
            local serverFolder = region:FindFirstChild("ServerBirds")
            if serverFolder then
                for _, serverBird in ipairs(serverFolder:GetChildren()) do
                    if serverBird:GetAttribute("Id") == id then
                        local mutation = serverBird:GetAttribute("Mutation")
                        if mutation and mutationData[mutation] and mutationData[mutation].EventOnly then
                            return false
                        end
                    end
                end
            end
        end
    end
    
    return true
end

main:Section("Sell")

local autoSell = false
local autoSellThread = nil

main:Toggle("Auto Sell", false, function(state)
    autoSell = state

    if autoSell then
        autoSellThread = task.spawn(function()
            while autoSell do
                local args = { [1] = "All" }
                game:GetService("ReplicatedStorage"):WaitForChild("Util", 9e9)
                    :WaitForChild("Net", 9e9)
                    :WaitForChild("RF/SellInventory", 9e9):InvokeServer(unpack(args))
                task.wait(2) -- Adjust delay as needed
            end
        end)
    else
        autoSell = false
    end
end)

main:Button("Sell All", function()
    local args = {
        [1] = "All"; 
    }

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Util = ReplicatedStorage:WaitForChild("Util", 9e9)
    local Net = Util:WaitForChild("Net", 9e9)
    local SellInventory = Net:WaitForChild("RF/SellInventory", 9e9)

    SellInventory:InvokeServer(unpack(args))
end)

main:Button("Sell Selected", function()
    local args = {
        [1] = "Selected";
    }

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Util = ReplicatedStorage:WaitForChild("Util", 9e9)
    local Net = Util:WaitForChild("Net", 9e9)
    local SellInventory = Net:WaitForChild("RF/SellInventory", 9e9)

    SellInventory:InvokeServer(unpack(args))
end)

main:Section("Teleport")

local teleportLocations = {
    "Beakwoods",
    "Mount Beaks",
    "Quill Lake",
    "Deadlands",
    "Safezone"
}

local function teleportTo(position)
    local character = game.Players.LocalPlayer.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(position)
        end
    end
end

-- Create the dropdown for teleport locations
main:Dropdown("Teleport Location", teleportLocations, function(selected)
    if selected == "Beakwoods" then
        teleportTo(Vector3.new(529, 157, 69))
    elseif selected == "Mount Beaks" then
        teleportTo(Vector3.new(84, 237, 379))
    elseif selected == "Quill Lake" then
        teleportTo(Vector3.new(-312, 155, -481))
    elseif selected == "Deadlands" then
        teleportTo(Vector3.new(-755, 143, -1304))
    elseif selected == "Safezone" then
        teleportTo(Vector3.new(131, 3, -262))
    end
end)

main:Section("Darts")
-- Get all available darts from the Darts module
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DartsModule = require(ReplicatedStorage:WaitForChild("Configuration"):WaitForChild("Darts"))

-- Create dart options for dropdown
local dartOptions = {}
for dartName, dartInfo in pairs(DartsModule) do
    if dartInfo.Price then -- Skip Default dart which has no price
        table.insert(dartOptions, dartName .. " (" .. dartInfo.Price .. "$)")
    end
end

-- Sort dart options by price
table.sort(dartOptions, function(a, b)
    local priceA = tonumber(string.match(a, "%((%d+)%$%)"))
    local priceB = tonumber(string.match(b, "%((%d+)%$%)"))
    return priceA < priceB
end)

-- Map dropdown selections to actual dart names
local dartNameMap = {}
for _, option in ipairs(dartOptions) do
    local dartName = string.match(option, "^(.+) %(")
    dartNameMap[option] = dartName
end

-- Cache the remote function reference
local Util = ReplicatedStorage:WaitForChild("Util", 9e9)
local Net = Util:WaitForChild("Net", 9e9)
local BuyDart = Net:WaitForChild("RF/BuyDart", 9e9)

-- Selected dart and quantity variables
local selectedDart = nil
local selectedQuantity = 1

-- Quantity options
local quantityOptions = {"1", "5", "10"}

-- Create the dropdown for dart selections
main:Dropdown("Dart Types", dartOptions, function(selected)
    selectedDart = dartNameMap[selected]
end)

-- Create the dropdown for quantity selections
main:Dropdown("Quantity", quantityOptions, function(selected)
    selectedQuantity = tonumber(selected)
end)

-- Create the buy button
main:Button("Purchase Darts", function()
    if selectedDart then
        local args = {
            [1] = selectedDart, 
            [2] = selectedQuantity
        }
        BuyDart:InvokeServer(unpack(args))
    end
end)

-- Get the guns module from ReplicatedStorage
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Util = ReplicatedStorage:WaitForChild("Util", 9e9)
local Net = Util:WaitForChild("Net", 9e9)
local GunShop = Net:WaitForChild("RF/GunShop", 9e9)
local Configuration = ReplicatedStorage:WaitForChild("Configuration", 9e9)
local GunsModule = require(Configuration:WaitForChild("Guns", 9e9))

-- Organize guns by region
local gunsByRegion = {
    ["Beakwoods"] = {},
    ["Quill Lake"] = {},
    ["Mount Beaks"] = {},
    ["Deadlands"] = {}
}

-- Populate guns by region with simplified display names (no region or rarity)
for gunName, gunData in pairs(GunsModule) do
    local region = gunData.Region
    if region and gunsByRegion[region] then
        local price = gunData.Price or 0
        local formattedPrice = price > 0 and "("..tostring(price).."$)" or "(Default)"
        local level = gunData.Level and " Lv."..tostring(gunData.Level) or ""
        -- Removed rarity from here
        table.insert(gunsByRegion[region], {
            name = gunName,
            displayName = gunName.." "..formattedPrice..level -- Removed rarity
        })
    end
end

-- Create section for guns
main:Section("Guns")

-- Prepare dropdown options
local selectedGun = nil
local allGunOptions = {}

-- Add guns to options list WITHOUT region prefix
local function addGunsToOptions(region, guns)
    for _, gun in ipairs(guns) do
        table.insert(allGunOptions, {
            display = gun.displayName, -- Removed region prefix
            name = gun.name
        })
    end
end

-- Populate all gun options
for region, guns in pairs(gunsByRegion) do
    addGunsToOptions(region, guns)
end

-- Create dropdown options list
local dropdownOptions = {}
for _, gunOption in ipairs(allGunOptions) do
    table.insert(dropdownOptions, gunOption.display)
end

-- Fixed Dropdown implementation
local gunDropdown = main:Dropdown("Select Gun", dropdownOptions, function(selected)
    for _, gunOption in ipairs(allGunOptions) do
        if gunOption.display == selected then
            selectedGun = gunOption.name
            break
        end
    end
end)

-- Button to purchase the selected gun
main:Button("Purchase Selected Gun", function()
    if selectedGun then
        local args = {
            [1] = "BuyGun",
            [2] = selectedGun
        }
        GunShop:InvokeServer(unpack(args))
    end
end)


main:Section("Appraise")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- References
local LocalPlayer = Players.LocalPlayer
local Net = ReplicatedStorage:WaitForChild("Util"):WaitForChild("Net")
local getPrice = Net:FindFirstChild("RF/GetPriceOfBird")
local appraise = Net:FindFirstChild("RF/ThrowInWishingWell")

-- Variables
local isAutoAppraising = false
local autoAppraiseLoop = nil
local backpackConnection = nil
local isProcessingAppraisal = false
local initialEquipDone = false
local lastProcessedBird = nil

-- Filter Variables
local selectedMutation = "Any"
local requireShiny = false
local requireGolden = false

-- Mutation List
local mutationTypes = {
    "Any",
    "None",
    "Albino",
    "Spotted",
    "Gold-Spotted",
    "Rusty",
    "B&W",
    "Two-Toned",
    "Mossy",
    "Stone",
    "Tin",
    "Cherry",
    "Confetti",
    "Clown",
    "Frost",
    "Berserk",
    "Human",
    "Shadow",
    "Striped",
    "Marble",
    "Metallic",
    "Leafy",
    "Purple-Crystal",
    "Green-Crystal",
    "Yellow-Crystal",
    "Zombie",
    "Bio-Luminous",
    "Ruby",
    "Mythical",
    "Timeworm",
    "Lava",
    "Ember",
    "Da Neily",
    "Blossom",
    "Firefly",
    "Cosmic",
    "Angelic"
}

-- Function to get equipped bird information
local function getEquippedBirdInfo()
    -- Check character for equipped tool (bird)
    local Character = LocalPlayer.Character
    if not Character then return nil end
    
    -- Find equipped tool in character
    local equippedBird = Character:FindFirstChildOfClass("Tool")
    if equippedBird and equippedBird:GetAttribute("ItemType") == "Bird" then
        return equippedBird.Name, equippedBird -- Return bird ID and the bird object
    end
    
    return nil, nil
end

-- Function to check if bird meets our filter criteria
local function birdMeetsCriteria(birdObject)
    if not birdObject then return false end
    
    -- Check mutation criteria
    local mutation = birdObject:GetAttribute("Mutation") or "None"
    if selectedMutation ~= "Any" and mutation ~= selectedMutation then
        return false
    end
    
    -- Check shiny criteria
    if requireShiny and not birdObject:GetAttribute("Shiny") then
        return false
    end
    
    -- Check golden criteria
    if requireGolden and not birdObject:GetAttribute("Golden") then
        return false
    end
    
    return true
end

-- Function to equip a tool
local function equipTool(tool)
    if not tool then return false end
    
    local Character = LocalPlayer.Character
    if not Character then return false end
    
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return false end
    
    -- Equip the tool
    Humanoid:EquipTool(tool)
    return true
end

-- Function to check for birds in backpack and equip one if found
local function checkBackpack()
    if initialEquipDone then return false end
    
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if not Backpack then return false end
    
    for _, item in pairs(Backpack:GetChildren()) do
        if item:IsA("Tool") and item:GetAttribute("ItemType") == "Bird" then
            -- Skip the last processed bird if it exists
            if lastProcessedBird and item.Name == lastProcessedBird then
                continue
            end
            
            equipTool(item)
            initialEquipDone = true
            return true
        end
    end
    
    return false
end

-- Function to find any bird in backpack and equip it
local function findAndEquipAnyBird()
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if not Backpack then return false end
    
    for _, item in pairs(Backpack:GetChildren()) do
        if item:IsA("Tool") and item:GetAttribute("ItemType") == "Bird" then
            equipTool(item)
            return true
        end
    end
    
    return false
end

-- Setup backpack connection to detect when birds are added
local function setupBackpackConnection()
    -- Clean up existing connection if any
    if backpackConnection then
        backpackConnection:Disconnect()
        backpackConnection = nil
    end
    
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if not Backpack then return end
    
    backpackConnection = Backpack.ChildAdded:Connect(function(child)
        if not isAutoAppraising then return end
        
        -- Check if the added item is a bird
        if child:IsA("Tool") and child:GetAttribute("ItemType") == "Bird" then
            -- Check if it meets our criteria
            if birdMeetsCriteria(child) then
                -- This is a bird we want to keep - stop auto-appraising
                isAutoAppraising = false
                
                -- Clean up the loop
                if autoAppraiseLoop then
                    autoAppraiseLoop:Disconnect()
                    autoAppraiseLoop = nil
                end
                
                -- Clean up backpack connection
                if backpackConnection then
                    backpackConnection:Disconnect()
                    backpackConnection = nil
                end
                
                -- Equip the bird we want to keep
                task.wait(0.2)
                equipTool(child)
                return
            end
            
            -- Only equip if we're in the middle of processing an appraisal
            if isProcessingAppraisal then
                task.wait(0.2) -- Small delay to ensure item is fully ready
                equipTool(child)
                
                -- Mark appraisal as complete
                isProcessingAppraisal = false
            end
        end
    end)
end

-- Function to appraise a bird
local function appraiseBird(birdId)
    if not birdId then return false end
    
    -- Save the current bird ID to avoid re-appraising immediately
    lastProcessedBird = birdId
    
    -- Set processing flag
    isProcessingAppraisal = true
    
    -- Get price first
    local success, price = pcall(function()
        return getPrice:InvokeServer(birdId)
    end)
    
    -- If getting price failed, reset state
    if not success then
        isProcessingAppraisal = false
        return false
    end
    
    -- Wait a bit
    task.wait(0.5)
    
    -- Appraise the bird
    local appraiseSuccess = pcall(function()
        return appraise:InvokeServer(birdId)
    end)
    
    -- If appraisal failed, reset state
    if not appraiseSuccess then
        isProcessingAppraisal = false
        return false
    end
    
    -- Wait longer for the bird to return - up to 10 seconds
    local startWaitTime = tick()
    while isProcessingAppraisal and tick() - startWaitTime < 10 do
        task.wait(0.5)
        
        -- Check if we already have a bird equipped (might be a different one)
        local currentBird = getEquippedBirdInfo()
        if currentBird then
            isProcessingAppraisal = false
            break
        end
    end
    
    -- If we're still processing after timeout
    if isProcessingAppraisal then
        isProcessingAppraisal = false
        
        -- Try to find and equip any bird
        findAndEquipAnyBird()
    end
    
    return true
end

-- Dropdown for mutation selection
main:Dropdown("Stop on Mutation", mutationTypes, function(selected)
    selectedMutation = selected
end)

-- Toggle for shiny requirement
main:Toggle("Require Shiny", false, function(state)
    requireShiny = state
end)

-- Toggle for golden requirement
main:Toggle("Require Golden", false, function(state)
    requireGolden = state
end)

-- Single toggle for auto-appraise in main section
main:Toggle("Auto Appraise", false, function(state)
    isAutoAppraising = state
    
    if isAutoAppraising then
        -- Reset flags
        isProcessingAppraisal = false
        initialEquipDone = false
        lastProcessedBird = nil
        
        -- Setup backpack monitoring first thing
        setupBackpackConnection()
        
        -- Cancel existing loop if there is one
        if autoAppraiseLoop then
            autoAppraiseLoop:Disconnect()
            autoAppraiseLoop = nil
        end
        
        -- Check if we have a bird equipped at the start
        local initialBirdId, birdObject = getEquippedBirdInfo()
        if initialBirdId then
            -- Check if the currently equipped bird meets criteria
            if birdMeetsCriteria(birdObject) then
                isAutoAppraising = false
                return
            end
            
            initialEquipDone = true
        else
            checkBackpack()
        end
        
        -- Start the auto-appraise loop
        local lastAppraiseTime = 0
        autoAppraiseLoop = game:GetService("RunService").Heartbeat:Connect(function()
            local currentTime = tick()
            
            -- Don't proceed if we're currently processing an appraisal
            if isProcessingAppraisal then return end
            
            -- If we haven't done initial equip yet, try again
            if not initialEquipDone then
                checkBackpack()
            end
            
            if currentTime - lastAppraiseTime >= 3 and not isProcessingAppraisal then  -- 3 second interval
                -- Get current equipped bird ID
                local currentBirdId, birdObject = getEquippedBirdInfo()
                
                if currentBirdId then
                    -- Check if the current bird meets our criteria before appraising
                    if birdMeetsCriteria(birdObject) then
                        -- We found a bird that meets criteria - stop auto-appraising
                        isAutoAppraising = false
                        
                        -- Clean up the loop
                        if autoAppraiseLoop then
                            autoAppraiseLoop:Disconnect()
                            autoAppraiseLoop = nil
                        end
                        
                        -- Clean up backpack connection
                        if backpackConnection then
                            backpackConnection:Disconnect()
                            backpackConnection = nil
                        end
                    else
                        -- Process the appraisal for this bird since it doesn't meet criteria
                        local success = appraiseBird(currentBirdId)
                        lastAppraiseTime = currentTime
                    end
                else
                    -- Try to find and equip any bird
                    findAndEquipAnyBird()
                    lastAppraiseTime = currentTime -- Update time anyway to prevent spamming
                end
            end
        end)
    else
        isProcessingAppraisal = false
        
        -- Clean up the loop
        if autoAppraiseLoop then
            autoAppraiseLoop:Disconnect()
            autoAppraiseLoop = nil
        end
        
        -- Clean up backpack connection
        if backpackConnection then
            backpackConnection:Disconnect()
            backpackConnection = nil
        end
    end
end)

main:Button("Appraise Equipped Bird", function()
	local Character = game:GetService("Players").LocalPlayer.Character
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Net = ReplicatedStorage:WaitForChild("Util"):WaitForChild("Net")

	local getPrice = Net:FindFirstChild("RF/GetPriceOfBird")
	local appraise = Net:FindFirstChild("RF/ThrowInWishingWell")

	getPrice:InvokeServer() -- Optional: you can store or print this if needed
	wait(0.5)
	appraise:InvokeServer()
end)

--// Misc
main:Section("Other")
main:Button("Rejoin", function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService'Players'.LocalPlayer)
end)
-- Simple Anti-AFK Script for Roblox
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variable to track if anti-AFK is enabled
local antiAFKEnabled = false

-- Function for the toggle button
local function AntiAFK(state)
    antiAFKEnabled = state
    
    if antiAFKEnabled then
        -- Connect to the Idled event
        LocalPlayer.Idled:Connect(function()
            if antiAFKEnabled then
                -- Simulate mouse click to prevent AFK kick
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(), workspace.CurrentCamera.CFrame)
            end
        end)
       
    else
        
    end
end

-- For UI integration
main:Toggle("Anti-AFK", false, function(state)
    AntiAFK(state)
end)
main:Bind("Toggle Ui", Enum.KeyCode.E, function(arg)
    if game:GetService("CoreGui").intern.Enabled == true then
        game:GetService("CoreGui").intern.Enabled = false
    else
        game:GetService("CoreGui").intern.Enabled = true
    end
end)
main:Label("made by 0o4o")