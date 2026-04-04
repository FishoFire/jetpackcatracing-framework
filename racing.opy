#!mainFile "main.opy"

rule "anti crash":
	@Event global
	@Condition getServerLoad() > 250
    wait(1, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), "anti-crash system activated")
    setSlowMotion(10)
    waitUntil(getServerLoad() < 230, Math.INFINITY)
    setSlowMotion(100)

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



# decrease to make it wait more often if you have load problems, keep at full int numbers no floats
#!define fence_delay 3
# projectile size, 30 is maximum possible atm
#!define fence_proj_size 30
# gridsize of 16 means a 16x16 grid with the point in the center
#!define fence_grid 16
# calculation to find the side of the map
#!define fence_offset vect((fence_grid * fence_proj_size) / 2, 0, (fence_grid * fence_proj_size) / 2)
# calculation for next explosion
#!define fence_position  MapVectorArray[1] - fence_offset + (MapVectorArray[0] % fence_grid) * (Vector.LEFT * fence_proj_size) + floor(MapVectorArray[0] / fence_grid) * (Vector.FORWARD * fence_proj_size)

rule "Addon | Little Destructo - Fence Breaker":
    # Made by FishoFire version 1.0
    # wait to overwrite any from copy pastas
	wait(LoadOrder.destructo)
    # first entry will act as index, rest is the points themselves
    MapVectorArray = [0]
    # flag mode = both flag points, just incase
    # tdm/dm = first spawn points, the maps are not big so it just covers entire map. all teams defaults to team 1 spawn
    # push: payload and cp 0 are set but rest isnt. normal payload maps have more then 1 point.
    # rest of maps have up to 3 points
    MapVectorArray.append( #$$ Combine with `MapVectorArray = [0]`
        [getFlagPosition(Team.1), getFlagPosition(Team.2)] if getCurrentGamemode() == Gamemode.CTF else
        getSpawnPoints(Team.ALL)[0] if getCurrentGamemode() in [Gamemode.TDM, Gamemode.FFA] else
        getPayloadPosition() if getPayloadPosition()[0] and not (getObjectivePosition(1) + getObjectivePosition(2)) else
        [getObjectivePosition(0), getObjectivePosition(1), getObjectivePosition(2)])
    # explode in a grid around the selected points
    while len(MapVectorArray) > 1:
        MapVectorArray[0] = 0
        while MapVectorArray[0] < (fence_grid * fence_grid):
            createProjectile(
                Projectile.ORB,  # the only orb available without fx extension
                null,
                fence_position,
                Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, fence_proj_size,
                DynamicEffect.GOOD_EXPLOSION, # possible without extensions: bad, good, ring
                DynamicEffect.EXPLOSION_SOUND, # possible without extensions: explosion sound, buf sound, ring explosion sound
                1, 1, 0, 0, 0, 0)
            MapVectorArray[0] ++
            if not (MapVectorArray[0] % fence_delay): # use modulo to only wait every x orbs keep the 0 change the other number
                wait(0)
        del MapVectorArray[1]

    # handle exceptions (looking at you new queen street)
    MapVectorArray = [vect(8.276, 4.113, 15.261), vect(-8.319, 2.624, 14.245), vect(0.006, 4.821, 18.513)]
    while len(MapVectorArray):
        # same as other projectile before
        createProjectile(
            Projectile.ORB,
            null,
            MapVectorArray[0],
            Vector.DOWN, Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 0, 0, fence_proj_size,
            DynamicEffect.GOOD_EXPLOSION,
            DynamicEffect.EXPLOSION_SOUND,
            1, 1, 0, 0, 0, 0)
        del MapVectorArray[0]
        wait(0)
    MapVectorArray = null
