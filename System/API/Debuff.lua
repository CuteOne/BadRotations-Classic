if br.api == nil then br.api = {} end
-- debuff is the table located at br.player.debuff
-- v is the spellID passed from the builder which cycles all the collected debuff spells from the spell list for the spec
-- spell in the examples represent the name in the debuffs list (Spec, Shared Class, Shared Global Lists) defined in System/List/Spells.lua

br.api.debuffs = function(debuff,k,v)
    local spec = 0--GetSpecializationInfo(GetSpecialization())
    debuff.exists = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        return UnitDebuffID(thisUnit,v,sourceUnit) ~= nil
    end
    debuff.duration = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        return getDebuffDuration(thisUnit,v,sourceUnit) or 0
    end
    debuff.remain = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        return math.abs(getDebuffRemain(thisUnit,v,sourceUnit))
    end
    debuff.remains = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        return math.abs(getDebuffRemain(thisUnit,v,sourceUnit))
    end
    debuff.stack = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        if getDebuffStacks(thisUnit,v,sourceUnit) == 0 and UnitDebuffID(thisUnit,v,sourceUnit) ~= nil then
            return 1
        else
            return getDebuffStacks(thisUnit,v,sourceUnit)
        end
    end
    debuff.pandemic = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        if thisUnit == 'target' then thisUnit = GetObjectWithGUID(UnitGUID("target")) end 
        local pandemic = debuff.duration(thisUnit,sourceUnit)
        if br.player.pandemic[thisUnit] ~= nil and br.player.pandemic[thisUnit][k] ~= nil then 
            pandemic = br.player.pandemic[thisUnit][k] 
        end
        return pandemic
    end
    debuff.refresh = function(thisUnit,sourceUnit)
        if thisUnit == nil then thisUnit = 'target' end
        if sourceUnit == nil then sourceUnit = 'player' end
        return debuff.remain(thisUnit,sourceUnit) <= debuff.pandemic(thisUnit,sourceUnit) * 0.3
    end
    debuff.count = function()
        return tonumber(getDebuffCount(v))
    end
    debuff.remainCount = function(remain)
        return tonumber(getDebuffRemainCount(v,remain))
    end
    debuff.lowest = function(range,debuffType)
        if range == nil then range = 40 end
        if debuffType == nil then debuffType = "remain" end
        return getDebuffMinMax(k, range, debuffType, "min")
    end
    debuff.max = function(range,debuffType)
        if range == nil then range = 40 end
        if debuffType == nil then debuffType = "remain" end
        return getDebuffMinMax(k, range, debuffType, "max")
    end
end