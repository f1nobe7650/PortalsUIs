-- This has not been tested on any other executors besides krampus (only tested in roblox studio)
-- I cannot guarantee everything works (ex. custom font which i removed)
-- Made by portal | example at bottom

if isfile("menu_plex.font") then
	delfile("menu_plex.font")
end

writefile("ProggyClean.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/ProggyClean.ttf"))

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

	Font:Register("menu_plex", 400, "normal", {Id = "ProggyClean.ttf", Font = ""});
end

local realfont = Font.new(Font:GetRegistry("menu_plex"))

local Library = {};
do
	Library = {
		Open = true;
		Accent = Color3.fromRGB(0, 170, 255);
		Pages = {};
		Sections = {};
		Flags = {};
		UnNamedFlags = 0;
		ThemeObjects = {};
		Holder = nil;
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
		Connections = {};
		UIKey = Enum.KeyCode.End;
		ScreenGUI = nil;
		FSize = 12;
		SettingsPage = nil;
		VisValues = {};
		Cooldown = false;
		Notifs = {};
		Friends = {};
		Priorities = {};
	}

	-- // Ignores
	local Flags = {}; -- Ignore
	local Dropdowns = {}; -- Ignore
	local Pickers = {}; -- Ignore
	local VisValues = {}; -- Ignore

	-- // Extension
	Library.__index = Library
	Library.Pages.__index = Library.Pages
	Library.Sections.__index = Library.Sections
	local LocalPlayer = game:GetService('Players').LocalPlayer;
	local Mouse = LocalPlayer:GetMouse();
	local TweenService = game:GetService("TweenService");

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
		function Library:RGBA(r, g, b, alpha)
			local rgb = Color3.fromRGB(r, g, b)
			--[[local mt = table.clone(getrawmetatable(rgb))

			setreadonly(mt, false)
			local old = mt.__index

			mt.__index = newcclosure(function(self, key)
				if key:lower() == "transparency" then
					return alpha
				end

				return old(self, key)
			end)

			setrawmetatable(rgb, mt)--]]

			return rgb
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
			Icon.BorderColor3 = Color3.fromRGB(0,0,0)
			Icon.BorderSizePixel = 1
			if count == 1 then
				Icon.Position = UDim2.new(1, - (count * 22),0.5,0)
			else
				Icon.Position = UDim2.new(1, - (count * 22) - (count * 4),0.5,0)
			end
			Icon.Size = UDim2.new(0, 22, 0, 10)
			Icon.Text = ""
			Icon.AutoButtonColor = false

			local IconInline = Instance.new("Frame")
			IconInline.Name = "IconInline"
			IconInline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			IconInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			IconInline.BorderSizePixel = 0
			IconInline.BackgroundTransparency = 1
			IconInline.Position = UDim2.new(0, 2, 0, 2)
			IconInline.Size = UDim2.new(1, -4, 1, -4)
			IconInline.Parent = Icon

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(30, 30, 30)
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Parent = Icon
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8

			local UIStroke6 = Instance.new("UIStroke")
			UIStroke6.Name = "UIStroke"
			UIStroke6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke6.Color = Color3.fromRGB(30, 30, 30)
			UIStroke6.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke6.Parent = IconInline
			UIStroke6.Thickness = 2
			UIStroke6.Transparency = 0.7
			--
			local ColorOutline = Instance.new("Frame")
			ColorOutline.Name = "ColorOutline"
			ColorOutline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			ColorOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ColorOutline.Position = UDim2.new(0,30,0,-20)
			ColorOutline.Size = UDim2.new(0, 184, 0, 182)
			ColorOutline.Visible = false
			ColorOutline.Parent = Icon

			local ColorInline = Instance.new("Frame")
			ColorInline.Name = "ColorInline"
			ColorInline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			ColorInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ColorInline.BorderSizePixel = 0
			ColorInline.Position = UDim2.new(0, 2, 0, 2)
			ColorInline.Size = UDim2.new(1, -4, 1, -4)

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Accent.Size = UDim2.new(1, 0, 0, 2)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			Accent.Parent = ColorInline

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 4, 0, 3)
			Title.Size = UDim2.new(1, 0, 0, 16)
			Title.Parent = ColorInline

			local TextButton = Instance.new("Frame")
			TextButton.Name = "TextButton"
			TextButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextButton.Position = UDim2.new(0, 6, 0, 22)
			TextButton.Size = UDim2.new(0, 150, 0, 150)

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = TextButton

			local Val = Instance.new("ImageButton")
			Val.Name = "Val"
			Val.Image = "http://www.roblox.com/asset/?id=14684562507"
			Val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Val.BackgroundTransparency = 1
			Val.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Val.BorderSizePixel = 0
			Val.Size = UDim2.new(1, 0, 1, 0)
			Val.Parent = TextButton
			Val.ZIndex = 100

			local Sat = Instance.new("ImageButton")
			Sat.Name = "Sat"
			Sat.Image = "http://www.roblox.com/asset/?id=14684563800"
			Sat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Sat.BackgroundTransparency = 1
			Sat.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Sat.BorderSizePixel = 0
			Sat.Size = UDim2.new(1, 0, 1, 0)
			Sat.Parent = TextButton
			Sat.ZIndex = 100

			local Hue = Instance.new("ImageButton")
			Hue.Name = "Hue"
			Hue.Image = "http://www.roblox.com/asset/?id=14684557999"
			Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hue.Position = UDim2.new(0, 158, 0, 0)
			Hue.Size = UDim2.new(0, 10, 0, 150)

			local UIStroke1 = Instance.new("UIStroke")
			UIStroke1.Name = "UIStroke"
			UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke1.Thickness = 2
			UIStroke1.Transparency = 0.8
			UIStroke1.Parent = Hue

			local HueSlide = Instance.new("Frame")
			HueSlide.Name = "HueSlide"
			HueSlide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueSlide.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HueSlide.Position = UDim2.new(0, -2, 0, 0)
			HueSlide.Size = UDim2.new(1, 4, 0, 4)
			local H,S,V = default:ToHSV()
			local HueAccent = Instance.new("Frame")
			HueAccent.Name = "HueAccent"
			HueAccent.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
			HueAccent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HueAccent.BorderSizePixel = 0
			HueAccent.Position = UDim2.new(0, 1, 0, 1)
			HueAccent.Size = UDim2.new(1, -2, 1, -2)
			HueAccent.Parent = HueSlide

			HueSlide.Parent = Hue

			Hue.Parent = TextButton

			local Square = Instance.new("Frame")
			Square.Name = "Square"
			Square.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Square.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Square.Size = UDim2.new(0, 4, 0, 4)
			Square.Parent = TextButton
			Square.ZIndex = 100

			local SquareAccent = Instance.new("Frame")
			SquareAccent.Name = "SquareAccent"
			SquareAccent.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
			SquareAccent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SquareAccent.BorderSizePixel = 0
			SquareAccent.Position = UDim2.new(0, 1, 0, 1)
			SquareAccent.Size = UDim2.new(1, -2, 1, -2)
			SquareAccent.Parent = Square

			TextButton.Parent = ColorInline

			ColorInline.Parent = ColorOutline

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
				local relative_palette = (mouse_position - TextButton.AbsolutePosition)
				local relative_hue     = (mouse_position - Hue.AbsolutePosition)
				--
				if slidingsaturation then
					sat = math.clamp(1 - relative_palette.X / TextButton.AbsoluteSize.X, 0, 1)
					val = math.clamp(1 - relative_palette.Y / TextButton.AbsoluteSize.Y, 0, 1)
				elseif slidinghue then
					hue = math.clamp(relative_hue.Y / Hue.AbsoluteSize.Y, 0, 1)
				end

				hsv = Color3.fromHSV(hue, sat, val)
				TextButton.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				HueAccent.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				Icon.BackgroundColor3 = hsv
				SquareAccent.BackgroundColor3 = hsv

				HueSlide.Position = UDim2.new(0,-2,math.clamp(hue, 0.005, 0.990),0)
				Square.Position = UDim2.new(math.clamp(1 - sat, 0.000, 1 - 0.030), 0, math.clamp(1 - val, 0.000, 1 - 0.030), 0)

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
					TextButton.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					HueAccent.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					SquareAccent.BackgroundColor3 = hsv
					HueSlide.Position = UDim2.new(0,-2,math.clamp(hue, 0.005, 0.990),0)
					Square.Position = UDim2.new(math.clamp(1 - sat, 0.000, 1 - 0.030), 0, math.clamp(1 - val, 0.000, 1 - 0.030), 0)

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

			Library:Connection(game:GetService("UserInputService").InputChanged, function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then

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
				if ColorOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ColorOutline) and not Library:IsMouseOverFrame(Icon) then
						ColorOutline.Visible = false
						parent.ZIndex = 1
					end
				end
			end)

			Icon.MouseButton1Down:Connect(function()
				ColorOutline.Visible = true
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

			return colorpickertypes, ColorOutline
		end
	end

	function Library:NewInstance(Inst, Theme)
		local Obj = Instance.new(Inst)
		if Theme then
			table.insert(Library.ThemeObjects, Obj)
			if Obj:IsA("Frame") or Obj:IsA("TextButton") or Obj:IsA("ScrollingFrame") then
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
			end;
		end;
		return Obj;
	end;

	function Library:updateNotifsPositions(position)
		for i, v in pairs(Library.Notifs) do 
			local Position = Vector2.new(20, 20)
			game:GetService("TweenService"):Create(v.Container, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0,Position.X,0,Position.Y + (i * 25))}):Play()
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
		NotifContainer.Size = UDim2.new(0,120,0,16)
		NotifContainer.BackgroundColor3 = Color3.new(1,1,1)
		NotifContainer.BackgroundTransparency = 1
		NotifContainer.BorderSizePixel = 0
		NotifContainer.BorderColor3 = Color3.new(0,0,0)
		NotifContainer.ZIndex = 99999999
		notification.Container = NotifContainer

		local Notif = Instance.new("Frame")
		Notif.Name = "Notif"
		Notif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Notif.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notif.Position = UDim2.new(0, 0, 0, 0)
		Notif.AutomaticSize = Enum.AutomaticSize.X
		Notif.Size = UDim2.new(0,120,0,18)
		Notif.Parent = NotifContainer
		Notif.BackgroundTransparency = 1
		table.insert(notification.Objects, Notif)

		local DisabledGradient = Instance.new("UIGradient")
		DisabledGradient.Name = "DisabledGradient"
		DisabledGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
		})
		DisabledGradient.Rotation = 90
		DisabledGradient.Parent = Notif

		local UIStroke = Instance.new("UIStroke")
		UIStroke.Name = "UIStroke"
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
		UIStroke.Thickness = 2
		UIStroke.Transparency = 1
		UIStroke.Parent = Notif
		table.insert(notification.Objects, UIStroke)

		local Value = Instance.new("TextLabel")
		Value.Name = "Value"
		Value.FontFace = realfont
		Value.Text = message
		Value.TextColor3 = Color3.fromRGB(255, 255, 255)
		Value.TextSize = Library.FSize
		Value.TextStrokeTransparency = 0
		Value.TextTransparency = 1
		Value.TextXAlignment = Enum.TextXAlignment.Left
		Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Value.BackgroundTransparency = 1
		Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Value.BorderSizePixel = 0
		Value.Position = UDim2.new(0, 6, 0, 0)
		Value.Size = UDim2.new(0,0, 1, 0)
		Value.Parent = Notif
		Value.AutomaticSize = Enum.AutomaticSize.X
		table.insert(notification.Objects, Value)

		local UIPadding = Instance.new("UIPadding")
		UIPadding.Name = "UIPadding"
		UIPadding.PaddingRight = UDim.new(0, 6)
		UIPadding.Parent = Notif

		local Accent = Instance.new("Frame")
		Accent.Name = "Accent"
		Accent.BackgroundColor3 = color ~= nil and color or Library.Accent
		Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
		Accent.Size = UDim2.new(0,2,1,0)
		Accent.BackgroundTransparency = 1
		table.insert(notification.Objects, Accent)

		local UIGradient = Instance.new("UIGradient")
		UIGradient.Name = "UIGradient"
		UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
		})
		UIGradient.Rotation = 0
		UIGradient.Parent = Accent

		Accent.Parent = Notif


		function notification:remove()
			table.remove(Library.Notifs, table.find(Library.Notifs, notification))
			Library:updateNotifsPositions(Position)
			task.wait(0.5)
			notification.Container:Destroy()
		end

		task.spawn(function()
			Notif.AnchorPoint = Vector2.new(1,0)
			for i,v in next, notification.Objects do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				elseif v:IsA("UIStroke") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 0.8}):Play()
				end
			end
			local Tween1 = game:GetService("TweenService"):Create(Notif, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(0,0)}):Play()
			game:GetService("TweenService"):Create(Value, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			task.wait(duration)
			game:GetService("TweenService"):Create(Notif, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(1,0)}):Play()
			for i,v in next, notification.Objects do
				if v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				elseif v:IsA("UIStroke") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = 1}):Play()
				end
			end
			game:GetService("TweenService"):Create(Value, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
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
				Dragging = { false, UDim2.new(0, 0, 0, 0) };
				Name = Options.Name or "Monlith";
			};
			--
			local ScreenGui = Instance.new("ScreenGui", game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer.PlayerGui or game.CoreGui)
			ScreenGui.Name = "ScreenGui"
			ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			Library.ScreenGUI = ScreenGui
			ScreenGui.DisplayOrder = 100

			local Outline = Instance.new("TextButton")
			Outline.Name = "Outline"
			Outline.AnchorPoint = Vector2.new(0.5, 0.5)
			Outline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.Position = UDim2.new(0.5, 0, 0.5, 0)
			Outline.Size = UDim2.new(0, 500, 0, 600)
			Library.Holder = Outline
			Outline.Text = ""
			Outline.AutoButtonColor = false

			local Inline = Instance.new("Frame")
			Inline.Name = "Inline"
			Inline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			local HolderOutline = Instance.new("Frame")
			HolderOutline.Name = "HolderOutline"
			HolderOutline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			HolderOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HolderOutline.Position = UDim2.new(0, 6, 0, 22)
			HolderOutline.Size = UDim2.new(1, -12, 1, -28)

			local HolderInline = Instance.new("Frame")
			HolderInline.Name = "HolderInline"
			HolderInline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			HolderInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HolderInline.BorderSizePixel = 0
			HolderInline.Position = UDim2.new(0, 2, 0, 2)
			HolderInline.Size = UDim2.new(1, -4, 1, -4)

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Accent.BorderSizePixel = 0
			Accent.Position = UDim2.new(0, 0, 0, 0)
			Accent.Size = UDim2.new(1, 0, 0, 1)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			Accent.Parent = HolderInline

			local Tabs = Instance.new("Frame")
			Tabs.Name = "Tabs"
			Tabs.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Tabs.BorderSizePixel = 0
			Tabs.Position = UDim2.new(0, 0, 0, 1)
			Tabs.Size = UDim2.new(1, 0, 0, 34)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Tabs

			Tabs.Parent = HolderInline

			HolderInline.Parent = HolderOutline

			HolderOutline.Parent = Inline

			local Accent1 = Library:NewInstance("Frame", true)
			Accent1.Name = "Accent"
			Accent1.BackgroundColor3 = Library.Accent
			Accent1.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Accent1.Size = UDim2.new(1, 0, 0, 1)

			local UIGradient1 = Instance.new("UIGradient")
			UIGradient1.Name = "UIGradient"
			UIGradient1.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient1.Rotation = 90
			UIGradient1.Parent = Accent1

			Accent1.Parent = Inline

			local TopGradient = Instance.new("Frame")
			TopGradient.Name = "TopGradient"
			TopGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TopGradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TopGradient.BorderSizePixel = 0
			TopGradient.Position = UDim2.new(0, 0, 0, 3)
			TopGradient.Size = UDim2.new(1, 0, 0, 17)

			local UIGradient2 = Instance.new("UIGradient")
			UIGradient2.Name = "UIGradient"
			UIGradient2.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35)),
			})
			UIGradient2.Rotation = 90
			UIGradient2.Parent = TopGradient

			TopGradient.Parent = Inline

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Window.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 4, 0, 3)
			Title.Size = UDim2.new(1, 0, 0, 16)
			Title.Parent = Inline

			Inline.Parent = Outline

			Outline.Parent = ScreenGui

			local FadeThing = Instance.new("Frame")
			FadeThing.Name = "FadeThing"
			FadeThing.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			FadeThing.BackgroundTransparency = 1
			FadeThing.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FadeThing.BorderSizePixel = 0
			FadeThing.Position = UDim2.new(0, 8, 0, 41)
			FadeThing.Size = UDim2.new(1, -16, 1, -49)
			FadeThing.Parent = HolderInline
			FadeThing.Visible = false
			FadeThing.ZIndex = 100

			-- // Elements
			Window.Elements = {
				TabHolder = Tabs,
				Holder = HolderInline,
				FadeThing = FadeThing
			}

			-- // Dragging
			Library:Connection(Outline.MouseButton1Down, function()
				local Location = game:GetService("UserInputService"):GetMouseLocation()
				Window.Dragging[1] = true
				Window.Dragging[2] = UDim2.new(0, Location.X - Outline.AbsolutePosition.X, 0, Location.Y - Outline.AbsolutePosition.Y)
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
					Outline.Position = UDim2.new(
						0,
						Location.X - Window.Dragging[2].X.Offset + (Outline.Size.X.Offset * Outline.AnchorPoint.X),
						0,
						Location.Y - Window.Dragging[2].Y.Offset + (Outline.Size.Y.Offset * Outline.AnchorPoint.Y)
					)
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if Input.KeyCode == Library.UIKey then
					Library:SetOpen(not Library.Open)
				end
			end)

			-- // Functions
			function Window:UpdateTabs()
				for Index, Page in pairs(Window.Pages) do
					Page:Turn(Page.Open)
					Page.Elements.PageButton.Size = UDim2.new(1/#Window.Pages,0,1,0)
					Page.Elements.PageFrame.Size = UDim2.new(1,Index == 1 and -1 or Index == #Window.Pages and -1 or -2,1,Page.Open and -2 or -4)
					Page.Elements.PageFrame.Position = UDim2.new(0,Index == 1 and 0 or 1,0,2)
				end
			end

			function Window:KeyList() -- finobe wanted me to paste off eclipse incase this ever gets leaked LOL
				local NKeyList = {Keybinds = {}};
				Library.KeyList = NKeyList;
				--
				local KeyList = Instance.new("Frame")
				KeyList.Name = "KeyList"
				KeyList.AnchorPoint = Vector2.new(0, 0.5)
				KeyList.AutomaticSize = Enum.AutomaticSize.XY
				KeyList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				KeyList.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KeyList.Position = UDim2.new(0, 20, 0.5, 0)
				KeyList.Size = UDim2.new(0, 0, 0, 18)
				KeyList.Parent = ScreenGui
				KeyList.Visible = false

				local DisabledGradient = Instance.new("UIGradient")
				DisabledGradient.Name = "DisabledGradient"
				DisabledGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
				})
				DisabledGradient.Rotation = 90
				DisabledGradient.Parent = KeyList

				local UIStroke = Instance.new("UIStroke")
				UIStroke.Name = "UIStroke"
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
				UIStroke.Thickness = 2
				UIStroke.Transparency = 0.8
				UIStroke.Parent = KeyList

				local Value = Instance.new("TextLabel")
				Value.Name = "Value"
				Value.FontFace = realfont
				Value.Text = "Keybinds"
				Value.TextColor3 = Color3.fromRGB(255, 255, 255)
				Value.TextSize = Library.FSize
				Value.TextStrokeTransparency = 0
				Value.TextXAlignment = Enum.TextXAlignment.Left
				Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Value.BackgroundTransparency = 1
				Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderSizePixel = 0
				Value.Position = UDim2.new(0, 4, 0, 0)
				Value.Size = UDim2.new(0, 100, 0, 20)
				Value.Parent = KeyList

				local UIPadding = Instance.new("UIPadding")
				UIPadding.Name = "UIPadding"
				UIPadding.PaddingRight = UDim.new(0, 6)
				UIPadding.Parent = KeyList

				local Accent = Library:NewInstance("Frame", true)
				Accent.Name = "Accent"
				Accent.BackgroundColor3 = Library.Accent
				Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
				Accent.Size = UDim2.new(1, 6, 0, 2)

				local UIGradient = Instance.new("UIGradient")
				UIGradient.Name = "UIGradient"
				UIGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
				})
				UIGradient.Rotation = 90
				UIGradient.Parent = Accent

				Accent.Parent = KeyList

				local Content = Instance.new("Frame")
				Content.Name = "Content"
				Content.AutomaticSize = Enum.AutomaticSize.XY
				Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Content.BackgroundTransparency = 1
				Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Content.BorderSizePixel = 0
				Content.Position = UDim2.new(0, 10, 0, 20)

				local UIPadding1 = Instance.new("UIPadding")
				UIPadding1.Name = "UIPadding"
				UIPadding1.PaddingBottom = UDim.new(0, 5)
				UIPadding1.PaddingRight = UDim.new(0, 5)
				UIPadding1.Parent = Content

				local UIListLayout = Instance.new("UIListLayout")
				UIListLayout.Name = "UIListLayout"
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Parent = Content

				Content.Parent = KeyList

				-- Functions
				function NKeyList:SetVisible(State)
					KeyList.Visible = State;
				end;
				--
				function NKeyList:NewKey(Name,Page)
					local KeyValue = {}
					--
					local NewKey = Instance.new("TextLabel")
					NewKey.Name = "NewKey"
					NewKey.FontFace = realfont
					NewKey.Text = Page .. ": " .. Name
					NewKey.TextColor3 = Color3.fromRGB(255, 255, 255)
					NewKey.TextSize = Library.FSize
					NewKey.TextStrokeTransparency = 0
					NewKey.TextXAlignment = Enum.TextXAlignment.Left
					NewKey.AutomaticSize = Enum.AutomaticSize.XY
					NewKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					NewKey.BackgroundTransparency = 1
					NewKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
					NewKey.BorderSizePixel = 0
					NewKey.Position = UDim2.new(0, 4, 0, 0)
					NewKey.Size = UDim2.new(0, 100, 0, 20)
					NewKey.Parent = Content
					NewKey.Visible = false
					--
					function KeyValue:SetVisible(State)
						NewKey.Visible = State;
					end;
					return KeyValue
				end;
				return NKeyList
			end
			Window:KeyList()

			function Window:UpdateTitle(str)
				Title.Text = str
			end

			-- // Returns
			return setmetatable(Window, Library)
		end;
		--
		function Library:Page(Properties)
			if not Properties then
				Properties = {}
			end
			--
			local Page = {
				Name = Properties.Name or "Page",
				Window = self,
				Open = false,
				Sections = {},
				Elements = {},
			}
			--
			local NewPage = Instance.new("TextButton")
			NewPage.Name = "NewPage"
			NewPage.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			NewPage.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewPage.TextSize = 14
			NewPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewPage.BackgroundTransparency = 1
			NewPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewPage.BorderSizePixel = 0
			NewPage.Size = UDim2.new(0.2, 0, 1, 0)
			NewPage.Parent = Page.Window.Elements.TabHolder

			local Frame = Instance.new("Frame")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0, 1, 0, 2)
			Frame.Size = UDim2.new(1, -2, 1, -4)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35)),
			})
			UIGradient.Enabled = false
			UIGradient.Rotation = 90
			UIGradient.Parent = Frame

			local TextLabel = Instance.new("TextLabel")
			TextLabel.Name = "TextLabel"
			TextLabel.FontFace = realfont
			TextLabel.Text = Page.Name
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = Library.FSize
			TextLabel.TextStrokeTransparency = 0
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0, 0, 0, -1)
			TextLabel.Size = UDim2.new(1, 0, 0, 32)
			TextLabel.Parent = Frame

			Frame.Parent = NewPage

			local RealPage = Instance.new("Frame")
			RealPage.Name = "RealPage"
			RealPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			RealPage.BackgroundTransparency = 1
			RealPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			RealPage.BorderSizePixel = 0
			RealPage.Position = UDim2.new(0, 8, 0, 41)
			RealPage.Size = UDim2.new(1, -16, 1, -49)
			RealPage.Parent = Page.Window.Elements.Holder
			RealPage.Visible = false

			local Left = Instance.new("Frame")
			Left.Name = "Left"
			Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Left.BackgroundTransparency = 1
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.Size = UDim2.new(0.5, -6, 1, 0)
			Left.ZIndex = 2

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 10)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = Left

			Left.Parent = RealPage

			local Right = Instance.new("Frame")
			Right.Name = "Right"
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.Position = UDim2.new(0.5, 6, 0, 0)
			Right.Size = UDim2.new(0.5, -6, 1, 0)

			local UIListLayout1 = Instance.new("UIListLayout")
			UIListLayout1.Name = "UIListLayout"
			UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout1.Parent = Right
			UIListLayout1.Padding = UDim.new(0, 10)

			Right.Parent = RealPage

			function Page:Turn(bool)
				if not Library.Cooldown then
					Page.Open = bool
					UIGradient.Enabled = Page.Open and true or false
					Frame.BackgroundColor3 = Page.Open and Color3.new(1,1,1) or Color3.fromRGB(30,30,30)
					--
					task.spawn(function()
						Page.Window.Elements.FadeThing.Visible = true
						TweenService:Create(Page.Window.Elements.FadeThing, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
						task.wait(0.1)
						RealPage.Visible = Page.Open
						TweenService:Create(Page.Window.Elements.FadeThing, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
						task.wait(0.1)
						Page.Window.Elements.FadeThing.Visible = false
					end)
					--
					for Index, Page in pairs(Page.Window.Pages) do
						Page.Elements.PageFrame.Size = UDim2.new(1,Index == 1 and -1 or Index == #Page.Window.Pages and -1 or -2,1,Page.Open and -2 or -4)
						Page.Elements.PageFrame.Position = UDim2.new(0,Index == 1 and 0 or 1,0,2)
					end
				end
			end
			--
			Library:Connection(NewPage.MouseButton1Down, function()
				if not Page.Open then
					Page:Turn(true)
					for _, Pages in pairs(Page.Window.Pages) do
						if Pages.Open and Pages ~= Page then
							Pages:Turn(false)
						end
					end
				end
			end)

			-- // Elements
			Page.Elements = {
				Left = Left,
				Right = Right,
				RealPage = RealPage,
				PageButton = NewPage,
				PageFrame = Frame,
			}

			-- // Drawings
			if #Page.Window.Pages == 0 then
				Page:Turn(true)
			end
			Page.Window.Pages[#Page.Window.Pages + 1] = Page
			Page.Window:UpdateTabs()
			return setmetatable(Page, Library.Pages)
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
				AutoSize = (Properties.AutoSize or Properties.autosize or false),
				Size = (Properties.Size or Properties.size or 100),
				Zindex = (Properties.Zindex or Properties.zindex or 1),
				Elements = {},
				Content = {},
				Sections = {},
			}
			--
			local SectionOutline = Instance.new("Frame")
			SectionOutline.Name = "SectionOutline"
			SectionOutline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			SectionOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionOutline.Size = UDim2.new(1, 0, 0, Section.Size)
			SectionOutline.AutomaticSize = Section.AutoSize and Enum.AutomaticSize.Y or Enum.AutomaticSize.None
			SectionOutline.ZIndex = Section.Zindex
			SectionOutline.Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right

			local SectionInline = Instance.new("Frame")
			SectionInline.Name = "SectionInline"
			SectionInline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			SectionInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionInline.BorderSizePixel = 0
			SectionInline.Position = UDim2.new(0, 1, 0, 1)
			SectionInline.Size = UDim2.new(1, -2, 1, -2)

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Accent.BorderSizePixel = 0
			Accent.Position = UDim2.new(0, 0, 0, 0)
			Accent.Size = UDim2.new(1, 0, 0, 1)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			local BlackLine = Instance.new("Frame")
			BlackLine.Name = "BlackLine"
			BlackLine.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			BlackLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BlackLine.BorderSizePixel = 0
			BlackLine.Position = UDim2.new(0, 0, 1, 0)
			BlackLine.Size = UDim2.new(1, 0, 0, 2)
			BlackLine.Parent = Accent

			Accent.Parent = SectionInline

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Section.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 4, 0, 3)
			Title.Size = UDim2.new(1, 0, 0, 16)
			Title.Parent = SectionInline

			local SectionContent = Instance.new("Frame")
			SectionContent.Name = "SectionContent"
			SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContent.BackgroundTransparency = 1
			SectionContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionContent.BorderSizePixel = 0
			SectionContent.Position = UDim2.new(0, 10, 0, 24)
			SectionContent.Size = UDim2.new(1, -20, 1, -30)

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 12)
			UIPadding.Parent = SectionContent

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.Padding = UDim.new(0, 10)
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = SectionContent

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
		function Pages:MultiSection(Properties)
			if not Properties then
				Properties = {}
			end
			--
			local Section = {
				Sections = (Properties.sections or Properties.Sections or {}),
				Page = self,
				Side = (Properties.side or Properties.Side or "left"):lower(),
				Size = (Properties.Size or Properties.size or 100),
				Zindex = (Properties.Zindex or Properties.zindex or 1),
				Elements = {},
				Content = {},
				ActualSections = {};
			}
			--
			local SectionOutline = Instance.new("Frame")
			SectionOutline.Name = "SectionOutline"
			SectionOutline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			SectionOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionOutline.Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right
			SectionOutline.Size = UDim2.new(1, 0, 0, Section.Size)
			SectionOutline.ZIndex = Section.Zindex


			local SectionInline = Instance.new("Frame")
			SectionInline.Name = "SectionInline"
			SectionInline.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			SectionInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionInline.BorderSizePixel = 0
			SectionInline.Position = UDim2.new(0, 1, 0, 1)
			SectionInline.Size = UDim2.new(1, -2, 1, -2)

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Accent.BorderSizePixel = 0
			Accent.Position = UDim2.new(0, 0, 0, 0)
			Accent.Size = UDim2.new(1, 0, 0, 1)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			local BlackLine = Instance.new("Frame")
			BlackLine.Name = "BlackLine"
			BlackLine.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			BlackLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BlackLine.BorderSizePixel = 0
			BlackLine.Position = UDim2.new(0, 0, 1, 0)
			BlackLine.Size = UDim2.new(1, 0, 0, 2)
			BlackLine.Parent = Accent

			Accent.Parent = SectionInline

			local Tabs = Instance.new("Frame")
			Tabs.Name = "Tabs"
			Tabs.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Tabs.BorderSizePixel = 0
			Tabs.Position = UDim2.new(0, 0, 0, 1)
			Tabs.Size = UDim2.new(1, 0, 0, 20)

			local UIListLayout1 = Instance.new("UIListLayout")
			UIListLayout1.Name = "UIListLayout"
			UIListLayout1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout1.Parent = Tabs

			Tabs.Parent = SectionInline

			SectionInline.Parent = SectionOutline

			local FadeThing = Instance.new("Frame")
			FadeThing.Name = "FadeThing"
			FadeThing.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			FadeThing.BackgroundTransparency = 1
			FadeThing.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FadeThing.BorderSizePixel = 0
			FadeThing.Position = UDim2.new(0, 10, 0, 29)
			FadeThing.Size = UDim2.new(1, -20, 1, -35)
			FadeThing.Parent = SectionInline
			FadeThing.Visible = false
			FadeThing.ZIndex = 100

			-- // Elements
			Section.Elements = {
				Top = Tabs;
			}
			local SectionShit = Section.Sections;
			local SectionShit2 = Section;
			local SectionButtons = {};


			for I, V in next, SectionShit do
				local MultiSection = {
					Window = self.Window,
					Page = self,
					Open = false,
					Content = {},
					NoUpdate = true,
					ContentAxis = 0;
					Elements = {};
				};

				-- // Drawings
				local NewPage = Instance.new("TextButton")
				NewPage.Name = "NewPage"
				NewPage.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
				NewPage.TextColor3 = Color3.fromRGB(0, 0, 0)
				NewPage.TextSize = 14
				NewPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NewPage.BackgroundTransparency = 1
				NewPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NewPage.BorderSizePixel = 0
				NewPage.Size = UDim2.new(0.2, 0, 1, 0)
				NewPage.Parent = Tabs

				local Frame = Instance.new("Frame")
				Frame.Name = "Frame"
				Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Frame.BorderColor3 = Color3.fromRGB(20,20,20)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(0, 0, 0, 2)
				Frame.Size = UDim2.new(1, 0,1, -2)

				local UIGradient = Instance.new("UIGradient")
				UIGradient.Name = "UIGradient"
				UIGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35)),
				})
				UIGradient.Enabled = false
				UIGradient.Rotation = 90
				UIGradient.Parent = Frame

				local TextLabel = Instance.new("TextLabel")
				TextLabel.Name = "TextLabel"
				TextLabel.FontFace = realfont
				TextLabel.Text = V
				TextLabel.TextColor3 = Color3.fromRGB(145,145,145)
				TextLabel.TextSize = Library.FSize
				TextLabel.TextStrokeTransparency = 0
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0, 0, 0, -1)
				TextLabel.Size = UDim2.new(1, 0, 0, 18)
				TextLabel.Parent = Frame

				Frame.Parent = NewPage

				local SectionContent = Instance.new("Frame")
				SectionContent.Name = "SectionContent"
				SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SectionContent.BackgroundTransparency = 1
				SectionContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SectionContent.BorderSizePixel = 0
				SectionContent.Position = UDim2.new(0, 10, 0, 29)
				SectionContent.Size = UDim2.new(1, -20, 1, -35)
				SectionContent.Visible = false

				local UIListLayout = Instance.new("UIListLayout")
				UIListLayout.Name = "UIListLayout"
				UIListLayout.Padding = UDim.new(0, 11)
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.Parent = SectionContent

				local UIPadding = Instance.new("UIPadding")
				UIPadding.Name = "UIPadding"
				UIPadding.PaddingBottom = UDim.new(0, 12)
				UIPadding.Parent = SectionContent

				SectionContent.Parent = SectionInline

				table.insert(SectionButtons, NewPage)


				-- // Update
				for Index, RSection in next, SectionButtons do
					RSection.Size = UDim2.new(1 / #SectionButtons, 0, 1, 0)
				end;

				-- // Open MultiSection
				function MultiSection:Turn(bool)
					MultiSection.Open = bool
					UIGradient.Enabled = MultiSection.Open and true or false
					Frame.BackgroundColor3 = MultiSection.Open and Color3.new(1,1,1) or Color3.fromRGB(30,30,30)
					TextLabel.TextColor3 = MultiSection.Open and Color3.new(1,1,1) or Color3.fromRGB(145,145,145)
					Frame.BorderSizePixel = MultiSection.Open and 0 or 1
					--
					task.spawn(function()
						FadeThing.Visible = true
						TweenService:Create(FadeThing, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
						task.wait(0.1)
						SectionContent.Visible = MultiSection.Open
						TweenService:Create(FadeThing, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
						task.wait(0.1)
						FadeThing.Visible = false
					end)
					--
					for Index, V in pairs(Section.ActualSections) do
						if #Section.ActualSections == 3 or #Section.ActualSections == 4 then
							V.Elements.PageFrame.Size = UDim2.new(1,Index == 1 and -1 or Index == #Section.ActualSections and -1 or 0,1,V.Open and -2 or -3)
							V.Elements.PageFrame.Position = UDim2.new(0,Index == #Section.ActualSections and 1 or 0,0,2)
						else
							V.Elements.PageFrame.Size = UDim2.new(1,Index == 1 and -1 or 0,1,V.Open and -2 or -3)
							V.Elements.PageFrame.Position = UDim2.new(0,0,0,2)
						end
					end
				end;

				Library:Connection(NewPage.MouseButton1Down, function()
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
					PageFrame = Frame;
					SectionContent = SectionContent;
				};

				-- // Returning
				SectionShit2.ActualSections[#SectionShit2.ActualSections + 1] = setmetatable(MultiSection, Library.Sections)
			end;

			-- // Returning
			Section.Page.Sections[#Section.Page.Sections + 1] = Section;
			Section.ActualSections[1]:Turn(true)
			return table.unpack(Section.ActualSections)
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
			NewToggle.Size = UDim2.new(1, 0, 0, 8)
			NewToggle.Parent = Toggle.Section.Elements.SectionContent

			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.Size = UDim2.new(0, 8, 0, 8)

			local DisabledGradient = Instance.new("UIGradient")
			DisabledGradient.Name = "DisabledGradient"
			DisabledGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient.Rotation = 90
			DisabledGradient.Parent = ToggleFrame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = ToggleFrame

			local ToggleAccent = Library:NewInstance("Frame", true)
			ToggleAccent.Name = "ToggleAccent"
			ToggleAccent.BackgroundColor3 = Library.Accent
			ToggleAccent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleAccent.BorderSizePixel = 0
			ToggleAccent.Size = UDim2.new(1, 0, 1, 0)
			ToggleAccent.Visible = false

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = ToggleAccent

			ToggleAccent.Parent = ToggleFrame

			ToggleFrame.Parent = NewToggle

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Toggle.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 14, 0, 0)
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewToggle

			-- // Functions
			local function SetState()
				Toggle.Toggled = not Toggle.Toggled
				ToggleAccent.Visible = Toggle.Toggled
				Library.Flags[Toggle.Flag] = Toggle.Toggled
				Toggle.Callback(Toggle.Toggled)
			end
			--
			Library:Connection(NewToggle.MouseButton1Down, SetState)

			function Toggle:Colorpicker(Properties)
				local Properties = Properties or {}
				local Colorpicker = {
					Name = (Properties.Name or Properties.name) or Toggle.Name,
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
					Colorpicker.Name,
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

			function Toggle:Keybind(Properties)
				local Properties = Properties or {}
				local Keybind = {
					Section = self,
					Page = self.Page,
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
				local ListValue;
				if not Keybind.Ignore then
					ListValue = Library.KeyList:NewKey(Keybind.Name, Keybind.Page.Name)
				end
				--
				local KeyFrame = Instance.new("TextButton")
				KeyFrame.Name = "KeyFrame"
				KeyFrame.AnchorPoint = Vector2.new(0, 0.5)
				KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				KeyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KeyFrame.Position = UDim2.new(1, -40, 0.5, 0)
				KeyFrame.Size = UDim2.new(0, 40, 0, 12)
				KeyFrame.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
				KeyFrame.Text = ""
				KeyFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
				KeyFrame.TextSize = 14
				KeyFrame.AutoButtonColor = false

				local UIStroke = Instance.new("UIStroke")
				UIStroke.Name = "UIStroke"
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
				UIStroke.Thickness = 2
				UIStroke.Transparency = 0.8
				UIStroke.Parent = KeyFrame

				local Value = Instance.new("TextLabel")
				Value.Name = "Value"
				Value.FontFace = realfont
				Value.Text = "..."
				Value.TextColor3 = Color3.fromRGB(255, 255, 255)
				Value.TextSize = Library.FSize
				Value.TextStrokeTransparency = 0
				Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Value.BackgroundTransparency = 1
				Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderSizePixel = 0
				Value.Size = UDim2.new(1, 0, 1, 0)
				Value.Parent = KeyFrame

				KeyFrame.Parent = NewToggle

				ModeBox.Name = "ModeBox"
				ModeBox.Parent = KeyFrame
				ModeBox.AnchorPoint = Vector2.new(0,0.5)
				ModeBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				ModeBox.BorderColor3 = Color3.fromRGB(0,0,0)
				ModeBox.BorderSizePixel = 1
				ModeBox.Size = UDim2.new(0, 55, 0, 60)
				ModeBox.Position = UDim2.new(0,48,0.5,0)
				ModeBox.Visible = false
				ModeBox.ZIndex = 2

				local UIStroke1 = Instance.new("UIStroke")
				UIStroke1.Name = "UIStroke"
				UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
				UIStroke1.Thickness = 2
				UIStroke1.Transparency = 0.8
				UIStroke1.Parent = ModeBox

				Hold.Name = "Hold"
				Hold.Parent = ModeBox
				Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Hold.BackgroundTransparency = 1.000
				Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Hold.BorderSizePixel = 0
				Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
				Hold.ZIndex = 2
				Hold.FontFace = realfont
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
				Toggle.FontFace = realfont
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
				Always.FontFace = realfont
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
								if not Keybind.Ignore then
									ListValue:SetVisible(true)
								end
							elseif Keybind.Mode == 'Hold' then
								State = false
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = State
								end
								Keybind.Callback(false)
								if not Keybind.Ignore then
									ListValue:SetVisible(false)
								end
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
				KeyFrame.MouseButton1Click:Connect(function()
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
									if not Keybind.Ignore then
										ListValue:SetVisible(false)
									end
								end
							end
						end
					end
				end)
				--
				Library:Connection(KeyFrame.MouseButton2Down, function()
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
					if ModeBox.Visible and (Input.UserInputType == Enum.UserInputType.MouseButton1) then
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
			NewSlider.Size = UDim2.new(1, 0, 0, 20)
			NewSlider.Parent = Slider.Section.Elements.SectionContent

			local ToggleFrame = Instance.new("TextButton")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.Position = UDim2.new(0, 0, 1, -7)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 7)
			ToggleFrame.Text = ""
			ToggleFrame.AutoButtonColor = false

			local DisabledGradient = Instance.new("UIGradient")
			DisabledGradient.Name = "DisabledGradient"
			DisabledGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient.Rotation = 90
			DisabledGradient.Parent = ToggleFrame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = ToggleFrame

			local ToggleAccent = Library:NewInstance("TextButton", true)
			ToggleAccent.Name = "ToggleAccent"
			ToggleAccent.BackgroundColor3 = Library.Accent
			ToggleAccent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleAccent.BorderSizePixel = 0
			ToggleAccent.Size = UDim2.new(0, 0, 1, 0)
			ToggleAccent.Text = ""
			ToggleAccent.AutoButtonColor = false

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = ToggleAccent

			ToggleAccent.Parent = ToggleFrame

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = realfont
			Value.Text = "0"
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Position = UDim2.new(0,0,0,-1)
			Value.Parent = ToggleFrame

			ToggleFrame.Parent = NewSlider

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Slider.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 8)
			Title.Parent = NewSlider

			-- // Functions
			local Sliding = false
			local Val = Slider.State
			local function Set(value)
				value = math.clamp(Library:Round(value, Slider.Decimals), Slider.Min, Slider.Max)

				local sizeX = ((value - Slider.Min) / (Slider.Max - Slider.Min))
				ToggleAccent.Size = UDim2.new(sizeX, 0, 1, 0)
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
				local sizeX = (input.Position.X - ToggleFrame.AbsolutePosition.X) / ToggleFrame.AbsoluteSize.X
				local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
				Set(value)
			end
			--
			Library:Connection(ToggleFrame.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					ISlide(input)
				end
			end)
			Library:Connection(ToggleFrame.InputEnded, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = false
				end
			end)
			Library:Connection(ToggleAccent.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					ISlide(input)
				end
			end)
			Library:Connection(ToggleAccent.InputEnded, function(input)
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
			function Slider:SetVisible(State)
				NewSlider.Visible = State
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
			NewList.Size = UDim2.new(1, 0, 0, 31)
			NewList.Parent = Dropdown.Section.Elements.SectionContent

			local ToggleFrame = Instance.new("TextButton")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.Position = UDim2.new(0, 0, 1, -18)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 18)
			ToggleFrame.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			ToggleFrame.Text = ""
			ToggleFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.TextSize = Library.FSize
			ToggleFrame.AutoButtonColor = false

			local DisabledGradient = Instance.new("UIGradient")
			DisabledGradient.Name = "DisabledGradient"
			DisabledGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient.Rotation = 90
			DisabledGradient.Parent = ToggleFrame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = ToggleFrame

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = realfont
			Value.Text = "0"
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 4, 0, 0)
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = ToggleFrame

			local ContentOutline = Instance.new("ScrollingFrame")
			ContentOutline.Name = "ContentOutline"
			ContentOutline.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ContentOutline.BottomImage = "rbxassetid://7783554086"
			ContentOutline.CanvasSize = UDim2.new()
			ContentOutline.MidImage = "rbxassetid://7783554086"
			ContentOutline.ScrollBarImageColor3 = Color3.fromRGB(30, 30, 30)
			ContentOutline.ScrollBarThickness = 6
			ContentOutline.TopImage = "rbxassetid://7783554086"
			ContentOutline.Active = true
			ContentOutline.AutomaticSize = Enum.AutomaticSize.Y
			ContentOutline.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			ContentOutline.BorderColor3 = Color3.fromRGB(20, 20, 20)
			ContentOutline.Position = UDim2.new(0, 0, 1, 0)
			ContentOutline.Size = UDim2.new(1, 0, 0, 0)
			ContentOutline.Visible = false

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = ContentOutline

			local UIPadding = Instance.new("UIPadding")
			UIPadding.Name = "UIPadding"
			UIPadding.PaddingBottom = UDim.new(0, 3)
			UIPadding.Parent = ContentOutline

			local UIStroke1 = Instance.new("UIStroke")
			UIStroke1.Name = "UIStroke"
			UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke1.Thickness = 2
			UIStroke1.Transparency = 0.8
			UIStroke1.Parent = ContentOutline

			ContentOutline.Parent = ToggleFrame

			ToggleFrame.Parent = NewList

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Dropdown.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 8)
			Title.Parent = NewList

			-- // Connections
			Library:Connection(ToggleFrame.MouseButton1Down, function()
				ContentOutline.Visible = not ContentOutline.Visible
				if ContentOutline.Visible then
					NewList.ZIndex = 5
				else
					NewList.ZIndex = 1
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ContentOutline.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(ContentOutline) and not Library:IsMouseOverFrame(ToggleFrame) then
						ContentOutline.Visible = false
						NewList.ZIndex = 1
					end
				end
			end)
			--
			local chosen = Dropdown.Max and {} or nil
			local Count = 0
			--
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

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
							text.Visible = false

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						else
							if #chosen == Dropdown.Max then
								Dropdown.OptionInsts[chosen[1]].text.Visible = false
								table.remove(chosen, 1)
							end

							table.insert(chosen, option)

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")
							text.Visible = true

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						end
					else
						for opt, tbl in next, Dropdown.OptionInsts do
							if opt ~= option then
								tbl.text.Visible = false
							end
						end
						chosen = option
						Value.Text = option
						text.Visible = true
						ContentOutline.Visible = false
						NewList.ZIndex = 1
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
					local OptButton = Instance.new("TextButton")
					OptButton.Name = "OptButton"
					OptButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
					OptButton.Text = ""
					OptButton.TextColor3 = Color3.fromRGB(0, 0, 0)
					OptButton.TextSize = Library.FSize
					OptButton.AutoButtonColor = false
					OptButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					OptButton.BackgroundTransparency = 1
					OptButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
					OptButton.BorderSizePixel = 0
					OptButton.Size = UDim2.new(1, 0, 0, 20)

					local Disabled = Instance.new("TextLabel")
					Disabled.Name = "Disabled"
					Disabled.FontFace = realfont
					Disabled.Text = option
					Disabled.TextColor3 = Color3.fromRGB(255, 255, 255)
					Disabled.TextSize = Library.FSize
					Disabled.TextStrokeTransparency = 0
					Disabled.TextXAlignment = Enum.TextXAlignment.Left
					Disabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Disabled.BackgroundTransparency = 1
					Disabled.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Disabled.BorderSizePixel = 0
					Disabled.Position = UDim2.new(0, 4, 0, 0)
					Disabled.Size = UDim2.new(1, 0, 1, 0)
					Disabled.Parent = OptButton

					local Enabled = Library:NewInstance("TextLabel", true)
					Enabled.Name = "Enabled"
					Enabled.FontFace = realfont
					Enabled.Text = option
					Enabled.TextColor3 = Library.Accent
					Enabled.TextSize = Library.FSize
					Enabled.TextStrokeTransparency = 0
					Enabled.TextXAlignment = Enum.TextXAlignment.Left
					Enabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Enabled.BackgroundTransparency = 1
					Enabled.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Enabled.BorderSizePixel = 0
					Enabled.Position = UDim2.new(0, 4, 0, 0)
					Enabled.Size = UDim2.new(1, 0, 1, 0)
					Enabled.Parent = OptButton
					Enabled.Visible = false

					OptButton.Parent = ContentOutline

					Dropdown.OptionInsts[option].text = Enabled
					Dropdown.OptionInsts[option].button = OptButton

					Count = Count + 1

					if Dropdown.ScrollMax then
						ContentOutline.AutomaticSize = Enum.AutomaticSize.None
						if Count < Dropdown.ScrollMax then
						else
							ContentOutline.Size = UDim2.new(1,0, 0, 20*Dropdown.ScrollMax)
						end
					else
						ContentOutline.AutomaticSize = Enum.AutomaticSize.Y
					end

					handleoptionclick(option, OptButton, Enabled)
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
							tbl.text.Visible = false
						end
					end

					for i, opt in next, option do
						if table.find(Dropdown.Options, opt) and #chosen < Dropdown.Max then
							table.insert(chosen, opt)
							Dropdown.OptionInsts[opt].text.Visible = true
						end
					end

					local textchosen = {}
					local cutobject = false

					for _, opt in next, chosen do
						table.insert(textchosen, opt)
					end

					Value.Text = #chosen == 0 and "" or table.concat(textchosen, ", ") .. (cutobject and ", ..." or "")

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
							tbl.text.Visible = false
						end
					end
					if table.find(Dropdown.Options, option) then
						chosen = option
						Dropdown.OptionInsts[option].text.Visible = true
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
		function Sections:Keybind(Properties)
			local Properties = Properties or {}
			local Keybind = {
				Section = self,
				Page = self.Page,
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
			local ListValue;
			if not Keybind.Ignore then
				ListValue = Library.KeyList:NewKey(Keybind.Name, Keybind.Page.Name)
			end
			--
			local NewKey = Instance.new("Frame")
			NewKey.Name = "NewKey"
			NewKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewKey.BackgroundTransparency = 1
			NewKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewKey.BorderSizePixel = 0
			NewKey.Size = UDim2.new(1, 0, 0, 8)
			NewKey.Parent = Keybind.Section.Elements.SectionContent

			local KeyFrame = Instance.new("TextButton")
			KeyFrame.Name = "KeyFrame"
			KeyFrame.AnchorPoint = Vector2.new(0, 0.5)
			KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			KeyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			KeyFrame.Position = UDim2.new(1, -40, 0.5, 0)
			KeyFrame.Size = UDim2.new(0, 40, 0, 12)
			KeyFrame.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			KeyFrame.Text = ""
			KeyFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
			KeyFrame.TextSize = 14
			KeyFrame.AutoButtonColor = false

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = KeyFrame

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = realfont
			Value.Text = "..."
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = KeyFrame

			KeyFrame.Parent = NewKey

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Keybind.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewKey

			ModeBox.Name = "ModeBox"
			ModeBox.Parent = KeyFrame
			ModeBox.AnchorPoint = Vector2.new(0,0.5)
			ModeBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			ModeBox.BorderColor3 = Color3.fromRGB(0,0,0)
			ModeBox.BorderSizePixel = 1
			ModeBox.Size = UDim2.new(0, 55, 0, 60)
			ModeBox.Position = UDim2.new(0,48,0.5,0)
			ModeBox.Visible = false
			ModeBox.ZIndex = 2

			local UIStroke1 = Instance.new("UIStroke")
			UIStroke1.Name = "UIStroke"
			UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke1.Thickness = 2
			UIStroke1.Transparency = 0.8
			UIStroke1.Parent = ModeBox

			Hold.Name = "Hold"
			Hold.Parent = ModeBox
			Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hold.BackgroundTransparency = 1.000
			Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hold.BorderSizePixel = 0
			Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
			Hold.ZIndex = 2
			Hold.FontFace = realfont
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
			Toggle.FontFace = realfont
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
			Always.FontFace = realfont
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
							if not Keybind.Ignore then
								ListValue:SetVisible(true)
							end
						elseif Keybind.Mode == "Hold" then
							State = false
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = State
							end
							Keybind.Callback(false)
							if not Keybind.Ignore then
								ListValue:SetVisible(false)
							end
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
			KeyFrame.MouseButton1Click:Connect(function()
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
								if not Keybind.Ignore then
									ListValue:SetVisible(false)
								end
							end
						end
					end
				end
			end)
			--
			Library:Connection(KeyFrame.MouseButton2Down, function()
				ModeBox.Visible = true
				NewKey.ZIndex = 5
			end)
			--
			Library:Connection(Hold.MouseButton1Down, function()
				set("Hold")
				Hold.TextColor3 = Color3.fromRGB(255,255,255)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewKey.ZIndex = 1
			end)
			--
			Library:Connection(Toggle.MouseButton1Down, function()
				set("Toggle")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(255,255,255)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewKey.ZIndex = 1
			end)
			--
			Library:Connection(Always.MouseButton1Down, function()
				set("Always")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(255,255,255)
				ModeBox.Visible = false
				NewKey.ZIndex = 1
			end)
			--
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if ModeBox.Visible and (Input.UserInputType == Enum.UserInputType.MouseButton1) then
					if not Library:IsMouseOverFrame(ModeBox) then
						ModeBox.Visible = false
						NewKey.ZIndex = 1
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
			local NewKey = Instance.new("Frame")
			NewKey.Name = "NewKey"
			NewKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewKey.BackgroundTransparency = 1
			NewKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewKey.BorderSizePixel = 0
			NewKey.Size = UDim2.new(1, 0, 0, 8)
			NewKey.Parent = Colorpicker.Section.Elements.SectionContent

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Colorpicker.Name
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Parent = NewKey

			-- // Functions
			Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
			local colorpickertypes = Library:NewPicker(
				Colorpicker.Name,
				Colorpicker.State,
				Colorpicker.Alpha,
				NewKey,
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
				}
				-- // Functions
				Colorpicker.Colorpickers = Colorpicker.Colorpickers + 1
				local Newcolorpickertypes = Library:NewPicker(
					NewColorpicker.Name,
					NewColorpicker.State,
					NewColorpicker.Alpha,
					NewKey,
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
			NewBox.Size = UDim2.new(1, 0, 0, Textbox.Name ~= nil and 31 or 18)
			NewBox.Parent = Textbox.Section.Elements.SectionContent

			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.Position = UDim2.new(0, 0, 1, -18)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 18)

			local DisabledGradient = Instance.new("UIGradient")
			DisabledGradient.Name = "DisabledGradient"
			DisabledGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient.Rotation = 90
			DisabledGradient.Parent = ToggleFrame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = ToggleFrame

			local Value = Instance.new("TextBox")
			Value.Name = "Value"
			Value.FontFace = realfont
			Value.Text = Textbox.State
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.TextXAlignment = Enum.TextXAlignment.Left
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 4, 0, 0)
			Value.Size = UDim2.new(1, -4, 1, 0)
			Value.Parent = ToggleFrame
			Value.ClearTextOnFocus = false

			ToggleFrame.Parent = NewBox

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.FontFace = realfont
			Title.Text = Textbox.Name ~= nil and Textbox.Name or ""
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = Library.FSize
			Title.TextStrokeTransparency = 0
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 8)
			Title.Parent = NewBox
			Title.Visible = Textbox.Name ~= nil and true or false

			-- // Connections
			Value.Focused:Connect(function()
				Value.TextColor3 = Library.Accent
			end)
			Value.FocusLost:Connect(function()
				Value.TextColor3 = Color3.new(1,1,1)
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
			NewButton.Size = UDim2.new(1, 0, 0, 18)
			NewButton.Parent = Button.Section.Elements.SectionContent

			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.Position = UDim2.new(0, 0, 1, -18)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 18)

			local DisabledGradient = Instance.new("UIGradient")
			DisabledGradient.Name = "DisabledGradient"
			DisabledGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient.Rotation = 90
			DisabledGradient.Parent = ToggleFrame

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = ToggleFrame

			local Value = Instance.new("TextLabel")
			Value.Name = "Value"
			Value.FontFace = realfont
			Value.Text = Button.Name
			Value.TextColor3 = Color3.fromRGB(255, 255, 255)
			Value.TextSize = Library.FSize
			Value.TextStrokeTransparency = 0
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.Parent = ToggleFrame

			ToggleFrame.Parent = NewButton
			--
			Library:Connection(NewButton.MouseButton1Down, function()
				Button.Callback()
				Value.TextColor3 = Library.Accent
				task.spawn(function()
					task.wait(0.1)
					Value.TextColor3 = Color3.fromRGB(255,255,255)
				end)
			end)

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
			NewPlayer.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewPlayer.Size = UDim2.new(1, 0, 0.5, 70)
			NewPlayer.Parent = Playerlist.Page.Elements.RealPage

			local Frame = Instance.new("Frame")
			Frame.Name = "Frame"
			Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0, 1, 0, 1)
			Frame.Size = UDim2.new(1, -2, 1, -2)

			local List = Library:NewInstance("ScrollingFrame", true)
			List.Name = "List"
			List.AutomaticCanvasSize = Enum.AutomaticSize.Y
			List.BottomImage = "rbxassetid://7783554086"
			List.CanvasSize = UDim2.new()
			List.MidImage = "rbxassetid://7783554086"
			List.ScrollBarImageColor3 = Library.Accent
			List.ScrollBarThickness = 0
			List.TopImage = "rbxassetid://7783554086"
			List.Active = true
			List.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			List.BorderColor3 = Color3.fromRGB(0, 0, 0)
			List.Position = UDim2.new(0, 5, 0, 40)
			List.Size = UDim2.new(1, -10, 0, 200)

			local UIListLayout = Instance.new("UIListLayout")
			UIListLayout.Name = "UIListLayout"
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Parent = List

			local UIStroke = Instance.new("UIStroke")
			UIStroke.Name = "UIStroke"
			UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke.Thickness = 2
			UIStroke.Transparency = 0.8
			UIStroke.Parent = List

			List.Parent = Frame

			local Friend = Instance.new("TextButton")
			Friend.Name = "Friend"
			Friend.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
			Friend.Text = ""
			Friend.TextColor3 = Color3.fromRGB(0, 0, 0)
			Friend.TextSize = 14
			Friend.AutoButtonColor = false
			Friend.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Friend.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Friend.Position = UDim2.new(1, -105, 1, -35)
			Friend.Size = UDim2.new(0, 100, 0, 25)

			local UIStroke1 = Instance.new("UIStroke")
			UIStroke1.Name = "UIStroke"
			UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke1.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke1.Thickness = 2
			UIStroke1.Transparency = 0.8
			UIStroke1.Parent = Friend

			local FriendLabel = Instance.new("TextLabel")
			FriendLabel.Name = "FriendLabel"
			FriendLabel.FontFace = realfont
			FriendLabel.Text = "Friendly"
			FriendLabel.TextColor3 = Color3.fromRGB(255,255,255)
			FriendLabel.TextSize = Library.FSize
			FriendLabel.TextStrokeTransparency = 0
			FriendLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			FriendLabel.BackgroundTransparency = 1
			FriendLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FriendLabel.BorderSizePixel = 0
			FriendLabel.Size = UDim2.new(1, 0, 1, 0)
			FriendLabel.Parent = Friend

			local DisabledGradient = Instance.new("UIGradient")
			DisabledGradient.Name = "DisabledGradient"
			DisabledGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient.Rotation = 90
			DisabledGradient.Parent = Friend

			Friend.Parent = Frame

			local Priority = Instance.new("TextButton")
			Priority.Name = "Priority"
			Priority.FontFace = realfont
			Priority.Text = ""
			Priority.TextColor3 = Color3.fromRGB(0, 0, 0)
			Priority.TextSize = 14
			Priority.AutoButtonColor = false
			Priority.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Priority.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Priority.Position = UDim2.new(1, -105, 1, -70)
			Priority.Size = UDim2.new(0, 100, 0, 25)

			local PriorityLabel = Instance.new("TextLabel")
			PriorityLabel.Name = "PriorityLabel"
			PriorityLabel.FontFace = realfont
			PriorityLabel.Text = "Prioritize"
			PriorityLabel.TextColor3 = Color3.fromRGB(255,255,255)
			PriorityLabel.TextSize = Library.FSize
			PriorityLabel.TextStrokeTransparency = 0
			PriorityLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PriorityLabel.BackgroundTransparency = 1
			PriorityLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PriorityLabel.BorderSizePixel = 0
			PriorityLabel.Size = UDim2.new(1, 0, 1, 0)
			PriorityLabel.Parent = Priority

			local DisabledGradient1 = Instance.new("UIGradient")
			DisabledGradient1.Name = "DisabledGradient"
			DisabledGradient1.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(47, 47, 47)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)),
			})
			DisabledGradient1.Rotation = 90
			DisabledGradient1.Parent = Priority

			local UIStroke2 = Instance.new("UIStroke")
			UIStroke2.Name = "UIStroke"
			UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke2.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke2.Thickness = 2
			UIStroke2.Transparency = 0.8
			UIStroke2.Parent = Priority

			Priority.Parent = Frame

			local ImageLabel = Instance.new("ImageLabel")
			ImageLabel.Name = "ImageLabel"
			ImageLabel.Image = ""
			ImageLabel.BackgroundColor3 = Color3.fromRGB(25,25,25)
			ImageLabel.BorderColor3 = Color3.fromRGB(0,0,0)
			ImageLabel.Position = UDim2.new(0, 5, 1, -75)
			ImageLabel.Size = UDim2.new(0, 70, 0, 70)
			ImageLabel.Parent = Frame

			local UIStroke3 = Instance.new("UIStroke")
			UIStroke3.Name = "UIStroke"
			UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke3.LineJoinMode = Enum.LineJoinMode.Miter
			UIStroke3.Thickness = 2
			UIStroke3.Transparency = 0.8
			UIStroke3.Parent = ImageLabel

			local PlayerName1 = Instance.new("TextLabel")
			PlayerName1.Name = "PlayerName"
			PlayerName1.FontFace = realfont
			PlayerName1.Text = "No Player Selected"
			PlayerName1.TextColor3 = Color3.fromRGB(255,255,255)
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
			PlayerName1.Parent = Frame

			local SectionName = Instance.new("TextLabel")
			SectionName.Name = "SectionName"
			SectionName.FontFace = realfont
			SectionName.Text = "Player List"
			SectionName.TextColor3 = Color3.fromRGB(255,255,255)
			SectionName.TextSize = Library.FSize
			SectionName.TextStrokeTransparency = 0
			SectionName.TextXAlignment = Enum.TextXAlignment.Left
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1
			SectionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionName.BorderSizePixel = 0
			SectionName.Position = UDim2.new(0, 5, 0, 0)
			SectionName.Size = UDim2.new(1, 0, 0, 20)
			SectionName.Parent = Frame

			local Accent = Library:NewInstance("Frame", true)
			Accent.Name = "Accent"
			Accent.BackgroundColor3 = Library.Accent
			Accent.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Accent.BorderSizePixel = 0
			Accent.Position = UDim2.new(0, 0, 0, 0)
			Accent.Size = UDim2.new(1, 0, 0, 1)

			local UIGradient = Instance.new("UIGradient")
			UIGradient.Name = "UIGradient"
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145)),
			})
			UIGradient.Rotation = 90
			UIGradient.Parent = Accent

			local BlackLine = Instance.new("Frame")
			BlackLine.Name = "BlackLine"
			BlackLine.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			BlackLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BlackLine.BorderSizePixel = 0
			BlackLine.Position = UDim2.new(0, 0, 1, 0)
			BlackLine.Size = UDim2.new(1, 0, 0, 2)
			BlackLine.Parent = Accent

			local TeamLabel = Instance.new("TextLabel")
			TeamLabel.Name = "TeamLabel"
			TeamLabel.FontFace = realfont
			TeamLabel.Text = "Team"
			TeamLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TeamLabel.TextSize = Library.FSize
			TeamLabel.TextStrokeTransparency = 0
			TeamLabel.TextXAlignment = Enum.TextXAlignment.Left
			TeamLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TeamLabel.BackgroundTransparency = 1
			TeamLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TeamLabel.BorderSizePixel = 0
			TeamLabel.Position = UDim2.new(0.333, 6, 0, 20)
			TeamLabel.Size = UDim2.new(0, 100, 0, 20)
			TeamLabel.Parent = Frame

			local NameLabel = Instance.new("TextLabel")
			NameLabel.Name = "NameLabel"
			NameLabel.FontFace = realfont
			NameLabel.Text = "Name"
			NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			NameLabel.TextSize = Library.FSize
			NameLabel.TextStrokeTransparency = 0
			NameLabel.TextXAlignment = Enum.TextXAlignment.Left
			NameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NameLabel.BackgroundTransparency = 1
			NameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NameLabel.BorderSizePixel = 0
			NameLabel.Position = UDim2.new(0, 6, 0, 20)
			NameLabel.Size = UDim2.new(0, 100, 0, 20)
			NameLabel.Parent = Frame

			local StatusLabel = Instance.new("TextLabel")
			StatusLabel.Name = "StatusLabel"
			StatusLabel.FontFace = realfont
			StatusLabel.Text = "Status"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			StatusLabel.TextSize = Library.FSize
			StatusLabel.TextStrokeTransparency = 0
			StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
			StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			StatusLabel.BackgroundTransparency = 1
			StatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			StatusLabel.BorderSizePixel = 0
			StatusLabel.Position = UDim2.new(0.667, 6, 0, 20)
			StatusLabel.Size = UDim2.new(0, 100, 0, 20)
			StatusLabel.Parent = Frame

			local DownArrow = Instance.new("ImageLabel")
			DownArrow.Name = "DownArrow"
			DownArrow.Image = "rbxassetid://14555080158"
			DownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DownArrow.BackgroundTransparency = 1
			DownArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DownArrow.BorderSizePixel = 0
			DownArrow.Position = UDim2.new(1, -12, 1, -92)
			DownArrow.Size = UDim2.new(0, 5, 0, 3)
			DownArrow.Parent = Frame

			local UpArrow = Instance.new("ImageLabel")
			UpArrow.Name = "UpArrow"
			UpArrow.Image = "rbxassetid://14555080158"
			UpArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			UpArrow.BackgroundTransparency = 1
			UpArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			UpArrow.BorderSizePixel = 0
			UpArrow.Position = UDim2.new(1, -12, 0, 43)
			UpArrow.Rotation = 180
			UpArrow.Size = UDim2.new(0, 5, 0, 3)
			UpArrow.Parent = Frame

			Accent.Parent = Frame

			Frame.Parent = NewPlayer

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
					if option ~= game.Players.LocalPlayer then
						optioninstances[option] = {}

						local NewPlayer1 = Instance.new("TextButton")
						NewPlayer1.Name = "NewPlayer"
						NewPlayer1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
						NewPlayer1.Text = ""
						NewPlayer1.TextColor3 = Color3.fromRGB(0, 0, 0)
						NewPlayer1.TextSize = 14
						NewPlayer1.AutoButtonColor = false
						NewPlayer1.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
						NewPlayer1.BorderColor3 = Color3.fromRGB(20,20,20)
						NewPlayer1.BorderSizePixel = 2
						NewPlayer1.Size = UDim2.new(1, 0, 0, 20)

						local PlayerName = Instance.new("TextLabel")
						PlayerName.Name = "PlayerName"
						PlayerName.FontFace = realfont
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
						PlayerName.Size = UDim2.new(0, 140, 1, 0)
						PlayerName.Parent = NewPlayer1
						PlayerName.TextWrapped = true

						local PlayerStatus = Instance.new("TextLabel")
						PlayerStatus.Name = "PlayerStatus"
						PlayerStatus.FontFace = realfont
						PlayerStatus.Text = option == game.Players.LocalPlayer and "Local Player" or table.find(Library.Friends, option) and "Friendly" or table.find(Library.Priorities, option) and "Priority" or "None"
						PlayerStatus.TextColor3 = option == game.Players.LocalPlayer and Color3.fromRGB(0, 170, 255) or table.find(Library.Friends, option) and Color3.fromRGB(0,255,0) or table.find(Library.Priorities, option) and Color3.fromRGB(255,0,0) or Color3.fromRGB(255,255,255)
						PlayerStatus.TextSize = Library.FSize
						PlayerStatus.TextStrokeTransparency = 0
						PlayerStatus.TextXAlignment = Enum.TextXAlignment.Left
						PlayerStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						PlayerStatus.BackgroundTransparency = 1
						PlayerStatus.BorderColor3 = Color3.fromRGB(0, 0, 0)
						PlayerStatus.BorderSizePixel = 0
						PlayerStatus.Position = UDim2.new(0.667, 6, 0, 0)
						PlayerStatus.Size = UDim2.new(0, 100, 1, 0)
						PlayerStatus.Parent = NewPlayer1

						local PlayerAccent = Library:NewInstance("TextLabel", true)
						PlayerAccent.Name = "PlayerAccent"
						PlayerAccent.FontFace = realfont
						PlayerAccent.Text = option.Name
						PlayerAccent.TextColor3 = Library.Accent
						PlayerAccent.TextSize = Library.FSize
						PlayerAccent.TextStrokeTransparency = 0
						PlayerAccent.TextXAlignment = Enum.TextXAlignment.Left
						PlayerAccent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						PlayerAccent.BackgroundTransparency = 1
						PlayerAccent.BorderColor3 = Color3.fromRGB(0, 0, 0)
						PlayerAccent.BorderSizePixel = 0
						PlayerAccent.Position = UDim2.new(0, 6, 0, 0)
						PlayerAccent.Size = UDim2.new(0, 140, 1, 0)
						PlayerAccent.Parent = NewPlayer1
						PlayerAccent.Visible = false
						PlayerAccent.TextWrapped = true

						local PlayerTeam = Instance.new("TextLabel")
						PlayerTeam.Name = "PlayerTeam"
						PlayerTeam.FontFace = realfont
						PlayerTeam.Text = option:FindFirstChild("Team") and tostring(option.Team.Name) or "No Team"
						PlayerTeam.TextColor3 = option:FindFirstChild("Team") and option.TeamColor.Color or Color3.fromRGB(255,255,255)
						PlayerTeam.TextSize = Library.FSize
						PlayerTeam.TextStrokeTransparency = 0
						PlayerTeam.TextXAlignment = Enum.TextXAlignment.Left
						PlayerTeam.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						PlayerTeam.BackgroundTransparency = 1
						PlayerTeam.BorderColor3 = Color3.fromRGB(0, 0, 0)
						PlayerTeam.BorderSizePixel = 0
						PlayerTeam.Position = UDim2.new(0.333, 6, 0, 0)
						PlayerTeam.Size = UDim2.new(0, 100, 1, 0)
						PlayerTeam.Parent = NewPlayer1

						local Line1 = Instance.new("Frame")
						Line1.Name = "Line1"
						Line1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						Line1.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Line1.BorderSizePixel = 0
						Line1.Position = UDim2.new(0.333, 0, 0, 0)
						Line1.Size = UDim2.new(0, 2, 1, 0)
						Line1.Parent = NewPlayer1

						local Line11 = Instance.new("Frame")
						Line11.Name = "Line1"
						Line11.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						Line11.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Line11.BorderSizePixel = 0
						Line11.Position = UDim2.new(0.667, 0, 0, 0)
						Line11.Size = UDim2.new(0, 2, 1, 0)
						Line11.Parent = NewPlayer1

						NewPlayer1.Parent = List

						optioninstances[option].button = NewPlayer1
						optioninstances[option].text = PlayerName
						optioninstances[option].status = PlayerStatus
						optioninstances[option].accent = PlayerAccent
						optioninstances[option].team = PlayerTeam

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
							PlayerAccent.Visible = true
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
							handleoptionclick(option, NewPlayer1, PlayerAccent)
						end
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
			Playerlist.Page.Elements.Left.Size = UDim2.new(0.5, -5,0.5, -70)
			Playerlist.Page.Elements.Right.Size = UDim2.new(0.5, -5,0.5, -70)
			Playerlist.Page.Elements.Left.Position = UDim2.new(0, 0,0.5, 75)
			Playerlist.Page.Elements.Right.Position = UDim2.new(0.5, 5,0.5, 75)
		end
	end;
end;

return Library
