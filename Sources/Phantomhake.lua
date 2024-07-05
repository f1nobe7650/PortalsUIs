-- // UI supports
-- SynX, Electron, Scriptware?, KRNL?
-- Leak and i slit your throat :)
local Decode = (syn and syn.crypt.base64.decode) or (crypt and crypt.base64decode) or base64_decode;
local Library = {
    Open = true;
    Relations = {};
    Folders = {
        main = "test";
        configs = "test/Configs";
    };
    Pages = {};
    Sections = {};
    Flags = {};
    UnNamedFlags = 0;
    Objects = {};
    ThemeObjects = {Objects = {}; Outlines = {}};
    Text = {};
    Themes = {
        ["Default"] = {["Accent"] = Color3.fromRGB(121, 68, 155);["Border1"] = Color3.fromRGB(10, 10, 10);["Border2"] = Color3.fromRGB(45, 45, 45);["Light Contrast"] = Color3.fromRGB(30, 30, 30);["Dark Contrast"] = Color3.fromRGB(20, 20, 20);["Text"] = Color3.fromRGB(175,175,175);["Light Text"] = Color3.fromRGB(255, 255, 255);};
        ["Old"] = {["Accent"] = Color3.fromRGB(82, 131, 255);["Border1"] = Color3.fromRGB(0,0,0);["Border2"] = Color3.fromRGB(50,50,50);["Light Contrast"] = Color3.fromRGB(30,30,30);["Dark Contrast"] = Color3.fromRGB(24,24,24);["Text"] = Color3.fromRGB(175,175,175);["Light Text"] = Color3.fromRGB(255,255,255);};
        ["Entrophy"] = {["Accent"] = Color3.fromRGB(129, 187, 233);["Border1"] = Color3.fromRGB(10, 10, 10);["Border2"] = Color3.fromRGB(76, 74, 82);["Light Contrast"] = Color3.fromRGB(61, 58, 67);["Dark Contrast"] = Color3.fromRGB(48, 47, 55);["Text"] = Color3.fromRGB(175,175,175);["Light Text"] = Color3.fromRGB(220, 220, 220);};
        ["Fatality"] = {["Accent"] = Color3.fromRGB(240, 15, 80);["Border1"] = Color3.fromRGB(15, 15, 40);["Border2"] = Color3.fromRGB(50, 40, 80);["Light Contrast"] = Color3.fromRGB(35, 25, 70);["Dark Contrast"] = Color3.fromRGB(25, 20, 50);["Text"] = Color3.fromRGB(175,175,175);["Light Text"] = Color3.fromRGB(200, 200, 255);};
    };
    Images = {
        ["Arrow_Down"] = Decode("iVBORw0KGgoAAAANSUhEUgAAABQAAAAPCAYAAADkmO9VAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAABoSURBVDhP7dBBCsAgDETR6LHs/XutNtMxi4BI1Cz7oFQw+QvLoyRR7f80CF48niuq6nfrOSPqG/qUDe+5qfWMhwveLxnHDAY4FzKPGQxyfioWM1jg3tBazGCR+85ezCDAzucs9gsQeQHFvhGzmKvF1QAAAABJRU5ErkJggg==");
        ["Arrow_Up"] = Decode("iVBORw0KGgoAAAANSUhEUgAAABQAAAALCAYAAAB/Ca1DAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABYSURBVDhPxc7RDsAQDIXh9v0feoYe2eipbST7LyiSL+SXDsuOYWo7rYf0zEa38JH9KkLpA8MQQ93LGYY8dLh4iqEevR3eYuiKtuErhoCWZRVDGdVdWE0kAV2EK/50sUCyAAAAAElFTkSuQmCC");
    };
    AllowedCharacters = {
        [1] = ' ',
        [2] = '!',
        [3] = '"',
        [4] = '#',
        [5] = '$',
        [6] = '%',
        [7] = '&',
        [8] = "'",
        [9] = '(',
        [10] = ')',
        [11] = '*',
        [12] = '+',
        [13] = ',',
        [14] = '-',
        [15] = '.',
        [16] = '/',
        [17] = '0',
        [18] = '1',
        [19] = '2',
        [20] = '3',
        [21] = '4',
        [22] = '5',
        [23] = '6',
        [24] = '7',
        [25] = '8',
        [26] = '9',
        [27] = ':',
        [28] = ';',
        [29] = '<',
        [30] = '=',
        [31] = '>',
        [32] = '?',
        [33] = '@',
        [34] = 'A',
        [35] = 'B',
        [36] = 'C',
        [37] = 'D',
        [38] = 'E',
        [39] = 'F',
        [40] = 'G',
        [41] = 'H',
        [42] = 'I',
        [43] = 'J',
        [44] = 'K',
        [45] = 'L',
        [46] = 'M',
        [47] = 'N',
        [48] = 'O',
        [49] = 'P',
        [50] = 'Q',
        [51] = 'R',
        [52] = 'S',
        [53] = 'T',
        [54] = 'U',
        [55] = 'V',
        [56] = 'W',
        [57] = 'X',
        [58] = 'Y',
        [59] = 'Z',
        [60] = '[',
        [61] = "\\",
        [62] = ']',
        [63] = '^',
        [64] = '_',
        [65] = '`',
        [66] = 'a',
        [67] = 'b',
        [68] = 'c',
        [69] = 'd',
        [70] = 'e',
        [71] = 'f',
        [72] = 'g',
        [73] = 'h',
        [74] = 'i',
        [75] = 'j',
        [76] = 'k',
        [77] = 'l',
        [78] = 'm',
        [79] = 'n',
        [80] = 'o',
        [81] = 'p',
        [82] = 'q',
        [83] = 'r',
        [84] = 's',
        [85] = 't',
        [86] = 'u',
        [87] = 'v',
        [88] = 'w',
        [89] = 'x',
        [90] = 'y',
        [91] = 'z',
        [92] = '{',
        [93] = '|',
        [94] = '}',
        [95] = '~'
    };
    ShiftCharacters = {
        ["1"] = "!",
        ["2"] = "@",
        ["3"] = "#",
        ["4"] = "$",
        ["5"] = "%",
        ["6"] = "^",
        ["7"] = "&",
        ["8"] = "*",
        ["9"] = "(",
        ["0"] = ")",
        ["-"] = "_",
        ["="] = "+",
        ["["] = "{",
        ["\\"] = "|",
        [";"] = ":",
        ["'"] = "\"",
        [","] = "<",
        ["."] = ">",
        ["/"] = "?",
        ["`"] = "~"
    };
    Keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3"
    };
};

-- // Ignores
local Flags = {}; -- Ignore
local Dropdowns = {}; -- Ignore
local Icons = {}; -- Ignore
local Pickers = {}; -- Ignore
Library.Theme = table.clone(Library.Themes["Old"]);

-- // Extension
local Render = loadstring(game:HttpGet("https://gist.githubusercontent.com/notportal/17d44958f38f00d9aeca86c59171a896/raw/ac588beb1ebf53a27a098aca28e2b5125e7e6d6b/newextension.lua"))();
Library.__index = Library;
Library.Pages.__index = Library.Pages;
Library.Sections.__index = Library.Sections;

-- // Functions
do -- Rendering
    function Library:NewDrawing(class, properties, no_cache)
        properties = properties or {}

        local object = Render:new(class)

        if not no_cache then
            Library.Objects[object] = object
        end

        if class == "Text" then
            Library.Text[object] = object
        end

        for property, value in next, properties do
            if property == "Theme" then
                Library.ThemeObjects.Objects[object] = value
                property = "Color"
                value = Library.Theme[value]
            end

            object[property] = value
        end

        return object
    end;
    --
    function Library:NewOutline(obj, color, zin, ignore)
        local outline = Render:new("Square")
        if not no_cache then
            Library.Objects[outline] = outline
        end
        outline.Parent = obj
        outline.Size = UDim2.new(1, 2, 1, 2)
        outline.Position = UDim2.new(0, -1, 0, -1)
        outline.ZIndex = zin or obj.ZIndex - 1

        if typeof(color) == "Color3" then
            outline.Color = color
        else
            outline.Color = Library.Theme[color]
            Library.ThemeObjects.Objects[outline] = color
        end

        outline.Parent = obj
        outline.Filled = false
        outline.Thickness = 1

        return outline
    end;
end;
--
do -- Misc Functions
    function Library:Connection(Signal, Callback)
        local Con = Signal:Connect(Callback)
        return Con
    end;
    --
    function Library:Disconnect(Connection)
        Connection:Disconnect()
    end;
    --
    function Library:Round(Number, Float)
        return Float * math.floor(Number / Float);
    end;
    --
    function Library:Flag()
        Library.UnNamedFlags = Library.UnNamedFlags + 1
        print(string.format("%.14g", Library.UnNamedFlags))
        return string.format("%.14g", Library.UnNamedFlags)
    end;
    --
    function Library:LoadTheme(ThemeType, Themes)
        if Themes[ThemeType] then
            local ThemeValue = game.HttpService:JSONDecode(Themes[ThemeType][2])
            
            for Index, Value in pairs(ThemeValue) do
                Library:ChangeThemeColor(Index, Color3.fromHex(Value));
            end;
        end;
    end;
    --
    function Library:ChangeObjectTheme(Object, Color)
        Library.ThemeObjects.Objects[Object] = Color
        Object.Color = Library.Theme[Color]
    end;
    --
    function Library:ChangeThemeColor(Option, Color)
        self.Theme[Option] = Color

        for obj, theme in next, Library.ThemeObjects.Objects do
            if rawget(obj, "exists") == true and theme == Option then
                obj.Color = Color
            end
        end
    end;
    --
    function Library:GetTextLength(str, font, fontsize)
        local text = Drawing.new("Text")
        text.Text = str
        text.Font = font
        text.Size = fontsize

        local textbounds = text.TextBounds
        text:Remove()

        return textbounds
    end;
    --
    function Library:RGBA(r, g, b, alpha)
        local rgb = Color3.fromRGB(r, g, b)
        local mt = table.clone(getrawmetatable(rgb))
        
        setreadonly(mt, false)
        local old = mt.__index
        
        mt.__index = newcclosure(function(self, key)
            if key == "Transparency" then
                return alpha
            end
            
            return old(self, key)
        end)
        
        setrawmetatable(rgb, mt)
        
        return rgb
    end;
    --
    function Library:WrapText(Text, Size)
        local Max = (Size / 7)
        --
        return Text:sub(0, Max)
    end;
    --
    function Library:GetConfig()
        local Config = "";
        for Index, Value in pairs(self.Flags) do
            if Index ~= "ConfigConfig_List" and Index ~= "ConfigConfig_Load" and Index ~= "ConfigConfig_Save" then
                local Value2 = Value
                local Final = ""
                --
                if typeof(Value2) == "Color3" then
                    local hue, sat, val = Value2:ToHSV();
                    --
                    Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, Value2.Transparency)
                elseif typeof(Value2) == "table" and Value2.Color and Value2.Transparency then
                    local hue, sat, val = Value2.Color:ToHSV()
                    --
                    Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, Value2.Transparency)
                elseif typeof(Value2) == "table" and Value.Mode then
                    local Values = Value.current
                    --
                    Final = ("key(%s,%s,%s)"):format(Values[1] or "nil", Values[2] or "nil", Value.Mode)
                elseif (Value2 ~= nil) then
                    if typeof(Value2) == "boolean" then
                        Value2 = ("bool(%s)"):format(tostring(Value2))
                    elseif typeof(Value2) == "table" then
                        local New = "table("
                        --
                        for Index2, Value3 in pairs(Value2) do
                            New = New .. Value3 .. ","
                        end
                        --
                        if New:sub(#New) == "," then
                            New = New:sub(0, #New - 1)
                        end
                        --
                        Value2 = New .. ")"
                    elseif typeof(Value2) == "string" then
                        Value2 = ("string(%s)"):format(Value2)
                    elseif typeof(Value2) == "number" then
                        Value2 = ("number(%s)"):format(Value2)
                    end
                    --
                    Final = Value2
                end
                --
                Config = Config .. Index .. ": " .. Final .. "\n"
            end
        end
        --
        return Config
    end;
    --
    function Library:LoadConfig(Config)
        local Table = string.split(Config, "\n")
        local Table2 = {};
        for Index, Value in pairs(Table) do
            local Table3 = string.split(Value, ":")
            --
            if Table3[1] ~= "ConfigConfig_List" and #Table3 >= 2 then
                local Value = Table3[2]:sub(2, #Table3[2])
                --
                if Value:sub(1, 3) == "rgb" then
                    local Table4 = string.split(Value:sub(5, #Value - 1), ",")
                    --
                    Value = Table4
                elseif Value:sub(1, 3) == "key" then
                    local Table4 = string.split(Value:sub(5, #Value - 1), ",")
                    --
                    if Table4[1] == "nil" and Table4[2] == "nil" then
                        Table4[1] = nil
                        Table4[2] = nil
                    end
                    --
                    Value = Table4
                elseif Value:sub(1, 4) == "bool" then
                    local Bool = Value:sub(6, #Value - 1)
                    --
                    Value = Bool == "true"
                elseif Value:sub(1, 5) == "table" then
                    local Table4 = string.split(Value:sub(7, #Value - 1), ",")
                    --
                    Value = Table4
                elseif Value:sub(1, 6) == "string" then
                    local String = Value:sub(8, #Value - 1)
                    --
                    Value = String
                elseif Value:sub(1, 6) == "number" then
                    local Number = tonumber(Value:sub(8, #Value - 1))
                    --
                    Value = Number
                end
                --
                Table2[Table3[1]] = Value
            end
        end
        --             
        for i,v in pairs(Table2) do
            if Flags[i] then
                if typeof(Flags[i]) == "table" then
                    Flags[i]:Set(v);
                else
                    Flags[i](v);
                end
            end;
        end;
    end;
end;
--
do -- Elemental Functions
    function Library:NewPicker(text, default, defaultalpha, parent, count, flag, callback, offset)
        local icon = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Color = default,
            Parent = parent,
            Transparency = 1,
            Size = UDim2.new(0, 20, 0, 10),
            Position = UDim2.new(1, -30 - (count * 17) - (count * 6), 0, 4 + offset),
            ZIndex = 55
        })
        local alphaicon = Library:NewDrawing("Image", {
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 61,
            Parent = icon,
            Data = Decode("iVBORw0KGgoAAAANSUhEUgAAABIAAAAKBAMAAABLZROSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAGUExURb+/v////5nD/3QAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAVSURBVBjTY2AQhEIkliAWSLY6QQYAknwC7Za+1vYAAAAASUVORK5CYII=")
        })

        local InnerOutline = Library:NewOutline(icon, "Border1", 55);

        Library:Connection(icon.MouseEnter, function()
            Library:ChangeObjectTheme(InnerOutline, "Accent")
        end)
        Library:Connection(icon.MouseLeave, function()
            Library:ChangeObjectTheme(InnerOutline, "Border1")
        end)

        local window = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Parent = icon,
            Theme = "Dark Contrast",
            Size = UDim2.new(0, 206, 0, 200),
            Visible = false,
            Position = UDim2.new(1, -185 + (count * 20) + (count * 6), 1, 6),
            ZIndex = 60
        })

        table.insert(Pickers, window)

        local outline1 = Library:NewOutline(window, "Border1", 66)
        Library:NewOutline(outline1, "Border2", 66)

        local Title = Library:NewDrawing("Text", {
            Text = text;
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 4, 0, 2);
            Parent = window;
            ZIndex = 66;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = text;
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 5, 0, 3);
            Parent = window;
            ZIndex = 65;
        });

        local saturation = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Parent = window,
            Color = default,
            Size = UDim2.new(0, 154, 0, 150),
            Position = UDim2.new(0, 6, 0, 20),
            ZIndex = 66
        })

        local satoutline = Library:NewOutline(saturation, "Border2",66)
        Library:NewOutline(satoutline, "Border1", 65)

        Library:NewDrawing("Image", {
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 66,
            Parent = saturation,
            Data = Decode("iVBORw0KGgoAAAANSUhEUgAAAJYAAACWCAYAAAA8AXHiAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAE5zSURBVHhe7Z3rimV7Uu1r7do2iog2KqIoqIi0l9b+oDRNi4gIoiAi+D7Hp/IJ/KgiitDeaES839u71uWM35hjRMacuTKratseDpwTECsiRoyI/3XNtTKzdvft1atXb168ePFWiq0+Fz/lV5HX0nfx7uUHu91uT+Yu/j3sOe778hDWMXmEeckMVrtx+VDL2bzJhU/da+yVB/by5cs3r1+/HnyPIX3x0Ucf2UfgUgP/448/Nkb+v/7rv95+zdd8jS1c/P/8z/+cceBQS+//+I//YJGvhb1VuTkI/VTjsRkDvrhw3nzLt3zLmz/5kz958+lPf/rN7/3e7739sz/7sze/+Iu/+OZGgRrMQFHqPVhjLODCBq8mV6w1TP7a/x7Ptj32hi6dGha3cGMsFLuxjO95JAfPF0ZjmUs+OfMoKi7x4cNdPcwBb7zwcl+Q37z0gmscSR2HySXyuhB6gBeTD0yJ/e4pGCpOLygGYR7OYxXPeXLJxG99cV8qeEu9p/Bx4f3zP/8zF824/LfM+1//9V/f/P3f//3b3//933/z5S9/+fWf//mfv7jp5sHpgqse9Il4uLIz4OJcrX3GkO0TwDlq8dfYU3PpaaVHLwFBfWkPbmpWTzbMuMTvxuCP6qi5s54q9Sc8XGLn5L9WK+fpQQ4Jl/4+OPgLs23cWrkdt32Ypi8UVnhrZi6yiH16IBSCoY2x7Rn8rS6Pe3Ph9LBhHY55g0P893//d++3LHmP/w//8A+vP/WpT73VRXrzt3/7t1wwP7F+/dd//c2NAhp38OgpZhKxzTV/rTvl91MntY7l73f6cDbGYiTNz0ZkLru2etpwNoExKSJevcpzr/RrbjaeTVWuT4HmOQXPnd7BXIKVDr9jYyW2zV0U+J4/fOqbTx/7JNKfp2NxYtdi2YeFu4++/vgNytNQmN/s4vjxCJZS9+DBQ/7f/u3fmBwXi49BP7X+8R//0f4//dM/vfm7v/u7N4rf/u7v/u6bL33pS29vPMboQfHSiZmwdBa2c/WRTNQYNcsOb+nEqvGmFF/+YFikPofOIpMfPLaX1loelt5sHB8tJBR7F5m7pDVz6ampH0Wul42wdSf+4nFSHu+KRxl/LmNy48s4ljKYD39fGC4KImxywfj+5KeOehP7iQrOxxt8LDXsCd+38emJ8BRDdanckxxPJfrxPU2X7PW//Mu/8AR7+6d/+qevpVzEt7/6q7/6+sZnJiNl4lXHLJQJNd45VAPIzIaaLzsXK2qSxBwWhcgfXqx9pbpBHds49tLXNfDyZbU44zXvwdgUxiVG6IOFK/GmNifxdxNiafG9BtcBrrj9y7/rYwGCzzw3B5+XjRNrDayFcSGdOEuRu5j26IUO3fOOeM/YPzsSfPaejzt8LmcvG1YXzF/0dZlecOG4O3D+8i//ku9Yb7B8LP72b//2m9tXvvIVN83CZoFs7vVgt89AzYe781PHBBvf4dl2YennL7/JOS/xJuGDXfOUyz6qS+50scghsv5yvbFVP31S1z264ie+6mkD1T5Osdrw+uSYesn0vNiNI70cni824l4AcLPvrkV6DsRclGLEgPK9CbKI6/M080+EXCQ+9mS5oP74ox+fePL5vvWG71d81/qbv/mbtzcAGjOJKhNGFzY+g9YP78qh3annpddwYh/1SM5KbeLmsNd+xumTPHXsEzl/1LJBuWDl7Z6dozecPH44UxNf5vF3KYktOan5kvZH9lrAyp+xGuOD0aB5LP0k+6nl8XsmJWCpqQ+HJws+Asx+4PJCvUTm9QseGMH5WAPz06rfrbD04uORS8XHIA8nnnJ/9Vd/9UYfhzy13t740kXXLMDKY5eJLWxP1hNFwznVMqH4jy4MShvhs/n0a57aS9/yGH9/dJxqW0N84ZofzOMXg4uyVqxkj+0xypf0VwjI9Ik/fHHmaVKsPHozBngwz5EcL1jmYlJi8gqHh1xreAGjvy4BFCA/EcHB4MUa46KAYbk4SHwrF6cYTy2sLpJSr1/0gvExKOufFmVfcLl4Wv3FX/zFmz/+4z9+cyOgiQb0YGwgSsxkwfCZQOL5ThJ1nsHJg/WjRzG74MXCSb593U8i6OihGNg+NYrn4024eRCw8ecw2jO51nSM9m+uNVDcp+OgSPoyfw7WdUg5HQ8phsT3uvHhsXfBdi+PG57nVN+OLhRW8+BAi82cJbYoY+QytKfHV51JnaueLscXqqMWcR0DYME5R83htbj+yBPH382YA9+x4PGkIqfvWlZdLl8sfq/F9yyeWre//uu/9ihq5o1gQ1lcY5QJFrvkvcL4XmBy1pXz4uqzIAmY+zQHtmL7YFxkZGP3ePjCfHjE7Q/OmPVJtja+axcHuP3YH3M3BzycnlJrx8e5Won7aR/Z1/mJmF7N4cR6HHj46QEXOxhhMK8fNxelWC8QEOILZCd5PtLI830KWKrweELx1OI7lqjzlOJXC9Tp+1Q/Dt9yybhPfP+6ccNozgQhylLgGGWwYM5LvSB8Bpbvn6JQeFFyU1OMCWM3hiWx6+nPizB/DMADU+wmHAp58NROX4l7xJ9x0o/YvVLvsemHH9k1M07i9rUllgzu6BzPnOL78LAFGUuxnxgZBxhprfuAU3ukLJ5T+3FRANNbsJ9yrnMTteFyYKnjskj86wa9cf1LT3zlwXzGukB+moGr5oUuzGt+3cCfhfgdFj4fif3NgvIv9FH4mu9aNz4TARmsGxz1ghBiFimVe2wycq3LRriIBRKThwaGnz6Erk0drczPRp14zcGlhk1TbD+cGV9U+62hPhfRPOoQauFhyS1/csHH5+USX7FTP2z95jUFv1mwmgug8wvvvN2b/LJeu3heR/ZhLgkl9EDZx/bonorn+mJYLmQuJbZf3v2E4+OOml46MFQXjo/K/kToHD8Zctn4zs5T7caPiAzAZJnQulw+ZCyTkvUfPeFKPDiLQ+GE70UJO303Wtz5jiHI+fIQcFSYF4rKF3QcVmIZy57bHAjY8t2v3EvOcyvW/M61jgbxT/3gds3EKDmpXP/k6B7i+eLIR4YjnNOH4/3yRFJLXzA7h9Dfk9UTpk8V96UMjIsBRA2Y1B+1HDylXJIKtQftDb+TosSDcrHim6YL5KcpTy8uDDE1PL3oq8v1mo9Bff/yxyYfjfxO68YXLRowsC5ON6iL7Ab2UnlC5JgwC0eBiJkMMfVoqLuvD6K1xJDggSn2xmESuwG2cSiOdy0Y38XSv72nls2S9VOh+OYgjS+9+443QA6hBsu+SKg1v/biTx5Jj1ONgUOICU9r4XD32CZKGD8Xputkvq7h4Jk7+6+83OPCoIgsuPvg0wdNnrgfkf7Jj4tDL77E8zQj5jfvfLfi1w9cPC4VT60b/+SBSTIRJsxEsTRfWPOeADaY/XI3xsRYO4vt5lCbuGOYnzGNURi+N6O19Dqm6UtnXvweiDdJvfpURKA5hWYc8xBicObP3744POrJwSO3+K5ns/PDRA+6PHNbFwwfqW+cuq4dTRM3ulqlWE/fcMM9zHDZy+O2HHjFXOaM7Zi9PIA8gWTcn/WTQ7hQ4rzASvyFnacZ36f4Tsb3q/6UyGXicsHjtwyqeXvjdw4MwNwZtJvPwGAcIorvSgkbE2wW2jpwJpC6bgZl3lBwxV5MY2zGc89ywINxKv0OMuPQEz3Sh02tx1I8Ocmej8dtTWP5HWfviX1Jue4D0Bz1bHYOy6qc19d1Sdy7eQMPY8+hR8yReAw7R319Cz617Deh1E8k+gjjolHvjziJS+DqrHxhhFlbyxNHF8tng+WCcHGo4cIR89Gn/E2XynkuF5eKWr5zCXuhL++vb1/+8pc9ERaAZaJYBsSXOqdmXYg34MqTz8elP49bh5KHJzWPPrQiB0ZOnD49nAvX45GnDowkMRoe1k81JBzjKBubMcttrv1QH1gwOO2DbNxYc+nbcdpv1yL4XXefOsYO97g0suVerX2TjktivxgWlxf2XXltpS+Q91QCDSk2lwkMDr4ujbnEXCAsBD7ucgH9t0HiYK4V9kKXyn9b5FJxufgCz2W7/dEf/ZEXy+EwcXwGxTJan0QGNbh4832L5mwatagofpeQbz9xmnefxN1MCzGafh4bbc4kjUcN8winczSOxm9v87C8YMHB9hzoh20NL/Kdl9hP3nHzMg601ulHPpZmxwlL2sOEY15zA9o3PQ1Jj5OPj02McS+EcbEGlfbLOaaPn2LgTeUi+RLVSvxk4oIyNYB+/BH3MnGR4HKJ6MMlIsdTiwtG7C/vf/iHf0gPJjv/1JXBwLQB3qgsBMgHw2ZqwH7/KYf89IFLDb7sfCy0H3n84O7bXuE5phEYvegt8Vg0D460J1x/Sac/CodcOOanh8ekJjnEPhzqSIGh+PDxmS889qEc4vjOtR6RT8FNdfMxSxJubYUYUww+++FAOEqb1oWPNZeLwNgcOlhwLoEvKxdHsevh8kSCrxb+eJT6InPZ4IKxXvoxDy4PTy0unYSLNB+H5MD5DfztD/7gDyAwyblYNJL15q4NOnGyAF8yOAxKTB15eoRrjHzjjOeDoi8v9GiufeJjZj6yjltLjMqXOS53azQep1Nseqdu4vKLY4nJ0TNc3kjH4IeUi4B1HhZyxNBrJX5JnQ9QPbU13m9zwiP27WXfEp98yAi1zJOcpLgtPbkcCOcFDkYNcXL+rsQ5yvrppovTy2Uel6sXDQyfL+/kiPkYJMbngknf3r70pS8xWSYxl4YJII0ZrPkuQuFsPDE+eeposPP0k2+MGAq5cJ1DWXDwzbXdeXLhTL6WXPOI+ATmBp88Gr7rGcMJJnXk/KQllOuPFdbIPFrD2rNPrfMcwcHgATMPYf4BBIy8qJ5bxw3WPJaQeuMR+wYFwyOklj7EreXg+aGCjy3yqfP3YGrJC/IXdS6LanyxuCDK+Y3Ujzw48Hkqyb7QU8q/x2IsLuZXvvIVx/Tmo5A/7TP7UQ1o3bEsp+1YjU4c4vJQBpXlt5qcyMT0wC9fvmMEq0lNTfgzFrXKf9R8cHzzZPnsJeYvts7RX3zHqWtvlI0vTj/2gUdH50hMT88tPc2hby15esBPjO+14Sf23OgTLj6Y+6XXR6yPHKocv89wfyw9Uue50T815qfGeyT8pcbBejxdDMaYtVCXPDU+f6wu0cvMx2Mzji4PPT2uLg/YS/E6b+8RYxPrAtvXeO5/498oy/HN5Z2HyPeNzxMIyO9cYg3iHLHUSfiL63cneSRcavyuEg+6eRlPqeOJZEeCv7gmNw9Fekwq84BCAgtfbj9mWgsMx/liR4kFqPNx32L0jzVRcuoDt3w4mrdrmD8gmBtAkLRPMdyo+wBL/R0RKS9j0B9xzDhIzwQr8Rjy52NQ/MF0Uegn+gt/xJGTEPsjkd7Uhdcv7f6Jb1s4fOyJQh9+E++fGFXn72q33/md3/FGaWAPRhGTQBuTYNMTexHE9cV1jSboxwM5Bi4e8SGAIeDEco1tH1ncU77jpt4Lay55zwEcDg3Cm7kyt/6SE4WrunIdp9ZKDSA4Gk7H5yniH2TgwZfYKg/ROWIUDgfccXjBdwGAhFjqvSfNelkX846YA44Sp85vTPEEu4YnFD2AfWGE20d1CVwcHK4/zpL3JYQv3P+EJhfRfGJUQh1/K6SWj0ivr49CTp+V4jvGFkPVkEchvvbG31tGsyAm137NuW/r4OFLwP2Ilcj1xxC+H9eMn7w/HpWbsRdWnh/BYNS3V2qs8NDicLUJ/nhInfu2f3q4Rr7nTBycuuG2B5h6FmMfnCOmHiu1bQ4edVj6hzsfdfHpz1cFuOYF7xieK9rxycHlSYKlVpfAfeFhyal+PoLle+8iXi99yMOHG759RNNyXEyWh4prbr/1W7/ld4rieZewEMVz0xWSP+VkfHs1Cb8L4/udD0+15rmBpDwEH5iY3tsnl3EcJ9++7TG8zKU9zE2dLWvYlrR4fZt3XAjz1k8frxmLwsNCWb7nFzFev3nJYJ2HhAOfcbNe56Rt6B8WpP5Yl7qP4hg7rXeePitvLhg8bNRz1uGXMx+P5KTz1NKFMo8nEzW6jMzF/y1qn1b6aXD/kboflS9uv/mbv+mZcHAq9uCyp4vVHH64dpKD7xgrNc7hsNEMuup9aIyRPGXIo4uDCPN3DXiA7cPE11g+UAPxJdR40+X7+x5pelITf9ZAHBwIezpMbOdAUJ7EfdPDsdED9/hSE+DVJy/tPgWaXzjPOFeLwOmYvGAZij1N3phfMt7Kod48Lo/OZvrD0cUhNM650YKPP3yUS0Yd3NT7n9Conf8zQur5PRaX6/Ybv/Eb9PU/9mLCkFkcFybii8H4Uh/S2gxvDAsDoO4pH0sMnwWunrOZrZEaXxb1JakvLptG2t9h6ImVdD6uD982cpo/OTsS6lsXCOtBJWwg+dOF40X42HCI5xKBJW6P4XJITqYuGFAvJT6pnd+85vD9RoQGqLOE56cVONxckqknQY4LhIBJPa4uiPv1coXPl3O5r/29i4tEDp88l4pLduM/hwZYTwMvkovFRJhNfE+WzSdfn0OiMZx9MPj0Ig8/6v7F8PvHW/hgjEk+vMF4wSfXMbDtFalvSx7pF3Uwxup6pPNkIieF51xjcondjDw55pYQC8GHcJHdV+bgEKR+5ijbenhQ2mzOBEts1CXz5xpjKYE/5TxFWG8uhkH64GPpy9NHcn1iTY10LhMxvD7xFPtS8VEIptxxHyCrl5WJ1keV4xTrX3O2yrND9aeHmhfvl8tTHosIZ0Psq6ac6QlWPrbj0lMl/iKKHw6PWXxj9CyX+tQ6l5gvoB4vMbU8SmceYNTFdz055pX5emz5/RJsDe6a9oDDfMGp1UG0v5Wa9HYc6y/N+OnpcRTbdhxZOK4lB46fPaJHOa5BVx+ePjNv5sU48FF4Ev+eSzlj9IVDP6zi8oxB8uZj6yP1k2PAwVQ4HCYVn0GHDx7fiij2YSdvHwsOBz5+bccpBgf+7i1xLrgvKXWp9wbAZ8zUm4tPnTgzJwRLbfpZ03/mLdtD9aHQg5zaNPbcys8YPuxi6ukYPlxJfzHp8eXPoYZDj/HR8oTB5SlqfsZ6ybjheA5YcunJeL5w1KfGlwJ/1RqnVpgefh+RZ42+8OBYuB9//LF7YgG8aViBY1VoHMGCITQqj2bw4g/WOnz44MJ68QaL9URT4968Y+hLTJ6cbBdtnFq4VfrBiT9zaEwtc8AX1rgba4z5gTN+sPZyHbnUe+7BPS8w6mV9cOSFu/+uSb5rIccF8I/q4bcfOfdrn84r/f2jPjz4wl7y1AnudbQWS9+OSw2anl4jc6GvrLnE+GBcJuq4uPQT7jcBeXy44rxMvce9/dqv/Zo/d5Xwh3Z9kbhJp+9XF7+f+/Yl5m+sPt+jTJCA4WqSOFNTX5T9PWpwrPDm6Ts85rX55Sl2LdxyNo605ikfW2UtsvTxDzEmpB8+Ibh4kIo3Z3Hx0XvqmB9Czs4hfFES5fheWiHW4dpvL+ZFGB5v0uLE/DoADN9D0IMv2RVdrs7DPVBhXptqXU8h48JV3mPAgcuXdSzftVJz+j5xUm1Q3zHsglU+J6l5aWay3PZiGayxlbzE74RMbnJrXNcTi1/8lE9fP3ZpSD/yKKLe7glPmH1w+X6HSoZD/qKuwSq/x3aeseibOfQp5Dhr8jwSk/c7NzjWc9B0TutITZ8onlu0H1W21DZHzB4lb07yWH8MyXaM6aOxmfOsRz2M4YMlT+x+xeKbRz98KU8JPy3BGQ++3rgvpe4rzG9jbwy6/R1vXM3GRxEwcXyYamqQmloGTw8mY5xL15hc68E6WfpHyfHuMA8+l0VxN4xSxDlUPdhApY7NJFdeahzTj77i94DB7NMjsbnwWsvY9ISDjyWGE/G41MMnLzv7nTrn6L90MKz6+MCJ4WvdrPnECe80BmPj9wKk3v3gNy+LztqSN0asuu6xa3R37DOP+C/1ncp7QS3j4HeSPgy0fg7em6oJN++FM0Bia2uYTDAG7OLKYWI8XstrDzCPgaQGbvvsXp2L37mK3Q8cDIUHB2wdgucQTg/Jig+XzegYcJH4VvVsL3zzmAN14ZfrJ297y/pgOh5KL+WsnSs9lWOOfUJYOxa+7MucS+tnDHiagy05etEHTHzXoGDi2G89/IzjpxHf1ahj/8iBdR77p0f10recl851PGq4aJ6ASAxsbVwFk/UBYhOf8mo89VIG5nOWzW4/JupcrbRPMiZvTiZI+cyj9eEQ8+6YsagpDy2eHszDm7B4ffI96k9NfObhDYwtb97JtdRxkVrDOOBZS9e5e/pwwVFw8loSnJ5HffcCSz/PAVXs8TW2edRg1ccXhnHI44vrw8cSM1Z62UrZU/8UKcwfZ6kj9t//6AeHXMbxl3Y4EuO9iGA4MwCWWE1GV+zNaPyfxx84u0FjyWeyg2nQYq7Puw4Yjg863JlDrDcrdY5V4yccmgOdHL56uEaLA2dDTge7fak3EB/bWvmef+Y5eWyVmPnL9+93mhfmzQVjLGFzwLLeg+Q4AOdQ8NZJPS/82iox48ChN3MQRk+PS66atRqnjnpqUufvZPI7f49NHWvAcmGE8Z2RnDEeUal1r4zfeo9DPYk5cFTJ8beCa6K2KA15AWs9AzeHJV71xuS7Dpu6LtoYlg0Jp/NpP/uMCae5jGPd+Lb1mZssvjU9PT/y9Eo/Y+1NX3zqi9WK53fpqvfaN5e89HT4xeX7sIP7aYQPf9XUn9poc46Zi+y+DK6X7x8quqYL31zNF5/9MB8ffnjm8kDB10OMS4ffWq+Xpxs5BiY5G11N0RxmrBe8OVhEPhyZ+YhzHn9ZJud+WHSN3zGG0x6JXb+xxmhr47sHFhXmQ2MzV503oj71cFhL68gl743DD+6LjYY/PaXEbLbxxDMeMdyV92HCKUa+NWCxVnBpL0zHMxdNvj2YXvMdiz7MzzZc7094ng95WT/VqFEbc7k1YHDF8Xcy1oVyoeBR7xdUhLFoBqRY3OM7TbC5OOGbQy6YYz1GzZN0wc6DLT45f7QRdxzifgz14075Hpb7hWcOtbXNaZxuyIyFz2VIj/Gr7U8v+CjzFeb+1KRuLhrzLJdabPr4ndx5wE2+h2hLDk76u6Z4NXxreJ5TMNcyn+Q9V/V0v9W7vYiZ81yO4O6RuJeHLes+ztwQuAg5cOrgl+uLhSjhTYvO5IXbR/HLa02anfJgTAAMv5dEi3TvcNrXlo3gEsEn314Zp72MwQOjJvyx5MX15qG5mMXtZ2wwX2oZxzmMqveGXPkoHHoFx3rjV8/6voDd/J0DD9bDNb50Dheu4vKMoR03sevok95c/Pn36eSE+elSDpZYPOfhMg5Och0PyJdP3PabOaDgKDz64ZPoRfBBoCqyJseXawbxZmIp1uR8UAtnQDbTcXowiCU867UfPEnHdS14L2Qu0uTp18uVXt28xuZpLvT1vMoDbx9pD8dzlLgmWNfdOnr4IMgzt/BmDnCk7Yn1uI33JZeap36+NFg0uNcfbvv7exN9wm9f90bhUI+CMx41iduP2HXtIXFP/IzlS1YeWOPOs4rwKwd6Re13wC7kkc0FslVz+1hk84Qdj5djsuYk54mRwAfj8LDhDKY5Fj/xUfyoa8gXD39y9AVTPF9q4YMTk0Plm09eh9DNda1wH054WPIzD7Xz5heDF8y19GVO5MHgdKz0ZkrMz09N5gIPzZvBHMbuXGQdcxFkfWHS2/biMy/q/GsAMMZPP/99UljVde2HZRDmVzzWPyV2XeRTzz7yhPR3LOnxR+h7iqjZ+M/lUflMjoWfOJVMGBzrJPxYr4OnAEIaTK7fdWDUY8HJE7Mg6uiDgmd8czOMYza0PSQzl9YiyRujN5Kc+UxSsfs0T4/0MQaPGqkvteK+m8HcHx75WA7LvPakDguO1EfxO46s8/SNeuzU9WOpa+nlbJ/65pOX7cfZcOEhPJnke9zw4LePv1+Rk/gJRgNPJhMaf8UUUmFLnLzfZdJuFPxOlAHMg5PYNVmkL0x7gGER/TjrBe2+8Ja1wlV+fGqI5bo+vH6HguIDDs+1rZHORl5x+b0AG6O3a1JnjLzmbZyajOex+kQE3z3Jx7rP2hf6tIZLSh9j5PHhs0/EWZ8xxd2bzt81K7aPqmZ+8gPf/eCmHzVy56N2emVc/3eF8d3fk0BFstK0cXP3VMW2CBY+T5zgbKQtMUoMhw1qb2zz0i5o+pJHyt015eKzGdhyicPzxYUrn9/Ct0cPcvqQgy/X60foCQcu2B3tZXDt7kmeS6K+PjRwiQ+JXHq6Bow5E/dJgLZn+dL27uG6p3wO03NI3r+zKhbu1FWDWdVnlFh1nnfmg/bJCsd+ubLmgoNR8/KXf/mX/5cCRNzjcqFMSuTjZJUjNoHgwWK8yWB0PGBPwEnqgFcvE1hwfGMIPr0Q5WeM9qcGq5gF4ZaPD1a+/SawwTxFLhGp9pNgZywUDBLzNzkcemAlHgNNfvasXDjY+qwpNZ2f55SajjtjoJnjKGM0R7xq6Dc9mhfkixzcfeXXUjJzSe8dd270wXeO/QvPil8uMcXcxG6IC2rBm6Mwsa3yjTvh5hB825XD98QRfGw5xOG1v3mZl7ErJ/EpJ/FCZRXOpvtjl3wuFZeLXDe8PHOJsdtnHlLHcLGdW7Gsze/uziO80faVeqxgp3FbJ52ny4rL9RMi6rkxtqxriBen+e6550gOm7P0JwxxuVhwqX/VEL/rm7mlL1/BnNPW+qPVmytgLhU+tv41rtXA+J5sMSYHll625WKZxMZSxyJOdRJsJ28MS0wNMdo6cvKp33lb8I6b/ns+e3zvBUIdPv0ypvsEnw2tL+vLtLg+OLBoe7qPeORZH3OZQyoHJd5jyh+uYubNpXCf5Mszp/MBx4dHjj0Apz62PmtAHGPj7/zOYQdnbC4XVvHxxEI1qK0SthsrjubyUNvFeqFR+2DUcENSay6Lwu/iGqdmxhE+GPlaMCy8iP3ym2f8WI8DHq6VmDo4ia31sfSgpmPDZ5xy4u85sqkeL+P63Q9P6g1H07OxD5cYbjmtIw8fLDxz6U0+a3JMvrz2ABfHeXol33kaS56j6hMPnZ9UY92P+o5JndTfqcjnieVLJfnYg6jIG321EpoRjw3uQ8RH8VFmh6WuuKyxZX0QkMB2nP7mtUYbeLLwsXDBVs3YXZ+4h9K1+GDks5nt51x112HhhHfFeyna25t/5Uhn3nDBw+n6ffDk4e0eqbcqnt8xwZO6Hjw9wH0xqCUmT7/wif1xRUwOrLnk8fsT4FygjOlxuIjp6zxjYcGZH0kW7INARZh44/hV4hx080zEWHB/iaMX+faUelOD28dqQj4ULJiEfu6JpOf89KWYubsfHBScvgg9E/viEMNVygo/47oXudas8d2TXHCrYh8CJPrDC79592RcfPJYuMr7MMrDqtaXIJg59OvYiueSkCen/u6TnvP7KjAZz48+2PqtT2ycOHfAdyHYaHnp6Uuz+8sn7997oTRRTP7hOxaK7JiDvGAIxcNByUsZzM9ULYJNn5zs1MBTS7it8QHiY1urzXMdWCbMVLCnmipJ8uDl8tI8OAeOXyus83Vf6uT3MrJBzMGHstQ/TSbvQ6ZfsMGpyxhTr9h9weEwR9XSzxjzBSNe9Z4TvlTw+ZIFB/MFk+81J986jweGDy8x4ys8Lgs2ivjSUVMutYhyp8uEhad864+/FQoY3TF+FkHcRaruuGzkevmC74U5D55e9rEQsyCPURvfefzw0c5hMCwi234zluw8qchlfJqbgwWTduPdE58kPZPH769RLPSGBx8l11pZ+vfXIY6pKU/YHCxjsAfK+SDBg01v4nCJsa333HYtfFlihoI3HGrBY+H4Yy78/s6r86eulxTMY9ITX/PzGHCr1ICh8Aj2BMZuH5HPuwrXG56JPOLWl3rxqZ/Bse3FDLDZXHq6LhxyVuL+wECMJd+5pJZ27o8yNByprTBvYjD3pZ7JKcYYp3ZzgvmSsqHEkJHF6bpmvii+arB9N3d9tqja+FDhpd6HJt81+PSqjTKf6Zmaxu5Bv3Jbq5x/bcB4WGq9aZJyo7508CRTD5Zx2o9aY3D6m/fwXnbBbi7AfmIrPlJ/4QyA34l2I03P4nphfMPid6KuFdw6L/YOh1JjWFYLVzXG0NROvZQF7rzCR2vx77cWx2PiY8Px/jBm8Dm82Bm7tVXijGWfNQpnbviuJyYn8YG1FhwrDF655qietj5MesFZc5iDD26Fv3CUcd2bvMb3pUP56Q4+cyIHL/U9C5+ZaLbRGYO4C3IBqsaPFJy/322MQy1fg7eeUec7FqGsffG8CcoPv0+h9qqAEaPkqKM+Y81H7x6nCk/Wig8NDn77qKctMX1S13E6Pnk23rXUwG1Mzz0OuuLZ0/gdyxdE1hrcFyR7AKbweGJlPlXzsOI4xxwkHcsHCxbOzAcFoyY8j4tPb+qwyZU33OTg8STjI9Lfr4T7yYZKfDHBEWMCvGEKunGzyJ1LbBxZmC2bv+L+JteKlIdkU7w5KH3Js6gqMZendfSkCEvMYcAjDn/7/gjMnFwncY44XPcS5o0gL7ybbD5+tIfpHNill5Ua8vQsp0pOCt4xXJs50t/ziJ08Si09iic3T5mq8NbORcIqpxbHx5T8+QeAq2bq4KGp4wj6fYwecMrzerAdixw14C5AlfQBYosRc4DNSwUdlwe5U+N3X/HkvLD06UY6Ztb0SU/jiHJyD05y1tW3izaOEJeHDw8CNcwhvZDTePC3lbp3fPOSK+afhPoxqqFtGYOxJGzw9KEWYd3lZD6do/lIajqWVbD7NI7PgTI3X9TNpTc9WoeV7gsw/cDLpWdyXnOwXQ+3uLn4wvYls7KmuVgIVgVzgI0ryXlz8kRiEONq5rrUDI5Qk7wtefBXuWytS+w8XDgc4I7hw6NG1jgKBi/c4UmMocK8OVF6sxHus/CtPTTPqzHj6YlfvL2t9AoHrufUHL50cJS5Mkf49F24Y2zqqbMv672U7zklD7f1YJ6rejtPn+Q6H1+CcIuD+SdCcPzmEtOPM3Sd/I15rGI0ZZH7UjSmmTGIzW8OPhtJjkMsJjs/cpMDh0cjeOFPf9lO3jUIOeZAzbblK7SmhvSeczcb3z3L2zF7oZrZ2KzB+Yw13OJwilMrnfkLY8OJt+0hmOOJHgdqPpPggtMv+f5UZ57w9ulegrWva6LGU+M+5QQ3B8Vv74V7P6ltLGmP1vd7VevB/S9H4/tpBYcXJusDzmbaB2MhCFYYjY1LzLsX00N24l0XzIdGET4WnDEyji+frBcDN5gXTk3UXKnj8rDk6LW4xrDlo+L4EKijt7RPjenbmnLhpWb3sSWHz1wV9zCuc+wYtnlqOr9zxNU1nnEkfms9N3LlYemFiuO6jiOdpxJ+rC8FeHqYk9oZSzpf1JtPXS8VT/PH//tYW5kUloNGKAruzSov6gnBy8aah9Cn/TsWSl+p3/UReO4h7vzuDAyfPhnL4xG3LzGa2DWyvPs9ZmrdB05jBmAM5rzrq/BlvU+y1HJosxfN0Y8e9BJmHw3fGDl4SLlIa1Dyin2QmaMPjVwx1U5P/I5DH6zUdUh60XdwqecLN2PM3MjDS41t5uhe8KRz6ZTaeP3jR1QV43fjrpYCmYcv05mA/V2H4ofPouEaY/H1ycnS11ypY/JRcl4UPdKzvTw2PuNlDPdqXq45aDal850Ngyc7H9nkq8yVfp0n2KrZ/FoOo/XeZHLlrj4bn/7EnWcw98ZHya+cxyIO5jWmnw9V0ks0vYTB9dwk85GWy+e+i+dfKWwcLjXE4FvBZdvPH4uzIRwQPsli2Byc42KKZY6LhDbHF3pZNsI1GoSBLfAknkjrOcDy2xvBb4/EcLrQ2Wh8pBxEPTz/jWdtzoGRb1wfnlLEMw65WCs49WD8UJHYuc6vXGn3Ft+WeZPLuvy0yFrIO6ZOU5+LgaUvOcVeF5zsHVzyroEv7b80aH0/9qYXfZrvmIqt9KFnepkPFs70aU3nRQ6N//AdCwVE8VVgi8hOcXnhzGYRc/nJMZPy1sATw28PWXNR6oiDeaKtD3f6tY9sfffCD8dWB8DQjX2Zw7eC069jwQFL7+Fc+Htu807HCvNTkIYS54Ttdz3qi4OGg7J+85hjcrap9eHih+tce1Mja5+eHZse4B1n9fFFqdKruFSQh+jvvGZsnkjKTT94jaP8D7A9/EmnqgYc1BwkShz/bRY9WLmyLHLqNkc6NbLIxvuvBbo5p7ERYgQOFn45WGkPubxR5diU4a4DgTrjkkPBsGAECFx4KE8qRLD70Dd5z0PWB4BeerqmOfzg1LqmcyqmuIfqehQeGBYNH9unl+eR+ft8seplLrZ8WT4SpydEYnDywcu3pt/E0n2pUHM88FYWp0b2sdXGWBYg6wZg2RB8BpoeWDgoCyWPptb1WLjLUuc89fjUxLov4zeGR43kVBMcnYubvOuwizsfy+XQD6x+ePaxzKlKbsU+ECYkOxegPOrbI/178eH2Etm2blkfHDVg8uHVJz9jElMjnZ/i4NZKvXfEWLjy+7Fpjra53MYfw4dHXJ+a+LXnP+lsLaZFiHc8NfDLR2RpdKqBg7JpSnVToJ16VciXQ17WPZHi9EWVZ1Od0yIdwy+uMZ3iBZ96fDjRznNw+sr63d7c5tXCh1tlPFR5z5/1loeAX1WwLbxi+OrDYbT3KR/t4btv5gqv33F8jovnJxExY8IJ3+vCFz7fpSRcHPcnzjzHhyvdOfOLxzY2pxPyJuFX07i+J6cCC9xY/0qgWj4zVQ3fNRyTy0HPH5+FdZLDqQ+3MTxh8Hx5sMr3UW9ehGHNKR+R782PekPIE2NRistR3DG7jqnBouljTb0Vv9r+5WxtH2pkvSZ4in0w5dWHE27HJddDLa+/JfeZSt2Leeg7Ty9c58yXf1txjGGJyyGmvipsnmbiMaH9pKr6I1TbdvpnMye78apiGhvXhI31EJY6ltimthvkSVID3kuWPn7KwSsHXzLjtWclfcxTbcc2hoLRG0XSx70Vule5u5dy3uRwXRM+cd/ptCzfSn3G3P08d/rBRZsHU50PMJziw6ut37i85PZlI5aZuTkXTrU/sTtOX89FS8OyBnK+rOSCs3Tq5pLJugfWSQk5D6LC2XwWWKya/xW3/bRpDYNS1kWg5IyTZwPaG8FH1zjmKMU7a7jJuQccbPmrZvId507MGmcM5aY3vHLZD/zU+zKFN/VYxlw8PznJ1fITkawPgRifHrLzxqltj/geB8tkgvvQsPWzBqy/57R/aqu7zr2o2/nUeC+Yc/sm7ycPOU2F71Xt6T/fkJO1Lq5Vvj+GXYxyabBa9FgNZB/d/jXGR1oj658ei5dLng1OjRfcHlUwfvKS782gpjkOKnWOGYM8okVyiL0Qvp3h+st7Y6XcgxJ8LP3oBQ43PYjZKMaauqV+oiHtJeXAKHG8BYw3Tnr7gqD0SuxLQB22PYrBkbKG4aLp7TmG28PtBTW/Ncn7YmGJuw5k88OTsT9jBKfWYxNLi9u6AKGBBrCP1Rg9JB8ieWwPkgbECPzyqAHbNeRXnQ+xfsbypYADhhCjEhYz9elrvnz6+LBS175doMdKf29Ka8DxqQNH4YBVVs7ryph++oCFY03f6UXcmsZY5A7P62uOMcBRhWgvVft4/HLAFw/b77f45hGrff/8g5L3hUi+ta6Br9iXKzi2F7K8Yh4LLe7bmkSbmUSz+jsHXiz5uTj14aj5CHFVYTd7ctSCo/TGCp8cNpvSAx4OUm5zieF6U/I0np6MkTyW3iP0BWcseJ3PnhdW6gvWfoDUyfceqL7jdE4npUd9iT9W4KvOc1aNLVjHkfhjJuN5DopdJ7VNPE+Q9pXv70sff/yx68HhiM/HW+davi8UyngL6560v3NYPY39hJTvj0YKfQgIVkVPKvks0vx+50JkmZh9LBvLhuZjzXgOi9nMoSbHZJ1P7WBMFq4BCflwXE+uyhxSNzXlwwWnZ+TE7djtBb8c4ozty0ScPuV2/fC9wZJutDeenLg+ZKzGm6cHGErcnkhzsj5Y4bMOiXtF56CTN3/nhSt9fIRRWy54MF8IfOxWeNwbfP6jidT74za5jxkn/ch5cr4smbQVrP49ZeHaBNUfm4BNzpYcPVAEDJ/dIFceY2ZzybMBM0Z74CNc4j1HBJvxLc1lXM8tfTs/jwOesadGOmuRNPaYYGsu0yt8czPGyVKLjbLh5tKjvrQ4A/ugUGrC6+HSy5cFPP3MRcDlt16peVr5iaS59Ev28Iil4O6Zus6LnoRwO24t4hqp7xBj4TMW+MsvfvGLvyLndIhYtBjKJlIT/Njh48kzNUhrMlh9T3JzciiCHsaUmIcubPdqfvqVQz/mAm/Xp9ablhqPK8VOj+ZkZcyxBKuP8cbhCJ8e9anHb4/4uPUdM6dgHgOlVpAvDLnskfuTT8n0RC/xtvYlJwsXHyAcZGLlPb4skPn4ys1FXvkThpUa9zthK4eTpBcd8cDNoRnspOSZSHeAp8yr4/E+eewSc6kR79QrY3uy5FXbd8b0Q+GQx0EYQ2oMFcffI8O1pJ/HkPpdiE0a3xxqpY7BqaEP/bQ288Opzzz6rm1M6HWARWZ+9CJW3r0YC58cROqi/T48T4X08eFKO1dzFSPGiKWBjrOUnOqqxfKdyX+ExhWGOM8YSGrA3QMuCuflF77whV8R0Zsckn2EePtsLLKxclA1nZzEkyme3kxqeNXm6a9YoWP/ZNO6xO7JBmuxrqUGPhfThZLUIF44Crf9pKZSQx+keDkdq3UIRfUl3tjwbeO7tjjE5pqPOoeAsybm5JcDw+75e7zk5Np3XE7UGH3omzpDyc3c2DssHOHeiPAR52pTZ5u4H4uecuqG65uMKmGtj0U2VqUTG9FaJL6xVzowtHkWoLou1HFkPzkcw8dvL/l+mjEehI4bDKi2PPvwou6B0pMcdvE6/mw4eHlYRLk+MYxjieO7V9Tv2NR2vo05DPbc7/D0c5wxqs6jxPFpN33Sy3nw5NwndR6rOZQ4vTqmY55IWDgSmeN7FTY1+H56wQkOd/vmNw/Yg7Rlo/GxxYshr/TRtvlYqRdYHjG2MblY90id+yDi9ZAcw9c40wcJvzHWG5E6+8VT6/EX7nE7//S6q50LnPaPuh94+k6fWG/ywjiUmbv0VI+QX/yTRcV7dMhoOcWTa619hHHk+191thci2/01hl9OrL/sU4+Wq5xxtZ46uLGuh//y85///K8I9KZjmQw+UhxlgyWC5qAxvkzIricGV+wQ/BrrgOFCpakx8u2HdNyEiOcWdS+EWurA8NuXl/KDTy9iifmpNU4PPh6Fd7HmxNqPei7Y1mHJdQ3y2WRjjA0XH6U2Y1JnBY9voWf5EuP0VuxeYMlZrni4vkRg4VjV2xege7Lmt3nArpdyqQBaxxOcxq03Hn348s4i629FsgHznSfx+Ngchi/MzhOjGvhRLJ4vEjgzbQ0a33Dq/CSKmEttMY1vDAFrD0lxj8Xc6CXfm88YzAPBQuy8astF8GX65isfY4vSi76rv3uZFBHeJ4PXscbzPMhTq3Tj9th9mrMlDmauxP2LrX4bPynjCmdsXxRhnivkPOk8vqwffXDQ1jbP4iB5Q2qzSCtF4FvXRpxi/GtdxBsWv33alwszvx1X2pPkF6vpCc+12ijGaR8vGpt686hFhM1lTA9zU2/FZ4z61KLtAy6Z7z9w6sNJjS/IrsdvvDjFzc982Kv274G2t+dNnWQOGoUbdQwvuJU+VXjk06M5x1gpgbkvJYThb677C+9v6efjMJz6rXn4z79E9qERL/UCyRFTiH/l4nOI8BP3ck0P8PYpVg6Cz+WKeMHwwMuTdcxYvYjNIe1Jfgt1YFLXZA5wuxlIN888lfk34+0JtzGcclu36n0JGFfxcPElPtwqPZmbepqDH44Pq7WMD4d8OLQ3V8Zc4XOw1C9ee218fnWBD4YvVfiwjvjuTSxxLGVdrpUaU9yxXM8A3mQES8wAaHPBvcCIfZSG5aB0F+7NylPEBfDAsAbUY3Eo84S4MCg9ILXXq+NQy7PsnlFgc9LbcwIrjoVLX3LwpLbkwKOugwM/ffC9Z/DB8VeNDwcueWI4K+c+sZ4PsYwPq5zUjirlvMQ14Zm7OFi+pHtsetYnl/F88ODxHZOT7fi+ROF17LmU5IvJp8/+waBjnP9HQeqL4AnpMB1LPJlyyKPJjV/+zjeu38PeuV3HWLw0DoZ4DtRzyYT3UPZcvfjWsUji9qcOm54+QKxiNsPzkG8sa8V2Q92vfeGAy/rdDw6HmB7yXdcxajsnOOWRYxyKwbASc7HBqLM6e4jHah8AaniyMIaUjyyvA26tOP03VoxH3I82xGMSVwGDWcuR9D81G676uReBNxrVwIQTF7vkPCHiHhTCKK1B6nNYDL5xXQ4fHDXFtiT2YWR885COI3wOqzgWPjhzEw9prSnE5FJraS/lvGFg7YdLDSoO9X5iUdMcVnEvUnMeC2lMjnHgt+cW8EgvkOdFPYqASRE4Hqt9hMF3beclaR/PJ0odnKr7Y+HSG7894/viSBH7i/9IOzkvWkTbYsXr60D6MaXa4wKAhePfjJNvDfNicGJ48JlhxvGThBwTIb4+jehBz/LgtIcnIGlNuB4PnHctfDBZHzo5eu364PX9b/jplzHNS979cPBbUxvx46I+L63RkD5wxkOBqCV/Uc8ptVMXa46s/wnM0fb4Yg8HDKFWYkzWfCcObsfvk8rjkYOb/u4t7cec8YXBMU4sxUfxwT56+bnPfW5+j4UijAJWVXjKI/itw0qmhklQA8ZLOPbJt1/45gZnws7tGgQfjnBzitmR4Kdm8EvetfhYYuSVLpGdY9mu4W6sHqe5YDsOfepHZw8yBj1ljhrJzCd15RgLGS6ArWKnWl9ycp2TVeK69CD2GHZ02FxUyfRI3eRj3QNVjosI5gsZ7syPxB3rC8et9iJRmqD1dw4p9krvZooNSoR5A1CJfXG8OHwWEsyXDr4LJXDSczYj/NZ3QU7Rhzh93G9xrCtvDnbnpZ4XHPz0MY88H9W7DgHfeumH+rtI8L6biU+HsvP4CONIN89zgnPVcCde/VzPOtq3OHxwiTHWDSdjov6uhB+On0KKZU5rdV6yecTz1Ar3o5c/8iM/4icWWRaTZrb1kXKYoMzOu66crZtbKVfChGdcuIoJk3Y/56QeF7vyrkfB4fGkwUacx6oW59Qjvf10irgx9RBam/4zRuqM4bcPvOodrnnk2pO4vkHJq+MNi0zP7SeeC9xafMaRkPI6hPlCwRHURe4+5dlfWHshxKcv7+IR2haLeh6NfStphKa5bZvrMGYyOXxj4U+OTRE2kwJDePeXI/EE6AN/4RZ88HxPMzeLspDvPFft8FTrQ6D/nkd6YMztPMkxHmNdFQ5cydQiB3QAcS3q5c1GA42Ea5wxUWKN4zrGC0bsTxHyUl8OAoljHLiZP3k/JToGPnb16Hi9aFD9xMGXnurhoeCJPcfgtopn/ckhvYCe48vPfvazfmIhWah9bCZnoSi5OZTNLR+bAfBdE7wTGEzqXs1T1tpuOtwIuGNyrXfiKEHstD8HVt6lz8yn4yFgCWeOy5+L0H7kE3dM12dcONbFc9yeyzpP7EC2E0Hg7H7hIkNjzJ0H5wW/45uoGtZhwhpfYn/xpmdCzz9+L1nrjYdrvz86d5NOPvrqeBKdnjDltDbiBUivC7EPVz2a66LNJ98vzOnhPDUsDg61aTebgjTX70Xgyfmdg99x4NEPbvtSk7z5zMFV6Z+4G2gBx2wtj75bNicxUgzB+qmBzzzwNdeuvU8ta3kSH644fmo1v3DnxCdufnj0pFf43AO481Md2hyacVvfJyVx/2XDqfblD//wD/uJVa3E94ZmEsNRvH0mZ6wW1UQdtwd6R0wIv4t1AqEx0vpwPGYuYvuWw2Y6T1xexGNhJa2duvS1D2nN5+ExJoEPHggZp7WSsa90QfqmoXZZ5zsmMb6khzdjrMHGZp32jcSmD34VGZ91rdja8ReGGMvYw6t/Z+yTvvyBH/gB/wtSBIsy6UoxJINb8ME1rkHiqqQTnVpJNxHMh8aciXGe4iPNIcWYI5tED2ScB5me8DpuafEddA6IfIqmV+qwnk/H33F9yQlDATdGLIvB7zi2jO/oEM8ZVW37+8mR+vIJwJE+WchhiG3pQQ48dbtv12+3XIJaSXv1ciJY91DO7+DY45/NIBwUhJC6ICuycZRZhDMbIB0ffg9UYpuazZ+a9sNS9+rho2B4NNK734uJet6LZxwhh7/mZwu3P1BQW2z3SI17uJmkrsbvl9TmHCPUVEgvzq5zmLyVsWNl5mOs8zA3NZbMzb82EMeXKTwTyRFLOQcuFSlkxowiOz7Na8XulTlc1WvDEmf828vPfOYz81HYCeBXWGzzR82RLxfbOHkfGgNQW7w9KuDNIztff/V2T0ntFmNw4KP0ZcyOy1zKrQWPTs/U94JNLgfoPuThpqa10w8fDnPAl/Z/n8v19eHGwjGGBYdHEJk5v9KbDZuxBpfPwI6Dtx/iOGphDuVFES5P+xTzWhYX4SIVcwwHS1Du7Zd+6Zf4UwxvNb5c09i7wxgvX750jhhbDAuFF02S2L56uE/j5IzXCrbvlwS45MS35Q2Q8czp2NB5wcKhP9ZECYk9Xyz95OPCNcavM/B3zi8Pbca2TwEEH6n/HIbF9csh48bBMAlv0h5P82ONzdkmtWtdE25xL6rSmP1tTZWYl+wDMjiWmicwxEDHlXBQdvyYJOigxBtD8KvNYckn9jtEF7N9HGuxc4uJo2wSsHNY8I4l6zhibvs0pgdj1RZbfSmxCDOOFXc+BhlDsR/x4YzSi0b4SPulN7L9fgwMZ9nJpa9j/GUZp+fgsVH87IlrJPzUZU6xxP7+xL4F67h7LH80YkkiyYE7T1wNl57FXVtF1KLx/ijsf3Dx0e0XfuEX1Oc4ETWybSw+1iEvLP6KI8Idk09ukljcbYGPuTw8WSS2xBFj7IHUvbHgziaPdbRiBK6dA8OfnAGJA0nHTDhE8K6Vg8Nnj0jjk2d+q8SWl84XEAHr/iJQ4lrII/Ux8QfihTEH0DKBiCWDSw5AwjwiTcTMPzV3n+Am40hw53wA0ss9pDP2Whc0+37HUtAJ1C8uSwNSfpKgr/SUkBrfmhxPheuTx2+jxZsnjXjONwcPejHy9KSX4vZo3hYpjoVLHUqc/OQiM4aDY9yTADFX1kKcudoHp2fz26Lw4ntMuLqMx7vpkL7LK67ZqhrzWX97NydxLvMuH+snWBVOZHjB99Oqgu96xpYWQ6ZeCrb96uRuP//zP6/6o4Ma2m2sOfsd2ViLO07B53G8ayeQ3MtT377FiSeQtA/17H1xLG4tUHEs81Mv241j49ZHGp4s/8y788EyX82jczJvyIfFsIGT/xCb+QL03T44lhcs/BYlro80tL3uewRnSN2njhdeOazH4O7llxIl3aeEtrykJzLfsW4/93M/52YsFkljFzKRbMLR5ZBtX3z88cf1K5Onln7Hv9E/TbQbOYcZ3Acatxbxooh5wYLVdu4SgMF5QVJ7irFDXLYuL6y/Mbb7xBz1FHGeJHnWE359xjHW8SITu+mDuLa+lGbHbQuOlfD0cnzpPRaJP7WqGT8yj256kLr0st8a5XY91vPrXCS1xm8/+7M/Cx85ZrQsE2eD0GJt5EDCT4nYTqpcbXwHMpXD2H0mIblOrge3fwKtTdA+yPRkvliE+XCh2VDwnZPgI/aNSLLBJ9LV4vrlgmMj92omH785m+1H7PPCgeKzjshciBJx/XKI16s6LuCb7kE4w9t27T/yLk5x5jGXPDJlt5/5mZ/BGyAL8SYzQR3yjm2JKWhNLXksL0gHXXk79KAvhclNk90fSw19GyOdCxiwX4JjE2P8kZUY6bj2/RKRe+XunGWFYxMMcITnmthLaAfDdx7vjSxvKr5TNWcuL0gB3GixedfQC7cxEt+6YI/Dm5hxJaz/dGnX+TE/P4mclIBh18Vqzrz58o6IZD81+Cx6sPCO26M42HCC03hq0OD0ny/tUXO3ZAHOp69r7tROPTWtrZUc74hjvlb49GGdWGoTT29Zx5l/65xLn+IzfnMXv7EtGD0ztnFZzxFfOX+ZZh5w0Ui/FA+QGJyafsnuvGe8aPelNfWt4vaPx0ix+uanHnlUv5Q+zb+8/fRP/7Q/p6nFCrRokvWPUfK0QTSw+XCYRGNuf/Kl2fJSbuOI67B+udQhHMYVNCBhPPW1bdoJCcDGGvsl0vUWu1okPoaJ8jgofoCaP1YS+KEWMSARjwNDWBD+sTBJc3LbJOYQggpx1kz4JhcRjueHFcV/CE3p9ARvbfZVkLk0wz8NXA4viCAbemD9cqyDsYkpA35x+6mf+qm5WKAk8LkIEAxIenjlgcEJZssLn+n4kmOENdg+yOuk6Y8lJ6lrywvSOSFmSRIOmbl0joyBT9ov4TxlkYVNuLC7Fln+I+wpiyz/EVwAyzp0iWyzdwj5cp6K24en4RRKjEl9McLxnuGyj2uc47DSc1+sCOXuF/vi9pM/+ZMHO0Ctmp4gtF+mGRSLXC8gFpcN2JcFizh7iHsGMjcTPl0OA6tFHea342u+NkK/iamlv8S0cK/vutrdq+6CHmENYk7YxLEIzulgsYS8YAc4y0Py8D3/hTlgT9nb7hewX840W7gJeuEqrXFOPF/G4Ds39vYTP/ETdxPXC4P0okgGroPNpgy2+LuPefvisOim67S2G4NPjvS9S9cYG9fSDV1g3eLuv8dBIIFxIeGUt9K2CTAGs7bitvRBqGc+cCS79pFf2x640rmABsKv5YWPRsYBawJZ/rlo1d47c8nmIX0AADyAbRR7++IXv3gCahkEl03KZjmtSWMf8bE5iMEi9U8WSg8N6aIkxSYnGac1HQdJCnEYaJoQ+2VJLhw6hxVKrSVBEzbbj32OdxAkdWX302DX9qljmBfsjhOcnk6YHnahaMU1TUqGVyf1CHF57n2Yw4q3n1T4x7vkIMxe3r7whS8cFQewPyZOh93L1Xdt+Uh9bN6Nd/O414uJ1N+2fZDgMSPDpeeet+TEJUASIg43Vn9jCH2vWOONL/9RDmm88OXeS0/QhA+f/e8lKl5/CaXFHvGa4zsbdknjE2/X7rGX3Vzb2+c///kTUItwsdaTwZhiH2QHyGFOnoOwI6kPZ/m+NPSg6Fofe7w0kFATMYxSS4Akhzhs/1rqy481dwoiuCuue8pjtn+1CWJskfEXWJcXNqLztG0yaz+ID/xtd0+k3Fqb3ROJz1OGATx+dGrqZw692MYltcOX0OfN7cd//Mevl8cWjAb11XiaSOwzGF/ojaQu0kZ3L6dk8kzUyIOYt8jDjbXT+TTGdJwr3lB5z4U3Refd7ySp3dzpgaz1Y30IkQOM07qEpx4Sh7xceeuwTjXbl9zDbS8lu2a4lyfUXb/cWoS1c9aR96q7/diP/dhgfkmAPNVwc3oxwArvQ6FHcYT4emj1MT1w/OKIaiasU8MLfbHI9q9c7D7U+M6VQLw5zSE7rn+Hc8rf8bHo/t6DbH/zRja/foyfOoV42RcpXLRPpsqVY9n+6nOtQ09rqO9/YBZgFKx+5V5uxxImvHP+TXPxSg+SPLacWN65/DjrJ8kea/vw72G8ILrsGkYDSbDJI8Y3f/fYeOL6WNeVE4s4h74jjxjXFJig/zLvCUmcfeA6Dj6anv7tdseJIv2/UGFN/i28sNHI8QX3XIe94qPq5fGe0P7Wfqv5t8997nOnJwgWFwzhEU2M4BQf8JD5LgOcfsadlThxWBa+ayfuPOBEis+Tcz0hbZaPPDgbLPmCEXauDiJfLR9ZsW3CR/yncOQpnzff+t3iPFk2J9L4hG/ePZ89X2d1qpVsvk1829uP/uiPngBk+/c++2t4QTafS8AiK0yshycpzyUouT2GxLmTc4gvV3ut73abdyo5BQkDPcIjJ1/KEwBrMDkW1z/t+EVyj3f1y0HqPsXZvoV9lPKPBRmbJ8mVN1yJcWxylfE3Htcv+yzY74s0NxxJWx0vR3C7ffazn92ABZ8wh2h/4/XtRJxJjXQuEz42HBsHkklI8BvWwdTlJdK0pQHj7I3okw2MuUhM5aVzQ+I7qOEFWw7OrpGccnYOwfeCkadqIn2jGGwOUtYx5LWu9jg3Cogb60t1uBYoR+HDHB6cA+TjE3fXVZ7DbR1JAtxuP/RDP3RkwkC2LzmFl6fLk3UcLCGbi+zc9pFLPKE29FHNpg5RsvLvPNDG+/KBcciZrzlaK0/GKYBHDd9l+sSE0z6bl9D/Tp4AHul8dPXynJ42h/vY3xJ+5eo/enrtPttHiOFnv/qnmsrwIqc6zNVH6Ie9/eAP/mAJk0R2fPXXQTjGRziY+ogzi8chRYxvAQArN/AjosY+5VbazhPxu3J74su1PBUP2PjCeyBKsi6HwTAVKLaOJAWWPCpQz9O8/XLED++OQ3D7FDOWi15u3NMY20fMDXFyq27nbrfPfOYzRyaMyo7xG7JBmtTmOoeSa1w5BQr1Do5ruaQf4p3APe+hZeJrAvmQC4jP3IM5jgw3+Ue1fgm8fATn0UEgwa7yUHjObzzm+TfgdmOZxzyN1qWybF/CIZbby4jYnqmOp6/8qb19//d/fwtOFc/F+HmUV3YaeTbmksS1kOzBcvH2pZCcaiUOFvYo/wz/lHtEvMTIcxx8zduXBwk8csUusf0FPTgHtvN3c8gdLjJOPl0mlszZ3eNLto+c4vS6+5QrgNy+7/u+r4d6sNZg9clz2D18hGR95BRIejlWzZWCDECSS8W7CeG7CbWVFmOKgxEvcfxEfuqXTD7zvBvvfnYkce83W7J5O/8E94Q9E+/H93ACrdT5O/EpIbnEvizRynN8SzDX7vzte7/3e08Xq3InjjnDsc7vRdw7DIT4CsVamm89wiUDQ9514BUznuDEvcbIqc+uQRJ7E1c8smPczvVejDTlYMkdDnKQVw0+PXkT9ymE7Hpk1yy5xshg1x7Inb5Pcm7f8z3f89QTC5kAvJyLTB352NOBXmM7ku3GjuwnHgK3tZmvf8LqEw7pBSTPRsvC90VI6fFy+OXdfTJuuWL3YqB7fYo3rjQt3fPzm5MfclhXQWLWk8szfVoj2Vj9TgZo8pFrjJywa03C9+Xcbt/93d+98/a7QU3sfKyxbtjybfeTq2LSksatachL5cqpj3EQKa9yjyPxRy2HUzoXEbsxLBfWgUQxvg8/sU19ajn48HwhEM13Lmx5YPjguSRTt+V9sHfFyD1M8k7sqborfAV2fPuu7/qu2QAt9rQZGAcS4pV7suEW8KaymUfTCz2xufAa81Jx8iLvwnDT7xEW3/hT2JIG2H6/oeDKxWnOEq6x+BX7gqbPsu25+dfvVR7jHibB3zEC1dhaK7d7c9rv1OuARhwE27xTv9t3fud3ThUdJLPJiIGLmPUOXvKG4yfz8FPJFojw0HD3vMbSc2OR98Lk92M/iAXYY24c8Cksvq3kwbn0jS1+j3cueL7niVtR/orf4xVj8vZTduLew5DLGL3g93g2vNy+4zu+YwiXBpW7MCB4Nzpi7I7cxTeI2159slXKW/TKh+Btc5UBV97c68WS3OXG3uNeDxK5x6+z+ZN8Qnb+Efc9x7O8Az9hiPCN3Z3z7du//dsL2vByEfPRr9YlWvIh3MHvPPGM3ym7h0/w3+HLv/f0Qu71qFxzd0mSR3jGu36cVqbvejNsng//UrsvhA0vlQt25SKb/+hj/vZt3/ZtD8xz0k2yedfUyJOJp1N3ccD32bgtT3DfC9+Up/hIc9e5bf8i7+y1Bexd664syr0+8Sb37MVBnhizc7nHj/dkbvDbt37rt25Set6VT5T7REVK+eXDSwe8k3eNzvBuLvaam5oEtpErMZ7lnbkLVnmq7h55X8ba97lM8e72fLIOWeNV9nin3O2bv/mb55GO7O83dzb02niExuX18HZf4hKufYkZt3XFtlBLrpzFPQokiS2td1Gk7u698oAO79Xek+fyK+e+h3tIc5g9l8qqfSTP5ZBL/jT2B9ae5ENrb5/+9KdPF+upBsBPbXhzyz7q0Vx854vtHNL8c7I5da+9NucqST07zlP1wBmLPIM9N84nylWe4gC/zzqR/+k8cuXcvumbvula9En6nKSb/hSnG3J9St2RSVw5102912NxbBxI7nElJ/DK6ZoSWt7RZy7ctSz2JO/Bcb/Fw5kxtlw4T8pu9pSE8sF9bt/4jd/4CLxHBOpBVe7xrhLK8XKnx5an+l3rds/n5Kl+Vwnv7iFVnhuT3GV+7xz3fTjIE7y7c32fnu/DQf67vNs3fMM3TAJON4iCxlhk5d57I6+1yObjPtUX2dz3kaf4/5O978n7cqExrw/pjdzhNz4vUhIu+DvHuNP3WXmKf/v6r//6JxtdiwizCf/tQ4pMzQeUP5rTO+QR4R01d/ld9zOi9KN9eerXCMhdvD3ulD07eOVSt4NnL9aq+9Cau/nb133d1z1ZKFHtc+l3CsXPbe5TcuJ/YPld8nv2eESirpflHT1OyV1Xeab+vSZXufT5oFpk1X9wLZL6Z2tvX/u1X/uu5keXpzflfWSKP2Gfu0Uf2OtJ8gf02cR5N1O/LtEHP6Uk5xsY+QR9tpx6Xnq9T/09cU+1evzH3ovcPvWpTz07SOeTx/O7for7JPKo2Vep/3ut6wPlvYs+oP+HTGQuc+WJcT6k5ztljfHefW/877TH/yRyqv0qXYj3kfce6Ks8pyebMc71o++OzMX4gHl9VRfwnFzm9N8ad/67t6+GdGOvm6z4g8b4QPr/Sfm/bmKfYK/+j6xB53/+L2b+vzwtH/oG+X9XXrz433LUIQNpxx2DAAAAAElFTkSuQmCC")
        })

        local saturationpicker = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Parent = saturation,
            Color = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(0, 2, 0, 2),
            ZIndex = 66
        })

        Library:NewOutline(saturationpicker, "Border1",66)

        local hueframe = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Parent = window,
            Size = UDim2.new(0,15, 0, 150),
            Position = UDim2.new(0, 165, 0, 20),
            ZIndex = 66
        })

        local hueoutline = Library:NewOutline(hueframe, "Border2",66)
        Library:NewOutline(hueoutline, "Border1", 65)

        Library:NewDrawing("Image", {
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 66,
            Parent = hueframe,
            Data = Decode("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")
        })

        local huepicker = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Parent = hueframe,
            Color = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(1,0,0,1),
            ZIndex = 66,
            Visible = true
        })

        Library:NewOutline(huepicker, "Border1",66)

        local alphaframe = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 1,
            Size = UDim2.new(0, 15, 0, 150),
            Position = UDim2.new(1, -20, 0, 20),
            ZIndex = 66,
            Parent = window
        })

        local alpoutline = Library:NewOutline(alphaframe, "Border2",66)
        Library:NewOutline(alpoutline, "Border1", 65)

        Library:NewDrawing("Image", {
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 66,
            Transparency = 1,
            Parent = alphaframe,
            Data = Decode("iVBORw0KGgoAAAANSUhEUgAAAAkAAABuCAYAAAD1YDnyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAFMSURBVFhHvZMhTMNQFEX/WOZwKBwON4dDNMHN4XBzc3M43BwOh8PhULip1s3hcLg53Nxcue9mIy/ty/8kDfcktzlpsv97xEZ1XacjVVUdLKWmaQ6W0slfNmrbdgIh/tf+1PCX3YUvu7MPP4WQQR8evuzO6s4gRFN3DiG5unFpvaOjWd0FhOTqwiv8ekdHs7pLCNHUTSFEU3cFIZq6awjR1N1AiKZuBiG5uuLsEX6Hn9XdQkiurjh7hFf4Wd0dhGjq5hCiqVtAiKZuCSGaunsI0dQ9QMjguuKsbgUhg+uKs7pHCNHUPUGIpu4ZQjR1LxCiqXuFEE3dG4Ro6t4hJFcX/mv9ekdHs7o1hOTqwiv8ekdHs7rfOzR1GwjR1H1AiKbuE0I0dV8QoqnbQkiurjh7hN/hZ3XfEJKrK84e4RV+VreDEE3dHkL+uy6NfwDz0OfO0eCa+AAAAABJRU5ErkJggg==")
        })

        local alphapicker = Library:NewDrawing("Square", {
            Filled = true,
            Thickness = 0,
            Parent = alphaframe,
            Color = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(1, 0, 0, 1),
            ZIndex = 67,
            Visible = true
        })

        Library:NewOutline(alphapicker, "Border1",66)

        local rgbinput = Library:NewDrawing("Square", {
            Filled = true,
            Transparency = 1,
            Thickness = 1,
            Theme = "Dark Contrast",
            Size = UDim2.new(1, -12, 0, 14),
            Position = UDim2.new(0, 6, 0, 180),
            ZIndex = 66,
            Parent = window
        })

        local outline2 = Library:NewOutline(rgbinput, "Border2",66)
        Library:NewOutline(outline2, "Border1",66)

        local text = Library:NewDrawing("Text", {
            Text = string.format("%s, %s, %s", math.floor(default.R * 255), math.floor(default.G * 255), math.floor(default.B * 255)),
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Position = UDim2.new(0.5, 0, 0, 0),
            Center = true,
            Theme = "Text",
            ZIndex = 67,
            Outline = false,
            Parent = rgbinput
        })
        local textshadow = Library:NewDrawing("Text", {
            Text = string.format("%s, %s, %s", math.floor(default.R * 255), math.floor(default.G * 255), math.floor(default.B * 255)),
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Position = UDim2.new(0.5, 1, 0, 1),
            Center = true,
            Color = Color3.new(0,0,0),
            ZIndex = 66,
            Outline = false,
            Parent = rgbinput
        })

        local mouseover = false

        local hue, sat, val = default:ToHSV()
        local hsv = default:ToHSV()
        local alpha = defaultalpha
        local oldcolor = hsv
        local toggled = false;
        local fadetoggled = false;

        local function set(color, a, nopos, setcolor)
            if type(color) == "table" then
                a = color[4]
                color = Color3.fromHSV(color[1], color[2], color[3])
            end

            if type(color) == "string" then
                color = Color3.fromHex(color)
            end

            local oldcolor = hsv
            local oldalpha = alpha

            hue, sat, val = color:ToHSV()
            alpha = a or 1
            hsv = Color3.fromHSV(hue, sat, val)

            if hsv ~= oldcolor or alpha ~= oldalpha then
                icon.Color = hsv
                alphaframe.Color = hsv
                alphaicon.Transparency = 1 - alpha

                if not nopos then
                    saturationpicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 2)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 2)))
                    huepicker.Position = UDim2.new(0, math.clamp(hue * hueframe.AbsoluteSize.X, 0, hueframe.AbsoluteSize.X - 2), 0, 0)
                    alphapicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - alpha) * alphaframe.AbsoluteSize.Y, 0, alphaframe.AbsoluteSize.Y - 2))
                    if setcolor then
                        saturation.Color = Color3.fromHSV(hue,1,1)
                    end
                end

                text.Text = string.format("%s, %s, %s", math.round(hsv.R * 255), math.round(hsv.G * 255), math.round(hsv.B * 255))
                textshadow.Text = string.format("%s, %s, %s", math.round(hsv.R * 255), math.round(hsv.G * 255), math.round(hsv.B * 255))

                if flag then 
                    Library.Flags[flag] = Library:RGBA(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha)
                end

                callback(Library:RGBA(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha))

            end
        end
        
        Flags[flag] = set

        set(default, defaultalpha)

        local defhue, _, _ = default:ToHSV()

        local curhuesizey = defhue

        local function updatesatval(input, set_callback)
            local sizeX = math.clamp((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X, 0, 1)
            local sizeY = 1 - math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) + 36) / saturation.AbsoluteSize.Y, 0, 1)
            local posY = math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y) * saturation.AbsoluteSize.Y + 36, 0, saturation.AbsoluteSize.Y - 2)
            local posX = math.clamp(((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X) * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 2)

            saturationpicker.Position = UDim2.new(0, posX, 0, posY)

            if set_callback then
                set(Color3.fromHSV(curhuesizey or hue, sizeX, sizeY), alpha or defaultalpha, true, false)
            end
        end

        local slidingsaturation = false

        saturation.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                slidingsaturation = true
                updatesatval(input)
            end
        end)

        saturation.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                slidingsaturation = false
                updatesatval(input, true)
            end
        end)

        local slidinghue = false

        local function updatehue(input, set_callback)
            local sizeY = 1 - math.clamp(((input.Position.Y - hueframe.AbsolutePosition.Y) + 36) / hueframe.AbsoluteSize.Y, 0, 1)
            local posY = math.clamp(((input.Position.Y - hueframe.AbsolutePosition.Y) / hueframe.AbsoluteSize.Y) * hueframe.AbsoluteSize.Y + 36, 0, hueframe.AbsoluteSize.Y - 2)

            huepicker.Position = UDim2.new(0, 0, 0, posY)
            saturation.Color = Color3.fromHSV(sizeY, 1, 1)
            curhuesizey = sizeY
            if set_callback then
            set(Color3.fromHSV(sizeY, sat, val), alpha or defaultalpha, true, true)
            end
        end

        hueframe.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                slidinghue = true
                updatehue(input)
            end
        end)

        hueframe.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                slidinghue = false
                updatehue(input, true)
            end
        end)

        local slidingalpha = false

        local function updatealpha(input, set_callback)
            local sizeY = 1 - math.clamp(((input.Position.Y - alphaframe.AbsolutePosition.Y) + 36) / alphaframe.AbsoluteSize.Y, 0, 1)
            local posY = math.clamp(((input.Position.Y - alphaframe.AbsolutePosition.Y) / alphaframe.AbsoluteSize.Y) * alphaframe.AbsoluteSize.Y + 36, 0, alphaframe.AbsoluteSize.Y - 2)

            alphapicker.Position = UDim2.new(0, 0, 0, posY)
            if set_callback then
            set(Color3.fromHSV(curhuesizey, sat, val), sizeY, true)
            end
        end

        alphaframe.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                slidingalpha = true
                updatealpha(input)
            end
        end)

        alphaframe.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                slidingalpha = false
                updatealpha(input, true)
            end
        end)

        Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if slidingalpha then
                    updatealpha(input)
                end

                if slidinghue then
                    updatehue(input)
                end

                if slidingsaturation then
                    updatesatval(input)
                end
            end
        end)

        icon.MouseButton1Click:Connect(function()
            for _, picker in next, Pickers do
                if picker ~= window then
                    picker.Visible = false
                end
            end

            window.Visible = not window.Visible

            if slidinghue then
                slidinghue = false
            end

            if slidingsaturation then
                slidingsaturation = false
            end

            if slidingalpha then
                slidingalpha = false
            end
        end)

        local colorpickertypes = {}

        function colorpickertypes:Set(color, alpha)
            set(color)
            updatealpha(alpha)
        end

        return colorpickertypes, window
    end;
    --
    function Library:NewBox(box, text, textshadow, callback, finishedcallback)
        local max_size = box.AbsoluteSize.X - 44
        local current_uncut_str = ""
        local string = ""
        local function update_text(str)
            local will_cut = Library:GetTextLength(str, 2, 13).X > max_size
            current_uncut_str = not will_cut and str or current_uncut_str

            text.Text = current_uncut_str .. (will_cut and "..." or "") 
            textshadow.Text = current_uncut_str .. (will_cut and "..." or "")
        end
        box.MouseButton1Click:Connect(function()
            Library:ChangeObjectTheme(text, "Accent")
            game:GetService("ContextActionService"):BindActionAtPriority("disablekeyboard", function() return Enum.ContextActionResult.Sink end, false, 3000, Enum.UserInputType.Keyboard)

            local connection
            local backspaceconnection

            local keyqueue = 0

            if not connection then
                connection = Library:Connection(game:GetService("UserInputService").InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode ~= Enum.KeyCode.Backspace then
                            local str = game:GetService("UserInputService"):GetStringForKeyCode(input.KeyCode)

                            if table.find(Library.AllowedCharacters, str) then
                                keyqueue = keyqueue + 1
                                local currentqueue = keyqueue

                                if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightShift) and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                                    string = string .. str:lower()
                                    update_text(string)

                                    callback(text.Text)

                                    local ended = false

                                    coroutine.wrap(function()
                                        task.wait(0.5)

                                        while game:GetService("UserInputService"):IsKeyDown(input.KeyCode) and currentqueue == keyqueue  do
                                            string = string .. str:lower()
                                            update_text(string)
                                            callback(text.Text)

                                            task.wait(0.02)
                                        end
                                    end)()
                                else
                                    string = string .. (Library.ShiftCharacters[str] or str:upper())
                                    update_text(string)
                                    callback(text.Text)

                                    coroutine.wrap(function()
                                        task.wait(0.5)

                                        while game:GetService("UserInputService"):IsKeyDown(input.KeyCode) and currentqueue == keyqueue  do
                                            string = string .. (Library.ShiftCharacters[str] or str:upper())
                                            update_text(string)
                                            callback(text.Text)

                                            task.wait(0.02)
                                        end
                                    end)()
                                end
                            end
                        end

                        if input.KeyCode == Enum.KeyCode.Return then
                            game:GetService("ContextActionService"):UnbindAction("disablekeyboard")
                            Library:Disconnect(backspaceconnection)
                            Library:Disconnect(connection)
                            finishedcallback(text.Text)
                            Library:ChangeObjectTheme(text, "Text")
                        end
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        game:GetService("ContextActionService"):UnbindAction("disablekeyboard")
                        Library:Disconnect(backspaceconnection)
                        Library:Disconnect(connection)
                        finishedcallback(text.Text)
                        Library:ChangeObjectTheme(text, "Text")
                    end
                end)

                local backspacequeue = 0

                backspaceconnection = Library:Connection(game:GetService("UserInputService").InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Backspace then
                        backspacequeue = backspacequeue + 1
                        string = string:sub(1, -2)
                        update_text(string)
                        callback(text.Text)

                        local currentqueue = backspacequeue

                        coroutine.wrap(function()
                            task.wait(0.5)

                            if backspacequeue == currentqueue then
                                while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Backspace) do
                                    string = string:sub(1, -2)
                                    update_text(string)
                                    callback(text.Text)

                                    task.wait(0.02)
                                end
                            end
                        end)()
                    end
                end)
            end
        end)
    end;
end;

-- // Main Elements
do
    local Pages = Library.Pages;
    local Sections = Library.Sections;
    --
    function Library:Window(Properties)
        local Window = {
            Pages = {};
            PageAxis = 0;
            Dragging = {false, UDim2.new(0, 0, 0, 0)};
            Resizing = {false, UDim2.new(0, 0, 0, 0), UDim2.new(0, 0, 0, 0)};
            Resized = nil;
            Elements = {};
        };

        -- // Drawings
        local MainFrame = Library:NewDrawing("Square", {
            Visible = true;
            Filled = true;
            Thickness = 1;
            Theme = "Light Contrast";
            Size = Properties.Size or UDim2.new(0, 500, 0, 600);
            Position = UDim2.new(0, 100, 0, 100);
            ZIndex = 50;
        });
        Library:NewOutline(MainFrame, "Border1")
        local MainFrameOutline = Library:NewDrawing("Square", {
            Visible = true;
            Filled = false;
            Thickness = 1;
            Theme = "Accent";
            Size = UDim2.new(1,4,1,4);
            Position = UDim2.new(0,-2,0,-2);
            ZIndex = MainFrame.ZIndex - 1;
            Parent = MainFrame;
        });
        Library:NewOutline(MainFrameOutline, "Border1")
        local InnerFrame = Library:NewDrawing("Square", {
            Visible = true;
            Filled = true;
            Thickness = 1;
            Theme = "Dark Contrast";
            Size = UDim2.new(1,-10,1,-25);
            Position = UDim2.new(0,5,0,20);
            ZIndex = 51;
            Parent = MainFrame;
        });
        Library:NewOutline(InnerFrame, "Border1")
        local InnerFrameOutline = Library:NewDrawing("Square", {
            Visible = true;
            Filled = false;
            Thickness = 1;
            Theme = "Border2";
            Size = UDim2.new(1,4,1,4);
            Position = UDim2.new(0,-2,0,-2);
            ZIndex = InnerFrame.ZIndex - 1;
            Parent = InnerFrame;
        });

        -- Title
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 4, 0, 2);
            Parent = MainFrame;
            ZIndex = 51;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 5, 0, 3);
            Parent = MainFrame;
            ZIndex = 50;
        });

        -- Sub Title
        local SubTitle = Library:NewDrawing("Text", {
            Text = Properties.Sub or "Title";
            Size = 13;
            Font = 2;
            Theme = "Accent";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 4 + Title.TextBounds.X, 0, 2);
            Parent = MainFrame;
            ZIndex = 51;
        });
        local SubTitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Sub or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 5 + Title.TextBounds.X, 0, 3);
            Parent = MainFrame;
            ZIndex = 50;
        });

        -- Extra
        local Extra = Library:NewDrawing("Text", {
            Text = Properties.Extra or "";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 10 + Title.TextBounds.X + SubTitle.TextBounds.X, 0, 2);
            Parent = MainFrame;
            ZIndex = 51;
        });
        local ExtraShadow = Library:NewDrawing("Text", {
            Text = Properties.Extra or "";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 11 + Title.TextBounds.X + SubTitle.TextBounds.X, 0, 3);
            Parent = MainFrame;
            ZIndex = 50;
        });

        -- // Set name
        function Window:SetName(TitleS, Sub, ExtraS)
            Title.Text = TitleS;
            TitleShadow.Text = TitleS;
            SubTitle.Text = Sub;
            SubTitleShadow.Text = Sub;
            Extra.Text = ExtraS;
            ExtraShadow.Text = ExtraS;

            -- Reposition
            Title.Position = UDim2.new(0, 4, 0, 2);
            TitleShadow.Position = UDim2.new(0, 5, 0, 3);
            SubTitle.Position = UDim2.new(0, 4 + Title.TextBounds.X, 0, 2);
            SubTitleShadow.Position = UDim2.new(0, 5 + Title.TextBounds.X, 0, 3);
            Extra.Position = UDim2.new(0, 10 + Title.TextBounds.X + SubTitle.TextBounds.X, 0, 2);
            ExtraShadow.Position = UDim2.new(0, 11 + Title.TextBounds.X + SubTitle.TextBounds.X, 0, 3);
        end;

        -- Rest
        local TabButtonHolder = Library:NewDrawing("Square", {
            Visible = true;
            Filled = true;
            Thickness = 1;
            Transparency = 1;
            Size = UDim2.new(1,-20,0, 20);
            Position = UDim2.new(0,10,0,15);
            ZIndex = 52;
            Parent = InnerFrame;
        });
        local TabButtonHolderOutline = Library:NewDrawing("Square", {
            Visible = true;
            Filled = false;
            Thickness = 1;
            Transparency = 1;
            Size = UDim2.new(1,4,1,4);
            Position = UDim2.new(0,-2,0,-2);
            ZIndex = 51;
            Parent = TabButtonHolder;
            Theme = "Border2";
        });
        local Cursor = Library:NewDrawing('Quad', {
            Theme = "Accent",
            Visible = true,
            Filled = true,
            ZIndex = 1000,
        })
        local CursorOutline = Library:NewDrawing('Quad', {
            Theme = "Border1",
            Visible = true,
            Filled = true,
            ZIndex = 999,
        })
        game:GetService("UserInputService").MouseIconEnabled = not Library.Open

        -- // Buttons
        local Dragger = Library:NewDrawing("Square", {
            Parent = MainFrame,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            ZIndex = 50,
            Size = UDim2.new(1, -2, 0, 14),
            Position = UDim2.new(0, 1, 0, 1);
            ZIndex = 50;
        });

        -- // Dragging
        Library:Connection(Dragger.MouseButton1Down, function()
            local Location = game:GetService("UserInputService"):GetMouseLocation();
            Window.Dragging[1] = true;
            Window.Dragging[2] = UDim2.new(0, Location.X - MainFrame.AbsolutePosition.X, 0, Location.Y - MainFrame.AbsolutePosition.Y);
        end);
        Library:Connection(Dragger.MouseButton1Up, function()
            Window.Dragging[1] = false;
            Window.Dragging[2] = UDim2.new(0, 0, 0, 0);
        end);
        Library:Connection(game:GetService("UserInputService").InputChanged, function(Input)
            local Location = game:GetService("UserInputService"):GetMouseLocation();
            local ActualLocation = nil;
            if Window.Dragging[1] then
                --ActualLocation = Vector2.new(math.clamp(Location.X, 9, (workspace.CurrentCamera.ViewportSize.X + 9) - MainFrame.AbsoluteSize.X), math.clamp(Location.Y, 23, (workspace.CurrentCamera.ViewportSize.Y + 23) - MainFrame.AbsoluteSize.Y))
                MainFrame.Position = UDim2.new(0, Location.X - Window.Dragging[2].X.Offset, 0, Location.Y - Window.Dragging[2].Y.Offset);
                --MainFrame.Position = UDim2.new(0, ActualLocation.X - Window.Dragging[2].X.Offset, 0, Location.Y - Window.Dragging[2].Y.Offset);
            end;
            if Input.UserInputType == Enum.UserInputType.MouseMovement and Library.Open then
                if Cursor.Visible then
                    Cursor.PointA = Location
                    Cursor.PointB = Location + Vector2.new(10,8)
                    Cursor.PointC = Location + Vector2.new(4,8)
                    Cursor.PointD = Location + Vector2.new(0,13)
                    CursorOutline.PointA = Cursor.PointA + Vector2.new(-1,-2)
                    CursorOutline.PointB = Cursor.PointB + Vector2.new(2,0)
                    CursorOutline.PointC = Cursor.PointC + Vector2.new(-1,3)
                    CursorOutline.PointD = Cursor.PointD + Vector2.new(-1,2)
                end
            end;
        end);

        -- // Functions
        function Window:UpdateTabs()
            for Index, Page in pairs(Window.Pages) do
                Page.Elements.PageButtonOutline.Size = UDim2.new(1 / #self.Pages, Index == #self.Pages and 1 or 1, 1, 0)
                Page.Elements.PageButtonOutline.Position = UDim2.new((Index - 1) * (1 / #self.Pages), 0, 0, 0)
                Page:Turn(Page.Open)
            end;
        end;
        --
        function Window:Update() -- Shitty Fix :(
            MainFrame.Position = UDim2.new(MainFrame.Position.X.Scale,MainFrame.Position.X.Offset,MainFrame.Position.Y.Scale,MainFrame.Position.Y.Offset);
        end;
        --
        function Window:GetConfig()
            local configtbl = {}
            for flag, _ in next, flags do
                local value = Library.Flags[flag]

                if typeof(value) == "EnumItem" then
                    configtbl[flag] = tostring(value)
                elseif typeof(value) == "Color3" then
                    configtbl[flag] = {color = value:ToHex(), alpha = value.A}
                else
                    configtbl[flag] = value
                end
            end
            local config = game:GetService("HttpService"):JSONEncode(configtbl)
            --
            return config
        end;

        -- // Elements
        Window.Elements = {
            MainFrame = MainFrame;
            MainFrameInner = InnerFrame;
            MainFrameInner2 = InnerFrameOutline;
            Title = Title;
            TitleShadow = TitleShadow;
            MainFrameOutline = MainFrameOutline;
            TabFrame = TabButtonHolder;
        };

        -- // Returns
        return debug.setmetatable(Window, Library);
    end;
    --
    function Library:Tab(Properties)
        local Page = {
            Window = self;
            Open = false;
            Sections = {};
            Elements = {};
        };

        -- // Drawings
        local TabInnerFrame = Library:NewDrawing("Square", {
            Visible = true;
            Filled = true;
            Thickness = 1;
            Theme = "Light Contrast";
            ZIndex = 52;
            Parent = Page.Window.Elements.TabFrame;
            Size = UDim2.new(1,0,1,0);
        });
        Library:NewOutline(TabInnerFrame, "Border1", 52)
        local AccentLine = Library:NewDrawing("Square", {
            Visible = Page.Open;
            Filled = true;
            Thickness = 1;
            Theme = "Accent";
            ZIndex = 53;
            Parent = TabInnerFrame;
            Size = not Properties.TabLine and UDim2.new(1,-2,0,2) or UDim2.new(1,0,0,2);
            Position = UDim2.new(0,0,0,0);
        });
        local TabTitle = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 2, 0, 4);
            Parent = TabInnerFrame;
            ZIndex = 53;
        });
        local TabTitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 3, 0, 5);
            Parent = TabInnerFrame;
            ZIndex = 52;
        });
        local TabHolder = Library:NewDrawing("Square", {
            Visible = false;
            Filled = true;
            Thickness = 1;
            Transparency = 0;
            Color = Color3.fromRGB(20, 20, 25);
            Size = UDim2.new(1, -20, 1, -80);
            Position = UDim2.new(0, 10, 0, 50);
            Parent = Page.Window.Elements.MainFrameInner;
            ZIndex = 51;
        });

        -- // Section Holders
        local Left = Library:NewDrawing("Square", {Transparency = 0, Filled = false, Thickness = 1, ZIndex = 51,Parent = TabHolder, Size = UDim2.new(0.5, -14, 1, -10), Position = UDim2.new(0, -2, 0, 0)});
        local Right = Library:NewDrawing("Square", {Transparency = 0, Filled = false, Thickness = 1, Parent = TabHolder, ZIndex = 51, Size = UDim2.new(0.5, -14, 1, -10),Position = UDim2.new(0.5, 16, 0, 0)});
        Left:AddListLayout(3);
        Right:AddListLayout(3);

        -- // Hover Effect
        Library:Connection(TabInnerFrame.MouseEnter, function()
            Library.ThemeObjects[TabTitle] = Library.Theme["Accent"];
            TabTitle.Color = Library.Theme["Accent"];
        end);
        --
        Library:Connection(TabInnerFrame.MouseLeave, function()
            Library.ThemeObjects[TabTitle] = Library.Theme["Text"];
            TabTitle.Color = Library.Theme["Text"];
        end);

        -- // Open Page
        function Page:Turn(bool)
            Page.Open = bool
            AccentLine.Visible = Page.Open
            TabHolder.Visible = Page.Open
        end;

        Library:Connection(TabInnerFrame.MouseButton1Click, function()
            if not Page.Open then
                Page:Turn(true)
                for index, other_page in pairs(Page.Window.Pages) do
                    if other_page.Open and other_page ~= Page then
                        other_page:Turn(false)
                    end
                end
            end
        end)
        
        if #Page.Window.Pages == 0 then
            Page:Turn(true);
        end;

        -- // Elements
        Page.Elements = {
            PageButtonOutline = TabInnerFrame;
            Title = TabTitle;
            TabHolder = TabHolder;
            Left = Left;
            Right = Right;
        };

        Page.Window.Pages[#Page.Window.Pages + 1] = Page;
        Page.Window:UpdateTabs();
        return debug.setmetatable(Page, Library.Pages);
    end;
    --
    function Pages:NestedTab(Properties)

        -- // Drawings
        local TabButtonHolder = Library:NewDrawing("Square", {
            Visible = true;
            Filled = true;
            Thickness = 1;
            Transparency = 1;
            Size = UDim2.new(1,-20,0, 20);
            Position = UDim2.new(0,10,0,15);
            ZIndex = 52;
            Parent = InnerFrame;
        });
        local TabButtonHolderOutline = Library:NewDrawing("Square", {
            Visible = true;
            Filled = false;
            Thickness = 1;
            Transparency = 1;
            Size = UDim2.new(1,4,1,4);
            Position = UDim2.new(0,-2,0,-2);
            ZIndex = 51;
            Parent = TabButtonHolder;
            Theme = "Border2";
        });
    end;
    --
    function Pages:Section(Properties)
        local Section = {
            Window = self.Window,
            Page = self,
            Open = false,
            Side = (Properties.side or Properties.Side or "left"):lower(),
            Content = {},
            ContentAxis = 0;
            Elements = {};
        };

        -- // Drawings
        local SectionHolderOutline = Library:NewDrawing("Square", {
            Parent = (Section.Side == "right" and Section.Page.Elements.Right or Section.Side == "left" and Section.Page.Elements.Left or Section.Page.Elements.Left),
            Visible = true,
            Filled = true,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Border1",
            Size = UDim2.new(1,0,0,20)
        });

        local SectionHolderInline = Library:NewDrawing("Square", {
            Parent = SectionHolderOutline,
            Visible = true,
            Filled = false,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Border2",
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1)
        });
        local SectionHolderMain = Library:NewDrawing("Square", {
            Parent = SectionHolderInline,
            Visible = true,
            Filled = true,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Dark Contrast",
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1),
        });
        Library:NewOutline(SectionHolderMain, "Border1")
        --[[local TopBarOutline = Library:NewDrawing("Square", {
            Parent = SectionHolderOutline,
            Visible = true,
            Filled = true,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Accent",
            Size = UDim2.new(1, -4, 0, 1),
            Position = UDim2.new(0, 2, 0, 2),
        });]]
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 2, 0, 0);
            Parent = SectionHolderMain;
            ZIndex = 54;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 3, 0, 1);
            Parent = SectionHolderMain;
            ZIndex = 53;
        });
        local SectionContent = Library:NewDrawing("Square", {
            Transparency = 0,
            Size = UDim2.new(1, -22, 1, -28),
            Position = UDim2.new(0, 8, 0, 20),
            Parent = SectionHolderOutline,
            ZIndex = 53,
            Thickness = 0,
            Filled = false
        });
        SectionContent:AddListLayout(3);

        -- // Elements
        Section.Elements = {
            SectionHolderOutline = SectionHolderOutline;
            SectionHolderInline = SectionHolderInline;
            SectionHolderMain = SectionHolderMain;
            TopBarOutline = TopBarOutline;
            SectionContent = SectionContent;
        }

        -- // Functions
        function Section:Update(Value)
            SectionHolderOutline.Size = UDim2.new(1,0, 0, SectionContent.AbsoluteContentSize + Value)
        end;

        -- // Returning
        Section.Page.Sections[#Section.Page.Sections + 1] = Section;
        return debug.setmetatable(Section, Library.Sections)
    end;
    --
    function Pages:MultiSection(Properties)
        local Section = {
            Window = self.Window,
            Page = self,
            Open = false,
            Sections = (Properties.sections or Properties.Sections or {}),
            Side = (Properties.side or Properties.Side or "left"):lower(),
            --Size = (Properties.size or Properties.Size or 200),
            NoUpdate = true,
            Content = {},
            ContentAxis = 0;
            Elements = {};
            ActualSections = {};
        };

        -- // Drawings
        local SectionHolderOutline = Library:NewDrawing("Square", {
            Parent = (Section.Side == "right" and Section.Page.Elements.Right or Section.Side == "left" and Section.Page.Elements.Left or Section.Page.Elements.Left),
            Visible = true,
            Filled = true,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Border1",
            Size = UDim2.new(1,0,0,0)
        });

        local SectionHolderInline = Library:NewDrawing("Square", {
            Parent = SectionHolderOutline,
            Visible = true,
            Filled = false,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Border2",
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1)
        });
        local SectionHolderMain = Library:NewDrawing("Square", {
            Parent = SectionHolderInline,
            Visible = true,
            Filled = true,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Dark Contrast",
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1),
        });
        Library:NewOutline(SectionHolderMain, "Border1")
        --[[local TopBarOutline = Library:NewDrawing("Square", {
            Parent = SectionHolderOutline,
            Visible = true,
            Filled = true,
            Thickness = 1,
            ZIndex = 53,
            Theme = "Accent",
            Size = UDim2.new(1, -4, 0, 1),
            Position = UDim2.new(0, 2, 0, 2),
        });]]
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 2, 0, 0);
            Parent = SectionHolderMain;
            ZIndex = 54;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 3, 0, 1);
            Parent = SectionHolderMain;
            ZIndex = 53;
        });
        local SectionButtonHolder = Library:NewDrawing("Square", {
            Visible = true;
            Filled = true;
            Thickness = 1;
            Transparency = 1;
            Size = UDim2.new(1,-14,0, 20);
            Position = UDim2.new(0,7,0,20);
            ZIndex = 54;
            Parent = SectionHolderMain;
        });
        local SectionButtonHolderOutline = Library:NewDrawing("Square", {
            Visible = true;
            Filled = false;
            Thickness = 1;
            Transparency = 1;
            Size = UDim2.new(1,4,1,4);
            Position = UDim2.new(0,-2,0,-2);
            ZIndex = 53;
            Parent = SectionButtonHolder;
            Theme = "Border2";
        });
        
        -- // Elements
        Section.Elements = {
            SectionHolderOutline = SectionHolderOutline;
            SectionButtonHolder = SectionButtonHolder;
            SectionHolderInline = SectionHolderInline;
            SectionHolderMain = SectionHolderMain;
            TopBarOutline = TopBarOutline;
        }
        local SectionShit = Section.Sections;
        local SectionShit2 = Section;
        local SectionButtons = {};

        for I, V in next, SectionShit do
            local MultiSection = {
                Window = self.Window,
                Page = self.Page,
                Section = self,
                Open = false,
                Content = {},
                NoUpdate = true,
                ContentAxis = 0;
                Elements = {};
            };

            -- // Drawings
            local TabInnerFrame = Library:NewDrawing("Square", {
                Visible = true;
                Filled = true;
                Thickness = 1;
                Theme = "Light Contrast";
                ZIndex = 54;
                Parent = SectionButtonHolder;
                Size = UDim2.new(1,0,1,0);
            });
            Library:NewOutline(TabInnerFrame, "Border1", 54)
            if not Properties.TabLine then
                local TabLine = Library:NewDrawing("Square", {
                    Visible = true;
                    Filled = true;
                    Thickness = 1;
                    Theme = "Border1";
                    ZIndex = 53;
                    Parent = TabInnerFrame;
                    Size = UDim2.new(0,1,1,0);
                    Position = UDim2.new(1,-2,0,0);
                });
            end;
            local AccentLine = Library:NewDrawing("Square", {
                Visible = MultiSection.Open;
                Filled = true;
                Thickness = 1;
                Theme = "Accent";
                ZIndex = 54;
                Parent = TabInnerFrame;
                Size = UDim2.new(1,0,0,2);
                Position = UDim2.new(0,0,0,0);
            });
            local TabTitle = Library:NewDrawing("Text", {
                Text = V or "Title";
                Size = 13;
                Font = 2;
                Theme = "Text";
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 2, 0, 4);
                Parent = TabInnerFrame;
                ZIndex = 55;
            });
            local TabTitleShadow = Library:NewDrawing("Text", {
                Text = V or "Title";
                Size = 13;
                Font = 2;
                Color = Color3.fromRGB();
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 3, 0, 5);
                Parent = TabInnerFrame;
                ZIndex = 54;
            });
            local SectionContent = Library:NewDrawing("Square", {
                Transparency = 0,
                Size = UDim2.new(1, -22, 1, -28),
                Position = UDim2.new(0, 8, 0, 50),
                Parent = SectionHolderOutline,
                ZIndex = 53,
                Thickness = 0,
                Filled = false,
                Visible = false
            });
            SectionContent:AddListLayout(3);
            table.insert(SectionButtons, TabInnerFrame)

            -- // Functions
            Library:Connection(TabInnerFrame.MouseEnter, function()
                Library.ThemeObjects[TabTitle] = Library.Theme["Accent"];
                TabTitle.Color = Library.Theme["Accent"];
            end);
            --
            Library:Connection(TabInnerFrame.MouseLeave, function()
                Library.ThemeObjects[TabTitle] = Library.Theme["Text"];
                TabTitle.Color = Library.Theme["Text"];
            end);

            -- // Update
            for Index, Section in next, SectionButtons do
                Section.Size = UDim2.new(1 / #SectionButtons, Index == #SectionButtons and 0 or 1, 1, 0)
                Section.Position = UDim2.new((Index - 1) * (1 / #SectionButtons), 0, 0, 0)
            end;

            -- // Open MultiSection
            function MultiSection:Turn(bool)
                MultiSection.Open = bool
                AccentLine.Visible = MultiSection.Open
                SectionContent.Visible = MultiSection.Open
                if bool then
                    SectionHolderOutline.Size = UDim2.new(1,0, 0, SectionContent.AbsoluteContentSize + 64) -- 5 hours for this!
                    MultiSection.Window:Update()
                end;
            end;

            function MultiSection:Update()
                SectionHolderOutline.Size = UDim2.new(1,0, 0, SectionContent.AbsoluteContentSize + 64)
            end;
        
            Library:Connection(TabInnerFrame.MouseButton1Click, function()
                if not MultiSection.Open then
                    MultiSection:Turn(true)
                    for index, other_page in pairs(SectionShit2.ActualSections) do
                        if other_page.Open and other_page ~= MultiSection then
                            other_page:Turn(false)
                        end
                    end
                end
            end)
            
            if #SectionShit == 0 then
                MultiSection:Turn(true);
            end;
        
            -- // Elements
            MultiSection.Elements = {
                PageButtonOutline = TabInnerFrame;
                Title = TabTitle;
                SectionContent = SectionContent;
            };

            -- // Returning
            --SectionShit2.Page.Sections[#SectionShit2.Page.Sections + 1] = MultiSection;
            SectionShit2.ActualSections[#SectionShit2.ActualSections + 1] = debug.setmetatable(MultiSection, Library.Sections)
            SectionHolderOutline.Size = UDim2.new(1,0, 0, SectionContent.AbsoluteContentSize + 64)
            --return debug.setmetatable(MultiSection, Library.Sections)
        end;

        -- // Returning
        Section.Page.Sections[#Section.Page.Sections + 1] = Section;
        Section.ActualSections[1]:Turn(true)
        return table.unpack(Section.ActualSections)
    end;
    --
    function Sections:Toggle(Properties)
        local Properties = Properties or {}
        local Toggle = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or false),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag()),
            Toggled = false;
            Colorpickers = 0;
        }

        -- // Elements
        local ToggleHolder = Library:NewDrawing("Square", {
            Parent = Toggle.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, 16),
            ZIndex = 53,
        });
        local ToggleFrame = Library:NewDrawing("Square", {
            Parent = ToggleHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(0,6,0,6),
            Position = UDim2.new(0,3,0,5),
            ZIndex = 56,
            Theme = "Dark Contrast"
        });
        --
        local InnerOutline = Library:NewOutline(ToggleFrame, "Border1");
        local MidOutline = Library:NewOutline(InnerOutline, "Border2");
        local OuterOutline = Library:NewOutline(MidOutline, "Border1");
        --
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 20, 0, 1);
            Parent = ToggleHolder;
            ZIndex = 54;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 21, 0, 2);
            Parent = ToggleHolder;
            ZIndex = 53;
        });

        -- // Functions
        local function SetState()
            Toggle.Toggled = not Toggle.Toggled
            if Toggle.Toggled then
                Library:ChangeObjectTheme(ToggleFrame, "Accent")
                Library:ChangeObjectTheme(MidOutline, "Accent")
                Library:ChangeObjectTheme(Title, "Light Text")
            else
                Library:ChangeObjectTheme(ToggleFrame, "Dark Contrast")
                Library:ChangeObjectTheme(MidOutline, "Border2")
                Library:ChangeObjectTheme(Title, "Text")
            end
            Library.Flags[Toggle.Flag] = Toggle.Toggled
            Toggle.Callback(Toggle.Toggled)
        end;
        Library:Connection(ToggleHolder.MouseButton1Click, SetState);
        Library:Connection(ToggleHolder.MouseEnter, function()
            if not Toggle.Toggled then
                Library:ChangeObjectTheme(MidOutline, "Accent")
            end;
        end);
        Library:Connection(ToggleHolder.MouseLeave, function()
            if not Toggle.Toggled then
                Library:ChangeObjectTheme(MidOutline, "Border2")
            end;
        end);

        -- // Misc Functions
        local function set(bool)
            bool = type(bool) == "boolean" and bool or false
            if Toggle.Toggled ~= bool then
                SetState()
            end;
        end;
        set(Toggle.State);
        Flags[Toggle.Flag] = set;
        Library.Flags[Toggle.Flag] = Toggle.Toggled
        --
        function Toggle:Set(bool)
            set(bool)
        end;

        -- // Keybind
        function Toggle:Keybind(Properties)
            local Properties = Properties or {}
            local Keybind = {
                State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or nil),
                Mode = (Properties.mode or Properties.Mode or "Hold"),
                Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
                Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag()),
                Binding = nil
            }
            local Key
            local State = false 
        
            -- // Elements
            local Shit = Library:NewDrawing("Square", {
                Parent = ToggleHolder,
                Visible = true,
                Filled = true,
                Thickness = 0,
                Transparency = 0,
                Size = UDim2.new(1, -28, 1, 0),
                Position = UDim2.new(0,17,0,0),
                ZIndex = 53
            });
            local ValueTitle = Library:NewDrawing("Text", {
                Text = "[-]";
                Size = 13;
                Font = 2;
                Theme = "Text";
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(1,-40, 0, 1);
                Parent = Shit;
                ZIndex = 54;
                Center = false;
            });
            local ValueTitleShadow = Library:NewDrawing("Text", {
                Text = "[-]";
                Size = 13;
                Font = 2;
                Color = Color3.fromRGB();
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(1,-39, 0, 2);
                Parent = Shit;
                ZIndex = 53;
                Center = false;
            });
            ValueTitle.Position = UDim2.new(1,-ValueTitle.TextBounds.X,0,1)
            ValueTitleShadow.Position = UDim2.new(1,-ValueTitleShadow.TextBounds.X + 1,0,2)
            local KeybindThing = Library:NewDrawing("Square", {
                Parent = Shit,
                Visible = true,
                Filled = true,
                Thickness = 0,
                Transparency = 0,
                Size = UDim2.new(0, 30, 1, 0),
                Position = UDim2.new(1,-30,0,0),
                ZIndex = 54
            });
            --
            local mode_frame = Library:NewDrawing("Square",{
                Theme = "Dark Contrast",
                Size = UDim2.new(0,54,0,50),
                Position = UDim2.new(1,5,0,-10),
                Filled = true,
                Parent = ToggleHolder,
                Thickness = 1,
                ZIndex = 55,
                Visible = false
            })
        
            local InnerOutline = Library:NewOutline(mode_frame, "Border1", 55);
            local MidOutline = Library:NewOutline(InnerOutline, "Border2", 55);
            local OuterOutline = Library:NewOutline(MidOutline, "Border1", 55);
        
            local holdtext = Library:NewDrawing("Text", {
                Text = "Hold",
                Font = Drawing.Fonts.Plex,
                Size = 13,
                Theme = Keybind.Mode == "Hold" and "Accent" or "Text",
                Position = UDim2.new(0.5,0,0,2),
                ZIndex = 56,
                Parent = mode_frame,
                Outline = true,
                Center = true
            })
            
            local toggletext = Library:NewDrawing("Text", {
                Text = "Toggle",
                Font = Drawing.Fonts.Plex,
                Size = 13,
                Theme = Keybind.Mode == "Toggle" and "Accent" or "Text",
                Position = UDim2.new(0.5,0,0,18),
                ZIndex = 56,
                Parent = mode_frame,
                Outline = true,
                Center = true
            })
            local alwaystext = Library:NewDrawing("Text", {
                Text = "Always",
                Font = Drawing.Fonts.Plex,
                Size = 13,
                Theme = Keybind.Mode == "Always" and "Accent" or "Text",
                Position = UDim2.new(0.5,0,0,34),
                ZIndex = 56,
                Parent = mode_frame,
                Outline = true,
                Center = true
            })
        
            local holdbutton = Library:NewDrawing("Square",{
                Color = Color3.new(0,0,0),
                Size = UDim2.new(0,44,0,12),
                Position = UDim2.new(0,0,0,2),
                Filled = false,
                Parent = mode_frame,
                Thickness = 1,
                ZIndex = 56,
                Transparency = 0
            })
        
            local togglebutton = Library:NewDrawing("Square",{
                Color = Color3.new(0,0,0),
                Size = UDim2.new(0,44,0,12),
                Position = UDim2.new(0,0,0,20),
                Filled = false,
                Parent = mode_frame,
                Thickness = 1,
                ZIndex = 56,
                Transparency = 0
            })
            local alwaysbutton = Library:NewDrawing("Square",{
                Color = Color3.new(0,0,0),
                Size = UDim2.new(0,44,0,12),
                Position = UDim2.new(0,0,0,36),
                Filled = false,
                Parent = mode_frame,
                Thickness = 1,
                ZIndex = 56,
                Transparency = 0
            })
        
            -- // Functions
            Library:Connection(ToggleHolder.MouseEnter, function()
                if not Keybind.Binding then
                    Library:ChangeObjectTheme(ValueTitle, "Accent")
                end;
            end);
            Library:Connection(ToggleHolder.MouseLeave, function()
                if not Keybind.Binding then
                    Library:ChangeObjectTheme(ValueTitle, "Text")
                end;
            end);
        
            -- // Misc Functions
            local function set(newkey)
                if string.find(tostring(newkey), "Enum") then
                    if c then
                        c:Disconnect()
                        if Keybind.Flag then
                            Library.Flags[Keybind.Flag] = false
                        end
                        Keybind.Callback(false)
                    end
                    if tostring(newkey):find("Enum.KeyCode.") then
                        newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
                    elseif tostring(newkey):find("Enum.UserInputType.") then
                        newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
                    end
                    if newkey == Enum.KeyCode.Backspace then
                        Key = nil
            
                        local text = "-"
                        local sizeX = Library:GetTextLength("["..text.."]", Drawing.Fonts.Plex, 13).X
        
                        ValueTitle.Text = "["..text.."]"
                        ValueTitleShadow.Text = "["..text.."]"
                        ValueTitle.Position = UDim2.new(1,-sizeX,0,1)
                        ValueTitleShadow.Position = UDim2.new(1,-sizeX + 1,0,2)
                        KeybindThing.Size = UDim2.new(0,sizeX + 5, 1,0)
                        KeybindThing.Position = UDim2.new(1,-sizeX - 5,0,0)
                        Library:ChangeObjectTheme(ValueTitle, "Text")
                    elseif newkey ~= nil then
                        Key = newkey
            
                        local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))
                        local sizeX = Library:GetTextLength("["..text.."]", Drawing.Fonts.Plex, 13).X
        
                        ValueTitle.Text = "["..text.."]"
                        ValueTitleShadow.Text = "["..text.."]"
                        ValueTitle.Position = UDim2.new(1,-sizeX,0,1)
                        ValueTitleShadow.Position = UDim2.new(1,-sizeX + 1,0,2)
                        KeybindThing.Size = UDim2.new(0,sizeX + 5, 1,0)
                        KeybindThing.Position = UDim2.new(1,-sizeX - 5,0,0)
                        Library:ChangeObjectTheme(ValueTitle, "Text")
                    end
        
                    Library.Flags[Keybind.Flag .. "_KEY"] = newkey
                elseif table.find({"Always", "Toggle", "Hold"}, newkey) then
                    Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
                    Keybind.Mode = newkey
                    if Keybind.Mode == "Always" then
                        State = true
                        if Keybind.Flag then
                            Library.Flags[Keybind.Flag] = State
                        end
                        Keybind.Callback(true)
                    end
                else 
                    State = newkey
                    if Keybind.Flag then
                        Library.Flags[Keybind.Flag] = newkey
                    end
                    Keybind.Callback(newkey)
                end 
            end
            --
            set(Keybind.State) 
            KeybindThing.MouseButton1Click:Connect(function()
                if not Keybind.Binding then
                    local sizeX = Library:GetTextLength("[-]", Drawing.Fonts.Plex, 13).X
        
                    ValueTitle.Text = "[-]"
                    ValueTitleShadow.Text = "[-]"
                    ValueTitle.Position = UDim2.new(1,-sizeX,0,1)
                    ValueTitleShadow.Position = UDim2.new(1,-sizeX + 1,0,2)
                    KeybindThing.Size = UDim2.new(0,sizeX + 5, 1,0)
                    KeybindThing.Position = UDim2.new(1,-sizeX - 5,0,0)
                    Library:ChangeObjectTheme(ValueTitle, "Accent")
                    
                    Keybind.Binding = Library:Connection(game:GetService("UserInputService").InputBegan, function(input, gpe)
                        set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
                        Library:Disconnect(Keybind.Binding)
                        task.wait()
                        Keybind.Binding = nil
                    end)
                end
            end)
            --
            Library:Connection(game:GetService("UserInputService").InputBegan, function(inp)
                if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding then
                    if Keybind.Mode == "Hold" then
                        if Keybind.Flag then
                            Library.Flags[Keybind.Flag] = true
                        end
                        c = Library:Connection(game:GetService("RunService").RenderStepped, function()
                            if Keybind.Callback then
                                Keybind.Callback(true)
                            end
                        end)
                    elseif Keybind.Mode == "Toggle" then
                        State = not State
                        if Keybind.Flag then
                            Library.Flags[Keybind.Flag] = State;
                        end
                        Keybind.Callback(State)
                    end
                end
            end)
            --
            Library:Connection(game:GetService("UserInputService").InputEnded, function(inp)
                if Keybind.Mode == "Hold" then
                    if Key ~= '' or Key ~= nil then
                        if inp.KeyCode == Key or inp.UserInputType == Key then
                            if c then
                                c:Disconnect()
                                if Keybind.Flag then
                                    Library.Flags[Keybind.Flag] = false;
                                end
                                if Keybind.Callback then
                                    Keybind.Callback(false)
                                end
                            end
                        end
                    end
                end
            end)
            --
            holdbutton.MouseButton1Click:Connect(function()
                set("Hold")
                Library:ChangeObjectTheme(holdtext, "Accent")
                Library:ChangeObjectTheme(toggletext, "Text")
                Library:ChangeObjectTheme(alwaystext, "Text")
                mode_frame.Visible = false
            end)
            togglebutton.MouseButton1Click:Connect(function()
                set("Toggle")
                Library:ChangeObjectTheme(holdtext, "Text")
                Library:ChangeObjectTheme(toggletext, "Accent")
                Library:ChangeObjectTheme(alwaystext, "Text")
                mode_frame.Visible = false
            end)
            alwaysbutton.MouseButton1Click:Connect(function()
                set("Always")
                Library:ChangeObjectTheme(holdtext, "Text")
                Library:ChangeObjectTheme(toggletext, "Text")
                Library:ChangeObjectTheme(alwaystext, "Accent")
                mode_frame.Visible = false
            end)
            KeybindThing.MouseButton2Up:Connect(function()
                mode_frame.Visible = true
            end)
            --
            Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
            Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
            Flags[Keybind.Flag] = set
            Flags[Keybind.Flag .. "_KEY"] = set
            Flags[Keybind.Flag .. "_KEY STATE"] = set
            --
            function Keybind:Set(key)
                set(key)
            end
        
            -- // Returning
            return Keybind;
        end;

        -- // Colorpicker
        function Toggle:Colorpicker(Properties)
            local Properties = Properties or {}
            local Colorpicker = {
                State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or Color3.fromRGB(255,0,0)),
                Alpha = (Properties.alpha or Properties.Alpha or Properties.transparency or Properties.Transparency or 1),
                Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
                Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag()),
            }
            -- // Functions
            Toggle.Colorpickers = Toggle.Colorpickers + 1;
            local colorpickertypes = Library:NewPicker(Properties.Title or "Color",Colorpicker.State, Colorpicker.Alpha, ToggleHolder, Toggle.Colorpickers - 1, Colorpicker.Flag, Colorpicker.Callback, 2)

            function Colorpicker:Set(color)
                colorpickertypes:set(color, false, true)
            end
        
            -- // Returning
            return Colorpicker;
        end;

        -- // Returning
        Toggle.Section.Content[#Toggle.Section.Content + 1] = Toggle;
        Toggle.Section.ContentAxis += ToggleHolder.Size.Y.Offset;
        if not Toggle.Section.NoUpdate then
            Toggle.Section:Update(24);
        else
            Toggle.Section:Update();
        end
        return Toggle;
    end;
    --
    function Sections:Slider(Properties)
        local Properties = Properties or {}
        local Slider = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            Min = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0),
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or 10),
            Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 100),
            Sub = (Properties.suffix or Properties.Suffix or Properties.ending or Properties.Ending or Properties.prefix or Properties.Prefix or Properties.measurement or Properties.Measurement or ""),
            Decimals = (Properties.decimals or Properties.Decimals or 1),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag())
        }
        Slider.Decimals = 1 / Slider.Decimals;
        local TextValue = ("[value]/"..Slider.Max..Slider.Sub);

        -- // Elements
        local SliderHolder = Library:NewDrawing("Square", {
            Parent = Slider.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, Properties.Title and 28 or 16),
            ZIndex = 53,
        });
        local SliderFrame = Library:NewDrawing("Square", {
            Parent = SliderHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,-28,0,6),
            Position = UDim2.new(0,17,0, Properties.Title and 18 or 6),
            ZIndex = 55,
            Theme = "Dark Contrast"
        });
        --
        local InnerOutline = Library:NewOutline(SliderFrame, "Border1");
        local MidOutline = Library:NewOutline(InnerOutline, "Border2");
        local OuterOutline = Library:NewOutline(MidOutline, "Border1");
        --
        local SliderFill = Library:NewDrawing("Square", {
            Parent = SliderFrame,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(0,0,1,0),
            ZIndex = 55,
            Theme = "Accent"
        });
        --
        local SliderDrag = Library:NewDrawing("Square", {
            Parent = SliderHolder,
            Visible = true,
            Filled = false,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1,0,1,0),
            ZIndex = 58
        });
        --
        if Properties.Title then
            local Title = Library:NewDrawing("Text", {
                Text = Properties.Title or "Title";
                Size = 13;
                Font = 2;
                Theme = "Text";
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 14, 0, 0);
                Parent = SliderHolder;
                ZIndex = 54;
            });
            local TitleShadow = Library:NewDrawing("Text", {
                Text = Properties.Title or "Title";
                Size = 13;
                Font = 2;
                Color = Color3.fromRGB();
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 15, 0, 1);
                Parent = SliderHolder;
                ZIndex = 53;
            });
        end;
        --
        local ValueTitle = Library:NewDrawing("Text", {
            Text = TextValue;
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Center = true;
            Position = UDim2.new(0.5, 0, 0, -4);
            Parent = SliderFrame;
            ZIndex = 56;
        });
        local ValueTitleShadow = Library:NewDrawing("Text", {
            Text = TextValue;
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Center = true;
            Position = UDim2.new(0.5, 1, 0, -3);
            Parent = SliderFrame;
            ZIndex = 55;
        });

        -- // Functions
        local Sliding = false
        local function Set(value)
            value = math.clamp(Library:Round(value, Slider.Decimals), Slider.Min, Slider.Max)

            ValueTitle.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))
            ValueTitleShadow.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))

            local sizeX = ((value - Slider.Min) / (Slider.Max - Slider.Min))
            SliderFill.Size = UDim2.new(sizeX, 0, 1, 0)

            Library.Flags[Slider.Flag] = value
            Slider.Callback(value)
        end
        --
        Set(Slider.State)
        --
        local function Slide(input)
            local sizeX = (input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X
            local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
            Set(value)
        end
        --
        Library:Connection(SliderDrag.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = true
                Slide(input)
            end
        end)
        Library:Connection(SliderDrag.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = false
            end
        end)
        Library:Connection(SliderFill.InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = true
                Slide(input)
            end
        end)
        Library:Connection(SliderFill.InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = false
            end
        end)
        Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if Sliding then
                    Slide(input)
                end
            end
        end)
        --
        Library:Connection(SliderHolder.MouseEnter, function()
            Library:ChangeObjectTheme(MidOutline, "Accent")
        end);
        Library:Connection(SliderHolder.MouseLeave, function()
            Library:ChangeObjectTheme(MidOutline, "Border2")
        end);
        --
        function Slider:Set(Value)
            Set(Value);
        end;
        --
        Flags[Slider.Flag] = Set;

        -- // Returning
        Slider.Section.Content[#Slider.Section.Content + 1] = Slider;
        Slider.Section.ContentAxis += SliderHolder.Size.Y.Offset;
        if not Slider.Section.NoUpdate then
            Slider.Section:Update(24);
        else
            Slider.Section:Update();
        end
        return Slider;
    end;
    --
    function Sections:Dropdown(Properties)
        local Properties = Properties or {}
        local Dropdown = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            Open = false,
            Options = (Properties.options or Properties.Options or Properties.values or Properties.Values or {"1","2","3"}),
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or nil),
            Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or nil),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag())
        }

        -- // Elements
        local DropdownHolder = Library:NewDrawing("Square", {
            Parent = Dropdown.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, Properties.Title and 30 or 18),
            ZIndex = 53,
        });
        local DropdownFrame = Library:NewDrawing("Square", {
            Parent = DropdownHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,-28,0,8),
            Position = UDim2.new(0,17,0, Properties.Title and 18 or 6),
            ZIndex = 56,
            Theme = "Dark Contrast"
        });
        --
        local InnerOutline = Library:NewOutline(DropdownFrame, "Border1");
        local MidOutline = Library:NewOutline(InnerOutline, "Border2");
        local OuterOutline = Library:NewOutline(MidOutline, "Border1");
        --
        local DropdownIcon = Library:NewDrawing("Image", {
            Parent = DropdownFrame,
            Visible = true,
            Data = Library.Images["Arrow_Down"],
            Transparency = 1,
            Size = UDim2.new(0,7,0,5),
            Position = UDim2.new(1,-10,0.5,-2),
            ZIndex = 56,
        });
        --
        local DropdownContentFrame = Library:NewDrawing("Square", {
            Parent = DropdownFrame,
            Visible = false,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,0,0,10),
            Position = UDim2.new(100,0,1,6),
            ZIndex = 58,
            Theme = "Dark Contrast"
        });
        --
        local ContentInnerOutline = Library:NewOutline(DropdownContentFrame, "Border1",58);
        local ContentMidOutline = Library:NewOutline(ContentInnerOutline, "Border2",58);
        local ContentOuterOutline = Library:NewOutline(ContentMidOutline, "Border1",58);
        --
        local DropdownContentHolder = Library:NewDrawing("Square", {
            Transparency = 0,
            Size = UDim2.new(1, -6, 1, -6),
            Position = UDim2.new(0, 3, 0, 3),
            Parent = DropdownContentFrame
        })
        DropdownContentHolder:AddListLayout(3)
        --
        local DropdownDrag = Library:NewDrawing("Square", {
            Parent = DropdownFrame,
            Visible = true,
            Filled = false,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1,0,1,0),
            ZIndex = 56
        });
        --
        if Properties.Title then
            local Title = Library:NewDrawing("Text", {
                Text = Properties.Title or "Title";
                Size = 13;
                Font = 2;
                Theme = "Text";
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 14, 0, 0);
                Parent = DropdownHolder;
                ZIndex = 54;
            });
            local TitleShadow = Library:NewDrawing("Text", {
                Text = Properties.Title or "Title";
                Size = 13;
                Font = 2;
                Color = Color3.fromRGB();
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 15, 0, 1);
                Parent = DropdownHolder;
                ZIndex = 53;
            });
        end;
        --
        local ValueTitle = Library:NewDrawing("Text", {
            Text = "";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Center = false;
            Position = UDim2.new(0, 2, 0, -3);
            Parent = DropdownFrame;
            ZIndex = 57;
        });
        local ValueTitleShadow = Library:NewDrawing("Text", {
            Text = "";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Center = false;
            Position = UDim2.new(0, 3, 0, -2);
            Parent = DropdownFrame;
            ZIndex = 56;
        });

        -- // Functions
        local Opened = false
        Library:Connection(DropdownDrag.MouseButton1Click, function()
            Opened = not Opened
            DropdownContentFrame.Visible = Opened;
            DropdownIcon.Data = (Opened and Library.Images["Arrow_Up"] or Library.Images["Arrow_Down"]);
            DropdownIcon.Position = (Opened and UDim2.new(1,-10,0.5,-3) or UDim2.new(1,-10,0.5,-2));
            DropdownContentFrame.Position = (Opened and UDim2.new(0,0,1,6) or UDim2.new(100,0,1,6))
        end);

        local optioninstances = {}
        local count = 0
        local countindex = {}
        local startindex = 0

        local chosen = max and {}

        local function handleoptionclick(option, button, text)

                button.MouseButton1Click:Connect(function()
                    for opt, tbl in next, optioninstances do
                        if opt ~= option then
                            Library:ChangeObjectTheme(tbl.text, "Text")
                        end
                    end
                    chosen = option
                    ValueTitle.Text = option
                    ValueTitleShadow.Text = option
                    Library:ChangeObjectTheme(text, "Accent")
                    Library.Flags[Dropdown.Flag] = option
                    Dropdown.Callback(option)
                end)
        end

        local function createoptions(tbl)
            for _, option in next, tbl do
                optioninstances[option] = {}

                countindex[option] = count + 1

                local button = Library:NewDrawing("Square", {
                    Filled = true,
                    Transparency = 0,
                    Thickness = 1,
                    Size = UDim2.new(1, 0, 0, 16),
                    ZIndex = 58,
                    Parent = DropdownContentHolder,
                })
        
                optioninstances[option].button = button
        
                local title = Library:NewDrawing("Text", {
                    Text = option,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 2, 0, 1),
                    Theme = "Text",
                    ZIndex = 59,
                    Outline = true,
                    Parent = button
                })
        
                optioninstances[option].text = title
        
                if Dropdown.Max then
                    if count < Dropdown.Max then
                        DropdownContentFrame.Size = UDim2.new(1, 0, 0, DropdownContentHolder.AbsoluteContentSize + 6)
                    end
                else
                    DropdownContentFrame.Size = UDim2.new(1, 0, 0, DropdownContentHolder.AbsoluteContentSize + 6)
                end
        
                count = count + 1
                handleoptionclick(option, button, title)
            end
        end

        createoptions(Dropdown.Options)

        --// Scroll
        if Dropdown.Max then
            --
            DropdownContentHolder:MakeScrollable()
            local scroll_connect = nil;
            --
            local scrollbar_outline = Library:NewDrawing("Square", {Transparency = 1,Size = UDim2.new(0,4,1,0),Position = UDim2.new(1,-4,0,0),ZIndex = 60, Parent = DropdownContentFrame, Thickness = 1, Theme = "Border2", Filled = true});
            --
            local scrollbar = Library:NewDrawing("Square", {Transparency = 1,Size = UDim2.new(0,3,count == 0 and 1 or count/Dropdown.Max, 0),Position = UDim2.new(1,-3,0,0),ZIndex = 61, Parent = DropdownContentFrame, Thickness = 1, Theme = "Accent", Filled = true});
            --
            local function refreshscroll()
                local scale = (startindex) / (count > 0 and count or 1)
                scrollbar.Position = UDim2.new(1,-3, scale, 0)
                scrollbar.Size = UDim2.new(0, 3, math.clamp(count == 0 and 1 or 1 / (count / Dropdown.Max), 0, 1), 0)
            end
            --
            DropdownContentHolder.MouseEnter:Connect(function()
                scroll_connect = Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseWheel then
                        local down = input.Position.Z < 0 and true or false
                        if down then
                            local indexesleft = count - Dropdown.Max - startindex
                            if indexesleft >= 0 then
                                startindex = math.clamp(startindex + 1, 0, count - Dropdown.Max)
                                refreshscroll()
                            end
                        else
                            local indexesleft = count - Dropdown.Max + startindex
                            if indexesleft >= count - Dropdown.Max then
                                startindex = math.clamp(startindex - 1, 0, count - Dropdown.Max)
                                refreshscroll()
                            end
                        end
                    end
                end);
            end)
            --
            DropdownContentHolder.MouseLeave:Connect(function()
                if scroll_connect then
                    Library:Disconnect(scroll_connect)
                end
            end)
            refreshscroll()
        end;
        local set
        set = function(option)
            for opt, tbl in next, optioninstances do
                if opt ~= option then
                    Library:ChangeObjectTheme(tbl.text, "Text")
                end
            end
            if table.find(Dropdown.Options, option) then
                chosen = option
                ValueTitle.Text = option
                ValueTitleShadow.Text = option
                Library:ChangeObjectTheme(optioninstances[option].text, "Accent")
                Library.Flags[Dropdown.Flag] = chosen
                Dropdown.Callback(chosen)
            else
                chosen = nil
                ValueTitle.Text = ""
                ValueTitleShadow.Text = ""
                Library.Flags[Dropdown.Flag] = chosen
                Dropdown.Callback(chosen)
            end
        end
        Flags[Dropdown.Flag] = Dropdown
        set(Dropdown.State)
        function Dropdown:Set(option)
            set(option)
        end
        --
        function Dropdown:Refresh(tbl)
            content = table.clone(tbl)
            count = 0

            for _, opt in next, optioninstances do
                coroutine.wrap(function()
                    opt.button:Remove()
                end)()
            end

            table.clear(optioninstances)

            createoptions(tbl)

            if Dropdown.Max then
                DropdownContentHolder:RefreshScrolling()
                refreshscroll()
            end

            value.Text = ""

            if max then
                table.clear(chosen)
            else
                chosen = nil
            end

            Library.Flags[Dropdown.Flag] = chosen
            Dropdown.Callback(chosen)
        end
        --
        Library:Connection(DropdownHolder.MouseEnter, function()
            Library:ChangeObjectTheme(MidOutline, "Accent")
        end);
        Library:Connection(DropdownHolder.MouseLeave, function()
            Library:ChangeObjectTheme(MidOutline, "Border2")
        end);
        -- // Returning
        Dropdown.Section.Content[#Dropdown.Section.Content + 1] = Dropdown;
        Dropdown.Section.ContentAxis += DropdownHolder.Size.Y.Offset;
        if not Dropdown.Section.NoUpdate then
            Dropdown.Section:Update(24);
        else
            Dropdown.Section:Update();
        end
        DropdownContentFrame.Visible = false
        return Dropdown;
    end;
    --
    function Sections:Multibox(Properties)
        local Properties = Properties or {}
        local Multibox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            Open = false,
            Options = (Properties.options or Properties.Options or Properties.values or Properties.Values or {"1","2","3"}),
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or nil),
            Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 1),
            ScrollMax = (Properties.scrollmax or Properties.ScrollMax or Properties.scrollmaximum or Properties.ScrollMaximum or 5),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag())
        }

        -- // Elements
        local MultiboxHolder = Library:NewDrawing("Square", {
            Parent = Multibox.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, Properties.Title and 30 or 18),
            ZIndex = 53,
        });
        local MultiboxFrame = Library:NewDrawing("Square", {
            Parent = MultiboxHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,-28,0,8),
            Position = UDim2.new(0,17,0, Properties.Title and 18 or 6),
            ZIndex = 56,
            Theme = "Dark Contrast"
        });
        --
        local InnerOutline = Library:NewOutline(MultiboxFrame, "Border1");
        local MidOutline = Library:NewOutline(InnerOutline, "Border2");
        local OuterOutline = Library:NewOutline(MidOutline, "Border1");
        --
        local MultiboxIcon = Library:NewDrawing("Image", {
            Parent = MultiboxFrame,
            Visible = true,
            Data = Library.Images["Arrow_Down"],
            Transparency = 1,
            Size = UDim2.new(0,7,0,5),
            Position = UDim2.new(1,-10,0.5,-2),
            ZIndex = 56,
        });
        table.insert(Icons, MultiboxIcon)
        --
        local MultiboxContentFrame = Library:NewDrawing("Square", {
            Parent = MultiboxFrame,
            Visible = false,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,0,0,10),
            Position = UDim2.new(100,0,1,6),
            ZIndex = 58,
            Theme = "Dark Contrast"
        });
        --
        local ContentInnerOutline = Library:NewOutline(MultiboxContentFrame, "Border1",58);
        local ContentMidOutline = Library:NewOutline(ContentInnerOutline, "Border2",58);
        local ContentOuterOutline = Library:NewOutline(ContentMidOutline, "Border1",58);
        --
        local MultiboxContentHolder = Library:NewDrawing("Square", {
            Transparency = 0,
            Size = UDim2.new(1, -6, 1, -6),
            Position = UDim2.new(0, 3, 0, 3),
            Parent = MultiboxContentFrame
        })
        MultiboxContentHolder:AddListLayout(3)
        --
        local MultiboxDrag = Library:NewDrawing("Square", {
            Parent = MultiboxFrame,
            Visible = true,
            Filled = false,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1,0,1,0),
            ZIndex = 56
        });
        --
        if Properties.Title then
            local Title = Library:NewDrawing("Text", {
                Text = Properties.Title or "Title";
                Size = 13;
                Font = 2;
                Theme = "Text";
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 14, 0, 0);
                Parent = MultiboxHolder;
                ZIndex = 54;
            });
            local TitleShadow = Library:NewDrawing("Text", {
                Text = Properties.Title or "Title";
                Size = 13;
                Font = 2;
                Color = Color3.fromRGB();
                OutlineColor = Color3.fromRGB();
                Outline = false;
                Position = UDim2.new(0, 15, 0, 1);
                Parent = MultiboxHolder;
                ZIndex = 53;
            });
        end;
        --
        local ValueTitle = Library:NewDrawing("Text", {
            Text = "";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Center = false;
            Position = UDim2.new(0, 2, 0, -3);
            Parent = MultiboxFrame;
            ZIndex = 57;
        });
        local ValueTitleShadow = Library:NewDrawing("Text", {
            Text = "";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Center = false;
            Position = UDim2.new(0, 3, 0, -2);
            Parent = MultiboxFrame;
            ZIndex = 56;
        });

        local Opened = false
        Library:Connection(MultiboxDrag.MouseButton1Click, function()
            Opened = not Opened
            MultiboxContentFrame.Visible = Opened;
            MultiboxIcon.Data = (Opened and Library.Images["Arrow_Up"] or Library.Images["Arrow_Down"]);
            MultiboxIcon.Position = (Opened and UDim2.new(1,-10,0.5,-3) or UDim2.new(1,-10,0.5,-2));
            MultiboxContentFrame.Position = (Opened and UDim2.new(0,0,1,6) or UDim2.new(100,0,1,6))
        end);

        local optioninstances = {}
        local count = 0
        local countindex = {}
        local startindex = 0

        local chosen = Multibox.Max and {}

        local function handleoptionclick(option, button, text)
                button.MouseButton1Click:Connect(function()
                    if Multibox.Max then
                        if table.find(chosen, option) then
                            table.remove(chosen, table.find(chosen, option))
        
                            local textchosen = {}
                            local cutobject = false
        
                            for _, opt in next, chosen do
                                table.insert(textchosen, opt)
        
                                if Library:GetTextLength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (MultiboxFrame.AbsoluteSize.X - 14) then
                                    cutobject = true
                                    table.remove(textchosen, #textchosen)
                                end
                            end
        
                            ValueTitle.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                            ValueTitleShadow.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
        
                            Library:ChangeObjectTheme(text, "Text")
        
                            Library.Flags[Multibox.Flag] = chosen
                            Multibox.Callback(chosen)
                        else
                            if #chosen == Multibox.Max then
                                Library:ChangeObjectTheme(optioninstances[chosen[1]].text, "Text")
        
                                table.remove(chosen, 1)
                            end
        
                            table.insert(chosen, option)
        
                            local textchosen = {}
                            local cutobject = false
        
                            for _, opt in next, chosen do
                                table.insert(textchosen, opt)
        
                                if Library:GetTextLength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (MultiboxFrame.AbsoluteSize.X - 14) then
                                    cutobject = true
                                    table.remove(textchosen, #textchosen)
                                end
                            end
        
        
                            ValueTitle.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                            ValueTitleShadow.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
        
                            Library:ChangeObjectTheme(text, "Accent")
        
                            Library.Flags[Multibox.Flag] = chosen
                            Multibox.Callback(chosen)
                        end
                    end
                end)

        end

        local function createoptions(tbl)
            for _, option in next, tbl do
                optioninstances[option] = {}

                countindex[option] = count + 1

                local button = Library:NewDrawing("Square", {
                    Filled = true,
                    Transparency = 0,
                    Thickness = 1,
                    Size = UDim2.new(1, 0, 0, 16),
                    ZIndex = 58,
                    Parent = MultiboxContentHolder
                })
        
                optioninstances[option].button = button
        
                local title = Library:NewDrawing("Text", {
                    Text = option,
                    Font = Drawing.Fonts.Plex,
                    Size = 13,
                    Position = UDim2.new(0, 2, 0, 1),
                    Theme = "Text",
                    ZIndex = 59,
                    Outline = true,
                    Parent = button
                })
        
                optioninstances[option].text = title
        
                if Multibox.ScrollMax then
                    if count < Multibox.ScrollMax then
                        MultiboxContentFrame.Size = UDim2.new(1, 0, 0, MultiboxContentHolder.AbsoluteContentSize + 6)
                    end
                else
                    MultiboxContentFrame.Size = UDim2.new(1, 0, 0, MultiboxContentHolder.AbsoluteContentSize + 6)
                end
        
                count = count + 1
                handleoptionclick(option, button, title)
            end
        end

        createoptions(Multibox.Options)

        --// Scroll
        if Multibox.ScrollMax then
            --
            MultiboxContentHolder:MakeScrollable()
            local scroll_connect = nil;
            --
            local scrollbar_outline = Library:NewDrawing("Square", {Transparency = 1,Size = UDim2.new(0,4,1,0),Position = UDim2.new(1,-4,0,0),ZIndex = 60, Parent = MultiboxContentFrame, Thickness = 1, Theme = "Border2", Filled = true});
            --
            local scrollbar = Library:NewDrawing("Square", {Transparency = 1,Size = UDim2.new(0,3,count == 0 and 1 or count/Multibox.ScrollMax, 0),Position = UDim2.new(1,-3,0,0),ZIndex = 61, Parent = MultiboxContentFrame, Thickness = 1, Theme = "Accent", Filled = true});
            --
            local function refreshscroll()
                local scale = (startindex) / (count > 0 and count or 1)
                scrollbar.Position = UDim2.new(1,-3, scale, 0)
                scrollbar.Size = UDim2.new(0, 3, math.clamp(count == 0 and 1 or 1 / (count / Multibox.ScrollMax), 0, 1), 0)
            end
            --
            MultiboxContentHolder.MouseEnter:Connect(function()
                scroll_connect = Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseWheel then
                        local down = input.Position.Z < 0 and true or false
                        if down then
                            local indexesleft = count - Multibox.ScrollMax - startindex
                            if indexesleft >= 0 then
                                startindex = math.clamp(startindex + 1, 0, count - Multibox.ScrollMax)
                                refreshscroll()
                            end
                        else
                            local indexesleft = count - Multibox.ScrollMax + startindex
                            if indexesleft >= count - Multibox.ScrollMax then
                                startindex = math.clamp(startindex - 1, 0, count - Multibox.ScrollMax)
                                refreshscroll()
                            end
                        end
                    end
                end);
            end)
            --
            MultiboxContentHolder.MouseLeave:Connect(function()
                if scroll_connect then
                    Library:Disconnect(scroll_connect)
                end
            end)
            refreshscroll()
        end;
        local set
        set = function(d, option)
            if Multibox.Max then
                table.clear(chosen)
                option = type(option) == "table" and option or {}
                chosen = type(option) == "table" and option or {}


                for opt, tbl in next, optioninstances do
                    if not table.find(option, opt) then
                        --tbl.button.Transparency = 0
                        Library:ChangeObjectTheme(tbl.text, "Text")
                    end
                end

                for i, opt in next, option do
                    if table.find(Multibox.Options, opt) and #chosen < Multibox.Max then
                        table.insert(chosen, opt)
                        Library:ChangeObjectTheme(optioninstances[opt].text, "Accent")
                    end
                end

                local textchosen = {}
                local cutobject = false

                for _, opt in next, chosen do
                    table.insert(textchosen, opt)

                    if Library:GetTextLength(table.concat(textchosen, ", ") .. ", ...", Drawing.Fonts.Plex, 13).X > (MultiboxFrame.AbsoluteSize.X - 14) then
                        cutobject = true
                        table.remove(textchosen, #textchosen)
                    end
                end

                ValueTitle.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
                ValueTitleShadow.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")

                Library.Flags[Multibox.Flag] = chosen
                Multibox.Callback(chosen)
            end
        end
        Flags[Multibox.Flag] = set
        set(Multibox.State)
        --
        function Multibox:Set(option)
            set(option)
        end
        --
        function Multibox:Refresh(tbl)
            content = table.clone(tbl)
            count = 0

            for _, opt in next, optioninstances do
                coroutine.wrap(function()
                    opt.button:Remove()
                end)()
            end

            table.clear(optioninstances)

            createoptions(tbl)

            if Multibox.ScrollMax then
                MultiboxContentHolder:RefreshScrolling()
                refreshscroll()
            end

            value.Text = ""

            if Multibox.Max then
                table.clear(chosen)
            else
                chosen = nil
            end

            Library.Flags[Multibox.Flag] = chosen
            Multibox.Callback(chosen)
        end
        --
        Library:Connection(MultiboxHolder.MouseEnter, function()
            Library:ChangeObjectTheme(MidOutline, "Accent")
        end);
        Library:Connection(MultiboxHolder.MouseLeave, function()
            Library:ChangeObjectTheme(MidOutline, "Border2")
        end);
        -- // Returning
        Multibox.Section.Content[#Multibox.Section.Content + 1] = Multibox;
        Multibox.Section.ContentAxis += MultiboxHolder.Size.Y.Offset;
        if not Multibox.Section.NoUpdate then
            Multibox.Section:Update(24);
        else
            Multibox.Section:Update();
        end
        MultiboxContentFrame.Visible = false
        return Multibox;
    end;
    --
    function Sections:Keybind(Properties)
        local Properties = Properties or {}
        local Keybind = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or nil),
            Mode = (Properties.mode or Properties.Mode or "Hold"),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag()),
            Binding = nil;
            State = false;
            Key = "";
        }
        local Key

        -- // Elements
        local KeybindHolder = Library:NewDrawing("Square", {
            Parent = Keybind.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, 16),
            ZIndex = 53,
        });
        --
        local Shit = Library:NewDrawing("Square", {
            Parent = KeybindHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, -28, 1, 0),
            Position = UDim2.new(0,17,0,0),
            ZIndex = 53
        });
        --
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 14, 0, 1);
            Parent = KeybindHolder;
            ZIndex = 54;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 15, 0, 2);
            Parent = KeybindHolder;
            ZIndex = 53;
        });
        local ValueTitle = Library:NewDrawing("Text", {
            Text = "[-]";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(1,-40, 0, 1);
            Parent = Shit;
            ZIndex = 54;
            Center = false;
        });
        local ValueTitleShadow = Library:NewDrawing("Text", {
            Text = "[-]";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(1,-39, 0, 2);
            Parent = Shit;
            ZIndex = 53;
            Center = false;
        });
        ValueTitle.Position = UDim2.new(1,-ValueTitle.TextBounds.X,0,1)
        ValueTitleShadow.Position = UDim2.new(1,-ValueTitleShadow.TextBounds.X + 1,0,2)
        local KeybindThing = Library:NewDrawing("Square", {
            Parent = KeybindHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 54,
        });
        --
        local mode_frame = Library:NewDrawing("Square",{
            Theme = "Dark Contrast",
            Size = UDim2.new(0,54,0,50),
            Position = UDim2.new(1,5,0,-10),
            Filled = true,
            Parent = KeybindHolder,
            Thickness = 1,
            ZIndex = 55,
            Visible = false
        })

        local InnerOutline = Library:NewOutline(mode_frame, "Border1", 55);
        local MidOutline = Library:NewOutline(InnerOutline, "Border2", 55);
        local OuterOutline = Library:NewOutline(MidOutline, "Border1", 55);

        local holdtext = Library:NewDrawing("Text", {
            Text = "Hold",
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Theme = Keybind.Mode == "Hold" and "Accent" or "Text",
            Position = UDim2.new(0.5,0,0,2),
            ZIndex = 56,
            Parent = mode_frame,
            Outline = true,
            Center = true
        })
        
        local toggletext = Library:NewDrawing("Text", {
            Text = "Toggle",
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Theme = Keybind.Mode == "Toggle" and "Accent" or "Text",
            Position = UDim2.new(0.5,0,0,18),
            ZIndex = 56,
            Parent = mode_frame,
            Outline = true,
            Center = true
        })
        local alwaystext = Library:NewDrawing("Text", {
            Text = "Always",
            Font = Drawing.Fonts.Plex,
            Size = 13,
            Theme = Keybind.Mode == "Always" and "Accent" or "Text",
            Position = UDim2.new(0.5,0,0,34),
            ZIndex = 56,
            Parent = mode_frame,
            Outline = true,
            Center = true
        })

        local holdbutton = Library:NewDrawing("Square",{
            Color = Color3.new(0,0,0),
            Size = UDim2.new(0,44,0,12),
            Position = UDim2.new(0,0,0,2),
            Filled = false,
            Parent = mode_frame,
            Thickness = 1,
            ZIndex = 56,
            Transparency = 0
        })

        local togglebutton = Library:NewDrawing("Square",{
            Color = Color3.new(0,0,0),
            Size = UDim2.new(0,44,0,12),
            Position = UDim2.new(0,0,0,20),
            Filled = false,
            Parent = mode_frame,
            Thickness = 1,
            ZIndex = 56,
            Transparency = 0
        })
        local alwaysbutton = Library:NewDrawing("Square",{
            Color = Color3.new(0,0,0),
            Size = UDim2.new(0,44,0,12),
            Position = UDim2.new(0,0,0,36),
            Filled = false,
            Parent = mode_frame,
            Thickness = 1,
            ZIndex = 56,
            Transparency = 0
        })

        -- // Functions
        Library:Connection(KeybindHolder.MouseEnter, function()
            if not Keybind.Binding then
                Library:ChangeObjectTheme(ValueTitle, "Accent")
            end;
        end);
        Library:Connection(KeybindHolder.MouseLeave, function()
            if not Keybind.Binding then
                Library:ChangeObjectTheme(ValueTitle, "Text")
            end;
        end);

        -- // Misc Functions
        local function set(newkey)
            if string.find(tostring(newkey), "Enum") then
                if c then
                    c:Disconnect()
                    if Keybind.Flag then
                        Library.Flags[Keybind.Flag] = Keybind.State
                    end
                    Keybind.Callback(false)
                end
                if tostring(newkey):find("Enum.KeyCode.") then
                    newkey = Enum.KeyCode[tostring(newkey):gsub("Enum.KeyCode.", "")]
                elseif tostring(newkey):find("Enum.UserInputType.") then
                    newkey = Enum.UserInputType[tostring(newkey):gsub("Enum.UserInputType.", "")]
                end
                if newkey == Enum.KeyCode.Backspace then
                    Keybind.Key = nil
        
                    local text = "[-]"
                    local sizeX = Library:GetTextLength(text, Drawing.Fonts.Plex, 13).X

                    ValueTitle.Text = "["..text.."]"
                    ValueTitleShadow.Text = "["..text.."]"
                    ValueTitle.Position = UDim2.new(1,-sizeX,0,1)
                    ValueTitleShadow.Position = UDim2.new(1,-sizeX + 1,0,2)
                    Library:ChangeObjectTheme(ValueTitle, "Text")
                elseif newkey ~= nil then
                    Keybind.Key = newkey
        
                    local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))
                    local sizeX = Library:GetTextLength("["..text.."]", Drawing.Fonts.Plex, 13).X

                    ValueTitle.Text = "["..text.."]"
                    ValueTitleShadow.Text = "["..text.."]"
                    ValueTitle.Position = UDim2.new(1,-sizeX,0,1)
                    ValueTitleShadow.Position = UDim2.new(1,-sizeX + 1,0,2)
                    Library:ChangeObjectTheme(ValueTitle, "Text")
                end

                Library.Flags[Keybind.Flag .. "_KEY"] = newkey
            elseif table.find({"Always", "Toggle", "Hold"}, newkey) then
                Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
                Keybind.Mode = newkey
                if Keybind.Mode == "Always" then
                    Keybind.State = true
                    if Keybind.Flag then
                        Library.Flags[Keybind.Flag] = Keybind.State
                    end
                    Keybind.Callback(true)
                end
            else 
                Keybind.State = newkey
                if Keybind.Flag then
                    Library.Flags[Keybind.Flag] = newkey
                end
                Keybind.Callback(newkey)
            end 
        end
        --
        set(Keybind.State) 
        KeybindThing.MouseButton1Click:Connect(function()
            if not Keybind.Binding then
                local sizeX = Library:GetTextLength("[-]", Drawing.Fonts.Plex, 13).X

                ValueTitle.Text = "[-]"
                ValueTitleShadow.Text = "[-]"
                ValueTitle.Position = UDim2.new(1,-sizeX,0,1)
                ValueTitleShadow.Position = UDim2.new(1,-sizeX + 1,0,2)
                Library:ChangeObjectTheme(ValueTitle, "Accent")
                
                Keybind.Binding = Library:Connection(game:GetService("UserInputService").InputBegan, function(input, gpe)
                    set(input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType)
                    Library:Disconnect(Keybind.Binding)
                    task.wait()
                    Keybind.Binding = nil
                end)
            end
        end)
        --
        Library:Connection(game:GetService("UserInputService").InputBegan, function(inp)
            if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding then
                if Keybind.Mode == "Hold" then
                    if Keybind.Flag then
                        Library.Flags[Keybind.Flag] = Keybind
                    end
                    c = Library:Connection(game:GetService("RunService").RenderStepped, function()
                        if Keybind.Callback then
                            Keybind.Callback(true)
                        end
                    end)
                elseif Keybind.Mode == "Toggle" then
                    State = not State
                    if Keybind.Flag then
                        Library.Flags[Keybind.Flag] = Keybind.State;
                    end
                    Keybind.Callback(State)
                end
            end
        end)
        --
        Library:Connection(game:GetService("UserInputService").InputEnded, function(inp)
            if Keybind.Mode == "Hold" then
                if Keybind.Key ~= '' or Keybind.Key ~= nil then
                    if inp.KeyCode == Keybind.Key or inp.UserInputType == Keybind.Key then
                        if c then
                            c:Disconnect()
                            if Keybind.Flag then
                                Library.Flags[Keybind.Flag] = Keybind.State;
                            end
                            if Keybind.Callback then
                                Keybind.Callback(false)
                            end
                        end
                    end
                end
            end
        end)
        --
        holdbutton.MouseButton1Click:Connect(function()
            set("Hold")
            Library:ChangeObjectTheme(holdtext, "Accent")
            Library:ChangeObjectTheme(toggletext, "Text")
            Library:ChangeObjectTheme(alwaystext, "Text")
            mode_frame.Visible = false
        end)
        togglebutton.MouseButton1Click:Connect(function()
            set("Toggle")
            Library:ChangeObjectTheme(holdtext, "Text")
            Library:ChangeObjectTheme(toggletext, "Accent")
            Library:ChangeObjectTheme(alwaystext, "Text")
            mode_frame.Visible = false
        end)
        alwaysbutton.MouseButton1Click:Connect(function()
            set("Always")
            Library:ChangeObjectTheme(holdtext, "Text")
            Library:ChangeObjectTheme(toggletext, "Text")
            Library:ChangeObjectTheme(alwaystext, "Accent")
            mode_frame.Visible = false
        end)
        KeybindThing.MouseButton2Up:Connect(function()
            mode_frame.Visible = true
        end)
        --
        Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
        Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
        Flags[Keybind.Flag] = set
        Flags[Keybind.Flag .. "_KEY"] = set
        Flags[Keybind.Flag .. "_KEY STATE"] = set
        --
        function Keybind:Set(key)
            set(key)
        end
        -- // Returning
        Keybind.Section.Content[#Keybind.Section.Content + 1] = Keybind;
        Keybind.Section.ContentAxis += KeybindHolder.Size.Y.Offset;
        if not Keybind.Section.NoUpdate then
            Keybind.Section:Update(24);
        else
            Keybind.Section:Update();
        end
        return Keybind;
    end;
    --
    function Sections:Colorpicker(Properties)
        local Properties = Properties or {}
        local Colorpicker = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or Color3.fromRGB(255,0,0)),
            Alpha = (Properties.alpha or Properties.Alpha or Properties.transparency or Properties.Transparency or 1),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag()),
            Colorpickers = 0
        }

        -- // Elements
        local ColorpickerHolder = Library:NewDrawing("Square", {
            Parent = Colorpicker.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, 16),
            ZIndex = 53,
        });
        --
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 14, 0, 1);
            Parent = ColorpickerHolder;
            ZIndex = 54;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0, 15, 0, 2);
            Parent = ColorpickerHolder;
            ZIndex = 53;
        });
        -- // Functions
        local colorpickertypes = Library:NewPicker(Title.Text,Colorpicker.State, Colorpicker.Alpha, ColorpickerHolder, Colorpicker.Colorpickers, Colorpicker.Flag, Colorpicker.Callback, 2)
        function colorpickertypes:new_colorpicker(cfg)
            Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
            local cp_tbl = {}
            local default = cfg.state or cfg.State or cfg.def or cfg.Def or cfg.default or cfg.Default or Color3.fromRGB(255,0,0);
            local flag = cfg.flag or cfg.Flag or utility.nextflag();
            local callback = cfg.callback or function() end;
            local defaultalpha = cfg.alpha or cfg.Alpha or 1

            local cp = Library:NewPicker(Title.Text,default, defaultalpha, ColorpickerHolder, Colorpicker.Colorpickers, flag, callback, 2)
            function cp_tbl:Set(color)
                cp:set(color, false, true)
            end
            return cp_tbl
        end

        function Colorpicker:Set(color)
            colorpickertypes:set(color, false, true)
        end

        -- // Returning
        Colorpicker.Section.Content[#Colorpicker.Section.Content + 1] = Colorpicker;
        Colorpicker.Section.ContentAxis += ColorpickerHolder.Size.Y.Offset;
        if not Colorpicker.Section.NoUpdate then
            Colorpicker.Section:Update(30);
        else
            Colorpicker.Section:Update();
        end
        return Colorpicker, colorpickertypes;
    end;
    --
    function Sections:Button(Properties)
        local Properties = Properties or {}
        local Button = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
        };

        -- // Elements
        local ButtonHolder = Library:NewDrawing("Square", {
            Parent = Button.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, 28),
            ZIndex = 53,
        });
        local ButtonFrame = Library:NewDrawing("Square", {
            Parent = ButtonHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,-28,0,17),
            Position = UDim2.new(0,17,0, 6),
            ZIndex = 56,
            Theme = "Dark Contrast"
        });
        local Title = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Center = true;
            Position = UDim2.new(0.5, 0, 0, 1);
            Parent = ButtonFrame;
            ZIndex = 57;
        });
        local TitleShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Center = true;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0.5, 1, 0, 1);
            Parent = ButtonFrame;
            ZIndex = 56;
        });
        local InnerOutline = Library:NewOutline(ButtonFrame, "Border1");
        local MidOutline = Library:NewOutline(ButtonFrame, "Border2");
        local OuterOutline = Library:NewOutline(MidOutline, "Border1");

        -- // Callback
        Library:Connection(ButtonFrame.MouseButton1Click, function()
            Button.Callback();
        end);

        -- // Highlight
        Library:Connection(ButtonHolder.MouseEnter, function()
            Library:ChangeObjectTheme(MidOutline, "Accent")
        end);
        Library:Connection(ButtonHolder.MouseLeave, function()
            Library:ChangeObjectTheme(MidOutline, "Border2")
        end);

        -- // Returns
        Button.Section.Content[#Button.Section.Content + 1] = Button;
        Button.Section.ContentAxis += ButtonHolder.Size.Y.Offset;
        if not Button.Section.NoUpdate then
            Button.Section:Update(24);
        else
            Button.Section:Update();
        end;
        return Button;
    end;
    --
    function Sections:Textbox(Properties)
        local Properties = Properties or {}
        local Textbox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,
            State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or ""),
            Callback = (Properties.callback or Properties.Callback or Properties.callBack or Properties.CallBack or function() end),
            Flag = (Properties.flag or Properties.Flag or Properties.pointer or Properties.Pointer or Library:Flag())
        };

        -- // Elements
        local TextboxHolder = Library:NewDrawing("Square", {
            Parent = Textbox.Section.Elements.SectionContent,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 0,
            Size = UDim2.new(1, 0, 0, 28),
            ZIndex = 53,
        });
        local TextboxFrame = Library:NewDrawing("Square", {
            Parent = TextboxHolder,
            Visible = true,
            Filled = true,
            Thickness = 0,
            Transparency = 1,
            Size = UDim2.new(1,-28,0,17),
            Position = UDim2.new(0,17,0, 6),
            ZIndex = 55,
            Theme = "Dark Contrast"
        });

        -- // Text
        local Text = Library:NewDrawing("Text", {
            Text = Textbox.State;
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Center = true;
            Position = UDim2.new(0.5, 0, 0, 1);
            Parent = TextboxFrame;
            ZIndex = 57;
        });
        local TextShadow = Library:NewDrawing("Text", {
            Text = Textbox.State;
            Size = 13;
            Font = 2;
            Center = true;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0.5, 1, 0, 1);
            Parent = TextboxFrame;
            ZIndex = 56;
            Transparency = 0;
        });


        -- // Placeholder
        local Placeholder = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Theme = "Text";
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Center = true;
            Position = UDim2.new(0.5, 0, 0, 1);
            Parent = TextboxFrame;
            ZIndex = 57;
            Transparency = 0.5;
        });
        local PlaceholderShadow = Library:NewDrawing("Text", {
            Text = Properties.Title or "Title";
            Size = 13;
            Font = 2;
            Center = true;
            Color = Color3.fromRGB();
            OutlineColor = Color3.fromRGB();
            Outline = false;
            Position = UDim2.new(0.5, 1, 0, 1);
            Parent = TextboxFrame;
            ZIndex = 56;
            Transparency = 0.5;
        });

        -- // Input
        Library:NewBox(TextboxFrame, Text, TextShadow,  function(str) 
            if str == "" then
                Placeholder.Visible = true
                PlaceholderShadow.Visible = true
                Text.Visible = false
                TextShadow.Visible = false
            else
                Placeholder.Visible = false
                PlaceholderShadow.Visible = false
                Text.Visible = true
                TextShadow.Visible = true
            end
        end, function(str)
            Library.Flags[Textbox.Flag] = str
            Textbox.Callback(str)
        end)

        local function set(str)
            Text.Visible = str ~= ""
            Placeholder.Visible = str == "";
            Text.Text = str
            Library.Flags[Textbox.Flag] = str
            Textbox.Callback(str)
        end

        Flags[Textbox.Flag] = set

        local InnerOutline = Library:NewOutline(TextboxFrame, "Border1");
        local MidOutline = Library:NewOutline(TextboxFrame, "Border2");
        local OuterOutline = Library:NewOutline(MidOutline, "Border1");

        -- // Highlight
        Library:Connection(TextboxHolder.MouseEnter, function()
            Library:ChangeObjectTheme(MidOutline, "Accent")
        end);
        Library:Connection(TextboxHolder.MouseLeave, function()
            Library:ChangeObjectTheme(MidOutline, "Border2")
        end);

        if not Textbox.Section.NoUpdate then
            Textbox.Section:Update(24);
        else
            Textbox.Section:Update();
        end;
        return Textbox
    end;
end; 

local Test = Library:Window({Title = "osiris", Sub = " is a paste", Extra = "- extra text here figure out yourself nigger", Size = UDim2.new(0,620,0,655)});
local Page = Test:Tab({Title = "Legit"})
Test:Tab({Title = "Rage"})
Test:Tab({Title = "Players"})
Test:Tab({Title = "Visuals"})
Test:Tab({Title = "Misc"})
Test:Tab({Title = "World"})
Test:Tab({Title = "Config", TabLine = true})
--
local Section = Page:Section({Title = "section"})
Page:Section({Title = "section"})
Page:Section({Title = "section", side = "right"})
local TestA,NiceOne,lol = Page:MultiSection({Title = "test", side = "right", sections = {"test", "niceone","lol"}})
Page:MultiSection({Title = "test", side = "right", sections = {"test", "niceone","lol"}})
--
Section:Toggle({Title = "toggle"}):Keybind({Callback = print})
Section:Toggle({Title = "click me retard"}):Colorpicker({Title = "cheese"})
Section:Toggle({Title = "pasted"})
Section:Slider({Title = "has title"})
Section:Slider({})
Section:Dropdown({Title = "dropdown"})
Section:Dropdown({Title = "dropdown scroll", options = {"1","2","3","4","5","6","7","8"}, max = 4})
Section:Multibox({Title = "multibox", max = 3, options = {"1","2","3","4","5","6","7","8"}, scrollmax = 4})
Section:Keybind({Title = "test", Flag = "test", Mode = "Toggle", callback = function(p) print(p); print(Library.Flags.test) end})
Section:Colorpicker({Title = "cheese"})
Section:Textbox({})
--
TestA:Toggle({Title = "toggle"})
TestA:Toggle({Title = "click me retard"})
TestA:Toggle({Title = "pasted"})
TestA:Slider({Title = "has title"})
TestA:Slider({})
TestA:Button({Title = "has title"})
TestA:Dropdown({Title = "dropdown scroll", options = {"1","2","3","4","5","6","7","8"}, max = 4})
--
NiceOne:Toggle({Title = "nice one"})
NiceOne:Toggle({Title = "this was soo hard to make"})
NiceOne:Toggle({Title = "5 hours for this btw"})
--
TestA:Turn(true)

Test:Update()

return Library, Library.Flags, Flags;
