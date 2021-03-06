--[[
						CLASS CONDITIONS!
			Only submit class specific conditions here.
					KEEP ORGANIZED AND CLEAN!

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
]]
--------------------------------------------------- PRIEST ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("insanity", function(target, spell)
	return UnitPower(target, SPELL_POWER_INSANITY)
end)

--------------------------------------------------- HUNTER ---------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("petrange", function(target)
	if target then
		return NeP.Engine.Distance('pet', target)
	end
	return 0
end)

--------------------------------------------------- DEATHKNIGH -----------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("runicpower", function(target, spell)
	return UnitPower(target, SPELL_POWER_RUNIC_POWER)
end)

NeP.DSL.RegisterConditon("runes.count", function(target)
	local count = 0
	for i=1, 6 do
		local start, duration, runeReady = GetRuneCooldown(i)
		if runeReady then count = count+1 end
	end
	return count
end)

NeP.DSL.RegisterConditon("runes.cooldown", function(target, runes)
	local rT = {}
	for i=1, 6 do
		local r, d, c = GetRuneCooldown(i)
		local cd = (r + d) - GetTime()
		rT[#rT+1] = cd
	end
	table.sort(rT, function(a,b) return a < b end)
	return rT[runes] or 0
end)

NeP.DSL.RegisterConditon("runes", function(target, rune)
	return NeP.DSL.Conditions["runes.count"](target, rune)
end)

--------------------------------------------------- SHAMMMAN -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("maelstrom", function(target, spell)
    return UnitPower(target, SPELL_POWER_MAELSTROM)
end)

NeP.DSL.RegisterConditon("totem", function(target, totem)
	for index = 1, 4 do
		local _, totemName, startTime, duration = GetTotemInfo(index)
		if totemName == GetSpellName(totem) then
			return true
		end
	end
	return false
end)

NeP.DSL.RegisterConditon("totem.duration", function(target, totem)
	for index = 1, 4 do
	local _, totemName, startTime, duration = GetTotemInfo(index)
	if totemName == GetSpellName(totem) then
		return floor(startTime + duration - GetTime())
	end
	end
	return 0
end)

--------------------------------------------------- WARLOCK --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("demonicfury", function(target, spell)
	return UnitPower(target, SPELL_POWER_DEMONIC_FURY)
end)

NeP.DSL.RegisterConditon("embers", function(target, spell)
	return UnitPower(target, SPELL_POWER_BURNING_EMBERS, true)
end)

NeP.DSL.RegisterConditon("soulshards", function(target, spell)
	return UnitPower(target, SPELL_POWER_SOUL_SHARDS)
end)

--------------------------------------------------- MONK -----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("chi", function(target, spell)
	return UnitPower(target, SPELL_POWER_CHI)
end)

-- Returns the number of chi you have left till max (e.g. you have a max of 5 chi and 3 chi now, so it will return 2)
NeP.DSL.RegisterConditon("chidiff", function(target, spell)
    local max = UnitPowerMax(target, SPELL_POWER_CHI)
    local curr = UnitPower(target, SPELL_POWER_CHI)
    return (max - curr)
end)

--------------------------------------------------- DRUID ----------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("eclipse", function(target, spell)
	return math.abs(UnitPower(target, SPELL_POWER_ECLIPSE))
end)

NeP.DSL.RegisterConditon("eclipseRaw", function(target, spell)
	return UnitPower(target, SPELL_POWER_ECLIPSE)
end)

NeP.DSL.RegisterConditon("solar", function(target, spell)
	return GetEclipseDirection() == 'sun'
end)

NeP.DSL.RegisterConditon("lunar", function(target, spell)
	return GetEclipseDirection() == 'moon'
end)

NeP.DSL.RegisterConditon("form", function(target, spell)
	return GetShapeshiftForm()
end)

NeP.DSL.RegisterConditon("combopoints", function()
	return GetComboPoints('player', 'target')
end)

NeP.DSL.RegisterConditon("balance.sun", function()
	local direction = GetEclipseDirection()
	if direction == 'none' or direction == 'sun' then return true end
end)

NeP.DSL.RegisterConditon("balance.moon", function()
	local direction = GetEclipseDirection()
	if direction == 'moon' then return true end
end)

NeP.DSL.RegisterConditon("mushrooms", function ()
	local count = 0
	for slot = 1, 3 do
	if GetTotemInfo(slot) then
		count = count + 1 end
	end
	return count
end)

--------------------------------------------------- PALADIN --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("holypower", function(target, spell)
	return UnitPower(target, SPELL_POWER_HOLY_POWER)
end)

NeP.DSL.RegisterConditon("seal", function(target, spell)
	return GetShapeshiftForm()
end)

--------------------------------------------------- WARRIOR --------------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("rage", function(target, spell)
	return UnitPower(target, SPELL_POWER_RAGE)
end)

NeP.DSL.RegisterConditon("stance", function(target, spell)
	return GetShapeshiftForm()
end)

--------------------------------------------------- DEMONHUNTER ----------------------------------------------
--------------------------------------------------------------------------------------------------------------

NeP.DSL.RegisterConditon("fury", function(target, spell)
	return UnitPower(target, SPELL_POWER_FURY)
end)

NeP.DSL.RegisterConditon("pain", function(target, spell)
	return UnitPower(target, SPELL_POWER_PAIN)
end)

-- Returns the number of fury you have left till max (e.g. you have a max of 100 fury and 80 fury now, so it will return 20)
NeP.DSL.RegisterConditon("furydiff", function(target, spell)
    local max = UnitPowerMax(target, SPELL_POWER_FURY)
    local curr = UnitPower(target, SPELL_POWER_FURY)
    return (max - curr)
end)