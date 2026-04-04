#!mainFile "main.opy"


rule "Init Global":
    # disableInspector()
    wait(1)
    setMatchTime(900)
    #setObjectiveDescription(getAllPlayers(), "{0} {1}".format(heroIcon(Hero.JETPACK_CAT), "Jetpack Cat Racing!"), HudReeval.VISIBILITY_AND_STRING)
    
    # Checkpoints = []
    # Lobby_High = []


rule "Init Player":
    @Event playerJoined
    @Condition eventPlayer.isDummy() == false
    @Condition getTotalTimeElapsed() > 1

    eventPlayer.disableGamemodeHud()
    eventPlayer.disableGamemodeInWorldUi()
    eventPlayer.disableMessages()
    eventPlayer.disablePlayerCollision()
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 999999)
    chaseAtRate(eventPlayer.Timer, 0, 1, ChaseRateReeval.NONE)
      
    FullReset()
