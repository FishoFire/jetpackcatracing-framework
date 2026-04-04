settings {
    "main": {
        "description": "Improved with unlimited fuel and increasing speed.\nCredit to: Jeshaal#1649. original creator.",
        "modeName": "Jetpack Cat Racing IMPROVED"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "spectatorSlots": 12,
        "team1Slots": 0,
        "team2Slots": 12,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [
                {
                    "circuitRoyal": [
                        "night"
                    ]
                },
                {
                    "dorado": [
                        "night"
                    ]
                },
                {
                    "eichenwalde": [
                        "morning"
                    ]
                },
                "hanamura",
                "horizonLunarColony",
                {
                    "paraiso": [
                        "morning"
                    ]
                },
                "volskaya"
            ]
        },
        "general": {
            "heroLimit": "off",
            "respawnTime%": 0,
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "jetpackCat": {
                "secondaryFireRechargeRate%": 500,
                "enablePassiveUnlimitedFuel": true,
                "enableUlt": false
            },
            "enabledHeroes": [
                "jetpackCat"
            ]
        }
    }
}

#Global variables

globalvar Starting 0
globalvar Racetrack_Game 1
globalvar Lobby_High 2
globalvar Lobby_Best 3


#Player variables

playervar Racetrack 0
playervar Timer 1
playervar High_Score 2
playervar Racing 3
playervar SPEED 26


#Only remove the following directive if the gamemode does not use tricks such as A+0, A*0, "am" == "**", etc which would otherwise be optimized out.
#!optimizeStrict


rule "Add to Racetrack":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Disabled
    
    Racetrack_Game.append(eventPlayer.getEyePosition())
    createIcon(getAllPlayers(), eventPlayer.getEyePosition(), Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.WHITE)


rule "Game Setup":
    setMatchTime(900)
    setObjectiveDescription(getAllPlayers(), "{0} {1}".format(heroIcon(Hero.JETPACK_CAT), "Jetpack Cat Racing!"), HudReeval.VISIBILITY_AND_STRING)
    Racetrack_Game = []
    Lobby_High = []
    hudSubtext(getAllPlayers(), "\n", HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "Hold {0} to restart".format(inputBindingString(Button.RELOAD)), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "Hold {0} to change camera".format(inputBindingString(Button.INTERACT)), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    #hudHeader(getAllPlayers(), "Lobby Best: {0} by {1}".format(sorted(Lobby_High)[0], Lobby_Best), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), "Lobby Best: {0}{1}{2}".format(sorted(Lobby_High)[0] if Lobby_Best != 0 else "0", " by " if Lobby_Best != 0 else "", Lobby_Best if Lobby_Best != 0 else ""), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "Horizon Lunar Colony":
    @Condition getCurrentMap() == Map.HORIZON_LUNAR_COLONY
    
    Starting = vect(25.37, 20.855, -6.643)
    Racetrack_Game = [vect(37.522, 17.733, -13.274), vect(53.096, 15.646, -25.568), vect(52.649, 15.575, -36.41), vect(54.263, 16.157, -58.092), vect(44.59, 18.758, -76.158), vect(35.424, 16.084, -87.461), vect(24.838, 10.76, -88.175), vect(-2.301, 7.968, -91.878), vect(-13.549, 7.281, -106.714), vect(-33.665, 6.239, -121.167), vect(-42.132, 6.291, -117.656), vect(-46.948, 7.061, -105.457), vect(-33.36, 6.317, -96.191), vect(-19.603, 7.352, -95.754), vect(-7.166, 10.899, -94.01), vect(18.525, 10.621, -90.217), vect(32.131, 10.459, -85.929), vect(44.337, 11.322, -90.534), vect(60.153, 11.996, -86.571), vect(77.787, 14.861, -80.178), vect(71.56, 16.245, -68.203), vect(50.237, 16.638, -48.119), vect(30.144, 16.983, -44.147), vect(19.227, 16.899, -30.245), vect(21.859, 17.116, -18.253), vect(37.238, 17.318, -13.683)]


rule "Paraiso":
    @Condition getCurrentMap() == Map.PARAISO
    
    Starting = vect(-50.676, 12.902, 56.768)
    Racetrack_Game = [vect(-40.366, 9.04, 45.388), vect(-22.48, 2.544, 20.652), vect(-14.472, 1.766, 11.069), vect(-17.619, 2.385, -2.307), vect(-13.005, 10.038, -20.632), vect(-15.388, 10.636, -32.491), vect(-9.12, 19.06, -50.178), vect(-3.124, 19.954, -61.828), vect(2.276, 15.435, -79.872), vect(3.048, 7.23, -96.952), vect(-6.525, 6.175, -108.911), vect(-3.114, 3.932, -122.923), vect(-7.841, 2.913, -137.025), vect(-23.794, 3.309, -146.904), vect(-35.625, 7.5, -136.16), vect(-26.737, 11.149, -134.206), vect(-8.189, 11.575, -130.559), vect(-6.221, 7.083, -109.633), vect(2.737, 7.339, -97.992), vect(-0.975, 7.656, -73.444), vect(5.229, 5.998, -57.852), vect(-5.406, 2.92, -38.669), vect(-1.427, 2.679, -25.56), vect(-17.692, 2.648, -1.151), vect(-15.832, 2.09, 14.362), vect(-30.399, 2.717, 29.38)]


rule "Volskaya Industries":
    @Condition getCurrentMap() == Map.VOLSKAYA
    
    Starting = vect(-10.628, 9.626, 19.068)
    Racetrack_Game = [vect(-15.63, 7.184, 34.912), vect(-17.47, 5.118, 52.249), vect(-19.993, 8.754, 70.92), vect(-29.008, 12.611, 75.678), vect(-42.074, 13.11, 74.283), vect(-64.946, 5.527, 52.4), vect(-98.997, 4.859, 57.923), vect(-102.755, 4.638, 66.313), vect(-99.341, 4.866, 73.493), vect(-86.859, 4.544, 77.395), vect(-58.07, 4.933, 95.297), vect(-28.197, 5.602, 98.226), vect(-5.113, 0.097, 100.164), vect(20.514, -0.988, 101.062), vect(37.493, -1.373, 89.011), vect(39.523, -1.467, 69.684), vect(24.011, -0.609, 46.118), vect(0.426, 1.399, 25.545), vect(-16.476, 6.793, 28.745)]


rule "Hanamura":
    @Condition getCurrentMap() == Map.HANAMURA
    
    Starting = vect(69.447, 13.709, 3.227)
    Racetrack_Game = [vect(55.31, 11.133, 9.266), vect(29.707, 8.628, 11.127), vect(5.313, 4.482, 2.078), vect(-4.063, 4.042, -8.343), vect(-17.38, 0.756, -17.216), vect(-26.126, 5.056, -50.521), vect(-26.721, 3.746, -67.521), vect(-20.674, 3.591, -76.343), vect(-0.854, 5.924, -82.08), vect(14.102, 6.337, -74.915), vect(28.236, 4.267, -60.297), vect(32.851, 4.951, -42.201), vect(25.275, 3.13, -30.573), vect(11.991, 2.447, -24.385), vect(16.174, 2.392, -6.394), vect(28.754, 3.516, -3.708), vect(39.216, 3.909, -11.624), vect(57.521, 1.663, -13.342), vect(67.34, 3.716, -5.188), vect(68.84, 6.15, 7.811)]


rule "Circuit Royale":
    @Condition getCurrentMap() == Map.CIRCUIT_ROYAL
    
    Starting = vect(-63.092, 19.061, -41.668)
    Racetrack_Game = [vect(-53.641, 13.536, -41.479), vect(-34.12, 10.55, -41.657), vect(-21.127, 9.304, -29.655), vect(-21.983, 8.472, -9.899), vect(-16.404, 8.064, 3.199), vect(-5.232, 8.553, 4.751), vect(6.568, 8.718, -4.389), vect(5.468, 13.841, -26.904), vect(15.007, 13.063, -38.756), vect(22.848, 16.548, -28.173), vect(29.165, 16.369, -12.011), vect(59.743, 16.456, -9.967), vect(64.545, 16.607, 3.808), vect(56.732, 15.231, 19.058), vect(66.289, 13.842, 33.599), vect(85.58, 14.877, 27.167), vect(105.15, 19.15, 23.557), vect(105.291, 19.53, 33.537), vect(95.396, 19.633, 43.823), vect(62.5, 21.121, 53.809), vect(41.806, 21.956, 48.069), vect(27.022, 22.607, 40.311), vect(11.481, 23.156, 31.769), vect(2.747, 26.388, 21.349), vect(-10.467, 19.309, 10.476), vect(-20.481, 21.853, -0.662), vect(-35.744, 26.195, -14.557), vect(-50.105, 20.578, -24.259), vect(-53.734, 14.237, -41.146)]


rule "Dorado":
    @Condition getCurrentMap() == Map.DORADO
    
    Starting = vect(-3.321, 10.885, 4.219)
    Racetrack_Game = [vect(11.539, 3.979, 5.665), vect(29.67, 8.829, 2.197), vect(37.063, 18.143, -6.771), vect(41.682, 22.152, -12.468), vect(63.967, 24.868, -20.54), vect(81.002, 20.163, -6.788), vect(85.286, 22.485, 15.304), vect(92.147, 23.353, 30.175), vect(111.378, 24.212, 31.505), vect(139.042, 13.955, 27.63), vect(147.295, 13.668, 36.151), vect(163.354, 13.845, 43.972), vect(170.938, 14.481, 57.311), vect(184.013, 16.787, 50.442), vect(177.854, 21.545, 36.597), vect(155.333, 15.785, 24.958), vect(144.677, 14.299, 29.783), vect(121.855, 13.716, 19.711), vect(123.432, 12.799, -2.438), vect(95.706, 11.853, -20.531), vect(87.751, 11.855, -24.141), vect(72.063, 14.015, -14.382), vect(39.013, 8.085, -18.048), vect(14.574, 9.578, -11.385), vect(5.479, 9.258, -8.387), vect(4.818, 6.764, 2.715), vect(11.84, 4.351, 5.864)]


rule "Rialto":
    @Condition getCurrentMap() == Map.RIALTO
    
    Starting = vect(107.775, 4.948, -21.257)
    Racetrack_Game = [vect(89.326, 5.411, -21.137), vect(71.471, 4.702, -21.43), vect(67.008, 5.814, -45.725), vect(44.204, 7.662, -66.725), vect(31.899, 8.255, -66.88), vect(9.724, 10.965, -77.426), vect(-12.113, 14.047, -77.773), vect(-30.532, 17.601, -74.886), vect(-39.011, 18.698, -86.257), vect(-56.925, 13.876, -102.818), vect(-57.185, 13.208, -130.562), vect(-47.071, 10.674, -140.276), vect(-47.138, 10.345, -147.479), vect(-66.938, 10.594, -145.932), vect(-66.076, 9.875, -136.463), vect(-66.183, 10.491, -124.363), vect(-57.134, 11.351, -119.526), vect(-57.629, 22.541, -80.334), vect(-51.595, 18.91, -64.204), vect(-34.973, 13.246, -49.913), vect(-21.252, 8.79, -42.706), vect(0.632, 1.365, -41.862), vect(13.474, 9.381, -46.529), vect(31.327, 12.855, -35.043), vect(43.825, 12.376, -11.256), vect(71.118, 5.898, 4.977), vect(86.217, 5.01, 7.733), vect(89.483, 5.984, -20.7)]


rule "King's Row":
    @Condition getCurrentMap() == Map.KINGS_ROW
    
    Starting = vect(-4.057, 18.303, 16.517)
    Racetrack_Game = [vect(-6.018, 13.126, 1.408), vect(-8.498, 11.226, -24.786), vect(-17.804, 11.014, -34.361), vect(-30.674, 10.956, -33.545), vect(-39.323, 11.011, -35.114), vect(-63.381, 8.313, -33.252), vect(-82.484, 8.078, -40.765), vect(-97.055, 7.241, -10.747), vect(-117.459, 8.615, -4.016), vect(-133.072, 9.029, 9.203), vect(-147.825, 9.006, 11.021), vect(-148.448, 7.803, 19.239), vect(-141.217, 5.624, 23.962), vect(-118.972, 2.534, 18.772), vect(-123.793, 3.778, -2.206), vect(-99.89, 4.841, -9.863), vect(-90.618, 6.485, -22.572), vect(-83.162, 7.014, -24.805), vect(-69.482, 7.294, -20.787), vect(-60.382, 8.092, -32.04), vect(-48.309, 8.676, -33.428), vect(-38.042, 3.871, -24.814), vect(-23.43, 3.716, -28.183), vect(-11.984, 4.083, -29.041), vect(-8.094, 7.192, -18.804), vect(-5.964, 13.434, 1.557)]


rule "Eichenwalde":
    @Condition getCurrentMap() == Map.EICHENWALDE
    
    Starting = vect(-11.615, 8.374, -8.658)
    Racetrack_Game = [vect(-6.534, 11.063, -22.158), vect(6.604, 12.39, -26.837), vect(13.274, 15.076, -43.445), vect(19.241, 17.252, -54.811), vect(24.571, 19.93, -72.863), vect(59.198, 15.14, -93.575), vect(81.056, 16.497, -94.093), vect(88.621, 15.928, -75.294), vect(99.45, 15.176, -72.463), vect(101.066, 14.76, -60.344), vect(90.115, 15.358, -53.731), vect(94.862, 15.448, -41.956), vect(117.13, 15.339, -41.104), vect(126.556, 17.283, -35.436), vect(141.502, 17.556, -41.767), vect(135.197, 14.673, -62.632), vect(123.154, 14.383, -61.318), vect(110.442, 14.814, -58.905), vect(104.815, 14.874, -52.272), vect(103.576, 16.322, -42.237), vect(94.604, 16.86, -39.805), vect(90.293, 22.363, -59.57), vect(88.494, 22.147, -65.975), vect(82.16, 22.417, -70.058), vect(66.692, 21.795, -62.287), vect(56.935, 20.52, -56.573), vect(55.425, 19.752, -46.87), vect(52.489, 18.981, -37.864), vect(43.118, 16.907, -22.959), vect(30.33, 13.408, -12.461), vect(9.838, 10.638, -6.16), vect(-6.439, 11.471, -21.554)]


rule "Start":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.teleport(Starting)
    eventPlayer.Racetrack = Racetrack_Game
    eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.Racetrack[0]), Relativity.TO_WORLD)
    createEffect(eventPlayer.filter(lambda _: eventPlayer.Racetrack[0] != 0), Effect.GOOD_AURA, Color.GREEN, eventPlayer.Racetrack[0], 2.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createEffect(eventPlayer.filter(lambda _: eventPlayer.Racetrack[1] != 0), Effect.GOOD_AURA, Color.WHITE, eventPlayer.Racetrack[1], 2.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    hudHeader(eventPlayer, "Time: {0}".format(eventPlayer.Timer), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(eventPlayer, "Best Time: {0}".format(sorted(eventPlayer.High_Score)[0]), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.Timer = 0
    eventPlayer.High_Score = []
    createInWorldText(getAllPlayers(), "Best Time: {0}".format(sorted(eventPlayer.High_Score)[0]), updateEveryFrame(eventPlayer.getEyePosition() + vect(0, 0.5, 0)), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)
    eventPlayer.Racing = false
    eventPlayer.setMoveSpeed(100)
    eventPlayer.SPEED = 100


rule "Reset":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.teleport(Starting)
    eventPlayer.Racetrack = Racetrack_Game
    eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.Racetrack[0]), Relativity.TO_WORLD)
    eventPlayer.Timer = 0
    stopChasingVariable(eventPlayer.Timer)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.Racing = false
    eventPlayer.setMoveSpeed(100)
    eventPlayer.SPEED = 100


rule "Score":
    @Event eachPlayer
    @Condition distance(eventPlayer.Racetrack[0], eventPlayer.getEyePosition()) <= 2.5
    @Condition eventPlayer.isAlive() == true
    
    del eventPlayer.Racetrack[0]
    playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer.getEyePosition(), 100)
    chaseAtRate(eventPlayer.Timer, 100000000, 1)
    eventPlayer.Racing = true
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setMoveSpeed(eventPlayer.SPEED * 2)
    eventPlayer.SPEED += 3
    if eventPlayer.isUsingAbility1() == false or eventPlayer.Timer > 0.016:
        goto lbl_0
    eventPlayer.cancelPrimaryAction()
    lbl_0:


rule "Finish":
    @Event eachPlayer
    @Condition eventPlayer.Racetrack == []
    #@Condition eventPlayer.Timer != 0
    
    eventPlayer.Racing = false
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 2)
    stopChasingVariable(eventPlayer.Timer)
    bigMessage(eventPlayer, "Time: {0} {1}".format(eventPlayer.Timer, "(New Personal Best!)" if sorted(eventPlayer.High_Score)[0] == eventPlayer.Timer else ""))
    eventPlayer.High_Score.append(eventPlayer.Timer)
    eventPlayer.setAbility1Enabled(true)
    #smallMessage(eventPlayer, "{0} Ability 1 available".format(abilityIconString(Hero.JETPACK_CAT, Button.ABILITY_1)))
    if eventPlayer.Timer == 0:
        goto lbl_0
    Lobby_High.append(eventPlayer.Timer)
    Lobby_Best = eventPlayer if sorted(Lobby_High)[0] == sorted(eventPlayer.High_Score)[0] else Lobby_Best
    lbl_0:


rule "Change Camera":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    
    wait(0.1 - 0.016, Wait.ABORT_WHEN_FALSE)
    eventPlayer.Z = 0 if eventPlayer.Z == 2 else eventPlayer.Z + 1
    wait()
    if eventPlayer.Z != 0:
        if eventPlayer.Z == 1:
            eventPlayer.startCamera(updateEveryFrame(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(-0.75, 0, 0), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -4.3, null, eventPlayer, false).getHitPosition() + ((directionTowards(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * -4.3 + worldVector(vect(-0.75, 0, 0), eventPlayer, Transform.ROTATION), null, eventPlayer, false).getHitPosition(), eventPlayer.getEyePosition() + worldVector(vect(-0.75, 0, 0), eventPlayer, Transform.ROTATION))) * 0.3)), updateEveryFrame(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000 + worldVector(vect(-0.75, 0, 0), eventPlayer, Transform.ROTATION)), 10000)
        elif eventPlayer.Z == 2:
            eventPlayer.startCamera(updateEveryFrame(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(0.75, 0, 0), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -4.3, null, eventPlayer, false).getHitPosition() + ((directionTowards(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * -4.3 + worldVector(vect(0.75, 0, 0), eventPlayer, Transform.ROTATION), null, eventPlayer, false).getHitPosition(), eventPlayer.getEyePosition() + worldVector(vect(0.75, 0, 0), eventPlayer, Transform.ROTATION))) * 0.3)), updateEveryFrame(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 1000 + worldVector(vect(0.75, 0, 0), eventPlayer, Transform.ROTATION)), 10000)
    else:
        eventPlayer.stopCamera()


rule "Ability 1 Message":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition eventPlayer.Racing == true
    
    wait(0.032, Wait.ABORT_WHEN_FALSE)
    smallMessage(eventPlayer, "{0} Ability 1 is unavailable during races".format(abilityIconString(Hero.JETPACK_CAT, Button.ABILITY_1)))


rule "Ability 1 Disable When Racing":
    @Event eachPlayer
    @Condition eventPlayer.Racing == true
    @Disabled
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.75)
    eventPlayer.forceButtonPress(Button.ABILITY_1)


