#!mainFile "main.opy"


rule "Init Global":
    if not INSPECTOR_ON:
        disableInspector()
    disableAnnouncer()
    disableGamemodeCompletion()
    disableScoring()

    wait(1)
    LeaderboardText = null
    LeaderboardEntries = []
    LeaderboardRemake = false
    setMatchTime(900)

    wait(LoadOrder.SETUP)
    
    if Checkpoints == null:
        Checkpoints = []
  


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
    wait(LoadOrder.SETUP + 0.1)
    eventPlayer.wsEditorOn = createWorkshopSettingBool("Editor", "Editor Mode Enabled", EDITOR_ON, 0)
	if not eventPlayer.wsEditorOn:
        chaseAtRate(eventPlayer.Timer, 0, 1, ChaseRateReeval.NONE)
    eventPlayer.PersonalBest = null
    waitUntil(getTotalTimeElapsed() > 1, 1) # map variables need to load first
    FullReset()

