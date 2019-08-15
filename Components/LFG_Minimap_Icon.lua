EasyRecruiting.MinimapIcon = {};

function EasyRecruiting.MinimapIcon:resetIcon()
  ER_MinimapButton:SetTexture("Interface\AddOns\EasyRecruiting\icons\frames\BattlenetWorking0")
end

function EasyRecruiting.MinimapIcon.toggle()
  if( ERFrame:IsVisible() ) then
		HideUIPanel(ERFrame);
	else
		ShowUIPanel(ERFrame);
	end
end

function EasyRecruiting.MinimapIcon.reposition()
  --DEFAULT_CHAT_FRAME:AddMessage("repositionrepositionreposition");
	ER_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(ERSettings.minimapPos)),(80*sin(ERSettings.minimapPos))-52);
end

function EasyRecruiting.MinimapIcon.OnUpdate()
  DEFAULT_CHAT_FRAME:AddMessage("OnUpdate");
	local xpos,ypos = GetCursorPosition();
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = xmin-xpos/UIParent:GetScale()+70;
	ypos = ypos/UIParent:GetScale()-ymin-70;

	ERSettings.minimapPos = math.deg(math.atan2(ypos,xpos));
  DEFAULT_CHAT_FRAME:AddMessage(ERSettings.minimapPos);
	EasyRecruiting.MinimapIcon:reposition();
end

function EasyRecruiting.MinimapIcon.onClick()
end