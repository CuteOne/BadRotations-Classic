local function actionList_Precombat()
    -- flask
    if cast.able.flask() then
        if cast.flask() then return end
    end
    -- food
    if cast.able.food() then
        if cast.food() then return end
    end
    -- augmentation
    if cast.able.augmentation() then
        if cast.augmentation() then return end
    end
    -- snapshot_stats
    --TODO: parsing snapshot_stats
    -- potion
    if cast.able.potion() then
        if cast.potion() then return end
    end
    -- chi_burst,if=(!talent.serenity.enabled|!talent.fist_of_the_white_tiger.enabled)
    if cast.able.chiBurst() and ((not talent.serenity or not talent.fistOfTheWhiteTiger)) then
        if cast.chiBurst() then return end
    end
    -- chi_wave
    if cast.able.chiWave() then
        if cast.chiWave() then return end
    end
end
local function actionList_Rotation()
    -- # Executed before combat begins. Accepts non-harmful actions only.
    if cast.able.UNKNOWN() then
        if cast.UNKNOWN() then return end
    end
    -- auto_attack
    if cast.able.autoAttack() then
        if cast.autoAttack() then return end
    end
    -- spear_hand_strike,if=target.debuff.casting.react
    if cast.able.spearHandStrike() and (target.debuff.casting.react) then
        if cast.spearHandStrike() then return end
    end
    -- touch_of_karma,interval=90,pct_health=0.5
    if cast.able.touchOfKarma() then
        if cast.touchOfKarma() then return end
    end
    -- potion,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
    if cast.able.potion() and (buff.serenity.exists() or buff.stormEarthAndFire.exists() or (not talent.serenity and trinket.proc.agility.react) or buff.bloodlust.exists() or ttd() <= 60) then
        if cast.potion() then return end
    end
    -- call_action_list,name=serenity,if=buff.serenity.up
    if actionList_Serenity() then return end
    -- fist_of_the_white_tiger,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=3
    if cast.able.fistOfTheWhiteTiger() and ((energyTTM < 1 or (talent.serenity and cd.serenity.remain() < 2)) and chiMax - chi >= 3) then
        if cast.fistOfTheWhiteTiger() then return end
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=(energy.time_to_max<1|(talent.serenity.enabled&cooldown.serenity.remains<2))&chi.max-chi>=2&!prev_gcd.1.tiger_palm
    if cast.able.tigerPalm() and ((energyTTM < 1 or (talent.serenity and cd.serenity.remain() < 2)) and chiMax - chi >= 2 and not cast.last.tigerPalm(1)) then
        if cast.tigerPalm() then return end
    end
    -- call_action_list,name=cd
    if actionList_Cd() then return end
    -- call_action_list,name=st,if=active_enemies<3
    if #enemies.yards < 3 then
        if actionList_St() then return end
    end
    -- call_action_list,name=aoe,if=active_enemies>=3
    if #enemies.yards >= 3 then
        if actionList_Aoe() then return end
    end
end
local function actionList_St()
    -- whirling_dragon_punch
    if cast.able.whirlingDragonPunch() then
        if cast.whirlingDragonPunch() then return end
    end
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=chi>=5
    if cast.able.risingSunKick() and (chi >= 5) then
        if cast.risingSunKick() then return end
    end
    -- fists_of_fury,if=energy.time_to_max>3
    if cast.able.fistsOfFury() and (energyTTM > 3) then
        if cast.fistsOfFury() then return end
    end
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains
    if cast.able.risingSunKick() and (min) then
        if cast.risingSunKick() then return end
    end
    -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&buff.dance_of_chiji.up
    if cast.able.spinningCraneKick() and (not cast.last.spinningCraneKick(1) and buff.danceOfChiji.exists()) then
        if cast.spinningCraneKick() then return end
    end
    -- rushing_jade_wind,if=buff.rushing_jade_wind.down&active_enemies>1
    if cast.able.rushingJadeWind() and (not buff.rushingJadeWind.exists() and #enemies.yards > 1) then
        if cast.rushingJadeWind() then return end
    end
    -- reverse_harm,if=chi.max-chi>=2
    if cast.able.reverseHarm() and (chiMax - chi >= 2) then
        if cast.reverseHarm() then return end
    end
    -- fist_of_the_white_tiger,if=chi<=2
    if cast.able.fistOfTheWhiteTiger() and (chi <= 2) then
        if cast.fistOfTheWhiteTiger() then return end
    end
    -- energizing_elixir,if=chi<=3&energy<50
    if cast.able.energizingElixir() and (chi <= 3 and energy < 50) then
        if cast.energizingElixir() then return end
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(cooldown.rising_sun_kick.remains>3|chi>=3)&(cooldown.fists_of_fury.remains>4|chi>=4|(chi=2&prev_gcd.1.tiger_palm))&buff.swift_roundhouse.stack<2
    if cast.able.blackoutKick() and (not cast.last.blackoutKick(1) and (cd.risingSunKick.remain() > 3 or chi >= 3) and (cd.fistsOfFury.remain() > 4 or chi >= 4 or (chi == 2 and cast.last.tigerPalm(1))) and buff.swiftRoundhouse.stack() < 2) then
        if cast.blackoutKick() then return end
    end
    -- chi_wave
    if cast.able.chiWave() then
        if cast.chiWave() then return end
    end
    -- chi_burst,if=chi.max-chi>=1&active_enemies=1|chi.max-chi>=2
    if cast.able.chiBurst() and (chiMax - chi >= 1 and #enemies.yards == 1 or chiMax - chi >= 2) then
        if cast.chiBurst() then return end
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.tiger_palm&chi.max-chi>=2
    if cast.able.tigerPalm() and (not cast.last.tigerPalm(1) and chiMax - chi >= 2) then
        if cast.tigerPalm() then return end
    end
    -- flying_serpent_kick,if=prev_gcd.1.blackout_kick&chi>3&buff.swift_roundhouse.stack<2,interrupt=1
    if cast.able.flyingSerpentKick() and (cast.last.blackoutKick(1) and chi > 3 and buff.swiftRoundhouse.stack() < 2) then
        if cast.flyingSerpentKick() then return end
    end
end
local function actionList_Aoe()
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=(talent.whirling_dragon_punch.enabled&cooldown.whirling_dragon_punch.remains<5)&cooldown.fists_of_fury.remains>3
    if cast.able.risingSunKick() and ((talent.whirlingDragonPunch and cd.whirlingDragonPunch.remain() < 5) and cd.fistsOfFury.remain() > 3) then
        if cast.risingSunKick() then return end
    end
    -- whirling_dragon_punch
    if cast.able.whirlingDragonPunch() then
        if cast.whirlingDragonPunch() then return end
    end
    -- energizing_elixir,if=!prev_gcd.1.tiger_palm&chi<=1&energy<50
    if cast.able.energizingElixir() and (not cast.last.tigerPalm(1) and chi <= 1 and energy < 50) then
        if cast.energizingElixir() then return end
    end
    -- fists_of_fury,if=energy.time_to_max>3
    if cast.able.fistsOfFury() and (energyTTM > 3) then
        if cast.fistsOfFury() then return end
    end
    -- rushing_jade_wind,if=buff.rushing_jade_wind.down
    if cast.able.rushingJadeWind() and (not buff.rushingJadeWind.exists()) then
        if cast.rushingJadeWind() then return end
    end
    -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(((chi>3|cooldown.fists_of_fury.remains>6)&(chi>=5|cooldown.fists_of_fury.remains>2))|energy.time_to_max<=3)
    if cast.able.spinningCraneKick() and (not cast.last.spinningCraneKick(1) and (((chi > 3 or cd.fistsOfFury.remain() > 6) and (chi >= 5 or cd.fistsOfFury.remain() > 2)) or energyTTM <= 3)) then
        if cast.spinningCraneKick() then return end
    end
    -- reverse_harm,if=chi.max-chi>=2
    if cast.able.reverseHarm() and (chiMax - chi >= 2) then
        if cast.reverseHarm() then return end
    end
    -- chi_burst,if=chi<=3
    if cast.able.chiBurst() and (chi <= 3) then
        if cast.chiBurst() then return end
    end
    -- fist_of_the_white_tiger,if=chi.max-chi>=3
    if cast.able.fistOfTheWhiteTiger() and (chiMax - chi >= 3) then
        if cast.fistOfTheWhiteTiger() then return end
    end
    -- tiger_palm,target_if=min:debuff.mark_of_the_crane.remains,if=chi.max-chi>=2&(!talent.hit_combo.enabled|!prev_gcd.1.tiger_palm)
    if cast.able.tigerPalm() and (chiMax - chi >= 2 and (not talent.hitCombo or not cast.last.tigerPalm(1))) then
        if cast.tigerPalm() then return end
    end
    -- chi_wave
    if cast.able.chiWave() then
        if cast.chiWave() then return end
    end
    -- flying_serpent_kick,if=buff.bok_proc.down,interrupt=1
    if cast.able.flyingSerpentKick() and (not buff.bokProc.exists()) then
        if cast.flyingSerpentKick() then return end
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains,if=!prev_gcd.1.blackout_kick&(buff.bok_proc.up|(talent.hit_combo.enabled&prev_gcd.1.tiger_palm&chi<4))
    if cast.able.blackoutKick() and (not cast.last.blackoutKick(1) and (buff.bokProc.exists() or (talent.hitCombo and cast.last.tigerPalm(1) and chi < 4))) then
        if cast.blackoutKick() then return end
    end
end
local function actionList_Essences()
    -- concentrated_flame
    if cast.able.concentratedFlame() then
        if cast.concentratedFlame() then return end
    end
    -- blood_of_the_enemy
    if cast.able.bloodOfTheEnemy() then
        if cast.bloodOfTheEnemy() then return end
    end
    -- guardian_of_azeroth
    if cast.able.guardianOfAzeroth() then
        if cast.guardianOfAzeroth() then return end
    end
    -- focused_azerite_beam
    if cast.able.focusedAzeriteBeam() then
        if cast.focusedAzeriteBeam() then return end
    end
    -- purifying_blast
    if cast.able.purifyingBlast() then
        if cast.purifyingBlast() then return end
    end
    -- the_unbound_force
    if cast.able.theUnboundForce() then
        if cast.theUnboundForce() then return end
    end
    -- ripple_in_space
    if cast.able.rippleInSpace() then
        if cast.rippleInSpace() then return end
    end
    -- worldvein_resonance
    if cast.able.worldveinResonance() then
        if cast.worldveinResonance() then return end
    end
    -- memory_of_lucid_dreams,if=energy<40&buff.storm_earth_and_fire.up
    if cast.able.memoryOfLucidDreams() and (energy < 40 and buff.stormEarthAndFire.exists()) then
        if cast.memoryOfLucidDreams() then return end
    end
end
local function actionList_Serenity()
    -- rising_sun_kick,target_if=min:debuff.mark_of_the_crane.remains,if=active_enemies<3|prev_gcd.1.spinning_crane_kick
    if cast.able.risingSunKick() and (#enemies.yards < 3 or cast.last.spinningCraneKick(1)) then
        if cast.risingSunKick() then return end
    end
    -- fists_of_fury,if=(buff.bloodlust.up&prev_gcd.1.rising_sun_kick)|buff.serenity.remains<1|(active_enemies>1&active_enemies<5)
    if cast.able.fistsOfFury() and ((buff.bloodlust.exists() and cast.last.risingSunKick(1)) or buff.serenity.remain() < 1 or (#enemies.yards > 1 and #enemies.yards < 5)) then
        if cast.fistsOfFury() then return end
    end
    -- spinning_crane_kick,if=!prev_gcd.1.spinning_crane_kick&(active_enemies>=3|(active_enemies=2&prev_gcd.1.blackout_kick))
    if cast.able.spinningCraneKick() and (not cast.last.spinningCraneKick(1) and (#enemies.yards >= 3 or (#enemies.yards == 2 and cast.last.blackoutKick(1)))) then
        if cast.spinningCraneKick() then return end
    end
    -- blackout_kick,target_if=min:debuff.mark_of_the_crane.remains
    if cast.able.blackoutKick() and (min) then
        if cast.blackoutKick() then return end
    end
end
local function actionList_Cd()
    -- invoke_xuen_the_white_tiger
    if cast.able.invokeXuenTheWhiteTiger() then
        if cast.invokeXuenTheWhiteTiger() then return end
    end
    -- use_item,name=variable_intensity_gigavolt_oscillating_reactor
    --TODO: parsing use_item
    -- blood_fury
    if cast.able.racial() and (race == "Orc") then
        if cast.racial() then return end
    end
    -- berserking
    if cast.able.racial() and (race == "Troll") then
        if cast.racial() then return end
    end
    -- arcane_torrent,if=chi.max-chi>=1&energy.time_to_max>=0.5
    if cast.able.racial() and (chiMax - chi >= 1 and energyTTM >= 0.5 and race == "BloodElf") then
        if cast.racial() then return end
    end
    -- lights_judgment
    if cast.able.racial() and (race == "LightforgedDraenei") then
        if cast.racial() then return end
    end
    -- fireblood
    if cast.able.racial() and (race == "DarkIronDwarf") then
        if cast.racial() then return end
    end
    -- ancestral_call
    if cast.able.racial() and (race == "MagharOrc") then
        if cast.racial() then return end
    end
    -- touch_of_death,if=target.time_to_die>9
    if cast.able.touchOfDeath() and (ttd() > 9) then
        if cast.touchOfDeath() then return end
    end
    -- storm_earth_and_fire,if=cooldown.storm_earth_and_fire.charges=2|(cooldown.fists_of_fury.remains<=6&chi>=3&cooldown.rising_sun_kick.remains<=1)|target.time_to_die<=15
    if cast.able.stormEarthAndFire() and (charges.stormEarthAndFire.count() == 2 or (cd.fistsOfFury.remain() <= 6 and chi >= 3 and cd.risingSunKick.remain() <= 1) or ttd() <= 15) then
        if cast.stormEarthAndFire() then return end
    end
    -- serenity,if=cooldown.rising_sun_kick.remains<=2|target.time_to_die<=12
    if cast.able.serenity() and (cd.risingSunKick.remain() <= 2 or ttd() <= 12) then
        if cast.serenity() then return end
    end
    -- call_action_list,name=essences
    if actionList_Essences() then return end
end