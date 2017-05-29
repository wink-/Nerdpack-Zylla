local _, Zylla = ...

	{type = 'header', 	text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'center'},
	{type = 'text', 	text = 'Left Ctrl: Cannonball Barrage (Cursor}', align = 'center'},
	{type = 'text', 	text = 'Left Alt: Grappling Hook (Cursor)', align = 'center'},
	{type = 'text', 	text = 'Right Alt: ', align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled', key = 'kPause', default = true},
} 

local exeOnLoad = function()
	 Zylla.ExeOnLoad()

	print("|cffFFFF00 ----------------------------------------------------------------------|r")
	print("|cffFFFF00 --- |rRogue |cffFFF569Outlaw |r")
	print("|cffFFFF00 --- |rRecommended Talents: 1/1 - 2/3 - 3/1 - 4/X - 5/1 - 6/2 - 7/2")
	print("|cffFFFF00 ----------------------------------------------------------------------|r")

end

local _Zylla = {
	{'/targetenemy [dead][noharm]', '{target.dead||!target.exists}&!player.area(40).enemies=0'},
}

local Survival ={
	{'Crimson Vial', 'player.health<=65'},
	{'Riposte', 'player.health<=45||player.incdmg(5)>player.health.max*0.20'},
	{'Cloak of Shadows', 'incdmg(5).magic>player.health.max'},
}

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Cannonball Barrage', 'keybind(lcontrol)', 'cursor.ground'},
	{'Grappling Hook', 'talent(2,1)&keybind(lalt)', 'cursor.ground'},
}

local Util = {
	{'%pause' , 'player.debuff(200904)||player.debuff(Sapped Soul||target.debuff(Gouge).duration>gcd'}, -- Vault of the Wardens, Sapped Soul, Gouge
}

local Interrupts = {
	{'Kick', 'target.inmelee'},
	{'Between the Eyes', 'target.range<=20&cooldown(Kick).remains>gcd&combo_points>0'},
	{'Blind', 'target.range<=15&cooldown(Kick).remains>gcd&cooldown(Between the Eyes)>gcd'},
	{'Cloak of Shadows', 'cooldown(Kick).remains>gcd&cooldown(Between the Eyes)>gcd&cooldown(Blind)>gcd'},
}

local Build = {
	{'Ghostly Strike', 'target.inmelee&combo_points.deficit>=1&target.debuff(Ghostly Strike).duration<2'},
	{'Pistol Shot', 'target.range<=20&player.buff(Opportunity)&combo_points<5'},
	{'Saber Slash', 'target.inmelee&{combo_points<5||{combo_points<=5&player.buff(Broadsides)}}'},
}

local Finishers = {
	{'Between the Eyes', 'target.range<=20&combo_points>=5&player.buff(Shark Infested Waters)'},
	{'Run Through', 'target.inmelee&combo_points>=5'},
	{'Death from Above', 'talent(7,3)&target.area(8).enemies>=5&combo_points>=5'},
	{'Slice and Dice', 'talent(7,1)&combo_points>=5&player.buff(Slice and Dice).remains<=2'},
}

local Blade_Flurry = {
	{'Blade Flurry', 'player.area(7).enemies>3&!player.buff(Blade Flurry)'},
	{'Blade Flurry', 'player.area(7).enemies<2&player.buff(Blade Flurry)'},
}

local Cooldowns = {
	{'Cannonball Barrage', 'target.area(10).enemies<=3', 'target.ground'},
	{'Adrenaline Rush', 'target.inmelee&energy.deficit>0'},
	{'Marked for Death', 'talent(7,2)&{combo_points<=5&player.energy>=26}||pull_timer<=10'},
	{'Curse of the Dreadblades', 'combo_points.deficit>=4&{!talent(1,1)||target.debuff(Ghostly Strike)}'},
	{'Killing Spree', 'talent(6,3)&energy.time_to_max>5||player.energy<15'},
}

local RollingBones ={
	{'Roll the Bones', 'player.combopoints>=5&!player.talent(7,1)&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)'},
	{'Roll the Bones', 'player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.talent(7,1)&player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&player.buff(Shark Infested Waters)&!player.buff(True Bearing)&!player.buff(Buried Treasure)||player.combopoints>=5&!player.talent(7,1)&player.spell(Adrenaline Rush).cooldown>15&player.spell(Curse of the Dreadblades).cooldown>15&!player.buff(Broadsides)&!player.buff(Jolly Roger)&!player.buff(Grand Melee)&!player.buff(Shark Infested Waters)&!player.buff(True Bearing)&player.buff(Buried Treasure)'},
	{'Roll the Bones', '!RtB'},
}

local TricksofTrade = {
	{'Tricks of the Trade', '!focus.buff', 'focus'},
	{'Tricks of the Trade', '!tank.buff', 'tank'},
}

local xCombat = {
	{RollingBones},
	{Blade_Flurry},
	{Cooldowns, 'toggle(Cooldowns)'},
	{Build},
	{Finishers},
}

local inCombat = {
	{_Zylla, 'toggle(AutoTarget)'},
	{Keybinds},
	{Interrupts, 'target.interruptAt(70)&toggle(Interrupts)&target.infront'},
	{Survival, 'player.health<100'},
	{xCombat, 'target.infront'},
	{TricksofTrade},
}

local outCombat = {
	{'Stealth', '!player.buff(Stealth)'},
	{'Ambush', 'target.inmelee&target.infront&player.buff(Stealth)'},
	{Keybinds},
	{TricksofTrade},
}

NeP.CR:Add(260, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Rogue - Outlaw',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})