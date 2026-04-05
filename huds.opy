#!mainFile "main.opy"


rule "HUD Setup":
    wait(LoadOrder.HUDS_GLOBAL)
    # hudSubtext(getAllPlayers(), "\n", HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    # hudSubtext(getAllPlayers(), "Hold {0} to restart".format(inputBindingString(Button.RELOAD)), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    # hudSubtext(getAllPlayers(), "Hold {0} to change camera".format(inputBindingString(Button.INTERACT)), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    # hudHeader(getAllPlayers(), "Lobby Best: {0} by {1}".format(sorted(Lobby_High)[0], Lobby_Best), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    # hudHeader(getAllPlayers(), "Lobby Best: {0}{1}{2}".format(sorted(Lobby_High)[0] if Lobby_Best != 0 else "0", " by " if Lobby_Best != 0 else "", Lobby_Best if Lobby_Best != 0 else ""), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


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
    
    hudSubtext(localPlayer, f"Time: {localPlayer.Timer}", HudPosition.TOP, HudOrder.TIMER, ColorConfig[Customize.PLAYER_TIME] , HudReeval.VISIBILITY_AND_STRING)

    hudSubtext(localPlayer, "\nSpeed: {}\nMultiplier: x{}{}".format(localPlayer.getSpeed(), localPlayer.SpeedMultiplier/100,LeftAlign100), HudPosition.LEFT, HudOrder.SPD, ColorConfig[Customize.SPD_COLOR], HudReeval.VISIBILITY_AND_STRING)
    
    # checkpoint icon as text
    #createInWorldText(localPlayer.filter(lambda _: localPlayer.GoalCheckpoint != 0), GoalText, localPlayer.GoalCheckpoint, 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION,  ColorConfig[Customize.GOAL_COLOR] , SpecVisibility.DEFAULT)

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
    
rule "Editor HUD":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    
    hudHeader(
        hostPlayer if eventPlayer.EditorMode > EditorMode.OFF else null,
        f"{'N/A' if eventPlayer.EditorMode == EditorMode.ON else 'Move Mode' if eventPlayer.EditorMode == EditorMode.MOVE_CHECKPOINT else 'Insert Mode' if eventPlayer.EditorMode == EditorMode.INSERT_CHECKPOINT else 'Remove Mode'}",
        HudPosition.TOP, 
        99, 
        Color.PURPLE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if eventPlayer.EditorMode > EditorMode.OFF else null,
        f"\n\n\n\n\n\n        FORWARD\nNEXT CHECKPOINT",
        HudPosition.TOP, 
        100, 
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if eventPlayer.EditorMode > EditorMode.OFF else null,
        f"\n\n\n\n\n\n\n\n<<< {'Move Mode' if (eventPlayer.EditorMode + 1 if eventPlayer.EditorMode < len(EditorMode) - 1 else 2) == EditorMode.MOVE_CHECKPOINT else 'Insert Mode' if (eventPlayer.EditorMode + 1 if eventPlayer.EditorMode < len(EditorMode) - 1 else 2) == EditorMode.INSERT_CHECKPOINT else 'Remove Mode'}                                                                             {'Move Checkpoint' if (eventPlayer.EditorMode - 1 if eventPlayer.EditorMode > 2 else len(EditorMode) - 1) == EditorMode.MOVE_CHECKPOINT else 'Insert Checkpoint' if (eventPlayer.EditorMode - 1 if eventPlayer.EditorMode > 2 else len(EditorMode) - 1) == EditorMode.INSERT_CHECKPOINT else 'Remove Checkpoint'} >>>",
        HudPosition.TOP, 
        101, 
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer,
        f"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nEnable Editor: Hold {inputBindingString(Button.INTERACT)}" if eventPlayer.EditorMode <= 0 else f"Disable Editor: Hold {inputBindingString(Button.INTERACT)}",        HudPosition.TOP,
        103,
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR,
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if eventPlayer.EditorMode > EditorMode.OFF else null,
        f"\n\n\n\n                                                                              Save: {inputBindingString(Button.MELEE)}" if eventPlayer.EditorMode == EditorMode.MOVE_CHECKPOINT and eventPlayer.ActivelyEditing else f"\n\n\n\n                                                                              Move: {inputBindingString(Button.MELEE)}" if eventPlayer.EditorMode == EditorMode.MOVE_CHECKPOINT else f"\n\n\n\n                                                                              Insert: {inputBindingString(Button.MELEE)}" if eventPlayer.EditorMode == EditorMode.INSERT_CHECKPOINT else f"\n\n\n\n                                                                              Remove: {inputBindingString(Button.MELEE)}",
        HudPosition.TOP,
        103,
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR,
        SpecVisibility.NEVER
    )
    hudSubtext(
        hostPlayer if eventPlayer.EditorMode > EditorMode.OFF else null,
        f"\n         BACKWARDS\nPREVIOUS CHECKPOINT",
        HudPosition.TOP, 
        104, 
        Color.WHITE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )

    hudSubtext(getAllPlayers(), 
        f"Hold {inputBindingString(Button.INTERACT)}: To Enable Editor Mode\n",
        HudPosition.RIGHT, HudOrder.CONTROLS + 10, ColorConfig[Customize.CONTROL_HUD_1] , HudReeval.VISIBILITY_AND_STRING
    )

    