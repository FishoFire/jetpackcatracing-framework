#!mainFile "main.opy"


rule "Hanamura":
    @Condition getCurrentMap() == Map.HANAMURA
    
    StartVector = vect(69.447, 13.709, 3.227)
    Checkpoints = [vect(55.31, 11.133, 9.266), vect(29.707, 8.628, 11.127), vect(5.313, 4.482, 2.078), vect(-4.063, 4.042, -8.343), vect(-17.38, 0.756, -17.216), vect(-26.126, 5.056, -50.521), vect(-26.721, 3.746, -67.521), vect(-20.674, 3.591, -76.343), vect(-0.854, 5.924, -82.08), vect(14.102, 6.337, -74.915), vect(28.236, 4.267, -60.297), vect(32.851, 4.951, -42.201), vect(25.275, 3.13, -30.573), vect(11.991, 2.447, -24.385), vect(16.174, 2.392, -6.394), vect(28.754, 3.516, -3.708), vect(39.216, 3.909, -11.624), vect(57.521, 1.663, -13.342), vect(67.34, 3.716, -5.188), vect(68.84, 6.15, 7.811)]



rule "Start":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true

    eventPlayer.teleport(StartVector)
    
    eventPlayer.ReturnCheckpointIndex = 0
    eventPlayer.CurrentCheckpointVector = Checkpoints[0]
    eventPlayer.NextCheckpointVector = Checkpoints[1]


    eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.Checkpoints[0]), Relativity.TO_WORLD)
    createEffect(localPlayer.filter(lambda _: localPlayer.CurrentCheckpointVector != 0), Effect.GOOD_AURA, Color.GREEN, localPlayer.CurrentCheckpointVector, 2.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(localPlayer.filter(lambda _: localPlayer.NextCheckpointVector != 0), Effect.GOOD_AURA, Color.WHITE, localPlayer.NextCheckpointVector, 2.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    hudSubtext(eventPlayer, "Time: {0}".format(eventPlayer.Timer), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.Timer = 0
    eventPlayer.High_Score = []
    eventPlayer.IsRacing = false
    eventPlayer.setMoveSpeed(100)
    eventPlayer.SpeedMultiplier = 100


rule "Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    eventPlayer.teleport(StartVector)
    eventPlayer.startForcingPosition(StartVector)
    wait()
    eventPlayer.stopForcingPosition()
    eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), Checkpoints[0]), Relativity.TO_WORLD)
    eventPlayer.Timer = 0
    stopChasingVariable(eventPlayer.Timer)

    eventPlayer.ReturnCheckpointIndex = 0
    eventPlayer.CurrentCheckpointVector = Checkpoints[0]
    eventPlayer.NextCheckpointVector = Checkpoints[1]

    eventPlayer.IsRacing = false
    eventPlayer.setMoveSpeed(100)
    eventPlayer.SpeedMultiplier = 100


rule "Arrive at Checkpoint":
    @Event eachPlayer
    @Condition distance(eventPlayer.CurrentCheckpointVector, eventPlayer.getEyePosition()) <= 2.65
    @Condition eventPlayer.isAlive() == true
    
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getEyePosition(), 100)
    chaseAtRate(eventPlayer.Timer, 100000000, 1)
    eventPlayer.IsRacing = true

    eventPlayer.setMoveSpeed(eventPlayer.SpeedMultiplier * 2)
    eventPlayer.SpeedMultiplier += 3

    eventPlayer.ReturnCheckpointIndex += 1
    eventPlayer.CurrentCheckpointVector = eventPlayer.NextCheckpointVector
    eventPlayer.NextCheckpointVector = Checkpoints[eventPlayer.ReturnCheckpointIndex + 1]



rule "Finish":
    @Event eachPlayer
    @Condition not eventPlayer.CurrentCheckpointVector
    #@Condition eventPlayer.Timer != 0
    
    eventPlayer.IsRacing = false
    stopChasingVariable(eventPlayer.Timer)
    bigMessage(eventPlayer, "Time: {0} {1}".format(eventPlayer.Timer, "(New Personal Best!)" if sorted(eventPlayer.High_Score)[0] == eventPlayer.Timer else ""))
    eventPlayer.High_Score.append(eventPlayer.Timer)
    if eventPlayer.Timer == 0:
        goto lbl_0
    Lobby_High.append(eventPlayer.Timer)
    Lobby_Best = eventPlayer if sorted(Lobby_High)[0] == sorted(eventPlayer.High_Score)[0] else Lobby_Best
    lbl_0:



