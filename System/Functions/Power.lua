-- if getCombo() >= 1 then
function getCombo()
	return UnitPower("player", 4) --GetComboPoints("player") - Legion Change
end
function getEmber(Unit)
	return UnitPower(Unit, 14)
end
function getEmberMax(Unit)
	return UnitPowerMax(Unit, 14)
end
-- if getMana("target") <= 15 then
function getMana(Unit)
	return 100 * UnitPower(Unit, 0) / UnitPowerMax(Unit, 0)
end
-- if getPower("target") <= 15 then
function getPower(Unit, index)
	local value = value
	if select(3, UnitClass("player")) == 11 or select(3, UnitClass("player")) == 4 then
		if UnitBuffID("player", 106951) or UnitBuffID("player", 102543) then
			value = UnitPower(Unit, index) * 2
		else
			value = UnitPower(Unit, index)
		end
	else
		value = UnitPower(Unit, index) -- 100 * UnitPower(Unit) / UnitPowerMax(Unit)
	end
	return UnitPower(Unit, index)
end
function getPowerMax(Unit, index)
	local value = value
	if select(3, UnitClass("player")) == 11 or select(3, UnitClass("player")) == 4 then
		if UnitBuffID("player", 106951) or UnitBuffID("player", 102543) then
			value = UnitPowerMax(Unit, index) * 2
		else
			value = UnitPowerMax(Unit, index)
		end
	else
		value = UnitPowerMax(Unit, index) -- 100 * UnitPower(Unit) / UnitPowerMax(Unit)
	end
	return UnitPowerMax(Unit, index)
end
function getPowerAlt(Unit)
	local value = value
	local class = select(2, UnitClass(Unit))
	local spec = GetSpecialization()
	local power = UnitPower
	if (class == "DRUID" and spec == 2) or class == "ROGUE" then
		return power(Unit, 4)
	end
	if class == "WARLOCK" then
		return power(Unit, 7)
	end
	return 0
end
-- if getTimeToMax("player") < 3 then
function getTimeToMax(Unit)
	local max = UnitPowerMax(Unit)
	local curr = UnitPower(Unit)
	local curr2 = curr
	local _, regen = GetPowerRegen(Unit)
	if select(3, UnitClass("player")) == 11 and (GetShapeshiftFormID() ~= nil and not GetShapeshiftFormID() == 1) and isKnown(114107) then
		curr2 = curr + 4 * getCombo()
	end
	return (max - curr2) * (1.0 / regen)
end
-- /dump getCastRegen(185358)
function getCastRegen(spellId)
	local regenRate = GetPowerRegen("player")
	local power = 0

	-- Get the "execute time" of the spell (larger of GCD or the cast time).
	local castTime = getCastTime(spellId) or 0
	local gcd = getSpellCD(61304)
	if gcd == 0 then
		gcd = max(1, 1.5 / (1 + UnitSpellHaste("player") / 100))
	end
	local castSeconds = (castTime > gcd) and castTime or gcd
	power = power + regenRate * castSeconds

	return power
end
-- if getRegen("player") > 15 then
function getRegen(Unit)
	return select(2, GetPowerRegen(Unit))
end
function getSpellCost(spell)
	local t = GetSpellPowerCost(GetSpellInfo(spell))
	if not t then
		return 0
	elseif not t[1] then 
		return 0
	elseif not t[1]["minCost"] then
		return 0
	elseif not t[2] then
		return t[1]["minCost"], t[1]["cost"], t[1]["type"]
	elseif not t[2]["minCost"] then
		return t[1]["minCost"], t[1]["cost"], t[1]["type"]
	else
		return t[1]["minCost"], t[1]["cost"], t[1]["type"], t[2]["minCost"], t[2]["cost"]
	end
end

function hasResources(spell, offset)
	local cost, _, costtype = getSpellCost(spell)
	offset = offset or 0
	if not cost then
		return false
	elseif cost == 0 then
		return true
	elseif UnitPower("player", costtype) > cost + offset then
		return true
	end
end
