#!mainFile "main.opy"

rule "Customize Credits and Colors Here":
    wait(LoadOrder.customize)
    CreatorName = "creator name here"
    MapCode = "map code here"

    #credit hud name   -   作者HUD
    ColorConfig[Customize.credit_name] = Color.VIOLET
    #credit hud code   -   代码HUD
    ColorConfig[Customize.credit_code] = Color.SKY_BLUE
    #dsc.gg/genjiparkour
    ColorConfig[Customize.dsc] = Color.AQUA
    #server time hud   -   房间倒计时
    ColorConfig[Customize.servertime] = Color.RED
    #time  hud   -   单关用时HUD
    ColorConfig[Customize.time] = Color.WHITE
    #level hud   -   关卡HUD
    ColorConfig[Customize.level] = Color.WHITE
    #command hud   -   指令HUD
    ColorConfig[Customize.command_normal] = Color.WHITE
    #command hud highlight   -   指令HUD高亮
    ColorConfig[Customize.command_highlight] = Color.GREEN
    #bhop/climb available   -   小跳/爬墙未用HUD
    ColorConfig[Customize.bhopclimb_available] = Color.GREEN
    #bhop/climb used (cant be same as available)   -   小跳/爬墙已用HUD
    ColorConfig[Customize.bhopclimb_used] = Color.RED

    #current checkpoint ring   -   当前检查点光圈
    ColorConfig[Customize.ring_current] =  Color.SKY_BLUE
    #next checkpoint ring   -   下一关检查点光圈
    ColorConfig[Customize.ring_next] = Color.LIME_GREEN
    #next checkpoint light shaft   -   下一关检查点光柱
    ColorConfig[Customize.shaft] = Color.WHITE
    #next checkpoint icon   -   下一关检查点图标
    ColorConfig[Customize.nexticon_color] = Color.SKY_BLUE
    #"come here" text   -   到这里来" 文本
    ColorConfig[Customize.cometext] = Color.WHITE
    #kill orbs   -   击杀球
    ColorConfig[Customize.killorb] = Color.BLUE
    #normal orbs   -   弹球
    ColorConfig[Customize.orb_normal] = Color.GREEN
    #lock orbs (overwritten if its same as normal)
    #收集球 (与普通弹 球相同时将 自动覆写)
    ColorConfig[Customize.orb_lock] = Color.ORANGE
    #portals   -   自定义 传送门
    ColorConfig[Customize.portal] = Color.WHITE
    #Addon checkpoint Huds   -   应用于 所有地图文 本的颜色
    ColorConfig[Customize.cp_huds] = Color.BLUE
    #Addon checkpoint IWT   -   应用于 所有地图文 本的颜色
    ColorConfig[Customize.cp_iwts] = Color.LIME_GREEN