-- dmt private library
-- made by portal | not for public use
if isfile("dmtmenu.font") then
	delfile("dmtmenu.font")
end

local Library = {};
do
	Library = {
		Open = true;
		Accent = Color3.fromRGB(214, 112, 112);
		Pages = {};
		Sections = {};
		Flags = {};
		UnNamedFlags = 0;
		ThemeObjects = {};
		Holder = nil;
		Watermark = nil;
		Keys = {
			[Enum.KeyCode.LeftShift] = "lS",
			[Enum.KeyCode.RightShift] = "rS",
			[Enum.KeyCode.LeftControl] = "lC",
			[Enum.KeyCode.RightControl] = "rC",
			[Enum.KeyCode.LeftAlt] = "lA",
			[Enum.KeyCode.RightAlt] = "rA",
			[Enum.KeyCode.CapsLock] = "caps",
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
			[Enum.KeyCode.KeypadOne] = "n1",
			[Enum.KeyCode.KeypadTwo] = "n2",
			[Enum.KeyCode.KeypadThree] = "n3",
			[Enum.KeyCode.KeypadFour] = "n4",
			[Enum.KeyCode.KeypadFive] = "n5",
			[Enum.KeyCode.KeypadSix] = "n6",
			[Enum.KeyCode.KeypadSeven] = "n7",
			[Enum.KeyCode.KeypadEight] = "n8",
			[Enum.KeyCode.KeypadNine] = "n9",
			[Enum.KeyCode.KeypadZero] = "n0",
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
			[Enum.UserInputType.MouseButton1] = "m1",
			[Enum.UserInputType.MouseButton2] = "m2",
			[Enum.UserInputType.MouseButton3] = "m3"
		};
		Connections = {};
		FontSize = 12;
		KeyList = nil;
		UIKey = Enum.KeyCode.End;
		ScreenGUI = nil;
		CurrentColor = nil;
		FSize = 13;
		Notifs = {};
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

		Font:Register("dmtmenu", 400, "normal", {Id = "dmt_font.ttf", Font = ""});
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
		function Library:ChangeAccent(Color)
			Library.Accent = Color

			for obj, theme in next, Library.ThemeObjects do
				if theme:IsA("Frame") or theme:IsA("TextButton") then
					theme.BackgroundColor3 = Color
				elseif theme:IsA("TextLabel") then
					theme.TextColor3 = Color
				end
			end
		end
	end;
	
	-- // Colorpicker Element
	do
		function Library:NewPicker(name, default, defaultalpha, parent, count, flag, callback)
			-- // Instances
			local Icon = Instance.new('TextButton', parent)
			local ColorWindow = Library:NewInstance('Frame', true)
			local WindowInline = Instance.new('Frame', ColorWindow)
			local Color = Instance.new('TextButton', WindowInline)
			local Sat = Instance.new('ImageLabel', Color)
			local Val = Instance.new('ImageLabel', Color)
			local Container = Instance.new('Frame', Color)
			local Hue = Instance.new('ImageButton', Color)
			local Alpha = Instance.new('ImageButton', Color)
			local HueSlide = Instance.new('Frame', Hue)
			local AlphaSlide = Instance.new('Frame', Alpha)
			--
			Icon.Name = "Icon"
			Icon.Position = UDim2.new(1, - (count * 18) - (count * 6),0.5,0)
			Icon.AnchorPoint = Vector2.new(0,0.5)
			Icon.Size = UDim2.new(0,16,0,8)
			Icon.BackgroundColor3 = default
			Icon.BorderColor3 = Color3.fromRGB(71, 71, 71)
			Icon.BorderSizePixel = 0
			Icon.AnchorPoint = Vector2.new(1,0.5)
			Icon.AutoButtonColor = false
			Icon.Text = ""
			--
			ColorWindow.Name = "ColorWindow"
			ColorWindow.Parent = Icon
			ColorWindow.Position = UDim2.new(1,-2,1,2)
			ColorWindow.Size = UDim2.new(0,150,0,146)
			ColorWindow.AnchorPoint = Vector2.new(1,0)
			ColorWindow.ZIndex = 100
			ColorWindow.Visible = false
			ColorWindow.BorderSizePixel = 0
			--
			WindowInline.Name = "WindowInline"
			WindowInline.Position = UDim2.new(0,1,0,1)
			WindowInline.Size = UDim2.new(1,-2,1,-2)
			WindowInline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			WindowInline.BorderSizePixel = 0;
			WindowInline.ZIndex = 100
			--
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
			Color.TextSize = 14
			Color.ZIndex = 100
			--
			Sat.Name = "Sat"
			Sat.Size = UDim2.new(1,0,1,0)
			Sat.BackgroundColor3 = Color3.new(1,1,1)
			Sat.BackgroundTransparency = 1
			Sat.BorderSizePixel = 0
			Sat.BorderColor3 = Color3.new(0,0,0)
			Sat.Image = "http://www.roblox.com/asset/?id=14684562507"
			Sat.ZIndex = 100
			--
			Val.Name = "Val"
			Val.Size = UDim2.new(1,0,1,0)
			Val.BackgroundColor3 = Color3.new(1,1,1)
			Val.BackgroundTransparency = 1
			Val.BorderSizePixel = 0
			Val.BorderColor3 = Color3.new(0,0,0)
			Val.Image = "http://www.roblox.com/asset/?id=14684563800"
			Val.ZIndex = 100
			--
			Container.Name = "Container"
			Container.Position = UDim2.new(0,-2,1,5)
			Container.Size = UDim2.new(0,189,0,55)
			Container.BackgroundColor3 = Color3.new(1,1,1)
			Container.BackgroundTransparency = 1
			Container.BorderColor3 = Color3.new(0,0,0)
			Container.ZIndex = 100
			--
			Hue.Name = "Hue"
			Hue.Position = UDim2.new(1,10,0,0)
			Hue.Size = UDim2.new(0,15,1,0)
			Hue.BackgroundColor3 = Color3.new(1,1,1)
			Hue.BorderColor3 = Color3.new(0,0,0)
			Hue.Image = "http://www.roblox.com/asset/?id=14684557999"
			Hue.AutoButtonColor = false
			Hue.ZIndex = 100
			Hue.BorderSizePixel = 0
			--
			Alpha.Name = "Alpha"
			Alpha.Position = UDim2.new(0,0,1,7)
			Alpha.Size = UDim2.new(0,146,0,15)
			Alpha.BackgroundColor3 = Color3.new(1,1,1)
			Alpha.BorderColor3 = Color3.new(0,0,0)
			Alpha.Image = "http://www.roblox.com/asset/?id=16841308372"
			Alpha.AutoButtonColor = false
			Alpha.ZIndex = 100
			Alpha.BorderSizePixel = 0
			--
			HueSlide.Name = "HueSlide"
			HueSlide.Size = UDim2.new(1,0,0,3)
			HueSlide.BackgroundColor3 = Color3.new(1,1,1)
			HueSlide.BorderColor3 = Color3.new(0,0,0)
			HueSlide.BorderSizePixel = 1
			--
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
			--
			Library:Connection(Icon.MouseLeave, function()
				Icon.BorderSizePixel = 0
			end)

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
				Alpha.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				HueSlide.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
				Icon.BackgroundColor3 = hsv

				HueSlide.Position = UDim2.new(0,0,math.clamp(hue, 0.005, 0.995),0)
				AlphaSlide.Position = UDim2.new(math.clamp(alpha, 0.000, 0.982),0,0,0)

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
					Alpha.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					HueSlide.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
					HueSlide.Position = UDim2.new(0,0,math.clamp(hue, 0.005, 0.995),0)
					AlphaSlide.Position = UDim2.new(math.clamp(alpha, 0.000, 0.982),0,0,0)

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
					if not Library:IsMouseOverFrame(ColorWindow) and not Library:IsMouseOverFrame(Icon) then
						ColorWindow.Visible = false
						parent.ZIndex = 3
					end
				end
			end)
			
			Icon.MouseButton1Down:Connect(function()
				ColorWindow.Visible = true
				parent.ZIndex = 3

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
	
	function Library:updateNotifsPositions(position)
    for i, v in pairs(Library.Notifs) do 
        local Position = position == "Middle" and Vector2.new(workspace.CurrentCamera.ViewportSize.X/2 - (v["Objects"][2].TextBounds.X + 4)/2,600) or Vector2.new(20, 20)
        game:GetService("TweenService"):Create(v.Container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0,Position.X,0,Position.Y + (i * 20))}):Play()
    end 
end
-- 
function Library:Notification(message, duration, color, position)
    local notification = {Container = nil, Objects = {}}
    -- 
    local NotifContainer = Instance.new('Frame', Library.ScreenGUI)
    local Background = Instance.new('Frame', NotifContainer)
    local TextLabel = Instance.new('TextLabel', Background)
    local Progress = Instance.new('Frame', Background)
    --
    local Position = position == "Middle" and Vector2.new(workspace.CurrentCamera.ViewportSize.X/2 - (TextLabel.TextBounds.X + 4)/2, 600) or Vector2.new(20, 20)
    --
    NotifContainer.Name = "NotifContainer"
    NotifContainer.Position = UDim2.new(0,Position.X, 0, Position.Y)
    NotifContainer.Size = UDim2.new(0,TextLabel.TextBounds.X + 4,0,16)
    NotifContainer.BackgroundColor3 = Color3.new(1,1,1)
    NotifContainer.BackgroundTransparency = 1
    NotifContainer.BorderSizePixel = 0
    NotifContainer.BorderColor3 = Color3.new(0,0,0)
    NotifContainer.ZIndex = 99999999
    notification.Container = NotifContainer
    --
    Background.Name = "Background"
    Background.Size = UDim2.new(1,0,1,0)
    Background.BackgroundColor3 = Color3.new(0.0588,0.0588,0.0784)
    Background.BackgroundTransparency = 1
    Background.BorderColor3 = Color3.new(0.1373,0.1373,0.1569)
    table.insert(notification.Objects, Background)
    --
    TextLabel.Name = "TextLabel"
    TextLabel.Position = UDim2.new(0,0,0,0)
    TextLabel.Size = UDim2.new(1,0,1,0)
    TextLabel.BackgroundColor3 = Color3.new(1,1,1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderSizePixel = 0
    TextLabel.BorderColor3 = Color3.new(0,0,0)
    TextLabel.Text = message
    TextLabel.TextColor3 = Color3.fromRGB(245,245,245)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
    TextLabel.TextSize = Library.FSize
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    table.insert(notification.Objects, TextLabel)
    --
    Progress.Name = "Progress"
    Progress.Position = UDim2.new(0,0,1,-1)
    Progress.Size = UDim2.new(0,0,0,1)
    Progress.BackgroundColor3 = Color3.new(1,0,0)
    Progress.BorderSizePixel = 0
    Progress.BorderColor3 = Color3.new(0,0,0)
    table.insert(notification.Objects, Progress)

    if color ~= nil then
        Progress.BackgroundColor3 = color
    end

    function notification:remove()
        table.remove(Library.Notifs, table.find(Library.Notifs, notification))
        Library:updateNotifsPositions(position)
        notification.Container:Destroy()
    end

    task.spawn(function()
        Background.AnchorPoint = Vector2.new(1,0)
        local Tween1 = game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(0,0)}):Play()
        local Tween2 = game:GetService("TweenService"):Create(Progress, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,1)}):Play()
        --game:GetService("TweenService"):Create(Progress, TweenInfo.new(duration or 5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.new(0,1,0)}):Play()
        task.wait(duration)
        game:GetService("TweenService"):Create(Background, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {AnchorPoint = Vector2.new(1,0)}):Play()
        for i,v in next, notification.Objects do
            game:GetService("TweenService"):Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        end
        game:GetService("TweenService"):Create(TextLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
    end)

    task.delay(0.25 + duration + 0.25, function()
        notification:remove()
    end)

    table.insert(Library.Notifs, notification)
    NotifContainer.Position = UDim2.new(0,Position.X,0,Position.Y + (table.find(Library.Notifs, notification) * 25))
    NotifContainer.Size = UDim2.new(0,TextLabel.TextBounds.X + 4,0,16)
    Library:updateNotifsPositions(position)

    return notification
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
			elseif Obj:IsA("ImageLabel") then
				Obj.ImageColor3 = Library.Accent;
			elseif Obj:IsA("UIStroke") then
				Obj.Color = Library.Accent;
			end;
		end;
		return Obj;
	end;

	-- // Library Functions
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
				Name = Options.name or Options.Name or "dmt";
				Status = Options.status or Options.Status or "private build";
			};
			--
			local DMT = Instance.new("ScreenGui")
			local Outline = Library:NewInstance("Frame", true)
			local Inline = Instance.new("Frame")
			local Top = Instance.new("TextButton")
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			local Status = Instance.new("TextLabel")
			local StatusShadow = Instance.new("TextLabel")
			local shadowHolder = Instance.new("Frame")
			local ambientShadow = Instance.new("ImageLabel")
			local Line = Instance.new("Frame")
			local Tabs = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			--
			DMT.Name = "DMT"
			DMT.Parent = game.CoreGui
			DMT.DisplayOrder = 1000
			DMT.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			Library.ScreenGUI = DMT

			Outline.Name = "Outline"
			Outline.Parent = DMT
			Outline.AnchorPoint = Vector2.new(0.5, 0.5)
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.BorderSizePixel = 0
			Outline.Position = UDim2.new(0.5, 0, 0.5, 0)
			Outline.Size = UDim2.new(0, 580, 0, 470)

			Inline.Name = "Inline"
			Inline.Parent = Outline
			Inline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			Top.Name = "Top"
			Top.Parent = Inline
			Top.BackgroundColor3 = Color3.fromRGB(28, 30, 32)
			Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Top.BorderSizePixel = 0
			Top.Size = UDim2.new(1, 0, 0, 18)
			Top.ZIndex = 2
			Top.AutoButtonColor = false
			Top.Text = ""

			Title.Name = "Title"
			Title.Parent = Top
			Title.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 5, 0, 0)
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Window.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = Top
			TitleShadow.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 6, 0, 1)
			TitleShadow.Size = UDim2.new(1, 0, 1, 0)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Window.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left

			Status.Name = "Status"
			Status.Parent = Top
			Status.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
			Status.BackgroundTransparency = 1.000
			Status.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Status.BorderSizePixel = 0
			Status.Position = UDim2.new(0, -5, 0, 0)
			Status.Size = UDim2.new(1, 0, 1, 0)
			Status.ZIndex = 2
			Status.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Status.Text = Window.Status
			Status.TextColor3 = Color3.fromRGB(245, 245, 245)
			Status.TextSize = Library.FSize
			Status.TextXAlignment = Enum.TextXAlignment.Right

			StatusShadow.Name = "StatusShadow"
			StatusShadow.Parent = Top
			StatusShadow.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
			StatusShadow.BackgroundTransparency = 1.000
			StatusShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			StatusShadow.BorderSizePixel = 0
			StatusShadow.Position = UDim2.new(0, -4, 0, 1)
			StatusShadow.Size = UDim2.new(1, 0, 1, 0)
			StatusShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			StatusShadow.Text = Window.Status
			StatusShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			StatusShadow.TextSize = Library.FSize
			StatusShadow.TextXAlignment = Enum.TextXAlignment.Right

			shadowHolder.Name = "shadowHolder"
			shadowHolder.Parent = Top
			shadowHolder.BackgroundTransparency = 1.000
			shadowHolder.Position = UDim2.new(0, 0, 1, 0)
			shadowHolder.Size = UDim2.new(1, 0, 1, 0)

			ambientShadow.Name = "ambientShadow"
			ambientShadow.Parent = shadowHolder
			ambientShadow.AnchorPoint = Vector2.new(0.5, 0)
			ambientShadow.BackgroundTransparency = 1.000
			ambientShadow.Position = UDim2.new(0.5, 0, 0, 0)
			ambientShadow.Size = UDim2.new(1, 0, 1, 0)
			ambientShadow.Image = "rbxassetid://3484053161"
			ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

			Line.Name = "Line"
			Line.Parent = Inline
			Line.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0, 130, 0, 39)
			Line.Size = UDim2.new(0, 1, 1, -60)

			Tabs.Name = "Tabs"
			Tabs.Parent = Inline
			Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Tabs.BackgroundTransparency = 1.000
			Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Tabs.BorderSizePixel = 0
			Tabs.Position = UDim2.new(0, 5, 0, 39)
			Tabs.Size = UDim2.new(0, 120, 1, -60)

			UIListLayout.Parent = Tabs
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			-- // Elements
			Window.Elements = {
				TabHolder = Tabs,
				Holder = Inline
			}

			-- // Dragging
			Library:Connection(Top.MouseButton1Down, function()
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
					Page.Elements.PageButton.Size = UDim2.new(1,0,1/#Window.Pages,0)
				end
			end

			-- // Returns
			Library.Holder = Outline
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
			local AccentLine = Library:NewInstance("Frame", true)
			local PageName = Instance.new("TextLabel")
			local PageNameShadow = Instance.new("TextLabel")
			local NPage = Instance.new("Frame")
			local Left = Instance.new("Frame")
			local LeftLayout = Instance.new("UIListLayout")
			local Right = Instance.new("Frame")
			local RightLayout = Instance.new("UIListLayout")
			local MultiHolder = Instance.new("Frame")
			local MultiLayout = Instance.new("UIListLayout")
			--
			NewPage.Name = "NewPage"
			NewPage.Parent = Page.Window.Elements.TabHolder
			NewPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewPage.BackgroundTransparency = 1.000
			NewPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewPage.BorderSizePixel = 0
			NewPage.Size = UDim2.new(1, 0, 0.200000003, 0)
			NewPage.AutoButtonColor = false
			NewPage.Font = Enum.Font.SourceSans
			NewPage.Text = ""
			NewPage.TextColor3 = Color3.fromRGB(245, 245, 245)
			NewPage.TextSize = 14.000
			NewPage.ZIndex = 5

			AccentLine.Name = "AccentLine"
			AccentLine.Parent = NewPage
			AccentLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AccentLine.BorderSizePixel = 0
			AccentLine.Position = UDim2.new(1, 5, 0, 0)
			AccentLine.Size = UDim2.new(0, 1, 1, 0)
			AccentLine.Visible = false

			PageName.Name = "PageName"
			PageName.Parent = NewPage
			PageName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PageName.BackgroundTransparency = 1.000
			PageName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageName.BorderSizePixel = 0
			PageName.Size = UDim2.new(1, 0, 1, 0)
			PageName.ZIndex = 2
			PageName.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			PageName.Text = Page.Name
			PageName.TextColor3 = Color3.fromRGB(145,145,145)
			PageName.TextSize = Library.FSize

			PageNameShadow.Name = "PageNameShadow"
			PageNameShadow.Parent = NewPage
			PageNameShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PageNameShadow.BackgroundTransparency = 1.000
			PageNameShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageNameShadow.BorderSizePixel = 0
			PageNameShadow.Position = UDim2.new(0, 1, 0, 1)
			PageNameShadow.Size = UDim2.new(1, 0, 1, 0)
			PageNameShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			PageNameShadow.Text = Page.Name
			PageNameShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			PageNameShadow.TextSize = Library.FSize

			NPage.Name = "Page"
			NPage.Parent = Page.Window.Elements.Holder
			NPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NPage.BackgroundTransparency = 1.000
			NPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NPage.BorderSizePixel = 0
			NPage.Position = UDim2.new(0, 144, 0, 39)
			NPage.Size = UDim2.new(0, 421, 1, -60)
			NPage.Visible = false

			Left.Name = "Left"
			Left.Parent = NPage
			Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Left.BackgroundTransparency = 1.000
			Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Left.BorderSizePixel = 0
			Left.Size = UDim2.new(0.5, -2, 1, 0)
			Left.ZIndex = 2

			LeftLayout.Name = "LeftLayout"
			LeftLayout.Parent = Left
			LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
			LeftLayout.Padding = UDim.new(0, 6)

			Right.Name = "Right"
			Right.Parent = NPage
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.Position = UDim2.new(0.5, 2, 0, 0)
			Right.Size = UDim2.new(0.5, -2, 1, 0)

			RightLayout.Name = "RightLayout"
			RightLayout.Parent = Right
			RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
			RightLayout.Padding = UDim.new(0, 6)
			
			MultiHolder.Name = "Multi-Holder"
			MultiHolder.Parent = Page.Window.Elements.Holder
			MultiHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MultiHolder.BackgroundTransparency = 1.000
			MultiHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MultiHolder.BorderSizePixel = 0
			MultiHolder.Position = UDim2.new(0, 144, 0, 25)
			MultiHolder.Size = UDim2.new(0, 421, 0, 25)
			MultiHolder.Visible = false

			MultiLayout.Name = "MultiLayout"
			MultiLayout.Parent = MultiHolder
			MultiLayout.FillDirection = Enum.FillDirection.Horizontal
			MultiLayout.SortOrder = Enum.SortOrder.LayoutOrder

			function Page:Turn(bool)
				Page.Open = bool
				NPage.Visible = Page.Open
				AccentLine.Visible = Page.Open
				PageName.TextColor3 = Page.Open and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
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
			--
			Library:Connection(NewPage.MouseEnter, function() 
				if not Page.Open then
					PageName.TextColor3 = Color3.fromRGB(200,200,200)
				end
			end)
			--
			Library:Connection(NewPage.MouseLeave, function() 
				if not Page.Open then
					PageName.TextColor3 = Color3.fromRGB(145,145,145)
				end
			end)

			-- // Elements
			Page.Elements = {
				Left = Left,
				Right = Right,
				MultiHolder = MultiHolder,
				RealPage = NPage,
				PageButton = NewPage
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
				Zindex = (Properties.Zindex or Properties.zindex or 1),
				Elements = {},
				Content = {},
				Sections = {},
				Limit = (Properties.Limit or Properties.limit or false),
			}
			--
			local NewSection = Library:NewInstance("Frame", true)
			local SectionInline = Instance.new("Frame")
			local Content = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local Space = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			local Close = Instance.new("ImageButton")

			NewSection.Name = "NewSection"
			NewSection.Parent = Section.Side == "left" and Section.Page.Elements.Left or Section.Side == "right" and Section.Page.Elements.Right
			NewSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewSection.BorderSizePixel = 0
			NewSection.Size = UDim2.new(1, 0, 0, 12)
			NewSection.AutomaticSize = Enum.AutomaticSize.Y
			NewSection.ZIndex = Section.Zindex

			SectionInline.Name = "SectionInline"
			SectionInline.Parent = NewSection
			SectionInline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			SectionInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionInline.BorderSizePixel = 0
			SectionInline.Position = UDim2.new(0, 1, 0, 1)
			SectionInline.Size = UDim2.new(1, -2, 1, -2)

			Content.Name = "Content"
			Content.Parent = SectionInline
			Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Content.BackgroundTransparency = 1.000
			Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Content.BorderSizePixel = 0
			Content.Position = UDim2.new(0, 7, 0, 10)
			Content.Size = UDim2.new(1, -14, 0, 0)

			UIListLayout.Parent = Content
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 8)

			Space.Name = "Space"
			Space.Parent = Content
			Space.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Space.BackgroundTransparency = 1.000
			Space.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Space.BorderSizePixel = 0
			Space.LayoutOrder = 1000
			Space.Size = UDim2.new(1, 0, 0, 2)

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = NewSection
			SectionTitle.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTitle.BorderSizePixel = 0
			SectionTitle.BackgroundTransparency = 1
			SectionTitle.Position = UDim2.new(0, 5, 0, -5)
			SectionTitle.Size = UDim2.new(0, 0, 0, 8)
			SectionTitle.ZIndex = 3
			SectionTitle.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			SectionTitle.Text = Section.Name
			SectionTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
			SectionTitle.TextSize = Library.FSize
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			SectionTitle.AutomaticSize = Enum.AutomaticSize.X

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewSection
			TitleShadow.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 6, 0, -4)
			TitleShadow.Size = UDim2.new(0, 0, 0, 8)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Section.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left
			TitleShadow.AutomaticSize = Enum.AutomaticSize.X
			
			Close.Name = "Close"
			Close.Parent = NewSection
			Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Close.BackgroundTransparency = 1.000
			Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Close.BorderSizePixel = 0
			Close.Position = UDim2.new(1, -12, 0, 3)
			Close.Size = UDim2.new(0, 9, 0, 6)
			Close.Image = "http://www.roblox.com/asset/?id=16843282447"
			
			Library:Connection(Close.MouseButton1Down, function() 
				Content.Visible = not Content.Visible
			end)

			-- // Elements
			Section.Elements = {
				SectionContent = Content;
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
			local Box = Instance.new("Frame")
			local Accent = Library:NewInstance("Frame", true)
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")

			NewToggle.Name = "NewToggle"
			NewToggle.Parent = Toggle.Section.Elements.SectionContent
			NewToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewToggle.BackgroundTransparency = 1.000
			NewToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewToggle.BorderSizePixel = 0
			NewToggle.Size = UDim2.new(1, 0, 0, 14)
			NewToggle.Font = Enum.Font.SourceSans
			NewToggle.Text = ""
			NewToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			NewToggle.TextSize = 14.000

			Box.Name = "Box"
			Box.Parent = NewToggle
			Box.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			Box.BorderColor3 = Color3.fromRGB(59, 59, 60)
			Box.Size = UDim2.new(0, 14, 0, 14)

			Accent.Name = "Accent"
			Accent.Parent = Box
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(1, 0, 1, 0)
			Accent.Visible = false

			Title.Name = "Title"
			Title.Parent = NewToggle
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 22, 0, 0)
			Title.Size = UDim2.new(0, 100, 1, 0)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Toggle.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewToggle
			TitleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 23, 0, 1)
			TitleShadow.Size = UDim2.new(0, 100, 1, 0)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Toggle.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left

			-- // Functions
			local function SetState()
				Toggle.Toggled = not Toggle.Toggled
				Accent.Visible = Toggle.Toggled
				Library.Flags[Toggle.Flag] = Toggle.Toggled
				Toggle.Callback(Toggle.Toggled)
			end
			--
			Library:Connection(NewToggle.MouseButton1Down, SetState)
			Library:Connection(NewToggle.MouseEnter, function()
				if not Toggle.Toggled then
					Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				end
			end)
			--
			Library:Connection(NewToggle.MouseLeave, function()
				if not Toggle.Toggled then
					Box.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
				end
			end)
			
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
				local Value = Instance.new("TextButton")
				local ModeBox = Instance.new("Frame")
				local Inline = Instance.new("Frame")
				local Hold = Instance.new("TextButton")
				local HoldShadow = Instance.new("TextLabel")
				local Toggle = Instance.new("TextButton")
				local ToggleShadow = Instance.new("TextLabel")
				local Always = Instance.new("TextButton")
				local AlwaysShadow = Instance.new("TextLabel")
				local ValueShadow = Instance.new("TextLabel")
				--
				Value.Name = "Value"
				Value.Parent = NewToggle
				Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Value.BackgroundTransparency = 1.000
				Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Value.BorderSizePixel = 0
				Value.Position = UDim2.new(1, -30, 0, 0)
				Value.Size = UDim2.new(0, 30, 1, 0)
				Value.ZIndex = 2
				Value.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				Value.Text = "[unk]"
				Value.TextColor3 = Color3.fromRGB(245, 245, 245)
				Value.TextSize = Library.FSize
				Value.TextXAlignment = Enum.TextXAlignment.Right
				Value.AutoButtonColor = false

				ModeBox.Name = "ModeBox"
				ModeBox.Parent = Value
				ModeBox.BackgroundColor3 = Color3.fromRGB(214, 112, 112)
				ModeBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ModeBox.BorderSizePixel = 0
				ModeBox.Size = UDim2.new(0, 50, 0, 60)
				ModeBox.Position = UDim2.new(0,-20,0,0)
				ModeBox.Visible = false

				Inline.Name = "Inline"
				Inline.Parent = ModeBox
				Inline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
				Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Inline.BorderSizePixel = 0
				Inline.Position = UDim2.new(0, 1, 0, 1)
				Inline.Size = UDim2.new(1, -2, 1, -2)

				Hold.Name = "Hold"
				Hold.Parent = Inline
				Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Hold.BackgroundTransparency = 1.000
				Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Hold.BorderSizePixel = 0
				Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
				Hold.ZIndex = 2
				Hold.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				Hold.Text = "hold"
				Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
				Hold.TextSize = Library.FSize

				HoldShadow.Name = "HoldShadow"
				HoldShadow.Parent = Inline
				HoldShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HoldShadow.BackgroundTransparency = 1.000
				HoldShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				HoldShadow.BorderSizePixel = 0
				HoldShadow.Position = UDim2.new(0, 1, 0, 1)
				HoldShadow.Size = UDim2.new(1, 0, 0.333000004, 0)
				HoldShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				HoldShadow.Text = "hold"
				HoldShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
				HoldShadow.TextSize = Library.FSize

				Toggle.Name = "Toggle"
				Toggle.Parent = Inline
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BackgroundTransparency = 1.000
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0, 0, 0.333000004, 0)
				Toggle.Size = UDim2.new(1, 0, 0.333000004, 0)
				Toggle.ZIndex = 2
				Toggle.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				Toggle.Text = "toggle"
				Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
				Toggle.TextSize = Library.FSize

				ToggleShadow.Name = "ToggleShadow"
				ToggleShadow.Parent = Inline
				ToggleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleShadow.BackgroundTransparency = 1.000
				ToggleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleShadow.BorderSizePixel = 0
				ToggleShadow.Position = UDim2.new(0, 1, 0.333000004, 1)
				ToggleShadow.Size = UDim2.new(1, 0, 0.333000004, 0)
				ToggleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				ToggleShadow.Text = "toggle"
				ToggleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleShadow.TextSize = Library.FSize

				Always.Name = "Always"
				Always.Parent = Inline
				Always.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Always.BackgroundTransparency = 1.000
				Always.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Always.BorderSizePixel = 0
				Always.Position = UDim2.new(0, 0, 0.666999996, 0)
				Always.Size = UDim2.new(1, 0, 0.333000004, 0)
				Always.ZIndex = 2
				Always.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				Always.Text = "always"
				Always.TextColor3 = Keybind.Mode == "Always" and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
				Always.TextSize = Library.FSize

				AlwaysShadow.Name = "AlwaysShadow"
				AlwaysShadow.Parent = Inline
				AlwaysShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				AlwaysShadow.BackgroundTransparency = 1.000
				AlwaysShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				AlwaysShadow.BorderSizePixel = 0
				AlwaysShadow.Position = UDim2.new(0, 1, 0.666999996, 1)
				AlwaysShadow.Size = UDim2.new(1, 0, 0.333000004, 0)
				AlwaysShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				AlwaysShadow.Text = "always"
				AlwaysShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
				AlwaysShadow.TextSize = Library.FSize

				ValueShadow.Name = "ValueShadow"
				ValueShadow.Parent = NewToggle
				ValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ValueShadow.BackgroundTransparency = 1.000
				ValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueShadow.BorderSizePixel = 0
				ValueShadow.Position = UDim2.new(1, -29, 0, 1)
				ValueShadow.Size = UDim2.new(0, 30, 1, 0)
				ValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				ValueShadow.Text = "[unk]"
				ValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
				ValueShadow.TextSize = Library.FSize
				ValueShadow.TextXAlignment = Enum.TextXAlignment.Right

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
							local text = "[unk]"

							Value.Text = text
							ValueShadow.Text = text
						elseif newkey ~= nil then
							Key = newkey
							if Keybind.UseKey then
								if Keybind.Flag then
									Library.Flags[Keybind.Flag] = Key
								end
								Keybind.Callback(Key)
							end
							local text = string.lower("[" .. (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", "")) .. "]")

							Value.Text = text
							ValueShadow.Text = text
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
				Value.MouseButton1Click:Connect(function()
					if not Keybind.Binding then

						Value.Text = "[...]"
						ValueShadow.Text = "[...]"

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
				Library:Connection(Value.MouseButton2Down, function()
					ModeBox.Visible = true
					NewToggle.ZIndex = 5
				end)
				--
				Library:Connection(Hold.MouseButton1Down, function()
					set("Hold")
					Hold.TextColor3 = Color3.fromRGB(245, 245, 245)
					Toggle.TextColor3 = Color3.fromRGB(145,145,145)
					Always.TextColor3 = Color3.fromRGB(145,145,145)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				--
				Library:Connection(Toggle.MouseButton1Down, function()
					set("Toggle")
					Hold.TextColor3 = Color3.fromRGB(145,145,145)
					Toggle.TextColor3 = Color3.fromRGB(245, 245, 245)
					Always.TextColor3 = Color3.fromRGB(145,145,145)
					ModeBox.Visible = false
					NewToggle.ZIndex = 1
				end)
				--
				Library:Connection(Always.MouseButton1Down, function()
					set("Always")
					Hold.TextColor3 = Color3.fromRGB(145,145,145)
					Toggle.TextColor3 = Color3.fromRGB(145,145,145)
					Always.TextColor3 = Color3.fromRGB(245, 245, 245)
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
			local Slide = Instance.new("TextButton")
			local Accent = Library:NewInstance("TextButton", true)
			local Shadow = Instance.new("Frame")
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			local Value = Instance.new("TextLabel")
			local ValueShadow = Instance.new("TextLabel")
			--
			NewSlider.Name = "NewSlider"
			NewSlider.Parent = Slider.Section.Elements.SectionContent
			NewSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewSlider.BackgroundTransparency = 1.000
			NewSlider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewSlider.BorderSizePixel = 0
			NewSlider.Size = UDim2.new(1, 0, 0, 16)

			Slide.Name = "Slide"
			Slide.Parent = NewSlider
			Slide.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			Slide.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slide.BorderSizePixel = 0
			Slide.Position = UDim2.new(0, -2, 1, -5)
			Slide.Size = UDim2.new(0, 120, 0, 5)
			Slide.AutoButtonColor = false
			Slide.Font = Enum.Font.SourceSans
			Slide.Text = ""
			Slide.TextColor3 = Color3.fromRGB(0, 0, 0)
			Slide.TextSize = 14.000

			Accent.Name = "Accent"
			Accent.Parent = Slide
			Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Accent.BorderSizePixel = 0
			Accent.Size = UDim2.new(0.5, 0, 1, 0)
			Accent.AutoButtonColor = false
			Accent.Font = Enum.Font.SourceSans
			Accent.Text = ""
			Accent.TextColor3 = Color3.fromRGB(0, 0, 0)
			Accent.TextSize = 14.000

			Shadow.Name = "Shadow"
			Shadow.Parent = Accent
			Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Shadow.BackgroundTransparency = 0.800
			Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Shadow.BorderSizePixel = 0
			Shadow.Position = UDim2.new(1, -4, 0, 0)
			Shadow.Size = UDim2.new(0, 4, 1, 0)

			Title.Name = "Title"
			Title.Parent = NewSlider
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(0, 100, 0, 10)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Slider.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewSlider
			TitleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 1, 0, 1)
			TitleShadow.Size = UDim2.new(0, 100, 0, 10)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Slider.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left

			Value.Name = "Value"
			Value.Parent = NewSlider
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(0, 18, 0, 0)
			Value.Size = UDim2.new(0, 100, 0, 10)
			Value.ZIndex = 2
			Value.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Value.Text = "0"
			Value.TextColor3 = Color3.fromRGB(245, 245, 245)
			Value.TextSize = Library.FSize
			Value.TextXAlignment = Enum.TextXAlignment.Right

			ValueShadow.Name = "ValueShadow"
			ValueShadow.Parent = NewSlider
			ValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueShadow.BackgroundTransparency = 1.000
			ValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.BorderSizePixel = 0
			ValueShadow.Position = UDim2.new(0, 19, 0, 1)
			ValueShadow.Size = UDim2.new(0, 100, 0, 10)
			ValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			ValueShadow.Text = "0"
			ValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.TextSize = Library.FSize
			ValueShadow.TextXAlignment = Enum.TextXAlignment.Right

			-- // Functions
			local Sliding = false
			local Val = Slider.State
			local function Set(value)
				value = math.clamp(Library:Round(value, Slider.Decimals), Slider.Min, Slider.Max)

				local sizeX = ((value - Slider.Min) / (Slider.Max - Slider.Min))
				Accent.Size = UDim2.new(sizeX, 0, 1, 0)
				if Slider.Disabled and value == Slider.Min then
					Value.Text = Slider.Disabled
					ValueShadow.Text = Slider.Disabled
				else
					Value.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))
					ValueShadow.Text = TextValue:gsub("%[value%]", string.format("%.14g", value))
				end
				Val = value

				Library.Flags[Slider.Flag] = value
				Slider.Callback(value)
			end				
			--
			local function ISlide(input)
				local sizeX = (input.Position.X - Slide.AbsolutePosition.X) / Slide.AbsoluteSize.X
				local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
				Set(value)
			end
			--
			Library:Connection(Slide.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					ISlide(input)
				end
			end)
			Library:Connection(Slide.InputEnded, function(input)
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
			Library:Connection(Slide.MouseEnter, function()
				Slide.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
			end)
			--
			Library:Connection(Slide.MouseLeave, function()
				Slide.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
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
			local Outline = Library:NewInstance("Frame", true)
			local Inline = Instance.new("TextButton")
			local Value = Instance.new("TextLabel")
			local ValueShadow = Instance.new("TextLabel")
			local Content = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			--
			NewList.Name = "NewList"
			NewList.Parent = Dropdown.Section.Elements.SectionContent
			NewList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewList.BackgroundTransparency = 1.000
			NewList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewList.BorderSizePixel = 0
			NewList.Size = UDim2.new(1, 0, 0, 30)

			Outline.Name = "Outline"
			Outline.Parent = NewList
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.BorderSizePixel = 0
			Outline.Position = UDim2.new(0, -2, 1, -18)
			Outline.Size = UDim2.new(0, 122, 0, 18)

			Inline.Name = "Inline"
			Inline.Parent = Outline
			Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.AutoButtonColor = false
			Inline.Font = Enum.Font.SourceSans
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14.000

			Value.Name = "Value"
			Value.Parent = Inline
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.ZIndex = 2
			Value.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Value.Text = ""
			Value.TextColor3 = Color3.fromRGB(245, 245, 245)
			Value.TextSize = Library.FSize

			ValueShadow.Name = "ValueShadow"
			ValueShadow.Parent = Inline
			ValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueShadow.BackgroundTransparency = 1.000
			ValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.BorderSizePixel = 0
			ValueShadow.Position = UDim2.new(0, 1, 0, 1)
			ValueShadow.Size = UDim2.new(1, 0, 1, 0)
			ValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			ValueShadow.Text = ""
			ValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.TextSize = Library.FSize

			Content.Name = "Content"
			Content.Parent = Outline
			Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Content.BorderSizePixel = 0
			Content.Position = UDim2.new(0, 0, 1, 0)
			Content.Size = UDim2.new(1, 0, 0, 0)
			Content.Visible = false
			Content.AutomaticSize = Enum.AutomaticSize.Y

			UIListLayout.Parent = Content
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			Title.Name = "Title"
			Title.Parent = NewList
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(0, 100, 0, 10)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Dropdown.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewList
			TitleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 1, 0, 1)
			TitleShadow.Size = UDim2.new(0, 100, 0, 10)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Dropdown.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left

			-- // Connections
			Library:Connection(Inline.MouseButton1Down, function()
				Content.Visible = not Content.Visible
				if Content.Visible then
					NewList.ZIndex = 3
				else
					NewList.ZIndex = 1
				end
			end)
			Library:Connection(game:GetService("UserInputService").InputBegan, function(Input)
				if Content.Visible and Input.UserInputType == Enum.UserInputType.MouseButton1 then
					if not Library:IsMouseOverFrame(Content) and not Library:IsMouseOverFrame(Inline) then
						Content.Visible = false
						NewList.ZIndex = 1
					end
				end
			end)
			Library:Connection(Inline.MouseEnter, function()
				Inline.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
			end)
			--
			Library:Connection(Inline.MouseLeave, function()
				Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			end)
			--
			local chosen = Dropdown.Max and {} or nil
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
							ValueShadow.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						else
							if #chosen == Dropdown.Max then
								table.remove(chosen, 1)
							end

							table.insert(chosen, option)

							local textchosen = {}
							local cutobject = false

							for _, opt in next, chosen do
								table.insert(textchosen, opt)
							end

							Value.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")
							ValueShadow.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

							Library.Flags[Dropdown.Flag] = chosen
							Dropdown.Callback(chosen)
						end
					else
						chosen = option
						Value.Text = option
						ValueShadow.Text = option
						Content.Visible = false
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
					local NewOption = Instance.new("TextButton")
					local Accent = Library:NewInstance("Frame", true)
					local Option = Instance.new("TextLabel")
					local OptionShadow = Instance.new("TextLabel")
					--
					NewOption.Name = "NewOption"
					NewOption.Parent = Content
					NewOption.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
					NewOption.BorderColor3 = Color3.fromRGB(61,61,61)
					NewOption.BorderSizePixel = 0
					NewOption.Size = UDim2.new(1, 0, 0, 18)
					NewOption.AutoButtonColor = false
					NewOption.Text = ""
					Dropdown.OptionInsts[option].button = NewOption
					
					Accent.Name = "Accent"
					Accent.Parent = NewOption
					Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Accent.BorderSizePixel = 0
					Accent.Position = UDim2.new(0, 0, 1, -1)
					Accent.Size = UDim2.new(1, 0, 0, 1)

					Option.Name = "Option"
					Option.Parent = NewOption
					Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Option.BackgroundTransparency = 1.000
					Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Option.BorderSizePixel = 0
					Option.Size = UDim2.new(1, 0, 1, 0)
					Option.ZIndex = 2
					Option.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
					Option.Text = option
					Option.TextColor3 = Color3.fromRGB(245, 245, 245)
					Option.TextSize = Library.FSize

					OptionShadow.Name = "OptionShadow"
					OptionShadow.Parent = NewOption
					OptionShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					OptionShadow.BackgroundTransparency = 1.000
					OptionShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
					OptionShadow.BorderSizePixel = 0
					OptionShadow.Position = UDim2.new(0, 1, 0, 1)
					OptionShadow.Size = UDim2.new(1, 0, 1, 0)
					OptionShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
					OptionShadow.Text = option
					OptionShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
					OptionShadow.TextSize = Library.FSize
					
					Dropdown.OptionInsts[option].text = Option
					
					Library:Connection(NewOption.MouseEnter, function() 
						NewOption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
					end)
					Library:Connection(NewOption.MouseLeave, function() 
						NewOption.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
					end)

					handleoptionclick(option, NewOption, Option)
				end
			end
			createoptions(Dropdown.Options)
			--
			local set
			set = function(option)
				if Dropdown.Max then
					table.clear(chosen)
					option = type(option) == "table" and option or {}

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
					ValueShadow.Text = #chosen == 0 and "" or table.concat(textchosen, ",") .. (cutobject and ", ..." or "")

					Library.Flags[Dropdown.Flag] = chosen
					Dropdown.Callback(chosen)
				end
			end
			--
			function Dropdown:Set(option)
				if Dropdown.Max then
					set(option)
				else
					if table.find(Dropdown.Options, option) then
						chosen = option
						Value.Text = option
						ValueShadow.Text = option
						Library.Flags[Dropdown.Flag] = chosen
						Dropdown.Callback(chosen)
					else
						chosen = nil
						Value.Text = "unk"
						ValueShadow.Text = "unk"
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
			local NewColor = Instance.new("Frame")
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")

			NewColor.Name = "NewColor"
			NewColor.Parent = Colorpicker.Section.Elements.SectionContent
			NewColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewColor.BackgroundTransparency = 1.000
			NewColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewColor.BorderSizePixel = 0
			NewColor.Size = UDim2.new(1, 0, 0, 10)

			Title.Name = "Title"
			Title.Parent = NewColor
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(0, 100, 1, 0)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Colorpicker.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewColor
			TitleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 1, 0, 1)
			TitleShadow.Size = UDim2.new(0, 100, 1, 0)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Colorpicker.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left

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
			local NewBind = Instance.new("Frame")
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			local Value = Instance.new("TextButton")
			local ModeBox = Instance.new("Frame")
			local Inline = Instance.new("Frame")
			local Hold = Instance.new("TextButton")
			local HoldShadow = Instance.new("TextLabel")
			local Toggle = Instance.new("TextButton")
			local ToggleShadow = Instance.new("TextLabel")
			local Always = Instance.new("TextButton")
			local AlwaysShadow = Instance.new("TextLabel")
			local ValueShadow = Instance.new("TextLabel")
			--
			NewBind.Name = "NewBind"
			NewBind.Parent = Keybind.Section.Elements.SectionContent
			NewBind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewBind.BackgroundTransparency = 1.000
			NewBind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewBind.BorderSizePixel = 0
			NewBind.Size = UDim2.new(1, 0, 0, 10)

			Title.Name = "Title"
			Title.Parent = NewBind
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(0, 100, 1, 0)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Keybind.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewBind
			TitleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 1, 0, 1)
			TitleShadow.Size = UDim2.new(0, 100, 1, 0)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Keybind.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left

			Value.Name = "Value"
			Value.Parent = NewBind
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Position = UDim2.new(1, -30, 0, 0)
			Value.Size = UDim2.new(0, 30, 1, 0)
			Value.ZIndex = 2
			Value.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Value.Text = "[unk]"
			Value.TextColor3 = Color3.fromRGB(245, 245, 245)
			Value.TextSize = Library.FSize
			Value.TextXAlignment = Enum.TextXAlignment.Right
			Value.AutoButtonColor = false

			ModeBox.Name = "ModeBox"
			ModeBox.Parent = Value
			ModeBox.BackgroundColor3 = Color3.fromRGB(214, 112, 112)
			ModeBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ModeBox.BorderSizePixel = 0
			ModeBox.Size = UDim2.new(0, 50, 0, 60)
			ModeBox.Position = UDim2.new(0,-20,0,0)
			ModeBox.Visible = false

			Inline.Name = "Inline"
			Inline.Parent = ModeBox
			Inline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)

			Hold.Name = "Hold"
			Hold.Parent = Inline
			Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hold.BackgroundTransparency = 1.000
			Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hold.BorderSizePixel = 0
			Hold.Size = UDim2.new(1, 0, 0.333000004, 0)
			Hold.ZIndex = 2
			Hold.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Hold.Text = "hold"
			Hold.TextColor3 = Keybind.Mode == "Hold" and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
			Hold.TextSize = Library.FSize

			HoldShadow.Name = "HoldShadow"
			HoldShadow.Parent = Inline
			HoldShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HoldShadow.BackgroundTransparency = 1.000
			HoldShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			HoldShadow.BorderSizePixel = 0
			HoldShadow.Position = UDim2.new(0, 1, 0, 1)
			HoldShadow.Size = UDim2.new(1, 0, 0.333000004, 0)
			HoldShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			HoldShadow.Text = "hold"
			HoldShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			HoldShadow.TextSize = Library.FSize

			Toggle.Name = "Toggle"
			Toggle.Parent = Inline
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BackgroundTransparency = 1.000
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0, 0, 0.333000004, 0)
			Toggle.Size = UDim2.new(1, 0, 0.333000004, 0)
			Toggle.ZIndex = 2
			Toggle.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Toggle.Text = "toggle"
			Toggle.TextColor3 = Keybind.Mode == "Toggle" and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
			Toggle.TextSize = Library.FSize

			ToggleShadow.Name = "ToggleShadow"
			ToggleShadow.Parent = Inline
			ToggleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleShadow.BackgroundTransparency = 1.000
			ToggleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleShadow.BorderSizePixel = 0
			ToggleShadow.Position = UDim2.new(0, 1, 0.333000004, 1)
			ToggleShadow.Size = UDim2.new(1, 0, 0.333000004, 0)
			ToggleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			ToggleShadow.Text = "toggle"
			ToggleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			ToggleShadow.TextSize = Library.FSize

			Always.Name = "Always"
			Always.Parent = Inline
			Always.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Always.BackgroundTransparency = 1.000
			Always.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Always.BorderSizePixel = 0
			Always.Position = UDim2.new(0, 0, 0.666999996, 0)
			Always.Size = UDim2.new(1, 0, 0.333000004, 0)
			Always.ZIndex = 2
			Always.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Always.Text = "always"
			Always.TextColor3 = Keybind.Mode == "Always" and Color3.fromRGB(245,245,245) or Color3.fromRGB(145,145,145)
			Always.TextSize = Library.FSize

			AlwaysShadow.Name = "AlwaysShadow"
			AlwaysShadow.Parent = Inline
			AlwaysShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			AlwaysShadow.BackgroundTransparency = 1.000
			AlwaysShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			AlwaysShadow.BorderSizePixel = 0
			AlwaysShadow.Position = UDim2.new(0, 1, 0.666999996, 1)
			AlwaysShadow.Size = UDim2.new(1, 0, 0.333000004, 0)
			AlwaysShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			AlwaysShadow.Text = "always"
			AlwaysShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			AlwaysShadow.TextSize = Library.FSize

			ValueShadow.Name = "ValueShadow"
			ValueShadow.Parent = NewBind
			ValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueShadow.BackgroundTransparency = 1.000
			ValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.BorderSizePixel = 0
			ValueShadow.Position = UDim2.new(1, -29, 0, 1)
			ValueShadow.Size = UDim2.new(0, 30, 1, 0)
			ValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			ValueShadow.Text = "[unk]"
			ValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.TextSize = Library.FSize
			ValueShadow.TextXAlignment = Enum.TextXAlignment.Right

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
						local text = "[unk]"

						Value.Text = text
						ValueShadow.Text = text
					elseif newkey ~= nil then
						Key = newkey
						if Keybind.UseKey then
							if Keybind.Flag then
								Library.Flags[Keybind.Flag] = Key
							end
							Keybind.Callback(Key)
						end
						local text = string.lower("[" .. (Library.Keys[newkey] or tostring(newkey):gsub("Enum.KeyCode.", "")) .. "]")

						Value.Text = text
						ValueShadow.Text = text
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
			Value.MouseButton1Click:Connect(function()
				if not Keybind.Binding then

					Value.Text = "[...]"
					ValueShadow.Text = "[...]"

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
			Library:Connection(Value.MouseButton2Down, function()
				ModeBox.Visible = true
				NewBind.ZIndex = 5
			end)
			--
			Library:Connection(Hold.MouseButton1Down, function()
				set("Hold")
				Hold.TextColor3 = Color3.fromRGB(245, 245, 245)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			--
			Library:Connection(Toggle.MouseButton1Down, function()
				set("Toggle")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(245, 245, 245)
				Always.TextColor3 = Color3.fromRGB(145,145,145)
				ModeBox.Visible = false
				NewBind.ZIndex = 1
			end)
			--
			Library:Connection(Always.MouseButton1Down, function()
				set("Always")
				Hold.TextColor3 = Color3.fromRGB(145,145,145)
				Toggle.TextColor3 = Color3.fromRGB(145,145,145)
				Always.TextColor3 = Color3.fromRGB(245, 245, 245)
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
		function Sections:Section(Properties)
			if not Properties then
				Properties = {}
			end
			--
			local Section = {
				Name = Properties.Name or "Section",
				Zindex = Properties.Zindex or Properties.zindex or 1,
				Page = self,
				Window = self.Page,
				Elements = {},
				Content = {},
				Open = false,
			}
			--
			local NewSection = Library:NewInstance("Frame", true)
			local SectionInline = Instance.new("Frame")
			local Content = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local Space = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			local Close = Instance.new("ImageButton")

			NewSection.Name = "NewSection"
			NewSection.Parent = Section.Page.Elements.SectionContent
			NewSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewSection.BorderSizePixel = 0
			NewSection.Size = UDim2.new(0, 157, 0, 12)
			NewSection.AutomaticSize = Enum.AutomaticSize.Y
			NewSection.ZIndex = Section.Zindex

			SectionInline.Name = "SectionInline"
			SectionInline.Parent = NewSection
			SectionInline.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			SectionInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionInline.BorderSizePixel = 0
			SectionInline.Position = UDim2.new(0, 1, 0, 1)
			SectionInline.Size = UDim2.new(1, -2, 1, -2)

			Content.Name = "Content"
			Content.Parent = SectionInline
			Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Content.BackgroundTransparency = 1.000
			Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Content.BorderSizePixel = 0
			Content.Position = UDim2.new(0, 7, 0, 10)
			Content.Size = UDim2.new(1, -14, 0, 0)

			UIListLayout.Parent = Content
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 8)

			Space.Name = "Space"
			Space.Parent = Content
			Space.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Space.BackgroundTransparency = 1.000
			Space.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Space.BorderSizePixel = 0
			Space.LayoutOrder = 1000
			Space.Size = UDim2.new(1, 0, 0, 2)

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = NewSection
			SectionTitle.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTitle.BorderSizePixel = 0
			SectionTitle.BackgroundTransparency = 1
			SectionTitle.Position = UDim2.new(0, 5, 0, -5)
			SectionTitle.Size = UDim2.new(0, 0, 0, 8)
			SectionTitle.ZIndex = 3
			SectionTitle.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			SectionTitle.Text = Section.Name
			SectionTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
			SectionTitle.TextSize = Library.FSize
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			SectionTitle.AutomaticSize = Enum.AutomaticSize.X

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewSection
			TitleShadow.BackgroundColor3 = Color3.fromRGB(24, 25, 27)
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 6, 0, -4)
			TitleShadow.Size = UDim2.new(0, 0, 0, 8)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Section.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left
			TitleShadow.AutomaticSize = Enum.AutomaticSize.X

			Close.Name = "Close"
			Close.Parent = NewSection
			Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Close.BackgroundTransparency = 1.000
			Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Close.BorderSizePixel = 0
			Close.Position = UDim2.new(1, -12, 0, 3)
			Close.Size = UDim2.new(0, 9, 0, 6)
			Close.Image = "http://www.roblox.com/asset/?id=16843282447"

			if Section.Page.Limit then
				Content.Visible = false
				function Section:Turn(bool)
					Section.Open = bool
					Content.Visible = Section.Open
				end
	
				Library:Connection(Close.MouseButton1Down, function() 
					if not Section.Open then
						Section:Turn(true)
						for _, Sections in pairs(Section.Page.Sections) do
							if Sections.Open and Sections ~= Section then
								Sections:Turn(false)
							end
						end
					end
				end)
			else
				Library:Connection(Close.MouseButton1Down, function() 
					Content.Visible = not Content.Visible
				end)
			end

			-- // Elements
			Section.Elements = {
				SectionContent = Content;
			}

			-- // Returning
			if Section.Page.Limit then
				if #Section.Page.Sections == 0 then
					Section:Turn(true)
				end
			end
			Section.Window.Sections[#Section.Window.Sections + 1] = Section
			Section.Page.Sections[#Section.Page.Sections + 1] = Section
			return setmetatable(Section, Library.Sections)
		end
		--
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
			--
			local NewList = Instance.new("Frame")
			local Outline = Library:NewInstance("Frame", true)
			local Inline = Instance.new("TextButton")
			local Value = Instance.new("TextBox")
			local ValueShadow = Instance.new("TextLabel")
			local Title = Instance.new("TextLabel")
			local TitleShadow = Instance.new("TextLabel")
			--
			NewList.Name = "NewList"
			NewList.Parent = Textbox.Section.Elements.SectionContent
			NewList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewList.BackgroundTransparency = 1.000
			NewList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewList.BorderSizePixel = 0
			NewList.Size = UDim2.new(1, 0, 0, 30)

			Outline.Name = "Outline"
			Outline.Parent = NewList
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.BorderSizePixel = 0
			Outline.Position = UDim2.new(0, -2, 1, -18)
			Outline.Size = UDim2.new(1,4, 0, 18)

			Inline.Name = "Inline"
			Inline.Parent = Outline
			Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.AutoButtonColor = false
			Inline.Font = Enum.Font.SourceSans
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14.000

			Value.Name = "Value"
			Value.Parent = Inline
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.ZIndex = 2
			Value.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Value.Text = ""
			Value.TextColor3 = Color3.fromRGB(245, 245, 245)
			Value.TextSize = Library.FSize
			Value.TextWrapped = true
			Value.Text = Textbox.State
			Value.ClearTextOnFocus = false

			ValueShadow.Name = "ValueShadow"
			ValueShadow.Parent = Inline
			ValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueShadow.BackgroundTransparency = 1.000
			ValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.BorderSizePixel = 0
			ValueShadow.Position = UDim2.new(0, 1, 0, 1)
			ValueShadow.Size = UDim2.new(1, 0, 1, 0)
			ValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			ValueShadow.Text = Textbox.State
			ValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.TextSize = Library.FSize
			ValueShadow.TextWrapped = true
			
			Title.Name = "Title"
			Title.Parent = NewList
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(0, 100, 0, 10)
			Title.ZIndex = 2
			Title.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Title.Text = Textbox.Name
			Title.TextColor3 = Color3.fromRGB(245, 245, 245)
			Title.TextSize = Library.FSize
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TitleShadow.Name = "TitleShadow"
			TitleShadow.Parent = NewList
			TitleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleShadow.BackgroundTransparency = 1.000
			TitleShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.BorderSizePixel = 0
			TitleShadow.Position = UDim2.new(0, 1, 0, 1)
			TitleShadow.Size = UDim2.new(0, 100, 0, 10)
			TitleShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			TitleShadow.Text = Textbox.Name
			TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleShadow.TextSize = Library.FSize
			TitleShadow.TextXAlignment = Enum.TextXAlignment.Left
			
			-- // Connections
			Library:Connection(Inline.MouseEnter, function()
				Inline.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
			end)
			--
			Library:Connection(Inline.MouseLeave, function()
				Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			end)
			Value.Focused:Connect(function()
				ValueShadow.Text = ""
			end)
			Value.FocusLost:Connect(function()
				Textbox.Callback(Value.Text)
				ValueShadow.Text = Value.Text
				Library.Flags[Textbox.Flag] = Value.Text
			end)
			--
			local function set(str)
				Value.Text = str
				ValueShadow.Text = str
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
			local Outline = Library:NewInstance("Frame", true)
			local Inline = Instance.new("TextButton")
			local Value = Instance.new("TextLabel")
			local ValueShadow = Instance.new("TextLabel")
			--
			NewButton.Name = "NewButton"
			NewButton.Parent = Button.Section.Elements.SectionContent
			NewButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewButton.BackgroundTransparency = 1.000
			NewButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewButton.BorderSizePixel = 0
			NewButton.Size = UDim2.new(1, 0, 0, 22)

			Outline.Name = "Outline"
			Outline.Parent = NewButton
			Outline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Outline.BorderSizePixel = 0
			Outline.Position = UDim2.new(0, -2, 0, 0)
			Outline.Size = UDim2.new(0.5, 0, 1, 0)

			Inline.Name = "Inline"
			Inline.Parent = Outline
			Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Inline.BorderSizePixel = 0
			Inline.Position = UDim2.new(0, 1, 0, 1)
			Inline.Size = UDim2.new(1, -2, 1, -2)
			Inline.AutoButtonColor = false
			Inline.Font = Enum.Font.SourceSans
			Inline.Text = ""
			Inline.TextColor3 = Color3.fromRGB(0, 0, 0)
			Inline.TextSize = 14.000

			Value.Name = "Value"
			Value.Parent = Inline
			Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Value.BackgroundTransparency = 1.000
			Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Value.BorderSizePixel = 0
			Value.Size = UDim2.new(1, 0, 1, 0)
			Value.ZIndex = 2
			Value.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			Value.Text = Button.Name
			Value.TextColor3 = Color3.fromRGB(245, 245, 245)
			Value.TextSize = Library.FSize
			
			ValueShadow.Name = "ValueShadow"
			ValueShadow.Parent = Inline
			ValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueShadow.BackgroundTransparency = 1.000
			ValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.BorderSizePixel = 0
			ValueShadow.Position = UDim2.new(0, 1, 0, 1)
			ValueShadow.Size = UDim2.new(1, 0, 1, 0)
			ValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
			ValueShadow.Text = Button.Name
			ValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
			ValueShadow.TextSize = Library.FSize

			Library:Connection(Inline.MouseEnter, function()
				Inline.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
			end)
			--
			Library:Connection(Inline.MouseLeave, function()
				Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
			end)
			--
			Library:Connection(Inline.MouseButton1Down, function()
				Button.Callback()
				Inline.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
			end)
			--
			Library:Connection(Inline.MouseButton1Up, function()
				if Library:IsMouseOverFrame(Inline) then
					Inline.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
				else
					Inline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
				end
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
				local iOutline = Library:NewInstance("Frame", true)
				local iInline = Instance.new("TextButton")
				local iValue = Instance.new("TextLabel")
				local iValueShadow = Instance.new("TextLabel")

				iOutline.Name = "Outline"
				iOutline.Parent = NewButton
				iOutline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iOutline.BorderSizePixel = 0
				iOutline.Position = UDim2.new(0.5, 2, 0, 0)
				iOutline.Size = UDim2.new(0.5, 0, 1, 0)

				iInline.Name = "Inline"
				iInline.Parent = iOutline
				iInline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
				iInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iInline.BorderSizePixel = 0
				iInline.Position = UDim2.new(0, 1, 0, 1)
				iInline.Size = UDim2.new(1, -2, 1, -2)
				iInline.AutoButtonColor = false
				iInline.Font = Enum.Font.SourceSans
				iInline.Text = ""
				iInline.TextColor3 = Color3.fromRGB(0, 0, 0)
				iInline.TextSize = 14.000

				iValue.Name = "Value"
				iValue.Parent = iInline
				iValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				iValue.BackgroundTransparency = 1.000
				iValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iValue.BorderSizePixel = 0
				iValue.Size = UDim2.new(1, 0, 1, 0)
				iValue.ZIndex = 2
				iValue.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				iValue.Text = InButton.Name
				iValue.TextColor3 = Color3.fromRGB(245, 245, 245)
				iValue.TextSize = Library.FSize

				iValueShadow.Name = "ValueShadow"
				iValueShadow.Parent = iInline
				iValueShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				iValueShadow.BackgroundTransparency = 1.000
				iValueShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				iValueShadow.BorderSizePixel = 0
				iValueShadow.Position = UDim2.new(0, 1, 0, 1)
				iValueShadow.Size = UDim2.new(1, 0, 1, 0)
				iValueShadow.FontFace = Font.new(Font:GetRegistry("dmtmenu"))
				iValueShadow.Text = InButton.Name
				iValueShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
				iValueShadow.TextSize = Library.FSize

				Library:Connection(iInline.MouseEnter, function()
					iInline.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
				end)
				--
				Library:Connection(iInline.MouseLeave, function()
					iInline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
				end)
				--
				Library:Connection(iInline.MouseButton1Down, function()
					InButton.Callback()
					iInline.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
				end)
				--
				Library:Connection(iInline.MouseButton1Up, function()
					if Library:IsMouseOverFrame(iInline) then
						iInline.BackgroundColor3 = Color3.fromRGB(71, 71, 71)
					else
						iInline.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
					end
				end)
			end
			
			return Button
		end
		--
	end;

end;

-- Local Variables
local Flags = Library.Flags
local Pointers = Library.Pointers
local Utility = Library.Utility

getfenv(0)["Library"] = Library;
getfenv(0)["Flags"] = Flags;
getfenv(0)["Pointers"] = Pointers;
Library:Window({})
return Library;
