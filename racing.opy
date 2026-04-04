#!mainFile "main.opy"

def Reset():
    eventPlayer.teleport(StartVector)
    eventPlayer.startForcingPosition(StartVector)
    wait()
    eventPlayer.stopForcingPosition()
    eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), Checkpoints[0]), Relativity.TO_WORLD)
    stopChasingVariable(eventPlayer.Timer)
    eventPlayer.ReturnCheckpointIndex = 0
    eventPlayer.Last_checkpoint = Checkpoints[0]
    eventPlayer.Goal_checkpoint = Checkpoints[1]
    eventPlayer.Timer = 0
    eventPlayer.High_Score = []
    eventPlayer.IsRacing = false
    eventPlayer.setMoveSpeed(100)
    eventPlayer.SpeedMultiplier = 100

rule "Start":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    Reset()   


rule "Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    Reset()


rule "Arrive at Checkpoint":
    @Event eachPlayer
    @Condition distance(eventPlayer.Last_checkpoint, eventPlayer.getEyePosition()) <= 2.65
    @Condition eventPlayer.isAlive()
    # TODO: Separate starting the level vs arriving at a checkpoint IN the level?
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getEyePosition(), 100)
    
    chaseAtRate(eventPlayer.Timer, 100000000, 1)
    eventPlayer.IsRacing = true

    eventPlayer.setMoveSpeed(eventPlayer.SpeedMultiplier * 2)
    eventPlayer.SpeedMultiplier += 3

    eventPlayer.ReturnCheckpointIndex += 1
    eventPlayer.Last_checkpoint = eventPlayer.Goal_checkpoint
    eventPlayer.Goal_checkpoint = Checkpoints[eventPlayer.ReturnCheckpointIndex + 1]



rule "Finish":
    @Event eachPlayer
    @Condition not eventPlayer.Last_checkpoint
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



