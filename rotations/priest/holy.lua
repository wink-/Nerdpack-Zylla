local _, Zylla = ...

local Mythic_GUI = _G.Mythic_GUI
local Fel_Explosives = _G.Fel_Explosives
local Logo_GUI = _G.Logo_GUI
local unpack = _G.unpack

local GUI = {
	unpack(Logo_GUI),
	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: ', align = 'center'},
	{type = 'text', 	text = 'Left Alt: ', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
	{type = 'ruler'},	{type = 'spacer'},
	unpack(Mythic_GUI),
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |PRIEST |cffADFF2FHoly|r')
	print('|cffADFF2F --- |rRecommended Talents: Not ready yet.')
	print('|cffADFF2F --- |r')
	print('|cffADFF2F --- |rThis rotation does not work at the moment!|')
	print('|cffADFF2F ---------------------------------------------------------------------------|r')
end

local Keybinds = {

}

local Cooldowns = {

}

local inCombat = {
	{Fel_Explosives, 'range<40'}
}

local outCombat = {

}

NeP.CR:Add(256, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Priest - Holy',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
