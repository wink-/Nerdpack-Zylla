local _, Zylla = ...

local GUI = {
	--Logo
	{type = 'texture',  texture = 'Interface\\AddOns\\Nerdpack-Zylla\\media\\logo.blp', width = 128, height = 128, offset = 90, y = -60, align = 'center'},
	{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},{type = 'spacer'},
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'text', 	text = 'Left Shift: Pause', align = 'left'},
	{type = 'text', 	text = 'Left Ctrl: Metamorphosis', align = 'left'},
	{type = 'text', 	text = 'Left Alt: Netherwalk', align = 'left'},
	{type = 'text', 	text = 'Right Alt: Darkness', align = 'left'},
	{type = 'ruler'},	{type = 'spacer'},
	-- Settings
	{type = 'header', 	text = 'Class Settings',							 								align = 'center'},
	{type = 'checkbox', text = 'Pause Enabled',								 								key = 'kPause', 		default = true},
	{type = 'checkbox', text = 'Enable Bursting',								 							key = 'burst', 			default = true},
--{type = 'checkbox', text = 'Cancel Movement/Action Animations',						key = 'kanime', 		default = false},	-- Will be implemented soon...
	{type = 'checkbox', text = 'Use \'Vengeful Retreat\'',										key = 'vengeful', 	default = true},
	{type = 'checkbox', text = 'Use \'Fel Rush\'',														key = 'felrush', 		default = true},
	{type = 'checkspin', 	text = 'Use \'Metamorphosis + Units to strike\'',		key = 'meta',       spin = 4, step = 1, max = 20, check = true },
	{type = 'checkspin', 	text = 'Use \'Chaos Nova + Units to strike\'',			key = 'chaos',      spin = 4, step = 1, max = 20, check = true },
	{type = 'ruler'},	{type = 'spacer'},
	-- Survival
	{type = 'header', 	text = 'Survival',									  	      align = 'center'},
	{type = 'checkspin', 	text = 'Blur below HP%',               			key = 'blur',         spin = 60, check = true},
	{type = 'checkspin', 	text = 'Netherwalk below HP%',              key = 'nether',       spin = 25, check = true},
  {type = 'checkspin',	text = 'Healthstone',												key = 'HS',						spin = 45, check = true},
  {type = 'checkspin',	text = 'Healing Potion',										key = 'AHP',					spin = 45, check = true},
	{type = 'ruler'},	  {type = 'spacer'},
}

local exeOnLoad = function()
	Zylla.ExeOnLoad()
	Zylla.AFKCheck()

	print('|cffADFF2F ---------------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rDemon Hunter |cffADFF2FHavoc|r')
	print('|cffADFF2F --- |rRecommended Talents: ROTATION IS NOT READY FOR RELEASE.')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffFFFB2F Configuration: |rRight-click MasterToggle and go to Combat Routines Settings!|r')

	NeP.Interface:AddToggle({
		key = 'xIntRandom',
		name = 'Interrupt Anyone',
		text = 'Interrupt all nearby enemies, without targeting them.',
		icon = 'Interface\\Icons\\inv_ammo_arrow_04',
	})

end

local Keybinds = {
	{'%pause', 'keybind(lshift)&UI(kPause)'},
	{'Metamorphosis', 'keybind(lcontrol)', 'cursor.ground'},
	{'Netherwalk', 'keybind(lalt)', 'player'},
	{'Darkness', 'keybind(ralt)', 'player'}
}

local Survival = {
	{'Blur', 'player.health<=UI(blur_spin)&UI(blur_check)'},
	{'Netherwalk', 'player.health<=UI(nether_spin)&UI(nether_check)', 'player'},
	{'#127834', 'item(127834).usable&item(127834).count>0&player.health<=UI(AHP_spin)&UI(AHP_check)'}, 		-- Ancient Healing Potion
	{'#5512', 'item(5512).usable&item(5512).count>0&player.health<=UI(HS_spin)&UI(HS_check)', 'player'}	 	--Health Stone
}

local Interrupts = {
	{'!Consume Magic', nil, 'target'},
	{'!Chaos Nova', 'UI(chaos_check)&player.spell(Consume Magic).cooldown>gcd&!player.lastcast(Consume Magic)', 'target'}
}

local Interrupts_Random = {
	{'!Consume Magic', 'interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&inFront&range<21', 'enemies'},
	{'!Chaos Nova', 'UI(chaos_check)&interruptAt(70)&toggle(xIntRandom)&toggle(Interrupts)&range<10&player.spell(Consume Magic).cooldown>gcd&!player.lastcast(Consume Magic)', 'enemies'}
}

local Cooldowns = {
	{'Metamorphosis', 'range<41&combat&alive&area(8).enemies>UI(meta_spin)&UI(meta_check)', 'enemies.ground'},
	{'Nemesis', 'player.spell(Chaos Blades).cooldown<gcd', 'target'},
	{'Chaos Blades', nil, 'player'},
	{'Chaos Nova', 'player.area(8).enemies>UI(chaos_spin)&UI(chaos_check)'}
}

local Burst = {
	{'Nemesis', 'player.spell(Metamorphosis).cooldown<gcd&player.spell(Chaos Blades).cooldown<gcd', 'target'},
	{'Chaos Blades', 'target.debuff(Nemesis)'},
	{'Metamorphosis', 'player.buff(Chaos Blades)', 'target.ground'}
}

local xAoECombat = {
	{Cooldowns, 'toggle(cooldowns)'},
	{'Fel Rush', 'UI(felrush)&{{talent(1,1)&player.fury.diff<30}||{spell.charges==1&spell.recharge<=2&player.area(8).enemies>3}||{talent(5,1)&!player.buff(Momentum)}}', 'player'},
	{'Vengeful Retreat', 'UI(vengeful)&{{talent(2,1)&player.fury<85}||{talent(5,1)&!player.buff(Momentum)}}'},
	{'Fel Barrage', '{talent(5,1)&player.buff(Momentum)}||{!talent(5,1)}', 'target'},
	{'Fury of the Illidari', '{talent(5,1)&player.buff(Momentum)}||{!talent(5,1)}', 'target'},
	{'Eye Beam', '{talent(5,1)&player.buff(Momentum)}||{!talent(5,1)}', 'target'},
	{'Blade Dance', 'player.area(8).enemies>3', 'target'},
	{'Blade Dance', 'talent(3,2)', 'target'},
	{'Throw Glaive', 'talent(3,3)&player.buff(Momentum)', 'target'},
	{'Throw Glaive', 'player.area(8).enemies>=2', 'target'},
	{'Death Sweep', 'player.area(8).enemies>3', 'target'},
	{'Death Sweep', 'talent(3,2)', 'target'},
	{'Chaos Strike', 'player.area(8).enemies>2&talent(3,1)'},
	{'Chaos Strike', 'player.fury>70||{player.fury>60&talent(2,2)}'},
	{'Demon\'s Bite', '!talent(2,2)', 'target'}
}

local xSTCombat = {
	{Cooldowns, 'toggle(cooldowns)'},
	{'Vengeful Retreat', 'UI(vengeful)&{{player.state(snare)}||{target.range<7&player.spell(Fel Rush).charges>1&player.fury<95}}'},
	{'Fel Rush', 'UI(felrush)&spell.charges==1&spell.recharge<=2', 'player'},
	{'Fel Barrage', nil, 'target'},
	{'Fury of the Illidari', nil, 'target'},
	{'Eye Beam', 'talent(7,3)&!player.buff(Demonic)'},
	{'Fel Eruption', nil, 'target'},
	{'Blade Dance', 'talent(5,3)&player.fury>14', 'target'},
	{'Death Sweep', 'talent(5,3)&player.fury>14', 'target'},
	{'Felblade', 'player.fury.diff>30'},
	{'Chaos Strike', 'player.fury>39', 'target'},
	{'Annihilation', 'player.fury>39', 'target'},
	{'Demon\'s Bite', '!talent(2,2)', 'target'},
	{'Throw Glaive', 'talent(2,2)', 'target'},
	{'Throw Glaive', 'talent(3,3)', 'target'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health<100'},
	{Interrupts, 'target.interruptAt(70)'},
	{Interrupts_Random},
	{Burst, 'UI(burst)&xtime<5&target.range<=5&target.inFront'},
	{xSTCombat, 'player.area(15).enemies<3&target.range<=5&target.inFront&{{UI(burst)&xtime>4}||{!UI(burst)}}'},
	{xAoECombat, 'player.area(15).enemies>2&target.range<=5&target.inFront&{{UI(burst)&xtime>4}||{!UI(burst)}}'},
	{'Fel Rush', 'UI(felrush)&target.range>12&target.range<41', 'player'}
}

local outCombat = {
	{Keybinds}
}

NeP.CR:Add(577, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Demon Hunter - Havoc',
	ic = {
		{inCombat, '!player.channeling(Eye Beam)'},
		{'&@Zylla.face', 'UI(eyeface)&player.channeling(Eye Beam)', 'target'}
	},	ooc = outCombat,
	gui = GUI,
	gui_st = {title='Zylla\'s Combat Routines', width='256', height='520', color='A330C9'},
	ids = Zylla.SpellIDs[Zylla.Class],
	wow_ver = Zylla.wow_ver,
	nep_ver = Zylla.nep_ver,
	load = exeOnLoad
})
