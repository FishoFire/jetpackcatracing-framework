#!mainFile "main.opy"

settings {
    "main": {
        "description": "Jetpack Cat Racing Overhaul.\nAdapted by nebula, original credit to Jashaal and Roeesun.",
        "modeName": f"Jetpack Cat Racing {versionhere}"
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

                "hanamura"
            ]

        },
        "general": {
            "heroLimit": "off",
            "respawnTime%": 0,
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