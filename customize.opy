#!mainFile "main.opy"

rule "Customize Credits and Colors Here":
    wait(LoadOrder.customize)

    # credits
    CreatorName = "creator name here"
    MapCode = "map code here"

    # ring size
    RingSize = 2.5

    #credit hud name   -   作者HUD
    ColorConfig[Customize.credit_name] = Color.VIOLET

    #credit hud code   -   代码HUD
    ColorConfig[Customize.credit_code] = Color.SKY_BLUE

    #discord link
    ColorConfig[Customize.dsc] = Color.AQUA

    #control scheme
    ColorConfig[Customize.control_hud_1] = Color.WHITE

    #player timer
    ColorConfig[Customize.player_time] = Color.WHITE

    #next cp
    ColorConfig[Customize.goal_cp] = Color.GREEN

    #after next cp
    ColorConfig[Customize.after_next_cp] = Color.WHITE

    #goal icon color
    ColorConfig[Customize.goal_color] = Color.ROSE

    #speed meter color
    ColorConfig[Customize.spd_color] = Color.WHITE
    