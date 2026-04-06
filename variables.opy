#!mainFile "main.opy"

# Global variables

globalvar StartVector 0
globalvar Checkpoints 1
#globalvar Lobby_High 2 # old system
#globalvar Lobby_Best 3 # old system
globalvar CreatorName 4
globalvar MapCode 5
globalvar ColorConfig 6
globalvar MapVectorArray 7 # for fence breaker
globalvar RingSize 8
globalvar GoalText 9
globalvar wsEditorMode 10

globalvar TestBotArray 

globalvar LeaderboardText # txt entities
globalvar LeaderboardEntries # # [ [name, time] ]
globalvar LeaderBoardRemake # trigger remake leaderboard

# Player variables

playervar EditorMode 0
playervar Timer 1
playervar High_Score 2 # personal best
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
subroutine LeaderboardUpdate

#!define LeftAlign100 "                                                                                                    "

enum Customize: # index in the customize array for colors and such
    CREDIT_NAME,
    CREDIT_CODE,
    DSC,
    CONTROL_HUD_1,
    PLAYER_TIME,
    AFTER_NEXT_CP,
    GOAL_CP,
    GOAL_COLOR,
    SPD_COLOR,
    PERSONAL_BEST,

enum LoadOrder:
    MAP_DATA     = -1,
    CUSTOMIZE   = 0,
    DESTRUCTO   = 0.016 * 2,
    #SETUP       = 0.016 * 32,
    #ADDON       = 0.016 * 40,
    HUDS_GLOBAL  = 0.016 * 48,
    #HUDS_PLAYER  = 0.016 * 56,
    #HUDS_EDITOR  = 0.016 * 64,
    EFFECTS     = 0.016 * 256,

# _END are general purpose last order huds for their side
enum HudOrder: # hud ordering
    # hud middle ###############
    TIMER,

    MIDLE_END, 
    # hud left ###############
    CREDIT,
    DISC,
    SPD,
    TEST_POSITION,
    TEST_LOAD,

    LEFT_END,

    # hud right ###############
    CONTROLS,
    PERSONAL_BEST,
    TOP5,

    RIGHT_END,

enum EditorMode:
    OFF = 0,
    ON = 1,
    MOVE = 2,
    INSERT = 3,
    REMOVE = 4,

macro Array.insertAt(index, item):
    self.append(null)
    self = [CAE if CAI <= index else self[CAI - 1] for CAE, CAI in self]
    self[index] = item

macro Player.flyMovementDelta():
    ((0.096 + 0.192 * self.isHoldingButton(Button.PRIMARY_FIRE) - 0.048 * self.isHoldingButton(Button.SECONDARY_FIRE)) *
    (self.getFacingDirection() * self.getThrottle().z * (vect(1, not self.isHoldingButton(Button.ABILITY_1), 1)) +
    worldVector(self.getThrottle() * Vector.LEFT, self, Transform.ROTATION) +
    Vector.UP * (self.isHoldingButton(Button.JUMP) - self.isHoldingButton(Button.CROUCH))))

