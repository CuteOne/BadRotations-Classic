local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.swipe },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.swipe },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.shred },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.healingTouch}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.tigersFury },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.tigersFury },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.tigersFury }
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.cower },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.cower }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.bash },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.bash }
    };
    CreateButton("Interrupt",4,0)
-- Cleave Button
	CleaveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Cleaving Enabled", tip = "Rotation will cleave targets.", highlight = 1, icon = br.player.spell.rake },
        [2] = { mode = "Off", value = 2 , overlay = "Cleaving Disabled", tip = "Rotation will not cleave targets", highlight = 0, icon = br.player.spell.rake }
    };
    CreateButton("Cleave",5,0)
-- Prowl Button
	ProwlModes = {
        [1] = { mode = "On", value = 1 , overlay = "Prowl Enabled", tip = "Rotation will use Prowl", highlight = 1, icon = br.player.spell.prowl },
        [2] = { mode = "Off", value = 2 , overlay = "Prowl Disabled", tip = "Rotation will not use Prowl", highlight = 0, icon = br.player.spell.prowl }
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
        --     br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFFSet APL Mode to use.")
        -- -- Dummy DPS Test
        --     br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- -- Opener
        --     br.ui:createCheckbox(section, "Opener")
            -- -- Pre-Pull Timer
            -- br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        -- Auto Shapeshifts
            br.ui:createCheckbox(section,"Auto Shapeshifts","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to best form for situation.|cffFFBB00.")
        -- -- Fall Timer
        --     br.ui:createSpinnerWithout(section,"Fall Timer", 2, 1, 5, 0.25, "|cffFFFFFFSet to desired time to wait until shifting to flight form when falling (in secs).")
        -- -- Break Crowd Control
        --     br.ui:createCheckbox(section,"Break Crowd Control","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to break crowd control.|cffFFBB00.")
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
            -- -- Tiger's Fury
            -- br.ui:createCheckbox(section,"Tiger's Fury")
            -- -- Berserk
            -- br.ui:createCheckbox(section,"Berserk")
            -- -- Trinkets
            -- br.ui:createDropdownWithout(section,"Trinkets", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Trinkets.")
        br.ui:checkSectionState(section)
        -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
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

----------------
--- ROTATION ---
----------------
local function runRotation()
    -- if br.timer:useTimer("debugFeral", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------

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
        local solo
        local spell
        local stealth
        local talent
        local thp
        local traits
        local travel, cat
        local ttd
        local ttm
        local units
        local use

        -- General Locals
        local enemyBlood
        local fbMaxEnergy
        local focusedTime = GetTime()
        local friendsInRange = false
        local htTimer
        local lastForm
        local leftCombat
        local minCount
        local noDoT
        local profileStop
        local range
        local ripDuration = 24
        local targetDistance
        local useThrash
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
        swimming, moving                   = IsSwimming(), GetUnitSpeed("player")>0
        gcd                                = br.player.gcd
        gcdMax                             = br.player.gcdMax
        has                                = br.player.has
        healPot                            = getHealthPot()
        inCombat                           = br.player.inCombat
        inInstance                         = br.player.instance=="party"
        inRaid                             = br.player.instance=="raid"
        item                               = br.player.items
        level                              = br.player.level
        lootDelay                          = getOptionValue("LootDelay")
        lowestHP                           = br.friend[1].unit
        mana                               = br.player.power.mana.amount()
        minCount                           = useCDs() and 1 or 3
        mode                               = br.player.mode
        multidot                           = br.player.mode.cleave == 1 and br.player.mode.rotation < 3
        opener                             = br.player.opener
        php                                = br.player.health
        pullTimer                          = PullTimerRemain()
        race                               = br.player.race
        rage                               = br.player.power.rage.amount()
        solo                               = #br.friend < 2
        spell                              = br.player.spell
        stealth                            = br.player.buff.prowl.exists() or br.player.buff.shadowmeld.exists()
        talent                             = br.player.talent
        thp                                = getHP
        travel, cat                        = br.player.buff.travelForm.exists(), br.player.buff.catForm.exists()
        ttd                                = getTTD
        ttm                                = br.player.power.energy.ttm()
        units                              = br.player.units
        use                                = br.player.use

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
		if lastSpellCast == nil then lastSpellCast = spell.catForm end
        if opener == nil then opener = false end
        if lastForm == nil then lastForm = "Caster" end
		if not inCombat and not hastar and profileStop==true then
            profileStop = false
		end

        -- if br.player.potion.agility ~= nil then
        --     if br.player.potion.agility[1] ~= nil then
        --         agiPot = br.player.potion.agility[1].itemID
        --     else
        --         agiPot = 0
        --     end
        -- else
        --     agiPot = 0
        -- end

        -- friendsInRange = 0
        -- if not solo then
        --     for i = 1, #br.friend do
        --         if getDistance(br.friend[i].unit) < 15 then
        --             friendsInRange = friendsInRange + 1
        --         end
        --     end
        -- end

        if energy > 50 then
            fbMaxEnergy = true
        else
            fbMaxEnergy = false
        end

        -- for i = 1, #enemies.yards40 do
        --     local thisUnit = enemies.yards40[i]
        --     if debuff.moonfire.refresh(thisUnit) then
        --         if cast.moonfire(thisUnit) then return end
        --     end
        -- end

        local function cancelForm()
            if isChecked("Auto Shapeshifts") then
                if buff.catForm.exists() then
                    lastForm = "Cat"
                    CancelShapeshiftForm()
                end
                if buff.bearForm.exists() then
                    lastForm = "Bear"
                    CancelShapeshiftForm()
                end
            end
        end
        -- ChatOverlay("Mark of the Wild: Refresh: "..tostring(buff.markOfTheWild.refresh())..", Remain: "..buff.markOfTheWild.remain()..", Duration: "..buff.markOfTheWild.duration())
--------------------
--- Action Lists ---
--------------------
	    -- Action List - Extras
		local function actionList_Extras()
		    -- Shapeshift Form Management
            if isChecked("Auto Shapeshifts") then --and br.timer:useTimer("debugShapeshift", 0.25) then
                -- Return to Last Form
                if lastForm ~= "Caster" then
                    if lastForm == "Bear" then 
                        if cast.bearForm() then lastForm = "Caster" return end
                    end
                    if lastForm == "Cat" then
                        if cast.catForm() then lastForm = "Cat" return end
                    end
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
		local function actionList_Defensive()
			if useDefensive() and not IsMounted() and not stealth and not buff.prowl.exists() then
                -- if not inCombat or not (buff.catForm.exists() or buff.bearForm.exists()) then
                    -- Entangling Roots
                    if isChecked("Entangling Roots") and cast.able.entanglingRoots() and not cast.last.entanglingRoots() and inCombat 
                        and GetUnitSpeed(units.dyn30)>0 and getDistance(units.dyn30) > 8 and not debuff.entanglingRoots.exists(units.dyn30)
                    then
                        cancelForm()
                        if cast.entanglingRoots() then return end
                    end
                    -- Mark of the Wild
                    if getOptionValue("Mark of the Wild") == 2 and cast.able.markOfTheWild() and not inCombat and buff.markOfTheWild.refresh() then
                        cancelForm()
                        if cast.markOfTheWild() then return end
                    end
                    -- Thorns
                    if getOptionValue("Thorns") == 2 and cast.able.thorns() and inCombat and buff.thorns.refresh() then
                        cancelForm()
                        if cast.thorns() then return end
                    end
                    -- Rejuvenation
                    if isChecked("Rejuvenation") and not inCombat and cast.able.rejuvenation()
                        and not buff.rejuvenation.exists() and php <= getOptionValue("Rejuvenation")
                    then
                        cancelForm()
                        if cast.rejuvenation() then return end
                    end
                    -- Regrowth
                    if isChecked("Regrowth") and not inCombat and cast.able.regrowth() and not buff.regrowth.exists()
                        and php <= getOptionValue("Regrowth")
                    then
                        cancelForm()
                        if cast.regrowth() then return end
                    end
                    -- Healing Touch
                    if isChecked("Healing Touch") and cast.able.healingTouch() and ((not inCombat and php <= getOptionValue("Healing Touch"))
                        or (inCombat and php <= getOptionValue("Healing Touch") / 2))
                    then
                        cancelForm()
                        if cast.healingTouch() then return end
                    end
                -- end
            end -- End Defensive Toggle
		end -- End Action List - Defensive
	    -- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
                return
            end -- End useInterrupts check
		end -- End Action List - Interrupts
	    -- Action List - Cooldowns
		local function actionList_Cooldowns()
			if getDistance("target") < 5 then
                return
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
        -- Action List - Opener
        function actionList_Opener()
        -- -- Wild Charge
        --     if isChecked("Wild Charge") and isValidUnit("target") and getDistance("target") >= 8 and getDistance("target") < 30 then
        --         if cast.wildCharge("target") then return end
        --     end
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
        local function actionList_Bear()
            if cast.able.bearForm() and not buff.bearForm.exists() then
                if cast.bearForm() then return end
            end
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
            if cast.able.maul() and (not isKnown(spell.swipe) or #enemies.yards5f < 3) then
                if cast.maul() then return end
            end
        end
    -- Action List - Cat
        local function actionList_Cat()
            -- if cast.able.catForm() and not buff.catForm.exists() then
            --     if cast.catForm() then return end
            -- end
            -- -- actions+=/faerie_fire_feral,debuff_only=1
            -- if cast.able.fairieFireFeral() and not debuff.fairieFireFeral.exists(units.dyn5) then
            --     if cast.fairieFireFeral() then return end
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
        end
    -- Action List - Caster
        local function actionList_Caster()
            -- Moonfire
            if cast.able.moonfire() and not debuff.moonfire.exists("target")
                and (not isKnown(spell.bearForm) or (mana > cast.cost.bearForm() + cast.cost.moonfire() and getDistance(units.dyn30) > 8))
            then
                if cast.moonfire() then return end
            end
            -- Wrath
            if cast.able.wrath() and (not isKnown(spell.bearForm) or (mana > cast.cost.bearForm() + cast.cost.wrath() and getDistance(units.dyn30) > 8)) then
                if cast.wrath() then return end
            end
            if (mana <= cast.cost.bearForm() + cast.cost.wrath() and mana <= cast.cost.bearForm() + cast.cost.moonfire()) or getDistance(units.dyn30) <= 8 then
                if isKnown(spell.castForm) then
                    if cast.catForm() then lastForm = "Caster" return end
                end
                if isKnown(spell.bearForm) then
                    if cast.bearForm() then lastForm = "Caster" return end
                end
            end  
        end
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not IsMounted()~=nil then
                if isValidUnit("target") --[[and opener == true]] and getDistance("target") < 30 then
                    -- Wrath
                    if cast.able.wrath("target") and (not buff.bearForm.exists() and not buff.catForm.exists()) and not cast.last.wrath() then
                        if cast.wrath("target") then return end
                    end
                    -- Moonfire
                    if cast.able.moonfire("target") and (not buff.bearForm.exists() and not buff.catForm.exists()) then
                        if cast.moonfire("target") then return end
                    end
                    -- Claw
                    if cast.able.claw("target") and buff.catForm.exists() then
                        if cast.claw("target") then return end
                    end
                    -- if getDistance("target") < 5 then
                    StartAttack()
                    -- end
                end
                -- Opener
                -- if actionList_Opener() then return end
            end
        end -- End Action List - PreCombat
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
            if actionList_Extras() then return end
            --------------------------
            --- Defensive Rotation ---
            --------------------------
            if actionList_Defensive() then return end
            ------------------------------
            --- Out of Combat Rotation ---
            ------------------------------
            if actionList_PreCombat() then return end
			-- if actionList_Opener() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
        -- Cat is 4 fyte!
            -- if level >= 20 and inCombat and not cat and #enemies.yards5 > 0 and not moving and isChecked("Auto Shapeshifts") then
            --     if cast.catForm("player") then return end
            -- else
            if inCombat and profileStop==false and not isChecked("Death Cat Mode") and isValidUnit("target") then --and opener == true then
                targetDistance = getDistance("target")
                -- Wild Charge
                -- -- wild_charge
                -- if isChecked("Displacer Beast / Wild Charge") and isValidUnit("target") then
                --     if cast.wildCharge("target") then return end
                -- end
                -- Displacer Beast
                -- displacer_beast,if=movement.distance>10
                -- Dash/Worgen Racial
                -- dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
                -- Rake/Shred from Stealth
                -- rake,if=buff.prowl.up|buff.shadowmeld.up
                -- if (buff.prowl.exists() or buff.shadowmeld.exists()) and getDistance("target") < 40 then
                --     StartAttack()
                -- else
                if targetDistance < 40 then
                    -- auto_attack
                    -- StartAttack()
                    ------------------------------
                    --- In Combat - Interrupts ---
                    ------------------------------
                    -- if actionList_Interrupts() then return end
                    ---------------------------
                    --- SimulationCraft APL ---
                    ---------------------------
                    -- if getOptionValue("APL Mode") == 1 then
                        -- StartAttack()
                        if targetDistance < 8 then
                            if not buff.catForm.exists() and isKnown(spell.catForm) and php > 30 then
                                SpellStopCasting()
                                if cast.catForm() then return end
                            end
                            if not buff.bearForm.exists() and isKnown(spell.bearForm) and (php <= 30 or not isKnown(spell.catForm)) then
                                SpellStopCasting()
                                if cast.bearForm() then return end
                            end
                        end
                        if not (buff.bearForm.exists() or buff.catForm.exists()) then
                            if actionList_Caster() then return end
                        end
                        if buff.bearForm.exists() then
                            if actionList_Bear() then return end
                        end
                        if buff.catForm.exists() then
                            if actionList_Cat() then return end
                        end
                    -- end -- End SimC APL
			    end -- End No Stealth | Rotation Off Check
			end --End In Combat
		end --End Rotation Logic
    -- end -- End Timer
end -- End runRotation
local id = 'DRUID'
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})