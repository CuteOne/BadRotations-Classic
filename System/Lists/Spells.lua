function getRacial()
    local race = select(2,UnitRace("player"))
    local OrcRacial
    if race == "Orc" then
        OrcRacial = select(7, GetSpellInfo(GetSpellInfo(33702)))
    end
    local racialSpells = {
        -- Alliance
        Dwarf    = 20594,           -- Stoneform
        Gnome    = 20589,           -- Escape Artist
        Human    = 59752,           -- Every Man for Himself
        NightElf = 58984,           -- Shadowmeld
        -- Horde
        Orc      = OrcRacial,       -- Blood Fury
        Tauren   = 20549,           -- War Stomp
        Troll    = 26297,           -- Berserking
        Scourge  = 7744,            -- Will of the Forsaken
    }
    return racialSpells[race]
end
if br.lists == nil then br.lists = {} end
br.lists.spells = {
    DRUID = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    HUNTER = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    MAGE = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    PALADIN = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    PRIEST = {
        abilities                       = {

        },
        buffs                           = {


        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    ROGUE = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    SHAMAN = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    WARLOCK = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    WARRIOR = {
        abilities                       = {

        },
        buffs                           = {

        },
        debuffs                         = {

        },
        talents                         = {

        },
    },
    -- Global
    Shared = {
        abilities                           = {
            global                          = 61304,
            racial                          = getRacial(),
            shadowmeld                      = 58984,
        },
        buffs                               = {
            bloodlust                       = 2825,
            heroism                         = 32182,
            netherwinds                     = 160452,
            norgannonsForesight             = 236373,
            potionOfBurstingBlood           = 265514,
            potionOfFocusedResolve          = 298317,
            prolongedPower                  = 229206,
            racial                          = getRacial(),
            shadowmeld                      = 58984,
        },
        debuffs                             = {

        },
    },
}
