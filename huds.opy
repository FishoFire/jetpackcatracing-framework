#!mainFile "main.opy"


rule "HUD Setup":
    wait(LoadOrder.hudsGlobal)
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
        HudPosition.LEFT, HO.credit, Color.SKY_BLUE, ColorConfig[Customize.credit_code], ColorConfig[Customize.credit_name], 
        HudReeval.VISIBILITY, SpecVisibility.DEFAULT
    )
    hudSubheader(true[0],
        f"Discord: dsc.gg/jetpack{LeftAlign100}",
        HudPosition.LEFT, HO.disc, ColorConfig[Customize.dsc], HudReeval.VISIBILITY, SpecVisibility.DEFAULT)

    hudSubtext(getAllPlayers(), f"Hold {inputBindingString(Button.RELOAD)} to restart", HudPosition.RIGHT, HO.controls, ColorConfig[Customize.control_hud_1] , HudReeval.VISIBILITY_AND_STRING)
    
    hudSubtext(localPlayer, f"Time: {localPlayer.Timer}", HudPosition.TOP, HO.timer, ColorConfig[Customize.player_time] , HudReeval.VISIBILITY_AND_STRING)
    
    # checkpoint icon as text
    #createInWorldText(localPlayer.filter(lambda _: localPlayer.GoalCheckpoint != 0), GoalText, localPlayer.GoalCheckpoint, 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_POSITION,  ColorConfig[Customize.goal_color] , SpecVisibility.DEFAULT)

rule "Effects Setup":
    wait(LoadOrder.effects)
    createEffect(localPlayer.filter(lambda _: localPlayer.GoalCheckpoint != 0), Effect.GOOD_AURA, ColorConfig[Customize.goal_cp], localPlayer.GoalCheckpoint, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(localPlayer.filter(lambda _: localPlayer.AfterNextCheckpoint != 0), Effect.GOOD_AURA, ColorConfig[Customize.after_next_cp], localPlayer.AfterNextCheckpoint, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    # checkpoint icon
    createIcon( 
        localPlayer.filter(lambda _: localPlayer.GoalCheckpoint != 0 and not localPlayer.isInViewAngle(localPlayer.GoalCheckpoint, 40) ), 
        localPlayer.GoalCheckpoint + vect(0,1,0), 
        Icon.ARROW_DOWN, 
        IconReeval.VISIBILITY_AND_POSITION, ColorConfig[Customize.goal_color], true
    )
    
  