local _, Zylla = ...
local _G = _G
local NeP = _G.NeP
_G.Zylla = Zylla

Zylla.Version = '2.5'
Zylla.Branch = 'RELEASE'
Zylla.Name = 'NerdPack - Zylla\'s Rotations'
Zylla.Author = 'Zylla'
Zylla.addonColor = '8801C0'
Zylla.ClassColor = '|cff'..NeP.Core:ClassColor('player', 'hex')..''
Zylla.wow_ver = '7.3.0'
Zylla.nep_ver = '1.11'
Zylla.timer = {}
Zylla.spell_timers = {}
Zylla.isAFK = false;
Zylla.Class = select(3,_G.UnitClass("player"))
Zylla.DonateURL = 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=23HX4QKDAD4YG'
Zylla.GuiSettings = {title='Zylla\'s Combat Routines', width='256', height='960', color='A330C9'}
Zylla.PetMode = 0
Zylla.GuiSettings = {
  title='Zylla\'s Combat Routines',
  width='256',
  height='960',
  color='A330C9'
}
