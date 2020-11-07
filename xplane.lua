local xplane_info = 
{
    version = "1.1.0",
    author = "Avacee",
    description = "This plugin parses UDP packets from Laminar Research's X-Plane Flight Simulator",
    repository = "https://github.com/avacee/xp11-Lua-Dissector"
}

set_plugin_info(xplane_info)

--local d = require('debug')

xplane = Proto("xplane","X-Plane")

xplane.prefs.becn_port = Pref.uint("BECN Port",49707," X-Plane's BECN port")

local VALS_StartType = {
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

local VALS_Situation = {
  [0] = "Save Situation",
  [1] = "Load Situation",
  [2] = "Save Movie",
  [3] = "Load Movie"
}

local VALS_BECN_MachineRole = {
  [1] = "Master",
  [2] = "External Visual",
  [3] = "IOS"
}

--xplane_EngineMode = {
--    [0] = "Feather",
--    [1] = "Normal",
--    [2] = "Beta",
--    [3] = "Reverse"
--}

local VALS_ISEx_MachineType = {
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

local xplane_DataIdLookup = {}
for i = 0, 138 do
  xplane_DataIdLookup[i] = {}
  for j=0,8 do
    xplane_DataIdLookup[i][j] = ""
  end
end

xplane_DataIdLookup[0][0] = "Frame Rate"
xplane_DataIdLookup[0][1] = "Actual Frame Rate"
xplane_DataIdLookup[0][2] = "Sim Frame Rate"
xplane_DataIdLookup[0][3] = "" --Unused
xplane_DataIdLookup[0][4] = "Frame Time (s) DataRef=sim/time/framerate_period"
xplane_DataIdLookup[0][5] = "CPU Time (s)"
xplane_DataIdLookup[0][6] = "GPU Time (s)  DataRef=sim/time/gpu_time_per_frame_sec_approx"
xplane_DataIdLookup[0][7] = "grnd ratio"
xplane_DataIdLookup[0][8] = "flit ratio (Requested Simulator Speed multiple from ctrl-T  DataRef=sim/time/sim_speed_actual"

xplane_DataIdLookup[1][0]= "Times"
xplane_DataIdLookup[1][1] = "Elapsed Sim Start (s)"
xplane_DataIdLookup[1][2] = "Elapsed Total Time (exc Start Screen) (s)"
xplane_DataIdLookup[1][3] = "Elapsed Mission Time (s)" 
xplane_DataIdLookup[1][4] = "Elapsed Timer (s)"
xplane_DataIdLookup[1][5] = "" -- Unused
xplane_DataIdLookup[1][6] = "Zulu Time  DataRef=sim/time/zulu_time_sec"
xplane_DataIdLookup[1][7] = "Simulator Local Time"
xplane_DataIdLookup[1][8] = "Hobbs Time DataRef=sim/time/hobbs_time"

xplane_DataIdLookup[2][0]= "Sim Stats"
xplane_DataIdLookup[2][1]= "USE (puffs)"
xplane_DataIdLookup[2][2]= "TOT (puffs)"
xplane_DataIdLookup[2][3]= "Triangles Visible"
xplane_DataIdLookup[2][4]= "" -- Unused
xplane_DataIdLookup[2][5]= "" -- Unused
xplane_DataIdLookup[2][6]= "" -- Unused
xplane_DataIdLookup[2][7]= "" -- Unused
xplane_DataIdLookup[2][8]= "" -- Unused

xplane_DataIdLookup[3][0]= "Speeds"
xplane_DataIdLookup[3][1]= "Knots Indicated Airspeed"
xplane_DataIdLookup[3][2]= "Knots Equivalent Airspeed "
xplane_DataIdLookup[3][3]= "Knots True Airspeed"
xplane_DataIdLookup[3][4]= "Knots Tree Ground Speed"
xplane_DataIdLookup[3][5]= "" -- Unused
xplane_DataIdLookup[3][6]= "Indicated (mph)" 
xplane_DataIdLookup[3][7]= "True Airspeed (mph)" 
xplane_DataIdLookup[3][8]= "True Ground Speed (mph)" 

xplane_DataIdLookup[4][0]= "Mach, VVI, g-load"
xplane_DataIdLookup[4][1]= "Current Mach"
xplane_DataIdLookup[4][2]= "" -- Unused
xplane_DataIdLookup[4][3]= "Vertical Velocity (feet per minute)"
xplane_DataIdLookup[4][4]= "" -- Unused
xplane_DataIdLookup[4][5]= "Gload (normal)"
xplane_DataIdLookup[4][6]= "GLoad (axial)" 
xplane_DataIdLookup[4][7]= "Gload (side)" 
xplane_DataIdLookup[4][8]= "" -- Unused

xplane_DataIdLookup[5][0]= "Weather"
xplane_DataIdLookup[5][1]= "Sea Level Pressure (inHG)"
xplane_DataIdLookup[5][2]= "Sea Level Temperature (degC)"
xplane_DataIdLookup[5][3]= "" -- Unused
xplane_DataIdLookup[5][4]= "Wind Speed (knots)"
xplane_DataIdLookup[5][5]= "Wind From Direction 0=N->S  270=West->East"
xplane_DataIdLookup[5][6]= "Local Turbulance (0->1)" 
xplane_DataIdLookup[5][7]= "Local Precipitation (0->1)"
xplane_DataIdLookup[5][8]= "Local Hail (0->1)"

xplane_DataIdLookup[6][0]= "Aircraft atmosphere"
xplane_DataIdLookup[6][1]= "Atmospheric Pressure (inHG)"
xplane_DataIdLookup[6][2]= "Atmospheric Temperature (degC)"
xplane_DataIdLookup[6][3]= "LE temp (degC)" 
xplane_DataIdLookup[6][4]= "Aircraft Density Ratio"
xplane_DataIdLookup[6][5]= "A (ktas)"
xplane_DataIdLookup[6][6]= "Q Dynamic pressue (lbs / ft^2)" 
xplane_DataIdLookup[6][7]= "" -- Unused
xplane_DataIdLookup[6][8]= "Gravitational Force (feet/s^2)"

xplane_DataIdLookup[7][0]= "System pressures"
xplane_DataIdLookup[7][1]= "Barometric pressure (inHG)"
xplane_DataIdLookup[7][2]= "edens (part)"
xplane_DataIdLookup[7][3]= "Vacuum ratio" 
xplane_DataIdLookup[7][4]= "Vacuum ratio"
xplane_DataIdLookup[7][5]= "Elec ratio"
xplane_DataIdLookup[7][6]= "Elec ratio" 
xplane_DataIdLookup[7][7]= "AHRS ratio" 
xplane_DataIdLookup[7][8]= "AHRS ratio"

xplane_DataIdLookup[8][0]= "Joystick aileron/elevator/rudder"
xplane_DataIdLookup[8][1]= "Elevator Full down = -1 Full Up = +1"
xplane_DataIdLookup[8][2]= "Aileron Full Left = -1  Full Right = +1"
xplane_DataIdLookup[8][3]= "Rudder  Full Left = -1  Full Right = +1"
xplane_DataIdLookup[8][4]= "" --Unused
xplane_DataIdLookup[8][5]= "" --Unused
xplane_DataIdLookup[8][6]= "" --Unused
xplane_DataIdLookup[8][7]= "" --Unused
xplane_DataIdLookup[8][8]= "" --Unused

xplane_DataIdLookup[9][0]= "Other Flight Controls"
xplane_DataIdLookup[9][1]= "Requested Thrust Vectoring"
xplane_DataIdLookup[9][2]= "Requested Wing Sweep"
xplane_DataIdLookup[9][3]= "Requested Wing Incidence"
xplane_DataIdLookup[9][4]= "Requested Wing Digedral" 
xplane_DataIdLookup[9][5]= "Requested Wing Retration" 
xplane_DataIdLookup[9][6]= "" --Unused
xplane_DataIdLookup[9][7]= "" --Unused
xplane_DataIdLookup[9][8]= "Water Jettisoned" 

xplane_DataIdLookup[10][0]= "Artificial Stability Input"
xplane_DataIdLookup[10][1]= "Elevator Full down = -1 Full Up = +1"
xplane_DataIdLookup[10][2]= "Aileron Full Left = -1  Full Right = +1"
xplane_DataIdLookup[10][3]= "Rudder  Full Left = -1  Full Right = +1"
xplane_DataIdLookup[10][4]= "" --Unused
xplane_DataIdLookup[10][5]= "" --Unused
xplane_DataIdLookup[10][6]= "" --Unused
xplane_DataIdLookup[10][7]= "" --Unused
xplane_DataIdLookup[10][8]= "" --Unused

xplane_DataIdLookup[11][0]= "Flight Control Deflections"
xplane_DataIdLookup[11][1]= "Elevator Full down = -1 Full Up = +1"
xplane_DataIdLookup[11][2]= "Aileron Full Left = -1  Full Right = +1"
xplane_DataIdLookup[11][3]= "Rudder  Full Left = -1  Full Right = +1"
xplane_DataIdLookup[11][4]= "" --Unused
xplane_DataIdLookup[11][5]= "Nosewheel Degrees from forward. Negative = left, Positive = right"
xplane_DataIdLookup[11][6]= "" --Unused
xplane_DataIdLookup[11][7]= "" --Unused
xplane_DataIdLookup[11][8]= "" --Unused

xplane_DataIdLookup[12][0]= "Wing sweep and thrust vectoring"
xplane_DataIdLookup[12][1]= "Sweep 1 (degrees back from normal)"
xplane_DataIdLookup[12][2]= "Sweep 1 (degrees back from normal)"
xplane_DataIdLookup[12][3]= "Sweep (degrees back from normal)"
xplane_DataIdLookup[12][4]= "Vector Ratio" 
xplane_DataIdLookup[12][5]= "Sweep ratio (to fully forward)"
xplane_DataIdLookup[12][6]= "Incidence ratio (to fully angled)" 
xplane_DataIdLookup[12][7]= "Dihedral ratio (to fulyl angled)" 
xplane_DataIdLookup[12][8]= "Retraction ratio (to fully angled)" 

xplane_DataIdLookup[13][0]= "Trim / flaps / Slats / Speedbrakes"
xplane_DataIdLookup[13][1]= "Elevator trim"
xplane_DataIdLookup[13][2]= "Aileron trim"
xplane_DataIdLookup[13][3]= "Rudder trim"
xplane_DataIdLookup[13][4]= "Flap Requested (0->1)" 
xplane_DataIdLookup[13][5]= "Flap Ratio (0->1)"
xplane_DataIdLookup[13][6]= "Slat Ratio" 
xplane_DataIdLookup[13][7]= "Speedbrake Requested (0->1)" 
xplane_DataIdLookup[13][8]= "Speedbrake Ratio (0->1)"

xplane_DataIdLookup[14][0]= "Gear and Brakes"
xplane_DataIdLookup[14][1]= "Gear Requested (0->1)"
xplane_DataIdLookup[14][2]= "wbrak, set"
xplane_DataIdLookup[14][3]= "Left Toe Brake requested"
xplane_DataIdLookup[14][4]= "Right Toe Brake requested" 
xplane_DataIdLookup[14][5]= "wbrak, position"
xplane_DataIdLookup[14][6]= "" --Unused 
xplane_DataIdLookup[14][7]= "" --Unused
xplane_DataIdLookup[14][8]= "" --Unused

xplane_DataIdLookup[15][0]= "Angular Moments"
xplane_DataIdLookup[15][1]= "M Roll Torque around X-axis (foot / lbs)"
xplane_DataIdLookup[15][2]= "L Roll Torque around Z-axis (foot / lbs)"
xplane_DataIdLookup[15][3]= "N Roll Torque around Y-axis (foot / lbs)"
xplane_DataIdLookup[15][4]= "" --Unused 
xplane_DataIdLookup[15][5]= "" --Unused 
xplane_DataIdLookup[15][6]= "" --Unused 
xplane_DataIdLookup[15][7]= "" --Unused
xplane_DataIdLookup[15][8]= "" --Unused

xplane_DataIdLookup[16][0]= "Angular Velocities"
xplane_DataIdLookup[16][1]= "Q Pitch Rate (measued in Body-axes)"
xplane_DataIdLookup[16][2]= "P Roll Rate (measued in Body-axes)"
xplane_DataIdLookup[16][3]= "R Yaw Rate (measued in Body-axes)"
xplane_DataIdLookup[16][4]= "" --Unused 
xplane_DataIdLookup[16][5]= "" --Unused 
xplane_DataIdLookup[16][6]= "" --Unused 
xplane_DataIdLookup[16][7]= "" --Unused
xplane_DataIdLookup[16][8]= "" --Unused

xplane_DataIdLookup[17][0]= "Pitch / Roll / Headings"
xplane_DataIdLookup[17][1]= "Pitch degrees (measured in body-axis Euler angles)"
xplane_DataIdLookup[17][2]= "Roll degrees (measured in body-axis Euler angles)"
xplane_DataIdLookup[17][3]= "True Heading (degrees)"
xplane_DataIdLookup[17][4]= "Magnetic Heading (degrees)"
xplane_DataIdLookup[17][5]= "" --Unused 
xplane_DataIdLookup[17][6]= "" --Unused 
xplane_DataIdLookup[17][7]= "" --Unused
xplane_DataIdLookup[17][8]= "" --Unused

xplane_DataIdLookup[18][0]= "Angle Of Attack, sideslip, paths"
xplane_DataIdLookup[18][1]= "Alpha - AoA (degrees)"
xplane_DataIdLookup[18][2]= "Beta slideslip (degrees)"
xplane_DataIdLookup[18][3]= "HPath (degrees)"
xplane_DataIdLookup[18][4]= "VPath (degrees)"
xplane_DataIdLookup[18][5]= "" --Unused 
xplane_DataIdLookup[18][6]= "" --Unused 
xplane_DataIdLookup[18][7]= "" --Unused
xplane_DataIdLookup[18][8]= "slip, degrees"

xplane_DataIdLookup[19][0]= "Magnetic Compass"
xplane_DataIdLookup[19][1]= "Magnetic Heading"
xplane_DataIdLookup[19][2]= "Magnetic Variation (from True)"
xplane_DataIdLookup[19][3]= "" --Unused
xplane_DataIdLookup[19][4]= "" --Unused
xplane_DataIdLookup[19][5]= "" --Unused 
xplane_DataIdLookup[19][6]= "" --Unused 
xplane_DataIdLookup[19][7]= "" --Unused
xplane_DataIdLookup[19][8]= "" --Unused

xplane_DataIdLookup[20][0]= "Global Position"
xplane_DataIdLookup[20][1]= "Latitude"
xplane_DataIdLookup[20][2]= "Longitude"
xplane_DataIdLookup[20][3]= "Altitude (ft above mean sea level)"
xplane_DataIdLookup[20][4]= "Altitude (ft above ground)"
xplane_DataIdLookup[20][5]= "Is On Runway?"
xplane_DataIdLookup[20][6]= "Indicated Altitude" 
xplane_DataIdLookup[20][7]= "Latitude (bottom of containing Lat/Long scenery square)" 
xplane_DataIdLookup[20][8]= "Longitude (left of containing Lat/Long scenery square)" 

xplane_DataIdLookup[21][0]= "Distances Travelled"
xplane_DataIdLookup[21][1]= "X - relative to inertial axes"
xplane_DataIdLookup[21][2]= "Y - relative to inertial axes"
xplane_DataIdLookup[21][3]= "Z - relative to inertial axes"
xplane_DataIdLookup[21][4]= "vX (m/s) - relative to inertial axes"
xplane_DataIdLookup[21][5]= "vY (m/s) - relative to inertial axes"
xplane_DataIdLookup[21][6]= "vZ (m/s) - relative to inertial axes"
xplane_DataIdLookup[21][7]= "Distance (feet)" 
xplane_DataIdLookup[21][8]= "Distance (nm)" 

xplane_DataIdLookup[22][0]= "All Planes Latitude"
xplane_DataIdLookup[23][0]= "All Planes Longitude"
xplane_DataIdLookup[24][0]= "All Planes Altitude (feet above mean sea level)"

for i=0,7,1 do
  xplane_DataIdLookup[22][i+1]= "Latitude of Plane " .. i
  xplane_DataIdLookup[23][i+1]= "Longitude of Plane " .. i
  xplane_DataIdLookup[24][i+1]= "Altitude of Plane " .. i
end

-- The following DATA entries have a similar descriptions so are populated in a loop later
xplane_DataIdLookup[25][0]= "Throttle - Requested"
xplane_DataIdLookup[26][0]= "Throttle - Actual"
xplane_DataIdLookup[27][0]= "Engine Mode (0=Feather, 1=Normal, 2-Beta and 3=Reverse)"
xplane_DataIdLookup[28][0]= "Propeller setting"
xplane_DataIdLookup[29][0]= "Mixture setting"
xplane_DataIdLookup[30][0]= "Carb heat"
xplane_DataIdLookup[31][0]= "Cowl flaps"
xplane_DataIdLookup[32][0]= "Magnetos"
xplane_DataIdLookup[33][0]= "Starter timeout"
xplane_DataIdLookup[34][0]= "Engine power"
xplane_DataIdLookup[35][0]= "Engine thrust"
xplane_DataIdLookup[36][0]= "Engine torque"
xplane_DataIdLookup[37][0]= "Engine RPM"
xplane_DataIdLookup[38][0]= "Propeller RPM"
xplane_DataIdLookup[39][0]= "Propeller Pitch"
xplane_DataIdLookup[40][0]= "Engine Wash"
xplane_DataIdLookup[41][0]= "N1"
xplane_DataIdLookup[42][0]= "N2"
xplane_DataIdLookup[43][0]= "Manifold pressure"
xplane_DataIdLookup[44][0]= "EPR"
xplane_DataIdLookup[45][0]= "Fuel Flow"
xplane_DataIdLookup[46][0]= "ITT"
xplane_DataIdLookup[47][0]= "EGT"
xplane_DataIdLookup[48][0]= "CHT"
xplane_DataIdLookup[49][0]= "Oil pressure"
xplane_DataIdLookup[50][0]= "Oil temperature"
xplane_DataIdLookup[51][0]= "Fuel pressure"
xplane_DataIdLookup[52][0]= "Generator amps"
xplane_DataIdLookup[53][0]= "Battery amps"
xplane_DataIdLookup[54][0]= "Battery volts"
xplane_DataIdLookup[55][0]= "Electric fuel pump on/off"
xplane_DataIdLookup[56][0]= "Idle speed low/high"
xplane_DataIdLookup[57][0]= "Battery on/off"
xplane_DataIdLookup[58][0]= "Generator on/off"
xplane_DataIdLookup[59][0]= "Inverter on/off"
xplane_DataIdLookup[60][0]= "FADEC on/off"
xplane_DataIdLookup[61][0]= "Igniter on/off"
xplane_DataIdLookup[62][0]= "Fuel weights"

for i=0,7,1 do
  xplane_DataIdLookup[25][i+1]= "Engine " .. i .. " requested throttle"
  xplane_DataIdLookup[26][i+1]= "Engine " .. i .. " actual throttle"
  xplane_DataIdLookup[27][i+1]= "Engine " .. i .. " mode"
  xplane_DataIdLookup[28][i+1]= "Propeller " .. i .. " setting"
  xplane_DataIdLookup[30][i+1]= "Engine " .. i .. " Carb heat"
  xplane_DataIdLookup[31][i+1]= "Engine " .. i .. " Cowl flaps"
  xplane_DataIdLookup[32][i+1]= "Magneto" .. 1
  xplane_DataIdLookup[33][i+1]= "Starter " .. i .. " timeout"
  xplane_DataIdLookup[34][i+1]= "Engine " .. i .. " Power (hp)"
  xplane_DataIdLookup[35][i+1]= "Engine " .. i .. " Thrust (lbs)"
  xplane_DataIdLookup[36][i+1]= "Engine " .. i .. " Torque (ft/lbs)"
  xplane_DataIdLookup[37][i+1]= "Engine " .. i .. " RPM"
  xplane_DataIdLookup[38][i+1]= "Propeller " .. i .. " RPM"
  xplane_DataIdLookup[39][i+1]= "Propeller " .. i .. " Pitch"
  xplane_DataIdLookup[40][i+1]= "Engine " .. i .. " Wash"
  xplane_DataIdLookup[41][i+1]= "Engine " .. i .. " N1"
  xplane_DataIdLookup[42][i+1]= "Engine " .. i .. " N2"
  xplane_DataIdLookup[43][i+1]= "Engine " .. i .. " MP (Manifold Pressure)"
  xplane_DataIdLookup[44][i+1]= "Engine " .. i .. " EPR (Engine Pressure Ratio)"
  xplane_DataIdLookup[45][i+1]= "Engine " .. i .. " Fuel Flow (lb/h)"
  xplane_DataIdLookup[46][i+1]= "Engine " .. i .. " ITT (Interstage Turbine Temperature)"
  xplane_DataIdLookup[47][i+1]= "Engine " .. i .. " EGT (Exhaust Gas Temperature("
  xplane_DataIdLookup[48][i+1]= "Engine " .. i .. " CHT (Cylinder Head Temperature)"
  xplane_DataIdLookup[49][i+1]= "Engine " .. i .. " Oil Pressure (lbs/in^2)"
  xplane_DataIdLookup[50][i+1]= "Engine " .. i .. " Oil Temperature"
  xplane_DataIdLookup[51][i+1]= "Engine " .. i .. " Fuel Pressure (lb/in^2)"
  xplane_DataIdLookup[52][i+1]= "Engine " .. i .. " Generator Amps (A)"
  xplane_DataIdLookup[53][i+1]= "Battery " .. i .. " Amps (A)"
  xplane_DataIdLookup[54][i+1]= "Battery " .. i .. " Volts (V)"
  xplane_DataIdLookup[55][i+1]= "Electric fuel pump " .. i .. " On/Off"
  xplane_DataIdLookup[56][i+1]= "Engine " .. i .. " Idle Speed Low/High"
  xplane_DataIdLookup[57][i+1]= "Battery " .. i .. " On/Off"
  xplane_DataIdLookup[58][i+1]= "Generator " .. i .. " on/off"
  xplane_DataIdLookup[59][i+1]= "Inverter " .. i .. " on/off"
  xplane_DataIdLookup[60][i+1]= "FADEC " .. i .. " on/off"
  xplane_DataIdLookup[61][i+1]= "Igniter " .. i .. " on/off"
  xplane_DataIdLookup[62][i+1]= "Fuel Tank " .. i .. " weight (lbs)"
end

xplane_DataIdLookup[63][0]= "Aircraft Payload (lbs) and Centre of Gravity"
xplane_DataIdLookup[63][1]= "Weight Empty"
xplane_DataIdLookup[63][2]= "Weight Total"
xplane_DataIdLookup[63][3]= "Fuel Total"
xplane_DataIdLookup[63][4]= "Weight Jettisonable" 
xplane_DataIdLookup[63][5]= "Weight Current" 
xplane_DataIdLookup[63][6]= "Weight Maximum" 
xplane_DataIdLookup[63][7]= "" --Unused
xplane_DataIdLookup[63][8]= "CoG (feet behind reference point)" 

xplane_DataIdLookup[64][0]= "Aerodynamic Forces"
xplane_DataIdLookup[64][1]= "Lift (lbs)"
xplane_DataIdLookup[64][2]= "Drag (lbs)"
xplane_DataIdLookup[64][3]= "Side (lbs)"
xplane_DataIdLookup[64][4]= "L (ft / lbs)" 
xplane_DataIdLookup[64][5]= "M (ft / lbs)" 
xplane_DataIdLookup[64][6]= "N (ft / lbs)" 
xplane_DataIdLookup[64][7]= "" --Unused
xplane_DataIdLookup[64][8]= "" --Unused

xplane_DataIdLookup[65][0]= "Engine Forces"
xplane_DataIdLookup[65][1]= "Normal (lbs)"
xplane_DataIdLookup[65][2]= "Axial (lbs)"
xplane_DataIdLookup[65][3]= "Side (lbs)"
xplane_DataIdLookup[65][4]= "" --Unused
xplane_DataIdLookup[65][5]= "" --Unused 
xplane_DataIdLookup[65][6]= "" --Unused
xplane_DataIdLookup[65][7]= "" --Unused
xplane_DataIdLookup[65][8]= "" --Unused

xplane_DataIdLookup[66][0]= "Landing Gear Vertical Forces (lbs)"
xplane_DataIdLookup[66][1]= "Landing Gear 1 (typically nosewheel)"
xplane_DataIdLookup[66][2]= "Landing Gear 2"
xplane_DataIdLookup[66][3]= "Landing Gear 3"
xplane_DataIdLookup[66][4]= "Landing Gear 4"
xplane_DataIdLookup[66][5]= "Landing Gear 5" 
xplane_DataIdLookup[66][6]= "Landing Gear 6"
xplane_DataIdLookup[66][7]= "Landing Gear 7"
xplane_DataIdLookup[66][8]= "Landing Gear 8"

xplane_DataIdLookup[67][0]= "Landing Gear Deployment Ratio (0=Up, 1=Down)"
xplane_DataIdLookup[67][1]= "Landing Gear 1 (typically nosewheel)"
xplane_DataIdLookup[67][2]= "Landing Gear 2"
xplane_DataIdLookup[67][3]= "Landing Gear 3"
xplane_DataIdLookup[67][4]= "Landing Gear 4"
xplane_DataIdLookup[67][5]= "Landing Gear 5" 
xplane_DataIdLookup[67][6]= "Landing Gear 6"
xplane_DataIdLookup[67][7]= "Landing Gear 7"
xplane_DataIdLookup[67][8]= "Landing Gear 8"

xplane_DataIdLookup[68][0]= "Lift over drag and coefficients"
xplane_DataIdLookup[68][1]= "Lift/Drag Ratio"
xplane_DataIdLookup[68][2]= "" --Unused
xplane_DataIdLookup[68][3]= "cl, total"
xplane_DataIdLookup[68][4]= "cd, total"
xplane_DataIdLookup[68][5]= "" --Unused
xplane_DataIdLookup[68][6]= "" --Unused
xplane_DataIdLookup[68][7]= "" --Unused
xplane_DataIdLookup[68][8]= "Lift/Drag (*etaP)"

xplane_DataIdLookup[69][0]= "Propeller Efficiency"
for i=0,7,1 do
  xplane_DataIdLookup[69][i+1]= "Propeller " .. i .. " Efficiency"
end

xplane_DataIdLookup[70][0]= "Aileron deflections 1"
xplane_DataIdLookup[71][0]= "Aileron deflections 2"
xplane_DataIdLookup[72][0]= "Roll spoiler deflections 1"
xplane_DataIdLookup[73][0]= "Roll spoiler deflections 2"
xplane_DataIdLookup[74][0]= "Elevator Deflections (degrees)"
xplane_DataIdLookup[75][0]= "Rudder deflections"
xplane_DataIdLookup[76][0]= "Yaw and brake deflections"
for i=0,6,2 do
  xplane_DataIdLookup[70][i+1]= "Left Aileron " .. i/2
  xplane_DataIdLookup[71][i+1]= "Left Aileron " .. (i/2) + 4
  xplane_DataIdLookup[72][i+1]= "Left Roll spoiler " .. i/2
  xplane_DataIdLookup[73][i+1]= "Left Roll spoiler " .. (i/2) + 4
  xplane_DataIdLookup[74][i+1]= "Left Elevator " .. i/2
  xplane_DataIdLookup[75][i+1]= "Left Rudder " .. i/2
  xplane_DataIdLookup[76][i+1]= "Left Yaw Brake " .. i/2
end
for i=1,7,2 do
  xplane_DataIdLookup[70][i+1]= "Right Aileron " .. (i-1)/2
  xplane_DataIdLookup[71][i+1]= "Right Aileron " .. ((i-1)/2) + 4
  xplane_DataIdLookup[72][i+1]= "Right Roll spoiler " .. (i-1)/2
  xplane_DataIdLookup[73][i+1]= "Right Roll spoiler " .. ((i-1)/2) + 4
  xplane_DataIdLookup[74][i+1]= "Right Elevator " .. (i-1)/2
  xplane_DataIdLookup[75][i+1]= "Right Rudder " .. (i-1)/2 
  xplane_DataIdLookup[76][i+1]= "Right Yaw Brake " .. (i-1)/2
end

xplane_DataIdLookup[77][0]= "Control Forces on Pilot's Hands (lbs)"
xplane_DataIdLookup[77][1]= "Pitch"
xplane_DataIdLookup[77][2]= "Roll"
xplane_DataIdLookup[77][3]= "Heading"
xplane_DataIdLookup[77][4]= "Left-Brake"
xplane_DataIdLookup[77][5]= "Right-Brake" 
xplane_DataIdLookup[77][6]= "" --Unused
xplane_DataIdLookup[77][7]= "" --Unused
xplane_DataIdLookup[77][8]= "" --Unused

xplane_DataIdLookup[78][0]= "Total Vertical Thrust Vectors"
xplane_DataIdLookup[79][0]= "Total lateral thrust vectors"
xplane_DataIdLookup[80][0]= "Pitch cyclic disc tilts"
xplane_DataIdLookup[81][0]= "Roll cyclic disc tilts"
xplane_DataIdLookup[82][0]= "Pitch cyclic flapping"
xplane_DataIdLookup[83][0]= "Roll cyclic flapping"
for i=0,7,1 do
  xplane_DataIdLookup[78][i+1]= "Vertical Thrust Vectors " .. i
  xplane_DataIdLookup[79][i+1]= "Lateral thrust vectors " .. i
  xplane_DataIdLookup[80][i+1]= "Pitch cyclic disc tilts " .. i
  xplane_DataIdLookup[81][i+1]= "Roll cyclic disc tilts " .. i
  xplane_DataIdLookup[82][i+1]= "Pitch cyclic flapping " .. i
  xplane_DataIdLookup[83][i+1]= "Roll cyclic flapping " .. i
end

xplane_DataIdLookup[84][0]= "Ground Effect lift (wings)"
xplane_DataIdLookup[84][1]= "Wing1 L cl*"
xplane_DataIdLookup[84][2]= "Wing1 R cl*"
xplane_DataIdLookup[84][3]= "Wing2 L cl*"
xplane_DataIdLookup[84][4]= "Wing2 R cl*"
xplane_DataIdLookup[84][5]= "Wing3 L cl*"
xplane_DataIdLookup[84][6]= "Wing3 R cl*"
xplane_DataIdLookup[84][7]= "Wing4 L cl*"
xplane_DataIdLookup[84][8]= "Wing4 R cl*"

xplane_DataIdLookup[85][0]= "Ground Effect drag (wings)"
xplane_DataIdLookup[85][1]= "Wing1 Lcdi*"
xplane_DataIdLookup[85][2]= "Wing1 Rcdi*"
xplane_DataIdLookup[85][3]= "Wing2 Lcdi*"
xplane_DataIdLookup[85][4]= "Wing2 Rcdi*"
xplane_DataIdLookup[85][5]= "Wing3 Lcdi*"
xplane_DataIdLookup[85][6]= "Wing3 Rcdi*"
xplane_DataIdLookup[85][7]= "Wing4 Lcdi*"
xplane_DataIdLookup[85][8]= "Wing4 Rcdi*"

xplane_DataIdLookup[86][0]= "Ground Effect wash (wings)"
xplane_DataIdLookup[86][1]= "Wing1 wash*"
xplane_DataIdLookup[86][2]= "Wing1 wash*"
xplane_DataIdLookup[86][3]= "Wing2 wash*"
xplane_DataIdLookup[86][4]= "Wing2 wash*"
xplane_DataIdLookup[86][5]= "Wing3 wash*"
xplane_DataIdLookup[86][6]= "Wing3 wash*"
xplane_DataIdLookup[86][7]= "Wing4 wash*"
xplane_DataIdLookup[86][8]= "Wing4 wash*"

xplane_DataIdLookup[87][0]= "Ground Effect lift (stabilisers)"
xplane_DataIdLookup[87][1]= "hstab L cl*"
xplane_DataIdLookup[87][2]= "hstab R cl*"
xplane_DataIdLookup[87][3]= "vstb1 cl*"
xplane_DataIdLookup[87][4]= "vstb2 cl*"
xplane_DataIdLookup[87][5]= "" --Unused
xplane_DataIdLookup[87][6]= "" --Unused
xplane_DataIdLookup[87][7]= "" --Unused
xplane_DataIdLookup[87][8]= "" --Unused

xplane_DataIdLookup[88][0]= "Ground Effect drag (stabilisers)"
xplane_DataIdLookup[88][1]= "hstab Lcdi*"
xplane_DataIdLookup[88][2]= "hstab Rcdi*"
xplane_DataIdLookup[88][3]= "vstb1 cdi*"
xplane_DataIdLookup[88][4]= "vstb2 cdi*"
xplane_DataIdLookup[88][5]= "" --Unused
xplane_DataIdLookup[88][6]= "" --Unused
xplane_DataIdLookup[88][7]= "" --Unused
xplane_DataIdLookup[88][8]= "" --Unused

xplane_DataIdLookup[89][0]= "Ground Effect wash (stabilisers)"
xplane_DataIdLookup[89][1]= "hstab wash*"
xplane_DataIdLookup[89][2]= "hstab wash*"
xplane_DataIdLookup[89][3]= "vstb1 wash*"
xplane_DataIdLookup[89][4]= "vstb2 wash*"
xplane_DataIdLookup[89][5]= "" --Unused
xplane_DataIdLookup[89][6]= "" --Unused
xplane_DataIdLookup[89][7]= "" --Unused
xplane_DataIdLookup[89][8]= "" --Unused

xplane_DataIdLookup[90][0]= "Wash ratio from Ground Effect (rotors)"
xplane_DataIdLookup[90][1]= "GE rotor 1 wash*"
xplane_DataIdLookup[90][2]= "GE rotor 2 wash*"
xplane_DataIdLookup[90][3]= "GE rotor 3 wash*"
xplane_DataIdLookup[90][4]= "GE rotor 4 wash*"
xplane_DataIdLookup[90][5]= "GE rotor 5 wash*"
xplane_DataIdLookup[90][6]= "GE rotor 6 wash*"
xplane_DataIdLookup[90][7]= "GE rotor 7 wash*"
xplane_DataIdLookup[90][8]= "GE rotor 8 wash*"

xplane_DataIdLookup[91][0]= "Wash ratio from Vortex Effect (rotors)"
xplane_DataIdLookup[91][1]= "VRS rotor 1 wash*"
xplane_DataIdLookup[91][2]= "VRS rotor 2 wash*"
xplane_DataIdLookup[91][3]= "VRS rotor 3 wash*"
xplane_DataIdLookup[91][4]= "VRS rotor 4 wash*"
xplane_DataIdLookup[91][5]= "VRS rotor 5 wash*"
xplane_DataIdLookup[91][6]= "VRS rotor 6 wash*"
xplane_DataIdLookup[91][7]= "VRS rotor 7 wash*"
xplane_DataIdLookup[91][8]= "VRS rotor 8 wash*"

xplane_DataIdLookup[92][0]= "Wing lift"
xplane_DataIdLookup[92][1]= "Wing1 lift"
xplane_DataIdLookup[92][2]= "Wing1 lift"
xplane_DataIdLookup[92][3]= "Wing2 lift"
xplane_DataIdLookup[92][4]= "Wing2 lift"
xplane_DataIdLookup[92][5]= "Wing3 lift"
xplane_DataIdLookup[92][6]= "Wing3 lift"
xplane_DataIdLookup[92][7]= "Wing4 lift"
xplane_DataIdLookup[92][8]= "Wing4 lift"

xplane_DataIdLookup[93][0]= "Wing drag"
xplane_DataIdLookup[93][1]= "Wing1 drag"
xplane_DataIdLookup[93][2]= "Wing1 drag"
xplane_DataIdLookup[93][3]= "Wing2 drag"
xplane_DataIdLookup[93][4]= "Wing2 drag"
xplane_DataIdLookup[93][5]= "Wing3 drag"
xplane_DataIdLookup[93][6]= "Wing3 drag"
xplane_DataIdLookup[93][7]= "Wing4 drag"
xplane_DataIdLookup[93][8]= "Wing4 drag"

xplane_DataIdLookup[94][0]= "Stabilizer lift"
xplane_DataIdLookup[94][1]= "hstab lift"
xplane_DataIdLookup[94][2]= "hstab lift"
xplane_DataIdLookup[94][3]= "vstb1 lift"
xplane_DataIdLookup[94][4]= "vstb2 lift"
xplane_DataIdLookup[94][5]= "" --Unused
xplane_DataIdLookup[94][6]= "" --Unused
xplane_DataIdLookup[94][7]= "" --Unused
xplane_DataIdLookup[94][8]= "" --Unused

xplane_DataIdLookup[95][0]= "Stabilizer drag"
xplane_DataIdLookup[95][1]= "hstab drag"
xplane_DataIdLookup[95][2]= "hstab drag"
xplane_DataIdLookup[95][3]= "vstb1 drag"
xplane_DataIdLookup[95][4]= "vstb2 drag"
xplane_DataIdLookup[95][5]= ""
xplane_DataIdLookup[95][6]= ""
xplane_DataIdLookup[95][7]= ""
xplane_DataIdLookup[95][8]= ""

xplane_DataIdLookup[96][0]= "COM1 and COM2 radio freqs"
xplane_DataIdLookup[96][1]= "COM1 Active"
xplane_DataIdLookup[96][2]= "COM1 Standby"
xplane_DataIdLookup[96][3]= "" -- Unused
xplane_DataIdLookup[96][4]= "COM2 Active"
xplane_DataIdLookup[96][5]= "COM2 Standby"
xplane_DataIdLookup[96][6]= "" --Unused
xplane_DataIdLookup[96][7]= "Transmit Status"
xplane_DataIdLookup[96][8]= "" --Unused

xplane_DataIdLookup[97][0]= "NAV1 and NAV2 radio freqs"
xplane_DataIdLookup[97][1]= "NAV1 Active"
xplane_DataIdLookup[97][2]= "NAV1 Standby"
xplane_DataIdLookup[97][3]= "NAV1 Type"
xplane_DataIdLookup[97][4]= "" --Unused
xplane_DataIdLookup[97][5]= "NAV2 Active"
xplane_DataIdLookup[97][6]= "NAV2 Standby"
xplane_DataIdLookup[97][7]= "NAV2 Type"
xplane_DataIdLookup[97][8]= "" --Unused

xplane_DataIdLookup[98][0]= "NAV1 and NAV2 OBS"
xplane_DataIdLookup[98][1]= "NAV1 OBS"
xplane_DataIdLookup[98][2]= "NAV1 s-crs"
xplane_DataIdLookup[98][3]= "NAV1 flag"
xplane_DataIdLookup[98][4]= "" --Unused
xplane_DataIdLookup[98][5]= "NAV2 OBS"
xplane_DataIdLookup[98][6]= "NAV2 s-crs"
xplane_DataIdLookup[98][7]= "NAV2 flag"
xplane_DataIdLookup[98][8]= ""

xplane_DataIdLookup[99][0]= "NAV1 deflection"
xplane_DataIdLookup[99][1]= "NAV1 n-typ"
xplane_DataIdLookup[99][2]= "NAV1 to-fr"
xplane_DataIdLookup[99][3]= "NAV1 m-crs"
xplane_DataIdLookup[99][4]= "NAV1 r-brg"
xplane_DataIdLookup[99][5]= "NAV1 dme-d"
xplane_DataIdLookup[99][6]= "NAV1 h-def"
xplane_DataIdLookup[99][7]= "NAV1 v-def"
xplane_DataIdLookup[99][8]= "" --Unused

xplane_DataIdLookup[100][0]= "NAV2 deflection"
xplane_DataIdLookup[100][1]= "NAV2 n-typ"
xplane_DataIdLookup[100][2]= "NAV2 to-fr"
xplane_DataIdLookup[100][3]= "NAV2 m-crs"
xplane_DataIdLookup[100][4]= "NAV2 r-brg"
xplane_DataIdLookup[100][5]= "NAV2 dme-d"
xplane_DataIdLookup[100][6]= "NAV2 h-def"
xplane_DataIdLookup[100][7]= "NAV2 v-def"
xplane_DataIdLookup[100][8]= "" --Unused

xplane_DataIdLookup[101][0]= "ADF1 and ADF2 statuses"
xplane_DataIdLookup[101][1]= "ACF1 frequency"
xplane_DataIdLookup[101][2]= "ADF1 card"
xplane_DataIdLookup[101][3]= "ADF1 r-brg"
xplane_DataIdLookup[101][4]= "ADF1 n-typ"
xplane_DataIdLookup[101][5]= "ACF2 frequency"
xplane_DataIdLookup[101][6]= "ADF2 card"
xplane_DataIdLookup[101][7]= "ADF2 r-brg"
xplane_DataIdLookup[101][8]= "ADF2 n-typ"

xplane_DataIdLookup[102][0]= "DME status"
xplane_DataIdLookup[102][1]= "DME nav01"
xplane_DataIdLookup[102][2]= "DME mode"
xplane_DataIdLookup[102][3]= "DME found"
xplane_DataIdLookup[102][4]= "DME dist"
xplane_DataIdLookup[102][5]= "DME speed"
xplane_DataIdLookup[102][6]= "DME time"
xplane_DataIdLookup[102][7]= "DME n-typ"
xplane_DataIdLookup[102][8]= "DME-3 freq"

xplane_DataIdLookup[103][0]= "GPS status"
xplane_DataIdLookup[103][1]= "GPS mode"
xplane_DataIdLookup[103][2]= "GPS index"
xplane_DataIdLookup[103][3]= "GPS dist - nm"
xplane_DataIdLookup[103][4]= "OSB mag"
xplane_DataIdLookup[103][5]= "crs mag"
xplane_DataIdLookup[103][6]= "rel brng"
xplane_DataIdLookup[103][7]= "hdef dots"
xplane_DataIdLookup[103][8]= "vdef dots"

xplane_DataIdLookup[104][0]= "Transponder status"
xplane_DataIdLookup[104][1]= "trans mode"
xplane_DataIdLookup[104][2]= "trans sett"
xplane_DataIdLookup[104][3]= "trans ID"
xplane_DataIdLookup[104][4]= "trans inter"
xplane_DataIdLookup[104][5]= "" --Unused
xplane_DataIdLookup[104][6]= "" --Unused
xplane_DataIdLookup[104][7]= "" --Unused
xplane_DataIdLookup[104][8]= "" --Unused

xplane_DataIdLookup[105][0]= "Marker staus"
xplane_DataIdLookup[105][1]= "Outer Marker - morse"
xplane_DataIdLookup[105][2]= "Middle Marker - morse"
xplane_DataIdLookup[105][3]= "Inner Marker - morse"
xplane_DataIdLookup[105][4]= "audio - active"
xplane_DataIdLookup[105][5]= "" --Unused
xplane_DataIdLookup[105][6]= "" --Unused
xplane_DataIdLookup[105][7]= "" --Unused
xplane_DataIdLookup[105][8]= "" --Unused

xplane_DataIdLookup[106][0]= "Electrical switches"
xplane_DataIdLookup[106][1]= "avio 0/1"
xplane_DataIdLookup[106][2]= "Navigation Lights (0/1)"
xplane_DataIdLookup[106][3]= "Beacon Light (0/1)"
xplane_DataIdLookup[106][4]= "Strob Light (0/1)"
xplane_DataIdLookup[106][5]= "Landing Lights (0/1)"
xplane_DataIdLookup[106][6]= "Taxi Lights (0/1)"
xplane_DataIdLookup[106][7]= "" --Unused
xplane_DataIdLookup[106][8]= "" --Unused

xplane_DataIdLookup[107][0]= "EFIS switches"
xplane_DataIdLookup[107][1]= "ECAM mode`"
xplane_DataIdLookup[107][2]= "EFIS sel 1"
xplane_DataIdLookup[107][3]= "EFIS sel 2"
xplane_DataIdLookup[107][4]= "HSI sel 1"
xplane_DataIdLookup[107][5]= "HSI sel 2"
xplane_DataIdLookup[107][6]= "HSI arc"
xplane_DataIdLookup[107][7]= "map r-sel"
xplane_DataIdLookup[107][8]= "map range"

xplane_DataIdLookup[108][0]= "AP, FD, HUD switches"
xplane_DataIdLookup[108][1]= "Ap - src"
xplane_DataIdLookup[108][2]= "fdir - mode"
xplane_DataIdLookup[108][3]= "fdir - ptch"
xplane_DataIdLookup[108][4]= "fdir - roll"
xplane_DataIdLookup[108][5]= "" --Unused
xplane_DataIdLookup[108][6]= "HUD power"
xplane_DataIdLookup[108][7]= "HUD brite"
xplane_DataIdLookup[108][8]= "" --Unused

xplane_DataIdLookup[109][0]= "Anti-ice switches"
xplane_DataIdLookup[109][1]= "deice - all"
xplane_DataIdLookup[109][2]= "deice inlet"
xplane_DataIdLookup[109][3]= "deice prop"
xplane_DataIdLookup[109][4]= "deice windo"
xplane_DataIdLookup[109][5]= "deice pito1"
xplane_DataIdLookup[109][6]= "deice piot2"
xplane_DataIdLookup[109][7]= "deice AoA"
xplane_DataIdLookup[109][8]= "devie wing"

xplane_DataIdLookup[110][0]= "Anti-ice and fuel switches"
xplane_DataIdLookup[110][1]= "alt air0"
xplane_DataIdLookup[110][2]= "alt air1"
xplane_DataIdLookup[110][3]= "auto ignit"
xplane_DataIdLookup[110][4]= "audo ignit"
xplane_DataIdLookup[110][5]= "manul ignit"
xplane_DataIdLookup[110][6]= "manul ignit"
xplane_DataIdLookup[110][7]= "l-eng tank"
xplane_DataIdLookup[110][8]= "r-eng tank"

xplane_DataIdLookup[111][0]= "Clutch and artificial stability switches"
xplane_DataIdLookup[111][1]= "prero engag"
xplane_DataIdLookup[111][2]= "prero level"
xplane_DataIdLookup[111][3]= "clutc ratio"
xplane_DataIdLookup[111][4]= "" --Unused
xplane_DataIdLookup[111][5]= "art pitch"
xplane_DataIdLookup[111][6]= "art roll"
xplane_DataIdLookup[111][7]= "yaw damp"
xplane_DataIdLookup[111][8]= "auto brake"

xplane_DataIdLookup[112][0]= "Misc switches"
xplane_DataIdLookup[112][1]= "tot energ"
xplane_DataIdLookup[112][2]= "radal feet"
xplane_DataIdLookup[112][3]= "prop sync"
xplane_DataIdLookup[112][4]= "fethr mode"
xplane_DataIdLookup[112][5]= "puffr power"
xplane_DataIdLookup[112][6]= "water scoop"
xplane_DataIdLookup[112][7]= "arrst hook"
xplane_DataIdLookup[112][8]= "chute deply"

xplane_DataIdLookup[113][0]= "Gen. Annunciations 1"
xplane_DataIdLookup[113][1]= "mast cau"
xplane_DataIdLookup[113][2]= "mast wat"
xplane_DataIdLookup[113][3]= "masy accp"
xplane_DataIdLookup[113][4]= "auto disco"
xplane_DataIdLookup[113][5]= "low vacum"
xplane_DataIdLookup[113][6]= "low volt"
xplane_DataIdLookup[113][7]= "fuel quant"
xplane_DataIdLookup[113][8]= "hyd press"

xplane_DataIdLookup[114][0]= "Gen. Annunciations 2"
xplane_DataIdLookup[114][1]= "yawda on"
xplane_DataIdLookup[114][2]= "sbrk on"
xplane_DataIdLookup[114][3]= "GPWS warn"
xplane_DataIdLookup[114][4]= "ice warn"
xplane_DataIdLookup[114][5]= "pitot off"
xplane_DataIdLookup[114][6]= "cabin althi"
xplane_DataIdLookup[114][7]= "afthr arm"
xplane_DataIdLookup[114][8]= "osps time"

xplane_DataIdLookup[115][0]= "Engine annunciations"
xplane_DataIdLookup[115][1]= "fuel press"
xplane_DataIdLookup[115][2]= "oil press"
xplane_DataIdLookup[115][3]= "oil temp"
xplane_DataIdLookup[115][4]= "inver warn"
xplane_DataIdLookup[115][5]= "gener warn"
xplane_DataIdLookup[115][6]= "chip detec"
xplane_DataIdLookup[115][7]= "engin fire"
xplane_DataIdLookup[115][8]= "ignit 0/1"

xplane_DataIdLookup[116][0]= "Autopilot armed status"
xplane_DataIdLookup[116][1]= "nav arm"
xplane_DataIdLookup[116][2]= "alt arm"
xplane_DataIdLookup[116][3]= "app arm"
xplane_DataIdLookup[116][4]= "vnav enab"
xplane_DataIdLookup[116][5]= "vnav warn"
xplane_DataIdLookup[116][6]= "vnav time"
xplane_DataIdLookup[116][7]= "gp enabl"
xplane_DataIdLookup[116][8]= ""

xplane_DataIdLookup[117][0]= "Autopilot modes"
xplane_DataIdLookup[117][1]= "auto throt"
xplane_DataIdLookup[117][2]= "mode hding"
xplane_DataIdLookup[117][3]= "mode alt"
xplane_DataIdLookup[117][4]= ""
xplane_DataIdLookup[117][5]= "bac 0/1"
xplane_DataIdLookup[117][6]= "app"
xplane_DataIdLookup[117][7]= ""
xplane_DataIdLookup[117][8]= "sync butn"

xplane_DataIdLookup[118][0]= "Autopilot values"
xplane_DataIdLookup[118][1]= "set speed"
xplane_DataIdLookup[118][2]= "set hding"
xplane_DataIdLookup[118][3]= "set vvi"
xplane_DataIdLookup[118][4]= "dial alt"
xplane_DataIdLookup[118][5]= "bac vnav alt"
xplane_DataIdLookup[118][6]= "use alt"
xplane_DataIdLookup[118][7]= "sync roll"
xplane_DataIdLookup[118][8]= "sync pitch"

xplane_DataIdLookup[119][0]= "Weapon status"
xplane_DataIdLookup[119][1]= "hdng delta"
xplane_DataIdLookup[119][2]= "ptch delta"
xplane_DataIdLookup[119][3]= "R d/sec"
xplane_DataIdLookup[119][4]= "Q d/sec"
xplane_DataIdLookup[119][5]= "rudd ratio"
xplane_DataIdLookup[119][6]= "elev ratio"
xplane_DataIdLookup[119][7]= "V kts"
xplane_DataIdLookup[119][8]= "dis ft"

xplane_DataIdLookup[120][0]= "Pressurization status"
xplane_DataIdLookup[120][1]= "set alt"
xplane_DataIdLookup[120][2]= "set vvi"
xplane_DataIdLookup[120][3]= "cabin alt"
xplane_DataIdLookup[120][4]= "cabin vvi"
xplane_DataIdLookup[120][5]= "test time"
xplane_DataIdLookup[120][6]= "diff psi"
xplane_DataIdLookup[120][7]= "dump all"
xplane_DataIdLookup[120][8]= "bleed src"

xplane_DataIdLookup[121][0]= "APU and GPU status"
xplane_DataIdLookup[121][1]= "APU runng"
xplane_DataIdLookup[121][2]= "APU N1"
xplane_DataIdLookup[121][3]= "APU rat"
xplane_DataIdLookup[121][4]= "GPU rat"
xplane_DataIdLookup[121][5]= "RAT rat"
xplane_DataIdLookup[121][6]= "APU amp"
xplane_DataIdLookup[121][7]= "GPU amp"
xplane_DataIdLookup[121][8]= "RAT amp"

xplane_DataIdLookup[122][0]= "Radar status"
xplane_DataIdLookup[122][1]= "targ select"
xplane_DataIdLookup[122][2]= "" --Unused
xplane_DataIdLookup[122][3]= "" --Unused
xplane_DataIdLookup[122][4]= "" --Unused
xplane_DataIdLookup[122][5]= "" --Unused
xplane_DataIdLookup[122][6]= "" --Unused
xplane_DataIdLookup[122][7]= "" --Unused
xplane_DataIdLookup[122][8]= "" --Unused

xplane_DataIdLookup[123][0]= "Hydraulic status"
xplane_DataIdLookup[123][1]= "eng-1 pump"
xplane_DataIdLookup[123][2]= "eng-2 pump"
xplane_DataIdLookup[123][3]= "ele pum"
xplane_DataIdLookup[123][4]= "RA pum"
xplane_DataIdLookup[123][5]= "hyd qty"
xplane_DataIdLookup[123][6]= "hyd qty"
xplane_DataIdLookup[123][7]= "hyd pres"
xplane_DataIdLookup[123][8]= "hyd pres"

xplane_DataIdLookup[124][0]= "Electrical and solar systems"
xplane_DataIdLookup[124][1]= "bus1 volt"
xplane_DataIdLookup[124][2]= "bus2 volt"
xplane_DataIdLookup[124][3]= "bus1 amp"
xplane_DataIdLookup[124][4]= "bus2 amp"
xplane_DataIdLookup[124][5]= "batt1 w-hr"
xplane_DataIdLookup[124][6]= "batt2 w-hr"
xplane_DataIdLookup[124][7]= "engin in W"
xplane_DataIdLookup[124][8]= "solar out W"

xplane_DataIdLookup[125][0]= "Icing status 1"
xplane_DataIdLookup[125][1]= "inlet ice"
xplane_DataIdLookup[125][2]= "inlet ine"
xplane_DataIdLookup[125][3]= "prop ice"
xplane_DataIdLookup[125][4]= "prop ice"
xplane_DataIdLookup[125][5]= "pitot ice"
xplane_DataIdLookup[125][6]= "pitot ice"
xplane_DataIdLookup[125][7]= "statc ice"
xplane_DataIdLookup[125][8]= "statc ice"

xplane_DataIdLookup[126][0]= "Icing status 2"
xplane_DataIdLookup[126][1]= "aoa ice"
xplane_DataIdLookup[126][2]= "aoa ice"
xplane_DataIdLookup[126][3]= "lwing ice"
xplane_DataIdLookup[126][4]= "rwing ice"
xplane_DataIdLookup[126][5]= "windo ice"
xplane_DataIdLookup[126][6]= "" --Unused
xplane_DataIdLookup[126][7]= "carb1 ice"
xplane_DataIdLookup[126][8]= "carb2 ice"

xplane_DataIdLookup[127][0]= "Warning status"
xplane_DataIdLookup[127][1]= "warn time"
xplane_DataIdLookup[127][2]= "caut time"
xplane_DataIdLookup[127][3]= "warn work"
xplane_DataIdLookup[127][4]= "caut work"
xplane_DataIdLookup[127][5]= "gear work"
xplane_DataIdLookup[127][6]= "gear warn"
xplane_DataIdLookup[127][7]= "stall warn"
xplane_DataIdLookup[127][8]= ""

xplane_DataIdLookup[128][0]= "Flight plan legs"
xplane_DataIdLookup[128][1]= "leg #"
xplane_DataIdLookup[128][2]= "leg type"
xplane_DataIdLookup[128][3]= "leg lat"
xplane_DataIdLookup[128][4]= "leg long"
xplane_DataIdLookup[128][5]= "" --Unused
xplane_DataIdLookup[128][6]= "" --Unused
xplane_DataIdLookup[128][7]= "" --Unused
xplane_DataIdLookup[128][8]= "" --Unused

xplane_DataIdLookup[129][0]= "Hardware options"
xplane_DataIdLookup[129][1]= "pedal nobrk"
xplane_DataIdLookup[129][2]= "pedal wibrk"
xplane_DataIdLookup[129][3]= "yoke pfc"
xplane_DataIdLookup[129][4]= "pedal pfc"
xplane_DataIdLookup[129][5]= "throt pfc"
xplane_DataIdLookup[129][6]= "cecon pfc"
xplane_DataIdLookup[129][7]= "switc pfc"
xplane_DataIdLookup[129][8]= "btogg pfc"

xplane_DataIdLookup[130][0]= "Camera location"
xplane_DataIdLookup[130][1]= "camra long"
xplane_DataIdLookup[130][2]= "camra lat"
xplane_DataIdLookup[130][3]= "camra ele"
xplane_DataIdLookup[130][4]= "camra hdng"
xplane_DataIdLookup[130][5]= "camra pitch"
xplane_DataIdLookup[130][6]= "camra roll"
xplane_DataIdLookup[130][7]= "" --Unused
xplane_DataIdLookup[130][8]= "camra clou"

xplane_DataIdLookup[131][0]= "Ground location"
xplane_DataIdLookup[131][1]= "" --Unused
xplane_DataIdLookup[131][2]= "" --Unused
xplane_DataIdLookup[131][3]= "" --Unused
xplane_DataIdLookup[131][4]= "" --Unused
xplane_DataIdLookup[131][5]= "" --Unused
xplane_DataIdLookup[131][6]= "" --Unused
xplane_DataIdLookup[131][7]= "" --Unused
xplane_DataIdLookup[131][8]= "" --Unused

xplane_DataIdLookup[132][0]= "Climb stats"
xplane_DataIdLookup[132][1]= "h-spd kt"
xplane_DataIdLookup[132][2]= "v-spd fpm"
xplane_DataIdLookup[132][3]= "" --Unused
xplane_DataIdLookup[132][4]= "mult VxVVI"
xplane_DataIdLookup[132][5]= "" --Unused
xplane_DataIdLookup[132][6]= "" --Unused
xplane_DataIdLookup[132][7]= "" --Unused
xplane_DataIdLookup[132][8]= "" --Unused

xplane_DataIdLookup[133][0]= "Cruise stats"
xplane_DataIdLookup[133][1]= "ff pph"
xplane_DataIdLookup[133][2]= "ff gph"
xplane_DataIdLookup[133][3]= "speed mph"
xplane_DataIdLookup[133][4]= "eta smpg"
xplane_DataIdLookup[133][5]= "etc nm/lb"
xplane_DataIdLookup[133][6]= "range sm"
xplane_DataIdLookup[133][7]= "endur hours"
xplane_DataIdLookup[133][8]= "mult VxMPG"

xplane_DataIdLookup[134][0]= "Landing gear steering"
xplane_DataIdLookup[134][1]= "Gear 1 deg"
xplane_DataIdLookup[134][2]= "Gear 2 deg"
xplane_DataIdLookup[134][3]= "Gear 3 deg"
xplane_DataIdLookup[134][4]= "Gear 4 deg"
xplane_DataIdLookup[134][5]= "Gear 5 deg"
xplane_DataIdLookup[134][6]= "Gear 6 deg"
xplane_DataIdLookup[134][7]= "Gear 7 deg"
xplane_DataIdLookup[134][8]= "Gear 8 deg"

xplane_DataIdLookup[135][0]= "Motion platform stats"
xplane_DataIdLookup[135][1]= "acc-x m/ss"
xplane_DataIdLookup[135][2]= "acc-y m/ss"
xplane_DataIdLookup[135][3]= "acc-z m/ss"
xplane_DataIdLookup[135][4]= "P rad/s"
xplane_DataIdLookup[135][5]= "Q rad/s"
xplane_DataIdLookup[135][6]= "R rad/s"
xplane_DataIdLookup[135][7]= "" --Unused
xplane_DataIdLookup[135][8]= "" --Unused

xplane_DataIdLookup[136][0]= "Joystick Raw Axis Deflections"
xplane_DataIdLookup[136][1]= "axis1 ratio"
xplane_DataIdLookup[136][2]= "axis2 ratio"
xplane_DataIdLookup[136][3]= "axis3 ratio"
xplane_DataIdLookup[136][4]= "axis4 ratio"
xplane_DataIdLookup[136][5]= "axis5 ratio"
xplane_DataIdLookup[136][6]= "axis6 ratio"
xplane_DataIdLookup[136][7]= "axis7 ratio"
xplane_DataIdLookup[136][8]= "axis8 ratio"

xplane_DataIdLookup[137][0]= "Gear forces"
xplane_DataIdLookup[137][1]= "norm lb"
xplane_DataIdLookup[137][2]= "axial lb"
xplane_DataIdLookup[137][3]= "side lb"
xplane_DataIdLookup[137][4]= "L lb-ft"
xplane_DataIdLookup[137][5]= "M lb-ft"
xplane_DataIdLookup[137][6]= "N lb-ft"
xplane_DataIdLookup[137][7]= "" --Unused
xplane_DataIdLookup[137][8]= "" --Unused

xplane_DataIdLookup[138][0]= "Servo Aileron / Elevator / Rudder"
xplane_DataIdLookup[138][1]= "elev servo"
xplane_DataIdLookup[138][2]= "ailrn servo"
xplane_DataIdLookup[138][3]= "ruddr servo"
xplane_DataIdLookup[138][4]= "" --Unused
xplane_DataIdLookup[138][5]= "" --Unused
xplane_DataIdLookup[138][6]= "" --Unused
xplane_DataIdLookup[138][7]= "" --Unused
xplane_DataIdLookup[138][8]= "" --Unused

xplane.fields.acfn_header = ProtoField.string("xplane.acfn","Header")
xplane.fields.acfn_index = ProtoField.int32("xplane.acfn.index","Index")
xplane.fields.acfn_path = ProtoField.string("xplane.acfn.path","Path")
xplane.fields.acfn_livery = ProtoField.int32("xplane.acfn.livery","Livery")

xplane.fields.acpr_header = ProtoField.string("xplane.acpr","Header")
xplane.fields.acpr_index = ProtoField.int32("xplane.acpr.index","Index")
xplane.fields.acpr_path = ProtoField.string("xplane.acpr.path","Path")
xplane.fields.acpr_livery = ProtoField.int32("xplane.acpr.livery","Livery")
xplane.fields.acpr_starttype = ProtoField.int32("xplane.acpr.starttype","Start Type",base.DEC,VALS_StartType)
xplane.fields.acpr_aircraftindex = ProtoField.int32("xplane.acpr.aircraftindex","Aircraft Index")
xplane.fields.acpr_ICAO = ProtoField.string("xplane.acpr.ICAO","ICAO")
xplane.fields.acpr_runwayindex = ProtoField.int32("xplane.acpr.runwayindex","Runway Index")
xplane.fields.acpr_runwaydirection = ProtoField.int32("xplane.acpr.runwaydirection","Runway Direction")
xplane.fields.acpr_latitude = ProtoField.double("xplane.acpr.latitude","Latitude")
xplane.fields.acpr_longitude = ProtoField.double("xplane.acpr.longitude","Longitude")
xplane.fields.acpr_elevation = ProtoField.double("xplane.acpr.elevation","Elevation")
xplane.fields.acpr_trueheading = ProtoField.double("xplane.acpr.trueheading","True Heading")
xplane.fields.acpr_speed = ProtoField.double("xplane.acpr.speed","Speed")

xplane.fields.alrt_header = ProtoField.string("xplane.alrt","Header")
xplane.fields.alrt_line1 = ProtoField.string("xplane.alrt.line1","Line 1")
xplane.fields.alrt_line2 = ProtoField.string("xplane.alrt.line2","Line 2")
xplane.fields.alrt_line3 = ProtoField.string("xplane.alrt.line3","Line 3")
xplane.fields.alrt_line4 = ProtoField.string("xplane.alrt.line4","Line 4")

xplane.fields.becn_header = ProtoField.string("xplane.becn", "Header")
xplane.fields.becn_major = ProtoField.uint8("xplane.becn.major", "Major Version")
xplane.fields.becn_minor = ProtoField.uint8("xplane.becn.minor", "Minor Version")
xplane.fields.becn_appid = ProtoField.int32("xplane.becn.appid", "Host ID")
xplane.fields.becn_version = ProtoField.int32("xplane.becn.version", "Version Number")
xplane.fields.becn_role = ProtoField.uint32("xplane.becn.role", "Role", base.DEC, VALS_BECN_MachineRole)
xplane.fields.becn_port = ProtoField.uint16("xplane.becn.port", "Port")
xplane.fields.becn_name = ProtoField.string("xplane.becn.name", "Computer Name")
xplane.fields.becn_newport = ProtoField.uint16("xplane.becn.newport", "New Port")

xplane.fields.cmnd_header = ProtoField.string("xplane.cmnd","Header")
xplane.fields.cmnd_command = ProtoField.string("xplane.cmnd.command","Command")

xplane.fields.data_header = ProtoField.string("xplane.data","Header")
xplane.fields.data_id = ProtoField.float("xplane.data.id","ID")
xplane.fields.data_value = ProtoField.float("xplane.data.value","Value")

xplane.fields.dcoc_header = ProtoField.string("xplane.dcoc","Header")
xplane.fields.dcoc_id = ProtoField.int32("xplane.dcoc.id","ID")

xplane.fields.dref_header = ProtoField.string("xplane.dref","Header")
xplane.fields.dref_value = ProtoField.float("xplane.dref.value","Value")
xplane.fields.dref_dataref = ProtoField.string("xplane.dref.dataref","DataRef")

xplane.fields.dsel_header = ProtoField.string("xplane.dsel","Header")
xplane.fields.dsel_id = ProtoField.int32("xplane.dsel.id","ID")

xplane.fields.fail_header = ProtoField.string("xplane.fail","Header")
xplane.fields.fail_id = ProtoField.string("xplane.fail.id","System ID")

xplane.fields.flir_in_header = ProtoField.string("xplane.flir","Header")
xplane.fields.flir_in_framerate = ProtoField.string("xplane.flir.framerate","Frame Rate")

xplane.fields.flir_out_header = ProtoField.string("xplane.flir", "Infra-red image data)")
xplane.fields.flir_out_height = ProtoField.int16("xp11in.flir.height","Height")
xplane.fields.flir_out_width = ProtoField.int16("xp11in.flir.width","Width")
xplane.fields.flir_out_frameindex = ProtoField.char("xp11in.flir.frameindex","Frame Index")
xplane.fields.flir_out_framecount = ProtoField.char("xp11in.flir.framecount","Frame Count")
xplane.fields.flir_out_imagedata = ProtoField.none("Xp11.flir.imagedata","Image Data (DXT1 Encoded)")

xplane.fields.ise4_header = ProtoField.string("xplane.ise4","Header")
xplane.fields.ise4_machinetype = ProtoField.int32("xplane.ise4.machinetpye","Machine Type", base.DEC,VALS_ISEx_MachineType)
xplane.fields.ise4_address = ProtoField.string("xplane.ise4.address","IP Address")
xplane.fields.ise4_port = ProtoField.string("xplane.ise4.port","Port")
xplane.fields.ise4_useip = ProtoField.int32("xplane.ise4.useip","Enabled")

xplane.fields.ise6_header = ProtoField.string("xplane.ise6","Header")
xplane.fields.ise6_machinetype = ProtoField.int32("xplane.ise6.machinetpye","Machine Type", base.DEC, VALS_ISEx_MachineType)
xplane.fields.ise6_address = ProtoField.string("xplane.ise6.address","IP Address")
xplane.fields.ise6_port = ProtoField.string("xplane.ise6.port","Port")
xplane.fields.ise6_useip = ProtoField.int32("xplane.ise6.useip","Enabled")

xplane.fields.lsnd_header = ProtoField.string("xplane.lsnd","Header")
xplane.fields.lsnd_index = ProtoField.int32("xplane.lsnd.index","Index (0-4)")
xplane.fields.lsnd_speed = ProtoField.float("xplane.lsnd.speed","Relative Speed (0->1)")
xplane.fields.lsnd_volume = ProtoField.float("xplane.lsnd.volume","Relative Volume (0->1")
xplane.fields.lsnd_filename = ProtoField.string("xplane.lsnd.filename","Filename")

xplane.fields.nfal_header = ProtoField.string("xplane.nfal","Header")
xplane.fields.nfal_navaidcode = ProtoField.string("xplane.nfal.navaidcode","Nav Aid Code")

xplane.fields.nrec_header = ProtoField.string("xplane.nrec","Header")
xplane.fields.nrec_navaidcode = ProtoField.string("xplane.nrec.navaidcode","Nav Aid Code")

xplane.fields.objl_header = ProtoField.string("xplane.objl","Header")
xplane.fields.objl_index = ProtoField.int32("xplane.objl.index","Index")
xplane.fields.objl_latitude = ProtoField.double("xplane.objl.latitude","Latitude")
xplane.fields.objl_longitude = ProtoField.double("xplane.objl.longitude","Longitude")
xplane.fields.objl_elevation = ProtoField.double("xplane.objl.elevation","Elevation")
xplane.fields.objl_psi = ProtoField.float("xplane.objl.psi","True Heading")
xplane.fields.objl_theta = ProtoField.float("xplane.objl.theta","Pitch")
xplane.fields.objl_phi = ProtoField.float("xplane.objl.phi","Roll")
xplane.fields.objl_onground = ProtoField.int32("xplane.objl.onground","Is On Ground")
xplane.fields.objl_smokesize = ProtoField.float("xplane.objl.smokesize","Smoke Size")

xplane.fields.objn_header = ProtoField.string("xplane.objn","Header")
xplane.fields.objn_index = ProtoField.int32("xplane.objn.index","Index")
xplane.fields.objn_filename = ProtoField.string("xplane.objn.filename","Filename")

xplane.fields.prel_header = ProtoField.string("xplane.prel","Header")
xplane.fields.prel_starttype = ProtoField.int32("xplane.prel.starttype","Start Type",base.DEC,VALS_StartType)
xplane.fields.prel_aircraftindex = ProtoField.int32("xplane.prel.aircraftindex","Aircraft Index")
xplane.fields.prel_ICAO = ProtoField.string("xplane.prel.ICAO","ICAO")
xplane.fields.prel_runwayindex = ProtoField.int32("xplane.prel.runwayindex","Runway Index")
xplane.fields.prel_runwaydirection = ProtoField.int32("xplane.prel.runwaydirection","Runway Direction")
xplane.fields.prel_latitude = ProtoField.double("xplane.prel.latitude","Latitude")
xplane.fields.prel_longitude = ProtoField.double("xplane.prel.longitude","Longitude")
xplane.fields.prel_elevation = ProtoField.double("xplane.prel.elevation","Elevation")
xplane.fields.prel_trueheading = ProtoField.double("xplane.prel.trueheading","True Heading")
xplane.fields.prel_speed = ProtoField.double("xplane.prel.speed","Speed")

xplane.fields.quit_header = ProtoField.string("xplane.quit","Header")

xplane.fields.radr_in_header = ProtoField.string("xplane.radr","Header")
xplane.fields.radr_in_pointcount = ProtoField.string("xplane.rpos.pointcount","Points Per Frame")

xplane.fields.radr_out_header = ProtoField.string("xplane.radr", "Header")
xplane.fields.radr_out_longitude = ProtoField.float("xplane.radr.longitude", "Longitude")
xplane.fields.radr_out_latitude = ProtoField.float("xplane.radr.latitude", "Latitude")
xplane.fields.radr_out_precipitation = ProtoField.int8("xplane.radr.precipitation", "Precipitation")
xplane.fields.radr_out_height = ProtoField.float("xplane.radr.height", "Storm Top")

xplane.fields.reco_header = ProtoField.string("xplane.reco","Header")
xplane.fields.reco_systemid = ProtoField.string("xplane.reco.systemid","System ID")

xplane.fields.rese_header = ProtoField.string("xplane.rese","Header")

xplane.fields.rpos_in_header = ProtoField.string("xplane.rpos","Header")
xplane.fields.rpos_in_frequency = ProtoField.string("xplane.rpos.frequency","Frequency")

xplane.fields.rpos_out_header = ProtoField.string("xplane.rpos", "Header")
xplane.fields.rpos_out_longitude = ProtoField.double("xplane.rpos.longitude", "Longitude")
xplane.fields.rpos_out_latitude = ProtoField.double("xplane.rpos.latitude", "Latitude")
xplane.fields.rpos_out_elevation = ProtoField.double("xplane.rpos.elevation", "Altitude (metres above mean sea level)")
xplane.fields.rpos_out_height = ProtoField.float("xplane.rpos.height", "Height (metres above ground)")
xplane.fields.rpos_out_theta = ProtoField.float("xplane.rpos.theta", "Pitch (degrees)")
xplane.fields.rpos_out_psi = ProtoField.float("xplane.rpos.psi", "True Heading (degrees)")
xplane.fields.rpos_out_phi = ProtoField.float("xplane.rpos.phi", "Roll (degrees)")
xplane.fields.rpos_out_vx = ProtoField.float("xplane.rpos.vx", "Velocity (east)")
xplane.fields.rpos_out_vy = ProtoField.float("xplane.rpos.vy", "Velocity (vertical)")
xplane.fields.rpos_out_vz = ProtoField.float("xplane.rpos.vz", "Velocity (south)")
xplane.fields.rpos_out_rollrate = ProtoField.float("xplane.rpos.rollrate", "Roll Rate")
xplane.fields.rpos_out_pitchrate = ProtoField.float("xplane.rpos.pitchrate", "Pitch Rate")
xplane.fields.rpos_out_yawrate = ProtoField.float("xplane.rpos.yawrate", "Yaw Rate")

xplane.fields.rref_in_header = ProtoField.string("xplane.rref","Header")
xplane.fields.rref_in_frequency = ProtoField.int32("xplane.rref.value", "Value")
xplane.fields.rref_in_id = ProtoField.int32("xplane.rref.id", "RREF ID")
xplane.fields.rref_in_dataref = ProtoField.string("xplane.rref.dataref","DataRef")

xplane.fields.rref_out_header = ProtoField.string("xplane.rref", "Header")
xplane.fields.rref_out_id = ProtoField.int32("xplane.rref.id", "RREF ID")
xplane.fields.rref_out_value = ProtoField.float("xplane.rref.value", "Value")

xplane.fields.shut_header = ProtoField.string("xplane.shut","Header")

xplane.fields.simo_header = ProtoField.string("xplane.simo","Header")
xplane.fields.simo_action = ProtoField.int32("xplane.simo.action","ActionID", base.DEC, VALS_Situation)
xplane.fields.simo_filename = ProtoField.string("xplane.simo.filename","Filename")

xplane.fields.soun_header = ProtoField.string("xplane.soun","Header")
xplane.fields.soun_speed = ProtoField.float("xplane.soun.speed","Relative Speed (0->1)")
xplane.fields.soun_volume = ProtoField.float("xplane.soun.volume","Relative Volume (0->1)")
xplane.fields.soun_filename = ProtoField.string("xplane.soun.filename","Filename")

xplane.fields.ssnd_header = ProtoField.string("xplane.ssnd","Header")
xplane.fields.ssnd_index = ProtoField.int32("xplane.ssnd.index","Index (0-4)")
xplane.fields.ssnd_speed = ProtoField.float("xplane.ssnd.speed","Relative Speed (0->1)")
xplane.fields.ssnd_volume = ProtoField.float("xplane.ssnd.volume","Relative Volume (0->1")
xplane.fields.ssnd_filename = ProtoField.string("xplane.ssnd.filename","Filename")

xplane.fields.ucoc_header = ProtoField.string("xplane.ucoc","Header")
xplane.fields.ucoc_id = ProtoField.int32("xplane.ucoc.id","ID")

xplane.fields.usel_header = ProtoField.string("xplane.usel","Header")
xplane.fields.usel_id = ProtoField.int32("xplane.usel.id","ID")

xplane.fields.vehx_header = ProtoField.string("xplane.vehx","Header")
xplane.fields.vehx_id = ProtoField.int32("xplane.vehx.id","ID")
xplane.fields.vehx_latitude = ProtoField.double("xplane.vehx.latitude","Latitude")
xplane.fields.vehx_longitude = ProtoField.double("xplane.vehx.longitude","Longitude")
xplane.fields.vehx_elevation = ProtoField.double("xplane.vehx.elevation","Elevation")
xplane.fields.vehx_heading = ProtoField.float("xplane.vehx.heading","Heading")
xplane.fields.vehx_pitch = ProtoField.float("xplane.vehx.pitch","Pitch")
xplane.fields.vehx_roll = ProtoField.float("xplane.vehx.roll","Roll")

local function dissectACFN(buffer, pinfo, tree)
    if buffer:len() ~= 165 then
        return false
    end
    if pinfo.dest_port == 48003 then 
        return false
    end
    
    pinfo.cols.info = "ACFN - Set Aircraft"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.acfn_header,       buffer(0,4))
    tree:add_le(xplane.fields.acfn_index,     tvb_content(0,4))
    tree:add_le(xplane.fields.acfn_path,      tvb_content(4,150))
    tree:add_le(xplane.fields.acfn_livery,    tvb_content(156,4))
    
    return true
end

local function dissectACPR(buffer, pinfo, tree)
    if buffer:len() ~= 229 then
        return false
    end

    pinfo.cols.info = "ACPR - Aircraft Start Position"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.acpr_header, buffer(0,4))
    tree:add_le(xplane.fields.acpr_index,tvb_content(0,4))
    tree:add_le(xplane.fields.acpr_path,tvb_content(4,150))
    tree:add_le(xplane.fields.acpr_livery, tvb_content(156,4))
    tree:add_le(xplane.fields.acpr_starttype,tvb_content(160,4))
    tree:add_le(xplane.fields.acpr_aircraftindex,tvb_content(164,4))
    tree:add_le(xplane.fields.acpr_ICAO,tvb_content(168,8))
    tree:add_le(xplane.fields.acpr_runwayindex,tvb_content(176,4))
    tree:add_le(xplane.fields.acpr_runwaydirection ,tvb_content(180,4))
    tree:add_le(xplane.fields.acpr_latitude ,tvb_content(184,8))
    tree:add_le(xplane.fields.acpr_longitude  ,tvb_content(192,8))
    tree:add_le(xplane.fields.acpr_elevation  ,tvb_content(200,8))
    tree:add_le(xplane.fields.acpr_trueheading  ,tvb_content(208,8))
    tree:add_le(xplane.fields.acpr_speed ,tvb_content(216,8))

    return true
end

local function dissectALRT(buffer, pinfo, tree)
    if buffer:len() ~= 965 then
        return false
    end

    pinfo.cols.info = "ALRT - Display Alert"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.alrt_header, buffer(0,4))
    tree:add(xplane.fields.alrt_line1,tvb_content(0,240))
    tree:add(xplane.fields.alrt_line1,tvb_content(240,240))
    tree:add(xplane.fields.alrt_line1,tvb_content(480,240))
    tree:add(xplane.fields.alrt_line1,tvb_content(720,240))
    
    return true
end

local function dissectBECN(buffer, pinfo, tree)
    
    if pinfo.dst_port ~= xplane.prefs.becn_port then
        return false
    end

    pinfo.cols.info = "BECN - Beacon Packet"
    local tvb_content = buffer(5)
    local major = tvb_content(0,1):le_int()
    local minor = tvb_content(1,1):le_int()
    tree:add(xplane.fields.becn_header, buffer(0,5))
    tree:add_le(xplane.fields.becn_major,tvb_content(0,1))
    tree:add_le(xplane.fields.becn_minor , tvb_content(1,1))
    tree:add_le(xplane.fields.becn_appid ,tvb_content(2,4))
    tree:add_le(xplane.fields.becn_version ,tvb_content(6,4))
    tree:add_le(xplane.fields.becn_role ,tvb_content(10,4))
    tree:add_le(xplane.fields.becn_port ,tvb_content(14,2))
    tree:add_le(xplane.fields.becn_name ,tvb_content(16,tvb_content:len()-16))
    if (major == 1 and minor == 2) then
        tree:add_le(xplane.fields.becn_newport ,tvb_content(tvb_content:len()-2,2))
    end    
    
    return true
end

local function dissectCMND(buffer, pinfo, tree)
    pinfo.cols.info = "CMND - Execute Command"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.cmnd_header, buffer(0,4))
    tree:add(xplane.fields.cmnd_command, tvb_content)
    
    return true
end

local function dissectDATA(buffer, pinfo, tree)
    pinfo.cols.info = "DATA - Set/Receive Data struct(s)"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 36
    tree:add(xplane.fields.data_header, buffer(0,4)):append_text(" .. Count = " .. count)
    for i=0, count-1, 1 do
        local index = tvb_content(i*36,4):le_uint()
        local desc = xplane_DataIdLookup[index][0]
        if desc == nil then
            desc = "Unknown - " .. index
        end
        local branch = tree:add(tvb_content(i*36,36), "ID:  " .. index .. "  " .. desc)
        for j=1,8,1 do
            local offset = (i*36) + j*4
            branch:add_le(tvb_content(offset,4), "[" .. j .. "]:  " .. tvb_content(offset, 4):le_float() .. "  " .. xplane_DataIdLookup[index][j])
        end
    end

    return true
end

local function dissectDCOC(buffer, pinfo, tree)
    if (buffer:len()-5) % 4 ~= 0 then
        return false
    end
  
    pinfo.cols.info = "DCOC - Enable Cockpit Data Output"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 4
    tree:add(xplane.fields.dcoc_header, buffer(0,4)):append_text("  Count = " .. count)
    for i=0,count-1, 1 do
        tree:add_le(xplane.fields.dcoc_id,tvb_content(i*4,4)) 
    end
    
    return true
end

local function dissectDREF(buffer, pinfo, tree)
    if buffer:len() ~= 509 then
        return false
    end

    pinfo.cols.info = "DREF - Send/Receive Dataref"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.dref_header, buffer(0,4))
    tree:add_le(xplane.fields.dref_value,tvb_content(0,4))
    tree:add_le(xplane.fields.dref_dataref, tvb_content(4))

    return true
end

local function dissectDSEL(buffer, pinfo, tree)
    if (buffer:len()-5) % 4 ~= 0 then
        return false
    end

    pinfo.cols.info = "DSEL - Disable UDP Data Output"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 4
    tree:add(xplane.fields.dsel_header, buffer(0,4)):append_text("  Count = " .. count)
    for i=0,count-1, 1 do
        tree:add_le(xplane.fields.dsel_id,tvb_content(i*4,4)) 
    end
    
    return true
end

local function dissectFAIL(buffer, pinfo, tree)
    pinfo.cols.info = "FAIL - Fail a system"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.fail_header, buffer(0,4))
    tree:add(xplane.fields.fail_id, tvb_content)

    return true
end

local function dissectFLIR_IN(buffer, pinfo, tree)
    pinfo.cols.info = "FLIR - Infra-Red image (IN)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.flir_header, buffer(0,4))
    tree:add_le(xplane.fields.flir_framerate, tvb_content)

    return true
end

local function dissectFLIR_OUT(buffer, pinfo, tree)
    pinfo.cols.info = "FLIR - Infra-Red image (OUT)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.flir_header, buffer(0,4)):append_text(" Obsolete in 11.50 onwards")
    tree:add_le(xplane.fields.flir_height,tvb_content(0,2))
    tree:add_le(xplane.fields.flir_width,tvb_content(2,2))
    tree:add_le(xplane.fields.flir_frameindex,tvb_content(4,1))
    tree:add_le(xplane.fields.flir_framecount,tvb_content(5,1))
    --tree:add_le(xplane.fields.flir_imagedata,buffer(6,buffer:len()-6)
    return true
end

local function dissectFLIR(buffer, pinfo, tree)
    if buffer:len() < 20 then
        return dissectFLIR_IN(buffer,pinfo,tree)
    else
        return dissectFLIR_OUT(buffer,pinfo,tree)
    end
end

local function dissectISE4(buffer, pinfo, tree)
    pinfo.cols.info = "ISE4 - Network setup (ip4)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.ise4_header, buffer(0,4))
    tree:add_le(xplane.fields.ise4_machinetype,tvb_content(0,4))
    tree:add_le(xplane.fields.ise4_address, tvb_content(4,16))
    tree:add_le(xplane.fields.ise4_port, tvb_content(20,8))
    tree:add_le(xplane.fields.ise4_useip, tvb_content(28,4))

    return true
end

local function dissectISE6(buffer, pinfo, tree)
    pinfo.cols.info = "ISE6 - Network setup (ip6)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.ise6_header, buffer(0,4))
    tree:add_le(xplane.fields.ise6_machinetype,tvb_content(0,4))
    tree:add_le(xplane.fields.ise6_address, tvb_content(4,65))
    tree:add_le(xplane.fields.ise6_port, tvb_content(69,6))
    tree:add_le(xplane.fields.ise6_useip, tvb_content(76,4))

    return true
end

local function dissectLSND(buffer, pinfo, tree)
    
pinfo.cols.info = "LSND - Starting looping a sound"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.lsnd_header, buffer(0,4))
    tree:add_le(xplane.fields.lsnd_index,tvb_content(0,4))
    tree:add_le(xplane.fields.lsnd_speed, tvb_content(4,4))
    tree:add_le(xplane.fields.lsnd_volume, tvb_content(8,4))
    tree:add(xplane.fields.lsnd_filename, tvb_content(12))

    return true
end

local function dissectNFAL(buffer, pinfo, tree)
    pinfo.cols.info = "NFAL - Fail a navaid"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.nfal_header, buffer(0,4))
    tree:add(xplane.fields.nfal_navaidcode, tvb_content)

    return true
end

local function dissectNREC(buffer, pinfo, tree)
    
pinfo.cols.info = "NREC - Recover a navaid"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.nrec_header, buffer(0,4))
    tree:add(xplane.fields.nrec_navaidcode, tvb_content)
    return true
end

local function dissectOBJL(buffer, pinfo, tree)
    pinfo.cols.info = "OBJL - Position an object"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.objl_header, buffer(0,4))
    tree:add_le(xplane.fields.objl_index ,tvb_content(0,4))
    tree:add_le(xplane.fields.objl_latitude,tvb_content(4,8))
    tree:add_le(xplane.fields.objl_longitude ,tvb_content(12,8))
    tree:add_le(xplane.fields.objl_elevation ,tvb_content(20,8))
    tree:add_le(xplane.fields.objl_psi ,tvb_content(28,4))
    tree:add_le(xplane.fields.objl_theta ,tvb_content(32,4))
    tree:add_le(xplane.fields.objl_phi ,tvb_content(36,4))
    tree:add_le(xplane.fields.objl_onground ,tvb_content(40,4))
    tree:add_le(xplane.fields.objl_smokesize ,tvb_content(44,4))

    return true
end

local function dissectOBJN(buffer, pinfo, tree)
    pinfo.cols.info = "OBJN - Load an object"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.objn_header, buffer(0,4))
    tree:add_le(xplane.fields.objn_index ,tvb_content(0,4))
    tree:add(xplane.fields.objn_filename,tvb_content(4))

    return true
end

local function dissectPREL(buffer, pinfo, tree)
    pinfo.cols.info = "PREL - Load and Position Aircraft)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.prel_header, buffer(0,4))
    tree:add_le(xplane.fields.prel_starttype,tvb_content(0,4)) 
    tree:add_le(xplane.fields.prel_aircraftindex,tvb_content(4,4))
    tree:add_le(xplane.fields.prel_ICAO,tvb_content(8,8))
    tree:add_le(xplane.fields.prel_runwayindex,tvb_content(16,4))
    tree:add_le(xplane.fields.prel_runwaydirection ,tvb_content(20,4))
    tree:add_le(xplane.fields.prel_latitude ,tvb_content(24,8))
    tree:add_le(xplane.fields.prel_longitude  ,tvb_content(32,8))
    tree:add_le(xplane.fields.prel_elevation  ,tvb_content(40,8))
    tree:add_le(xplane.fields.prel_trueheading  ,tvb_content(48,8))
    tree:add_le(xplane.fields.prel_speed ,tvb_content(56,8))

    return true
end

local function dissectQUIT(buffer, pinfo, tree)
    pinfo.cols.info = "QUIT - Quit X-Plane"
    tree:add(xplane.fields.quit_header, buffer(0,4))

    return true
end

local function dissectRADR_IN(buffer, pinfo, tree)
    pinfo.cols.info = "RADR - Weather Radar (IN)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.radr_in_header, buffer(0,4))
    tree:add(xplane.fields.radr_in_pointcount, tvb_content)

    return true
end

local function dissectRADR_OUT(buffer, pinfo, tree)
    pinfo.cols.info = "RADR - Weather Radar (OUT)"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 13
    tree:add(xplane.fields.radr_out_header, buffer(0,4)):append_text(" Count = " .. count)
    for i = 0, count - 1, 1 do
        local branch = tree:add(tvb_content(i * 13,13),"Radr " .. i)
        branch:add_le(xplane.fields.radr_out_longitude, tvb_content(i * 13,4))
        branch:add_le(xplane.fields.radr_out_latitude, tvb_content((i * 13) + 4,4))
        branch:add(xplane.fields.radr_out_precipitation, tvb_content((i * 13) + 8,1))
        branch:add_le(xplane.fields.radr_out_height, tvb_content((i * 13) + 9,4))
    end
    return true
end

local function dissectRADR(buffer, pinfo, tree)
    if buffer:len() < 12 then
        return dissectRADR_IN(buffer,pinfo,tree)
    else
        return dissectRADR_OUT(buffer,pinfo,tree)
    end
end

local function dissectRECO(buffer, pinfo, tree)
    pinfo.cols.info = "RECO - Recover a plane system"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.reco_header, buffer(0,4))
    tree:add(xplane.fields.reco_systemid, tvb_content)

    return true
end

local function dissectRESE(buffer, pinfo, tree)
    pinfo.cols.info = "RESE - Reset all failed systems"
    tree:add(xplane.fields.rese_header, buffer(0,4))

    return true
end

local function dissectRPOS_IN(buffer, pinfo, tree)
    pinfo.cols.info = "RPOS - Request Positional Data"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.rpos_in_header, buffer(0,4))
    tree:add(xplane.fields.rpos_in_frequency, tvb_content)

    return true
end

local function dissectRPOS_OUT(buffer, pinfo, tree)
    pinfo.cols.info = "RPOS - Positional Data)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.rpos_out_header, buffer(0,4))
    tree:add_le(xplane.fields.rpos_out_longitude, tvb_content(0, 8))
    tree:add_le(xplane.fields.rpos_out_latitude, tvb_content(8, 8))
    tree:add_le(xplane.fields.rpos_out_elevation, tvb_content(16, 8))
    tree:add_le(xplane.fields.rpos_out_height, tvb_content(24, 4))
    tree:add_le(xplane.fields.rpos_out_theta, tvb_content(28, 4))
    tree:add_le(xplane.fields.rpos_out_psi, tvb_content(32, 4))
    tree:add_le(xplane.fields.rpos_out_phi, tvb_content(36, 4))
    tree:add_le(xplane.fields.rpos_out_vx, tvb_content(40, 4))
    tree:add_le(xplane.fields.rpos_out_vy, tvb_content(44, 4))
    tree:add_le(xplane.fields.rpos_out_vz, tvb_content(48, 4))
    tree:add_le(xplane.fields.rpos_out_rollrate, tvb_content(52, 4))
    tree:add_le(xplane.fields.rpos_out_pitchrate, tvb_content(56, 4))
    tree:add_le(xplane.fields.rpos_out_yawrate, tvb_content(60, 4))

    return true
end

local function dissectRPOS(buffer, pinfo, tree)
    if buffer:len() ~= 69 then
        return dissectRPOS_IN(buffer,pinfo,tree)
    else
        return dissectRPOS_OUT(buffer,pinfo,tree)
    end
end

local function dissectRREF_IN(buffer, pinfo, tree)
    pinfo.cols.info = "RREF - Request Dataref"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.rref_in_header, buffer(0,4))
    tree:add_le(xplane.fields.rref_in_frequency, tvb_content(0, 4))
    tree:add_le(xplane.fields.rref_in_id, tvb_content(4, 4))
    tree:add_le(xplane.fields.rref_in_dataref, tvb_content(8, 400))
    
    return true
end

local function dissectRREF_OUT(buffer, pinfo, tree)
    pinfo.cols.info = "RREF - Dataref Array"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 8
    tree:add(xplane.fields.rref_out_header, buffer(0,4)):append_text(" Count = " .. count)
    for i = 0, count - 1, 1 do
        local branch = tree:add(tvb_content(i*8,8), "RREF [" .. i .. "]")
        branch:add_le(xplane.fields.rref_out_id, tvb_content(i*8, 4))
        branch:add_le(xplane.fields.rref_out_value, tvb_content((i*8) + 4, 4))
    end

    return true
end

local function dissectRREF(buffer, pinfo, tree)
    if buffer:len() == 413 then
        return dissectRREF_IN(buffer, pinfo, tree)
    else
        return dissectRREF_OUT(buffer, pinfo, tree)
    end
end

local function dissectSHUT(buffer, pinfo, tree)
    pinfo.cols.info = "SHUT - Shutdown the computer"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.shut_header, buffer(0,4))

    return true
end

local function dissectSIMO(buffer, pinfo, tree)
    pinfo.cols.info = "SIMO - Load/Save a Movie/Situation"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.simo_header, buffer(0,4))
    tree:add_le(xplane.fields.simo_action, tvb_content(0, 4))
    tree:add(xplane.fields.simo_filename, tvb_content(4))

    return true
end

local function dissectSOUN(buffer, pinfo, tree)
    
pinfo.cols.info = "SOUN - Play a Sound Once"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.soun_header, buffer(0,4))
    tree:add_le(xplane.fields.soun_speed, tvb_content(0,4))
    tree:add_le(xplane.fields.soun_volume, tvb_content(4,4))
    tree:add(xplane.fields.soun_filename, tvb_content(8))

    return true
end

local function dissectSSND(buffer, pinfo, tree)
    pinfo.cols.info = "SSND - Stop looping a sound"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.ssnd_header, buffer(0,4))
    tree:add_le(xplane.fields.ssnd_index,tvb_content(0,4))
    tree:add_le(xplane.fields.ssnd_speed, tvb_content(4,4))
    tree:add_le(xplane.fields.ssnd_volume, tvb_content(8,4))
    tree:add(xplane.fields.ssnd_filename, tvb_content(12))

    return true
end

local function dissectUCOC(buffer, pinfo, tree)
    pinfo.cols.info = "UCOC - Disable Cockpit Output"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 4
    tree:add(xplane.fields.ucoc_header, buffer(0,4)):append_text("  Count = " .. count)
    for i=0,count-1, 1 do
        tree:add_le(xplane.fields.ucoc_id,tvb_content(i*4,4)) 
    end

    return true
end

local function dissectUSEL(buffer, pinfo, tree)
    pinfo.cols.info = "USEL - Disable Network data row"
    local tvb_content = buffer(5)
    local count = tvb_content:len() / 4
    tree:add(xplane.fields.usel_header, buffer(0,4)):append_text("  Count = " .. count)
    for i=0,count-1, 1 do
        tree:add_le(xplane.fields.usel_id,tvb_content(i*4,4)) 
    end

    return true
end

local function dissectVEHX(buffer, pinfo, tree)
    pinfo.cols.info = "VEHX - Position Aircraft)"
    local tvb_content = buffer(5)
    tree:add(xplane.fields.vehx_header, buffer(0,4))
    tree:add_le(xplane.fields.vehx_id,tvb_content(0,4))
    tree:add_le(xplane.fields.vehx_latitude ,tvb_content(4,8))
    tree:add_le(xplane.fields.vehx_longitude  ,tvb_content(12,8))
    tree:add_le(xplane.fields.vehx_elevation  ,tvb_content(20,8))
    tree:add_le(xplane.fields.vehx_heading ,tvb_content(28,4))
    tree:add_le(xplane.fields.vehx_pitch ,tvb_content(32,4))
    tree:add_le(xplane.fields.vehx_roll ,tvb_content(36,4))

    return true
end

local subdissectors = {
    ACFN = dissectACFN, -- Checked - Note: Picks up the ACFN packet sent to LR ControlPad App on port 48003
    ACPR = dissectACPR, -- Checked
    ALRT = dissectALRT, -- Checked
    BECN = dissectBECN, -- Checked
    CMND = dissectCMND, -- Checked
    DATA = dissectDATA, -- Checked (Both Ways)
    DCOC = dissectDCOC, -- Checked
    DREF = dissectDREF, -- Checked (Both Ways)
    DSEL = dissectDSEL, -- Checked
    FAIL = dissectFAIL, -- Checked
    FLIR = dissectFLIR, -- Checked (Both ways) - Note: Obsolete as of 11.50. FLIR last worked in 11.41
    ISE4 = dissectISE4, -- Checked
    ISE6 = dissectISE6, -- Not Checked
    LSND = dissectLSND, -- Displays packet as expected but doesn't loop any audio - bug submitted - Ben replied no plan to fix in 11.50.
    NFAL = dissectNFAL, -- Checked
    NREC = dissectNREC, -- Checked
    OBJL = dissectOBJL, -- Checked
    OBJN = dissectOBJN, -- Checked
    PREL = dissectPREL, -- Checked
    QUIT = dissectQUIT, -- Checked
    RADR = dissectRADR, -- Checked (Both Ways)
    RECO = dissectRECO, -- Checked
    RESE = dissectRESE, -- Checked
    RPOS = dissectRPOS, -- Checked (Both Ways)
    RREF = dissectRREF, -- Checked (Both Ways)
    SHUT = dissectSHUT, -- Checked (Note: doesn't show up in wireshark live as shutdown is in progress before Wireshark has time to show it :p)
    SIMO = dissectSIMO, -- Checked
    SOUN = dissectSOUN, -- Checked
    SSND = dissectSSND, -- Displays Packet as expected but no way to check if the audio stops looping as LSND doesn't work.
    UCOC = dissectUCOC, -- Checked
    USEL = dissectUSEL, -- Checked
    VEHX = dissectVEHX, -- Checked
}

function xplane.dissector(buffer, pinfo, tree)

    if buffer:len() <= 5 then
        return false
    end

    local header = buffer(0, 4):string()
    if subdissectors[header] ~= nil then
        pinfo.cols.protocol = "xplane." .. header:lower()
        local subtree = tree:add(xplane, buffer(), "X-Plane (" .. header .. ") Packet Length " .. buffer:len())
        return subdissectors[header](buffer, pinfo, subtree)
    else
        return false
    end
end

xplane:register_heuristic("udp",  xplane.dissector)

-- ut = DissectorTable.get("udp.port")
-- ut:add(49000, xplane); -- Default value - must match X-Plane->Settings->Network->UDP Ports->Port we receive on (legacy)

-- ut = DissectorTable.get("udp.port")
-- ut:add(49001, xplane); -- Default value - must match X-Plane->Settings->Network->UDP Ports->Port we send from (legacy)
-- ut:add(49002, xplane); -- FLIR is emitted from 49002
-- ut:add(49707, xplane); -- BECN is multicast to 239.255.1.1:49707