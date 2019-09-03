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
	local DOOMWALKER_NPC_ID = 17711
	ThreatLib:GetModule("NPCCore"):RegisterModule(DOOMWALKER_NPC_ID, function(Doomwalker)

		function Doomwalker:Init()
			self:RegisterCombatant(DOOMWALKER_NPC_ID, true)
			self:RegisterSpellHandler("SPELL_DAMAGE", self.Overrun, 32636, 32637)
		end

		function Doomwalker:Overrun()
			self:WipeRaidThreatOnMob(DOOMWALKER_NPC_ID)
		end
	end)
end
