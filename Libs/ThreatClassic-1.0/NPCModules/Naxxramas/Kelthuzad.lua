local MAJOR_VERSION = "ThreatClassicBR-1.0"
local MINOR_VERSION = 4

if _G.ThreatLib_MINOR_VERSION == nil then _G.ThreatLib_MINOR_VERSION = 0 end
if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

local lib, oldminor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then
    return
end

ThreatLib_funcs[#ThreatLib_funcs + 1] = function()
	local ThreatLib = _G.ThreatLib
	local KEL_THUZAD_ID = 15990
	local CHAINS_ID = 28410

	ThreatLib:GetModule("NPCCore"):RegisterModule(KEL_THUZAD_ID, function(KelThuzad)
		function KelThuzad:Init()
			self:RegisterCombatant(KEL_THUZAD_ID, true)
			self:RegisterSpellHandler("SPELL_CAST_SUCCESS", self.Chains, CHAINS_ID)
		end

		function KelThuzad:Chains()
			self:WipeRaidThreatOnMob(KEL_THUZAD_ID)
		end
	end)
end
