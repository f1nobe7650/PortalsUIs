-- // Coded by _notportal
-- Example at bottom
if not isfile("ProggyClean.ttf") then
	writefile("ProggyClean.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/ProggyClean.ttf"))
end
if isfile("UI_FONT.font") then
	delfile("UI_FONT.font")
end
--
local Library = {};
do
	Library = {
		Open = true;
		Accent = Color3.fromRGB(85, 170, 255);
		PageAmount = 0;
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
		FSize = 12;
		UIFont = nil;
		SettingsPage = nil;
		VisValues = {};
		Cooldown = false;
		Friends = {};
		Priorities = {};
		KeyList = nil;
		Notifs = {};
	}

	-- // Ignores
	local Flags = {}; -- Ignore

	-- // Extension
	Library.__index = Library
	Library.Pages.__index = Library.Pages
	Library.Sections.__index = Library.Sections
	local LocalPlayer = game:GetService('Players').LocalPlayer;
	local Mouse = LocalPlayer:GetMouse();
	local TweenService = game:GetService("TweenService");

	-- // Custom Font
	do
		getsynasset = getcustomasset or getsynasset
		Font = setreadonly(Font, false);
		function Font:Register(Name, Weight, Style, Asset)
			if not isfile(Name .. ".font") then
				if not isfile(Asset.Id) then
					writefile(Asset.Id, Asset.Font);
				end;
				--
				local Data = {
					name = Name,
					faces = {{
						name = "Regular",
						weight = Weight,
						style = Style,
						assetId = getsynasset(Asset.Id);
					}}
				};
				--
				writefile(Name .. ".font", game:GetService("HttpService"):JSONEncode(Data));
				return getsynasset(Name .. ".font");
			else 
				warn("Font already registered");
			end;
		end;
		--
		function Font:GetRegistry(Name)
			if isfile(Name .. ".font") then
				return getsynasset(Name .. ".font");
			end;
		end;

		Font:Register("UI_FONT", 400, "normal", {Id = "ProggyClean.ttf", Font = ""});
	end

	-- // Misc Functions
	do
		function Library:Connection(Signal, Callback)
			local Con = Signal:Connect(Callback)
			return Con
		end
		--
		function Library:Disconnect(Connection)
			Connection:Disconnect()
		end
		--
		function Library:Round(Number, Float)
			return Float * math.floor(Number / Float)
		end
		--
		function Library.NextFlag()
			Library.UnNamedFlags = Library.UnNamedFlags + 1
			return string.format("%.14g", Library.UnNamedFlags)
		end
		--
		function Library:RGBA(r, g, b, alpha)
			local rgb = Color3.fromRGB(r, g, b)
			local mt = table.clone(getrawmetatable(rgb))

			setreadonly(mt, false)
			local old = mt.__index

			mt.__index = newcclosure(function(self, key)
				if key:lower() == "transparency" then
					return alpha
				end

				return old(self, key)
			end)

			setrawmetatable(rgb, mt)

			return rgb
		end
		--
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
					--
					if typeof(Value2) == "Color3" then
						local hue, sat, val = Value2:ToHSV()
						--
						Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, 1)
					elseif typeof(Value2) == "table" and Value2.Color and Value2.Transparency then
						local hue, sat, val = Value2.Color:ToHSV()
						--
						Final = ("rgb(%s,%s,%s,%s)"):format(hue, sat, val, Value2.Transparency)
					elseif typeof(Value2) == "table" and Value.Mode then
						local Values = Value.current
						--
						Final = ("key(%s,%s,%s)"):format(Values[1] or "nil", Values[2] or "nil", Value.Mode)
					elseif Value2 ~= nil then
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
					Config = Config .. Index .. ": " .. tostring(Final) .. "\n"
				end
			end
			--
			return Config
		end
		--
		function Library:LoadConfig(Config)
			local Table = string.split(Config, "\n")
			local Table2 = {}
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
		--
		function Library:SetOpen(bool)
			if typeof(bool) == 'boolean' then
				Library.Open = bool;
				Library.Holder.Visible = bool;
			end
		end;
		--
		function Library:IsMouseOverFrame(Frame)
			local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;

			if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X
				and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then

				return true;
			end;
		end;
		--
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
		--
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
					for Index, Page in pairs(Library.Pages) do
						Page.Elements.Button.Size = UDim2.new(0, Library.PageAmount and ((((background.Size.X.Offset - 35) - ((Library.PageAmount - 1) * 2)) / Library.PageAmount)) - 3 or 65, 1, 0);
					end
				end;
			end)
			Library:Connection(game:GetService("UserInputService").InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
		end
	end;

	-- // Colorpicker Element
	do
		function Library:NewPicker(name, default, defaultalpha, parent, count, flag, callback)
			-- // Instances
			local Icon = Instance.new("TextButton", parent)
			--
			Icon.Name = "Icon"
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.BackgroundColor3 = default
			Icon.BorderColor3 = Color3.fromRGB(50,50,50)
			Icon.BorderSizePixel = 1
			if count == 1 then
				Icon.Position = UDim2.new(1, - (count * 21),0.5,0)
			else
				Icon.Position = UDim2.new(1, - (count * 21) - (count * 4),0.5,0)
			end
			Icon.Size = UDim2.new(0, 20, 0, 8)
			Icon.Text = ""
			Icon.AutoButtonColor = false
			
			local Outline4 = Instance.new("Frame")
			Outline4.Name = "Outline"
			Outline4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline4.BackgroundTransparency = 1
			Outline4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline4.BorderSizePixel = 0
			Outline4.Position = UDim2.new(0, -1, 0, -1)
			Outline4.Size = UDim2.new(1, 2, 1, 2)
			Outline4.Parent = Icon

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Outline4

			local ColorWindow = Instance.new("Frame")
			ColorWindow.Name = "ColorWindow"
			ColorWindow.AnchorPoint = Vector2.new(0.5, 0.5)
			ColorWindow.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			ColorWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ColorWindow.Parent = Icon
			ColorWindow.Position = UDim2.new(1,0,1,2)
			ColorWindow.AnchorPoint = Vector2.new(1,0)
			ColorWindow.Size = UDim2.new(0, 170, 0, 170)
			ColorWindow.ZIndex = 2
			ColorWindow.Visible = false

			local ColorInline = Instance.new("Frame")
			ColorInline.Name = "ColorInline"
			ColorInline.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			ColorInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ColorInline.BorderSizePixel = 0
			ColorInline.Position = UDim2.new(0, 1, 0, 1)
			ColorInline.Size = UDim2.new(1, -2, 1, -2)

			local Color = Instance.new("TextButton")
			Color.Name = "Color"
			Color.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Color.Text = ""
			Color.TextColor3 = Color3.fromRGB(0, 0, 0)
			Color.TextSize = 14
			Color.AutoButtonColor = false
			Color.BackgroundColor3 = default
			Color.BorderColor3 = Color3.fromRGB(50, 50, 50)
			Color.Position = UDim2.new(0, 6, 0, 6)
			Color.Size = UDim2.new(1, -30, 1, -30)

			local Sat = Instance.new("ImageLabel")
			Sat.Name = "Sat"
			Sat.Image = "http://www.roblox.com/asset/?id=14684562507"
			Sat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Sat.BackgroundTransparency = 1
			Sat.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Sat.BorderSizePixel = 0
			Sat.Size = UDim2.new(1, 0, 1, 0)
			Sat.Parent = Color

			local Val = Instance.new("ImageLabel")
			Val.Name = "Val"
			Val.Image = "http://www.roblox.com/asset/?id=14684563800"
			Val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Val.BackgroundTransparency = 1
			Val.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Val.BorderSizePixel = 0
			Val.Size = UDim2.new(1, 0, 1, 0)
			Val.Parent = Color

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline.BackgroundTransparency = 1
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.BorderSizePixel = 0
			Outline.Position = UDim2.new(0, -1, 0, -1)
			Outline.Size = UDim2.new(1, 2, 1, 2)

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Outline

			Outline.Parent = Color

			Color.Parent = ColorInline

			local Alpha = Instance.new("ImageButton")
			Alpha.Name = "Alpha"
			Alpha.AutoButtonColor = false
			Alpha.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Alpha.BorderColor3 = Color3.fromRGB(50, 50, 50)
			Alpha.BorderSizePixel = 0
			Alpha.Position = UDim2.new(0, 6, 1, -16)
			Alpha.Size = UDim2.new(1, -30, 0, 10)

			local Outline1 = Instance.new("Frame")
			Outline1.Name = "Outline"
			Outline1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline1.BackgroundTransparency = 1
			Outline1.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline1.BorderSizePixel = 0
			Outline1.Position = UDim2.new(0, -1, 0, -1)
			Outline1.Size = UDim2.new(1, 2, 1, 2)

			local UIStroke1 = Instance.new("UIStroke")
			UIStroke1.Name = "UIStroke"
			UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke1.Parent = Outline1

			Outline1.Parent = Alpha

			local UIStroke2 = Instance.new("UIStroke")
			UIStroke2.Name = "UIStroke"
			UIStroke2.Color = Color3.fromRGB(50, 50, 50)
			UIStroke2.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke2.Parent = Alpha

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})
			UIGradient.Parent = Alpha

			Alpha.Parent = ColorInline

			local Hue = Instance.new("ImageButton")
			Hue.Name = "Hue"
			Hue.Image = "http://www.roblox.com/asset/?id=14684557999"
			Hue.AutoButtonColor = false
			Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hue.BorderColor3 = Color3.fromRGB(50, 50, 50)
			Hue.Position = UDim2.new(1, -16, 0, 6)
			Hue.Size = UDim2.new(0, 10, 1, -30)

			local Outline2 = Instance.new("Frame")
			Outline2.Name = "Outline"
			Outline2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline2.BackgroundTransparency = 1
			Outline2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline2.BorderSizePixel = 0
			Outline2.Position = UDim2.new(0, -1, 0, -1)
			Outline2.Size = UDim2.new(1, 2, 1, 2)

			local UIStroke3 = Instance.new("UIStroke")
			UIStroke3.Name = "UIStroke"
			UIStroke3.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke3.Parent = Outline2

			Outline2.Parent = Hue

			Hue.Parent = ColorInline

			ColorInline.Parent = ColorWindow

			-- // Connections
			local mouseover = false
			local hue, sat, val = default:ToHSV()
			local hsv = default:ToHSV()
			local alpha = defaultalpha
			local oldcolor = hsv
			local slidingsaturation = false
			local slidinghue = false
			local slidingalpha = false

			local function update()
				local real_pos = game:GetService("UserInputService"):GetMouseLocation()
				local mouse_position = Vector2.new(real_pos.X - 5, real_pos.Y - 30)
				local relative_palette = (mouse_position - Color.AbsolutePosition)
				local relative_hue     = (mouse_position - Hue.AbsolutePosition)
				local relative_opacity = (mouse_position - Alpha.AbsolutePosition)
				--
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
				Icon.BackgroundColor3 = hsv

				if flag then
					Library.Flags[flag] = Library:RGBA(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha)
				end

				callback(Library:RGBA(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha))
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

					if flag then
						Library.Flags[flag] = Library:RGBA(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha)
					end

					callback(Library:RGBA(hsv.r * 255, hsv.g * 255, hsv.b * 255, alpha))
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
					if not Library:IsMouseOverFrame(ColorWindow) and not Library:IsMouseOverFrame(Icon) and not Library:IsMouseOverFrame(parent) then
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

			return colorpickertypes, ColorWindow
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
	
	function Library:updateNotifsPositions(position)
		for i, v in pairs(Library.Notifs) do 
			local Position = Vector2.new(20, 20)
			game:GetService("TweenService"):Create(v.Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0,Position.X,0,Position.Y + (i * 25))}):Play()
		end 
	end

	function Library:Notification(message, duration, color)
		local notification = {Container = nil, Objects = {}}
		--
		local Position = Vector2.new(20, 20)
		--
		local NotifContainer = Instance.new('Frame', Library.ScreenGUI)
		NotifContainer.Name = "NotifContainer"
		NotifContainer.Position = UDim2.new(0,Position.X, 0, Position.Y)
		NotifContainer.AutomaticSize = Enum.AutomaticSize.X
		NotifContainer.Size = UDim2.new(0,0,0,16)
		NotifContainer.BackgroundColor3 = Color3.new(1,1,1)
		NotifContainer.BackgroundTransparency = 1
		NotifContainer.BorderSizePixel = 0
		NotifContainer.BorderColor3 = Color3.new(0,0,0)
		NotifContainer.ZIndex = 99999999
		notification.Container = NotifContainer

		local Outline = Instance.new("Frame")
		Outline.Name = "Outline"
		Outline.AutomaticSize = Enum.AutomaticSize.X
		Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Outline.Position = UDim2.new(0.01, 0, 0.02, 0)
		Outline.Size = UDim2.new(0, 0, 0, 16)
		Outline.Parent = NotifContainer
		Outline.BackgroundTransparency = 1
		table.insert(notification.Objects, Outline)

		local Inline = Instance.new("Frame")
		Inline.Name = "Inline"
		Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Inline.BorderSizePixel = 0
		Inline.Position = UDim2.new(0, 1, 0, 1)
		Inline.Size = UDim2.new(1, -2, 1, -2)
		Inline.BackgroundTransparency = 1
		table.insert(notification.Objects, Inline)

		local Value = Instance.new("TextLabel")
		Value.Name = "Value"
		Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
		Value.Text = message
		Value.TextColor3 = Color3.fromRGB(255, 255, 255)
		Value.TextSize = 12
		Value.TextStrokeTransparency = 0
		Value.TextXAlignment = Enum.TextXAlignment.Left
		Value.AutomaticSize = Enum.AutomaticSize.X
		Value.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Value.BackgroundTransparency = 1
		Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Value.BorderSizePixel = 0
		Value.Size = UDim2.new(0, 0, 1, 0)
		Value.TextTransparency = 1
		table.insert(notification.Objects, Value)

		local UIPadding = Instance.new("UIPadding")
		UIPadding.Name = "UIPadding"
		UIPadding.PaddingLeft = UDim.new(0, 5)
		UIPadding.PaddingRight = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 1)
		UIPadding.Parent = Value

		Value.Parent = Inline

		Inline.Parent = Outline

		local Accent = Instance.new("Frame")
		Accent.Name = "Accent"
		Accent.BackgroundColor3 = color ~= nil and color or Library.Accent
		Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Accent.BorderSizePixel = 0
		Accent.Size = UDim2.new(1, 0, 0, 1)
		Accent.Parent = Outline
		Accent.BackgroundTransparency = 1
		table.insert(notification.Objects, Accent)


		function notification:remove()
			table.remove(Library.Notifs, table.find(Library.Notifs, notification))
			Library:updateNotifsPositions(Position)
			task.wait(0.5)
			notification.Container:Destroy()
		end

		task.spawn(function()
			Outline.AnchorPoint = Vector2.new(1,0)
			for i,v in next, notification.Objects do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				elseif v:IsA("UIStroke") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0.8}):Play()
				end
			end
			local Tween1 = game:GetService("TweenService"):Create(Outline, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(0,0)}):Play()
			game:GetService("TweenService"):Create(Value, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			task.wait(duration)
			game:GetService("TweenService"):Create(Outline, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(1,0)}):Play()
			for i,v in next, notification.Objects do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				elseif v:IsA("UIStroke") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 1}):Play()
				end
			end
			game:GetService("TweenService"):Create(Value, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
		end)

		task.delay(duration, function()
			notification:remove()
		end)

		table.insert(Library.Notifs, notification)
		NotifContainer.Position = UDim2.new(0,Position.X,0,Position.Y + (table.find(Library.Notifs, notification) * 25))
		Library:updateNotifsPositions(Position)

		return notification
	end

	do
		local Pages = Library.Pages;
		local Sections = Library.Sections;
		--
		function Library:Window(Options)
			local Window = {
				Pages = {};
				Sections = {};
				Elements = {};
				PageAmount = Options.Amount or Options.amount or 5;
				Dragging = { false, UDim2.new(0, 0, 0, 0) };
				Name = (Options.Name or Options.name or "Name");
			};
			--
			local UI = Instance.new("ScreenGui", game.CoreGui)
			UI.Name = "UI"
			UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			Library.ScreenGUI = UI

			local AccentOutline = Library:NewInstance("TextButton", true)
			AccentOutline.Name = "AccentOutline"
			AccentOutline.AnchorPoint = Vector2.new(0,0)
			AccentOutline.BackgroundColor3 = Library.Accent
			AccentOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AccentOutline.ClipsDescendants = false
			AccentOutline.Position = UDim2.new(0, 200, 0, 200)
			AccentOutline.Size = UDim2.new(0, 550, 0, 600)
			AccentOutline.ZIndex = 2
			AccentOutline.Text = ""
			AccentOutline.AutoButtonColor = false

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.ClipsDescendants = false
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.ZIndex = 2

			local HolderOutline = Instance.new("Frame")
			HolderOutline.Name = "HolderOutline"
			HolderOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			HolderOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HolderOutline.Position = UDim2.new(0, 6, 0, 22)
			HolderOutline.Size = UDim2.new(1, -12, 1, -28)

			local HolderInline = Instance.new("Frame")
			HolderInline.Name = "HolderInline"
			HolderInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			HolderInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HolderInline.BorderSizePixel = 0
			HolderInline.Position = UDim2.new(0, 1, 0, 1)
			HolderInline.Size = UDim2.new(1, -2, 1, -2)

			local PageOutline = Instance.new("Frame")
			PageOutline.Name = "PageOutline"
			PageOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			PageOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageOutline.Position = UDim2.new(0, 4, 0, 26)
			PageOutline.Size = UDim2.new(1, -8, 1, -30)
			PageOutline.ZIndex = 6

			local PageInline = Instance.new("Frame")
			PageInline.Name = "PageInline"
			PageInline.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			PageInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageInline.BorderSizePixel = 0
			PageInline.Position = UDim2.new(0, 1, 0, 1)
			PageInline.Size = UDim2.new(1, -2, 1, -2)
			PageInline.Parent = PageOutline

			PageOutline.Parent = HolderInline

			local Tabs = Instance.new("Frame")
			Tabs.Name = "Tabs"
			Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Tabs.BackgroundTransparency = 1
			Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Tabs.BorderSizePixel = 0
			Tabs.Position = UDim2.new(0, 4, 0, 5)
			Tabs.Size = UDim2.new(1, -8, 0, 20)
			Tabs.ZIndex = 6
			
			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 8)
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Tabs

			Tabs.Parent = HolderInline

			HolderInline.Parent = HolderOutline

			HolderOutline.Parent = Inline

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.Text = Window.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 6, 0, 2)
			Title.Size = UDim2.new(0, 200, 0, 20)
			Title.Parent = Inline
			
			local Resize = Instance.new("TextButton")
			Resize.Name = "Resize"
			Resize.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Resize.Text = ""
			Resize.TextColor3 = Color3.fromRGB(0, 0, 0)
			Resize.TextSize = 14
			Resize.AutoButtonColor = false
			Resize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Resize.BackgroundTransparency = 1
			Resize.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Resize.BorderSizePixel = 0
			Resize.Position = UDim2.new(1, -15, 1, -15)
			Resize.Size = UDim2.new(0, 20, 0, 20)
			Resize.Parent = Inline
			Resize.ZIndex = 100
			
			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.Image = "rbxassetid://9052792535"
			ImageLabel.ImageColor3 = Color3.fromRGB(50, 50, 50)
			ImageLabel.ScaleType = Enum.ScaleType.Tile
			ImageLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Size = UDim2.new(0,14,0,14)
			ImageLabel.Position = UDim2.new(1, -14, 1, -14)
			ImageLabel.Parent = Inline

			Inline.Parent = AccentOutline

			AccentOutline.Parent = UI

			-- // Elements
			Window.Elements = {
				TabHolder = Tabs,
				Holder = PageInline,
				Base = AccentOutline,
			}

			-- // Dragging
			Library:Connection(AccentOutline.MouseButton1Down, function()
				local Location = game:GetService("UserInputService"):GetMouseLocation()
				Window.Dragging[1] = true
				Window.Dragging[2] = UDim2.new(0, Location.X - AccentOutline.AbsolutePosition.X, 0, Location.Y - AccentOutline.AbsolutePosition.Y)
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
					AccentOutline.Position = UDim2.new(
						0,
						Location.X - Window.Dragging[2].X.Offset + (AccentOutline.Size.X.Offset * AccentOutline.AnchorPoint.X),
						0,
						Location.Y - Window.Dragging[2].Y.Offset + (AccentOutline.Size.Y.Offset * AccentOutline.AnchorPoint.Y)
					)
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if Input.KeyCode == Library.UIKey then
					Library:SetOpen(not Library.Open)
				end
			end)
			Library:Resize(Resize, AccentOutline)

			-- // Functions
			function Window:UpdateTabs()
				for Index, Page in pairs(Window.Pages) do
					Page:Turn(Page.Open)
				end
			end

			-- // Returns
			Library.Holder = AccentOutline
			Library.PageAmount = Window.PageAmount;
			return setmetatable(Window, Library)
		end;
		--
		function Library:Page(Properties)
			if not Properties then
				Properties = {}
			end
			--
			local Page = {
				Name = Properties.Name or Properties.name or "Page",
				Window = self,
				Open = false,
				Sections = {},
				Pages = {},
				Elements = {},
				Weapons = {},
				Size = Properties.Size or 65,
				Icons = Properties.Weapons or Properties.weapons or false,
			}
			--
			local NewButton = Instance.new("TextButton")
			NewButton.Name = "NewButton"
			NewButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewButton.Text = ""
			NewButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.TextSize = 14
			NewButton.AutoButtonColor = false
			NewButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.Size = UDim2.new(0, Page.Window.PageAmount and ((((Page.Window.Elements.Base.Size.X.Offset - 35) - ((Page.Window.PageAmount - 1) * 2)) / Page.Window.PageAmount)) - 3 or Page.Size, 1, 0);

			local ButtonInline = Instance.new("Frame")
			ButtonInline.Name = "ButtonInline"
			ButtonInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ButtonInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonInline.BorderSizePixel = 0
			ButtonInline.Position = UDim2.new(0, 1, 0, 1)
			ButtonInline.Size = UDim2.new(1, -2, 1, -2)
			ButtonInline.ZIndex = 5

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 0, 1)
			Accent.Parent = ButtonInline
			Accent.Visible = false

			local PageName = Instance.new("TextLabel")
			PageName.Name = "PageName"
			PageName.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			PageName.TextColor3 = Color3.fromRGB(145,145,145)
			PageName.TextSize = 12
			PageName.Text = Page.Name
			PageName.TextStrokeTransparency = 0
			PageName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PageName.BackgroundTransparency = 1
			PageName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageName.Position = UDim2.new(0,0,0,1)
			PageName.BorderSizePixel = 0
			PageName.Size = UDim2.new(1, 0, 1, 0)
			PageName.Parent = ButtonInline

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Parent = ButtonInline

			ButtonInline.Parent = NewButton

			local Line = Instance.new("Frame")
			Line.Name = "Line"
			Line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0, 1, 1, -2)
			Line.Size = UDim2.new(1, -2, 0, 3)
			Line.ZIndex = 7

			local Frame = Instance.new("Frame")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(1, 0, 0, 0)
			Frame.Size = UDim2.new(0, 1, 1, 0)
			Frame.Parent = Line

			local Frame1 = Instance.new("Frame")
			Frame1.Name = "Frame"
			Frame1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Frame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame1.BorderSizePixel = 0
			Frame1.Position = UDim2.new(0, -1, 0, 0)
			Frame1.Size = UDim2.new(0, 1, 1, 0)
			Frame1.Parent = Line

			Line.Parent = NewButton

			NewButton.Parent = Page.Window.Elements.TabHolder
			
			local NewPage = Instance.new("Frame")
			NewPage.Name = "NewPage"
			NewPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewPage.BackgroundTransparency = 1
			NewPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewPage.BorderSizePixel = 0
			NewPage.Position = UDim2.new(0, 6, 0, 6)
			NewPage.Size = UDim2.new(1, -12, 1, -12)
			NewPage.Visible = false
			NewPage.Parent = Page.Window.Elements.Holder

			local Left = Instance.new("Frame")
			Left.Name = "Left"
			Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Left.BackgroundTransparency = 1
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.Size = UDim2.new(0.5, -4, 1, 0)
			Left.ZIndex = 2

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 6)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Left

			Left.Parent = NewPage

			local Right = Instance.new("Frame")
			Right.Name = "Right"
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.Position = UDim2.new(0.5, 4, 0, 0)
			Right.Size = UDim2.new(0.5, -4, 1, 0)

			local UIListLayout1 = Instance.new("UIListLayout")
			UIListLayout1.Name = "UIListLayout"
			UIListLayout1.Padding = UDim.new(0, 6)
			UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout1.Parent = Right

			Right.Parent = NewPage
			
			local Weapons = Instance.new("Frame")
			Weapons.Name = "Weapons"
			Weapons.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Weapons.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Weapons.Position = UDim2.new(0, 6, 0, 6)
			Weapons.Size = UDim2.new(1, -12, 0, 50)
			Weapons.Visible = false
			Weapons.Parent = Page.Window.Elements.Holder

			local WeaponInline = Instance.new("Frame")
			WeaponInline.Name = "WeaponInline"
			WeaponInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			WeaponInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WeaponInline.BorderSizePixel = 0
			WeaponInline.Position = UDim2.new(0, 1, 0, 1)
			WeaponInline.Size = UDim2.new(1, -2, 1, -2)

			local WAccent = Library:NewInstance("Frame", true)
			WAccent.Name = "WAccent"
			WAccent.BackgroundColor3 = Library.Accent
			WAccent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WAccent.BorderSizePixel = 0
			WAccent.Size = UDim2.new(1, 0, 0, 1)
			WAccent.Parent = WeaponInline

			local Holder = Instance.new("Frame")
			Holder.Name = "Holder"
			Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Holder.BackgroundTransparency = 1
			Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Holder.BorderSizePixel = 0
			Holder.Position = UDim2.new(0, 0, 0, 2)
			Holder.Size = UDim2.new(1, 0, 1, -2)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Holder

			Holder.Parent = WeaponInline

			WeaponInline.Parent = Weapons

			function Page:Turn(bool)
				Page.Open = bool
				if not Page.Icons then
					NewPage.Visible = Page.Open
				else
					Weapons.Visible = Page.Open
					for Index, Weapon in pairs(Page.Weapons) do
						Weapon:Turn(Weapon.Open)
					end
				end
				ButtonInline.BackgroundColor3 = Page.Open and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(20, 20, 20)
				PageName.TextColor3 = Page.Open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(145,145,145)
				Line.Size = Page.Open and UDim2.new(1, -2, 0, 4) or UDim2.new(1, -2, 0, 3)
				Line.BackgroundColor3 = Page.Open and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(20, 20, 20)
				Accent.Visible = Page.Open
			end
			--
			Library:Connection(NewButton.MouseButton1Down, function()
				if not Page.Open then
					for _, Pages in pairs(Page.Window.Pages) do
						if Pages.Open and Pages ~= Page then
							Pages:Turn(false)
						end
					end
					Page:Turn(true)
				end
			end)
			
			function Page:UpdateWeapons()
				for Index, Weapon in pairs(Page.Weapons) do
					Weapon.Elements.Button.Size = UDim2.new(1/#Page.Weapons,0,1,0)
					Weapon:Turn(Weapon.Open)
				end
			end

			-- // Elements
			Page.Elements = {
				Left = Page.Icons and nil or Left,
				Right = Page.Icons and nil or Right,
				Main = NewPage,
				Button = NewButton,
				WeaponOutline = Weapons,
				WeaponInline = Holder,
			}

			-- // Drawings
			if #Page.Window.Pages == 0 then
				Page:Turn(true)
			end
			Page.Window.Pages[#Page.Window.Pages + 1] = Page
			Library.Pages[#Library.Pages + 1] = Page
			Page.Window:UpdateTabs()
			return setmetatable(Page, Library.Pages)
		end
		--
		function Library:Watermark(Properties)
			local Watermark = {
				Name = (Properties.Name or Properties.name or "watermark text | placeholder");
			}
			--
			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.AutomaticSize = Enum.AutomaticSize.X
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0.01, 0,0.02, 0)
			Outline.Size = UDim2.new(0, 0, 0, 16)
			Outline.Visible = false
			Outline.Parent = Library.ScreenGUI

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = Watermark.Name
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.AutomaticSize = Enum.AutomaticSize.X
			Value.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(0, 0, 1, 0)

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingLeft = UDim.new(0, 5)
			UIPadding.PaddingRight = UDim.new(0, 5)
			UIPadding.Parent = Value

			Value.Parent = Inline

			Inline.Parent = Outline

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 0, 1)
			Accent.Parent = Outline
			
			-- // Functions
			function Watermark:UpdateText(NewText)
				Value.Text = NewText;
			end;
			function Watermark:SetVisible(State)
				Outline.Visible = State;
			end;
			
			return Watermark
		end
		--
		function Pages:Weapon(Properties)
			if not Properties then
				Properties = {}
			end
			--
			local Weapon = {
				Icon = Properties.Icon or Properties.icon or "rbxassetid://6034281935",
				Page = self,
				Open = false,
				Sections = {},
				Elements = {},
			}
			--
			--Weapon.Window.Elements.WeaponOutline.Visible = true

			local NewWeapon = Instance.new("ImageButton")
			NewWeapon.Name = "NewWeapon"
			NewWeapon.Image = Weapon.Icon
			NewWeapon.ImageColor3 = Color3.fromRGB(145, 145, 145)
			NewWeapon.ScaleType = Enum.ScaleType.Fit
			NewWeapon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewWeapon.BackgroundTransparency = 1
			NewWeapon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewWeapon.BorderSizePixel = 0
			NewWeapon.Size = UDim2.new(0.5, 0, 1, 0)
			NewWeapon.Parent = Weapon.Page.Elements.WeaponInline
			
			local NewPage = Instance.new("Frame")
			NewPage.Name = "NewPage"
			NewPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewPage.BackgroundTransparency = 1
			NewPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewPage.BorderSizePixel = 0
			NewPage.Position = UDim2.new(0, 6, 0, 66)
			NewPage.Size = UDim2.new(1, -12, 1, -72)
			NewPage.Visible = false
			NewPage.Parent = Weapon.Page.Window.Elements.Holder

			local Left = Instance.new("Frame")
			Left.Name = "Left"
			Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Left.BackgroundTransparency = 1
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.Size = UDim2.new(0.5, -4, 1, 0)
			Left.ZIndex = 2

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 6)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Left

			Left.Parent = NewPage

			local Right = Instance.new("Frame")
			Right.Name = "Right"
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.Position = UDim2.new(0.5, 4, 0, 0)
			Right.Size = UDim2.new(0.5, -4, 1, 0)

			local UIListLayout1 = Instance.new("UIListLayout")
			UIListLayout1.Name = "UIListLayout"
			UIListLayout1.Padding = UDim.new(0, 6)
			UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout1.Parent = Right

			Right.Parent = NewPage

			function Weapon:Turn(bool)
				Weapon.Open = bool
				NewPage.Visible = Weapon.Open and Weapon.Page.Open
				NewWeapon.ImageColor3 = Weapon.Open and Color3.new(1,1,1) or Color3.fromRGB(145,145,145)
			end
			--
			Library:Connection(NewWeapon.MouseButton1Down, function()
				if not Weapon.Open then
					Weapon:Turn(true)
					for _, Weapons in pairs(Weapon.Page.Weapons) do
						if Weapons.Open and Weapons ~= Weapon then
							Weapons:Turn(false)
						end
					end
				end
			end)
			--

			-- // Elements
			Weapon.Elements = {
				Left = Left,
				Right = Right,
				Button = NewWeapon,
				Main = NewPage
			}

			-- // Drawings
			if #Weapon.Page.Weapons == 0 then
				Weapon:Turn(true)
			end
			Weapon.Page.Weapons[#Weapon.Page.Weapons + 1] = Weapon
			Weapon.Page:UpdateWeapons()
			return setmetatable(Weapon, Library.Pages)
		end
		--
		function Pages:Section(Properties)
			if not Properties then
				Properties = {}
			end
			--
			local Section = {
				Name = Properties.Name or "Section",
				Page = self,
				Side = (Properties.side or Properties.Side or "left"):lower(),
				Zindex = (Properties.Zindex or Properties.zindex or 1),
				Elements = {},
				Content = {},
				Sections = {},
			}
			--
			local SectionOutline = Instance.new("Frame")
			SectionOutline.Name = "SectionOutline"
			SectionOutline.AutomaticSize = Enum.AutomaticSize.Y
			SectionOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			SectionOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionOutline.Size = UDim2.new(1, 0, 0, 20)
			SectionOutline.Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right
			SectionOutline.ZIndex = 10 - #Section.Page.Sections

			local SectionInline = Instance.new("Frame")
			SectionInline.Name = "SectionInline"
			SectionInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			SectionInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionInline.BorderSizePixel = 0
			SectionInline.Position = UDim2.new(0, 1, 0, 1)
			SectionInline.Size = UDim2.new(1, -2, 1, -2)

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 0, 1)
			Accent.Parent = SectionInline

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.Text = Section.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 5, 0, 1)
			Title.Size = UDim2.new(0, 200, 0, 20)
			Title.Parent = SectionInline

			local SectionContent = Instance.new("Frame")
			SectionContent.Name = "SectionContent"
			SectionContent.AutomaticSize = Enum.AutomaticSize.Y
			SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContent.BackgroundTransparency = 1
			SectionContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionContent.BorderSizePixel = 0
			SectionContent.Position = UDim2.new(0, 4, 0, 25)
			SectionContent.Size = UDim2.new(1, -8, 0, 0)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 10)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = SectionContent

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 6)
			UIPadding.Parent = SectionContent

			SectionContent.Parent = SectionInline

			SectionInline.Parent = SectionOutline

			-- // Elements
			Section.Elements = {
				SectionContent = SectionContent;
			}

			-- // Returning
			Section.Page.Sections[#Section.Page.Sections + 1] = Section
			return setmetatable(Section, Library.Sections)
		end
		--
		function Sections:Toggle(Properties)
			if not Properties then
				Properties = {}
			end
			--
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
			--
			local NewToggle = Instance.new("TextButton")
			NewToggle.Name = "NewToggle"
			NewToggle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewToggle.Text = ""
			NewToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewToggle.TextSize = 14
			NewToggle.AutoButtonColor = false
			NewToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewToggle.BackgroundTransparency = 1
			NewToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewToggle.BorderSizePixel = 0
			NewToggle.Size = UDim2.new(1, 0, 0, 10)
			NewToggle.Parent = Toggle.Section.Elements.SectionContent

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Size = UDim2.new(0, 10, 0, 10)

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 1, 0)
			Accent.Parent = Inline
			Accent.Visible = false

			Inline.Parent = Outline

			Outline.Parent = NewToggle

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 16, 0, 0)
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewToggle
			Title.Text = Toggle.Name

			-- // Functions
			local function SetState()
				Toggle.Toggled = not Toggle.Toggled
				Accent.Visible = Toggle.Toggled
				Library.Flags[Toggle.Flag] = Toggle.Toggled
				Toggle.Callback(Toggle.Toggled)
			end
			--
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
				--
				local ModeBox = Instance.new("Frame")
				local Hold = Instance.new("TextButton")
				local Toggle = Instance.new("TextButton")
				local Always = Instance.new("TextButton")
				--
				local kOutline = Instance.new("Frame")
				kOutline.Name = "Outline"
				kOutline.AnchorPoint = Vector2.new(0, 0.5)
				kOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				kOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				kOutline.Position = UDim2.new(1, -35, 0.5, 0)
				kOutline.Size = UDim2.new(0, 35, 0, 12)

				local KInline = Instance.new("TextButton")
				KInline.Name = "Inline"
				KInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				KInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KInline.BorderSizePixel = 0
				KInline.Position = UDim2.new(0, 1, 0, 1)
				KInline.Size = UDim2.new(1, -2, 1, -2)
				KInline.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
				KInline.Text = ""
				KInline.TextColor3 = Color3.fromRGB(0, 0, 0)
				KInline.TextSize = 14
				KInline.AutoButtonColor = false

				local Value = Instance.new("TextLabel")
				Value.Name = "Value"
				Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
				Value.Text = "MB2"
				Value.TextColor3 = Color3.fromRGB(255, 255, 255)
				Value.TextSize = 12
				Value.TextStrokeTransparency = 0
				Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Value.BackgroundTransparency = 1
				Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderSizePixel = 0
				Value.Size = UDim2.new(1, 0, 1, 0)
				Value.Parent = KInline

				KInline.Parent = kOutline

				kOutline.Parent = NewToggle

				ModeBox.Name = "ModeBox"
				ModeBox.Parent = kOutline
				ModeBox.AnchorPoint = Vector2.new(0,0.5)
				ModeBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
				ModeBox.BorderColor3 = Color3.fromRGB(50,50,50)
				ModeBox.BorderSizePixel = 1
				ModeBox.Size = UDim2.new(0, 65, 0, 60)
				ModeBox.Position = UDim2.new(0,40,0.5,0)
				ModeBox.Visible = false

				local Outline4 = Instance.new("Frame")
				Outline4.Name = "Outline"
				Outline4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Outline4.BackgroundTransparency = 1
				Outline4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Outline4.BorderSizePixel = 0
				Outline4.Position = UDim2.new(0, -1, 0, -1)
				Outline4.Size = UDim2.new(1, 2, 1, 2)
				Outline4.Parent = ModeBox

				local UIStroke = Instance.new("UIStroke")
				UIStroke.Name = "UIStroke"
				UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
				UIStroke.Parent = Outline4

				Hold.Name = "Hold"
				Hold.Parent = ModeBox
				Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Hold.BackgroundTransparency = 1.000
				Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Hold.BorderSizePixel = 0
				Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
				Hold.ZIndex = 2
				Hold.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
				Hold.Text = "Hold"
				Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.fromRGB(255,255,255) or Color3.fromRGB(145,145,145)
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
				Toggle.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
				Toggle.Text = "Toggle"
				Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.fromRGB(255,255,255) or Color3.fromRGB(145,145,145)
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
				Always.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
				Always.Text = "Always"
				Always.TextColor3 = Keybind.Mode == "Always" and Color3.fromRGB(255,255,255) or Color3.fromRGB(145,145,145)
				Always.TextSize = Library.FSize
				Always.TextStrokeTransparency = 0

				-- // Functions
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
						end

						Library.Flags[Keybind.Flag .. "_KEY"] = newkey
					elseif table.find({ "Always", "Toggle", "Hold" }, newkey) then
						if not Keybind.UseKey then
							Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
							Keybind.Mode = newkey
							if Keybind.Mode == "Always" then
								State = true
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = State
								end
								Keybind.Callback(true)
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
				--
				set(Keybind.State)
				set(Keybind.Mode)
				KInline.MouseButton1Click:Connect(function()
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
				--
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
						elseif Keybind.Mode == "Toggle" then
							State = not State
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(State)
						end
					end
				end)
				--
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
								end
							end
						end
					end
				end)
				--
				Library:Connection(KInline.MouseButton2Down, function()
					ModeBox.Visible = true
					NewToggle.ZIndex = 5
				end)
				--
				Library:Connection(Hold.MouseButton1Down, function()
					set("Hold")
					Hold.TextColor3 = Color3.fromRGB(255,255,255)
					Toggle.TextColor3 = Color3.fromRGB(145,145,145)
					Always.TextColor3 = Color3.fromRGB(145,145,145)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				--
				Library:Connection(Toggle.MouseButton1Down, function()
					set("Toggle")
					Hold.TextColor3 = Color3.fromRGB(145,145,145)
					Toggle.TextColor3 = Color3.fromRGB(255,255,255)
					Always.TextColor3 = Color3.fromRGB(145,145,145)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				--
				Library:Connection(Always.MouseButton1Down, function()
					set("Always")
					Hold.TextColor3 = Color3.fromRGB(145,145,145)
					Toggle.TextColor3 = Color3.fromRGB(145,145,145)
					Always.TextColor3 = Color3.fromRGB(255,255,255)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				--
				Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
					if ModeBox.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if not Library:IsMouseOverFrame(ModeBox) then
							ModeBox.Visible = false
							NewToggle.ZIndex = 1
						end
					end
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
				-- // Functions
				Toggle.Colorpickers = Toggle.Colorpickers + 1
				local colorpickertypes = Library:NewPicker(
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

				-- // Returning
				return Colorpicker
			end

			-- // Misc Functions
			function Toggle.Set(bool)
				bool = type(bool) == "boolean" and bool or false
				if Toggle.Toggled ~= bool then
					SetState()
				end
			end
			Toggle.Set(Toggle.State)
			Library.Flags[Toggle.Flag] = Toggle.State
			Flags[Toggle.Flag] = Toggle.Set

			-- // Returning
			return Toggle
		end
		--
		function Sections:Slider(Properties)
			if not Properties then
				Properties = {}
			end
			--
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
			--
			local NewSlider = Instance.new("Frame")
			NewSlider.Name = "NewSlider"
			NewSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewSlider.BackgroundTransparency = 1
			NewSlider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewSlider.BorderSizePixel = 0
			NewSlider.Size = UDim2.new(1, 0, 0, Slider.Name ~= nil and 26 or 12)
			NewSlider.Parent = Slider.Section.Elements.SectionContent

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0, 0, 1, -12)
			Outline.Size = UDim2.new(1, 0, 0, 12)

			local Inline = Instance.new("TextButton")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14
			Inline.AutoButtonColor = false

			local Accent = Library:NewInstance("TextButton", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(0, 0, 1, 0)
			Accent.Parent = Inline
			Accent.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Accent.Text = ""
			Accent.TextColor3 = Color3.fromRGB(0, 0, 0)
			Accent.TextSize = 14
			Accent.AutoButtonColor = false

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = "0"
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Inline

			Inline.Parent = Outline

			Outline.Parent = NewSlider

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 10)
			Title.Parent = NewSlider
			Title.Text = Slider.Name ~= nil and Slider.Name or ""
			Title.Visible = Slider.Name ~= nil and true or false

			-- // Functions
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
			--
			local function ISlide(input)
				local sizeX = (input.Position.X - Inline.AbsolutePosition.X) / Inline.AbsoluteSize.X
				local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
				Set(value)
			end
			--
			Library:Connection(Inline.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					ISlide(input)
				end
			end)
			Library:Connection(Inline.InputEnded, function(input)
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
			--
			function Slider:Set(Value)
				Set(Value)
			end
			--
			Flags[Slider.Flag] = Set
			Library.Flags[Slider.Flag] = Slider.State
			Set(Slider.State)

			-- // Returning
			return Slider
		end
		--
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
			--
			local NewList = Instance.new("Frame")
			NewList.Name = "NewList"
			NewList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewList.BackgroundTransparency = 1
			NewList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewList.BorderSizePixel = 0
			NewList.Size = UDim2.new(1, 0, 0, Dropdown.Name ~= nil and 30 or 16)
			NewList.Parent = Dropdown.Section.Elements.SectionContent

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0, 0, 1, -16)
			Outline.Size = UDim2.new(1, 0, 0, 16)

			local Inline = Instance.new("TextButton")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14
			Inline.AutoButtonColor = false

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = "None"
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 4, 0, 0)
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Inline

			local Icon = Instance.new("TextLabel")
			Icon.Name = "Icon"
			Icon.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Icon.Text = "+"
			Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
			Icon.TextSize = 12
			Icon.TextStrokeTransparency = 0
			Icon.TextXAlignment = Enum.TextXAlignment.Right
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(0, -4, 0, 0)
			Icon.Size = UDim2.new(1, 0, 1, 0)
			Icon.Parent = Inline

			Inline.Parent = Outline

			local ContentOutline = Instance.new("Frame")
			ContentOutline.Name = "ContentOutline"
			ContentOutline.AutomaticSize = Enum.AutomaticSize.Y
			ContentOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			ContentOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ContentOutline.Position = UDim2.new(0, 0, 1, 1)
			ContentOutline.Size = UDim2.new(1, 0, 0, 0)
			ContentOutline.Visible = false

			local ContentInline = Instance.new("Frame")
			ContentInline.Name = "ContentInline"
			ContentInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ContentInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ContentInline.BorderSizePixel = 0
			ContentInline.Position = UDim2.new(0, 1, 0, 1)
			ContentInline.Size = UDim2.new(1, -2, 1, -2)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 2)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = ContentInline

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 2)
			UIPadding.Parent = ContentInline

			ContentInline.Parent = ContentOutline

			ContentOutline.Parent = Outline

			Outline.Parent = NewList

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 10)
			Title.Parent = NewList
			Title.Visible = Dropdown.Name ~= nil and true or false
			Title.Text = Dropdown.Name ~= nil and Dropdown.Name or ""

			-- // Connections
			Library:Connection(Inline.MouseButton1Down, function()
				ContentOutline.Visible = not ContentOutline.Visible
				if ContentOutline.Visible then
					Icon.Text = "-"
					NewList.ZIndex = 5
				else
					Icon.Text = "+"
					NewList.ZIndex = 1
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ContentOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ContentOutline) and not Library:IsMouseOverFrame(Inline) then
						ContentOutline.Visible = false
						NewList.ZIndex = 1
						Icon.Text = "+"
					end
				end
			end)
			--
			local chosen = Dropdown.Max and {} or nil
			local Count = 0
			--
			local function handleoptionclick(option, button, text)
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
							text.TextColor3 = Color3.fromRGB(145,145,145)
							
							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						else
							if #chosen == Dropdown.Max then
								Dropdown.OptionInsts[chosen[1]].accent.Visible = false
								table.remove(chosen, 1)
							end

							table.insert(chosen, option)

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
							text.TextColor3 = Color3.fromRGB(255,255,255)

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						end
					else
						for opt, tbl in next, Dropdown.OptionInsts do
							if opt ~= option then
								tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
							end
						end
						chosen = option
						Value.Text = option
						text.TextColor3 = Color3.fromRGB(255,255,255)
						ContentOutline.Visible = false
						NewList.ZIndex = 1
						Icon.Text = "+"
						Library.Flags[Dropdown.Flag] = option
						Dropdown.Callback(option)
					end
				end)
			end
			--
			local function createoptions(tbl)
				for _, option in next, tbl do
					Dropdown.OptionInsts[option] = {}
					--
					local NewOption = Instance.new("TextButton")
					NewOption.Name = "NewOption"
					NewOption.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
					NewOption.Text = ""
					NewOption.TextColor3 = Color3.fromRGB(255, 255, 255)
					NewOption.TextSize = 12
					NewOption.TextStrokeTransparency = 0
					NewOption.TextWrapped = true
					NewOption.TextXAlignment = Enum.TextXAlignment.Left
					NewOption.AutoButtonColor = false
					NewOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					NewOption.BackgroundTransparency = 1
					NewOption.BorderColor3 = Color3.fromRGB(0, 0, 0)
					NewOption.BorderSizePixel = 0
					NewOption.Size = UDim2.new(1, 0, 0, 14)

					local OptionLabel = Instance.new("TextLabel")
					OptionLabel.Name = "OptionLabel"
					OptionLabel.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
					OptionLabel.Text = option
					OptionLabel.TextColor3 = Color3.fromRGB(145, 145, 145)
					OptionLabel.TextSize = 12
					OptionLabel.TextStrokeTransparency = 0
					OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
					OptionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					OptionLabel.BackgroundTransparency = 1
					OptionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					OptionLabel.BorderSizePixel = 0
					OptionLabel.Position = UDim2.new(0, 4, 0, 0)
					OptionLabel.Size = UDim2.new(1, 0, 1, 0)
					OptionLabel.Parent = NewOption

					NewOption.Parent = ContentInline

					Dropdown.OptionInsts[option].text = OptionLabel

					Count = Count + 1

					handleoptionclick(option, NewOption, OptionLabel)
				end
			end
			createoptions(Dropdown.Options)
			--
			local set
			set = function(option)
				if Dropdown.Max then
					table.clear(chosen)
					option = type(option) == "table" and option or {}

					for opt, tbl in next, Dropdown.OptionInsts do
						if not table.find(option, opt) then
							tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
						end
					end

					for i, opt in next, option do
						if table.find(Dropdown.Options, opt) and #chosen < Dropdown.Max then
							table.insert(chosen, opt)
							Dropdown.OptionInsts[opt].text.TextColor3 = Color3.fromRGB(255,255,255)
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
			--
			function Dropdown:Set(option)
				if Dropdown.Max then
					set(option)
				else
					for opt, tbl in next, Dropdown.OptionInsts do
						if opt ~= option then
							tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
						end
					end
					if table.find(Dropdown.Options, option) then
						chosen = option
						Dropdown.OptionInsts[option].text.TextColor3 = Color3.fromRGB(255,255,255)
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
			--
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

			-- // Returning
			if Dropdown.Max then
				Flags[Dropdown.Flag] = set
			else
				Flags[Dropdown.Flag] = Dropdown
			end
			Dropdown:Set(Dropdown.State)
			return Dropdown
		end
		--
		function Sections:ListBox(Properties)
			local Properties = Properties or {};
			local Dropdown = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Open = false,
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
			--
			local NewList = Instance.new("TextButton")
			NewList.Name = "NewList"
			NewList.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewList.Text = ""
			NewList.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewList.TextSize = 14
			NewList.AutoButtonColor = false
			NewList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewList.BackgroundTransparency = 1
			NewList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewList.BorderSizePixel = 0
			NewList.Size = UDim2.new(1, 0, 0, (14 * Dropdown.ScrollMax) + (2 * Dropdown.ScrollMax) + 4)
			NewList.Parent = Dropdown.Section.Elements.SectionContent

			local ContentOutline = Instance.new("Frame")
			ContentOutline.Name = "ContentOutline"
			ContentOutline.AutomaticSize = Enum.AutomaticSize.Y
			ContentOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			ContentOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ContentOutline.Size = UDim2.new(1, 0, 1, 0)

			local ContentInline = Library:NewInstance("ScrollingFrame", true)
			ContentInline.Name = "ContentInline"
			ContentInline.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ContentInline.BottomImage = "rbxassetid://7783554086"
			ContentInline.CanvasSize = UDim2.new()
			ContentInline.MidImage = "rbxassetid://7783554086"
			ContentInline.ScrollBarImageColor3 = Library.Accent
			ContentInline.ScrollBarThickness = 4
			ContentInline.TopImage = "rbxassetid://7783554086"
			ContentInline.Active = true
			ContentInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ContentInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ContentInline.BorderSizePixel = 0
			ContentInline.Position = UDim2.new(0, 1, 0, 1)
			ContentInline.Size = UDim2.new(1, -2, 1, -2)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 2)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = ContentInline

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 2)
			UIPadding.Parent = ContentInline

			ContentInline.Parent = ContentOutline

			ContentOutline.Parent = NewList
			--
			local chosen = Dropdown.Max and {} or nil
			local Count = 0
			--
			local function handleoptionclick(option, button, text)
				button.MouseButton1Down:Connect(function()
					if Dropdown.Max then
						if table.find(chosen, option) then
							table.remove(chosen, table.find(chosen, option))

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							text.TextColor3 = Color3.fromRGB(145,145,145)

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						else
							if #chosen == Dropdown.Max then
								Dropdown.OptionInsts[chosen[1]].accent.Visible = false
								table.remove(chosen, 1)
							end

							table.insert(chosen, option)

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							text.TextColor3 = Color3.fromRGB(255,255,255)

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						end
					else
						for opt, tbl in next, Dropdown.OptionInsts do
							if opt ~= option then
								tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
							end
						end
						chosen = option
						text.TextColor3 = Color3.fromRGB(255,255,255)
						Library.Flags[Dropdown.Flag] = option
						Dropdown.Callback(option)
					end
				end)
			end
			--
			local function createoptions(tbl)
				for _, option in next, tbl do
					Dropdown.OptionInsts[option] = {}
					--
					local NewOption = Instance.new("TextButton")
					NewOption.Name = "NewOption"
					NewOption.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
					NewOption.Text = ""
					NewOption.TextColor3 = Color3.fromRGB(255, 255, 255)
					NewOption.TextSize = 12
					NewOption.TextStrokeTransparency = 0
					NewOption.TextWrapped = true
					NewOption.TextXAlignment = Enum.TextXAlignment.Left
					NewOption.AutoButtonColor = false
					NewOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					NewOption.BackgroundTransparency = 1
					NewOption.BorderColor3 = Color3.fromRGB(0, 0, 0)
					NewOption.BorderSizePixel = 0
					NewOption.Size = UDim2.new(1, 0, 0, 14)

					local OptionLabel = Instance.new("TextLabel")
					OptionLabel.Name = "OptionLabel"
					OptionLabel.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
					OptionLabel.Text = option
					OptionLabel.TextColor3 = Color3.fromRGB(145, 145, 145)
					OptionLabel.TextSize = 12
					OptionLabel.TextStrokeTransparency = 0
					OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
					OptionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					OptionLabel.BackgroundTransparency = 1
					OptionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					OptionLabel.BorderSizePixel = 0
					OptionLabel.Position = UDim2.new(0, 4, 0, 0)
					OptionLabel.Size = UDim2.new(1, 0, 1, 0)
					OptionLabel.Parent = NewOption

					NewOption.Parent = ContentInline

					Dropdown.OptionInsts[option].text = OptionLabel

					Count = Count + 1

					handleoptionclick(option, NewOption, OptionLabel)
				end
			end
			createoptions(Dropdown.Options)
			--
			local set
			set = function(option)
				if Dropdown.Max then
					table.clear(chosen)
					option = type(option) == "table" and option or {}

					for opt, tbl in next, Dropdown.OptionInsts do
						if not table.find(option, opt) then
							tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
						end
					end

					for i, opt in next, option do
						if table.find(Dropdown.Options, opt) and #chosen < Dropdown.Max then
							table.insert(chosen, opt)
							Dropdown.OptionInsts[opt].text.TextColor3 = Color3.fromRGB(255,255,255)
						end
					end

					local textchosen = {}
					local cutobject = false

					for _, opt in next, chosen do
						table.insert(textchosen, opt)
					end

					Library.Flags[Dropdown.Flag] = chosen
					Dropdown.Callback(chosen)
				end
			end
			--
			function Dropdown:Set(option)
				if Dropdown.Max then
					set(option)
				else
					for opt, tbl in next, Dropdown.OptionInsts do
						if opt ~= option then
							tbl.text.TextColor3 = Color3.fromRGB(145,145,145)
						end
					end
					if table.find(Dropdown.Options, option) then
						chosen = option
						Dropdown.OptionInsts[option].text.TextColor3 = Color3.fromRGB(255,255,255)
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					else
						chosen = nil
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					end
				end
			end
			--
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

			-- // Returning
			if Dropdown.Max then
				Flags[Dropdown.Flag] = set
			else
				Flags[Dropdown.Flag] = Dropdown
			end
			Dropdown:Set(Dropdown.State)
			return Dropdown
		end
		--
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
			--
			local NewColor = Instance.new("TextButton")
			NewColor.Name = "NewColor"
			NewColor.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewColor.Text = ""
			NewColor.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewColor.TextSize = 14
			NewColor.AutoButtonColor = false
			NewColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewColor.BackgroundTransparency = 1
			NewColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewColor.BorderSizePixel = 0
			NewColor.Size = UDim2.new(1, 0, 0, 10)
			NewColor.Parent = Colorpicker.Section.Elements.SectionContent

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewColor
			Title.Text = Colorpicker.Name

			-- // Functions
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
				-- // Functions
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

				-- // Returning
				return NewColorpicker
			end

			-- // Returning
			return Colorpicker
		end
		--
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
			--
			local ModeBox = Instance.new("Frame")
			local Hold = Instance.new("TextButton")
			local Toggle = Instance.new("TextButton")
			local Always = Instance.new("TextButton")
			--
			local NewBind = Instance.new("Frame")
			NewBind.Name = "NewBind"
			NewBind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewBind.BackgroundTransparency = 1
			NewBind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewBind.BorderSizePixel = 0
			NewBind.Size = UDim2.new(1, 0, 0, 10)
			NewBind.Parent = Keybind.Section.Elements.SectionContent

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewBind
			Title.Text = Keybind.Name

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.AnchorPoint = Vector2.new(0, 0.5)
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(1, -35, 0.5, 0)
			Outline.Size = UDim2.new(0, 35, 0, 12)

			local Inline = Instance.new("TextButton")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14
			Inline.AutoButtonColor = false

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = "MB2"
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Inline

			Inline.Parent = Outline

			Outline.Parent = NewBind

			ModeBox.Name = "ModeBox"
			ModeBox.Parent = Outline
			ModeBox.AnchorPoint = Vector2.new(0,0.5)
			ModeBox.BackgroundColor3 = Color3.fromRGB(25,25,25)
			ModeBox.BorderColor3 = Color3.fromRGB(50,50,50)
			ModeBox.BorderSizePixel = 1
			ModeBox.Size = UDim2.new(0, 65, 0, 60)
			ModeBox.Position = UDim2.new(0,40,0.5,0)
			ModeBox.Visible = false
			
			local Outline4 = Instance.new("Frame")
			Outline4.Name = "Outline"
			Outline4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline4.BackgroundTransparency = 1
			Outline4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline4.BorderSizePixel = 0
			Outline4.Position = UDim2.new(0, -1, 0, -1)
			Outline4.Size = UDim2.new(1, 2, 1, 2)
			Outline4.Parent = ModeBox

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Outline4

			Hold.Name = "Hold"
			Hold.Parent = ModeBox
			Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hold.BackgroundTransparency = 1.000
			Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hold.BorderSizePixel = 0
			Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
			Hold.ZIndex = 2
			Hold.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Hold.Text = "Hold"
			Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.fromRGB(255,255,255) or Color3.fromRGB(145,145,145)
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
			Toggle.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Toggle.Text = "Toggle"
			Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.fromRGB(255,255,255) or Color3.fromRGB(145,145,145)
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
			Always.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Always.Text = "Always"
			Always.TextColor3 = Keybind.Mode == "Always" and Color3.fromRGB(255,255,255) or Color3.fromRGB(145,145,145)
			Always.TextSize = Library.FSize
			Always.TextStrokeTransparency = 0

			-- // Functions
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
					end

					Library.Flags[Keybind.Flag .. "_KEY"] = newkey
				elseif table.find({ "Always", "Toggle", "Hold" }, newkey) then
					if not Keybind.UseKey then
						Library.Flags[Keybind.Flag .. "_KEY STATE"] = newkey
						Keybind.Mode = newkey
						if Keybind.Mode == "Always" then
							State = true
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(true)
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
			--
			set(Keybind.State)
			set(Keybind.Mode)
			Inline.MouseButton1Click:Connect(function()
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
			--
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
					elseif Keybind.Mode == "Toggle" then
						State = not State
						if Keybind.Flag then
							Library.Flags[Keybind.Flag] = State
						end
						Keybind.Callback(State)
					end
				end
			end)
			--
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
							end
						end
					end
				end
			end)
			--
			Library:Connection(Inline.MouseButton2Down, function()
				ModeBox.Visible = true
				NewBind.ZIndex = 5
			end)
			--
			Library:Connection(Hold.MouseButton1Down, function()
				set("Hold")
				Hold.TextColor3 = Color3.fromRGB(255,255,255)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			--
			Library:Connection(Toggle.MouseButton1Down, function()
				set("Toggle")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(255,255,255)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			--
			Library:Connection(Always.MouseButton1Down, function()
				set("Always")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(255,255,255)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			--
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ModeBox.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ModeBox) then
						ModeBox.Visible = false
						NewBind.ZIndex = 1
					end
				end
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
			return Keybind
		end
		--
		function Sections:Textbox(Properties)
			local Properties = Properties or {}
			local Textbox = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = (Properties.Name or Properties.name or nil),
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
			--
			local NewBox = Instance.new("TextButton")
			NewBox.Name = "NewBox"
			NewBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewBox.Text = ""
			NewBox.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewBox.TextSize = 14
			NewBox.AutoButtonColor = false
			NewBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewBox.BackgroundTransparency = 1
			NewBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewBox.BorderSizePixel = 0
			NewBox.Size = UDim2.new(1, 0, 0, Textbox.Name ~= nil and 30 or 16)
			NewBox.Parent = Textbox.Section.Elements.SectionContent

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0, 0, 1, -16)
			Outline.Size = UDim2.new(1, 0, 0, 16)

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			local Value = Instance.new("TextBox")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = Textbox.State
			Value.PlaceholderText = Textbox.Placeholder
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.PlaceholderColor3 = Color3.fromRGB(145,145,145)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 4, 0, 0)
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Inline
			Value.ClearTextOnFocus = false

			Inline.Parent = Outline

			Outline.Parent = NewBox

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 12
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 10)
			Title.Parent = NewBox
			Title.Text = Textbox.Name ~= nil and Textbox.Name or ""
			Title.Visible = Textbox.Name ~= nil and true or false

			-- // Connections
			Value.FocusLost:Connect(function()
				Textbox.Callback(Value.Text)
				Library.Flags[Textbox.Flag] = Value.Text
			end)
			--
			local function set(str)
				Value.Text = str
				Library.Flags[Textbox.Flag] = str
				Textbox.Callback(str)
			end

			-- // Return
			Flags[Textbox.Flag] = set
			return Textbox
		end
		--
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
			--
			local NewButton = Instance.new("Frame")
			NewButton.Name = "NewButton"
			NewButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewButton.BackgroundTransparency = 1
			NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.BorderSizePixel = 0
			NewButton.Size = UDim2.new(1, 0, 0, 16)
			NewButton.Parent = Button.Section.Elements.SectionContent

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0, 0, 1, -16)
			Outline.Size = UDim2.new(1,0, 0, 16)

			local Inline = Instance.new("TextButton")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14
			Inline.AutoButtonColor = false

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = Button.Name
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = Inline

			Inline.Parent = Outline

			Outline.Parent = NewButton
			--
			Library:Connection(Inline.MouseButton1Down, function()
				Button.Callback()
				Value.TextColor3 = Library.Accent
				task.wait(0.1)
				Value.TextColor3 = Color3.fromRGB(255,255,255)
			end)

			function Button:Button(Properties)
				local Properties = Properties or {}
				local InButton = {
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
				--
				Outline.Size = UDim2.new(0.5, -4, 0, 16)
				local iOutline = Instance.new("Frame")
				iOutline.Name = "Outline"
				iOutline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				iOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iOutline.Position = UDim2.new(0.5, 4, 1, -16)
				iOutline.Size = UDim2.new(0.5, -4, 0, 16)
				iOutline.Parent = NewButton

				local iInline = Instance.new("TextButton")
				iInline.Name = "Inline"
				iInline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				iInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iInline.BorderSizePixel = 0
				iInline.Position = UDim2.new(0, 1, 0, 1)
				iInline.Size = UDim2.new(1, -2, 1, -2)
				iInline.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
				iInline.Text = ""
				iInline.TextColor3 = Color3.fromRGB(0, 0, 0)
				iInline.TextSize = 14
				iInline.AutoButtonColor = false

				local iValue = Instance.new("TextLabel")
				iValue.Name = "Value"
				iValue.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
				iValue.Text = InButton.Name
				iValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				iValue.TextSize = 12
				iValue.TextStrokeTransparency = 0
				iValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				iValue.BackgroundTransparency = 1
				iValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iValue.BorderSizePixel = 0
				iValue.Size = UDim2.new(1, 0, 1, 0)
				iValue.Parent = iInline

				iInline.Parent = iOutline

				--
				Library:Connection(iInline.MouseButton1Down, function()
					InButton.Callback()
					iValue.TextColor3 = Library.Accent
					task.wait(0.1)
					iValue.TextColor3 = Color3.fromRGB(255,255,255)
				end)
			end

			return Button
		end
		--
		function Pages:PlayerList(Properties)
			if not Properties then
				Properties = {}
			end
			--
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
			--
			local NewPlayer = Instance.new("Frame")
			NewPlayer.Name = "NewPlayer"
			NewPlayer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			NewPlayer.BorderColor3 = Color3.fromRGB(50,50,50)
			NewPlayer.BorderSizePixel = 1
			NewPlayer.Size = UDim2.new(1, 0, 0,342)
			NewPlayer.Parent = Playerlist.Page.Elements.Main
			
			local Outline4 = Instance.new("Frame")
			Outline4.Name = "Outline"
			Outline4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline4.BackgroundTransparency = 1
			Outline4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline4.BorderSizePixel = 0
			Outline4.Position = UDim2.new(0, -1, 0, -1)
			Outline4.Size = UDim2.new(1, 2, 1, 2)
			Outline4.Parent = NewPlayer

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Outline4

			local SectionTop = Instance.new("Frame")
			SectionTop.Name = "SectionTop"
			SectionTop.BackgroundColor3 = Color3.fromRGB(20,20,20)
			SectionTop.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTop.BorderSizePixel = 0
			SectionTop.Size = UDim2.new(1, 0, 0, 20)
			
			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 0, 1)
			Accent.Parent = SectionTop

			local SectionName = Instance.new("TextLabel")
			SectionName.Name = "SectionName"
			SectionName.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			SectionName.Text = "Player List"
			SectionName.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			List.BorderColor3 = Color3.fromRGB(50,50,50)
			List.BorderSizePixel = 1
			List.Position = UDim2.new(0, 5, 0, 25)
			List.Size = UDim2.new(1, -10, 0, 225)
			
			local Outline5 = Instance.new("Frame")
			Outline5.Name = "Outline"
			Outline5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline5.BackgroundTransparency = 1
			Outline5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline5.BorderSizePixel = 0
			Outline5.Position = UDim2.new(0, 4, 0, 24)
			Outline5.Size = UDim2.new(1, -8, 0, 227)
			Outline5.Parent = NewPlayer

			local UIStroke2 = Instance.new("UIStroke")
			UIStroke2.Name = "UIStroke"
			UIStroke2.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke2.Parent = Outline5

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = List

			List.Parent = NewPlayer

			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.Image = ""
			ImageLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ImageLabel.BorderColor3 = Color3.fromRGB(50,50,50)
			ImageLabel.Position = UDim2.new(0, 5, 1, -75)
			ImageLabel.Size = UDim2.new(0, 70, 0, 70)
			ImageLabel.Parent = NewPlayer
			
			local Outline8 = Instance.new("Frame")
			Outline8.Name = "Outline"
			Outline8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline8.BackgroundTransparency = 1
			Outline8.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline8.BorderSizePixel = 0
			Outline8.Position = UDim2.new(0,-1,0,-1)
			Outline8.Size = UDim2.new(1,2,1,2)
			Outline8.Parent = ImageLabel

			local UIStroke5 = Instance.new("UIStroke")
			UIStroke5.Name = "UIStroke"
			UIStroke5.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke5.Parent = Outline8

			local PlayerName1 = Instance.new("TextLabel")
			PlayerName1.Name = "PlayerName"
			PlayerName1.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			PlayerName1.Text = "Select a Player."
			PlayerName1.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Priority.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Priority.Text = ""
			Priority.TextColor3 = Color3.fromRGB(0, 0, 0)
			Priority.TextSize = 14
			Priority.AutoButtonColor = false
			Priority.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Priority.BorderColor3 = Color3.fromRGB(50,50,50)
			Priority.BorderSizePixel = 1
			Priority.Position = UDim2.new(1, -105, 1, -70)
			Priority.Size = UDim2.new(0, 100, 0, 25)
			
			local Outline6 = Instance.new("Frame")
			Outline6.Name = "Outline"
			Outline6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline6.BackgroundTransparency = 1
			Outline6.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline6.BorderSizePixel = 0
			Outline6.Position = UDim2.new(0,-1,0,-1)
			Outline6.Size = UDim2.new(1,2,1,2)
			Outline6.Parent = Priority

			local UIStroke3 = Instance.new("UIStroke")
			UIStroke3.Name = "UIStroke"
			UIStroke3.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke3.Parent = Outline6

			local PriorityLabel = Instance.new("TextLabel")
			PriorityLabel.Name = "PriorityLabel"
			PriorityLabel.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			PriorityLabel.Text = "Prioritize"
			PriorityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Friend.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Friend.Text = ""
			Friend.TextColor3 = Color3.fromRGB(0, 0, 0)
			Friend.TextSize = 14
			Friend.AutoButtonColor = false
			Friend.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Friend.BorderColor3 = Color3.fromRGB(50,50,50)
			Friend.BorderSizePixel = 1
			Friend.Position = UDim2.new(1, -105, 1, -34)
			Friend.Size = UDim2.new(0, 100, 0, 25)
			
			local Outline7 = Instance.new("Frame")
			Outline7.Name = "Outline"
			Outline7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Outline7.BackgroundTransparency = 1
			Outline7.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline7.BorderSizePixel = 0
			Outline7.Position = UDim2.new(0,-1,0,-1)
			Outline7.Size = UDim2.new(1,2,1,2)
			Outline7.Parent = Friend

			local UIStroke4 = Instance.new("UIStroke")
			UIStroke4.Name = "UIStroke"
			UIStroke4.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke4.Parent = Outline7

			local FriendLabel = Instance.new("TextLabel")
			FriendLabel.Name = "FriendLabel"
			FriendLabel.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			FriendLabel.Text = "Friendly"
			FriendLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			FriendLabel.TextSize = Library.FSize
			FriendLabel.TextStrokeTransparency = 0
			FriendLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			FriendLabel.BackgroundTransparency = 1
			FriendLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FriendLabel.BorderSizePixel = 0
			FriendLabel.Size = UDim2.new(1, 0, 1, 0)
			FriendLabel.Parent = Friend

			Friend.Parent = NewPlayer

			-- // Main
			local chosen = nil
			local optioninstances = {}
			local function handleoptionclick(option, button, accent)
				button.MouseButton1Click:Connect(function()
					chosen = option
					Library.Flags[Playerlist.Flag] = option
					Playerlist.CurrentPlayer = option
					--
					for opt, tbl in next, optioninstances do
						if opt ~= option then
							tbl.accent.Visible = false
						end
					end
					accent.Visible = true
					--
					if Playerlist.CurrentPlayer ~= Playerlist.LastPlayer then
						Playerlist.LastPlayer = Playerlist.CurrentPlayer;
						PlayerName1.Text = ("Id : %s\nDisplay Name : %s\nName : %s\nAccount Age : %s"):format(Playerlist.CurrentPlayer.UserId, Playerlist.CurrentPlayer.DisplayName ~= "" and Playerlist.CurrentPlayer.DisplayName or Playerlist.CurrentPlayer.Name, Playerlist.CurrentPlayer.Name, Playerlist.CurrentPlayer.AccountAge)
						--
						local imagedata = game:GetService("Players"):GetUserThumbnailAsync(Playerlist.CurrentPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

						ImageLabel.Image = imagedata
					end;
				end)
			end
			--
			local function createoptions(tbl)
				for i, option in next, tbl do
					optioninstances[option] = {}

					local NewPlayer1 = Instance.new("TextButton")
					NewPlayer1.Name = "NewPlayer"
					NewPlayer1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
					NewPlayer1.Text = ""
					NewPlayer1.TextColor3 = Color3.fromRGB(0, 0, 0)
					NewPlayer1.TextSize = 14
					NewPlayer1.AutoButtonColor = false
					NewPlayer1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					NewPlayer1.BorderColor3 = Color3.fromRGB(50,50,50)
					NewPlayer1.Size = UDim2.new(1, 0, 0, 15)

					local PlayerName = Instance.new("TextLabel")
					PlayerName.Name = "PlayerName"
					PlayerName.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
					PlayerName.Text = option.Name
					PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
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
					PlayerStatus.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
					PlayerStatus.Text = option == game.Players.LocalPlayer and "Local Player" or table.find(Library.Friends, option) and "Friendly" or table.find(Library.Priorities, option) and "Priority" or "None"
					PlayerStatus.TextColor3 = option == game.Players.LocalPlayer and Color3.fromRGB(0, 170, 255) or table.find(Library.Friends, option) and Color3.fromRGB(0,255,0) or table.find(Library.Priorities, option) and Color3.fromRGB(255,0,0) or Color3.fromRGB(255,255,255)
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
					
					if option == chosen then
						chosen = option
						Library.Flags[Playerlist.Flag] = option
						Playerlist.CurrentPlayer = option
						--
						for opt, tbl in next, optioninstances do
							if opt ~= option then
								tbl.accent.Visible = false
							end
						end
						AccentLine.Visible = true
						--
						if Playerlist.CurrentPlayer ~= Playerlist.LastPlayer then
							Playerlist.LastPlayer = Playerlist.CurrentPlayer;
							PlayerName1.Text = ("Id : %s\nDisplay Name : %s\nName : %s\nAccount Age : %s"):format(Playerlist.CurrentPlayer.UserId, Playerlist.CurrentPlayer.DisplayName ~= "" and Playerlist.CurrentPlayer.DisplayName or Playerlist.CurrentPlayer.Name, Playerlist.CurrentPlayer.Name, Playerlist.CurrentPlayer.AccountAge)
							--
							local imagedata = game:GetService("Players"):GetUserThumbnailAsync(Playerlist.CurrentPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

							ImageLabel.Image = imagedata
						end;
					end

					if option ~= game.Players.LocalPlayer then
						handleoptionclick(option, NewPlayer1, AccentLine)
					end
				end
			end
			--
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
					Playerlist.CurrentPlayer = chosen
				else
					chosen = nil
					Playerlist.CurrentPlayer = nil
				end
				Library.Flags[Playerlist.Flag] = chosen
			end
			--
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
					optioninstances[Playerlist.CurrentPlayer].status.TextColor3 = Color3.fromRGB(255,255,255)
				end
			end)
			--
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
					optioninstances[Playerlist.CurrentPlayer].status.TextColor3 = Color3.fromRGB(255,255,255)
				end
			end)
			--
			createoptions(game.Players:GetPlayers())
			--
			game.Players.PlayerAdded:Connect(function()
				Playerlist:Refresh(game.Players:GetPlayers(), true)
			end)
			--
			game.Players.PlayerRemoving:Connect(function()
				Playerlist:Refresh(game.Players:GetPlayers(), true)
			end)
			-- Fix
			Playerlist.Page.Elements.Left.Size = UDim2.new(0.5, -5,0.5, -80)
			Playerlist.Page.Elements.Right.Size = UDim2.new(0.5, -5,0.5, -80)
			Playerlist.Page.Elements.Left.Position = UDim2.new(0, 0,0.5, 85)
			Playerlist.Page.Elements.Right.Position = UDim2.new(0.5, 5,0.5, 85)
		end
		--
		function Sections:Divider(Properties)
			local Properties = Properties or {}
			local Divider = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or "divider",
			}
			--
			local NewDivider = Instance.new("TextButton")
			NewDivider.Name = "NewDivider"
			NewDivider.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewDivider.Text = ""
			NewDivider.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewDivider.TextSize = 14
			NewDivider.AutoButtonColor = false
			NewDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewDivider.BackgroundTransparency = 1
			NewDivider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewDivider.BorderSizePixel = 0
			NewDivider.Size = UDim2.new(1, 0, 0, 8)
			NewDivider.Parent = Divider.Section.Elements.SectionContent

			local Outline = Instance.new("Frame")
			Outline.Name = "Outline"
			Outline.AnchorPoint = Vector2.new(0, 0.5)
			Outline.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0, 0, 0.5, 0)
			Outline.Size = UDim2.new(1, 0, 0, 4)

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = Divider.Name
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = 12
			Value.TextStrokeTransparency = 0
			Value.AnchorPoint = Vector2.new(0.5, 0.5)
			Value.AutomaticSize = Enum.AutomaticSize.X
			Value.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0.5, 0, 0.5, 0)
			Value.Size = UDim2.new(0, 0, 0, 8)

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingLeft = UDim.new(0, 5)
			UIPadding.PaddingRight = UDim.new(0, 5)
			UIPadding.Parent = Value

			Value.Parent = Inline

			Inline.Parent = Outline

			Outline.Parent = NewDivider
			
			return Divider
		end
		--
		function Sections:Label(Properties)
			local Properties = Properties or {}
			local Label = {
				Window = self.Window,
				Page = self.Page,
				Section = self,
				Name = Properties.Name or "button",
			}
			--
			local NewButton = Instance.new("TextButton")
			NewButton.Name = "NewButton"
			NewButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewButton.Text = ""
			NewButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.TextSize = 14
			NewButton.AutoButtonColor = false
			NewButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewButton.BackgroundTransparency = 1
			NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.BorderSizePixel = 0
			NewButton.Size = UDim2.new(1, 0, 0, 8)
			NewButton.Parent = Label.Section.Elements.SectionContent

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
			Value.Text = Label.Name
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.TextColor3 = Color3.fromRGB(255,255,255)
			Value.TextSize = 12
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
		--
		function Library:Indicator(Properties)
			local Indicator = {
				Title = Properties.Name or Properties.name or "New Indicator";
				Elements = {};
				Dragging = { false, UDim2.new(0, 0, 0, 0) };
			};
			--
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
			Value.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
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
			
			-- // Dragging
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

				-- Dragging
				if Indicator.Dragging[1] then
					Outline.Position = UDim2.new(
						0,
						Location.X - Indicator.Dragging[2].X.Offset + (Outline.Size.X.Offset * Outline.AnchorPoint.X),
						0,
						Location.Y - Indicator.Dragging[2].Y.Offset + (Outline.Size.Y.Offset * Outline.AnchorPoint.Y)
					)
				end
			end)
			
			-- // Functions
			function Indicator:NewValue(Properties)
				local NewIndicator = {
					Name = Properties.Name or Properties.name or "New Value";
					Value = Properties.Value or Properties.value or "false";
				};
				--
				local NewInd = Instance.new("Frame")
				NewInd.Name = "NewInd"
				NewInd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NewInd.BackgroundTransparency = 1
				NewInd.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewInd.BorderSizePixel = 0
				NewInd.Size = UDim2.new(1, 0, 0, 15)

				local Title = Instance.new("TextLabel")
				Title.Name = "Title"
				Title.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
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
				IndValue.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
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
				
				-- // Functions
				function NewIndicator:UpdateValue(NewValue)
					IndValue.Text = tostring(NewValue)
				end
				
				return NewIndicator
			end
			--
			function Indicator:NewBar(Properties)
				local NewBarInd = {
					Name = Properties.Name or Properties.name or "New Value";
					Min = (Properties.min or Properties.Min or Properties.minimum or Properties.Minimum or 0);
					Max = (Properties.max or Properties.Max or Properties.maximum or Properties.Maximum or 100);
					State = (Properties.state or Properties.State or Properties.def or Properties.Def or Properties.default or Properties.Default or 0);
				};
				local TextValue = ("[value]")
				--
				local NewBar = Instance.new("Frame")
				NewBar.Name = "NewBar"
				NewBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NewBar.BackgroundTransparency = 1
				NewBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewBar.BorderSizePixel = 0
				NewBar.Size = UDim2.new(1, 0, 0, 25)

				local Title1 = Instance.new("TextLabel")
				Title1.Name = "Title"
				Title1.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
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
				IndValue1.FontFace = Font.new(Font:GetRegistry("UI_FONT"))
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

				-- // Functions
				function NewBarInd:UpdateValue(NewValue)
					NewValue = math.clamp(Library:Round(NewValue, 1), NewBarInd.Min, NewBarInd.Max)
					local sizeX = ((NewValue - NewBarInd.Min) / (NewBarInd.Max - NewBarInd.Min))
					Bar.Size = UDim2.new(sizeX, 0, 1, 0)
					IndValue1.Text = TextValue:gsub("%[value%]", string.format("%.14g", NewValue))
				end
				
				NewBarInd:UpdateValue(NewBarInd.State)

				return NewBarInd
			end
			--
			function Indicator:SetVisible(State)
				Outline.Visible = State
			end
			
			return Indicator
		end
		--
	end;
end;
return Library
