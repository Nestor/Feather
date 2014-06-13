local PNL = {}

function PNL:Init()
	self:SetFont("fr_CategoryFont")
	self:SetColor(color_white)
end

function PNL:Paint(w, h)
end

function PNL:OnCursorEntered()
	surface.PlaySound("UI/buttonrollover.wav")
end

function PNL:DoClick()
	self:OnClick()
	surface.PlaySound("weapons/pistol/pistol_empty.wav")
end

function PNL:DoClick()
	self:OnClick()
	surface.PlaySound("weapons/pistol/pistol_empty.wav")
end

function PNL:Think()
end
vgui.Register("FeatherHelpMenuButton", PNL, "DButton")

local PNL = {}

function PNL:Init()
	self:SetText("Help Menu")
	self:SetSize(ScrW()/2, ScrH()/2)
	self:Center()
	self:MakePopup()
	self:SetKeyboardInputEnabled(false)

	self.list = vgui.Create("PanelList", self)
	self.list:Dock(LEFT)
	self.list:DockMargin(5, 10, 5, 5)
	self.list:EnableVerticalScrollbar()
	self.list:SetSpacing(5)
	self.list:SetPadding(5)
	self.list:SetWide(self:GetWide()/3)

	self.content = vgui.Create("PanelList", self)
	self.content:Dock(FILL)
	self.content:DockMargin(5, 10, 5, 5)
	self.content:EnableVerticalScrollbar()
	self.content:SetSpacing(30)
	self.content:SetPadding(30)

	self:LoadButton("About Gamemode", function()
		self:LoadAbout()
	end)

	self:LoadButton("Rules", function()

	end)

	self.commands = {}
	for k, v in pairs(GAMEMODE.ChatCommands) do
		if !self.commands[v.category] then
			self.commands[v.category] = self:LoadButton(v.category, function()
				self:LoadCommand(v.category)
			end)
		end
	end
end

function PNL:LoadAbout()
	self.content:Clear()
	local text = vgui.Create("DLabel", self.content)
	text:SetContentAlignment(1)
	text:SetFont("fr_MenuFont")
	text:SetText("Loading..")
	text:SetAutoStretchVertical( true )
	text:SetColor(color_black)	
	self.content:AddItem(text)

	http.Fetch("https://raw.githubusercontent.com/rebel1324/Feather/master/aboutgamemode.txt", function(bdy, len, hed, cd)
		if text and text:IsVisible() then
			text:SetWrap(true)
			text:SetText(bdy)
		end
	end)
end

function PNL:LoadButton(name, func)
	local btn = vgui.Create("FeatherHelpMenuButton", self.list)
	btn:SetText(name)
	btn:SetTall(45)
	if func then
		btn.OnClick = func
	end
	self.list:AddItem(btn)

	return btn
end

function PNL:AddCommandText(str, syn, desc)
	local txt = "/"..str
	if syn then 
		txt = txt .. "\n" .. syn
	end
	
	if desc then
		txt = txt .. "\n" .. desc
	end
	
	local text = vgui.Create("DLabel", self.content)
	text:SetContentAlignment(1)
	text:SetFont("fr_MenuFont")
	text:SetText(txt)
	text:SetAutoStretchVertical( true )
	text:SetWrap( true )
	text:SetColor(color_black)	
	self.content:AddItem(text)
end

function PNL:LoadCommand(str)
	self.content:Clear()

	for k, v in pairs(GAMEMODE.ChatCommands) do
		if str == v.category then
			self:AddCommandText(k, v.syntax, v.desc)
		end
	end
end

vgui.Register("FeatherHelp", PNL, "FeatherFrame")

function GM:ShowHelp()
	if HELP then
		if HELP.Close then
			HELP:Close()
		end
		HELP = nil
		return
	end
	HELP = vgui.Create("FeatherHelp")
end
