#!mainFile "main.opy"


rule "Init Global":
    if not inspector_on:
        disableInspector()
    disableAnnouncer()
    disableGamemodeCompletion()
    disableScoring()

    wait(1)
    LeaderboardText = null
    LeaderboardEntries = []
    LeaderBoardRemake = false
    setMatchTime(900)

    # setup variables
    wsEditorMode = createWorkshopSettingBool("Editor", "Editor Mode Enabled", editor_on, 0)
    

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
