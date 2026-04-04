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

# Player variables

playervar Checkpoints 0
playervar Timer 1
playervar High_Score 2
playervar IsRacing 3
playervar SpeedMultiplier 4
playervar ReturnCheckpointIndex 5
playervar Last_checkpoint 6
playervar Goal_checkpoint 7


#!define LeftAlign100 "                                                                                                    "

enum Customize: 
    credit_name,
    credit_code,
    dsc,
    control_hud_1,
    player_time,
    goal_checkpoint,
    last_checkpoint


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
    # hud middle
    timer,
    # hud left
    credit,
    disc,

    # hud right
    controls,