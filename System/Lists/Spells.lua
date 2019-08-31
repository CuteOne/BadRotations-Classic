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
    return {Ranks = {racialSpells[race]}}
end

if br.lists == nil then br.lists = {} end
br.lists.spells = {
    DRUID = {
        abilities                       = {
            abolishPoison = {Ranks = {2893}},
            aquaticForm = {Ranks = {1066}},
            barkskin = {Ranks = {22812}},
            bash = {Ranks = {5211, 6798, 8983}},
            bearForm = {Ranks = {5487}},
            catForm = {Ranks = {768}},
            challengingRoar = {Ranks = {5209}},
            claw = {Ranks = {1082, 3029, 5201, 9849, 9850}},
            cower = {Ranks = {8998, 9000, 9892}},
            curePoison = {Ranks = {8946}},
            dash = {Ranks = {1850, 9821}},
            demoralizingRoar = {Ranks = {99, 1735, 9490, 9747, 9898}},
            direBearForm = {Ranks = {9634}},
            enrage = {Ranks = {5229}},
            entanglingRoots = {Ranks = {339, 1062, 5195, 5196, 9852, 9853}},
            faerieFire = {Ranks = {770, 778, 9749, 9907}},
            faerieFireFeral = {Ranks = {16857, 17390, 17391, 17392}},
            feralCharge = {Ranks = {16979}},
            ferociousBite = {Ranks = {22568, 22827, 22828, 22829, 31018}},
            frenziedRegeneration = {Ranks = {22842, 22895, 22896}},
            giftOfTheWild = {Ranks = {21849, 21850}},
            growl = {Ranks = {6795}},
            healingTouch = {Ranks = {5185, 5186, 5187, 5188, 5189, 6778, 8903, 9758, 9888, 9889, 25297}},
            hibernate = {Ranks = {2637, 18657, 18658}},
            hurricane = {Ranks = {17401, 17402}},
            innervate = {Ranks = {29166}},
            insectSwarm = {Ranks = {5570, 24974, 24975, 24976, 24977}},
            markOfTheWild = {Ranks = {1126, 5232, 6756, 5234, 8907, 9884, 9885}},
            maul = {Ranks = {6807, 6808, 6809, 8972, 9745, 9880, 9881}},
            moonfire = {Ranks = {8921, 8924, 8925, 8926, 8927, 8928, 8929, 9833, 9834, 9835}},
            moonkinForm = {Ranks = {24858}},
            naturesGrasp = {Ranks = {16689, 16810, 16811, 16812, 16813, 17329}},
            naturesSwiftness = {Ranks = {17116}},
            omenOfClarity = {Ranks = {16864}},
            pounce = {Ranks = {9005, 9823, 9827}},
            prowl = {Ranks = {5215, 6783, 9913}},
            rake = {Ranks = {1822, 1823, 1824, 9904}},
            ravage = {Ranks = {6785, 6787, 9866, 9867}},
            rebirth = {Ranks = {20484, 20739, 20742, 20747, 20748}},
            regrowth = {Ranks = {8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858}},
            rejuvenation = {Ranks = {774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299}},
            removeCurse = {Ranks = {2782}},
            rip = {Ranks = {1079, 9492, 9493, 9752, 9894, 9896}},
            shred = {Ranks = {5221, 6800, 8992, 9829, 9830}},
            sootheAnimal = {Ranks = {2908, 8955, 9901}},
            starfire = {Ranks = {2912, 8949, 8950, 8951, 9875, 9876, 25298}},
            swiftmend = {Ranks = {18562}},
            swipe = {Ranks = {779, 780, 769, 9754, 9908}},
            teleportMoonglade = {Ranks = {18960}},
            thorns = {Ranks = {467, 782, 1075, 8914, 9756, 9910}},
            tigersFury = {Ranks = {5217, 6793, 9845, 9846}},
            trackHumanoids = {Ranks = {5225}},
            tranquility = {Ranks = {740, 8918, 9862, 9863}},
            travelForm = {Ranks = {783}},
            wrath = {Ranks = {5176, 5177, 5178, 5179, 5180, 6780, 8905, 9912}}
        },
        buffs                           = {
            abolishPoison = {Ranks = {2893}},
            aquaticForm = {Ranks = {1066}},
            barkskin = {Ranks = {22812}},
            bearForm = {Ranks = {5487}},
            catForm = {Ranks = {768}},
            clearcasting = {Ranks = {16870}},
            dash = {Ranks = {1850, 9821}},
            direBearForm = {Ranks = {9634}},
            enrage = {Ranks = {5229}},
            frenziedRegeneration = {Ranks = {22842, 22895, 22896}},
            giftOfTheWild = {Ranks = {21849, 21850}},
            markOfTheWild = {Ranks = {1126, 5232, 6756, 5234, 8907, 9884, 9885}},
            moonkinForm = {Ranks = {24858}},
            naturesGrace = {Ranks = {16886}},
            naturesGrasp = {Ranks = {16689, 16810, 16811, 16812, 16813, 17329}},
            naturesSwiftness = {Ranks = {17116}},
            innevate = {Ranks = {29166}},
            omenOfClarity = {Ranks = {16864}},
            prowl = {Ranks = {5215, 6783, 9913}},
            regrowth = {Ranks = {8936, 8938, 8939, 8940, 8941, 9750, 9856, 9857, 9858}},
            rejuvenation = {Ranks = {774, 1058, 1430, 2090, 2091, 3627, 8910, 9839, 9840, 9841, 25299}},
            sootheAnimal = {Ranks = {2908, 8955, 9901}},
            thorns = {Ranks = {467, 782, 1075, 8914, 9756, 9910}},
            tigersFury = {Ranks = {5217, 6793, 9845, 9846}},
            trackHumanoids = {Ranks = {5225}},
            travelForm = {Ranks = {783}}
        },
        debuffs                         = {
            challengingRoar = {Ranks = {5209}},
            demoralizingRoar = {Ranks = {99, 1735, 9490, 9747, 9898}},
            entanglingRoots = {Ranks = {339, 1062, 5195, 5196, 9852, 9853}},
            faerieFire = {Ranks = {770, 778, 9749, 9907}},
            faerieFireFeral = {Ranks = {16857, 17390, 17391, 17392}},
            feralCharge = {Ranks = {16979}},
            hibernate = {Ranks = {2637, 18657, 18658}},
            hurricane = {Ranks = {17401, 17402}},
            insectSwarm = {Ranks = {5570, 24974, 24975, 24976, 24977}},
            moonfire = {Ranks = {8921, 8924, 8925, 8926, 8927, 8928, 8929, 9833, 9834, 9835}},
            rake = {Ranks = {1822, 1823, 1824, 9904}},
            rip = {Ranks = {1079, 9492, 9493, 9752, 9894, 9896}}
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
            autoAttack                      = {Ranks = {6603}},
            autoShoot                       = {Ranks = {5019}},
            global                          = {Ranks = {61304}},
            racial                          = getRacial(),
            shadowmeld                      = {Ranks = {58984}},
        },
        buffs                               = {
            bloodlust                       = {Ranks = {2825}},
            heroism                         = {Ranks = {32182}},
            netherwinds                     = {Ranks = {160452}},
            norgannonsForesight             = {Ranks = {236373}},
            potionOfBurstingBlood           = {Ranks = {265514}},
            potionOfFocusedResolve          = {Ranks = {298317}},
            prolongedPower                  = {Ranks = {229206}},
            racial                          = getRacial(),
            shadowmeld                      = {Ranks = {58984}},
        },
        debuffs                             = {

        },
    },
}
