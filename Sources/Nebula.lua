local Library = {};
local Font_Old = Enum.Font.GothamBold
local Path = game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer.PlayerGui or game.CoreGui
local Tick = tick() 

repeat wait() until game:IsLoaded(); 

local Tick = tick()

-- Custom Fonts
do 
	-- 
	writefile("smallest_pixel.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/ProggyTiny.ttf"))
	-- 
	local smallest_pixel = {
		name = "SmallestPixel7",
		faces = {
			{
				name = "Regular",
				weight = 400,
				style = "normal",
				assetId = getcustomasset("smallest_pixel.ttf")
			}
		}
	}

	writefile("menu_font.font", game:GetService("HttpService"):JSONEncode(smallest_pixel))

	getgenv().menu_font = Font.new(getcustomasset("menu_font.font"), Enum.FontWeight.Regular)
end; 

do -- Library
	Library = {
		Open = true;
		Accent = Color3.fromRGB(132, 108, 188);
		Pages = {};
		Sections = {};
		Flags = {};
		UnNamedFlags = 0;
		ThemeObjects = {};
		Holder = nil;
		Keys = {
			[Enum.KeyCode.LeftShift] = "LShift",
			[Enum.KeyCode.RightShift] = "RShift",
			[Enum.KeyCode.LeftControl] = "LCtrl",
			[Enum.KeyCode.RightControl] = "RCtrl",
			[Enum.KeyCode.LeftAlt] = "LAlt",
			[Enum.KeyCode.RightAlt] = "RAlt",
			[Enum.KeyCode.CapsLock] = "Caps",
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
		Connections = {};
		UIKey = Enum.KeyCode.End;
		ScreenGUI = nil;
		FSize = 10;
		UIFont = nil;
		SettingsPage = nil;
		VisValues = {};
		Cooldown = false;
		Friends = {};
		Priorities = {};
		KeyList = nil;
	}

	local Flags = {}; 
	local Dropdowns = {}; 
	local Pickers = {}; 
	local VisValues = {}; 

	
	Library.__index = Library
	Library.Pages.__index = Library.Pages
	Library.Sections.__index = Library.Sections
	local LocalPlayer = game:GetService('Players').LocalPlayer;
	local Mouse = LocalPlayer:GetMouse();
	local TweenService = game:GetService("TweenService");

	do
		function Library:Connection(Signal, Callback)
			local Con = Signal:Connect(Callback)
			return Con
		end
		
		function Library:Disconnect(Connection)
			Connection:Disconnect()
		end
		
		function Library:Round(Number, Float)
			return Float * math.floor(Number / Float)
		end
		
		function Library.NextFlag()
			Library.UnNamedFlags = Library.UnNamedFlags + 1
			return string.format("%.14g", Library.UnNamedFlags)
		end
		
		function Library:GetConfig()
			local Config = ""
			for Index, Value in pairs(self.Flags) do
				if
					Index ~= "ConfigConfig_List"
					and Index ~= "ConfigConfig_Load"
					and Index ~= "ConfigConfig_Save"
				then
					local Value2 = Value
					local Final = ""
					
					if typeof(Value2) == "Color3" then
						local hue, sat, val = Value2:ToHSV()
						
						Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, 1)
					elseif typeof(Value2) == "table" and Value2.Color and Value2.Transparency then
						local hue, sat, val = Value2.Color:ToHSV()
						
						Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, Value2.Transparency)
					elseif typeof(Value2) == "table" and Value.Mode then
						local Values = Value.current
						
						Final = ("key(%s,%s,%s)"):format(Values[1] or "nil", Values[2] or "nil", Value.Mode)
					elseif Value2 ~= nil then
						if typeof(Value2) == "boolean" then
							Value2 = ("bool(%s)"):format(tostring(Value2))
						elseif typeof(Value2) == "table" then
							local New = "table("
							
							for Index2, Value3 in pairs(Value2) do
								New = New .. Value3 .. ","
							end
							
							if New:sub(#New) == "," then
								New = New:sub(0, #New - 1)
							end
							
							Value2 = New .. ")"
						elseif typeof(Value2) == "string" then
							Value2 = ("string(%s)"):format(Value2)
						elseif typeof(Value2) == "number" then
							Value2 = ("number(%s)"):format(Value2)
						end
						
						Final = Value2
					end
					
					Config = Config .. Index .. ": " .. tostring(Final) .. "\n"
				end
			end
			
			return Config
		end
		
		function Library:LoadConfig(Config)
			local Table = string.split(Config, "\n")
			local Table2 = {}
			for Index, Value in pairs(Table) do
				local Table3 = string.split(Value, ":")
				
				if Table3[1] ~= "ConfigConfig_List" and #Table3 >= 2 then
					local Value = Table3[2]:sub(2, #Table3[2])
					
					if Value:sub(1, 3) == "rgb" then
						local Table4 = string.split(Value:sub(5, #Value - 1), ",")
						
						Value = Table4
					elseif Value:sub(1, 3) == "key" then
						local Table4 = string.split(Value:sub(5, #Value - 1), ",")
						
						if Table4[1] == "nil" and Table4[2] == "nil" then
							Table4[1] = nil
							Table4[2] = nil
						end
						
						Value = Table4
					elseif Value:sub(1, 4) == "bool" then
						local Bool = Value:sub(6, #Value - 1)
						
						Value = Bool == "true"
					elseif Value:sub(1, 5) == "table" then
						local Table4 = string.split(Value:sub(7, #Value - 1), ",")
						
						Value = Table4
					elseif Value:sub(1, 6) == "string" then
						local String = Value:sub(8, #Value - 1)
						
						Value = String
					elseif Value:sub(1, 6) == "number" then
						local Number = tonumber(Value:sub(8, #Value - 1))
						
						Value = Number
					end
					
					Table2[Table3[1]] = Value
				end
			end
			
			for i, v in pairs(Table2) do
				if Flags[i] then
					if typeof(Flags[i]) == "table" then
						Flags[i]:Set(v)
					else
						Flags[i](v)
					end
				end
			end
		end
		
		function Library:SetOpen(bool)
			if typeof(bool) == 'boolean' then
				Library.Open = bool;
				Library.Holder.Visible = bool;
			end
		end;
		
		function Library:IsMouseOverFrame(Frame)
			local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

			if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
				and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

				return true;
			end;
		end;
		
		function Library:ChangeAccent(Color)
			Library.Accent = Color

			for obj, theme in next, Library.ThemeObjects do
				if theme:IsA("Frame") or theme:IsA("TextButton") then
					theme.BackgroundColor3 = Color
				elseif theme:IsA("TextLabel") or theme:IsA("TextBox") then
					theme.TextColor3 = Color
				elseif theme:IsA("ImageLabel") or theme:IsA("ImageButton") then
					theme.ImageColor3 = Color
				elseif theme:IsA("ScrollingFrame") then
					theme.ScrollBarImageColor3 = Library.Accent
				end
			end
		end
		
		function Library:Toggle(Bool)
			self.Open = Bool
			Library.Holder.Visible = Bool
		end
	end;


	do
		function Library:NewPicker(name, default, defaultalpha, parent, count, flag, callback)
			local Icon = Instance.new("TextButton", parent)
			local ColorWindow = Instance.new('Frame', Icon)
			local WindowInline = Instance.new('Frame', ColorWindow)
			local Color = Instance.new('TextButton', WindowInline)
			local Sat = Instance.new('ImageLabel', Color)
			local Val = Instance.new('ImageLabel', Color)
			local Container = Instance.new('Frame', Color)
			local Hue = Instance.new('ImageButton', Color)
			local Alpha = Instance.new('ImageButton', Color)
			local HueSlide = Instance.new('Frame', Hue)
			local AlphaSlide = Instance.new('Frame', Alpha)
			
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = default
			Icon.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Icon.BorderSizePixel = 0
			if count == 1 then
				Icon.Position = UDim2.new(1, - (count * 34),0.5,0)
			else
				Icon.Position = UDim2.new(1, - (count * 34) - (count * 4),0.5,0)
			end
			Icon.Size = UDim2.new(0, 34, 0, 10)
			Icon.Text = ""
			Icon.AutoButtonColor = false

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Icon

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Icon
			
			ColorWindow.Name = "ColorWindow"
			ColorWindow.Parent = Icon
			ColorWindow.Position = UDim2.new(1,-2,1,2)
			ColorWindow.Size = UDim2.new(0,150,0,146)
			ColorWindow.AnchorPoint = Vector2.new(1,0)
			ColorWindow.ZIndex = 100
			ColorWindow.Visible = false
			ColorWindow.BorderSizePixel = 1
			ColorWindow.BackgroundColor3 = Color3.fromRGB(20,20,20)
			ColorWindow.BorderColor3 = Color3.fromRGB(30,30,30)
			
			WindowInline.Name = "WindowInline"
			WindowInline.Position = UDim2.new(0,1,0,1)
			WindowInline.Size = UDim2.new(1,-2,1,-2)
			WindowInline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			WindowInline.BorderSizePixel = 0;
			WindowInline.ZIndex = 100
			
			Color.Name = "Color"
			Color.Position = UDim2.new(0,1,0,1)
			Color.Size = UDim2.new(0,120,0,120)
			Color.BackgroundColor3 = default
			Color.BorderColor3 = Color3.new(0,0,0)
			Color.BorderSizePixel = 0
			Color.Text = ""
			Color.TextColor3 = Color3.new(0,0,0)
			Color.AutoButtonColor = false
			Color.Font = Enum.Font.SourceSans
			Color.TextSize = 7
			Color.ZIndex = 100
			
			Sat.Name = "Sat"
			Sat.Size = UDim2.new(1,0,1,0)
			Sat.BackgroundColor3 = Color3.new(1,1,1)
			Sat.BackgroundTransparency = 1
			Sat.BorderSizePixel = 0
			Sat.BorderColor3 = Color3.new(0,0,0)
			Sat.Image = "http://www.roblox.com/asset/?id=14684562507"
			Sat.ZIndex = 100
			
			Val.Name = "Val"
			Val.Size = UDim2.new(1,0,1,0)
			Val.BackgroundColor3 = Color3.new(1,1,1)
			Val.BackgroundTransparency = 1
			Val.BorderSizePixel = 0
			Val.BorderColor3 = Color3.new(0,0,0)
			Val.Image = "http://www.roblox.com/asset/?id=14684563800"
			Val.ZIndex = 100
			
			Container.Name = "Container"
			Container.Position = UDim2.new(0,-2,1,5)
			Container.Size = UDim2.new(0,189,0,55)
			Container.BackgroundColor3 = Color3.new(1,1,1)
			Container.BackgroundTransparency = 1
			Container.BorderColor3 = Color3.new(0,0,0)
			Container.ZIndex = 100
			
			Hue.Name = "Hue"
			Hue.Position = UDim2.new(1,10,0,0)
			Hue.Size = UDim2.new(0,15,1,0)
			Hue.BackgroundColor3 = Color3.new(1,1,1)
			Hue.BorderColor3 = Color3.new(0,0,0)
			Hue.Image = "http://www.roblox.com/asset/?id=14684557999"
			Hue.AutoButtonColor = false
			Hue.ZIndex = 100
			Hue.BorderSizePixel = 0
			
			Alpha.Name = "Alpha"
			Alpha.Position = UDim2.new(0,0,1,7)
			Alpha.Size = UDim2.new(0,146,0,15)
			Alpha.BackgroundColor3 = Color3.new(1,1,1)
			Alpha.BorderColor3 = Color3.new(0,0,0)
			Alpha.Image = "http://www.roblox.com/asset/?id=16841308372"
			Alpha.AutoButtonColor = false
			Alpha.ZIndex = 100
			Alpha.BorderSizePixel = 0
			
			HueSlide.Name = "HueSlide"
			HueSlide.Size = UDim2.new(1,0,0,3)
			HueSlide.BackgroundColor3 = Color3.new(1,1,1)
			HueSlide.BorderColor3 = Color3.new(0,0,0)
			HueSlide.BorderSizePixel = 1
			
			AlphaSlide.Name = "AlphaSlide"
			AlphaSlide.Size = UDim2.new(0,3,1,0)
			AlphaSlide.BackgroundColor3 = Color3.new(0,0,0)
			AlphaSlide.BackgroundTransparency = 0.4
			AlphaSlide.BorderColor3 = Color3.new(0,0,0)
			AlphaSlide.ZIndex = 100
			AlphaSlide.BorderSizePixel = 0

			Library:Connection(Icon.MouseEnter, function()
				Icon.BorderSizePixel = 1
			end)
			
			Library:Connection(Icon.MouseLeave, function()
				Icon.BorderSizePixel = 0
			end)

			
			local mouseover = false
			local hue, sat, val = default:ToHSV()
			local hsv = default:ToHSV()
			local alpha = defaultalpha
			local oldcolor = hsv
			local slidingsaturation = false
			local slidinghue = false
			local slidingalpha = false

			local function update()
				local real_pos         = game:GetService("UserInputService"):GetMouseLocation()
				local mouse_position   = Vector2.new(real_pos.X - 5, real_pos.Y - 30)
				local relative_palette = (mouse_position - Color.AbsolutePosition)
				local relative_hue     = (mouse_position - Hue.AbsolutePosition)
				local relative_opacity = (mouse_position - Alpha.AbsolutePosition)
				
				if slidingsaturation then
					sat = math.clamp(1 - relative_palette.X / Color.AbsoluteSize.X, 0, 1)
					val = math.clamp(1 - relative_palette.Y / Color.AbsoluteSize.Y, 0, 1)
				elseif slidinghue then
					hue = math.clamp(relative_hue.Y / Hue.AbsoluteSize.Y, 0, 1)
				elseif slidingalpha then
					alpha = math.clamp(relative_opacity.X / Alpha.AbsoluteSize.X, 0, 1)
				end

				hsv = Color3.fromHSV(hue, sat, val)
				Color.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				Alpha.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				HueSlide.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				Icon.BackgroundColor3 = hsv

				HueSlide.Position = UDim2.new(0,0,math.clamp(hue, 0.005, 0.995),0)
				AlphaSlide.Position = UDim2.new(math.clamp(alpha, 0.000, 0.982),0,0,0)

				if flag then
					Library.Flags[flag] = {} 
					Library.Flags[flag]["Color"] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					Library.Flags[flag]["Transparency"] = alpha
				end

				callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255), alpha)
			end

			local function set(color, a)
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

				if hsv ~= oldcolor then
					Icon.BackgroundColor3 = hsv
					Color.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					Alpha.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					HueSlide.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					HueSlide.Position = UDim2.new(0,0,math.clamp(hue, 0.005, 0.995),0)
					AlphaSlide.Position = UDim2.new(math.clamp(alpha, 0.000, 0.982),0,0,0)

					if flag then
						Library.Flags[flag] = {} 
						Library.Flags[flag]["Color"] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
						Library.Flags[flag]["Transparency"] = alpha
					end

					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255), alpha)
				end
			end

			Flags[flag] = set

			set(default, defaultalpha)

			Sat.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slidingsaturation = true
					update()
				end
			end)

			Sat.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slidingsaturation = false
					update()
				end
			end)

			Hue.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slidinghue = true
					update()
				end
			end)

			Hue.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slidinghue = false
					update()
				end
			end)

			Alpha.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slidingalpha = true
					update()
				end
			end)

			Alpha.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slidingalpha = false
					update()
				end
			end)

			Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if slidingalpha then
						update()
					end

					if slidinghue then
						update()
					end

					if slidingsaturation then
						update()
					end
				end
			end)

			local colorpickertypes = {}

			function colorpickertypes:Set(color, newalpha)
				set(color, newalpha)
			end

			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ColorWindow.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ColorWindow) and not Library:IsMouseOverFrame(Icon) then
						ColorWindow.Visible = false
						parent.ZIndex = 1
					end
				end
			end)

			Icon.MouseButton1Down:Connect(function()
				ColorWindow.Visible = true
				parent.ZIndex = 5

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

			return colorpickertypes, ColorWindow, Icon
		end
	end

	function Library:NewInstance(Inst, Theme)
		local Obj = Instance.new(Inst)
		if Theme then
			table.insert(Library.ThemeObjects, Obj)
			if Obj:IsA("Frame") or Obj:IsA("TextButton") then
				Obj.BackgroundColor3 = Library.Accent;
				if Obj:IsA("ScrollingFrame") then
					Obj.ScrollBarImageColor3 = Library.Accent
				end
			elseif Obj:IsA("TextLabel") or Obj:IsA("TextBox") then
				Obj.TextColor3 = Library.Accent;
			elseif Obj:IsA("ImageLabel") or Obj:IsA("ImageButton") then
				Obj.ImageColor3 = Library.Accent;
			elseif Obj:IsA("UIStroke") then
				Obj.Color = Library.Accent;
			elseif Obj:IsA("ScrollingFrame") then
				Obj.ScrollBarImageColor3 = Library.Accent
			end;
		end;
		return Obj;
	end;

	function Library:Resize(object, background)
		local start, objectposition, dragging, currentpos, currentsize

		Library:Connection(object.MouseButton1Down, function(input)
			dragging = true
			start = input
		end)
		Library:Connection(Mouse.Move, function(input)
			if dragging then
				local MouseLocation = game:GetService("UserInputService"):GetMouseLocation()
				local X = math.clamp(MouseLocation.X - background.AbsolutePosition.X, 550, 9999)
				local Y = math.clamp((MouseLocation.Y - 36) - background.AbsolutePosition.Y, 600, 9999)
				currentsize = UDim2.new(0,X,0,Y)
				background.Size = currentsize
			end;
		end)
		Library:Connection(game:GetService("UserInputService").InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
	end

	do
		local Pages = Library.Pages;
		local Sections = Library.Sections;
		
		function Library:Window(Options)
			local Window = {
				Pages = {};
				Sections = {};
				Elements = {};
				Dragging = { false, UDim2.new(0, 0, 0, 0) };
			};
			
			local FentFun = Instance.new("ScreenGui", Path)
			FentFun.Name = "fent.fun"
			FentFun.DisplayOrder = 1000
			FentFun.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.Image = "rbxassetid://297774371"
			ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
			ImageLabel.Size = UDim2.new(0, 700, 0, 550)

			local MainFrame = Instance.new("TextButton")
			MainFrame.Name = "MainFrame"
			MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MainFrame.BorderSizePixel = 0
			MainFrame.Position = UDim2.new(0, 2, 0, 2)
			MainFrame.Size = UDim2.new(1, -4, 1, -4)
			MainFrame.ZIndex = 10
			MainFrame.Text = ""
			MainFrame.AutoButtonColor = false
			Library.Holder = ImageLabel

			local TopFrame = Instance.new("Frame")
			TopFrame.Name = "TopFrame"
			TopFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			TopFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TopFrame.BorderSizePixel = 0
			TopFrame.Size = UDim2.new(1, 0, 0, 25)

			local Logo = Library:NewInstance("ImageLabel", true)
			Logo.Name = "Logo"
			Logo.Image = "http://www.roblox.com/asset/?id=17655988165"
			Logo.ScaleType = Enum.ScaleType.Fit
			Logo.AnchorPoint = Vector2.new(0, 0.5)
			Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Logo.BackgroundTransparency = 1
			Logo.ImageColor3 = Library.Accent
			Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Logo.BorderSizePixel = 0
			Logo.Position = UDim2.new(0, 5, 0.5, 0)
			Logo.Size = UDim2.new(0, 20, 0, 20)
			Logo.Parent = TopFrame

			TopFrame.Parent = MainFrame

			local Tabs = Instance.new("ScrollingFrame")
			Tabs.Name = "Tabs"
			Tabs.Size = UDim2.new(0, 80,1, -25)
			Tabs.BackgroundColor3 = Color3.new(1,1,1)
			Tabs.BackgroundTransparency = 1
			Tabs.BorderSizePixel = 0
			Tabs.BorderColor3 = Color3.new(0,0,0)
			Tabs.ScrollBarThickness = 2 
			Tabs.ScrollBarImageColor3 = Library.Accent
			Tabs.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
			Tabs.CanvasSize = UDim2.new(0, 0, 1.15, 0)
			Tabs.Position = UDim2.new(0, 0, 0, 25)
			table.insert(Library.ThemeObjects, Tabs)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Tabs

			Tabs.Parent = MainFrame

			MainFrame.Parent = ImageLabel

			local Holder = Instance.new("Frame")
			Holder.Name = "shadowHolder"
			Holder.BackgroundTransparency = 1
			Holder.Position = UDim2.new(0, -3, 0, -3)
			Holder.Size = UDim2.new(1, 6, 1, 6)
			Holder.ZIndex = 0

			local Shadow = Instance.new("ImageLabel")
			Shadow.Name = "umbraShadow"
			Shadow.Image = "rbxassetid://1316045217"
			Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			Shadow.ImageTransparency = 0.86
			Shadow.ScaleType = Enum.ScaleType.Slice
			Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
			Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
			Shadow.BackgroundTransparency = 1
			Shadow.Position = UDim2.new(0.5, 0, 0.5, 2)
			Shadow.Size = UDim2.new(1, 4, 1, 4)
			Shadow.ZIndex = 0
			Shadow.Parent = Holder

			local Shadow1 = Instance.new("ImageLabel")
			Shadow1.Name = "penumbraShadow"
			Shadow1.Image = "rbxassetid://1316045217"
			Shadow1.ImageColor3 = Color3.fromRGB(0, 0, 0)
			Shadow1.ImageTransparency = 0.88
			Shadow1.ScaleType = Enum.ScaleType.Slice
			Shadow1.SliceCenter = Rect.new(10, 10, 118, 118)
			Shadow1.AnchorPoint = Vector2.new(0.5, 0.5)
			Shadow1.BackgroundTransparency = 1
			Shadow1.Position = UDim2.new(0.5, 0, 0.5, 2)
			Shadow1.Size = UDim2.new(1, 4, 1, 4)
			Shadow1.ZIndex = 0
			Shadow1.Parent = Holder

			local Shadow2 = Instance.new("ImageLabel")
			Shadow2.Name = "ambientShadow"
			Shadow2.Image = "rbxassetid://1316045217"
			Shadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
			Shadow2.ImageTransparency = 0.49
			Shadow2.ScaleType = Enum.ScaleType.Slice
			Shadow2.SliceCenter = Rect.new(10, 10, 118, 118)
			Shadow2.AnchorPoint = Vector2.new(0.5, 0.5)
			Shadow2.BackgroundTransparency = 1
			Shadow2.Position = UDim2.new(0.5, 0, 0.5, 2)
			Shadow2.Size = UDim2.new(1, 4, 1, 4)
			Shadow2.ZIndex = 0
			Shadow2.Parent = Holder

			local ResizeButton = Instance.new("TextButton")
			ResizeButton.Name = "ResizeButton"
			ResizeButton.FontFace = menu_font
			ResizeButton.Text = ""
			ResizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			ResizeButton.TextSize = 7
			ResizeButton.AutoButtonColor = false
			ResizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ResizeButton.BackgroundTransparency = 1
			ResizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ResizeButton.BorderSizePixel = 0
			ResizeButton.Position = UDim2.new(1, -15, 1, -15)
			ResizeButton.Size = UDim2.new(0, 25, 0, 25)
			ResizeButton.Parent = MainFrame
			Library:Resize(ResizeButton, ImageLabel)

			Holder.Parent = ImageLabel

			ImageLabel.Parent = FentFun

			Window.Elements = {
				TabHolder = Tabs,
				Holder = MainFrame,
			}

			Library:Connection(MainFrame.MouseButton1Down, function()
				local Location = game:GetService("UserInputService"):GetMouseLocation()
				Window.Dragging[1] = true
				Window.Dragging[2] = UDim2.new(0, Location.X - ImageLabel.AbsolutePosition.X, 0, Location.Y - ImageLabel.AbsolutePosition.Y)
			end)
			Library:Connection(game:GetService("UserInputService").InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 and Window.Dragging[1] then
					local Location = game:GetService("UserInputService"):GetMouseLocation()
					Window.Dragging[1] = false
					Window.Dragging[2] = UDim2.new(0, 0, 0, 0)
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputChanged, function(Input)
				local Location = game:GetService("UserInputService"):GetMouseLocation()
				local ActualLocation = nil

				-- Dragging
				if Window.Dragging[1] then
					ImageLabel.Position = UDim2.new(
						0,
						Location.X - Window.Dragging[2].X.Offset + (ImageLabel.Size.X.Offset * ImageLabel.AnchorPoint.X),
						0,
						Location.Y - Window.Dragging[2].Y.Offset + (ImageLabel.Size.Y.Offset * ImageLabel.AnchorPoint.Y)
					)
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if Input.KeyCode == Library.UIKey then
					Library:Toggle(not Library.Open)
				end
			end)

			function Window:KeyList() 
				local NKeyList = {Keybinds = {}};
				Library.KeyList = NKeyList;
				
				local Background = Instance.new("Frame")
				local Gradient = Instance.new("Frame")
				local UIGradient = Library:NewInstance("UIGradient", true)
				local Name = Library:NewInstance("TextLabel", true)
				local Element = Instance.new("Frame")
				local Tab = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local Name_2 = Instance.new("TextLabel")
				
				Background.Name = "Background"
				Background.Parent = Keybinds
				Background.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
				Background.BorderColor3 = Color3.fromRGB(25, 25, 25)
				Background.Position = UDim2.new(0.01, 0, 0.488, 0)
				Background.Size = UDim2.new(0, 180, 0, 24)
				Background.Visible = false
				Background.AutomaticSize = Enum.AutomaticSize.XY
				Background.Parent = FentFun

				Gradient.Name = "Gradient"
				Gradient.Parent = Background
				Gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Gradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Gradient.BorderSizePixel = 0
				Gradient.Position = UDim2.new(0, 0, 0, 1)
				Gradient.Size = UDim2.new(1,0, 0, 1)

				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.50, Library.Accent), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
				UIGradient.Parent = Gradient

				Name.Name = "Name"
				Name.Parent = Background
				Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Name.BackgroundTransparency = 1.000
				Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Name.BorderSizePixel = 0
				Name.Size = UDim2.new(1,0,0,24)
				Name.FontFace = menu_font
				Name.Text = "Keybinds"
				Name.TextColor3 = Color3.fromRGB(255, 255, 255)
				Name.TextSize = 12.000
				Name.RichText = true

				local KeybindTab = Name

				Element.Name = "Element"
				Element.Parent = Background
				Element.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				Element.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Element.BorderSizePixel = 0
				Element.Position = UDim2.new(0, 0, 1, 0)
				Element.Size = UDim2.new(0, 140, 0, 1)

				Tab.Name = "Tab"
				Tab.Visible = true 
				Tab.Parent = Background
				Tab.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
				Tab.BackgroundTransparency = 1.000
				Tab.BorderColor3 = Color3.fromRGB(25, 25, 25)
				Tab.Position = UDim2.new(0, 0, 0, 20)
				Tab.Size = UDim2.new(1, 0, 0, -20)
				Tab.AutomaticSize = Enum.AutomaticSize.Y

				UIListLayout.Parent = Tab
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Padding = UDim.new(0,2)

				local dragging
				local dragInput
				local dragStart
				local startPos

				Background.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						dragStart = input.Position
						startPos = Background.Position

						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
							end
						end)
					end
				end)

				Background.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						dragInput = input
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if input == dragInput and dragging then
						local delta = input.Position - dragStart
						Background.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
					end
				end)

				-- Functions
				function NKeyList:SetVisible(State)
					Background.Visible = State;
				end;
				
				function NKeyList:NewKey(Key, Name, Mode)
					local KeyValue = {}
					
					local KName = Library:NewInstance("TextLabel", true)
					 
					KName.Name = "Name"
					KName.Parent = Tab
					KName.AnchorPoint = Vector2.new(0.5, 0.5)
					KName.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
					KName.BorderColor3 = Color3.fromRGB(25,25,25)
					KName.BorderSizePixel = 0
					KName.Position = UDim2.new(0.5, 0, -1.85000002, 0)
					KName.Size = UDim2.new(0, 0, 0, 0)
					KName.FontFace = menu_font
					KName.Text = "Failed to update text..."
					KName.TextColor3 = Library.Accent
					KName.TextSize = 12.000
					KName.RichText = true
					KName.AutomaticSize = Enum.AutomaticSize.XY
					
					function KeyValue:SetVisible(State)
						KName.Visible = State;
					end;
					
					function KeyValue:Update(NKey, NewName, NewMode)
						KName.Text = string.format('<font color="rgb(200,200,200)">%s: [%s] </font><font color="rgb(145,145,145)">(%s)</font>', NewName, tostring(NKey), tostring(string.lower(NewMode)))
					end;
					return KeyValue
				end;
				return NKeyList
			end
			Window:KeyList()

			
			function Window:UpdateTabs()
				for Index, Page in pairs(Window.Pages) do
					Page:Turn(Page.Open)
				end
			end

			Library.Holder = ImageLabel
			return setmetatable(Window, Library)
		end;
		
		function Library:Page(Properties)
			if not Properties then
				Properties = {}
			end
			
			local Page = {
				Name = Properties.Name or Properties.name or "Page",
				Icon = Properties.Icon or "rbxassetid://17023142662",
				Window = self,
				Open = false,
				Sections = {},
				Pages = {},
				Elements = {},
			}
			
			local NewTab = Instance.new("TextButton")
			NewTab.Name = "NewTab"
			NewTab.FontFace = menu_font
			NewTab.Text = ""
			NewTab.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewTab.TextSize = 7
			NewTab.AutoButtonColor = false
			NewTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewTab.BackgroundTransparency = 1
			NewTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewTab.BorderSizePixel = 0
			NewTab.Size = UDim2.new(1, 0, 0, 70)
			NewTab.Parent = Page.Window.Elements.TabHolder

			local AccentLine = Library:NewInstance("Frame", true)
			AccentLine.Name = "AccentLine"
			AccentLine.BackgroundColor3 = Library.Accent
			AccentLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AccentLine.BorderSizePixel = 0
			AccentLine.Size = UDim2.new(0, 2, 1, 0)
			AccentLine.Visible = true
			AccentLine.BackgroundTransparency = 1
			AccentLine.Parent = NewTab

			local Name = Instance.new("TextLabel")
			Name.Name = "Name"
			Name.FontFace = menu_font
			Name.Text = Page.Name
			Name.TextColor3 = Color3.fromRGB(200, 200, 200)
			Name.TextSize = Library.FSize
			Name.TextStrokeTransparency = 0
			Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Name.BackgroundTransparency = 1
			Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Name.BorderSizePixel = 0
			Name.Position = UDim2.new(0, 0, 1, -22)
			Name.Size = UDim2.new(1, 0, 0, 10)
			Name.Parent = NewTab

			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.Image = Page.Icon
			ImageLabel.ScaleType = Enum.ScaleType.Fit
			ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.ImageColor3 = Color3.fromRGB(200, 200, 200)
			ImageLabel.Position = UDim2.new(0.5, 0, 0.5, -6)
			ImageLabel.Size = UDim2.new(0, 25, 0, 25)
			ImageLabel.Parent = NewTab

			local NewPage = Instance.new("Frame")
			NewPage.Name = "NewPage"
			NewPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewPage.BackgroundTransparency = 1
			NewPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewPage.BorderSizePixel = 0
			NewPage.Position = UDim2.new(0, 91, 0, 35)
			NewPage.Size = UDim2.new(1, -100, 1, -40)
			NewPage.Visible = false
			NewPage.Parent = Page.Window.Elements.Holder

			local Left = Instance.new("Frame")
			Left.Name = "Left"
			Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Left.BackgroundTransparency = 1
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.Size = UDim2.new(0.5, -5, 1, 0)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 8)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Left

			Left.Parent = NewPage

			local Right = Instance.new("Frame")
			Right.Name = "Right"
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.Position = UDim2.new(0.5, 5, 0, 0)
			Right.Size = UDim2.new(0.5, -5, 1, 0)

			local UIListLayout1 = Instance.new("UIListLayout")
			UIListLayout1.Name = "UIListLayout"
			UIListLayout1.Padding = UDim.new(0, 8)
			UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout1.Parent = Right

			Right.Parent = NewPage

			function Page:Turn(bool)
				Page.Open = bool
				NewPage.Visible = Page.Open
				TweenService:Create(AccentLine, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = Page.Open and 0 or 1}):Play()
				TweenService:Create(NewTab, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = Page.Open and 0.95 or 1}):Play()
			end
			
			Library:Connection(NewTab.MouseButton1Down, function()
				if not Page.Open then
					for _, Pages in pairs(Page.Window.Pages) do
						if Pages.Open and Pages ~= Page then
							Pages:Turn(false)
						end
					end
					Page:Turn(true)
				end
			end)

			
			Page.Elements = {
				Left = Left,
				Right = Right,
				Main = NewPage,
			}

			
			if #Page.Window.Pages == 0 then
				Page:Turn(true)
			end
			Page.Window.Pages[#Page.Window.Pages + 1] = Page
			Page.Window:UpdateTabs()
			return setmetatable(Page, Library.Pages)
		end
		
		function Pages:Section(Properties)
			if not Properties then
				Properties = {}
			end
			
			local Section = {
				Name = Properties.Name or "Section",
				Page = self,
				Side = (Properties.side or Properties.Side or "left"):lower(),
				Zindex = (Properties.Zindex or Properties.zindex or 1),
				Elements = {},
				Content = {},
				Sections = {},
			}
			
			local NewSection = Instance.new("Frame")
			NewSection.Name = "NewSection"
			NewSection.AutomaticSize = Enum.AutomaticSize.Y
			NewSection.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			NewSection.BorderColor3 = Color3.fromRGB(30, 30, 30)
			NewSection.Size = UDim2.new(1, 0, 0, 50)
			NewSection.ZIndex = Section.Zindex
			NewSection.Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right

			local SectionTop = Instance.new("Frame")
			SectionTop.Name = "SectionTop"
			SectionTop.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
			SectionTop.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTop.BorderSizePixel = 0
			SectionTop.Size = UDim2.new(1, 0, 0, 20)

			local SectionName = Instance.new("TextLabel")
			SectionName.Name = "SectionName"
			SectionName.FontFace = menu_font
			SectionName.Text = Section.Name
			SectionName.TextColor3 = Color3.fromRGB(200, 200, 200)
			SectionName.TextSize = Library.FSize
			SectionName.TextStrokeTransparency = 0
			SectionName.TextXAlignment = Enum.TextXAlignment.Left
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1
			SectionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionName.BorderSizePixel = 0
			SectionName.Position = UDim2.new(0, 5, 0, 0)
			SectionName.Size = UDim2.new(1, 0, 1, 0)
			SectionName.Parent = SectionTop

			SectionTop.Parent = NewSection

			local SectionContent = Instance.new("Frame")
			SectionContent.Name = "SectionContent"
			SectionContent.AutomaticSize = Enum.AutomaticSize.Y
			SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContent.BackgroundTransparency = 1
			SectionContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionContent.BorderSizePixel = 0
			SectionContent.Position = UDim2.new(0, 10, 0, 25)
			SectionContent.Size = UDim2.new(1, -20, 0, 0)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 10)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = SectionContent

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 8)
			UIPadding.PaddingTop = UDim.new(0, 5)
			UIPadding.Parent = SectionContent

			SectionContent.Parent = NewSection

			
			Section.Elements = {
				SectionContent = SectionContent;
			}

			
			Section.Page.Sections[#Section.Page.Sections + 1] = Section
			return setmetatable(Section, Library.Sections)
		end
		
		function Pages:MultiSection(Properties)
			if not Properties then
				Properties = {}
			end
			
			local Section = {
				Sections = (Properties.sections or Properties.Sections or {}),
				Page = self,
				Side = (Properties.side or Properties.Side or "left"):lower(),
				Zindex = (Properties.Zindex or Properties.zindex or 1),
				Elements = {},
				Content = {},
				ActualSections = {};
			}
			
			local NewSection = Instance.new("Frame")
			NewSection.Name = "NewSection"
			NewSection.AutomaticSize = Enum.AutomaticSize.Y
			NewSection.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			NewSection.BorderColor3 = Color3.fromRGB(30, 30, 30)
			NewSection.Size = UDim2.new(1, 0, 0, 50)
			NewSection.ZIndex = Section.Zindex
			NewSection.Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right

			local SectionTop = Instance.new("Frame")
			SectionTop.Name = "SectionTop"
			SectionTop.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
			SectionTop.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTop.BorderSizePixel = 0
			SectionTop.Size = UDim2.new(1, 0, 0, 20)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = SectionTop

			SectionTop.Parent = NewSection

			
			Section.Elements = {
				Top = SectionTop;
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

				
				local SectionName = Instance.new("TextButton")
				SectionName.Name = "SectionName"
				SectionName.FontFace = menu_font
				SectionName.Text = V
				SectionName.TextColor3 = Color3.fromRGB(200, 200, 200)
				SectionName.TextSize = Library.FSize
				SectionName.TextStrokeTransparency = 0
				SectionName.TextXAlignment = Enum.TextXAlignment.Center
				SectionName.BackgroundColor3 = Color3.fromRGB(20,20,20)
				SectionName.BackgroundTransparency = 0
				SectionName.BorderColor3 = Color3.fromRGB(30, 30, 30)
				SectionName.BorderSizePixel = 1
				SectionName.Position = UDim2.new(0, 5, 0, 0)
				SectionName.Size = UDim2.new(1, 0, 1, -2)
				SectionName.Parent = SectionTop
				SectionName.AutoButtonColor = false

				local SectionContent = Instance.new("Frame")
				SectionContent.Name = "SectionContent"
				SectionContent.AutomaticSize = Enum.AutomaticSize.Y
				SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SectionContent.BackgroundTransparency = 1
				SectionContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SectionContent.BorderSizePixel = 0
				SectionContent.Position = UDim2.new(0, 10, 0, 25)
				SectionContent.Size = UDim2.new(1, -20, 0, 0)
				SectionContent.Visible = false

				local UIListLayout = Instance.new("UIListLayout")
				UIListLayout.Name = "UIListLayout"
				UIListLayout.Padding = UDim.new(0, 10)
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Parent = SectionContent

				local UIPadding = Instance.new("UIPadding")
				UIPadding.Name = "UIPadding"
				UIPadding.PaddingBottom = UDim.new(0, 8)
				UIPadding.PaddingTop = UDim.new(0, 5)
				UIPadding.Parent = SectionContent

				SectionContent.Parent = NewSection

				table.insert(SectionButtons, SectionName)

				for Index, RSection in next, SectionButtons do
					RSection.Size = UDim2.new(1 / #SectionButtons, 0, 1, 0)
				end;

				function MultiSection:Turn(bool)
					MultiSection.Open = bool
					TweenService:Create(SectionName, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = MultiSection.Open and Color3.fromRGB(27, 27, 27) or Color3.fromRGB(20,20,20)}):Play()
					SectionContent.Visible = MultiSection.Open
				end;

				Library:Connection(SectionName.MouseButton1Click, function()
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

				
				MultiSection.Elements = {
					Title = SectionName;
					SectionContent = SectionContent;
				};

				
				SectionShit2.ActualSections[#SectionShit2.ActualSections + 1] = setmetatable(MultiSection, Library.Sections)
			end;

			
			Section.Page.Sections[#Section.Page.Sections + 1] = Section;
			Section.ActualSections[1]:Turn(true)
			return table.unpack(Section.ActualSections)
		end
		
		function Sections:Toggle(Properties)
			if not Properties then
				Properties = {}
			end
			
			local Toggle = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Risk = Properties.Risk or false,
				Name = Properties.Name or "Toggle",
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or false
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				Toggled = false,
				Colorpickers = 0,
			}
			
			local NewToggle = Instance.new("TextButton")
			NewToggle.Name = "NewToggle"
			NewToggle.FontFace = menu_font
			NewToggle.Text = ""
			NewToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewToggle.TextSize = 7
			NewToggle.AutoButtonColor = false
			NewToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewToggle.BackgroundTransparency = 1
			NewToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewToggle.BorderSizePixel = 0
			NewToggle.Size = UDim2.new(1, 0, 0, 10)
			NewToggle.Parent = Toggle.Section.Elements.SectionContent

			local Frame = Instance.new("Frame")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frame.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Frame.BorderSizePixel = 0
			Frame.Size = UDim2.new(0, 10, 0, 10)

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Frame

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BackgroundTransparency = 1
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, -2, 1, -2)
			Accent.Position = UDim2.new(0,1,0,1)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			local UIGradient2 = Instance.new("UIGradient")
			UIGradient2.Name = "UIGradient"
			UIGradient2.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient2.Rotation = 90
			UIGradient2.Parent = Frame

			Accent.Parent = Frame

			Frame.Parent = NewToggle

			local Title = Library:NewInstance("TextLabel", Toggle.Risk)
			Title.Name = "Title"
			Title.FontFace = menu_font
			Title.Text = Toggle.Name
			Title.TextColor3 = Toggle.Risk and Library.Accent or Color3.fromRGB(200, 200, 200)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 18, 0, 0)
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewToggle

			
			local function SetState()
				Toggle.Toggled = not Toggle.Toggled
				TweenService:Create(Accent, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = Toggle.Toggled and 0 or 1}):Play()
				Library.Flags[Toggle.Flag] = Toggle.Toggled
				Toggle.Callback(Toggle.Toggled)
			end
			
			Library:Connection(NewToggle.MouseButton1Down, SetState)

			function Toggle:Keybind(Properties)
				local Properties = Properties or {}
				local Keybind = {
					Section = self,
					Name = Properties.name or Properties.Name or "Keybind",
					State = (
						Properties.state
							or Properties.State
							or Properties.def
							or Properties.Def
							or Properties.default
							or Properties.Default
							or nil
					),
					Mode = (Properties.mode or Properties.Mode or "Toggle"),
					UseKey = (Properties.UseKey or false),
					Ignore = (Properties.ignore or Properties.Ignore or false),
					Callback = (
						Properties.callback
							or Properties.Callback
							or Properties.callBack
							or Properties.CallBack
							or function() end
					),
					Flag = (
						Properties.flag
							or Properties.Flag
							or Properties.pointer
							or Properties.Pointer
							or Library.NextFlag()
					),
					Binding = nil,
				}
				local Key
				local State = false
				

				local ModeBox = Instance.new("Frame")
				local Hold = Instance.new("TextButton")
				local Toggle = Instance.new("TextButton")
				local Always = Instance.new("TextButton")
				local ListValue = Library.KeyList:NewKey(Keybind.State, Keybind.Name, Keybind.Mode)
				
				local Icon = Instance.new("TextButton")
				Icon.Name = "Icon"
				Icon.AnchorPoint = Vector2.new(0, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				Icon.BorderColor3 = Color3.fromRGB(30, 30, 30)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(1, -30, 0.5, 0)
				Icon.Size = UDim2.new(0, 30, 0, 14)
				Icon.Text = ""
				Icon.AutoButtonColor = false

				local UIGradient3 = Instance.new("UIGradient")
				UIGradient3.Name = "UIGradient"
				UIGradient3.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
				})
				UIGradient3.Rotation = 90
				UIGradient3.Parent = Icon

				local UIStroke2 = Instance.new("UIStroke")
				UIStroke2.Name = "UIStroke"
				UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke2.Color = Color3.fromRGB(30, 30, 30)
				UIStroke2.LineJoinMode = Enum.LineJoinMode.Miter
				UIStroke2.Parent = Icon

				local Value = Instance.new("TextLabel")
				Value.Name = "Value"
				Value.FontFace = menu_font
				Value.Text = "MB2"
				Value.TextColor3 = Color3.fromRGB(200, 200, 200)
				Value.TextSize = Library.FSize
				Value.TextStrokeTransparency = 0
				Value.TextWrapped = true
				Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Value.BackgroundTransparency = 1
				Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderSizePixel = 0
				Value.Size = UDim2.new(1, 0, 1, 0)
				Value.Parent = Icon

				Icon.Parent = NewToggle

				ModeBox.Name = "ModeBox"
				ModeBox.Parent = Icon
				ModeBox.AnchorPoint = Vector2.new(0,0.5)
				ModeBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
				ModeBox.BorderColor3 = Color3.fromRGB(30,30,30)
				ModeBox.BorderSizePixel = 1
				ModeBox.Size = UDim2.new(0, 65, 0, 60)
				ModeBox.Position = UDim2.new(0,40,0.5,0)
				ModeBox.Visible = false

				Hold.Name = "Hold"
				Hold.Parent = ModeBox
				Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Hold.BackgroundTransparency = 1.000
				Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Hold.BorderSizePixel = 0
				Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
				Hold.ZIndex = 2
				Hold.FontFace = menu_font
				Hold.Text = "Hold"
				Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.fromRGB(200,200,200) or Color3.fromRGB(145,145,145)
				Hold.TextSize = Library.FSize
				Hold.TextStrokeTransparency = 0

				Toggle.Name = "Toggle"
				Toggle.Parent = ModeBox
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BackgroundTransparency = 1.000
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0, 0, 0.333000004, 0)
				Toggle.Size = UDim2.new(1, 0, 0.333000004, 0)
				Toggle.ZIndex = 2
				Toggle.FontFace = menu_font
				Toggle.Text = "Toggle"
				Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.fromRGB(200,200,200) or Color3.fromRGB(145,145,145)
				Toggle.TextSize = Library.FSize
				Toggle.TextStrokeTransparency = 0

				Always.Name = "Always"
				Always.Parent = ModeBox
				Always.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Always.BackgroundTransparency = 1.000
				Always.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Always.BorderSizePixel = 0
				Always.Position = UDim2.new(0, 0, 0.666999996, 0)
				Always.Size = UDim2.new(1, 0, 0.333000004, 0)
				Always.ZIndex = 2
				Always.FontFace = menu_font
				Always.Text = "Always"
				Always.TextColor3 = Keybind.Mode == "Always" and Color3.fromRGB(200,200,200) or Color3.fromRGB(145,145,145)
				Always.TextSize = Library.FSize
				Always.TextStrokeTransparency = 0

				
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
							if Keybind.UseKey then
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = Key
								end
								Keybind.Callback(Key)
							end
							local text = "None"

							Value.Text = text
							ListValue:Update(text, Keybind.Name, Keybind.Mode)
						elseif newkey ~= nil then
							Key = newkey
							if Keybind.UseKey then
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = Key
								end
								Keybind.Callback(Key)
							end
							local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))

							Value.Text = text
							ListValue:Update(text, Keybind.Name, Keybind.Mode)
						end

						Library.Flags[Keybind.Flag .. "_KEY"] = newkey
					elseif table.find({ "Always", "Toggle", "Hold" }, newkey) then
						if not Keybind.UseKey then
							Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
							Keybind.Mode = newkey
							ListValue:Update((Library.Keys[Key] or tostring(Key):gsub("Enum.KeyCode.", "")), Keybind.Name, Keybind.Mode)
							if Keybind.Mode == "Always" then
								State = true
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = State
								end
								Keybind.Callback(true)
								ListValue:SetVisible(true)
							end
						end
					else
						State = newkey
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = newkey
						end
						Keybind.Callback(newkey)
					end
				end
				
				set(Keybind.State)
				set(Keybind.Mode)
				Icon.MouseButton1Click:Connect(function()
					if not Keybind.Binding then

						Value.Text = "..."

						Keybind.Binding = Library:Connection(
							game:GetService("UserInputService").InputBegan,
							function(input, gpe)
								set(
									input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode
										or input.UserInputType
								)
								Library:Disconnect(Keybind.Binding)
								task.wait()
								Keybind.Binding = nil
							end
						)
					end
				end)
				
				Library:Connection(game:GetService("UserInputService").InputBegan, function(inp)
					if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding and not Keybind.UseKey then
						if Keybind.Mode == "Hold" then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = true
							end
							c = Library:Connection(game:GetService("RunService").RenderStepped, function()
								if Keybind.Callback then
									Keybind.Callback(true)
								end
							end)
							ListValue:SetVisible(true)
						elseif Keybind.Mode == "Toggle" then
							State = not State
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(State)
							ListValue:SetVisible(State)
						end
					end
				end)
				
				Library:Connection(game:GetService("UserInputService").InputEnded, function(inp)
					if Keybind.Mode == "Hold" and not Keybind.UseKey then
						if Key ~= "" or Key ~= nil then
							if inp.KeyCode == Key or inp.UserInputType == Key then
								if c then
									c:Disconnect()
									if Keybind.Flag then
										Library.Flags[Keybind.Flag] = false
									end
									if Keybind.Callback then
										Keybind.Callback(false)
									end
									ListValue:SetVisible(false)
								end
							end
						end
					end
				end)
				
				Library:Connection(Icon.MouseButton2Down, function()
					ModeBox.Visible = true
					NewToggle.ZIndex = 5
				end)
				
				Library:Connection(Hold.MouseButton1Down, function()
					set("Hold")
					Hold.TextColor3 = Color3.fromRGB(200,200,200)
					Toggle.TextColor3 = Color3.fromRGB(145,145,145)
					Always.TextColor3 = Color3.fromRGB(145,145,145)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				
				Library:Connection(Toggle.MouseButton1Down, function()
					set("Toggle")
					Hold.TextColor3 = Color3.fromRGB(145,145,145)
					Toggle.TextColor3 = Color3.fromRGB(200,200,200)
					Always.TextColor3 = Color3.fromRGB(145,145,145)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				
				Library:Connection(Always.MouseButton1Down, function()
					set("Always")
					Hold.TextColor3 = Color3.fromRGB(145,145,145)
					Toggle.TextColor3 = Color3.fromRGB(145,145,145)
					Always.TextColor3 = Color3.fromRGB(200,200,200)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				
				Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
					if ModeBox.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if not Library:IsMouseOverFrame(ModeBox) then
							ModeBox.Visible = false
							NewToggle.ZIndex = 1
						end
					end
				end)
				
				Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
				Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
				Flags[Keybind.Flag] = set
				Flags[Keybind.Flag .. "_KEY"] = set
				Flags[Keybind.Flag .. "_KEY STATE"] = set
				
				function Keybind:Set(key)
					set(key)
				end

				
				return Keybind
			end

			function Toggle:Colorpicker(Properties)
				local Properties = Properties or {}
				local Colorpicker = {
					State = (
						Properties.state
							or Properties.State
							or Properties.def
							or Properties.Def
							or Properties.default
							or Properties.Default
							or Color3.fromRGB(255, 0, 0)
					),
					Alpha = (
						Properties.alpha
							or Properties.Alpha
							or Properties.transparency
							or Properties.Transparency
							or 1
					),
					Callback = (
						Properties.callback
							or Properties.Callback
							or Properties.callBack
							or Properties.CallBack
							or function() end
					),
					Flag = (
						Properties.flag
							or Properties.Flag
							or Properties.pointer
							or Properties.Pointer
							or Library.NextFlag()
					),
				}
				
				Toggle.Colorpickers = Toggle.Colorpickers + 1
				local colorpickertypes, ColorWindow, Icon = Library:NewPicker(
					"",
					Colorpicker.State,
					Colorpicker.Alpha,
					NewToggle,
					Toggle.Colorpickers,
					Colorpicker.Flag,
					Colorpicker.Callback
				)

				function Colorpicker:Set(color)
					colorpickertypes:set(color)
				end

				function Colorpicker:SetVisible(Bool) 
					Icon.Visible = Bool
				end 

				
				return Colorpicker
			end

			function Toggle.Set(bool)
				bool = type(bool) == "boolean" and bool or false
				if Toggle.Toggled ~= bool then
					SetState()
				end
			end
			 
			function Toggle.SetVisible(bool) 
				NewToggle.Visible = bool
			end 

			Toggle.Set(Toggle.State)
			Library.Flags[Toggle.Flag] = Toggle.State
			Flags[Toggle.Flag] = Toggle.Set

			
			return Toggle
		end
		
		function Sections:Slider(Properties)
			if not Properties then
				Properties = {}
			end
			
			local Slider = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or nil,
				Min = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or 10
				),
				Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 100),
				Sub = (
					Properties.suffix
						or Properties.Suffix
						or Properties.ending
						or Properties.Ending
						or Properties.prefix
						or Properties.Prefix
						or Properties.measurement
						or Properties.Measurement
						or ""
				),
				Decimals = (Properties.decimals or Properties.Decimals or 1),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				Disabled = (Properties.Disabled or Properties.disable or nil),
			}
			 
			local TextValue = ("[value]" .. Slider.Sub)
			
			local NewSlider = Instance.new("TextButton")
			NewSlider.Name = "NewSlider"
			NewSlider.FontFace = menu_font
			NewSlider.Text = ""
			NewSlider.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewSlider.TextSize = 7
			NewSlider.AutoButtonColor = false
			NewSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewSlider.BackgroundTransparency = 1
			NewSlider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewSlider.BorderSizePixel = 0
			NewSlider.Size = UDim2.new(1, 0, 0, 28)
			NewSlider.Parent = Slider.Section.Elements.SectionContent

			local Frame = Instance.new("TextButton")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frame.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0, 0, 1, -10)
			Frame.Size = UDim2.new(1, 0, 0, 10)
			Frame.AutoButtonColor = false
			Frame.Text = ""

			function Slider:SetVisible(Bool)
				NewSlider.Visible = Bool
			end 

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Name = "UIGradient"
			UIGradient3.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient3.Rotation = 90
			UIGradient3.Parent = Frame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Frame

			local Accent = Library:NewInstance("TextButton", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(0.5, 0, 1, 0)
			Accent.Text = ""
			Accent.AutoButtonColor = false

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			Accent.Parent = Frame

			Frame.Parent = NewSlider

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = menu_font
			Title.Text = Slider.Name
			Title.TextColor3 = Color3.fromRGB(200, 200, 200)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 12)
			Title.Parent = NewSlider

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = menu_font
			Value.Text = "100"
			Value.TextColor3 = Color3.fromRGB(200, 200, 200)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextXAlignment = Enum.TextXAlignment.Right
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 0, 12)
			Value.Parent = NewSlider

			
			local Sliding = false
			local Val = Slider.State
			local function Set(value)
				value = math.clamp(Library:Round(value, Slider.Decimals), Slider.Min, Slider.Max)

				local sizeX = ((value - Slider.Min) / (Slider.Max - Slider.Min))
				Accent.Size = UDim2.new(sizeX, 0, 1, 0)
				if Slider.Disabled and value == Slider.Min then
					Value.Text = Slider.Disabled
				else
					Value.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))
				end
				Val = value

				Library.Flags[Slider.Flag] = value
				Slider.Callback(value)
			end				
			
			local function ISlide(input)
				local sizeX = (input.Position.X - Frame.AbsolutePosition.X) / Frame.AbsoluteSize.X
				local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
				Set(value)
			end
			
			Library:Connection(Frame.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					ISlide(input)
				end
			end)
			Library:Connection(Frame.InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = false
				end
			end)
			Library:Connection(Accent.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					ISlide(input)
				end
			end)
			Library:Connection(Accent.InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = false
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if Sliding then
						ISlide(input)
					end
				end
			end)
			
			function Slider:Set(Value)
				Set(Value)
			end
			
			Flags[Slider.Flag] = Set
			Library.Flags[Slider.Flag] = Slider.State
			Set(Slider.State)

			
			return Slider
		end
		
		function Sections:List(Properties)
			local Properties = Properties or {};
			local Dropdown = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Open = false,
				Name = Properties.Name or Properties.name or nil,
				Options = (Properties.options or Properties.Options or Properties.values or Properties.Values or {
					"1",
					"2",
					"3",
				}),
				Max = (Properties.Max or Properties.max or nil),
				ScrollMax = (Properties.ScrollingMax or Properties.scrollingmax or nil),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or nil
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				OptionInsts = {},
			}
			
			local NewList = Instance.new("TextButton")
			NewList.Name = "NewList"
			NewList.FontFace = menu_font
			NewList.Text = ""
			NewList.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewList.TextSize = 7
			NewList.AutoButtonColor = false
			NewList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewList.BackgroundTransparency = 1
			NewList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewList.BorderSizePixel = 0
			NewList.Size = UDim2.new(1, 0, 0, 34)
			NewList.Parent = Dropdown.Section.Elements.SectionContent

			function Dropdown:SetVisible(Bool) 
				NewList.Visible = Bool
			end 

			local Frame = Instance.new("TextButton")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frame.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0, 0, 1, -16)
			Frame.Size = UDim2.new(1, 0, 0, 16)
			Frame.Text = ""
			Frame.AutoButtonColor = false

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Name = "UIGradient"
			UIGradient3.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient3.Rotation = 90
			UIGradient3.Parent = Frame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Frame

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = menu_font
			Value.Text = ""
			Value.TextColor3 = Color3.fromRGB(200, 200, 200)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.AnchorPoint = Vector2.new(0, 0.5)
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 5, 0.5, 0)
			Value.Size = UDim2.new(1, -40, 0, 12)
			Value.Parent = Frame

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.AnchorPoint = Vector2.new(0, 0.5)
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Position = UDim2.new(1, -14, 0.5, 0)
			Accent.Size = UDim2.new(0, 8, 0, 8)

			local UICorner = Instance.new("UICorner")
			UICorner.Name = "UICorner"
			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = Accent

			Accent.Parent = Frame

			local Content = Library:NewInstance("ScrollingFrame", true)
			Content.Name = "Content"
			Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
			Content.BottomImage = "rbxassetid://7783554086"
			Content.CanvasSize = UDim2.new()
			Content.MidImage = "rbxassetid://7783554086"
			Content.ScrollBarImageColor3 = Library.Accent
			Content.ScrollBarThickness = 4
			Content.TopImage = "rbxassetid://7783554086"
			Content.Active = true
			Content.AutomaticSize = Enum.AutomaticSize.Y
			Content.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Content.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Content.Position = UDim2.new(0, 0, 1, 0)
			Content.Size = UDim2.new(1, 0, 0, 0)
			Content.Visible = false
			Content.ZIndex = 50

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Content

			Content.Parent = Frame

			Frame.Parent = NewList

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = menu_font
			Title.Text = Dropdown.Name
			Title.TextColor3 = Color3.fromRGB(200, 200, 200)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 12)
			Title.Parent = NewList

			
			Library:Connection(Frame.MouseButton1Down, function()
				Content.Visible = not Content.Visible
				if Content.Visible then
					NewList.ZIndex = 5
				else
					NewList.ZIndex = 1
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if Content.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(Content) and not Library:IsMouseOverFrame(Frame) then
						Content.Visible = false
						NewList.ZIndex = 1
					end
				end
			end)
			
			local chosen = Dropdown.Max and {} or nil
			local Count = 0
			
			local function handleoptionclick(option, button, text, accent)
				button.MouseButton1Down:Connect(function()
					if Dropdown.Max then
						if table.find(chosen, option) then
							table.remove(chosen, table.find(chosen, option))

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
							text.Position = UDim2.new(0, 6, 0.5, 0)
							accent.Visible = false

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						else
							if #chosen == Dropdown.Max then
								Dropdown.OptionInsts[chosen[1]].accent.Visible = false
								Dropdown.OptionInsts[chosen[1]].text.Position = UDim2.new(0, 6, 0.5, 0)
								table.remove(chosen, 1)
							end

							table.insert(chosen, option)

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
							text.Position = UDim2.new(0, 8, 0.5, 0)
							accent.Visible = true

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						end
					else
						for opt, tbl in next, Dropdown.OptionInsts do
							if opt ~= option then
								tbl.text.Position = UDim2.new(0, 6, 0.5, 0)
								tbl.accent.Visible = false
							end
						end
						chosen = option
						Value.Text = option
						text.Position = UDim2.new(0, 8, 0.5, 0)
						accent.Visible = true
						Content.Visible = false
						NewList.ZIndex = 1
						Library.Flags[Dropdown.Flag] = option
						Dropdown.Callback(option)
					end
				end)
			end
			
			local function createoptions(tbl)
				for _, option in next, tbl do
					Dropdown.OptionInsts[option] = {}
					
					local NewOption = Instance.new("TextButton")
					NewOption.Name = "NewOption"
					NewOption.FontFace = menu_font
					NewOption.Text = ""
					NewOption.TextColor3 = Color3.fromRGB(0, 0, 0)
					NewOption.TextSize = 7
					NewOption.AutoButtonColor = false
					NewOption.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					NewOption.BorderColor3 = Color3.fromRGB(30, 30, 30)
					NewOption.Size = UDim2.new(1, 0, 0, 15)

					local Value1 = Instance.new("TextLabel")
					Value1.Name = "Value"
					Value1.FontFace = menu_font
					Value1.Text = option
					Value1.TextColor3 = Color3.fromRGB(200, 200, 200)
					Value1.TextSize = Library.FSize
					Value1.TextStrokeTransparency = 0
					Value1.TextWrapped = true
					Value1.TextXAlignment = Enum.TextXAlignment.Left
					Value1.AnchorPoint = Vector2.new(0, 0.5)
					Value1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Value1.BackgroundTransparency = 1
					Value1.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Value1.BorderSizePixel = 0
					Value1.Position = UDim2.new(0, 6, 0.5, 0)
					Value1.Size = UDim2.new(1, -40, 0, 12)
					Value1.Parent = NewOption

					local AccentLine = Library:NewInstance("Frame", true)
					AccentLine.Name = "AccentLine"
					AccentLine.BackgroundColor3 = Library.Accent
					AccentLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
					AccentLine.BorderSizePixel = 0
					AccentLine.Size = UDim2.new(0, 2, 1, 0)
					AccentLine.Parent = NewOption
					AccentLine.Visible = false

					NewOption.Parent = Content

					Dropdown.OptionInsts[option].text = Value1
					Dropdown.OptionInsts[option].accent = AccentLine

					Count = Count + 1

					if Dropdown.ScrollMax then
						Content.AutomaticSize = Enum.AutomaticSize.None
						if Count < Dropdown.ScrollMax then
						else
							Content.Size = UDim2.new(1,0, 0, 15*Dropdown.ScrollMax)
						end
					else
						Content.AutomaticSize = Enum.AutomaticSize.Y
					end

					handleoptionclick(option, NewOption, Value1, AccentLine)
				end
			end
			createoptions(Dropdown.Options)
			
			local set
			set = function(option)
				if Dropdown.Max then
					table.clear(chosen)
					option = type(option) == "table" and option or {}

					for opt, tbl in next, Dropdown.OptionInsts do
						if not table.find(option, opt) then
							tbl.text.Position = UDim2.new(0, 6, 0.5, 0)
							tbl.accent.Visible = false
						end
					end

					for i, opt in next, option do
						if table.find(Dropdown.Options, opt) and #chosen < Dropdown.Max then
							table.insert(chosen, opt)
						end
					end

					local textchosen = {}
					local cutobject = false

					for _, opt in next, chosen do
						table.insert(textchosen, opt)
					end

					Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

					Library.Flags[Dropdown.Flag] = chosen
					Dropdown.Callback(chosen)
				end
			end
			
			function Dropdown:Set(option)
				if Dropdown.Max then
					set(option)
				else
					for opt, tbl in next, Dropdown.OptionInsts do
						if opt ~= option then
							tbl.text.Position = UDim2.new(0, 6, 0.5, 0)
							tbl.accent.Visible = false
						end
					end
					if table.find(Dropdown.Options, option) then
						chosen = option
						Dropdown.OptionInsts[option].text.Position = UDim2.new(0, 8, 0.5, 0)
						Dropdown.OptionInsts[option].accent.Visible = true
						Value.Text = option
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					else
						chosen = nil
						Value.Text = "None"
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					end
				end
			end
			
			function Dropdown:Refresh(tbl)
				for _, opt in next, Dropdown.OptionInsts do
					coroutine.wrap(function()
						opt.button:Destroy()
					end)()
				end
				table.clear(Dropdown.OptionInsts)

				createoptions(tbl)

				if Dropdown.Max then
					table.clear(chosen)
				else
					chosen = nil
				end

				Library.Flags[Dropdown.Flag] = chosen
				Dropdown.Callback(chosen)
			end

			
			if Dropdown.Max then
				Flags[Dropdown.Flag] = set
			else
				Flags[Dropdown.Flag] = Dropdown
			end
			Dropdown:Set(Dropdown.State)
			return Dropdown
		end
		
		function Sections:Colorpicker(Properties)
			local Properties = Properties or {}
			local Colorpicker = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = (Properties.Name or "Colorpicker"),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or Color3.fromRGB(255, 0, 0)
				),
				Alpha = (
					Properties.alpha
						or Properties.Alpha
						or Properties.transparency
						or Properties.Transparency
						or 1
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				Colorpickers = 0,
			}
			
			local NewColor = Instance.new("TextButton")
			NewColor.Name = "NewColor"
			NewColor.FontFace = menu_font
			NewColor.Text = ""
			NewColor.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewColor.TextSize = 7
			NewColor.AutoButtonColor = false
			NewColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewColor.BackgroundTransparency = 1
			NewColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewColor.BorderSizePixel = 0
			NewColor.Size = UDim2.new(1, 0, 0, 12)
			NewColor.Parent = Colorpicker.Section.Elements.SectionContent

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = menu_font
			Title.Text = Colorpicker.Name
			Title.TextColor3 = Color3.fromRGB(200, 200, 200)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewColor

			
			Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
			local colorpickertypes = Library:NewPicker(
				Colorpicker.Name,
				Colorpicker.State,
				Colorpicker.Alpha,
				NewColor,
				Colorpicker.Colorpickers,
				Colorpicker.Flag,
				Colorpicker.Callback
			)

			function Colorpicker:Set(color)
				colorpickertypes:set(color, false, true)
			end

			function Colorpicker:Colorpicker(Properties)
				local Properties = Properties or {}
				local NewColorpicker = {
					State = (
						Properties.state
							or Properties.State
							or Properties.def
							or Properties.Def
							or Properties.default
							or Properties.Default
							or Color3.fromRGB(255, 0, 0)
					),
					Alpha = (
						Properties.alpha
							or Properties.Alpha
							or Properties.transparency
							or Properties.Transparency
							or 1
					),
					Callback = (
						Properties.callback
							or Properties.Callback
							or Properties.callBack
							or Properties.CallBack
							or function() end
					),
					Flag = (
						Properties.flag
							or Properties.Flag
							or Properties.pointer
							or Properties.Pointer
							or Library.NextFlag()
					),
				}
				
				Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
				local Newcolorpickertypes = Library:NewPicker(
					"",
					NewColorpicker.State,
					NewColorpicker.Alpha,
					NewColor,
					Colorpicker.Colorpickers,
					NewColorpicker.Flag,
					NewColorpicker.Callback
				)

				function NewColorpicker:Set(color)
					Newcolorpickertypes:Set(color)
				end

				
				return NewColorpicker
			end

			
			return Colorpicker
		end
		
		function Sections:Keybind(Properties)
			local Properties = Properties or {}
			local Keybind = {
				Section = self,
				Name = Properties.name or Properties.Name or "Keybind",
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or nil
				),
				Mode = (Properties.mode or Properties.Mode or "Toggle"),
				UseKey = (Properties.UseKey or false),
				Ignore = (Properties.ignore or Properties.Ignore or false),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
				Binding = nil,
			}
			local Key
			local State = false
			

			local ModeBox = Instance.new("Frame")
			local Hold = Instance.new("TextButton")
			local Toggle = Instance.new("TextButton")
			local Always = Instance.new("TextButton")
			local ListValue
			if not Keybind.Ignore then
				ListValue = Library.KeyList:NewKey(Keybind.State, Keybind.Name, Keybind.Mode)
			end
			
			local NewBind = Instance.new("TextButton")
			NewBind.Name = "NewBind"
			NewBind.FontFace = menu_font
			NewBind.Text = ""
			NewBind.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewBind.TextSize = 7
			NewBind.AutoButtonColor = false
			NewBind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewBind.BackgroundTransparency = 1
			NewBind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewBind.BorderSizePixel = 0
			NewBind.Size = UDim2.new(1, 0, 0, 12)
			NewBind.Parent = Keybind.Section.Elements.SectionContent

			local Icon = Instance.new("TextButton")
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Icon.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(1, -30, 0.5, 0)
			Icon.Size = UDim2.new(0, 30, 0, 14)
			Icon.Text = ""
			Icon.AutoButtonColor = false

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Name = "UIGradient"
			UIGradient3.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient3.Rotation = 90
			UIGradient3.Parent = Icon

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Icon

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = menu_font
			Value.Text = "MB2"
			Value.TextColor3 = Color3.fromRGB(200, 200, 200)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Icon

			Icon.Parent = NewBind

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = menu_font
			Title.Text = Keybind.Name
			Title.TextColor3 = Color3.fromRGB(200, 200, 200)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewBind

			ModeBox.Name = "ModeBox"
			ModeBox.Parent = Icon
			ModeBox.AnchorPoint = Vector2.new(0,0.5)
			ModeBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
			ModeBox.BorderColor3 = Color3.fromRGB(30,30,30)
			ModeBox.BorderSizePixel = 1
			ModeBox.Size = UDim2.new(0, 65, 0, 60)
			ModeBox.Position = UDim2.new(0,40,0.5,0)
			ModeBox.Visible = false

			Hold.Name = "Hold"
			Hold.Parent = ModeBox
			Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hold.BackgroundTransparency = 1.000
			Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hold.BorderSizePixel = 0
			Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
			Hold.ZIndex = 2
			Hold.FontFace = menu_font
			Hold.Text = "Hold"
			Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.fromRGB(200,200,200) or Color3.fromRGB(145,145,145)
			Hold.TextSize = Library.FSize
			Hold.TextStrokeTransparency = 0

			Toggle.Name = "Toggle"
			Toggle.Parent = ModeBox
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BackgroundTransparency = 1.000
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0, 0, 0.333000004, 0)
			Toggle.Size = UDim2.new(1, 0, 0.333000004, 0)
			Toggle.ZIndex = 2
			Toggle.FontFace = menu_font
			Toggle.Text = "Toggle"
			Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.fromRGB(200,200,200) or Color3.fromRGB(145,145,145)
			Toggle.TextSize = Library.FSize
			Toggle.TextStrokeTransparency = 0

			Always.Name = "Always"
			Always.Parent = ModeBox
			Always.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Always.BackgroundTransparency = 1.000
			Always.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Always.BorderSizePixel = 0
			Always.Position = UDim2.new(0, 0, 0.666999996, 0)
			Always.Size = UDim2.new(1, 0, 0.333000004, 0)
			Always.ZIndex = 2
			Always.FontFace = menu_font
			Always.Text = "Always"
			Always.TextColor3 = Keybind.Mode == "Always" and Color3.fromRGB(200,200,200) or Color3.fromRGB(145,145,145)
			Always.TextSize = Library.FSize
			Always.TextStrokeTransparency = 0

			
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
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							Keybind.Callback(Key)
						end
						local text = "None"

						Value.Text = text
						if not Keybind.Ignore then
							ListValue:Update(text, Keybind.Name, Keybind.Mode)
						end
					elseif newkey ~= nil then
						Key = newkey
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							Keybind.Callback(Key)
						end
						local text = (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", ""))

						Value.Text = text
						if not Keybind.Ignore then
							ListValue:Update(text, Keybind.Name, Keybind.Mode)
						end
					end

					Library.Flags[Keybind.Flag .. "_KEY"] = newkey
				elseif table.find({ "Always", "Toggle", "Hold" }, newkey) then
					if not Keybind.UseKey then
						Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
						Keybind.Mode = newkey
						if not Keybind.Ignore then
							ListValue:Update((Library.Keys[Key] or tostring(Key):gsub("Enum.KeyCode.", "")), Keybind.Name, Keybind.Mode)
						end
						if Keybind.Mode == "Always" then
							State = true
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(true)
							ListValue:SetVisible(true)
						end
					end
				else
					State = newkey
					if Keybind.Flag then
						Library.Flags[Keybind.Flag] = newkey
					end
					Keybind.Callback(newkey)
				end
			end
			
			set(Keybind.State)
			set(Keybind.Mode)
			Icon.MouseButton1Click:Connect(function()
				if not Keybind.Binding then

					Value.Text = "..."

					Keybind.Binding = Library:Connection(
						game:GetService("UserInputService").InputBegan,
						function(input, gpe)
							set(
								input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode
									or input.UserInputType
							)
							Library:Disconnect(Keybind.Binding)
							task.wait()
							Keybind.Binding = nil
						end
					)
				end
			end)
			
			Library:Connection(game:GetService("UserInputService").InputBegan, function(inp)
				if (inp.KeyCode == Key or inp.UserInputType == Key) and not Keybind.Binding and not Keybind.UseKey then
					if Keybind.Mode == "Hold" then
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = true
						end
						c = Library:Connection(game:GetService("RunService").RenderStepped, function()
							if Keybind.Callback then
								Keybind.Callback(true)
							end
						end)
						if not Keybind.Ignore then
							ListValue:SetVisible(true)
						end
					elseif Keybind.Mode == "Toggle" then
						State = not State
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = State
						end
						Keybind.Callback(State)
						if not Keybind.Ignore then
							ListValue:SetVisible(State)
						end
					end
				end
			end)
			
			Library:Connection(game:GetService("UserInputService").InputEnded, function(inp)
				if Keybind.Mode == "Hold" and not Keybind.UseKey then
					if Key ~= "" or Key ~= nil then
						if inp.KeyCode == Key or inp.UserInputType == Key then
							if c then
								c:Disconnect()
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = false
								end
								if Keybind.Callback then
									Keybind.Callback(false)
								end
								if not Keybind.Ignore then
									ListValue:SetVisible(false)
								end
							end
						end
					end
				end
			end)
			
			Library:Connection(Icon.MouseButton2Down, function()
				ModeBox.Visible = true
				NewBind.ZIndex = 5
			end)
			
			Library:Connection(Hold.MouseButton1Down, function()
				set("Hold")
				Hold.TextColor3 = Color3.fromRGB(200,200,200)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			
			Library:Connection(Toggle.MouseButton1Down, function()
				set("Toggle")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(200,200,200)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			
			Library:Connection(Always.MouseButton1Down, function()
				set("Always")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(200,200,200)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ModeBox.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ModeBox) then
						ModeBox.Visible = false
						NewBind.ZIndex = 1
					end
				end
			end)
			
			Library.Flags[Keybind.Flag .. "_KEY"] = Keybind.State
			Library.Flags[Keybind.Flag .. "_KEY STATE"] = Keybind.Mode
			Flags[Keybind.Flag] = set
			Flags[Keybind.Flag .. "_KEY"] = set
			Flags[Keybind.Flag .. "_KEY STATE"] = set
			
			function Keybind:Set(key)
				set(key)
			end

			
			return Keybind
		end
		
		function Sections:Textbox(Properties)
			local Properties = Properties or {}
			local Textbox = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = (Properties.Name or Properties.name or "textbox"),
				Placeholder = (
					Properties.placeholder
						or Properties.Placeholder
						or Properties.holder
						or Properties.Holder
						or ""
				),
				State = (
					Properties.state
						or Properties.State
						or Properties.def
						or Properties.Def
						or Properties.default
						or Properties.Default
						or ""
				),
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
			}
			
			local NewBox = Instance.new("TextButton")
			NewBox.Name = "NewBox"
			NewBox.FontFace = menu_font
			NewBox.Text = ""
			NewBox.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewBox.TextSize = 7
			NewBox.AutoButtonColor = false
			NewBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewBox.BackgroundTransparency = 1
			NewBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewBox.BorderSizePixel = 0
			NewBox.Size = UDim2.new(1, 0, 0, 34)
			NewBox.Parent = Textbox.Section.Elements.SectionContent

			function Textbox:SetVisible(Bool)
				NewBox.Visible = Bool
			end 	

			local Frame = Instance.new("Frame")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frame.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Frame.Position = UDim2.new(0, 0, 1, -16)
			Frame.Size = UDim2.new(1, 0, 0, 16)
			Frame.BorderSizePixel = 0

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Name = "UIGradient"
			UIGradient3.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient3.Rotation = 90
			UIGradient3.Parent = Frame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Frame

			local Value = Instance.new("TextBox")
			Value.Name = "Value"
			Value.FontFace = menu_font
			Value.Text = Textbox.State
			Value.PlaceholderText = Textbox.Placeholder
			Value.TextColor3 = Color3.fromRGB(200, 200, 200)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.AnchorPoint = Vector2.new(0, 0.5)
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 5, 0.5, 0)
			Value.Size = UDim2.new(1, -10, 0, 16)
			Value.Parent = Frame
			Value.ClearTextOnFocus = false

			Frame.Parent = NewBox

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = menu_font
			Title.Text = Textbox.Name
			Title.TextColor3 = Color3.fromRGB(200, 200, 200)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 12)
			Title.Parent = NewBox

			
			Value.FocusLost:Connect(function()
				Textbox.Callback(Value.Text)
				Library.Flags[Textbox.Flag] = Value.Text
			end)
			
			local function set(str)
				Value.Text = str
				Library.Flags[Textbox.Flag] = str
				Textbox.Callback(str)
			end

			
			Flags[Textbox.Flag] = set
			return Textbox
		end
		
		function Sections:Button(Properties)
			local Properties = Properties or {}
			local Button = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or "button",
				Callback = (
					Properties.callback
						or Properties.Callback
						or Properties.callBack
						or Properties.CallBack
						or function() end
				),
			}
			
			local NewButton = Instance.new("TextButton")
			NewButton.Name = "NewButton"
			NewButton.FontFace = menu_font
			NewButton.Text = ""
			NewButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.TextSize = 7
			NewButton.AutoButtonColor = false
			NewButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewButton.BackgroundTransparency = 1
			NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.BorderSizePixel = 0
			NewButton.Size = UDim2.new(1, 0, 0, 16)
			NewButton.Parent = Button.Section.Elements.SectionContent

			local Frame = Instance.new("Frame")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frame.BorderColor3 = Color3.fromRGB(30, 30, 30)
			Frame.Position = UDim2.new(0, 0, 1, -16)
			Frame.Size = UDim2.new(1, 0, 0, 16)
			Frame.BorderSizePixel = 0

			local UIGradient3 = Instance.new("UIGradient")
			UIGradient3.Name = "UIGradient"
			UIGradient3.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient3.Rotation = 90
			UIGradient3.Parent = Frame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Frame

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = menu_font
			Value.Text = Button.Name
			Value.TextColor3 = Color3.fromRGB(200, 200, 200)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Frame

			Frame.Parent = NewButton
			
			Library:Connection(NewButton.MouseButton1Down, function()
				Button.Callback()
				TweenService:Create(Value, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Library.Accent}):Play()
				task.spawn(function()
					task.wait(0.25)
					TweenService:Create(Value, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200,200,200)}):Play()
				end)
			end)

			return Button
		end
		
		function Pages:PlayerList(Properties)
			if not Properties then
				Properties = {}
			end
			
			local Playerlist = {
				Page = self,
				Players = {},
				CurrentPlayer = nil;
				LastPlayer = nil;
				Flag = (
					Properties.flag
						or Properties.Flag
						or Properties.pointer
						or Properties.Pointer
						or Library.NextFlag()
				),
			}
			
			local NewPlayer = Instance.new("Frame")
			NewPlayer.Name = "NewPlayer"
			NewPlayer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			NewPlayer.BorderColor3 = Color3.fromRGB(30, 30, 30)
			NewPlayer.Size = UDim2.new(1, 0, 0.5, 80)
			NewPlayer.Parent = Playerlist.Page.Elements.Main

			local SectionTop = Instance.new("Frame")
			SectionTop.Name = "SectionTop"
			SectionTop.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
			SectionTop.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTop.BorderSizePixel = 0
			SectionTop.Size = UDim2.new(1, 0, 0, 20)

			local SectionName = Instance.new("TextLabel")
			SectionName.Name = "SectionName"
			SectionName.FontFace = menu_font
			SectionName.Text = "Player List"
			SectionName.TextColor3 = Color3.fromRGB(200, 200, 200)
			SectionName.TextSize = Library.FSize
			SectionName.TextStrokeTransparency = 0
			SectionName.TextXAlignment = Enum.TextXAlignment.Left
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1
			SectionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionName.BorderSizePixel = 0
			SectionName.Position = UDim2.new(0, 5, 0, 0)
			SectionName.Size = UDim2.new(1, 0, 1, 0)
			SectionName.Parent = SectionTop

			SectionTop.Parent = NewPlayer

			local List = Library:NewInstance("ScrollingFrame", true)
			List.Name = "List"
			List.AutomaticCanvasSize = Enum.AutomaticSize.Y
			List.BottomImage = "rbxassetid://7783554086"
			List.CanvasSize = UDim2.new()
			List.MidImage = "rbxassetid://7783554086"
			List.ScrollBarImageColor3 = Library.Accent
			List.ScrollBarThickness = 8
			List.TopImage = "rbxassetid://7783554086"
			List.Active = true
			List.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			List.BorderColor3 = Color3.fromRGB(30, 30, 30)
			List.Position = UDim2.new(0, 5, 0, 25)
			List.Size = UDim2.new(1, -10, 0, 225)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = List

			List.Parent = NewPlayer

			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.Image = ""
			ImageLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ImageLabel.BorderColor3 = Color3.fromRGB(30, 30, 30)
			ImageLabel.Position = UDim2.new(0, 5, 1, -75)
			ImageLabel.Size = UDim2.new(0, 70, 0, 70)
			ImageLabel.Parent = NewPlayer

			local PlayerName1 = Instance.new("TextLabel")
			PlayerName1.Name = "PlayerName"
			PlayerName1.FontFace = menu_font
			PlayerName1.Text = "Select a Player."
			PlayerName1.TextColor3 = Color3.fromRGB(200, 200, 200)
			PlayerName1.TextSize = Library.FSize
			PlayerName1.TextStrokeTransparency = 0
			PlayerName1.TextXAlignment = Enum.TextXAlignment.Left
			PlayerName1.TextYAlignment = Enum.TextYAlignment.Top
			PlayerName1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PlayerName1.BackgroundTransparency = 1
			PlayerName1.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PlayerName1.BorderSizePixel = 0
			PlayerName1.Position = UDim2.new(0, 80, 1, -75)
			PlayerName1.Size = UDim2.new(1, -459, 0, 70)
			PlayerName1.Parent = NewPlayer

			local Priority = Instance.new("TextButton")
			Priority.Name = "Priority"
			Priority.FontFace = menu_font
			Priority.Text = ""
			Priority.TextColor3 = Color3.fromRGB(0, 0, 0)
			Priority.TextSize = 7
			Priority.AutoButtonColor = false
			Priority.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Priority.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Priority.BorderSizePixel = 0
			Priority.Position = UDim2.new(1, -105, 1, -70)
			Priority.Size = UDim2.new(0, 100, 0, 25)

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Priority

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Priority

			local PriorityLabel = Instance.new("TextLabel")
			PriorityLabel.Name = "PriorityLabel"
			PriorityLabel.FontFace = menu_font
			PriorityLabel.Text = "Prioritize"
			PriorityLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			PriorityLabel.TextSize = Library.FSize
			PriorityLabel.TextStrokeTransparency = 0
			PriorityLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PriorityLabel.BackgroundTransparency = 1
			PriorityLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PriorityLabel.BorderSizePixel = 0
			PriorityLabel.Size = UDim2.new(1, 0, 1, 0)
			PriorityLabel.Parent = Priority

			Priority.Parent = NewPlayer

			local Friend = Instance.new("TextButton")
			Friend.Name = "Friend"
			Friend.FontFace = menu_font
			Friend.Text = ""
			Friend.TextColor3 = Color3.fromRGB(0, 0, 0)
			Friend.TextSize = 7
			Friend.AutoButtonColor = false
			Friend.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Friend.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Friend.BorderSizePixel = 0
			Friend.Position = UDim2.new(1, -105, 1, -35)
			Friend.Size = UDim2.new(0, 100, 0, 25)

			local UIStroke1 = Instance.new("UIStroke")
			UIStroke1.Name = "UIStroke"
			UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke1.Color = Color3.fromRGB(30, 30, 30)
			UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke1.Parent = Friend

			local UIGradient1 = Instance.new("UIGradient")
			UIGradient1.Name = "UIGradient"
			UIGradient1.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
			})
			UIGradient1.Rotation = 90
			UIGradient1.Parent = Friend

			local FriendLabel = Instance.new("TextLabel")
			FriendLabel.Name = "FriendLabel"
			FriendLabel.FontFace = menu_font
			FriendLabel.Text = "Friendly"
			FriendLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			FriendLabel.TextSize = Library.FSize
			FriendLabel.TextStrokeTransparency = 0
			FriendLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			FriendLabel.BackgroundTransparency = 1
			FriendLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FriendLabel.BorderSizePixel = 0
			FriendLabel.Size = UDim2.new(1, 0, 1, 0)
			FriendLabel.Parent = Friend

			Friend.Parent = NewPlayer

			
			local chosen = nil
			local optioninstances = {}
			local function handleoptionclick(option, button, accent)
				button.MouseButton1Click:Connect(function()
					chosen = option
					Library.Flags[Playerlist.Flag] = option
					Playerlist.CurrentPlayer = option
					
					for opt, tbl in next, optioninstances do
						if opt ~= option then
							tbl.accent.Visible = false
						end
					end
					accent.Visible = true
					
					if Playerlist.CurrentPlayer ~= Playerlist.LastPlayer then
						Playerlist.LastPlayer = Playerlist.CurrentPlayer;
						PlayerName1.Text = ("Id : %s\nDisplay Name : %s\nName : %s\nAccount Age : %s"):format(Playerlist.CurrentPlayer.UserId, Playerlist.CurrentPlayer.DisplayName ~= "" and Playerlist.CurrentPlayer.DisplayName or Playerlist.CurrentPlayer.Name, Playerlist.CurrentPlayer.Name, Playerlist.CurrentPlayer.AccountAge)
						
						local imagedata = game:GetService("Players"):GetUserThumbnailAsync(Playerlist.CurrentPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

						ImageLabel.Image = imagedata
					end;
				end)
			end
			
			local function createoptions(tbl)
				for i, option in next, tbl do
					optioninstances[option] = {}

					local NewPlayer1 = Instance.new("TextButton")
					NewPlayer1.Name = "NewPlayer"
					NewPlayer1.FontFace = menu_font
					NewPlayer1.Text = ""
					NewPlayer1.TextColor3 = Color3.fromRGB(0, 0, 0)
					NewPlayer1.TextSize = 7
					NewPlayer1.AutoButtonColor = false
					NewPlayer1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					NewPlayer1.BorderColor3 = Color3.fromRGB(30, 30, 30)
					NewPlayer1.Size = UDim2.new(1, 0, 0, 15)

					local PlayerName = Instance.new("TextLabel")
					PlayerName.Name = "PlayerName"
					PlayerName.FontFace = menu_font
					PlayerName.Text = option.Name
					PlayerName.TextColor3 = Color3.fromRGB(200, 200, 200)
					PlayerName.TextSize = Library.FSize
					PlayerName.TextStrokeTransparency = 0
					PlayerName.TextXAlignment = Enum.TextXAlignment.Left
					PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					PlayerName.BackgroundTransparency = 1
					PlayerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
					PlayerName.BorderSizePixel = 0
					PlayerName.Position = UDim2.new(0, 6, 0, 0)
					PlayerName.Size = UDim2.new(1, 0, 1, 0)
					PlayerName.Parent = NewPlayer1

					local PlayerStatus = Instance.new("TextLabel")
					PlayerStatus.Name = "PlayerStatus"
					PlayerStatus.FontFace = menu_font
					PlayerStatus.Text = option == LocalPlayer and "Local Player" or table.find(Library.Friends, option) and "Friendly" or table.find(Library.Priorities, option) and "Priority" or "None"
					PlayerStatus.TextColor3 = option == LocalPlayer and Color3.fromRGB(0, 170, 255) or table.find(Library.Friends, option) and Color3.fromRGB(0,255,0) or table.find(Library.Priorities, option) and Color3.fromRGB(255,0,0) or Color3.fromRGB(200,200,200)
					PlayerStatus.TextSize = Library.FSize
					PlayerStatus.TextStrokeTransparency = 0
					PlayerStatus.TextXAlignment = Enum.TextXAlignment.Right
					PlayerStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					PlayerStatus.BackgroundTransparency = 1
					PlayerStatus.BorderColor3 = Color3.fromRGB(0, 0, 0)
					PlayerStatus.BorderSizePixel = 0
					PlayerStatus.Position = UDim2.new(0, -25, 0, 0)
					PlayerStatus.Size = UDim2.new(1, 0, 1, 0)
					PlayerStatus.Parent = NewPlayer1

					local AccentLine = Library:NewInstance("Frame", true)
					AccentLine.Name = "AccentLine"
					AccentLine.BackgroundColor3 = Library.Accent
					AccentLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
					AccentLine.BorderSizePixel = 0
					AccentLine.Size = UDim2.new(0, 2, 1, 0)
					AccentLine.Visible = false
					AccentLine.Parent = NewPlayer1

					NewPlayer1.Parent = List

					optioninstances[option].button = NewPlayer1
					optioninstances[option].text = PlayerName
					optioninstances[option].status = PlayerStatus
					optioninstances[option].accent = AccentLine

					if option ~= LocalPlayer then
						handleoptionclick(option, NewPlayer1, AccentLine)
					end
				end
			end
			
			function Playerlist:Refresh(tbl, dontchange)
				content = table.clone(tbl)

				for _, opt in next, optioninstances do
					coroutine.wrap(function()
						opt.button:Remove()
					end)()
				end

				table.clear(optioninstances)

				createoptions(content)

				if dontchange then
					chosen = Playerlist.CurrentPlayer
				else
					chosen = nil
				end
				Library.Flags[Playerlist.Flag] = chosen
				Playerlist.CurrentPlayer = nil
			end
			
			Priority.MouseButton1Click:Connect(function()
				if Playerlist.CurrentPlayer ~= nil and table.find(Library.Friends, Playerlist.CurrentPlayer) then
					table.remove(Library.Friends, table.find(Library.Friends, Playerlist.CurrentPlayer))
				end
				if Playerlist.CurrentPlayer ~= nil and not table.find(Library.Priorities, Playerlist.CurrentPlayer) then
					table.insert(Library.Priorities, Playerlist.CurrentPlayer)
					optioninstances[Playerlist.CurrentPlayer].status.Text = "Priority"
					optioninstances[Playerlist.CurrentPlayer].status.TextColor3 = Color3.fromRGB(255, 0, 0)
				elseif Playerlist.CurrentPlayer ~= nil and table.find(Library.Priorities, Playerlist.CurrentPlayer) then
					table.remove(Library.Priorities, table.find(Library.Priorities, Playerlist.CurrentPlayer))
					optioninstances[Playerlist.CurrentPlayer].status.Text = "None"
					optioninstances[Playerlist.CurrentPlayer].status.TextColor3 = Color3.fromRGB(200,200,200)
				end
			end)
			
			Friend.MouseButton1Click:Connect(function()
				if Playerlist.CurrentPlayer ~= nil and table.find(Library.Priorities, Playerlist.CurrentPlayer) then
					table.remove(Library.Priorities, table.find(Library.Priorities, Playerlist.CurrentPlayer))
				end
				if Playerlist.CurrentPlayer ~= nil and not table.find(Library.Friends, Playerlist.CurrentPlayer) then
					table.insert(Library.Friends, Playerlist.CurrentPlayer)
					optioninstances[Playerlist.CurrentPlayer].status.Text = "Friendly"
					optioninstances[Playerlist.CurrentPlayer].status.TextColor3 = Color3.fromRGB(0, 255, 0)
				elseif Playerlist.CurrentPlayer ~= nil and table.find(Library.Friends, Playerlist.CurrentPlayer) then
					table.remove(Library.Friends, table.find(Library.Friends, Playerlist.CurrentPlayer))
					optioninstances[Playerlist.CurrentPlayer].status.Text = "None"
					optioninstances[Playerlist.CurrentPlayer].status.TextColor3 = Color3.fromRGB(200,200,200)
				end
			end)
			
			createoptions(game.Players:GetPlayers())
			
			game.Players.PlayerAdded:Connect(function()
				Playerlist:Refresh(game.Players:GetPlayers(), true)
			end)
			
			game.Players.PlayerRemoving:Connect(function()
				Playerlist:Refresh(game.Players:GetPlayers(), true)
			end)

			Playerlist.Page.Elements.Left.Size = UDim2.new(0.5, -5,0.5, -80)
			Playerlist.Page.Elements.Right.Size = UDim2.new(0.5, -5,0.5, -80)
			Playerlist.Page.Elements.Left.Position = UDim2.new(0, 0,0.5, 85)
			Playerlist.Page.Elements.Right.Position = UDim2.new(0.5, 5,0.5, 85)
		end
		
		function Sections:Label(Properties)
			local Properties = Properties or {}
			local Label = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or "button",
			}
			
			local NewButton = Instance.new("TextButton")
			NewButton.Name = "NewButton"
			NewButton.FontFace = menu_font
			NewButton.Text = ""
			NewButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.TextSize = 7
			NewButton.AutoButtonColor = false
			NewButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewButton.BackgroundTransparency = 1
			NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.BorderSizePixel = 0
			NewButton.Size = UDim2.new(1, 0, 0, 10)
			NewButton.Parent = Label.Section.Elements.SectionContent

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = menu_font
			Value.Text = Label.Name
			Value.TextColor3 = Color3.fromRGB(200, 200, 200)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextWrapped = true
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = NewButton

			return Label
		end
		
		function Library:Indicator(Properties)
			local Indicator = {
				Title = Properties.Name or Properties.name or "New Indicator";
				Elements = {};
				Dragging = { false, UDim2.new(0, 0, 0, 0) };
			};
			
			local Outline = Instance.new("TextButton")
			Outline.Name = "Outline"
			Outline.AutomaticSize = Enum.AutomaticSize.Y
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0,200,0.5,0)
			Outline.Size = UDim2.new(0, 200, 0, 15)
			Outline.AnchorPoint = Vector2.new(0.5,0.5)
			Outline.Parent = Library.ScreenGUI
			Outline.Visible = false
			Outline.Text = ""
			Outline.AutoButtonColor = false

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.Font = Enum.Font.GothamBold
			Value.Text = Indicator.Title
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 0, 0, 2)
			Value.Size = UDim2.new(1, 0, 0, 15)
			Value.Parent = Inline

			local HolderOutline = Instance.new("Frame")
			HolderOutline.Name = "HolderOutline"
			HolderOutline.AutomaticSize = Enum.AutomaticSize.Y
			HolderOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			HolderOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HolderOutline.Position = UDim2.new(0, 6, 0, 22)
			HolderOutline.Size = UDim2.new(1, -12, 0, 0)

			local HolderInline = Instance.new("Frame")
			HolderInline.Name = "HolderInline"
			HolderInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			HolderInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HolderInline.BorderSizePixel = 0
			HolderInline.Position = UDim2.new(0, 1, 0, 1)
			HolderInline.Size = UDim2.new(1, -2, 1, -2)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 2)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = HolderInline

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 6)
			UIPadding.PaddingTop = UDim.new(0, 6)
			UIPadding.Parent = HolderInline

			HolderInline.Parent = HolderOutline

			HolderOutline.Parent = Inline

			local UIPadding1 = Instance.new("UIPadding")
			UIPadding1.Name = "UIPadding"
			UIPadding1.PaddingBottom = UDim.new(0, 6)
			UIPadding1.Parent = Inline

			Inline.Parent = Outline

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 0, 1)
			Accent.Parent = Outline

			Library:Connection(Outline.MouseButton1Down, function()
				local Location = game:GetService("UserInputService"):GetMouseLocation()
				Indicator.Dragging[1] = true
				Indicator.Dragging[2] = UDim2.new(0, Location.X - Outline.AbsolutePosition.X, 0, Location.Y - Outline.AbsolutePosition.Y)
			end)
			Library:Connection(game:GetService("UserInputService").InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 and Indicator.Dragging[1] then
					local Location = game:GetService("UserInputService"):GetMouseLocation()
					Indicator.Dragging[1] = false
					Indicator.Dragging[2] = UDim2.new(0, 0, 0, 0)
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputChanged, function(Input)
				local Location = game:GetService("UserInputService"):GetMouseLocation()
				local ActualLocation = nil

				if Indicator.Dragging[1] then
					Outline.Position = UDim2.new(
						0,
						Location.X - Indicator.Dragging[2].X.Offset + (Outline.Size.X.Offset * Outline.AnchorPoint.X),
						0,
						Location.Y - Indicator.Dragging[2].Y.Offset + (Outline.Size.Y.Offset * Outline.AnchorPoint.Y)
					)
				end
			end)

			
			function Indicator:NewValue(Properties)
				local NewIndicator = {
					Name = Properties.Name or Properties.name or "New Value";
					Value = Properties.Value or Properties.value or "false";
				};
				
				local NewInd = Instance.new("Frame")
				NewInd.Name = "NewInd"
				NewInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NewInd.BackgroundTransparency = 1
				NewInd.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewInd.BorderSizePixel = 0
				NewInd.Size = UDim2.new(1, 0, 0, 15)

				local Title = Instance.new("TextLabel")
				Title.Name = "Title"
				Title.Font = Enum.Font.GothamBold
				Title.Text = NewIndicator.Name
				Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title.TextSize = 12
				Title.TextStrokeTransparency = 0
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0, 4, 0, 0)
				Title.Size = UDim2.new(1, 0, 1, 0)
				Title.Parent = NewInd

				local IndValue = Instance.new("TextLabel")
				IndValue.Name = "IndValue"
				IndValue.Font = Enum.Font.GothamBold
				IndValue.Text = NewIndicator.Value
				IndValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				IndValue.TextSize = 12
				IndValue.TextStrokeTransparency = 0
				IndValue.TextXAlignment = Enum.TextXAlignment.Right
				IndValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				IndValue.BackgroundTransparency = 1
				IndValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				IndValue.BorderSizePixel = 0
				IndValue.Position = UDim2.new(0, -4, 0, 0)
				IndValue.Size = UDim2.new(1, 0, 1, 0)
				IndValue.Parent = NewInd

				NewInd.Parent = HolderInline

				
				function NewIndicator:UpdateValue(NewValue)
					IndValue.Text = tostring(NewValue)
				end

				return NewIndicator
			end
			
			function Indicator:NewBar(Properties)
				local NewBarInd = {
					Name = Properties.Name or Properties.name or "New Value";
					Min = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0);
					Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 100);
					State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or 0);
				};
				local TextValue = ("[value]")
				
				local NewBar = Instance.new("Frame")
				NewBar.Name = "NewBar"
				NewBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NewBar.BackgroundTransparency = 1
				NewBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewBar.BorderSizePixel = 0
				NewBar.Size = UDim2.new(1, 0, 0, 25)

				local Title1 = Instance.new("TextLabel")
				Title1.Name = "Title"
				Title1.Font = Enum.Font.GothamBold
				Title1.Text = NewBarInd.Name
				Title1.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title1.TextSize = 12
				Title1.TextStrokeTransparency = 0
				Title1.TextXAlignment = Enum.TextXAlignment.Left
				Title1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title1.BackgroundTransparency = 1
				Title1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title1.BorderSizePixel = 0
				Title1.Position = UDim2.new(0, 4, 0, 0)
				Title1.Size = UDim2.new(1, 0, 0, 15)
				Title1.Parent = NewBar

				local IndValue1 = Instance.new("TextLabel")
				IndValue1.Name = "IndValue"
				IndValue1.Font = Enum.Font.GothamBold
				IndValue1.Text = "0"
				IndValue1.TextColor3 = Color3.fromRGB(255, 255, 255)
				IndValue1.TextSize = 12
				IndValue1.TextStrokeTransparency = 0
				IndValue1.TextXAlignment = Enum.TextXAlignment.Right
				IndValue1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				IndValue1.BackgroundTransparency = 1
				IndValue1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				IndValue1.BorderSizePixel = 0
				IndValue1.Position = UDim2.new(0, -4, 0, 0)
				IndValue1.Size = UDim2.new(1, 0, 0, 15)
				IndValue1.Parent = NewBar

				local BarOutline = Instance.new("Frame")
				BarOutline.Name = "BarOutline"
				BarOutline.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				BarOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BarOutline.Position = UDim2.new(0, 4, 1, -6)
				BarOutline.Size = UDim2.new(1, -8, 0, 6)

				local Bar = Library:NewInstance("Frame", true)
				Bar.Name = "Bar"
				Bar.BackgroundColor3 = Library.Accent
				Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Bar.BorderSizePixel = 0
				Bar.Size = UDim2.new(0.5, 0, 1, 0)
				Bar.Parent = BarOutline

				BarOutline.Parent = NewBar

				NewBar.Parent = HolderInline

				
				function NewBarInd:UpdateValue(NewValue)
					NewValue = math.clamp(Library:Round(NewValue, 1), NewBarInd.Min, NewBarInd.Max)
					local sizeX = ((NewValue - NewBarInd.Min) / (NewBarInd.Max - NewBarInd.Min))
					Bar.Size = UDim2.new(sizeX, 0, 1, 0)
					IndValue1.Text = TextValue:gsub("%[value%]", string.format("%.14g", NewValue))
				end

				NewBarInd:UpdateValue(NewBarInd.State)

				return NewBarInd
			end
			
			function Indicator:SetVisible(State)
				Outline.Visible = State
			end

			return Indicator
		end
	end
end;

local Notifications = {Notifs = {}};
do 
    local NotificationGui = Instance.new("ScreenGui", Path)
    NotificationGui.Name = "ScreenGui"
    NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    -- 
	function Notifications:updateNotifsPositions(position)
		for i, v in pairs(Notifications.Notifs) do 
			local Position = Vector2.new(20, 20)
			game:GetService("TweenService"):Create(v.Container, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0,Position.X,0,Position.Y + (i * 25))}):Play()
		end 
	end

	function Notifications:Notification(message, duration, color, flash)
		local notification = {Container = nil, Objects = {}}
		--
		local Position = Vector2.new(20, 20)
		--
		local NewInd = Instance.new("Frame")
		NewInd.Name = "NewInd"
		NewInd.AutomaticSize = Enum.AutomaticSize.X
		NewInd.Position = UDim2.new(0,20,0,20)
		NewInd.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		NewInd.BackgroundTransparency = 1
		NewInd.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NewInd.Size = UDim2.fromOffset(0, 20)
		NewInd.Parent = NotificationGui
		notification.Container = NewInd

		local ActualInd = Instance.new("Frame")
		ActualInd.Name = "ActualInd"
		ActualInd.AutomaticSize = Enum.AutomaticSize.X
		ActualInd.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		ActualInd.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ActualInd.Size = UDim2.fromScale(1, 1)
		ActualInd.BackgroundTransparency = 1

		local Accent = Instance.new("Frame")
		Accent.Name = "Accent"
		Accent.BackgroundColor3 = color or Color3.fromRGB(255,255,255)
		Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Accent.Size = UDim2.new(0, 2, 1, 0)
		Accent.ZIndex = 2
		Accent.BackgroundTransparency = 1

		local UIGradient = Instance.new("UIGradient")
		UIGradient.Name = "UIGradient"
		UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 55)),
		})
		UIGradient.Parent = Accent

		Accent.Parent = ActualInd

		local IndInline = Instance.new("Frame")
		IndInline.Name = "IndInline"
		IndInline.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		IndInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
		IndInline.BorderSizePixel = 0
		IndInline.Position = UDim2.fromOffset(1, 1)
		IndInline.Size = UDim2.new(1, -2, 1, -2)
		IndInline.BackgroundTransparency = 1

		local UIGradient1 = Instance.new("UIGradient")
		UIGradient1.Name = "UIGradient"
		UIGradient1.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 170)),
		})
		UIGradient1.Rotation = 90
		UIGradient1.Parent = IndInline

		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "TextLabel"
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.Text = message
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 13
		TextLabel.TextStrokeTransparency = 0
		TextLabel.AutomaticSize = Enum.AutomaticSize.X
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.fromOffset(6, 0)
		TextLabel.Size = UDim2.fromScale(0, 1)
		TextLabel.Parent = IndInline
		TextLabel.TextTransparency = 1

		local UIPadding = Instance.new("UIPadding")
		UIPadding.Name = "UIPadding"
		UIPadding.PaddingRight = UDim.new(0, 6)
		UIPadding.Parent = IndInline

		IndInline.Parent = ActualInd

		ActualInd.Parent = NewInd


		function notification:remove()
			table.remove(Notifications.Notifs, table.find(Notifications.Notifs, notification))
			Notifications:updateNotifsPositions(Position)
			task.wait(0.5)
			NewInd:Destroy()
		end

		function notification:updatetext(new)
			TextLabel.Text = new
		end

		task.spawn(function()
			ActualInd.AnchorPoint = Vector2.new(1,0)
			for i,v in next, NewInd:GetDescendants() do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				elseif v:IsA("UIStroke") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 0.8}):Play()
				end
			end
			local Tween1 = game:GetService("TweenService"):Create(ActualInd, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(0,0)}):Play()
			game:GetService("TweenService"):Create(TextLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			task.wait(duration)
			for i,v in next, NewInd:GetDescendants() do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				elseif v:IsA("UIStroke") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 1}):Play()
				end
			end
			game:GetService("TweenService"):Create(TextLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
		end)

		task.delay(duration + 0.1, function()
			notification:remove()
		end)

		-- Flashing
		if flash then
			local time = 0 -- Start at 0 seconds
			task.spawn(function()
				while task.wait() do
					local progress = (math.sin(2 * math.pi * 2 * time) + 1) / 2;
					local value = color:Lerp(Color3.fromRGB(0, 0, 0), progress)

					Accent.BackgroundColor3 = value

					time = time + 0.01;
				end
			end)
		end

		table.insert(Notifications.Notifs, notification)
		Notifications:updateNotifsPositions(Position)
		NewInd.Position = UDim2.new(0,Position.X,0,Position.Y + (table.find(Notifications.Notifs, notification) * 25))
		return notification
	end
end

local Window = Library:Window({})

do 
	local Pages = {
		["Aiming"] = Window:Page({Name = "Aiming", Icon = "rbxassetid://6034509987"});
		["Rage"] = Window:Page({Name = "Anti Aim", Icon = "rbxassetid://17134553802"});
		["Renders"] = Window:Page({Name = "Renders", Icon = "rbxassetid://6031079158"});
		["World"] = Window:Page({Name = "World", Icon = "rbxassetid://6026568213"});
		["Misc"] = Window:Page({Name = "Misc", Icon = "rbxassetid://6031280883"});
		["Players"] = Window:Page({Name = "Playerlist", Icon = "rbxassetid://6034281935"});
		["LocalPlayer"] = Window:Page({Name = "LocalPlayer", Icon = "rbxassetid://6034281935"});
		["Settings"] = Window:Page({Name = "Settings", Icon = "rbxassetid://6031280882"});
	} 
	 
	do -- Aiming
		do
			do 
				local Enabled = Pages["Aiming"]:Section({Name = "Main", Side = "Left", Zindex = 3}); 
				Enabled:Toggle({Name = "Enabled", Flag = "Main Enabled"})
				Enabled:Keybind({Name = "Keybind", Flag = "Silent Bind", Default = Enum.KeyCode.End, Callback = function(Bool)
				end})
			end 

			do -- Silent Aim Multi Section
				local TextBox, Single_HitPart, Multi_HitParts, Jump_Prediction, Air_Part, Delay, Type; 
				
				do -- Silent Aim
					local Silent_Aim, Advanced = Pages["Aiming"]:MultiSection({Sections = {"Main", "Advanced"}, Side = "Left", Zindex = 3})
					do -- Main
						Silent_Aim:Toggle({Name = "Silent Aim", Flag = "Silent Aim"})
						Silent_Aim:Toggle({Name = "Auto Select Target", Flag = "Auto Select Target", Callback = function(Bool) if (Delay and Type) then Type:SetVisible(Bool) Delay:SetVisible(Bool) end end})
						Type = Silent_Aim:List({Name = "Mode", Options = {"Mouse", "Distance"}, Default = "Closest To Cursor Position"}); Type:SetVisible(false)
						Delay = Silent_Aim:Slider({Name = "Delay", Suffix = "ms", Flag = "Auto Select Delay", Min = 0, Max = 1000, Default = 100}); Delay:SetVisible(false)
						Silent_Aim:List({Name = "Prediction Type", Flag = "Prediction Type Silent Aim", Options = {"Auto", "Manual"}, Default = "Manual", Callback = function(Option) if not TextBox then return end; if (Option == "Auto" and TextBox) then TextBox:SetVisible(false) else TextBox:SetVisible(true) end end})
						TextBox = Silent_Aim:Textbox({Name = "Prediction", Flag = "Manual Prediction"})
						Silent_Aim:Toggle({Name = "Use Closest Part", Flag = "Nearest Part", Callback = function(Bool) if (Multi_HitParts and Single_HitPart) then Multi_HitParts:SetVisible(Bool) Single_HitPart:SetVisible(not Bool) end  end})
						Single_HitPart = Silent_Aim:List({Name = "Hit Box Selection", Flag = "Single Hit Part", Options = {"123"}, Default = "HumanoidRootPart"})
						Silent_Aim:Toggle({Name = "Prefer body aim if lethal", Flag = "Silent Aim"})
						Multi_HitParts = Silent_Aim:List({Name = "Hit Box Selection", Flag = "Closest Hit Part",Options = {"123"}, Default = {"HumanoidRootPart"}, Max = 9e9})
						Multi_HitParts:SetVisible(false)
					end 
					 
					do -- Advanced
						Advanced:Toggle({Name = "Look At", Flag = "Look At"})
						Advanced:Toggle({Name = "Auto Fire", Flag = "Auto Fire"})
						Advanced:Toggle({Name = "Spectate", Flag = "Spectate"})
						Advanced:Toggle({Name = "Notify", Flag = "Notify"})
						Advanced:Toggle({Name = "Aim-Viewer Bypass", Flag = "Aim-Viewer Bypass"})
						Advanced:Toggle({Name = "Jump Offset", Flag = "Jump Prediction", Callback = function(Bool)
							if (Jump_Prediction) then 
								Jump_Prediction:SetVisible(Bool)
							end 
						end})
						Jump_Prediction = Advanced:Textbox({Name = "Jump Prediction", Flag = "Manual Offset Value", Placeholder = "Jump Offset"})
						Jump_Prediction:SetVisible(false)
						Advanced:Toggle({Name = "Air Part", Flag = "Air Part", Callback = function(Bool)
							if (Air_Part) then 
								Air_Part:SetVisible(Bool)
							end 
						end})
						
						Air_Part = Advanced:List({Name = "Air Hit-Part", Flag = "Air Hit Part", Options = {"123"}, Default = "RightFoot"})
						Air_Part:SetVisible(false)
					end 
				end 
			end 
		end 
		
		do 
			local TextBox, Single_HitPart, Multi_HitParts, Jump_Prediction, Air_Part, Delay, Mouse_1, Mouse_2, Camera; 
			do
				local Aim_Assist, Advanced = Pages["Aiming"]:MultiSection({Sections = {"Aim Assist", "Advanced"}, Side = "Right"})
				-- Aim Assist
				do 
					Aim_Assist:Toggle({Name = "Enabled", Flag = "Aim Assist Enabled"}) 
					Aim_Assist:List({Name = "Prediction Type", Flag = "Prediction Type", Options = {"Auto", "Manual"}, Default = "Manual", Callback = function(Option) if not TextBox then return end; if (Option == "Auto" and TextBox) then TextBox:SetVisible(false) else TextBox:SetVisible(true) end  end})
					Aim_Assist:Textbox({Name = "Prediction", Flag = "Manual Prediction Aim Assist"})
					Aim_Assist:Toggle({Name = "Use Closest Part", Flag = "Nearest Part Aim Assist", Callback = function(Bool) if (Multi_HitParts and Single_HitPart) then Multi_HitParts:SetVisible(Bool) Single_HitPart:SetVisible(not Bool) end end})
					Single_HitPart = Aim_Assist:List({Name = "Hit-Part", Flag = "Aim Assist Single Hit Part", Options = {"123"}, Default = "HumanoidRootPart"})
					Multi_HitParts = Aim_Assist:List({Name = "Closest Hit Part", Flag = "Aim Assist Closest Hit Part", Options = {"123"}, Default = {"HumanoidRootPart"}, Max = 9e9}); Multi_HitParts:SetVisible(false)
					Aim_Assist:Slider({Name = "Stutter", Suffix = "ms", Min = 0, Max = 100, Default = 0, Flag = "Aim Assist Stutter"})
				end 

				do -- Advanced
					Advanced:Toggle({Name = "Use Mouse", Flag = "Use Mouse", Callback = function(Bool) if (Mouse_1 and Mouse_2 and Camera) then Mouse_1:SetVisible(Bool) Mouse_2:SetVisible(Bool) Camera:SetVisible(not Bool) end end}) 
					Mouse_1 = Advanced:Slider({Name = "Horizontal Smoothing", Suffix = "%", Min = 1, Max = 100, Default = 1, Flag = "Horizontal Smoothing"}); Mouse_1:SetVisible(false)
					Mouse_2 = Advanced:Slider({Name = "Vertical Smoothing", Suffix = "%", Min = 1, Max = 100, Default = 1, Flag = "Vertical Smoothing"}); Mouse_2:SetVisible(false)
					Camera = Advanced:Slider({Name = "Smoothing", Suffix = "%", Min = 1, Max = 100, Default = 1, Flag = "Smoothing"})
					Advanced:Toggle({Name = "Jump Offset", Flag = "Jump Offset Aim Assist", Callback = function(Bool) if (Jump_Prediction) then Jump_Prediction:SetVisible(Bool) end end})
					Jump_Prediction = Advanced:Textbox({Name = "Offset Value", Flag = "Manual Offset Value Aim Assist", Placeholder = "Jump Offset"}); Jump_Prediction:SetVisible(false)
					Advanced:Toggle({Name = "Air Part", Flag = "Air Part Aim Assist", Callback = function(Bool) if (Air_Part) then Air_Part:SetVisible(Bool) end end})
					Air_Part = Advanced:List({Name = "Air Hit-Part", Flag = "Air Hit Part", Options = {"123"}, Default = "RightFoot"}) Air_Part:SetVisible(false)
				end 
			end 	
			 
			do -- Resolver
				local Resolver = Pages["Aiming"]:Section({Name = "Resolver", Zindex = 9999, Side = "Right"}) 	
				Resolver:Toggle({Name = "Resolver", Flag = "Resolver"})
			end 
			 
			do -- Checks
				local Checks = Pages["Aiming"]:Section({Name = "Checks", Side = "Right"}) 	
				Checks:List({Name = "Checks", Flag = "Checks", Options = {"Knocked", "Wall", "Friend", "Grabbed", "ForceField"}, Max = 3})
			end 		
		end 
	end 	
	 
	do -- Rage 
		local Deysnc, Desync_Settings, Desync_Visualize = Pages["Rage"]:MultiSection({Sections = {"Spoofer", "Settings", "Visualize"}, Zindex = 5}) do  

			do -- Visualize
				local Textures, Reflectance; 
				Desync_Visualize:Toggle({Name = "Visualize", Flag = "Desync Visualize"}):Colorpicker({Default = Color3.fromHex("#ffffff"), Flag = "Desync Cham Part Color", Alpha = 0});
				local VisualizeHighlight = Desync_Visualize:Toggle({Name = "Highlight", Flag = "Desync Cham Highlight", Default = true})
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#7D0DC3"), Flag = "Desync Cham Fill Color", Alpha = 0.5});
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#000000"), Flag = "Desync Cham Outline Color", Alpha = 0});
				Desync_Visualize:List({Name = "Material", Flag = "Desync Cham Material", Options = {"ForceField", "Neon", "Plastic"}, Default = "ForceField", Callback = function(Option)
					if (Textures and Reflectance) then 
						Textures:SetVisible(Option == "ForceField" and true or false)
						Reflectance:SetVisible(Option == "Plastic" and true or false)
					end 
				end});	
				Reflectance = Desync_Visualize:Slider({Name = "Reflectance", Flag = 'Desync Cham Reflectance', Min = 0, Max = 1, Default = 0, Decimals = 0.01, Suffix = ""}) Reflectance:SetVisible(false)
				Textures = Desync_Visualize:List({Name = "Texture", Flag = "Desync Cham Material Texture", Options = {"Web", "Swirl", "Checkers", "CandyCane", "Dots", "Scanning", "Bubbles", "Player FF Texture", "Shield Forcefield", "Water", "None"}, Default = "Swirl"})
			end 
		end 

		local Exploits, AntiLock = Pages["Rage"]:MultiSection({Sections = {"Exploits", "Anti Lock"}, Zindex = 5, Side = "Right"}) do 
			do -- Exploits
				Exploits:Toggle({Name = "Physics Desync", Flag = "Fast Flags"})
				Exploits:Slider({Name = "Amount", Flag = 'Fast Flags Amount', Min = 1, Max = 15, Default = 2, Decimals = 1})
				Exploits:Toggle({Name = "Network Desync", Flag = "Network Desync"})
				Exploits:Slider({Name = "Delay", Flag = 'Network Delay', Suffix = "s", Min = 0.01, Max = 15, Default = 2, Decimals = 0.01})
				Exploits:Toggle({Name = "Destroy Cheaters", Flag = "Destroy Cheaters"}):Keybind({Name = "Destroy Cheaters Key", Flag = "Destroy Cheaters Key", Mode = "Toggle", Callback = function()
				end})
				Exploits:List({Name = "Mode", Flag = "Destroy Cheaters Mode", Options = {"Basic", "Bypass", "Kill"}, Default = "Basic"})
				Exploits:Toggle({Name = "Safe Mode", Flag = "Network Desync"})
			end 

			do -- Anti Lock
				AntiLock:Toggle({Name = "Enabled", Flag = "Anti Lock", Callback = function(Bool)
				end}):Keybind({Name = "Anti Lock", Flag = "Anti Lock Key", Mode = "Toggle", Callback = function(Bool)
				end})
				AntiLock:List({Name = "Type", Flag = "Anti Lock Type", Options = {"Random", "HvH", "Sky", "Velocity Cap"}, Default = "HvH"})
				AntiLock:Slider({Name = "Random Range", Flag = 'Anti Lock Random Range', Min = 0, Max = 100, Default = 0, Decimals = 1, Suffix = "st"})
			end 
		end 
	end 
	 
	do -- Visuals
		do
			local EspSettings, Crosshair, FieldOfView = Pages["Renders"]:MultiSection({Sections = {"Esp", "Crosshair", "Fov"}, Zindex = 5, Side = "Left"}) 
			do 
				
			end 	
			-- 
			do 
				
			end		
			-- 
			do 
			end 
		end 

		do
			local Hit_Effects, Target = Pages["Renders"]:MultiSection({Sections = {"Hit Effects", "Target Visuals"}, Zindex = 5, Side = "Right"}) 
			do 
				local HitCham; 
				local Reflectance;  
				local Textures; 
				Hit_Effects:List({Name = "Hit Marker", Flag = "Hit Marker", Options = {"3D", "2D", "Damage"}, Max = 9e9})
				Hit_Effects:Colorpicker({Nmae = "3D", Default = Color3.fromRGB(255, 0, 0), Transparency = 1, Flag = "3D Color"});
				Hit_Effects:Colorpicker({Nmae = "2D", Default = Color3.fromRGB(255, 0, 0), Transparency = 1, Flag = "2D Color"});
				Hit_Effects:Colorpicker({Nmae = "Damage", Default = Color3.fromRGB(255, 0, 0), Transparency = 1, Flag = "Damage Color"});
				Hit_Effects:Toggle({Name = "Hit Effects", Flag = "Hit Effects"}):Colorpicker({Default = Color3.fromRGB(255,255,255), Flag = "Hit Effect Settings"});
				Hit_Effects:List({Name = "Hit Effects", Flag = "Hit Effect", Options = {--[["Confetti"]] "Nova", "Sparkle", "Splash", "Slash", "Detailed Slash", "Electric", "Electric 2"}, Default = "Confetti"})
				Hit_Effects:Toggle({Name = "Hit Chams", Flag = "Hit Chams"}):Colorpicker({Default = Color3.fromRGB(255, 0, 0), Transparency = 0.8, Flag = "Hit Chams Settings"});
				local VisualizeHighlight = Hit_Effects:Toggle({Name = "Highlight", Flag = "Hit Cham Highlight", Default = true})
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#7D0DC3"), Flag = "Hit Cham Fill Color", Alpha = 0.5});
				VisualizeHighlight:Colorpicker({Default = Color3.fromHex("#000000"), Flag = "Hit Cham Outline Color", Alpha = 0});
				Hit_Effects:List({Name = "Material", Flag = "Hit Cham Material", Options = {"ForceField", "Neon", "Plastic"}, Default = "ForceField", Callback = function(Option)
					if (Textures and Reflectance) then 
						Textures:SetVisible(Option == "ForceField" and true or false)
						Reflectance:SetVisible(Option == "Plastic" and true or false)
					end 
				end});	
				Reflectance = Hit_Effects:Slider({Name = "Reflectance", Flag = 'Hit Cham Reflectance', Min = 0, Max = 1, Default = 0, Decimals = 0.01, Suffix = ""}) Reflectance:SetVisible(false)
				Textures = Hit_Effects:List({Name = "Texture", Flag = "Hit Cham Material Texture", Options = {"Web", "Swirl", "Checkers", "CandyCane", "Dots", "Scanning", "Bubbles", "Player FF Texture", "Shield Forcefield", "Water", "None"}, Default = "Swirl"})					
				Hit_Effects:Toggle({Name = "Hit-Logs", Flag = "Hit Notify"})
				Hit_Effects:Toggle({Name = "Fading", Flag = "Fading"});
				Hit_Effects:Slider({Name = "Fading Time", Flag = 'Fading Time', Min = 0.1, Max = 10.0, Default = 5.0, Decimals = 0.1});
			end 
			-- 
			do 
				local Line = Target:Toggle({Name = "Line", Flag = "Line Enabled"}); Line:Colorpicker({Default = Color3.fromRGB(255,0,0), Flag = "Line Inline Color"}); Line:Colorpicker({Default = Color3.fromRGB(255,0,0), Flag = "Line Outline Color"});
				Target:Slider({Name = "Thickness", Flag = 'Line Thickness', Min = 0, Max = 3, Default = 1, Decimals = 0.01});
				local Highlight = Target:Toggle({Name = "Highlight", Flag = "Highlight Enabled"}); Highlight:Colorpicker({Default = Color3.fromRGB(0,255,0), Alpha = 0.5, Flag = "Highlight Fill Color"}); Highlight:Colorpicker({Default = Color3.fromRGB(0,125,0), Flag = "Highlight Outline Color"});
				local BackTrack = Target:Toggle({Name = "Backtrack", Flag = "Back Track Enabled"}); BackTrack:Colorpicker({Default = Color3.fromRGB(255, 0, 0), alpha = 0.65, Flag = "Back Track Settings"}); 	
				Target:List({Name = "Method", Flag = "Back Track Method", Options = {"Clone", "Follow"}, Default = "Follow"}); 	
				Target:List({Name = "Material", Flag = "Back Track Material", Options = {"Neon", "Plastic", "ForceField"}, Default = "Neon"}); 	
				Target:Toggle({Name = "3D Box", Flag = "3D Box"}):Colorpicker({Default = Color3.fromRGB(255,0,0), Flag = "3D Box Color", Callback = function()  end});	
			end 
		end 
	end 
	 
	do -- World
		do
			local Gun = Pages["World"]:Section({Name = "Gun", Size = 330, Side = "Left"}) do 	
				local TracersColor; 
				Gun:Toggle({Name = "Gun Chams", Flag = "Gun Chams"}):Colorpicker({Default = Color3.fromRGB(255,255,255), Flag = "Gun Cham Color"});
				Gun:Toggle({Name = "Gun Spin", Flag = "Gun Spin"})
				Gun:Slider({Name = "Rate", Flag = 'Tracers Life Time', Min = 0, Max = 10, Default = 1, Decimals = 0.1})
				Gun:Toggle({Name = "Tracers", Flag = "Tracers"}):Colorpicker({Default = Color3.fromRGB(255,255,255), Flag = "Tracers Color"}); 
				Gun:List({Name = "Type", Flag = "Tracers Type", Options = {"Static", "Party"}, Default = "Static"})
				Gun:List({Name = "Texture", Flag = "Tracers Texture", Options = {"Double Helix", "Electric", "Electric + Glow", "Fade", "Glow", "Pulsate", "Red Lazer", "Smoke", "Thin Electric", "Vibrate", "Warp", "scotland dildo"}, Default = "Electric"})
				Gun:Slider({Name = "Curve Start", Flag = 'Curve Size 0', Min = 0, Max = 10, Default = 0, Decimals = 0.1})
				Gun:Slider({Name = "Curve End", Flag = 'Curve Size 1', Min = 0, Max = 10, Default = 0, Decimals = 0.1})
				Gun:Slider({Name = "Life Time", Flag = 'Tracers Life Time', Min = 0, Max = 10, Default = 5, Decimals = 0.1})
				Gun:Slider({Name = "Brightness", Flag = 'Tracers Brightness', Min = 0, Max = 1, Default = 0.99, Decimals = 0.01})
			end	
		end 

		do
			local World = Pages["World"]:Section({Name = "Environment", Size = 330, Side = "Right"}) do 	

			end 
			 
			local Correction = Pages["World"]:Section({Name = "Color Correction Effect", Size = 330, Side = "Right"}) do 	

            end 
		end 
	end 
	 
	do -- Misc
		do
			local Movement = Pages["Misc"]:Section({Name = "Movement", Size = 330, Side = "Left", Zindex = 1000}) do
				Movement:Toggle({Name = "Speed", Flag = "Speed Enabled"}):Keybind({Name = "Speed", Flag = "Speed Key", Mode = "Toggle"})
				Movement:Toggle({Name = "Auto-Jump", Flag = "Auto Jump"})
				Movement:Slider({Name = "Speed", Flag = 'Speed', Min = 0, Max = 100, Default = 20, Decimals = 1})
				Movement:Toggle({Name = "Fly", Flag = "Fly Enabled"}):Keybind({Name = "Fly", Flag = "Fly Key", Mode = "Toggle"})
				Movement:Slider({Name = "Fly", Flag = 'Fly Speed', Min = 0, Max = 100, Default = 20, Decimals = 1})
			end 
			 
			local Camera = Pages["Misc"]:Section({Name = "Camera", Size = 330, Side = "Left", Zindex = 13}) do
				local oldFieldOfView, Amount = workspace.CurrentCamera.FieldOfView, nil;
				Camera:Toggle({Name = "Zoom", Flag = "Zoom", Callback = function(Bool) 
					if (Amount) then 
						Amount:SetVisible(Bool)
					end 
				end}):Keybind({Name = "Zoom", Flag = "Optifine Key", Mode = "Hold", UseKey = true, Callback = function()

				end})
				Amount = Camera:Slider({Name = "Zoom", Flag = 'Zoom Amount', Min = 0, Max = 100, Default = 5, Decimals = 1})
				Camera:Toggle({Name = "Aspect Ratio", Flag = "Aspect Ratio"})
				Camera:Slider({Name = "Vertical", Flag = 'Vertical', Min = 0, Max = 100, Default = 20, Decimals = 1})
				Camera:Slider({Name = "Horizontal", Flag = 'Horizontal', Min = 0, Max = 100, Default = 20, Decimals = 1})
				Camera:Toggle({Name = "Motion Blur", Flag = "Motion Blur"})
				Camera:Slider({Name = "Intensity", Flag = 'Intensity', Min = 0, Max = 100, Default = 15, Decimals = 1})
			end 			
		end 
		
		do
			local Hit_Sounds = Pages["Misc"]:Section({Name = "Hit Sounds", Size = 330, Side = "Right"}) do
				Hit_Sounds:Toggle({Name = "Hit Sounds", Flag = "Hit Sounds"})
				Hit_Sounds:List({Name = "Hit Sounds", Flag = "Hit Sounds Sound", Options = sfx_names, Default = "Neverlose"})
				Hit_Sounds:Slider({Name = "Volume", Flag = 'Hit Sounds Volume', Min = 0.1, Max = 10.0, Default = 5.0, Decimals = 0.1})
				Hit_Sounds:Slider({Name = "Pitch", Flag = 'Hit Sounds Pitch', Min = 0.1, Max = 10.0, Default = 1.0, Decimals = 0.1})
				 
				Hit_Sounds:Toggle({Name = "Shoot Sounds", Flag = "Shoot Sounds"})
				Hit_Sounds:List({Name = "Shoot Sounds", Flag = "Shoot Sounds Sound", Options = Sounds, Default = "Neverlose"})
				Hit_Sounds:Slider({Name = "Volume", Flag = 'Shoot Sounds Volume', Min = 0.1, Max = 10.0, Default = 5.0, Decimals = 0.1})
				Hit_Sounds:Slider({Name = "Pitch", Flag = 'Shoot Sounds Pitch', Min = 0.1, Max = 10.0, Default = 1.0, Decimals = 0.1})
			end
			 
			local IndicatorSettings = Pages["Misc"]:Section({Name = "Indicators", Size = 330, Side = "Right", Zindex = 12}) do
				IndicatorSettings:Toggle({Name = "Target Indicators", Flag = "Target Indicators"})
				IndicatorSettings:Toggle({Name = "Watermark", Flag = "Watermark"})
			end 
		end 
	end 
	 
	do -- Settings
		local Config = Pages["Settings"]:Section({Name = "Config"})
		local ConfigList = Config:List({Name = "Config", Flag = "SettingConfigurationList", Options = {}})
		Config:Textbox({Flag = "SettingsConfigurationName", Name = "Config Name"})
		Config:Button({Name = "Save"})
		Config:Button({Name = "Load"})
		Config:Button({Name = "Delete"})
		Config:Button({Name = "Refresh"})
		Config:Keybind({Name = "Menu Key", Flag = "MenuKey", Ignore = true, UseKey = true, Default = Enum.KeyCode.End, Callback = function(State) Library.UIKey = State end})
		Config:Colorpicker({Name = "Menu Accent", Flag = "MenuAccent", Default = Library.Accent, Callback = function(State) Library:ChangeAccent(State) end})
		Config:Toggle({Name = "Keybind List", Callback = function(state) Library.KeyList:SetVisible(state) end}) 
	end
end 

Notifications:Notification("Loaded cheat in approxiametely: " .. math.floor(tick() - Tick) .. " seconds", 5, Library.Accent, false)
