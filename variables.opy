#!mainFile "main.opy"

# Global variables

globalvar StartVector 0
globalvar Checkpoints 1
globalvar Lobby_High 2
globalvar Lobby_Best 3
globalvar CreatorName 4
globalvar MapCode 5
globalvar ColorConfig 6

# Player variables

playervar Checkpoints 0
playervar Timer 1
playervar High_Score 2
playervar IsRacing 3
playervar SpeedMultiplier 4
playervar ReturnCheckpointIndex 5
playervar CurrentCheckpointVector 6
playervar NextCheckpointVector 7


#!define LeftAlign100 "                                                                                                    "

enum Customize: # always add new options on end so previously configured colors dont mess up
    credit_name,
    credit_code,
    servertime,
    time,
    level,
    command_normal,
    command_highlight,
    bhopclimb_available,
    bhopclimb_used,

    ring_current,
    ring_next,
    shaft,
    nexticon_color,
    cometext,
    killorb,
    orb_normal,
    orb_lock,
    portal,
    dsc,
    cp_huds,
    cp_iwts,



enum LoadOrder:
    mapData     = -1,
    customize   = 0,
    destructo   = 0.016 * 2,
    setup       = 0.016 * 32,
    addon       = 0.016 * 40,
    hudsGlobal  = 0.016 * 48,
    hudsPlayer  = 0.016 * 56,
    hudsEditor  = 0.016 * 64,
    effects     = 0.016 * 256,