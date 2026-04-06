#!mainFile "main.opy"

divider(test scripts) # seperate from rest because this scripts sometimes doesnt exist

rule "slowmo":
    @Disabled # enable slowmotion here
    setSlowMotion(100)


rule "test huds":
    wait(1)
    # position hud
    hudSubheader(getAllPlayers(), 
        "\n"
        "Position: {}\n"
        "Eye: {}\n"
        "Facing: {}\n"
        "Throthle: {}\n"
        "{}"
        "".format(
            localPlayer.getPosition(),
            localPlayer.getEyePosition(),
            localPlayer.getFacingDirection(),
            localPlayer.getThrottle(),
            LeftAlign100
        ), 
        HudPosition.LEFT, HudOrder.TEST_POSITION , Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT
    )

    # load hud
    hudSubheader(
        localPlayer,
        "Load: {}\n"
        "Avrg: {} \n"
        "Peak: {}\n"
        "{}"
        "".format(
            getServerLoad(),
            getAverageServerLoad(),
            getPeakServerLoad(),
            LeftAlign100
        ),
        HudPosition.LEFT, HudOrder.TEST_LOAD,
        Color.RED if getAverageServerLoad() > 220 else
        Color.ORANGE if getAverageServerLoad() > 190 else
        Color.YELLOW if getAverageServerLoad() > 160  else
        Color.BLUE if getAverageServerLoad() > 130 else
        Color.LIME_GREEN,
        HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT
    )



# turns bots on
#!define bots_on true

#!define testbot_number 11
#!define test_team Team.2

# test leaderboard
#!define leaderboard_test true
#!define leaderboard_delay 0.5

# test other set actions
#!define other_action false
#!define action_delay 0.4


rule "create test bots":
    @Condition bots_on
    testAI = []
    while len(testAI) < testbot_number:
        createDummy(Hero.JETPACK_CAT, test_team, -1, null, null)
        testAI.append(getLastCreatedEntity())
        wait(0.1)
        testAI[len(testAI)-1].startForcingName("test bot {0}".format(len(testAI)-1))


rule "leaderboard test":
    @Event eachPlayer
    #@Condition len(testAI) > testbot_number - 1 # check if all bots have loaded
    @Condition getTotalTimeElapsed() > 5 == true
    @Condition other_action == false
    @Condition eventPlayer in testAI

    # crouch to trigger start timer etc
    eventPlayer.startForcingButton(Button.CROUCH)
    wait(0.1)
    eventPlayer.stopForcingButton(Button.CROUCH)

    # delay between each bot to variate leaderboard
    wait( ((testAI.index(eventPlayer)) * leaderboard_delay ) )

    # set bot to last point, teleport them and force em down into it
    eventPlayer.CurrentCheckpointIdx = len(Checkpoints) - 2
    SetCheckpoints()
    eventPlayer.teleport(eventPlayer.GoalCheckpoint + Vector.UP  + Vector.UP * RingSize)
    wait(1)
    eventPlayer.startForcingButton(Button.CROUCH)
    waitUntil(not eventPlayer.IsRacing, 5)
    eventPlayer.stopForcingButton(Button.CROUCH)


