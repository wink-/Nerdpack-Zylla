local _, Zylla = ...
local GUI = {
} 

local _Zylla = {
	{'@Zylla.Targeting()', {'!target.alive&toggle(AutoTarget)'}},
}

local Survival = {

}

local Cooldowns = {

}

local AoE = {

}


local ST = {

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{_Zylla},
	{Keybinds},
	{Survival, 'player.health<100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies>=3'}},
	{ST, {'target.range<40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(267, {
	name = '[|cff'..Zylla.addonColor..'Zylla\'s|r] Warlock - Destro',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
