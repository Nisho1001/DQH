if DQA then DQA = {} end
                                                                ---- UI Start ----
local UIConfig = CreateFrame("Frame", "DQA-Frame", UIParent, "BasicFrameTemplateWithInset");
UIConfig:SetSize(280, 250);
UIConfig:SetPoint("RIGHT", UIParent, "RIGHT");
                                                            --- UI Children Start ---
UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
UIConfig.title:SetFontObject("GameFontHighlight");
UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 1);
UIConfig.title:SetText("Dungeon Quest Announcer");
                                                              --- Movable Widget ---
UIConfig:SetMovable(true);
UIConfig:EnableMouse(true);
UIConfig:RegisterForDrag("LeftButton");
UIConfig:SetScript("OnDragStart", UIConfig.StartMoving);
UIConfig:SetScript("OnDragStop", UIConfig .StopMovingOrSizing);


    --- dropdown widget ---
    --UIConfig.dropDown = CreateFrame("Frame", nil, UIParent, "UIDropDownMenuTemplate")
    --UIConfig.dropDown:SetPoint("CENTER")
    --UIDropDownMenu_SetWidth(dropDown, 200) -- Use in place of dropDown:SetWidth
    -- Bind an initializer function to the dropdown; see previous sections for initializer function examples.
    --UIDropDownMenu_Initialize(dropDown, WPDropDownDemo_Menu)
    ---- Start Dungeon Table's ----
    local playerLevel = UnitLevel("player");
    local playerFaction = UnitFactionGroup("player");
    local text = UIConfig:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    text:SetAllPoints(true, "CENTER",0, 0);
                                                                    ---Register LevelUP ---
function UIConfig:PLAYER_LEVEL_UP(newLevel)
    -- newLevel is the new level of the player, like 42
    playerLevel = newLevel
    print(playerLevel)
end
                                                                --- register levelup end ---
local DungeonAnnounce ={
        --   level, maxLevel, dungeon/s

           {13, 18, "Ragefire Chasm\n Rember to take quests", "horde" },
           {17, 24, "Wailing Caverns\n Rember to take quests", "horde" },
           {17, 24, "Deadmines\n Rember to take quests", "alliance" },
           {22, 24, "Shadowfang Keep\n Remeber to take quest" },
           {24, 28, "Blackfanthom Deeps\n Remeber to take quests" },
           {24, 28, "Stockades\n Remeber to take quests", "alliance" },
           {28, 32, "Scarlet Monastary Graveyard\n The quests are for all 4 dungeons"},
           {32, 35, "Scarlet Monastary Library\n The quests are for all 4 dungeons"},
           {35, 38, "Scarlet Monastary Armory\n The quests are for all 4 dungeons"},
           {38, 39, "Scarlet Monastary Cathedral\n The quests are for all 4 dungeons"},
           {39, 42, "Razorfen Downs\n Rember to take quests" },
           {42, 43, "Uldaman\n Remeber to take quests"},
           {43, 48, "Zul'Farak\n Remeber to take quests"},
           {49, 53, "Sunken Temple\n Remeber to take quests \n {Phase 2; ClassQuest}"},
           {53, 55, "Blackrock Depths\n Remeber to take quests"},
           {55, 56, "Upper Blackrock spire\n Remeber to take quests"},
           {56, 58, "Dire Maul East, West, North\n"},
           {58, 60, "Scholomance and Stratholme\n Remeber"},
       }
       local function GetTextFromRow(row)
        if (playerLevel >= row[1] and playerLevel <= row[2] and
            (not row[4] or row[4] == playerFaction)) then
            return row[3];
        end
        return nil;
    end
    UIConfig:RegisterEvent("PLAYER_LEVEL_UP")
    UIConfig:SetScript("OnEvent", function(update, _, newLevel)
        playerLevel = newLevel;
        update(playerLevel)
        for newLevel, row in ipairs(DungeonAnnounce) do
            local textValue = GetTextFromRow(row);
            if (newLevel) then
                update(playerLevel) end
                if (playerLevel) == true then
                text:SetText(textValue);
            end
        end
    end)

    for _, row in ipairs(DungeonAnnounce) do
        local textValue = GetTextFromRow(row);
        if (textValue) then
            text:SetText(textValue);
        end
    end

    local highestRequirementAllowed;

for _, row in ipairs(DungeonAnnounce) do
    local textValue = GetTextFromRow(row);
    if (textValue) then
        highestRequirementAllowed = textValue;
    end
end
text:SetText(highestRequirementAllowed or "You do not meet the requirements to do a dungeon yet.");
