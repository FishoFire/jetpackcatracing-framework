#!mainFile "main.opy"


rule "Init Global":
    # disableInspector()
    disableAnnouncer()
    disableGamemodeCompletion()
    disableScoring()

    wait(1)
    LeaderboardText = null
    LeaderboardEntries = []
    LeaderBoardRemake = false
    setMatchTime(900)
    #setObjectiveDescription(getAllPlayers(), "{0} {1}".format(heroIcon(Hero.JETPACK_CAT), "Jetpack Cat Racing!"), HudReeval.VISIBILITY_AND_STRING)
    
    # Checkpoints = []
  


rule "Init Player":
    @Event playerJoined
    @Condition eventPlayer.isDummy() == false or eventPlayer in TestBotArray
    eventPlayer.disableKillFeed()
    eventPlayer.disableGamemodeHud()
    eventPlayer.disableGamemodeInWorldUi()
    eventPlayer.disableMessages()
    eventPlayer.disablePlayerCollision()
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 999999)
    chaseAtRate(eventPlayer.Timer, 0, 1, ChaseRateReeval.NONE)
    eventPlayer.High_Score = null
    waitUntil(getTotalTimeElapsed() > 1, 1) # map variables need to load first
    FullReset()

rule "Init Editor":
    wsEditorMode = createWorkshopSettingBool("Editor", "Editor Mode Enabled", false, 0)