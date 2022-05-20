# Intern
This documentation is for the stable use of Intern Library.

## Booting the Library
```lua
local InternLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/nightwtf/Intern/main/source')))()
```

## Creating a Window
```lua
local Window = InternLib:CreateWindow("Title of the Library")

--[[
name = <string> - The name of the UI.
]]
```

## Creating a Button
```lua
Window:Button("Name of the Button", function()
    
end)

--[[
name = <string> - The name of the UI.
function = <function> - The function of the Button.
]]
```

## Creating a Toggle
```lua
Window:Toggle("Name of the Toggle", true, function(arg)
    
end)

--[[
name = <string> - The name of the UI.
bool = <bool> - Default Value for the toggle.
function = <function> - The function of the toggle.
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
name = <string> - The name of the UI.
]]
```

## Creating a TextBox
```lua
Window:TextBox("Name of the TextBox", true, function(arg)

end)

--[[
name = <string> - The name of the UI.
bool = <bool> - If the text should disappear after FocusLost.
function = <function> - The function of the textbox.
arg = <bool> - The value of the textbox.
]]
```
