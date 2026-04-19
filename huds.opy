#!mainFile "main.opy"


rule "HUD Setup":
    wait(LoadOrder.HUDS_GLOBAL)

    hudText(
        getAllPlayers(), 
        heroIcon(Hero.JETPACK_CAT), 
        f"Made By: {CreatorName}{LeftAlign100}",
        f"Map Code: {MapCode}{LeftAlign100}",
        HudPosition.LEFT, HudOrder.CREDIT, Color.SKY_BLUE, ColorConfig[Customize.CREDIT_CODE], ColorConfig[Customize.CREDIT_NAME], 
        HudReeval.VISIBILITY, SpecVisibility.DEFAULT
    )
    hudSubheader(true[0],
        f"Discord: dsc.gg/jetpack{LeftAlign100}",
        HudPosition.LEFT, HudOrder.DISC, ColorConfig[Customize.DSC], HudReeval.VISIBILITY, SpecVisibility.DEFAULT)

    hudSubtext(getAllPlayers(), 
        "Press {0}: reset\n"
        "Hold {0}: full restart\n"
        "".format(
        inputBindingString(Button.RELOAD)
        ), 
        HudPosition.RIGHT, HudOrder.CONTROLS, ColorConfig[Customize.CONTROL_HUD_1] , HudReeval.VISIBILITY_AND_STRING
    )
    
    hudText(
        localPlayer, 
        iconString(Icon.ARROW_RIGHT) if localPlayer.IsRacing else iconString(Icon.FLAG) if localPlayer.CurrentCheckpointIdx == 0 else  iconString(Icon.CHECKMARK) , 
        "{} / {}".format(localPlayer.CurrentCheckpointIdx,len(Checkpoints)-1), 
        "Time: {}".format(localPlayer.Timer), 
        HudPosition.TOP, HudOrder.TIMER,
        ColorConfig[Customize.PLAYER_TIME], ColorConfig[Customize.PLAYER_TIME], ColorConfig[Customize.PLAYER_TIME], 
        HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT
    )

    hudSubtext(localPlayer, "\nSpeed: {}\nMultiplier: x{}{}".format(localPlayer.getSpeed(), localPlayer.SpeedMultiplier/100,LeftAlign100), HudPosition.LEFT, HudOrder.SPD, ColorConfig[Customize.SPD_COLOR], HudReeval.VISIBILITY_AND_STRING)
    
    hudSubheader(localPlayer if localPlayer.PersonalBest else null, "{} Personal best: {}".format(abilityIconString(Hero.JETPACK_CAT, Button.ABILITY_2) ,localPlayer.PersonalBest), HudPosition.RIGHT, HudOrder.PERSONAL_BEST, ColorConfig[Customize.PERSONAL_BEST], HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)


rule "Effects Setup":
    wait(LoadOrder.EFFECTS)
    createEffect(localPlayer.filter(lambda _: localPlayer.GoalCheckpoint != 0), Effect.GOOD_AURA, ColorConfig[Customize.GOAL_CP], localPlayer.GoalCheckpoint, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(localPlayer.filter(lambda _: localPlayer.AfterNextCheckpoint != 0), Effect.GOOD_AURA, ColorConfig[Customize.AFTER_NEXT_CP], localPlayer.AfterNextCheckpoint, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(localPlayer.filter(lambda _: Checkpoints[localPlayer.CurrentCheckpointIdx] != 0 and localPlayer.EditorMode > EditorMode.OFF), Effect.GOOD_AURA, Color.RED, Checkpoints[localPlayer.CurrentCheckpointIdx], RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    # checkpoint icon
    createIcon( 
        localPlayer.filter(lambda _: localPlayer.EditorMode == 0 and localPlayer.GoalCheckpoint != 0 and not localPlayer.isInViewAngle(localPlayer.GoalCheckpoint, 4) ), 
        localPlayer.GoalCheckpoint + vect(0,1,0), 
        Icon.ARROW_DOWN, 
        IconReeval.VISIBILITY_AND_POSITION, ColorConfig[Customize.GOAL_COLOR], true
    )

rule "Remake Leaderboard HUD":
    @Condition LeaderboardRemake
    LeaderboardEntries = sorted(LeaderboardEntries, lambda i: i[1])

    while len(LeaderboardText) > 0: # delete previous board (because re-val is off)
        destroyHudText(LeaderboardText[0])
        del LeaderboardText[0]
    
    if len(LeaderboardEntries) < 1:
        LeaderboardRemake = false
        return

    if LeaderboardEntries[0]:
            hudSubtext(getAllPlayers(),
                "{0} Top 5 {0}".format(abilityIconString(Hero.JETPACK_CAT,Button.SECONDARY_FIRE))
                , HudPosition.RIGHT, HudOrder.TOP5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT
            )
            LeaderboardText.append(getLastCreatedText())
            hudText(getAllPlayers(), heroIcon(Hero.JETPACK_CAT), LeaderboardEntries[0][0], LeaderboardEntries[0][1], HudPosition.RIGHT, HudOrder.TOP5+1, Color.RED, Color.RED, Color.RED, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
            LeaderboardText.append(getLastCreatedText())
        if LeaderboardEntries[1]:
            hudText(getAllPlayers(), heroIcon(Hero.JETPACK_CAT), LeaderboardEntries[1][0], LeaderboardEntries[1][1], HudPosition.RIGHT, HudOrder.TOP5+2, Color.ORANGE, Color.ORANGE, Color.ORANGE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
            LeaderboardText.append(getLastCreatedText())
        if LeaderboardEntries[2]:
            hudText(getAllPlayers(), heroIcon(Hero.JETPACK_CAT), LeaderboardEntries[2][0], LeaderboardEntries[2][1], HudPosition.RIGHT, HudOrder.TOP5+3, Color.YELLOW, Color.YELLOW, Color.YELLOW, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
            LeaderboardText.append(getLastCreatedText())
        if LeaderboardEntries[3]:
            hudText(getAllPlayers(), heroIcon(Hero.JETPACK_CAT), LeaderboardEntries[3][0], LeaderboardEntries[3][1], HudPosition.RIGHT, HudOrder.TOP5+4, Color.LIME_GREEN, Color.LIME_GREEN,Color.LIME_GREEN, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
            LeaderboardText.append(getLastCreatedText())
        if LeaderboardEntries[4]:
            hudText(getAllPlayers(), heroIcon(Hero.JETPACK_CAT), LeaderboardEntries[4][0], LeaderboardEntries[4][1], HudPosition.RIGHT, HudOrder.TOP5+5, Color.GREEN, Color.GREEN, Color.GREEN,HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
            LeaderboardText.append(getLastCreatedText())


rule "Editor HUD":
    @Condition wsEditorMode
    
    hudHeader(
        hostPlayer if localPlayer.EditorMode > EditorMode.OFF else null,
        f"{'N/A' if localPlayer.EditorMode == EditorMode.ON else 'Move Mode' if localPlayer.EditorMode == EditorMode.MOVE else 'Insert Mode' if localPlayer.EditorMode == EditorMode.INSERT else 'Remove Mode'}",
        HudPosition.TOP, 
        99, 
        Color.PURPLE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if localPlayer.EditorMode > EditorMode.OFF else null,
        f"\n\n\n\n\n\n        FORWARD\nNEXT CHECKPOINT",
        HudPosition.TOP, 
        100, 
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if localPlayer.EditorMode > EditorMode.OFF else null,
        f"\n\n\n\n\n\n\n\n<<< {'Move Mode' if (localPlayer.EditorMode + 1 if localPlayer.EditorMode < len(EditorMode) - 1 else 2) == EditorMode.MOVE else 'Insert Mode' if (localPlayer.EditorMode + 1 if localPlayer.EditorMode < len(EditorMode) - 1 else 2) == EditorMode.INSERT else 'Remove Mode'}                                                                             {'Move Checkpoint' if (localPlayer.EditorMode - 1 if localPlayer.EditorMode > 2 else len(EditorMode) - 1) == EditorMode.MOVE else 'Insert Checkpoint' if (localPlayer.EditorMode - 1 if localPlayer.EditorMode > 2 else len(EditorMode) - 1) == EditorMode.INSERT else 'Remove Checkpoint'} >>>",
        HudPosition.TOP, 
        101, 
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer,
        f"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nEnable Editor: Hold {inputBindingString(Button.INTERACT)}" if localPlayer.EditorMode <= 0 else f"Disable Editor: Hold {inputBindingString(Button.INTERACT)}",        HudPosition.TOP,
        103,
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR,
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if localPlayer.EditorMode > EditorMode.OFF else null,
        f"\n\n\n\n                                                                              Save: {inputBindingString(Button.MELEE)}" if localPlayer.EditorMode == EditorMode.MOVE and localPlayer.ActivelyEditing else f"\n\n\n\n                                                                              Move: {inputBindingString(Button.MELEE)}" if localPlayer.EditorMode == EditorMode.MOVE else f"\n\n\n\n                                                                              Insert: {inputBindingString(Button.MELEE)}" if localPlayer.EditorMode == EditorMode.INSERT else f"\n\n\n\n                                                                              Remove: {inputBindingString(Button.MELEE)}",
        HudPosition.TOP,
        103,
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR,
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if localPlayer.EditorMode > EditorMode.OFF else null,
        f"\n         BACKWARDS\nPREVIOUS CHECKPOINT",
        HudPosition.TOP, 
        104, 
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )

    hudSubtext(
        hostPlayer, 
        f"Hold {inputBindingString(Button.INTERACT)}: To Enable Editor Mode\nHold {inputBindingString(Button.INTERACT)} & {inputBindingString(Button.ULTIMATE)}: To Export Data",
        HudPosition.RIGHT, HudOrder.CONTROLS + 10, ColorConfig[Customize.CONTROL_HUD_1] , HudReeval.VISIBILITY
    )

    