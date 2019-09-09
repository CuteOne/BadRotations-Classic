local rotationName = "CuteOne"
local br = _G["br"]

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation",
            tip = "Swaps between Single and Multiple based on number of targets in range.",
            highlight = 1, icon = br.player.spell.swipe },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation",
            tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.swipe },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation",
            tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.shred },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled",
            tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healingTouch}
    };
    CreateButton("Rotation",1,0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated",
            tip = "Automatic Cooldowns - Boss Detection.",
            highlight = 1, icon = br.player.spell.tigersFury },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled",tip = "Cooldowns used regardless of target.",
            highlight = 0, icon = br.player.spell.tigersFury },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.",
            highlight = 0, icon = br.player.spell.tigersFury }
    };
    CreateButton("Cooldown",2,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.",
            highlight = 1, icon = br.player.spell.cower },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.",
            highlight = 0, icon = br.player.spell.cower }
    };
    CreateButton("Defensive",3,0)
    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.",
            highlight = 1, icon = br.player.spell.bash },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.",
            highlight = 0, icon = br.player.spell.bash }
    };
    CreateButton("Interrupt",4,0)
    -- Bleed Button
	BleedModes = {
        [1] = { mode = "On", value = 1 , overlay = "Cleaving Enabled", tip = "Rotation will cleave targets.",
            highlight = 1, icon = br.player.spell.rake },
        [2] = { mode = "Off", value = 2 , overlay = "Cleaving Disabled", tip = "Rotation will not cleave targets",
            highlight = 0, icon = br.player.spell.rake }
    };
    CreateButton("Bleed",5,0)
    -- Prowl Button
	ProwlModes = {
        [1] = { mode = "On", value = 1 , overlay = "Prowl Enabled", tip = "Rotation will use Prowl",
            highlight = 1, icon = br.player.spell.prowl },
        [2] = { mode = "Off", value = 2 , overlay = "Prowl Disabled", tip = "Rotation will not use Prowl",
            highlight = 0, icon = br.player.spell.prowl }
    };
    CreateButton("Prowl",6,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
        -- General Options
        section = br.ui:createSection(br.ui.window.profile, "General")
            -- -- APL
            -- br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFFSet APL Mode to use.")
            -- -- Dummy DPS Test
            -- br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
            -- -- Opener
            -- br.ui:createCheckbox(section, "Opener")
            -- -- Pre-Pull Timer
            -- br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
            -- Auto Shapeshifts
            br.ui:createCheckbox(section,"Auto Shapeshifts","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to best form for situation.|cffFFBB00.")
            -- -- Fall Timer
            -- br.ui:createSpinnerWithout(section,"Fall Timer", 2, 1, 5, 0.25, "|cffFFFFFFSet to desired time to wait until shifting to flight form when falling (in secs).")
            -- -- Break Crowd Control
            -- br.ui:createCheckbox(section,"Break Crowd Control","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to break crowd control.|cffFFBB00.")
        br.ui:checkSectionState(section)
        -- Buffs
        section = br.ui:createSection(br.ui.window.profile, "Buffs")
            -- Mark of the Wild
            br.ui:createDropdownWithout(section, "Mark of the Wild", {"|cff00FF00Any", "|cffFFFF00Player Only", "|cffFF0000None"}, 2, "|cffFFFFFFHow to use Mark of the Wild.")
            -- Thorns
            br.ui:createDropdownWithout(section, "Thorns", {"|cff00FF00Any", "|cffFFFF00Player Only", "|cffFF0000None"}, 2, "|cffFFFFFFHow to use Thorns.")
        br.ui:checkSectionState(section)
        -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
            -- -- Potion
            -- br.ui:createCheckbox(section,"Potion")
            -- -- Elixir
            -- br.ui:createDropdownWithout(section,"Elixir", {"Flask of Seventh Demon","Repurposed Fel Focuser","Oralius' Whispering Crystal","None"}, 1, "|cffFFFFFFSet Elixir to use.")
            -- -- Racial
            -- br.ui:createCheckbox(section,"Racial")
            -- Tiger's Fury
            br.ui:createCheckbox(section,"Tiger's Fury")
            -- -- Berserk
            -- br.ui:createCheckbox(section,"Berserk")
            -- -- Trinkets
            -- br.ui:createDropdownWithout(section,"Trinkets", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Trinkets.")
        br.ui:checkSectionState(section)
        -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Abolish Poison
            br.ui:createCheckbox(section, "Abolish Poison")
            -- Cure Poison
            br.ui:createCheckbox(section, "Cure Poison")
            -- Entangling Roots
            br.ui:createCheckbox(section, "Entangling Roots")
            -- Faerie Fire
            br.ui:createCheckbox(section, "Faerie Fire")
            -- Healing Touch
            br.ui:createSpinner(section, "Healing Touch", 80, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
            -- Regrowth
            br.ui:createSpinner(section, "Regrowth",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
            -- Rejuvenation
            br.ui:createSpinner(section, "Rejuvenation", 75, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
            -- Rebirth
            br.ui:createCheckbox(section,"Rebirth")
            br.ui:createDropdownWithout(section, "Rebirth - Target", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
            -- Revive
            br.ui:createCheckbox(section,"Revive")
            br.ui:createDropdownWithout(section, "Revive - Target", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
        br.ui:checkSectionState(section)
        -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
            -- Interrupt Percentage
            br.ui:createSpinner(section, "Interrupts",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        br.ui:checkSectionState(section)
        -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
            -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
            -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
            -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
            -- Cleave Toggle
            br.ui:createDropdown(section, "Cleave Mode", br.dropOptions.Toggle,  6)
            -- Prowl Toggle
            br.ui:createDropdown(section, "Prowl Mode", br.dropOptions.Toggle,  6)
            -- Form Toggle
            br.ui:createDropdown(section, "Form Mode", br.dropOptions.Toggle, 6)
            -- Pause Toggle
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

--------------
--- Locals ---
--------------
-- BR API Locals
local buff
local cast
local comboPoints
local cd
local charges
local debuff
local debug
local enemies
local energy, energyRegen, energyDeficit
local equiped
local essence
local swimming, moving
local gcd
local gcdMax
local has
local healPot
local inCombat
local inRaid
local inInstance
local item
local level
local lootDelay
local lowestHP
local mana
local mode
local multidot
local opener
local php
local pullTimer
local race
local rage
local solo
local spell
local stealth
local talent
local thp
local travel, cat
local ttd
local ttm
local units
local use

-- General Locals
local actionList = {}
local behind
local enemyBlood
local fbMaxEnergy
local focusedTime = GetTime()
local friendsInRange = false
local htTimer
local lastForm
local lastFormID
local leftCombat
local minCount
local noDoT
local profileStop
local range
local ripDuration = 24
local shapeshifted
local targetDistance
local useThrash

-----------------------
--- Local Functions ---
-----------------------
local function shapeshiftCost(castSpell)
    if isChecked("Auto Shapeshifts") then
        if level < 10 or not (IsSpellKnown(spell.direBearForm) or IsSpellKnown(spell.bearForm)
            or IsSpellKnown(spell.catForm) or IsSpellKnown(spell.moonkinForm)
            or IsSpellKnown(spell.travelForm) or IsSpellKnown(spell.aquaticForm))
        then
            return 0
        end
        local shapeID = GetShapeshiftForm() or 0
        local shapeSpell
        local shapeCost
        if shapeID > 0 then
            shapeSpell = select(4,GetShapeshiftFormInfo(shapeID))
            shapeCost = GetSpellPowerCost(GetSpellInfo(shapeSpell))[1].cost
        else
            shapeSpell = lastFormID
            if shapeSpell == nil and not shapeshifted then shapeSpell = spell.catForm end
            shapeCost = GetSpellPowerCost(GetSpellInfo(shapeSpell))[1].cost
        end
        local spellCost = GetSpellPowerCost(GetSpellInfo(castSpell))[1].cost
        return shapeCost + spellCost
    end
    return 0
end

--------------------
--- Action Lists ---
--------------------
-- Action List - Extras
actionList.Extras = function()
    -- Prowl
    if mode.prowl == 1 and not inCombat and cast.able.prowl()
        and buff.catForm.exists() and not buff.prowl.exists()
    then
        for i = 1, #enemies.yards20nc do
            local thisUnit = enemies.yards20nc[i]
            if UnitReaction(thisUnit,"player") < 4 or isValidUnit(thisUnit) then
                if cast.prowl() then return end
            end
        end
    end
    -- Shapeshift Form Management
    if isChecked("Auto Shapeshifts") then --and br.timer:useTimer("debugShapeshift", 0.25) then
        -- Cancel Form when targeting NPC near you
        if getDistance("target") < 8 and UnitIsFriend("target","player") and not UnitIsDeadOrGhost("target")
            and not UnitIsPlayer("target") and (buff.bearForm.exists() or buff.catForm.exists())
        then
            CancelShapeshiftForm()
        end
        -- Aquatic Form
        if cast.able.aquaticForm("player") and not inCombat and swimming
        and not buff.aquaticForm.exists() and not buff.prowl.exists() and moving
        then
            -- if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then RunMacroText("/CancelForm") end
            if cast.aquaticForm("player") then debug("Casting Aquatic From [Swimming]") return true end
        end
    end -- End Shapeshift Form Management
    -- Dummy Test
    if isChecked("DPS Testing") then
        if GetObjectExists("target") then
            if getCombatTime() >= (tonumber(getOptionValue("DPS Testing"))*60) and isDummy() then
                StopAttack()
                ClearTarget()
                Print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
                profileStop = true
            end
        end
    end -- End Dummy Test
end -- End Action List - Extras
-- Action List - Defensive
actionList.Defensive = function()
    if useDefensive() and not IsMounted() and not stealth then
        -- Abolish Poison
        if isChecked("Abolish Poison") and (cast.able.abolishPoison() or shapeshifted)
            and canDispel(spell.abolishPoison) and not buff.abolishPoison.exists()
            and mana >= shapeshiftCost(spell.abolishPoison)
        then
            CancelShapeshiftForm()
            if cast.abolishPoison() then return true end
        end
        -- Cure Poison
        if isChecked("Cure Poison") and (cast.able.curePoison() or shapeshifted) and not IsSpellKnown(spell.abolishPoison)
            and canDispel(spell.curePoison) and mana >= shapeshiftCost(spell.curePoison)
        then
            CancelShapeshiftForm()
            if cast.curePoison() then return true end
        end
        -- Entangling Roots
        if isChecked("Entangling Roots") and (cast.able.entanglingRoots() or shapeshifted) and not cast.last.entanglingRoots()
            and GetUnitSpeed("target") > 0 and getDistance("target") > 8 and not UnitIsFacing("target","player")
            and not debuff.entanglingRoots.exists("target") and mana >= shapeshiftCost(spell.entanglingRoots)
            and inCombat and isValidUnit("target")
        then
            CancelShapeshiftForm()
            if cast.entanglingRoots("target") then return end
        end
        -- Faerie Fire
        if isChecked("Faerie Fire") and cast.able.faerieFire() and not debuff.faerieFire.exists("target")
            and not shapeshifted and mana >= shapeshiftCost(spell.faerieFire) and getDistance("target") > 8
            and isValidUnit("target")
        then
            CancelShapeshiftForm()
            if cast.faerieFire() then return end
        end
        -- Mark of the Wild
        if (cast.able.markOfTheWild() or shapeshifted)
            and mana >= shapeshiftCost(spell.markOfTheWild)
        then
            -- Target Friendly Player
            if getOptionValue("Mark of the Wild") == 1 and UnitIsPlayer("target")
                and UnitIsFriend("target") and not UnitIsDeadOrGhost("target")
                and buff.markOfTheWild.refresh("target")
            then
                CancelShapeshiftForm()
                if cast.markOfTheWild("target") then return end
            end
            -- Self Only
            if getOptionValue("Mark of the Wild") ~= 3 and buff.markOfTheWild.refresh("player") then
                CancelShapeshiftForm()
                if cast.markOfTheWild("player") then return end
            end
        end
        -- Thorns
        if (cast.able.thorns() or shapeshifted) and mana >= shapeshiftCost(spell.thorns) then
            -- Target Friendly Player
            if getOptionValue("Thorns") == 1 and UnitIsPlayer("target")
                and UnitIsFriend("target") and not UnitIsDeadOrGhost("target")
                and buff.thorns.refresh("target")
            then
                CancelShapeshiftForm()
                if cast.thorns("target") then return end
            end
            -- Self Only
            if getOptionValue("Thorns") ~= 3 and buff.thorns.refresh("player") then
                CancelShapeshiftForm()
                if cast.thorns("player") then return end
            end
        end
        -- Rejuvenation
        if isChecked("Rejuvenation") and (cast.able.rejuvenation() or shapeshifted)
            and not buff.rejuvenation.exists() and php <= getOptionValue("Rejuvenation")
            and mana >= shapeshiftCost(spell.rejuvenation)
        then
            CancelShapeshiftForm()
            if cast.rejuvenation() then return end
        end
        -- Regrowth
        if isChecked("Regrowth") and (cast.able.regrowth() or shapeshifted)
            and not buff.regrowth.exists() and php <= getOptionValue("Regrowth")
            and mana >= shapeshiftCost(spell.regrowth)
        then
            CancelShapeshiftForm()
            if cast.regrowth() then return end
        end
        -- Healing Touch
        if isChecked("Healing Touch") and (cast.able.healingTouch() or shapeshifted)
            and php <= getOptionValue("Healing Touch") and mana >= shapeshiftCost(spell.healingTouch)
        then
            CancelShapeshiftForm()
            if cast.healingTouch() then return end
        end
    end -- End Defensive Toggle
end -- End Action List - Defensive
-- Action List - Interrupts
actionList.Interrupts = function()
    if useInterrupts() then
        return
    end -- End useInterrupts check
end -- End Action List - Interrupts
-- Action List - Cooldowns
actionList.Cooldowns = function()
    if useCDs() and getDistance("target") < 5 then
        -- Tiger's Fury
        if isChecked("Tiger's Fury") and buff.tigersFury.refresh()
            and (comboPoints == 5 or energy == 100)
        then
            if cast.tigersFury() then return end
        end
    end -- End useCooldowns check
end -- End Action List - Cooldowns
-- Action List - Opener
actionList.Opener = function()
    -- -- Wild Charge
    -- if isChecked("Wild Charge") and isValidUnit("target") and getDistance("target") >= 8 and getDistance("target") < 30 then
    --     if cast.wildCharge("target") then return end
    -- end
    -- Start Attack
    -- auto_attack
    if isChecked("Opener") and isBoss("target") and opener == false then
        if isValidUnit("target") then --and getDistance("target") < 5 then
            opener = true
        end
    elseif (UnitExists("target") and not isBoss("target")) or not isChecked("Opener") then
        opener = true
    end
end -- End Action List - Opener
-- Action List - Bear
actionList.Bear = function()
    StartAttack()
    -- Enrage
    if cast.able.enrage() and rage < 10 and getDistance(units.dyn5) < 8 then
        if cast.enrage() then return end
    end
    -- Demoralizing Roar
    if cast.able.demoralizingRoar() and not debuff.demoralizingRoar.exists(units.dyn10) and getDistance(units.dyn10) < 10 then
        if cast.demoralizingRoar() then return end
    end
    -- Swipe
    if cast.able.swipe() and #enemies.yards5f >= 3 then
        if cast.swipe() then return end
    end
    -- Maul
    if cast.able.maul() and (not IsSpellKnown(spell.swipe) or #enemies.yards5f < 3) then
        if cast.maul() then return end
    end
end
-- Action List - Cat
actionList.Cat = function()
    -- -- if cast.able.catForm() and not buff.catForm.exists() then
    -- --     if cast.catForm() then return end
    -- -- end
    -- -- actions+=/faerie_fire_feral,debuff_only=1
    -- if cast.able.faerieFireFeral() and not debuff.faerieFireFeral.exists(units.dyn5) then
    --     if cast.faerieFireFeral() then return end
    -- end
    -- -- actions+=/tigers_fury,if=energy<=30&!buff.berserk.up
    -- -- actions+=/berserk_cat,if=energy>=80&energy<=90&!buff.tigers_fury.up
    -- -- actions+=/savage_roar,if=buff.combo_points.stack>=1&buff.savage_roar.remains<=1
    -- -- actions+=/rip,if=buff.combo_points.stack>=5&target.time_to_die>=6
    -- if cast.able.rip() and comboPoints >= 5 and ttd(units.dyn5) >= 6 then
    --     if cast.rip() then return end
    -- end
    -- -- actions+=/savage_roar,if=buff.combo_points.stack>=3&target.time_to_die>=9&buff.savage_roar.remains<=8&dot.rip.remains-buff.savage_roar.remains>=-3
    -- -- actions+=/ferocious_bite,if=target.time_to_die<=6&buff.combo_points.stack>=5
    -- -- actions+=/ferocious_bite,if=target.time_to_die<=1&buff.combo_points.stack>=4
    -- -- actions+=/ferocious_bite,if=buff.combo_points.stack>=5&dot.rip.remains>=8&buff.savage_roar.remains>=11
    -- -- actions+=/shred,extend_rip=1,if=dot.rip.remains<=4
    -- -- actions+=/mangle_cat,mangle<=1
    -- if cast.able.mangleCat() and debuff.mangleCat.remain() <= 1 then
    --     if cast.mangleCat() then return end
    -- end
    -- -- actions+=/rake,if=target.time_to_die>=9
    -- if cast.able.rake() and ttd(units.dyn5) >= 9 then
    --     if cast.rake() then return end
    -- end
    -- -- actions+=/shred,if=(buff.combo_points.stack<=4|dot.rip.remains>=0.8)&dot.rake.remains>=0.4&(energy>=80|buff.omen_of_clarity.react|dot.rip.remains<=2|buff.berserk.up|cooldown.tigers_fury.remains<=3)
    -- if (cast.able.shred() or cast.able.claw()) and (comboPoints <= 4 or debuff.rip.remain(units.dyn5) >= 0.8) and (debuff.rake.remain(units.dyn5) >= 0.4 or not isKnown(spell.rake))
    --     and (energy >= 80 or buff.clearcasting.exists() or debuff.rip.remain(units.dyn5) <= 2 or cd.tigersFury.remain() <= 3)
    -- then
    --     if cast.able.shred() then
    --         if cast.shred() then return end
    --     elseif cast.able.claw() then
    --         if cast.claw() then return end
    --     end
    -- end
    -- -- actions+=/shred,if=target.time_to_die<=9
    -- if (cast.able.shred() or cast.able.claw()) and ttd(units.dyn5) <= 9 then
    --     if cast.able.shred() then
    --         if cast.shred() then return end
    --     elseif cast.able.claw() then
    --         if cast.claw() then return end
    --     end
    -- end
    -- -- actions+=/shred,if=buff.combo_points.stack<=0&buff.savage_roar.remains<=2
    -- if (cast.able.shred() or cast.able.claw()) and comboPoints <= 0 and buff.savageRoar.remain() <= 2 then
    --     if cast.able.shred() then
    --         if cast.shred() then return end
    --     elseif cast.able.claw() then
    --         if cast.claw() then return end
    --     end
    -- end
    if range.dyn5 and UnitIsFacing("player",units.dyn5) then
        if comboPoints == 5 then
            -- Rip
            if mode.bleed == 1 and cast.able.rip() then
                if cast.rip() then return end
            end
        end
        if comboPoints < 5 or (mode.bleed == 2 and not IsSpellKnown(spell.ferociousBite)) then
            -- Rake
            if mode.bleed == 1 and cast.able.rake() and debuff.rake.refresh(units.dyn5) then
                if cast.rake() then return end
            end
            -- Shred
            if cast.able.shred() and behind then
                if cast.shred() then return end
            end
            -- Claw
            if cast.able.claw() and (not behind or not IsSpellKnown(spell.shred)) then
                if cast.claw() then return end
            end
        end
    end
end
-- Action List - Caster
actionList.Caster = function()
    -- Moonfire
    if cast.able.moonfire() and not debuff.moonfire.exists("target") and (lastForm == nil
        or (cast.able.lastForm() and getDistance("target") >= 8 and mana >= shapeshiftCost(spell.moonfire)))
    then
        if cast.moonfire() then return end
    end
    -- Wrath
    if cast.able.wrath() and not moving and (debuff.moonfire.exists("target") or not IsSpellKnown(spell.moonfire))
        and (lastForm == nil or (cast.able.lastForm() and getDistance("target") >= 8 and mana >= shapeshiftCost(spell.wrath)))
        and not cast.current.wrath()
    then
        if cast.wrath() then return end
    end
    -- Return to Last Form
    if isChecked("Auto Shapeshifts") and lastForm ~= nil
        and ((cast.able.lastForm() and mana < shapeshiftCost(spell.wrath)
        and mana < shapeshiftCost(spell.moonfire)) or getDistance("target") < 8)
    then
        if cast.lastForm() then return true end
    end
end
-- Action List - PreCombat
actionList.PreCombat = function()
    if not inCombat and not IsMounted()~=nil then
        if isValidUnit("target") --[[and opener == true]] and getDistance("target") < 30 then
            if not shapeshifted then
                -- Faerie Fire
                if isChecked("Faerie Fire") and cast.able.faerieFire()
                    and not debuff.faerieFire.exists("target")
                then
                    if cast.faerieFire("target") then return end
                end
                -- Wrath
                if cast.able.wrath("target") and not cast.last.wrath() then
                    if cast.wrath("target") then return end
                end
                -- Moonfire
                if cast.able.moonfire("target") then
                    if cast.moonfire("target") then return end
                end
            elseif buff.catForm.exists() then
                if getDistance("target") < 5 and UnitIsFacing("player","target") then
                    -- Tiger's Fury
                    if cast.able.tigersFury() and not buff.tigersFury.exists() then
                        if cast.tigersFury() then return end
                    end
                    -- Shred
                    if cast.able.shred("target") and behind
                        and (buff.tigersFury.exists() or not IsSpellKnown(spell.tigersFury))
                    then
                        if cast.shred("target") then return end
                    end
                    -- Claw
                    if cast.able.claw("target") and (not behind or not IsSpellKnown(spell.shred))
                        and (buff.tigersFury.exists() or not IsSpellKnown(spell.tigersFury))
                    then
                        if cast.claw("target") then return end
                    end
                end
            else
                StartAttack()
            end
        end
        -- Opener
        -- if actionList_Opener() then return end
    end
end -- End Action List - PreCombat

----------------
--- ROTATION ---
----------------
local function runRotation()
    --------------
    --- Locals ---
    --------------
    -- BR API
    buff                               = br.player.buff
    cast                               = br.player.cast
    comboPoints                        = br.player.power.comboPoints.amount()
    cd                                 = br.player.cd
    charges                            = br.player.charges
    debuff                             = br.player.debuff
    debug                              = br.addonDebug
    enemies                            = br.player.enemies
    energy, energyRegen, energyDeficit = br.player.power.energy.amount(), br.player.power.energy.regen(), br.player.power.energy.deficit()
    equiped                            = br.player.equiped
    gcd                                = br.player.gcd
    gcdMax                             = br.player.gcdMax
    has                                = br.player.has
    inCombat                           = br.player.inCombat
    inInstance                         = br.player.instance=="party"
    inRaid                             = br.player.instance=="raid"
    item                               = br.player.items
    level                              = br.player.level
    lowestHP                           = br.friend[1].unit
    mana                               = br.player.power.mana.amount()
    mode                               = br.player.mode
    multidot                           = br.player.mode.cleave == 1 and br.player.mode.rotation < 3
    opener                             = br.player.opener
    php                                = br.player.health
    race                               = br.player.race
    rage                               = br.player.power.rage.amount()
    solo                               = #br.friend < 2
    spell                              = br.player.spell
    stealth                            = br.player.buff.prowl.exists() or br.player.buff.shadowmeld.exists()
    talent                             = br.player.talent
    travel, cat                        = br.player.buff.travelForm.exists(), br.player.buff.catForm.exists()
    ttm                                = br.player.power.energy.ttm()
    units                              = br.player.units
    use                                = br.player.use
    -- Other API
    behind                             = ObjectExists("target") and not UnitIsFacing("target","player") --ObjectIsBehind("player","target")
    healPot                            = getHealthPot()
    lootDelay                          = getOptionValue("LootDelay")
    minCount                           = useCDs() and 1 or 3
    pullTimer                          = PullTimerRemain()
    swimming, moving                   = IsSwimming(), GetUnitSpeed("player")>0
    thp                                = getHP
    ttd                                = getTTD

    -- Get Best Unit for Range
    -- units.get(range, aoe)
    units.get(40)
    units.get(30)
    units.get(8,true)
    units.get(5)
    if range == nil then range = {} end
    range.dyn40 = getDistance(units.dyn40) < 40
    range.dyn8AOE = getDistance(units.dyn8AOE) < 8
    range.dyn5 = getDistance(units.dyn5) < 5

    -- Get List of Enemies for Range
    -- enemies.get(range, from unit, no combat, variable)
    enemies.get(40) -- makes enemies.yards40
    enemies.yards30r = getEnemiesInRect(10,30,false) or 0
    enemies.get(20,"player",true) -- makes enemies.yards20nc
    enemies.get(20)
    enemies.get(13,"player",false,true) -- makes enemies.yards13f
    enemies.get(8) -- makes enemies.yards8
    enemies.get(8,"player",false,true) -- makes enemies.yards8f
    enemies.get(8,"target") -- makes enemies.yards8t
    enemies.get(5,"player",false,true) -- makes enemies.yards5f

    if leftCombat == nil then leftCombat = GetTime() end
    if profileStop == nil then profileStop = false end
    if opener == nil then opener = false end
    if not inCombat and not ObjectExists("target") and profileStop==true then
        profileStop = false
    end

    shapeshifted = buff.direBearForm.exists() or buff.bearForm.exists() or buff.catForm.exists()
    or buff.moonkinForm.exists() or buff.travelForm.exists() or buff.aquaticForm.exists()

    if buff.direBearForm.exists() then lastForm = "direBearForm" end
    if buff.bearForm.exists() then lastForm = "bearForm" end
    if buff.catForm.exists() then lastForm = "catForm" end
    if buff.moonkinForm.exists() then lastForm = "moonkinForm" end
    if buff.travelForm.exists() then lastForm = "travelForm" end
    if buff.aquaticForm.exists() then lastForm = "aquaticForm" end
    cast.lastForm = cast[lastForm]
    cast.able.lastForm = cast.able[lastForm]
    buff.lastForm = buff[lastForm]
    lastFormID = spell[lastForm]

    -- if ObjectExists("target") then
    --     Print("Facing: "..tostring(ObjectIsFacing("target","player")).." "..tostring(UnitIsFacing("target","player")).." | Position: "..ObjectPosition("target"))
    -- end
    ---------------------
    --- Begin Profile ---
    ---------------------
    -- Profile Stop | Pause
    if not inCombat and not hastar and profileStop==true then
        profileStop = false
    elseif (inCombat and profileStop==true) or pause() or mode.rotation==4 then
        return true
    else
        -----------------------
        --- Extras Rotation ---
        -----------------------
        if actionList.Extras() then return end
        --------------------------
        --- Defensive Rotation ---
        --------------------------
        if actionList.Defensive() then return end
        ------------------------------
        --- Out of Combat Rotation ---
        ------------------------------
        if actionList.PreCombat() then return end
        -- if actionList_Opener() then return end
        --------------------------
        --- In Combat Rotation ---
        --------------------------
        if inCombat and profileStop==false and isValidUnit("target") then --and opener == true then
            targetDistance = getDistance("target")
            if targetDistance < 40 then
                -- auto_attack
                -- StartAttack()
                ------------------------------
                --- In Combat - Interrupts ---
                ------------------------------
                -- if actionList.Interrupts() then return end
                -----------------------------
                --- In Combat - Cooldowns ---
                -----------------------------
                if actionList.Cooldowns() then return end
                ---------------------------
                --- SimulationCraft APL ---
                ---------------------------
                -- if getOptionValue("APL Mode") == 1 then
                    -- StartAttack()
                    if not shapeshifted then
                        if actionList.Caster() then return end
                    end
                    if buff.bearForm.exists() then
                        if actionList.Bear() then return end
                    end
                    if buff.catForm.exists() then
                        if actionList.Cat() then return end
                    end
                -- end -- End SimC APL
            end -- End No Stealth | Rotation Off Check
        end --End In Combat
    end --End Rotation Logic
end -- End runRotation
local id = 'DRUID'
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})