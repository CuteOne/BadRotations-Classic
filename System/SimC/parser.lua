--Only for local testing
player = { token = "player" }
target = { token = "target" }
--

local SimC = { }
local debug_tokens = false

local actionListFunctions = { }

local function split(p,d)
   local t, ll
   t={}
   ll=0
   if(#p == 1) then
      return {p}
   end
   while true do
      l = string.find(p, d, ll, true)
      if l ~= nil then
         table.insert(t, string.sub(p,ll,l-1))
         ll = l + 1
      else
         table.insert(t, string.sub(p,ll))
         break
      end
   end
   return t
end

local function convert_spell_name(name)
    local str = ""
    local name = name or "UNKNOWN"
    if string.find(name, "_") then
        local splits = split(name, "_")
        local index = 0
        for _, v in next, splits do
            if index > 0 then
                str = str .. v:gsub("^%l", string.upper)
            else
                str = str .. v
            end
            index = index + 1
        end
    else
        str = name
    end
    return str
end
--Token section
local TOK_UNKNOWN = 0
local TOK_PLUS = 1
local TOK_MINUS = 2
local TOK_MULT = 3
local TOK_DIV = 4
local TOK_ADD = 5
local TOK_SUB = 6
local TOK_AND = 7
local TOK_OR = 8
local TOK_XOR = 9
local TOK_NOT = 10
local TOK_EQ = 11
local TOK_NOTEQ = 12
local TOK_LT = 13
local TOK_LTEQ = 14
local TOK_GT = 15
local TOK_GTEQ = 16
local TOK_LPAR = 17
local TOK_RPAR = 18
local TOK_IN = 19
local TOK_NOTIN = 20
local TOK_NUM = 21
local TOK_STR = 22
local TOK_ABS = 23
local TOK_SPELL_LIST = 24
local TOK_FLOOR = 25
local TOK_CEIL = 26

local current_index
local action
local action_name
local target_unit
local expr_str
local token_str
local prev_token
local function next_token()
    -- print(tostring(expr_str)..tostring(current_index))
    local c = string.sub(expr_str, current_index, current_index)

    if c == nil then return TOK_UNKNOWN end
    if (prev_token == TOK_FLOOR or prev_token == TOK_CEIL) and not c == "(" then
        return TOK_UNKNOWN
    end
    token_str = string.sub(expr_str, current_index, current_index)
    current_index = current_index + 1

    if c == "@" then return TOK_ABS end
    if c == "+" then return TOK_ADD end
    if c == "-" and (prev_token == TOK_STR or prev_token == TOK_NUM or prev_token == TOK_RPAR) then
        return TOK_SUB
    end
    if c == "-" and not prev_token == TOK_STR and not prev_token == TOK_NUM and not prev_token == tok_RPAR and not tonumber(string.sub(expr_str, current_index, current_index)) then
        return TOK_SUB
    end
    if c == "*" then return TOK_MULT end
    if c == "%" then return TOK_DIV end
    if c == "&" then
        if string.sub(expr_str, current_index, current_index) == "&" then
            current_index = current_index + 1
        end
        return TOK_AND
    end
    if c == "|" then
        if string.sub(expr_str, current_index, current_index) == "|" then
            current_index = current_index + 1
        end
        return TOK_OR
    end
    if c == "^" then
        if string.sub(expr_str, current_index, current_index) == "^" then
            current_index = current_index + 1
        end
        return TOK_XOR
    end
    if c == "~" then
        if string.sub(expr_str, current_index, current_index) == "~" then
            current_index = current_index + 1
        end
        return TOK_IN
    end
    if c == "!" then
        if string.sub(expr_str, current_index, current_index) == "=" then
            current_index = current_index + 1
            token_str = token_str .. "="
            return TOK_NOTEQ
        end
        if string.sub(expr_str, current_index, current_index) == "~" then
            current_index = current_index + 1
            --FIXME: !~ symbol
            token_str = token_str .. "~"
            return TOK_NOTIN
        end
        return TOK_NOT
    end
    if c == "=" then
        if string.sub(expr_str, current_index, current_index) == "=" then
            current_index = current_index + 1
        end
        return TOK_EQ
    end
    if c == "<" then
        if string.sub(expr_str, current_index, current_index) == "=" then
            current_index = current_index + 1
            token_str = token_str .. "="
            return TOK_LTEQ
        end
        return TOK_LT
    end
    if c == ">" then
        if string.sub(expr_str, current_index, current_index) == "=" then
            current_index = current_index + 1
            token_str = token_str .. "="
            return TOK_GTEQ
        end
        return TOK_GT
    end
    if c == "(" then return TOK_LPAR end
    if c == ")" then return TOK_RPAR end

    if c:match("%w") then
        c = string.sub(expr_str, current_index, current_index)
        while (c:match("%w") or c:match("%d") or c == "_" or c == ".") do
            token_str = token_str .. c
            current_index = current_index + 1
            c = string.sub(expr_str, current_index, current_index)
        end
        if token_str:match("floor") then
            return TOK_FLOOR
        elseif token_str:match("ceil") then
            return TOK_CEIL
        else
            return TOK_STR
        end
    end

    if c:match("%d") or c == "-" then
        c = string.sub(expr_str, current_index, current_index)
        while (c:match("%d") or c == ".") do
            token_str = token_str .. c
            current_index = current_index + 1
            c = string.sub(expr_str, current_index, current_index)
        end
        return TOK_NUM
    end

    if c:match(":") then
        -- print("Found a \":\"!")
        return TOK_UNKNOWN
    end

    if debug_tokens then
        print("Unexpected token:", c)
    end
    return TOK_UNKNOWN
end

local custom_actions = {
  ["cancel_buff"] = true, -- cancels a buff, just like "/cancelaura" would do in game.
  ["swap_action_list"] = true,
  ["run_action_list"] = true, -- calls the specified action list.
  ["call_action_list"] = true, -- calls the specified action list.
  ["restart_sequence"] = true, -- will restart the specified sequence.
  ["restore_mana"] = true, -- forcefully and instantly restores mana.
  ["sequence"] = true, -- sub-actions chains to execute in a given order
  ["strict_sequence"] = true, -- strict sequences are a breed of sequence, except for they do not need to be reset, and when they are started, they cannot be stopped under normal circumstances.
  ["snapshot_stats"] = true, -- forces simulationcraft to capture your buffed stats values just before the combat actually begins.
  ["start_moving"] = true, -- triggers a movement phase, it will end only with stop_moving.
  ["stop_moving"] = true, -- ends the movement phase.
  ["use_item"] = true, -- triggers the use of an item.
  ["use_items"] = true, -- triggers the use of an item.
  ["wait"] = true, -- orders the application to stop processing the actions list for a given time. Auto-attacks and such will still be performed.
  ["wait_until_ready"] = true, -- orders the player to stop processing the actions list until some cooldown or dot expires.
  ["pool_resource"] = true, -- will force the application to stop processing the actions list while the resource is restored.
  ["variable"] = true,
  ["min"] = true,
}
local is_custom_action = false
local tokens_present = false

local function parse_resource_token(data_type, data_identifier)
    if not data_identifier then
        return convert_spell_name(data_type)
    end
    if data_identifier == "max" then
        return convert_spell_name(data_type) .. "Max"
    elseif data_identifier == "time_to_max" then
        return convert_spell_name(data_type) .. "TTM"
    elseif data_identifier == "regen" then
        return convert_spell_name(data_type) .. "Regen"
    elseif data_identifier == "deficit" then
        return convert_spell_name(data_type) .. "Deficit"
    elseif string.sub(data_identifier,1,7) == "time_to" then
        return convert_spell_name(data_type) .. "TTM(" .. string.sub(data_identifier,9,10) .. ")"
    end
end
local function parse_azerite(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    if data_arg == "enabled" then
        return "traits."..spellName..".active()"
    elseif data_arg == "rank" then
        return "traits."..spellName..".rank()"
    end
    return name_str
end
local function parse_buffs(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_arg == "up" or data_arg == "react" then
        return "buff." .. spellName .. ".exists()"
    elseif data_arg == "down" then
        return "not buff." .. spellName .. ".exists()"
    elseif data_arg == "remains" then
        return "buff." .. spellName .. ".remain()"
    elseif data_arg == "stack" then
        return "buff." .. spellName .. ".stack()"
    end
    return name_str
end
local function parse_debuffs(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_arg == "up" or data_arg == "ticking" or data_type == "ticking" or data_arg == "react" then
        return "debuff." .. spellName .. ".exists()"
    elseif data_arg == "down" then
        return "not debuff." .. spellName .. ".exists()"
    elseif data_type == "duration" or data_arg == "duration" then
        return "debuff." .. spellName .. ".duration()"
    elseif data_type == "remains" or data_arg == "remains" then
        return "debuff." .. spellName .. ".remain()"
    elseif data_arg == "stack" then
        return "debuff." .. spellName .. ".stack()"
    elseif data_type == "refreshable" or data_arg == "refreshable" then
        return "debuff." .. spellName .. ".refresh()"
    elseif data_arg == "pmultiplier" then
        return "debuff." .. spellName .. ".applied()"
    elseif data_type == "persistent_multiplier" then
        return "debuff." .. spellName .. ".calc()"
    end
    return name_str
end
local function parse_cooldowns(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_arg == "remains" then
        return "cd." .. spellName .. ".remain()"
    elseif data_arg == "up" or data_arg == "ready" then
        return "not cd." .. spellName .. ".exists()"
    elseif data_arg == "charges" then
        return "charges." .. spellName .. ".count()"
    elseif data_arg == "charges_fractional" then
        return "charges." .. spellName .. ".frac()"
    end
    return name_str
end
local function parse_charges(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_type == "charges" then
        return "charges." .. action .. ".count()"
    elseif data_type == "full_recharge_time" then
        return "charges." .. action .. ".timeTillFull()"
    end
    return name_str
end
local function parse_enemies(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_type == "active_enemies" or data_type == "spell_targets" then
        return "#enemies.yards"
    elseif data_type == "target" then
        if data_identifier == "health" and data_arg == "pct" then
            return "thp"
        elseif data_identifier == "time_to_die" then
            return "ttd()"
        elseif data_identifier == "distance" then
            return "getDistance(\"target\")"
        end
    elseif data_type == "time_to_die" then
        return "ttd()"
    end
    return name_str
end
local function parse_gcd(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_identifier == "max" then
        return "gcdMax"
    elseif data_identifier == "remains" then
        return "gcd"
    end
    return "gcdMax"
end
local function parse_prev_gcd(action,data_type,data_identifier,data_arg,spellName,name_str)
    local convertedSpellName = convert_spell_name(data_arg)
    return "cast.last." .. convertedSpellName .. "(" .. data_identifier .. ")"

end
local function parse_items(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_type == "equipped" then
        return "equiped." .. spellName
    else
        return data_identifier
    end
    return name_str
end
local function parse_cast(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_arg == "cost" then
        return "cast.cost."..spellName.."()"
    elseif data_arg == "in_flight" then
        return "cast.last." .. action .. "()"
    elseif data_type == "cast_time" then
        return "cast.time." .. action .. "()"
    end
    return name_str
end
local function parse_talent(action,data_type,data_identifier,data_arg,spellName,name_str)
    if spellName == nil or spellName == "" then spellName = action end
    -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg).." | "..tostring(spellName).." | "..tostring(name_str))
    if data_arg == "enabled" then
        return "talent." .. spellName
    end
    return name_str
end
local function isResource(data_type)
    local resourceList = {
        "mana",
        "rage",
        "focus",
        "energy",
        "combo_points",
        "rune",
        "runes",
        "runic_power",
        "soul_shards",
        "astral_power",
        "holy_power",
        "alt_power",
        "maelstrom",
        "chi",
        "insanity",
        "arcane_charges",
        "fury",
        "pain",
    }
    for i = 1, #resourceList do
        if resourceList[i] == data_type then
            return true
        end
    end
    return false
end
local function parse_expression(name_str)
    local expr = ""
    local splits = split(name_str, ".")
    local data_type = splits[1]
    if data_type then
        local data_type = splits[1]
        local data_identifier = splits[2]
        local data_arg = splits[3]
        local spellName = data_identifier and convert_spell_name(data_identifier) or ""

        -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg))
        if data_type == "action" or data_type == "cast_time" then
            return parse_cast(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "active_enemies" or data_type == "spell_targets" or data_type == "target" or data_type == "time_to_die" then
            return parse_enemies(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "azerite" then
            return parse_azerite(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "buff" then
            return parse_buffs(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "charges" or data_type == "full_recharge_time" then
            return parse_charges(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "cooldown" then
            return parse_cooldowns(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "debuff" or data_type == "dot" or data_type == "refreshable" or data_type == "ticking" or data_type == "remains" or data_type == "duration" or data_type == "persistent_multiplier" then
            return parse_debuffs(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "gcd" then
            return parse_gcd(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "prev_gcd" then
            return parse_prev_gcd(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "race" then
            return "race == " .. "\"" .. spellName .. "\""
        elseif data_type == "set_bonus" or data_type == "equipped" then
            return parse_items(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "talent" then
            return parse_talent(action,data_type,data_identifier,data_arg,spellName,name_str)
        elseif data_type == "variable" then
            return spellName
        elseif isResource(data_type) then
            if data_type == "rune" then data_type = "runes" end
            return parse_resource_token(data_type, data_identifier) or name_str
        --elseif data_type == "min" then
            -- print(tostring(action).." | "..tostring(data_type).." | "..tostring(data_identifier).." | "..tostring(data_arg))

        end
        return name_str
    else
        print("Unknown expression type:", splits[1])
        return name_str
    end
end

local function parse_tokens(expr)
    if not expr then return end
    local tokens = { }
    local token
    expr_str = expr
    current_index = 1
    prev_token = TOK_UNKNOWN

    while (true) do
        token = next_token()
        if token == TOK_UNKNOWN then break end
        table.insert(tokens, {["type"] = token, ["label"] = token_str})
        -- print(tostring(tokens[#tokens].type).." | "..tostring(tokens[#tokens].label).." | "..tostring(tokens[#tokens].expression))
        if tokens[#tokens].type == TOK_STR and not tonumber(tokens[#tokens].label) then
            target_unit = player
            tokens[#tokens].expression = parse_expression(tokens[#tokens].label)
        end

        prev_token = token
    end

    return tokens
end

local function parse_action(expr)
    local tokens
    if expr:find("name=") then
        tokens = expr:sub(select(2, expr:find("name=")) + 1)
    end
    if expr:find("target_if=") then
        customTokenFound = true
        customTokens = expr:sub(select(2, expr:find("target_if=")) + 1,select(2, expr:find(".*if=")) - 4)
    end
    if expr:find("if=") then
        tokens = expr:sub(select(2, expr:find(".*if=")) + 1)
    end
    local act = split(expr, ",")
    if string.find(act[1], "=/") then
        action = split(act[1], "/")[2]
    elseif string.find(act[1], "=") then
        action = split(act[1], "=")[2]
    end
    -- print(action.." | "..tostring(tokens))
    if not custom_actions[action] then
        tokens_present = true
        -- print(action.." | "..tostring(tokens))
        if action == "arcane_torrent" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.BloodElf"
            else
                tokens = "race.BloodElf"
            end
        end
        if action == "blood_fury" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.Orc"
            else
                tokens = "race.Orc"
            end
        end
        if action == "berserking" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.Troll"
            else
                tokens = "race.Troll"
            end
        end
        if action == "lights_judgment" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.LightforgedDraenei"
            else
                tokens = "race.LightforgedDraenei"
            end
        end
        if action == "shadowmeld" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.NightElf"
            else
                tokens = "race.NightElf"
            end
        end
        if action == "ancestral_call" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.MagharOrc"
            else
                tokens = "race.MagharOrc"
            end
        end
        if action == "fireblood" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.DarkIronDwarf"
            else
                tokens = "race.DarkIronDwarf"
            end
        end
        if action == "arcane_pulse" then
            action = "racial";
            if tokens then
                tokens = tokens .. "&race.Nightborne"
            else
                tokens = "race.Nightborne"
            end
        end
        action = convert_spell_name(action)
    else
        is_custom_action = true
    end

    if is_custom_action then
        --Parse name=
        if action == "variable" or action == "call_action_list" or action == "run_action_list" then
            tokens_present = true
            if action == "call_action_list" or action == "run_action_list" then list_name = "actionList" else list_name = "" end
            action_name = list_name .. "_" .. split(expr:sub(select(2, expr:find("name=")) + 1), ",")[1]:gsub("^%l", string.upper)
        end
        --Parse value=
        if action == "variable" then
            if expr:find("if=") then
                tokens = split(expr:sub(select(2, expr:find("if=")) + 1), ",")[1]
            else
                tokens = split(expr:sub(select(2, expr:find("value=")) + 1), ",")[1]
            end
        end
    end
    --Parse other actions

    return tokens
end

function SimC:tokens_to_string(tokens)
    local expr = ""
    for _, t in next, tokens do
        -- print(t.type)
        if t.type == TOK_AND then
            expr = expr .. " and "
        elseif t.type == TOK_EQ then
            expr = expr .. " == "
        elseif t.type == TOK_NOT then
            expr = expr .. "not "
        elseif t.type == TOK_NOTEQ then
            expr = expr .. " ~= "
        elseif t.type == TOK_OR then
            expr = expr .. " or "
        elseif t.type == TOK_MULT then
            expr = expr .. " * "
        elseif t.type == TOK_DIV then
            expr = expr .. " / "
        elseif t.type == TOK_GTEQ then
            expr = expr .. " >= "
        elseif t.type == TOK_LTEQ then
            expr = expr .. " <= "
        elseif t.type == TOK_GT then
            expr = expr .. " > "
        elseif t.type == TOK_LT then
            expr = expr .. " < "
        elseif t.type == TOK_ADD then
            expr = expr .. " + "
        elseif t.type == TOK_MINUS or t.type == TOK_SUB then
            expr = expr .. " - "
        elseif t.type == TOK_STR and not tonumber(t.label) then
            if t.expression then
                expr = expr .. t.expression
            else
                expr = expr .. "ERROR"
            end
        else
            expr = expr .. t.label
        end
        if debug_tokens then
            print(t.type, t.label)
        end
    end
    return tostring(expr)
end

function SimC:Parse(input)
    is_custom_action = false
    tokens_present = false
    action = nil
    action_name = nil
    local expr = ""
    local simcLine = input
    local actionListName, actionListNameStart, actionListNameEnd

    if input:match("actions") then
        local tokens = parse_action(input)

        if input:match("actions.") == "actions." then
            actionListNameStart = select(2, input:find("actions.")) + 1
            actionListNameEnd = select(2, input:find("=")) - 1
            actionListName = string.gsub(input:sub(actionListNameStart, actionListNameEnd), "+" , "")
        else
            actionListName = "rotation"
        end
        actionListName = "actionList_" .. convert_spell_name(actionListName:gsub("^%l", string.upper))

        if tokens then
            tokens = parse_tokens(tokens)
        end
        -- if customTokens then
        --     customTokens = parse_tokens(customTokens)
        -- end
        local conditionals = tokens and self:tokens_to_string(tokens) or ""
        -- local customConditionals = customTokens and self:tokens_to_string(customTokens) or ""
        -- print(customConditionals)

        --Add hostile check here and add target automatically somehow
        if not is_custom_action then
            expr = "if cast.able." .. action .. "()"
            if action and (tokens or conditionals ~= "") then
                local part1 = conditionals:match("(.+)not not")
                local part2 = conditionals:match("not not%s+(%S+)")
                if part1 and part2 then conditionals = part1 .. part2 end
                expr = expr .. " and (" .. conditionals .. ")"
            end
            expr = expr .. " then\n        if cast." .. action .. "() then return end\n    end"
        elseif action == "variable" then
            if tokens and tokens_present then
                for k,v in pairs(tokens) do
                    if v.label ~= nil then
                        conditionals = k;
                        expression = v.expression
                        label = v.label;
                        break
                    end
                end
                if expression ~= nil then
                    expr = "if " .. convert_spell_name(label) .. "() then\n    ".. convert_spell_name(action_name):gsub("^%u", string.lower) .. " = " .. conditionals .. "\nend"
                else
                    expr = "local " .. convert_spell_name(action_name):gsub("^%u", string.lower) .. " = " .. label
                end
            end
        elseif action == "call_action_list" or action == "run_action_list" then
            if tokens and #tokens > 1 then
                expr = "if " .. conditionals .. " then\n        "
            end
            action_name = "actionList_" .. convert_spell_name(action_name):sub(11)
            expr = expr .. "if " .. action_name .. "() then return end"
            if tokens and #tokens > 1 then
                expr = expr .. "\n    end"
            end
        else
            expr = "--TODO: parsing " .. action
        end


        if simcLine:match("=(.*)") ~= nil then simcLine = simcLine:match("=(.*)") end
        if simcLine:match("/(.*)") ~= nil then simcLine = simcLine:match("/(.*)") end
        expr = "-- " .. simcLine .."\n    "..expr
        if actionListFunctions[actionListName] == nil then
            actionListFunctions[actionListName] = { expr }
        else
            table.insert(actionListFunctions[actionListName], expr)
        end
    end
    return expr
end

local function file_exists(file)
      local f = io.open(file, "rb")
      if f then f:close() end
      return f ~= nil
end

local function lines_from(file)
      if not file_exists(file) then return "" end
      lines = ""
      for line in io.lines(file) do
        lines = lines .. "\n" .. line
      end
      return lines
end

local wowDir = 'E:\\World of Warcraft\\_retail_\\Interface\\AddOns\\'
local pathToFile = 'BadRotations\\System\\SimC\\'
local rotation = lines_from(wowDir .. pathToFile .. 'aplList.simc')
local rotation = split(rotation, "\n")

for _, v in next, rotation do
    SimC:Parse(v)
end

for actionListType, actionList in pairs(actionListFunctions) do
    print("local function " .. actionListType .. "()")
    for _, action in pairs(actionList) do
        print("    "..(action:gsub("\r", "")))
    end
    print("end")
end
