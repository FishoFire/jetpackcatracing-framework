#!mainFile "main.opy"

rule "Customize Credits and Colors Here":
    wait(LoadOrder.CUSTOMIZE)

    # credits
    CreatorName = "creator name here"
    MapCode = "map code here"

    # ring size
    RingSize = 2.5

    #credit hud name   -   作者HUD
    ColorConfig[Customize.CREDIT_NAME] = Color.VIOLET

    #credit hud code   -   代码HUD
    ColorConfig[Customize.CREDIT_CODE] = Color.SKY_BLUE

    #discord link
    ColorConfig[Customize.DSC] = Color.AQUA

    #control scheme
    ColorConfig[Customize.CONTROL_HUD_1] = Color.WHITE

    #player timer
    ColorConfig[Customize.PLAYER_TIME] = Color.WHITE

    #next cp
    ColorConfig[Customize.GOAL_CP] = Color.GREEN

    #after next cp
    ColorConfig[Customize.AFTER_NEXT_CP] = Color.WHITE

    #goal icon color
    ColorConfig[Customize.GOAL_COLOR] = Color.ROSE

    #speed meter color
    ColorConfig[Customize.SPD_COLOR] = Color.WHITE
    