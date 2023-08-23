Config = {}

Config.Locations = { -- You can extend coordinates
    [1] = {
        coords = vector3(352.61, 6530.73, 28.74),
        collected = false
    },
    [2] = {
        coords = vector3(360.42, 6531.92, 28.74),
        collected = false
    },
    [3] = {
        coords = vector3(368.42, 6531.92, 28.74),
        collected = false
    },
}

Config.TreeRefreshInterval = 60000 -- 1 Minute

Config.OrangeJuice = vector3(2742.0, 4412.42, 48.62)

Config.MinOrange = 1
Config.MaxOrange = 8

Config.OrangeToJuice = 1

Config.OrangeBlip = vector3(348.85, 6525.7, 28.73)
Config.OrangeBlipName = "Orange"
Config.OrangeJuiceBlip = vector3(2742.13, 4412.31, 48.62)
Config.OrangeJuiceBlipName = "Orange Juice"

Config.Blip = true

Config.Lang = {
    collectorange = "[E] Collect Orange",
    converttojuice = "[E] Convet Orange To Juice",
    collected = "You collect orange. Count: ",
    collectedjuice = "You collected 1 orange juice.",
    dontenoughorange = "You don't have enough orange."
}