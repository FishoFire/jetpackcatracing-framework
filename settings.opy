#!mainFile "main.opy"
#!extension playMoreEffects
#!extension explosionSounds

settings {
    "main": {
        "description": "Jetpack Cat Racing Overhaul.\nAdapted by nebula, original credit to Jashaal and Roeesun.",
        "modeName": f"Jetpack Cat Racing {versionhere}"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "spectatorSlots": 3,
        "team1Slots": 0,
        "team2Slots": 10,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "skirmish": {
            "enabledMaps": [

                "hanamura"
            ]

        },
        "general": {
            "heroLimit": "off",
            "respawnTime%": 10,
            "spawnHealthPacks": "disabled",
            "enableRandomHeroes": true
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

#!define divider(x) rule "------------------------------------------------------------------------  x ------------------------------------------------------------------------ ":\
    @Delimiter\
    @Disabled