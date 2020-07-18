local xplookups_info = 
{
    version = "1.0.0",
    author = "Avacee",
    description = "This plugin parses X-Plane 11 UDP Packets",
    repository = "https://github.com/avacee/xp11-Lua-Dissector"
}

set_plugin_info(xplookups_info)

xp11_StartTypeLookup = {
  [5] = "RepeatLast",
  [6] = "LatLong",
  [7] = "GeneralArea",
  [8] = "NearestAirport",
  [9] = "SnapshotLoad",
  [10] = "Ramp",
  [11] = "Runway",
  [12] = "RunwayVFR",
  [13] = "RunwayIFR",
  [14] = "GrassStrip",
  [15] = "DirtStrip",
  [16] = "GravelStrip",
  [17] = "WaterRunway",
  [18] = "Helipad",
  [19] = "CarrierCatapult",
  [20] = "GliderTowPlane",
  [21] = "GliderWinch",
  [22] = "FormationFlying",
  [23] = "RefuelBoom",
  [24] = "RefuelBasket",
  [25] = "B52Drop",
  [26] = "ShuttlePiggyBack",
  [27] = "CarrierApproach",
  [28] = "FrigateApproach",
  [29] = "SmallOilRigApproach",
  [30] = "LargeOilPlatformApproach",
  [31] = "ForestFireApproach",
  [32] = "Shuttle01",
  [33] = "Shuttle02",
  [34] = "Shuttle03",
  [35] = "Shuttle04",
  [36] = "ShuttleGlide"
}

xp11_SituationLookup = {
  [0] = "Save Situation",
  [1] = "Load Situation",
  [2] = "Save Movie",
  [3] = "Load Movie"
}

xp11_BeaconTypeLookup = {
  [1] = "Master",
  [2] = "External Visual",
  [3] = "IOS"
}

xp11_EngineModeLookup = {
    [0] = "Feather",
    [1] = "Normal",
    [2] = "Beta",
    [3] = "Reverse"
}

xp11_MachineTypeLookup = {
  [0] = "Multiplayer1",
  [1] = "Multiplayer2",
  [2] = "Multiplayer3",
  [3] = "Multiplayer4",
  [4] = "Multiplayer5",
  [5] = "Multiplayer6",
  [6] = "Multiplayer7",
  [7] = "Multiplayer8",
  [8] = "Multiplayer9",
  [9] = "Multiplayer10",
  [10] = "Multiplayer11",
  [11] = "Multiplayer12",
  [12] = "Multiplayer13",
  [13] = "Multiplayer14",
  [14] = "Multiplayer15",
  [15] = "Multiplayer16",
  [16] = "Multiplayer17",
  [17] = "Multiplayer18",
  [18] = "Multiplayer19",
  [19] = "ExternalVisual0", 
  [20] = "ExternalVisual1", 
  [21] = "ExternalVisual2", 
  [22] = "ExternalVisual3", 
  [23] = "ExternalVisual4", 
  [24] = "ExternalVisual5", 
  [25] = "ExternalVisual6", 
  [26] = "ExternalVisual7", 
  [27] = "ExternalVisual8", 
  [28] = "ExternalVisual9", 
  [29] = "ExternalVisual10",
  [30] = "ExternalVisual11",
  [31] = "ExternalVisual12",
  [32] = "ExternalVisual13",
  [33] = "ExternalVisual14",
  [34] = "ExternalVisual15",
  [35] = "ExternalVisual16",
  [36] = "ExternalVisual17",
  [37] = "ExternalVisual18",
  [38] = "ExternalVisual19",
  [39] = "ExternalVisualMaster8",
  [42] = "IOSMasterThisIsIOS",
  [62] = "IOSThisIsMaster",
  [64] = "DataOutputTarget",
  [71] = "Xavi1",
  [72] = "Xavi2",
  [73] = "Xavi3",
  [74] = "Xavi4",
  [75] = "ForeFlight",
  [76] = "ForeFlightBroadcast",
  [77] = "ControlPadForIOS"
}