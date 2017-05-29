local _, Zylla = ...

local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Unending Resolve', key = 'S_UEE', default = true},
	{type = 'spinner', text = '', key = 'S_UE', default = 40},
	{type = 'checkbox', text = 'Enable Dark Pact', key = 'S_DPE', default = true},
	{type = 'spinner', text = '', key = 'S_DP', default = 50},
	{type = 'checkbox', text = 'Enable Drain Life', key = 'S_DLE', default = true},
	{type = 'spinner', text = '', key = 'S_DL', default = 30},
	{type = 'checkbox', text = 'Enable Health Funnel', key = 'S_HFE', default = true},
	{type = 'spinner', text = '', key = 'S_HF', default = 60},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Control: Shadowfury @ Cursor', key = 'K_SF', default = true},
	{type = 'checkbox', text = 'L-Alt: Demonic Circle', key = 'K_DC', default = true},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rWarlock |cffADFF2FDemonology |r')
	print('|cffADFF2F --- |rRecommended Talents: COMING SOON...')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		-- Doom
		key = 'yuDoom',
		name = 'Doom',
		text = 'Enable/Disable: Casting of Doom on targets',
		icon = 'Interface\\ICONS\\spell_shadow_auraofdarkness',
	})
end

local _Zylla = {
    {'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local Util = {
	-- ETC.
	{'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul)'}, -- Vault of the Wardens, Sapped Soul
}

local Survival = {
	{'&Unending Resolve', 'UI(S_UEE)&player.health<=UI(S_UE)'},
	{'&Dark Pact', 'UI(S_DPE)&talent(5,3)&pet.exists&player.health<=UI(S_DP)'},
	{'&Gift of the Naaru', 'UI(S_GOTNE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_GOTN)'},
	{'#5512', 'UI(S_HSE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HS)'},
	{'#127834', 'UI(S_AHPE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_AHP)'},
}

local Player = {
	{'!Drain Life', 'UI(S_DLE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_DL)', 'target'},
	{'!Health Funnel', 'UI(S_HFE)&pet.exists&pet.health<=UI(S_HF)', 'pet'},
}

local Keybinds = {
	{'!Shadowfury', '!player.moving&UI(K_SF)&talent(3,3)&keybind(lcontrol)', 'cursor.ground'},
	{'!Demonic Circle', 'UI(K_DC)&talent(3,1)&keybind(lalt)'},
}

local Cooldowns = {
	{'&Arcane Torrent'},
	{'&Berserking'},
	{'&Blood Fury'},
	{'Grimoire: Felguard', 'talent(6,2)'},	
	{'Summon Doomguard', '!talent(6,1)&target.area(10).enemies<=2'},
	{'Summon Infernal', '!talent(6,1)&target.area(10).enemies>2&!advanced', 'cursor.ground'},
	{'Summon Infernal', '!talent(6,1)&target.area(10).enemies>2&advanced', 'target.ground'},
	{'Summon Doomguard', 'talent(6,1)&target.area(10).enemies=1&player.buff(Sin\'dorei Spite)'},
	{'Summon Infernal', 'talent(6,1)&target.area(10).enemies>1&player.buff(Sin\'dorei Spite)&!advanced', 'cursor.ground'},
	{'Summon Infernal', 'talent(6,1)&target.area(10).enemies>1&player.buff(Sin\'dorei Spite)&advanced', 'target.ground'},
}

local DW_Clip = {
	{'!Summon Felguard', '!player.moving&!pet.exists&!talent(6,1)'},
	{'!Call Dreadstalkers', 'player.buff(Demonic Calling)'},
	{'!Hand of Gul\'dan', '!player.moving&player.soulshards>=4'},
	{'!Thal\'kiel\'s Consumption', '!player.moving&player.spell(Call Dreadstalkers).cooldown>3&player.lastgcd(Hand of Gul\'dan)'},
	{'!Demonic Empowerment', '!player.moving&!player.lastgcd(Demonic Empowerment)&{warlock.empower=0||player.lastgcd(Summon Felguard)||player.lastgcd(Call Dreadstalkers)||player.lastgcd(Hand of Gul\'dan)||player.lastgcd(Summon Darkglare)||player.lastgcd(Summon Doomguard)||player.lastgcd(Grimoire: Felguard)||player.lastgcd(Thal\'kiel\'s Consumption)}'},
	{'!Doom', '!talent(4,1)&toggle(yuDoom)&!target.debuff(Doom)'},
	{'!Life Tap', 'player.mana<=30&player.health>=15&{!player.lastgcd(Summon Felguard)||!player.lastgcd(Call Dreadstalkers)||!player.lastgcd(Hand of Gul\'dan)||!player.lastgcd(Summon Darkglare)||!player.lastgcd(Summon Doomguard)||!player.lastgcd(Grimoire: Felguard)}'},
	{'!Demonbolt', '!player.moving&talent(7,2)&!player.soulshards=4'},
	{'!Shadow Bolt', '!player.moving&!talent(7,2)&!player.soulshards=4'},
	{'!89751', 'spell.cooldown(89751)=0'},
}

local ST = {
	{DW_Clip, 'player.channeling(Demonwrath)&pet.exists'},
	{'!Summon Felguard', '!player.moving&!pet.exists&!talent(6,1)'},
	{'Call Dreadstalkers', '!player.moving&player.buff(Demonic Calling)'},
	{'Hand of Gul\'dan', '!player.moving&player.soulshards>=4'},
	{'Thal\'kiel\'s Consumption', '!player.moving&spell(Call Dreadstalkers).cooldown>3&player.lastgcd(Hand of Gul\'dan)'},
	{'Demonic Empowerment', '!player.moving&!player.lastgcd(Demonic Empowerment)&{warlock.empower=0||player.lastgcd(Summon Felguard)||player.lastgcd(Call Dreadstalkers)||player.lastgcd(Hand of Gul\'dan)||player.lastgcd(Summon Darkglare)||player.lastgcd(Summon Doomguard)||player.lastgcd(Grimoire: Felguard)||player.lastgcd(Thal\'kiel\'s Consumption)}'},
	{'Doom', '!talent(4,1)&toggle(yuDoom)&!target.debuff(Doom)'},
	{'Life Tap', 'player.mana<=30&player.health>=15&{!player.lastgcd(Summon Felguard)||!player.lastgcd(Call Dreadstalkers)||!player.lastgcd(Hand of Gul\'dan)||!player.lastgcd(Summon Darkglare)||!player.lastgcd(Summon Doomguard)||!player.lastgcd(Grimoire: Felguard)}'},
	{'Demonwrath', 'movingfor>=2&player.combat.time>2'},
	{'Demonbolt', '!player.moving&talent(7,2)&!player.soulshards=4'},
	{'Shadow Bolt', '!player.moving&!talent(7,2)&!player.soulshards=4'},
	{'&89751', 'spell.cooldown(89751)=0'},
}

local inCombat = {
	{_Zylla},
	{Util},
	{Keybinds},
	{Survival},
	{Player, '!player.moving'},
	{Cooldowns, 'toggle(cooldowns)'},
	{ST, 'target.infront&target.range<=40'},
}

local outCombat = {
	{'Life Tap', 'player.mana<=60&player.health>=60'},
}

NeP.CR:Add(266, {
	name = '[|cff'..Zylla.addonColor..'Zylla|r] Warlock - Demonology',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})