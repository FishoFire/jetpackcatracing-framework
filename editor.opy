#!mainFile "main.opy"


# TODO: Move into huds.opy
rule "Editor Init":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer

    hudHeader(
        hostPlayer if eventPlayer.EditorMode > EditorMode.OFF else null, 
        f"Editor Mode: {'N/A' if eventPlayer.EditorMode == EditorMode.ON else 'Move Checkpoint' if eventPlayer.EditorMode == EditorMode.MOVE_CHECKPOINT else 'Insert Checkpoint' if eventPlayer.EditorMode == EditorMode.INSERT_CHECKPOINT else 'Remove Checkpoint'}", 
        HudPosition.TOP, 
        100, 
        Color.PURPLE, 
        HudReeval.VISIBILITY_STRING_AND_COLOR, 
        SpecVisibility.NEVER
    )

rule "Editor | Enable Checkpoint Selection":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    eventPlayer.EditorMode = EditorMode.ON if eventPlayer.EditorMode != EditorMode.ON else EditorMode.OFF
    if eventPlayer.EditorMode:
        StartEditorCamera()
    else:
        StopEditorCamera()


rule "Editor | Select Checkpoint & Mode":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode > EditorMode.OFF and not eventPlayer.ActivelyEditing and (eventPlayer.getThrottle().z != 0 or eventPlayer.getThrottle().x != 0)

    if eventPlayer.getThrottle().z > 0:
        eventPlayer.CurrentCheckpointIdx += 1
        if eventPlayer.CurrentCheckpointIdx >= len(Checkpoints):
            eventPlayer.CurrentCheckpointIdx = 0

    elif eventPlayer.getThrottle().z < 0:
        eventPlayer.CurrentCheckpointIdx -= 1
        if eventPlayer.CurrentCheckpointIdx < 0:
            eventPlayer.CurrentCheckpointIdx = len(Checkpoints) - 1
    
    if eventPlayer.getThrottle().x > 0:
        eventPlayer.EditorMode += 1
        if eventPlayer.EditorMode >= len(EditorMode):
            eventPlayer.EditorMode = 1

    elif eventPlayer.getThrottle().x < 0:
        eventPlayer.EditorMode -= 1
        if eventPlayer.EditorMode < 1:
            eventPlayer.EditorMode = len(EditorMode) - 1
    
    SetCheckpoints()

    wait(0)

rule "Editor | Enable Checkpoint Edit":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.MOVE_CHECKPOINT and eventPlayer.isHoldingButton(Button.MELEE)
    wait(0.5, Wait.ABORT_WHEN_FALSE)
    eventPlayer.ActivelyEditing = not eventPlayer.ActivelyEditing
    if eventPlayer.ActivelyEditing:
        StartEditorCamera2()
        eventPlayer.EditCheckpointTemp = Checkpoints[eventPlayer.CurrentCheckpointIdx]
        createEffect(eventPlayer, Effect.GOOD_AURA, Color.ROSE, eventPlayer.EditCheckpointTemp, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.EditCheckpointEffect = getLastCreatedEntity()
    else:
        StartEditorCamera()
        Checkpoints[eventPlayer.CurrentCheckpointIdx] = eventPlayer.EditCheckpointTemp
        SetCheckpoints()
        eventPlayer.EditCheckpointTemp = null
        destroyEffect(eventPlayer.EditCheckpointEffect)

rule "Editor | Start Editing Position":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.MOVE_CHECKPOINT and eventPlayer.ActivelyEditing
    @Condition hostPlayer.isHoldingButton(Button.MELEE)

    waitUntil(not hostPlayer.isHoldingButton(Button.MELEE), Math.INFINITY)

    while not hostPlayer.isHoldingButton(Button.MELEE):
        eventPlayer.EditCheckpointTemp += eventPlayer.flyMovementDelta()
        wait(0)

rule "Editor | Remove Checkpoint":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.REMOVE_CHECKPOINT and eventPlayer.isHoldingButton(Button.MELEE)

    del Checkpoints[eventPlayer.CurrentCheckpointIdx]
    eventPlayer.CurrentCheckpointIdx -= 1
    SetCheckpoints()

rule "Editor | Insert Checkpoint (After Current Checkpoint)":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.EditorMode == EditorMode.INSERT_CHECKPOINT and eventPlayer.isHoldingButton(Button.MELEE)

    Checkpoints.insertAt(eventPlayer.CurrentCheckpointIdx, Checkpoints[eventPlayer.CurrentCheckpointIdx])
    eventPlayer.CurrentCheckpointIdx += 1
    SetCheckpoints()
    eventPlayer.EditorMode = EditorMode.MOVE_CHECKPOINT
    eventPlayer.ActivelyEditing = true
    StartEditorCamera2()
    eventPlayer.EditCheckpointTemp = Checkpoints[eventPlayer.CurrentCheckpointIdx]
    createEffect(eventPlayer, Effect.GOOD_AURA, Color.ROSE, eventPlayer.EditCheckpointTemp, RingSize-0.15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.EditCheckpointEffect = getLastCreatedEntity()


def StartEditorCamera():
    @Name "Editor | Start Editor 3rd Person Camera"
    
    eventPlayer.setInvisibility(Invis.ALL)
    DisableAbilities()
    eventPlayer.startCamera(
        eventPlayer.CurrentCheckpoint + (
            updateEveryFrame(eventPlayer.getFacingDirection()) * -6
        ), 
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
