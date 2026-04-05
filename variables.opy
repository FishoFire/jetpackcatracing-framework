#!mainFile "main.opy"

# Global variables

globalvar StartVector 0
globalvar Checkpoints 1
globalvar Lobby_High 2
globalvar Lobby_Best 3
globalvar CreatorName 4
globalvar MapCode 5
globalvar ColorConfig 6
globalvar MapVectorArray 7 # for fence breaker
globalvar RingSize 8
globalvar GoalText 9 

# Player variables

playervar EditorMode 0
playervar Timer 1
playervar High_Score 2
playervar IsRacing 3
playervar SpeedMultiplier 4
playervar CurrentCheckpointIdx 5
playervar GoalCheckpoint 6
playervar AfterNextCheckpoint 7
playervar CurrentCheckpoint 8
playervar ActivelyEditing
playervar EditCheckpointEffect 10
playervar EditCheckpointTemp 11

# Subroutines
subroutine FullReset
subroutine GoToResetPoint # teleport back to lastpoint
subroutine ResetSpeed
subroutine StartEditorCamera
subroutine StartEditorCamera2
subroutine StopEditorCamera
subroutine DisableAbilities
subroutine EnableAbilities
subroutine SetCheckpoints

#!define LeftAlign100 "                                                                                                    "
##!define LeftAlign100 ""

enum Customize: 
    credit_name,
    credit_code,
    dsc,
    control_hud_1,
    player_time,
    after_next_cp,
    goal_cp,
    goal_color,
    spd_color,

enum LoadOrder:
    mapData     = -1,
    customize   = 0,
    destructo   = 0.016 * 2,
    #setup       = 0.016 * 32,
    #addon       = 0.016 * 40,
    hudsGlobal  = 0.016 * 48,
    #hudsPlayer  = 0.016 * 56,
    #hudsEditor  = 0.016 * 64,
    effects     = 0.016 * 256,

enum HO: # hud ordering
    # hud middle ###############
    timer,

    # hud left ###############
    credit,
    disc,
    spd,

    # hud right ###############
    controls,

enum EditorMode:
    OFF = 0,
    ON = 1,
    MOVE_CHECKPOINT = 2,
    INSERT_CHECKPOINT = 3,
    REMOVE_CHECKPOINT = 4,

macro Array.insertAt(index, item):
    self.append(null)
    self = [CAE if CAI <= index else self[CAI - 1] for CAE, CAI in self]
    self[index] = item

macro Player.flyMovementDelta():
    ((0.096 + 0.192 * self.isHoldingButton(Button.PRIMARY_FIRE) - 0.048 * self.isHoldingButton(Button.SECONDARY_FIRE)) *
    (self.getFacingDirection() * self.getThrottle().z * (vect(1, not self.isHoldingButton(Button.ABILITY_1), 1)) +
    worldVector(self.getThrottle() * Vector.LEFT, self, Transform.ROTATION) +
    Vector.UP * (self.isHoldingButton(Button.JUMP) - self.isHoldingButton(Button.CROUCH))))