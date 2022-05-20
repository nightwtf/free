# Intern
This documentation is for the stable use of Intern Library.

## Booting the Library
```lua
local InternLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/nightwtf/Intern/main/source')))()
```

## Creating a Window
```lua
local Window = InternLib:CreateWindow("Title of the Library",)

--[[
Name = <string> - The name of the UI.
Rainbow = <bool> - Whether or not the user details shows Premium status or not.
]]
```

## Creating a Button
```lua
Window:Button("Name of the Button", function()
    
end)

--[[
Name = <string> - The name of the UI.
function() = <function> - The function of the Button.
]]
```

## Creating a Toggle
```lua
Window:Toggle("Name of the Toggle", function(arg)
    
end)

--[[
Name = <string> - The name of the UI.
function() = <function> - The function of the toggle.
arg = <bool> - The value of the toggle.
]]
```

## Creating a Keybind
```lua
Window:Bind()
```

## Creating a Section
```lua
Window:Section("Name of the Section")

--[[
Name = <string> - The name of the UI.
]]
```
