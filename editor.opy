#!mainFile "main.opy"

rule "Editor | Enable Checkpoint Selection":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    if not Checkpoints:
        Checkpoints = [vect(10, 10, 10)]
    eventPlayer.EditorMode = EditorMode.MOVE if eventPlayer.EditorMode == EditorMode.OFF else EditorMode.OFF
    if eventPlayer.EditorMode:
        smallMessage(hostPlayer, "   Checkpoint Selection Enabled")
        StartEditorCamera()
    else:
        smallMessage(hostPlayer, "   Checkpoint Selection Disabled")
        StopEditorCamera()


rule "Editor | Select Checkpoint & Mode":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    @Condition (
        eventPlayer.EditorMode > EditorMode.OFF and not eventPlayer.ActivelyEditing and (
            eventPlayer.getThrottle().z > 0.5 or eventPlayer.getThrottle().z < -0.5 or 
            eventPlayer.getThrottle().x > 0.5 or eventPlayer.getThrottle().x < -0.5
        )
    )

    if eventPlayer.getThrottle().z > 0.5:
        eventPlayer.CurrentCheckpointIdx += 1
        if eventPlayer.CurrentCheckpointIdx >= len(Checkpoints):
            eventPlayer.CurrentCheckpointIdx = 0
        wait(0.1)
        waitUntil(eventPlayer.getThrottle().z < 0.5, 0.1)

    elif eventPlayer.getThrottle().z < -0.5:
        eventPlayer.CurrentCheckpointIdx -= 1
        if eventPlayer.CurrentCheckpointIdx < 0:
            eventPlayer.CurrentCheckpointIdx = len(Checkpoints) - 1
        wait(0.1)
        waitUntil(eventPlayer.getThrottle().z > -0.5, 0.1)
    
    elif eventPlayer.getThrottle().x > 0.5:
        eventPlayer.EditorMode += 1
        if eventPlayer.EditorMode >= len(EditorMode):
            eventPlayer.EditorMode = 2
        wait(0.1)
        waitUntil(eventPlayer.getThrottle().x < 0.5, 0.1)

    elif eventPlayer.getThrottle().x < -0.5:
        eventPlayer.EditorMode -= 1
        if eventPlayer.EditorMode < 2:
            eventPlayer.EditorMode = len(EditorMode) - 1
        wait(0.1)
        waitUntil(eventPlayer.getThrottle().x > -0.5, 0.1)
    
    SetCheckpoints()
    wait(0)
    if ruleCondition:
        loop()

rule "Editor | Enable Checkpoint Edit":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.MOVE and eventPlayer.isHoldingButton(Button.MELEE)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    eventPlayer.ActivelyEditing = not eventPlayer.ActivelyEditing
    if eventPlayer.ActivelyEditing:
        smallMessage(hostPlayer, "   Checkpoint Edit Enabled")
        StartEditorCamera2()
        eventPlayer.EditCheckpointTemp = Checkpoints[eventPlayer.CurrentCheckpointIdx]
        createEffect(eventPlayer, Effect.GOOD_AURA, Color.ROSE, eventPlayer.EditCheckpointTemp, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.EditCheckpointEffect = getLastCreatedEntity()
    else:
        smallMessage(hostPlayer, "   Checkpoint Edit Saved")
        StartEditorCamera()
        Checkpoints[eventPlayer.CurrentCheckpointIdx] = eventPlayer.EditCheckpointTemp
        SetCheckpoints()
        eventPlayer.EditCheckpointTemp = null
        destroyEffect(eventPlayer.EditCheckpointEffect)

rule "Editor | Start Editing Position":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.MOVE and eventPlayer.ActivelyEditing
    # @Condition hostPlayer.isHoldingButton(Button.MELEE)

    waitUntil(not hostPlayer.isHoldingButton(Button.MELEE), Math.INFINITY)

    while not hostPlayer.isHoldingButton(Button.MELEE):
        eventPlayer.EditCheckpointTemp += eventPlayer.flyMovementDelta()
        wait(0)

rule "Editor | Remove Checkpoint":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.REMOVE and eventPlayer.isHoldingButton(Button.MELEE)

    smallMessage(hostPlayer, "   Checkpoint Removed")
    del Checkpoints[eventPlayer.CurrentCheckpointIdx]
    eventPlayer.CurrentCheckpointIdx -= 1
    SetCheckpoints()

rule "Editor | Insert Checkpoint (After Current Checkpoint)":
    @Event eachPlayer
    @Condition wsEditorMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.INSERT and eventPlayer.isHoldingButton(Button.MELEE)
    smallMessage(hostPlayer, "   Checkpoint Inserted")
    Checkpoints.insertAt(eventPlayer.CurrentCheckpointIdx, Checkpoints[eventPlayer.CurrentCheckpointIdx])
    eventPlayer.CurrentCheckpointIdx += 1
    SetCheckpoints()
    eventPlayer.EditorMode = EditorMode.MOVE
    eventPlayer.ActivelyEditing = true
    StartEditorCamera2()
    eventPlayer.EditCheckpointTemp = Checkpoints[eventPlayer.CurrentCheckpointIdx]
    createEffect(eventPlayer, Effect.GOOD_AURA, Color.ROSE, eventPlayer.EditCheckpointTemp, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.EditCheckpointEffect = getLastCreatedEntity()


#!define cam_distance 8
# calcultes distance between cam and wall and subtracts 1 to make sure you are not inside the wall
# if nothing is hit then it just returns max length
# parameter is the start position
#!define cam_dist_calc(start) (distance(start, raycast(start, start + eventPlayer.getFacingDirection() * - cam_distance,null,null,false).getHitPosition()) - 1)

def StartEditorCamera():
    @Name "Editor | Start Editor 3rd Person Camera"
    
    eventPlayer.setInvisibility(Invis.ALL)
    DisableAbilities()

    eventPlayer.startCamera(
        eventPlayer.CurrentCheckpoint + updateEveryFrame(eventPlayer.getFacingDirection() * - cam_dist_calc(eventPlayer.CurrentCheckpoint) ),
        eventPlayer.CurrentCheckpoint, 
        500
    )
    

def StartEditorCamera2():
    @Name "Editor | Start Editor 3rd Person Camera | Checkpoint Movement"

    eventPlayer.startCamera(
        eventPlayer.EditCheckpointTemp + (
            updateEveryFrame(eventPlayer.getFacingDirection()) * -6
        ), 
        eventPlayer.EditCheckpointTemp, 
        500
    )

def StopEditorCamera():
    @Name "Editor | Stop Editor 3rd Person Camera"
    eventPlayer.stopCamera()
    eventPlayer.setInvisibility(Invis.NONE)
    EnableAbilities()


def DisableAbilities():
    @Name "Editor | Disable Movement and Abilities"
    eventPlayer.setJumpEnabled(false)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setMoveSpeed(0)

def EnableAbilities():
    @Name "Editor | Enable Movement and Abilities"
    eventPlayer.setJumpEnabled(true)
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.setAbility1Enabled(false) # This stays off always
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setMoveSpeed(100)
