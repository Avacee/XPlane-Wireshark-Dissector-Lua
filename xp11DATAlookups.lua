local xpDATAlookups_info = 
{
    version = "1.0.0",
    author = "Avacee",
    description = "This plugin provides a 2D lookup table for XP",
    repository = "https://github.com/avacee/xp11-Lua-Dissector"
}

set_plugin_info(xpDATAlookups_info)

xp11_DataIdLookup = {}
for i = 0, 138 do
  xp11_DataIdLookup[i] = {}
  for j=0,8 do
    xp11_DataIdLookup[i][j] = ""
  end
end

xp11_DataIdLookup[0][0] = "Frame Rate"
xp11_DataIdLookup[0][1] = "Actual Frame Rate"
xp11_DataIdLookup[0][2] = "Sim Frame Rate"
xp11_DataIdLookup[0][3] = "" --Unused
xp11_DataIdLookup[0][4] = "Frame Time (s) DataRef=sim/time/framerate_period"
xp11_DataIdLookup[0][5] = "CPU Time (s)"
xp11_DataIdLookup[0][6] = "GPU Time (s)  DataRef=sim/time/gpu_time_per_frame_sec_approx"
xp11_DataIdLookup[0][7] = "grnd ratio"
xp11_DataIdLookup[0][8] = "flit ratio (Requested Simulator Speed multiple from ctrl-T  DataRef=sim/time/sim_speed_actual"

xp11_DataIdLookup[1][0]= "Times"
xp11_DataIdLookup[1][1] = "Elapsed Sim Start (s)"
xp11_DataIdLookup[1][2] = "Elapsed Total Time (exc Start Screen) (s)"
xp11_DataIdLookup[1][3] = "Elapsed Mission Time (s)" 
xp11_DataIdLookup[1][4] = "Elapsed Timer (s)"
xp11_DataIdLookup[1][5] = "" -- Unused
xp11_DataIdLookup[1][6] = "Zulu Time  DataRef=sim/time/zulu_time_sec"
xp11_DataIdLookup[1][7] = "Simulator Local Time"
xp11_DataIdLookup[1][8] = "Hobbs Time DataRef=sim/time/hobbs_time"

xp11_DataIdLookup[2][0]= "Sim Stats"
xp11_DataIdLookup[2][1]= "USE (puffs)"
xp11_DataIdLookup[2][2]= "TOT (puffs)"
xp11_DataIdLookup[2][3]= "Triangles Visible"
xp11_DataIdLookup[2][4]= "" -- Unused
xp11_DataIdLookup[2][5]= "" -- Unused
xp11_DataIdLookup[2][6]= "" -- Unused
xp11_DataIdLookup[2][7]= "" -- Unused
xp11_DataIdLookup[2][8]= "" -- Unused

xp11_DataIdLookup[3][0]= "Airspeed"
xp11_DataIdLookup[3][1]= "Knots Indicated Airspeed"
xp11_DataIdLookup[3][2]= "Knots Equivalent Airspeed "
xp11_DataIdLookup[3][3]= "Knots True Airspeed"
xp11_DataIdLookup[3][4]= "Knots Tree Ground Speed"
xp11_DataIdLookup[3][5]= "" -- Unused
xp11_DataIdLookup[3][6]= "Indicated (mph)" 
xp11_DataIdLookup[3][7]= "True Airspeed (mph)" 
xp11_DataIdLookup[3][8]= "True Ground Speed (mph)" 

xp11_DataIdLookup[4][0]= "G loads"
xp11_DataIdLookup[4][1]= "Current Mach"
xp11_DataIdLookup[4][2]= "" -- Unused
xp11_DataIdLookup[4][3]= "Vertical Velocity (feet per minute)"
xp11_DataIdLookup[4][4]= "" -- Unused
xp11_DataIdLookup[4][5]= "Gload (normal)"
xp11_DataIdLookup[4][6]= "GLoad (axial)" 
xp11_DataIdLookup[4][7]= "Gload (side)" 
xp11_DataIdLookup[4][8]= "" -- Unused

xp11_DataIdLookup[5][0]= "Weather"
xp11_DataIdLookup[5][1]= "Sea Level Pressure (inHG)"
xp11_DataIdLookup[5][2]= "Sea Level Temperature (degC)"
xp11_DataIdLookup[5][3]= "" -- Unused
xp11_DataIdLookup[5][4]= "Wind Speed (knots)"
xp11_DataIdLookup[5][5]= "Wind From Direction 0=N->S  270=West->East"
xp11_DataIdLookup[5][6]= "Local Turbulance (0->1)" 
xp11_DataIdLookup[5][7]= "Local Precipitation (0->1)"
xp11_DataIdLookup[5][8]= "Local Hail (0->1)"

xp11_DataIdLookup[6][0]= "Aircraft atmosphere"
xp11_DataIdLookup[6][1]= "Atmospheric Pressure (inHG)"
xp11_DataIdLookup[6][2]= "Atmospheric Temperature (degC)"
xp11_DataIdLookup[6][3]= "LE temp (degC)" 
xp11_DataIdLookup[6][4]= "Aircraft Density Ratio"
xp11_DataIdLookup[6][5]= "A (ktas)"
xp11_DataIdLookup[6][6]= "Q Dynamic pressue (lbs / ft^2)" 
xp11_DataIdLookup[6][7]= "" -- Unused
xp11_DataIdLookup[6][8]= "Gravitational Force (feet/s^2)"

xp11_DataIdLookup[7][0]= "System pressures"
xp11_DataIdLookup[7][1]= "Barometric pressure (inHG)"
xp11_DataIdLookup[7][2]= "edens (part)"
xp11_DataIdLookup[7][3]= "Vacuum ratio" 
xp11_DataIdLookup[7][4]= "Vacuum ratio"
xp11_DataIdLookup[7][5]= "Elec ratio"
xp11_DataIdLookup[7][6]= "Elec ratio" 
xp11_DataIdLookup[7][7]= "AHRS ratio" 
xp11_DataIdLookup[7][8]= "AHRS ratio"

xp11_DataIdLookup[8][0]= "Joystick Yoke1"
xp11_DataIdLookup[8][1]= "Elevator Full down = -1 Full Up = +1"
xp11_DataIdLookup[8][2]= "Aileron Full Left = -1  Full Right = +1"
xp11_DataIdLookup[8][3]= "Rudder  Full Left = -1  Full Right = +1"
xp11_DataIdLookup[8][4]= "" --Unused
xp11_DataIdLookup[8][5]= "" --Unused
xp11_DataIdLookup[8][6]= "" --Unused
xp11_DataIdLookup[8][7]= "" --Unused
xp11_DataIdLookup[8][8]= "" --Unused

xp11_DataIdLookup[9][0]= "Other Flight Controls"
xp11_DataIdLookup[9][1]= "Requested Thrust Vectoring"
xp11_DataIdLookup[9][2]= "Requested Wing Sweep"
xp11_DataIdLookup[9][3]= "Requested Wing Incidence"
xp11_DataIdLookup[9][4]= "Requested Wing Digedral" 
xp11_DataIdLookup[9][5]= "Requested Wing Retration" 
xp11_DataIdLookup[9][6]= "" --Unused
xp11_DataIdLookup[9][7]= "" --Unused
xp11_DataIdLookup[9][8]= "Water Jettisoned" 

xp11_DataIdLookup[10][0]= "Artificial Stability Input"
xp11_DataIdLookup[10][1]= "Elevator Full down = -1 Full Up = +1"
xp11_DataIdLookup[10][2]= "Aileron Full Left = -1  Full Right = +1"
xp11_DataIdLookup[10][3]= "Rudder  Full Left = -1  Full Right = +1"
xp11_DataIdLookup[10][4]= "" --Unused
xp11_DataIdLookup[10][5]= "" --Unused
xp11_DataIdLookup[10][6]= "" --Unused
xp11_DataIdLookup[10][7]= "" --Unused
xp11_DataIdLookup[10][8]= "" --Unused

xp11_DataIdLookup[11][0]= "Flight Control Deflections"
xp11_DataIdLookup[11][1]= "Elevator Full down = -1 Full Up = +1"
xp11_DataIdLookup[11][2]= "Aileron Full Left = -1  Full Right = +1"
xp11_DataIdLookup[11][3]= "Rudder  Full Left = -1  Full Right = +1"
xp11_DataIdLookup[11][4]= "" --Unused
xp11_DataIdLookup[11][5]= "Nosewheel Degrees from forward. Negative = left, Positive = right"
xp11_DataIdLookup[11][6]= "" --Unused
xp11_DataIdLookup[11][7]= "" --Unused
xp11_DataIdLookup[11][8]= "" --Unused

xp11_DataIdLookup[12][0]= "Wing sweep and thrust vectoring"
xp11_DataIdLookup[12][1]= "Sweep 1 (degrees back from normal)"
xp11_DataIdLookup[12][2]= "Sweep 1 (degrees back from normal)"
xp11_DataIdLookup[12][3]= "Sweep (degrees back from normal)"
xp11_DataIdLookup[12][4]= "Vector Ratio" 
xp11_DataIdLookup[12][5]= "Sweep ratio (to fully forward)"
xp11_DataIdLookup[12][6]= "Incidence ratio (to fully angled)" 
xp11_DataIdLookup[12][7]= "Dihedral ratio (to fulyl angled)" 
xp11_DataIdLookup[12][8]= "Retraction ratio (to fully angled)" 

xp11_DataIdLookup[13][0]= "Trim / flaps / Slats / Speedbrakes"
xp11_DataIdLookup[13][1]= "Elevator trim"
xp11_DataIdLookup[13][2]= "Aileron trim"
xp11_DataIdLookup[13][3]= "Rudder trim"
xp11_DataIdLookup[13][4]= "Flap Requested (0->1)" 
xp11_DataIdLookup[13][5]= "Flap Ratio (0->1)"
xp11_DataIdLookup[13][6]= "Slat Ratio" 
xp11_DataIdLookup[13][7]= "Speedbrake Requested (0->1)" 
xp11_DataIdLookup[13][8]= "Speedbrake Ratio (0->1)"

xp11_DataIdLookup[14][0]= "Gear and Brakes"
xp11_DataIdLookup[14][1]= "Gear Requested (0->1)"
xp11_DataIdLookup[14][2]= "wbrak, set"
xp11_DataIdLookup[14][3]= "Left Toe Brake requested"
xp11_DataIdLookup[14][4]= "Right Toe Brake requested" 
xp11_DataIdLookup[14][5]= "wbrak, position"
xp11_DataIdLookup[14][6]= "" --Unused 
xp11_DataIdLookup[14][7]= "" --Unused
xp11_DataIdLookup[14][8]= "" --Unused

xp11_DataIdLookup[15][0]= "Angular Moments"
xp11_DataIdLookup[15][1]= "M Roll Torque around X-axis (foot / lbs)"
xp11_DataIdLookup[15][2]= "L Roll Torque around Z-axis (foot / lbs)"
xp11_DataIdLookup[15][3]= "N Roll Torque around Y-axis (foot / lbs)"
xp11_DataIdLookup[15][4]= "" --Unused 
xp11_DataIdLookup[15][5]= "" --Unused 
xp11_DataIdLookup[15][6]= "" --Unused 
xp11_DataIdLookup[15][7]= "" --Unused
xp11_DataIdLookup[15][8]= "" --Unused

xp11_DataIdLookup[16][0]= "Angular Velocities"
xp11_DataIdLookup[16][1]= "Q Pitch Rate (measued in Body-axes)"
xp11_DataIdLookup[16][2]= "P Roll Rate (measued in Body-axes)"
xp11_DataIdLookup[16][3]= "R Yaw Rate (measued in Body-axes)"
xp11_DataIdLookup[16][4]= "" --Unused 
xp11_DataIdLookup[16][5]= "" --Unused 
xp11_DataIdLookup[16][6]= "" --Unused 
xp11_DataIdLookup[16][7]= "" --Unused
xp11_DataIdLookup[16][8]= "" --Unused

xp11_DataIdLookup[17][0]= "Pitch / Roll / Headings"
xp11_DataIdLookup[17][1]= "Pitch degrees (measured in body-axis Euler angles)"
xp11_DataIdLookup[17][2]= "Roll degrees (measured in body-axis Euler angles)"
xp11_DataIdLookup[17][3]= "True Heading (degrees)"
xp11_DataIdLookup[17][4]= "Magnetic Heading (degrees)"
xp11_DataIdLookup[17][5]= "" --Unused 
xp11_DataIdLookup[17][6]= "" --Unused 
xp11_DataIdLookup[17][7]= "" --Unused
xp11_DataIdLookup[17][8]= "" --Unused

xp11_DataIdLookup[18][0]= "Angle Of Attack"
xp11_DataIdLookup[18][1]= "Alpha - AoA (degrees)"
xp11_DataIdLookup[18][2]= "Beta slideslip (degrees)"
xp11_DataIdLookup[18][3]= "HPath (degrees)"
xp11_DataIdLookup[18][4]= "VPath (degrees)"
xp11_DataIdLookup[18][5]= "" --Unused 
xp11_DataIdLookup[18][6]= "" --Unused 
xp11_DataIdLookup[18][7]= "" --Unused
xp11_DataIdLookup[18][8]= "slip, degrees"

xp11_DataIdLookup[19][0]= "Magnetic Compass"
xp11_DataIdLookup[19][1]= "Magnetic Heading"
xp11_DataIdLookup[19][2]= "Magnetic Variation (from True)"
xp11_DataIdLookup[19][3]= "" --Unused
xp11_DataIdLookup[19][4]= "" --Unused
xp11_DataIdLookup[19][5]= "" --Unused 
xp11_DataIdLookup[19][6]= "" --Unused 
xp11_DataIdLookup[19][7]= "" --Unused
xp11_DataIdLookup[19][8]= "" --Unused

xp11_DataIdLookup[20][0]= "Global Position"
xp11_DataIdLookup[20][1]= "Latitude"
xp11_DataIdLookup[20][2]= "Longitude"
xp11_DataIdLookup[20][3]= "Altitude (ft above mean sea level)"
xp11_DataIdLookup[20][4]= "Altitude (ft above ground)"
xp11_DataIdLookup[20][5]= "Is On Runway?"
xp11_DataIdLookup[20][6]= "Indicated Altitude" 
xp11_DataIdLookup[20][7]= "Latitude (bottom of containing Lat/Long scenery square)" 
xp11_DataIdLookup[20][8]= "Longitude (left of containing Lat/Long scenery square)" 

xp11_DataIdLookup[21][0]= "Distances Travelled"
xp11_DataIdLookup[21][1]= "X - relative to inertial axes"
xp11_DataIdLookup[21][2]= "Y - relative to inertial axes"
xp11_DataIdLookup[21][3]= "Z - relative to inertial axes"
xp11_DataIdLookup[21][4]= "vX (m/s) - relative to inertial axes"
xp11_DataIdLookup[21][5]= "vY (m/s) - relative to inertial axes"
xp11_DataIdLookup[21][6]= "vZ (m/s) - relative to inertial axes"
xp11_DataIdLookup[21][7]= "Distance (feet)" 
xp11_DataIdLookup[21][8]= "Distance (nm)" 

xp11_DataIdLookup[22][0]= "All Planes Latitude"
xp11_DataIdLookup[23][0]= "All Planes Longitude"
xp11_DataIdLookup[24][0]= "All Planes Altitude (feet above mean sea level)"

for i=0,7,1 do
  xp11_DataIdLookup[22][i+1]= "Latitude of Plane " .. i
  xp11_DataIdLookup[23][i+1]= "Longitude of Plane " .. i
  xp11_DataIdLookup[24][i+1]= "Altitude of Plane " .. i
end

-- The following DATA entries have a similar description to are populated in a loop later
xp11_DataIdLookup[25][0]= "Throttle - Requested"
xp11_DataIdLookup[26][0]= "Throttle - Actual"
xp11_DataIdLookup[27][0]= "Engine Mode (0=Feather, 1=Normal, 2-Beta and 3=Reverse)"
xp11_DataIdLookup[28][0]= "Propeller setting"
xp11_DataIdLookup[29][0]= "Mixture setting"
xp11_DataIdLookup[30][0]= "Carb heat"
xp11_DataIdLookup[31][0]= "Cowl flaps"
xp11_DataIdLookup[32][0]= "Magnetos"
xp11_DataIdLookup[33][0]= "Starter timeout"
xp11_DataIdLookup[34][0]= "Engine power"
xp11_DataIdLookup[35][0]= "Engine thrust"
xp11_DataIdLookup[36][0]= "Engine torque"
xp11_DataIdLookup[37][0]= "Engine RPM"
xp11_DataIdLookup[38][0]= "Propeller RPM"
xp11_DataIdLookup[39][0]= "Propeller Pitch"
xp11_DataIdLookup[40][0]= "Engine Wash"
xp11_DataIdLookup[41][0]= "N1"
xp11_DataIdLookup[42][0]= "N2"
xp11_DataIdLookup[43][0]= "Manifold pressure"
xp11_DataIdLookup[44][0]= "EPR"
xp11_DataIdLookup[45][0]= "Fuel Flow"
xp11_DataIdLookup[46][0]= "ITT"
xp11_DataIdLookup[47][0]= "EGT"
xp11_DataIdLookup[48][0]= "CHT"
xp11_DataIdLookup[49][0]= "Oil pressure"
xp11_DataIdLookup[50][0]= "Oil temperature"
xp11_DataIdLookup[51][0]= "Fuel pressure"
xp11_DataIdLookup[52][0]= "Generator amps"
xp11_DataIdLookup[53][0]= "Battery amps"
xp11_DataIdLookup[54][0]= "Battery volts"
xp11_DataIdLookup[55][0]= "Electric fuel pump on/off"
xp11_DataIdLookup[56][0]= "Idle speed low/high"
xp11_DataIdLookup[57][0]= "Battery on/off"
xp11_DataIdLookup[58][0]= "Generator on/off"
xp11_DataIdLookup[59][0]= "Inverter on/off"
xp11_DataIdLookup[60][0]= "FADEC on/off"
xp11_DataIdLookup[61][0]= "Igniter on/off"
xp11_DataIdLookup[62][0]= "Fuel weights"

for i=0,7,1 do
  xp11_DataIdLookup[25][i+1]= "Engine " .. i .. " requested throttle"
  xp11_DataIdLookup[26][i+1]= "Engine " .. i .. " actual throttle"
  xp11_DataIdLookup[27][i+1]= "Engine " .. i .. " mode"
  xp11_DataIdLookup[28][i+1]= "Propeller " .. i .. " setting"
  xp11_DataIdLookup[30][i+1]= "Engine " .. i .. " Carb heat"
  xp11_DataIdLookup[31][i+1]= "Engine " .. i .. " Cowl flaps"
  xp11_DataIdLookup[32][i+1]= "Magneto" .. 1
  xp11_DataIdLookup[33][i+1]= "Starter " .. i .. " timeout"
  xp11_DataIdLookup[34][i+1]= "Engine " .. i .. " Power (hp)"
  xp11_DataIdLookup[35][i+1]= "Engine " .. i .. " Thrust (lbs)"
  xp11_DataIdLookup[36][i+1]= "Engine " .. i .. " Torque (ft/lbs)"
  xp11_DataIdLookup[37][i+1]= "Engine " .. i .. " RPM"
  xp11_DataIdLookup[38][i+1]= "Propeller " .. i .. " RPM"
  xp11_DataIdLookup[39][i+1]= "Propeller " .. i .. " Pitch"
  xp11_DataIdLookup[40][i+1]= "Engine " .. i .. " Wash"
  xp11_DataIdLookup[41][i+1]= "Engine " .. i .. " N1"
  xp11_DataIdLookup[42][i+1]= "Engine " .. i .. " N2"
  xp11_DataIdLookup[43][i+1]= "Engine " .. i .. " MP (Manifold Pressure)"
  xp11_DataIdLookup[44][i+1]= "Engine " .. i .. " EPR (Engine Pressure Ratio)"
  xp11_DataIdLookup[45][i+1]= "Engine " .. i .. " Fuel Flow (lb/h)"
  xp11_DataIdLookup[46][i+1]= "Engine " .. i .. " ITT (Interstage Turbine Temperature)"
  xp11_DataIdLookup[47][i+1]= "Engine " .. i .. " EGT (Exhaust Gas Temperature("
  xp11_DataIdLookup[48][i+1]= "Engine " .. i .. " CHT (Cylinder Head Temperature)"
  xp11_DataIdLookup[49][i+1]= "Engine " .. i .. " Oil Pressure (lbs/in^2)"
  xp11_DataIdLookup[50][i+1]= "Engine " .. i .. " Oil Temperature"
  xp11_DataIdLookup[51][i+1]= "Engine " .. i .. " Fuel Pressure (lb/in^2)"
  xp11_DataIdLookup[52][i+1]= "Engine " .. i .. " Generator Amps (A)"
  xp11_DataIdLookup[53][i+1]= "Battery " .. i .. " Amps (A)"
  xp11_DataIdLookup[54][i+1]= "Battery " .. i .. " Volts (V)"
  xp11_DataIdLookup[55][i+1]= "Electric fuel pump " .. i .. " On/Off"
  xp11_DataIdLookup[56][i+1]= "Engine " .. i .. " Idle Speed Low/High"
  xp11_DataIdLookup[57][i+1]= "Battery " .. i .. " On/Off"
  xp11_DataIdLookup[58][i+1]= "Generator " .. i .. " on/off"
  xp11_DataIdLookup[59][i+1]= "Inverter " .. i .. " on/off"
  xp11_DataIdLookup[60][i+1]= "FADEC " .. i .. " on/off"
  xp11_DataIdLookup[61][i+1]= "Igniter " .. i .. " on/off"
  xp11_DataIdLookup[62][i+1]= "Fuel Tank " .. i .. " weight (lbs)"
end

xp11_DataIdLookup[63][0]= "Aircraft Payload (lbs) and Centre of Gravity"
xp11_DataIdLookup[63][1]= "Weight Empty"
xp11_DataIdLookup[63][2]= "Weight Total"
xp11_DataIdLookup[63][3]= "Fuel Total"
xp11_DataIdLookup[63][4]= "Weight Jettisonable" 
xp11_DataIdLookup[63][5]= "Weight Current" 
xp11_DataIdLookup[63][6]= "Weight Maximum" 
xp11_DataIdLookup[63][7]= "" --Unused
xp11_DataIdLookup[63][8]= "CoG (feet behind reference point)" 

xp11_DataIdLookup[64][0]= "Aerodynamic Forces"
xp11_DataIdLookup[64][1]= "Lift (lbs)"
xp11_DataIdLookup[64][2]= "Drag (lbs)"
xp11_DataIdLookup[64][3]= "Side (lbs)"
xp11_DataIdLookup[64][4]= "L (ft / lbs)" 
xp11_DataIdLookup[64][5]= "M (ft / lbs)" 
xp11_DataIdLookup[64][6]= "N (ft / lbs)" 
xp11_DataIdLookup[64][7]= "" --Unused
xp11_DataIdLookup[64][8]= "" --Unused

xp11_DataIdLookup[65][0]= "Engine Forces"
xp11_DataIdLookup[65][1]= "Normal (lbs)"
xp11_DataIdLookup[65][2]= "Axial (lbs)"
xp11_DataIdLookup[65][3]= "Side (lbs)"
xp11_DataIdLookup[65][4]= "" --Unused
xp11_DataIdLookup[65][5]= "" --Unused 
xp11_DataIdLookup[65][6]= "" --Unused
xp11_DataIdLookup[65][7]= "" --Unused
xp11_DataIdLookup[65][8]= "" --Unused

xp11_DataIdLookup[66][0]= "Landing Gear Vertical Forces (lbs)"
xp11_DataIdLookup[66][1]= "Landing Gear 1 (typically nosewheel)"
xp11_DataIdLookup[66][2]= "Landing Gear 2"
xp11_DataIdLookup[66][3]= "Landing Gear 3"
xp11_DataIdLookup[66][4]= "Landing Gear 4"
xp11_DataIdLookup[66][5]= "Landing Gear 5" 
xp11_DataIdLookup[66][6]= "Landing Gear 6"
xp11_DataIdLookup[66][7]= "Landing Gear 7"
xp11_DataIdLookup[66][8]= "Landing Gear 8"

xp11_DataIdLookup[67][0]= "Landing Gear Deployment Ratio (0=Up, 1=Down)"
xp11_DataIdLookup[67][1]= "Landing Gear 1 (typically nosewheel)"
xp11_DataIdLookup[67][2]= "Landing Gear 2"
xp11_DataIdLookup[67][3]= "Landing Gear 3"
xp11_DataIdLookup[67][4]= "Landing Gear 4"
xp11_DataIdLookup[67][5]= "Landing Gear 5" 
xp11_DataIdLookup[67][6]= "Landing Gear 6"
xp11_DataIdLookup[67][7]= "Landing Gear 7"
xp11_DataIdLookup[67][8]= "Landing Gear 8"

xp11_DataIdLookup[68][0]= "Lift over drag and coefficients"
xp11_DataIdLookup[68][1]= "Lift/Drag Ratio"
xp11_DataIdLookup[68][2]= ""
xp11_DataIdLookup[68][3]= "cl, total"
xp11_DataIdLookup[68][4]= "cd, total"
xp11_DataIdLookup[68][5]= "" 
xp11_DataIdLookup[68][6]= ""
xp11_DataIdLookup[68][7]= ""
xp11_DataIdLookup[68][8]= "Lift/Drag (*etaP)"

xp11_DataIdLookup[69][0]= "Propeller Efficiency"
for i=0,7,1 do
  xp11_DataIdLookup[69][i+1]= "Propeller " .. i .. " Efficiency"
end

xp11_DataIdLookup[70][0]= "Aileron deflections 1"
xp11_DataIdLookup[71][0]= "Aileron deflections 2"
xp11_DataIdLookup[72][0]= "Roll spoiler deflections 1"
xp11_DataIdLookup[73][0]= "Roll spoiler deflections 2"
xp11_DataIdLookup[74][0]= "Elevator Deflections (degrees)"
xp11_DataIdLookup[75][0]= "Rudder deflections"
xp11_DataIdLookup[76][0]= "Yaw and brake deflections"
for i=0,6,2 do
  xp11_DataIdLookup[70][i+1]= "Left Aileron " .. i/2
  xp11_DataIdLookup[71][i+1]= "Left Aileron " .. (i/2) + 4
  xp11_DataIdLookup[72][i+1]= "Left Roll spoiler " .. i/2
  xp11_DataIdLookup[73][i+1]= "Left Roll spoiler " .. (i/2) + 4
  xp11_DataIdLookup[74][i+1]= "Left Elevator " .. i/2
  xp11_DataIdLookup[75][i+1]= "Left Rudder " .. i/2
  xp11_DataIdLookup[76][i+1]= "Left Yaw Brake " .. i/2
end
for i=1,7,2 do
  xp11_DataIdLookup[70][i+1]= "Right Aileron " .. (i-1)/2
  xp11_DataIdLookup[71][i+1]= "Right Aileron " .. ((i-1)/2) + 4
  xp11_DataIdLookup[72][i+1]= "Right Roll spoiler " .. (i-1)/2
  xp11_DataIdLookup[73][i+1]= "Right Roll spoiler " .. ((i-1)/2) + 4
  xp11_DataIdLookup[74][i+1]= "Right Elevator " .. (i-1)/2
  xp11_DataIdLookup[75][i+1]= "Right Rudder " .. (i-1)/2 
  xp11_DataIdLookup[76][i+1]= "Right Yaw Brake " .. (i-1)/2
end

xp11_DataIdLookup[77][0]= "Control Forces on Pilot's Hands (lbs)"
xp11_DataIdLookup[77][1]= "Pitch"
xp11_DataIdLookup[77][2]= "Roll"
xp11_DataIdLookup[77][3]= "Heading"
xp11_DataIdLookup[77][4]= "Left-Brake"
xp11_DataIdLookup[77][5]= "Right-Brake" 
xp11_DataIdLookup[77][6]= ""
xp11_DataIdLookup[77][7]= ""
xp11_DataIdLookup[77][8]= ""

xp11_DataIdLookup[78][0]= "Total Vertical Thrust Vectors"
xp11_DataIdLookup[79][0]= "Total lateral thrust vectors"
xp11_DataIdLookup[80][0]= "Pitch cyclic disc tilts"
xp11_DataIdLookup[81][0]= "Roll cyclic disc tilts"
xp11_DataIdLookup[82][0]= "Pitch cyclic flapping"
xp11_DataIdLookup[83][0]= "Roll cyclic flapping"
for i=0,7,1 do
  xp11_DataIdLookup[78][i+1]= "Vertical Thrust Vectors " .. i
  xp11_DataIdLookup[79][i+1]= "Lateral thrust vectors " .. i
  xp11_DataIdLookup[80][i+1]= "Pitch cyclic disc tilts " .. i
  xp11_DataIdLookup[81][i+1]= "Roll cyclic disc tilts " .. i
  xp11_DataIdLookup[82][i+1]= "Pitch cyclic flapping " .. i
  xp11_DataIdLookup[83][i+1]= "Roll cyclic flapping " .. i
end

xp11_DataIdLookup[84][0]= "Ground Effect lift (wings)"
xp11_DataIdLookup[84][1]= "Wing1 L cl*"
xp11_DataIdLookup[84][2]= "Wing1 R cl*"
xp11_DataIdLookup[84][3]= "Wing2 L cl*"
xp11_DataIdLookup[84][4]= "Wing2 R cl*"
xp11_DataIdLookup[84][5]= "Wing3 L cl*"
xp11_DataIdLookup[84][6]= "Wing3 R cl*"
xp11_DataIdLookup[84][7]= "Wing4 L cl*"
xp11_DataIdLookup[84][8]= "Wing4 R cl*"

xp11_DataIdLookup[85][0]= "Ground Effect drag (wings)"
xp11_DataIdLookup[85][1]= "Wing1 Lcdi*"
xp11_DataIdLookup[85][2]= "Wing1 Rcdi*"
xp11_DataIdLookup[85][3]= "Wing2 Lcdi*"
xp11_DataIdLookup[85][4]= "Wing2 Rcdi*"
xp11_DataIdLookup[85][5]= "Wing3 Lcdi*"
xp11_DataIdLookup[85][6]= "Wing3 Rcdi*"
xp11_DataIdLookup[85][7]= "Wing4 Lcdi*"
xp11_DataIdLookup[85][8]= "Wing4 Rcdi*"

xp11_DataIdLookup[86][0]= "Ground Effect wash (wings)"
xp11_DataIdLookup[86][1]= "Wing1 wash*"
xp11_DataIdLookup[86][2]= "Wing1 wash*"
xp11_DataIdLookup[86][3]= "Wing2 wash*"
xp11_DataIdLookup[86][4]= "Wing2 wash*"
xp11_DataIdLookup[86][5]= "Wing3 wash*"
xp11_DataIdLookup[86][6]= "Wing3 wash*"
xp11_DataIdLookup[86][7]= "Wing4 wash*"
xp11_DataIdLookup[86][8]= "Wing4 wash*"

xp11_DataIdLookup[87][0]= "Ground Effect lift (stabilisers)"
xp11_DataIdLookup[87][1]= "hstab L cl*"
xp11_DataIdLookup[87][2]= "hstab R cl*"
xp11_DataIdLookup[87][3]= "vstb1 cl*"
xp11_DataIdLookup[87][4]= "vstb2 cl*"
xp11_DataIdLookup[87][5]= ""
xp11_DataIdLookup[87][6]= ""
xp11_DataIdLookup[87][7]= ""
xp11_DataIdLookup[87][8]= ""

xp11_DataIdLookup[88][0]= "Ground Effect drag (stabilisers)"
xp11_DataIdLookup[88][1]= "hstab Lcdi*"
xp11_DataIdLookup[88][2]= "hstab Rcdi*"
xp11_DataIdLookup[88][3]= "vstb1 cdi*"
xp11_DataIdLookup[88][4]= "vstb2 cdi*"
xp11_DataIdLookup[88][5]= ""
xp11_DataIdLookup[88][6]= ""
xp11_DataIdLookup[88][7]= ""
xp11_DataIdLookup[88][8]= ""

xp11_DataIdLookup[89][0]= "Ground Effect wash (stabilisers)"
xp11_DataIdLookup[89][1]= "hstab wash*"
xp11_DataIdLookup[89][2]= "hstab wash*"
xp11_DataIdLookup[89][3]= "vstb1 wash*"
xp11_DataIdLookup[89][4]= "vstb2 wash*"
xp11_DataIdLookup[89][5]= ""
xp11_DataIdLookup[89][6]= ""
xp11_DataIdLookup[89][7]= ""
xp11_DataIdLookup[89][8]= ""

xp11_DataIdLookup[90][0]= "Wash ratio from Ground Effect (rotors)"
xp11_DataIdLookup[90][1]= "GE rotor 1 wash*"
xp11_DataIdLookup[90][2]= "GE rotor 2 wash*"
xp11_DataIdLookup[90][3]= "GE rotor 3 wash*"
xp11_DataIdLookup[90][4]= "GE rotor 4 wash*"
xp11_DataIdLookup[90][5]= "GE rotor 5 wash*"
xp11_DataIdLookup[90][6]= "GE rotor 6 wash*"
xp11_DataIdLookup[90][7]= "GE rotor 7 wash*"
xp11_DataIdLookup[90][8]= "GE rotor 8 wash*"

xp11_DataIdLookup[91][0]= "Wash ratio from Vortex Effect (rotors)"
xp11_DataIdLookup[91][1]= "VRS rotor 1 wash*"
xp11_DataIdLookup[91][2]= "VRS rotor 2 wash*"
xp11_DataIdLookup[91][3]= "VRS rotor 3 wash*"
xp11_DataIdLookup[91][4]= "VRS rotor 4 wash*"
xp11_DataIdLookup[91][5]= "VRS rotor 5 wash*"
xp11_DataIdLookup[91][6]= "VRS rotor 6 wash*"
xp11_DataIdLookup[91][7]= "VRS rotor 7 wash*"
xp11_DataIdLookup[91][8]= "VRS rotor 8 wash*"

xp11_DataIdLookup[92][0]= "Wing lift"
xp11_DataIdLookup[92][1]= "Wing1 lift"
xp11_DataIdLookup[92][2]= "Wing1 lift"
xp11_DataIdLookup[92][3]= "Wing2 lift"
xp11_DataIdLookup[92][4]= "Wing2 lift"
xp11_DataIdLookup[92][5]= "Wing3 lift"
xp11_DataIdLookup[92][6]= "Wing3 lift"
xp11_DataIdLookup[92][7]= "Wing4 lift"
xp11_DataIdLookup[92][8]= "Wing4 lift"

xp11_DataIdLookup[93][0]= "Wing drag"
xp11_DataIdLookup[93][1]= "Wing1 drag"
xp11_DataIdLookup[93][2]= "Wing1 drag"
xp11_DataIdLookup[93][3]= "Wing2 drag"
xp11_DataIdLookup[93][4]= "Wing2 drag"
xp11_DataIdLookup[93][5]= "Wing3 drag"
xp11_DataIdLookup[93][6]= "Wing3 drag"
xp11_DataIdLookup[93][7]= "Wing4 drag"
xp11_DataIdLookup[93][8]= "Wing4 drag"

xp11_DataIdLookup[94][0]= "Stabilizer lift"
xp11_DataIdLookup[94][1]= "hstab lift"
xp11_DataIdLookup[94][2]= "hstab lift"
xp11_DataIdLookup[94][3]= "vstb1 lift"
xp11_DataIdLookup[94][4]= "vstb2 lift"
xp11_DataIdLookup[94][5]= ""
xp11_DataIdLookup[94][6]= ""
xp11_DataIdLookup[94][7]= ""
xp11_DataIdLookup[94][8]= ""

xp11_DataIdLookup[95][0]= "Stabilizer drag"
xp11_DataIdLookup[95][1]= "hstab drag"
xp11_DataIdLookup[95][2]= "hstab drag"
xp11_DataIdLookup[95][3]= "vstb1 drag"
xp11_DataIdLookup[95][4]= "vstb2 drag"
xp11_DataIdLookup[95][5]= ""
xp11_DataIdLookup[95][6]= ""
xp11_DataIdLookup[95][7]= ""
xp11_DataIdLookup[95][8]= ""

xp11_DataIdLookup[96][0]= "COM1 and COM2 radio freqs"
xp11_DataIdLookup[96][1]= "COM1 Active"
xp11_DataIdLookup[96][2]= "COM1 Standby"
xp11_DataIdLookup[96][3]= "" -- Unused
xp11_DataIdLookup[96][4]= "COM2 Active"
xp11_DataIdLookup[96][5]= "COM2 Standby"
xp11_DataIdLookup[96][6]= ""
xp11_DataIdLookup[96][7]= "Transmit Status"
xp11_DataIdLookup[96][8]= ""

xp11_DataIdLookup[97][0]= "NAV1 and NAV2 radio freqs"
xp11_DataIdLookup[97][1]= "NAV1 Active"
xp11_DataIdLookup[97][2]= "NAV1 Standby"
xp11_DataIdLookup[97][3]= "NAV1 Type"
xp11_DataIdLookup[97][4]= ""
xp11_DataIdLookup[97][5]= "NAV2 Active"
xp11_DataIdLookup[97][6]= "NAV2 Standby"
xp11_DataIdLookup[97][7]= "NAV2 Type"
xp11_DataIdLookup[97][8]= ""

xp11_DataIdLookup[98][0]= "NAV1 and NAV2 OBS"
xp11_DataIdLookup[98][1]= "NAV1 OBS"
xp11_DataIdLookup[98][2]= "NAV1 s-crs"
xp11_DataIdLookup[98][3]= "NAV1 flag"
xp11_DataIdLookup[98][4]= ""
xp11_DataIdLookup[98][5]= "NAV2 OBS"
xp11_DataIdLookup[98][6]= "NAV2 s-crs"
xp11_DataIdLookup[98][7]= "NAV2 flag"
xp11_DataIdLookup[98][8]= ""

xp11_DataIdLookup[99][0]= "NAV1 deflection"
xp11_DataIdLookup[99][1]= "NAV1 n-typ"
xp11_DataIdLookup[99][2]= "NAV1 to-fr"
xp11_DataIdLookup[99][3]= "NAV1 m-crs"
xp11_DataIdLookup[99][4]= "NAV1 r-brg"
xp11_DataIdLookup[99][5]= "NAV1 dme-d"
xp11_DataIdLookup[99][6]= "NAV1 h-def"
xp11_DataIdLookup[99][7]= "NAV1 v-def"
xp11_DataIdLookup[99][8]= ""

xp11_DataIdLookup[100][0]= "NAV2 deflection"
xp11_DataIdLookup[100][1]= "NAV2 n-typ"
xp11_DataIdLookup[100][2]= "NAV2 to-fr"
xp11_DataIdLookup[100][3]= "NAV2 m-crs"
xp11_DataIdLookup[100][4]= "NAV2 r-brg"
xp11_DataIdLookup[100][5]= "NAV2 dme-d"
xp11_DataIdLookup[100][6]= "NAV2 h-def"
xp11_DataIdLookup[100][7]= "NAV2 v-def"
xp11_DataIdLookup[100][8]= ""

xp11_DataIdLookup[101][0]= "ADF1 and ADF2 statuses"
xp11_DataIdLookup[101][1]= "ACF1 frequency"
xp11_DataIdLookup[101][2]= "ADF1 card"
xp11_DataIdLookup[101][3]= "ADF1 r-brg"
xp11_DataIdLookup[101][4]= "ADF1 n-typ"
xp11_DataIdLookup[101][5]= "ACF2 frequency"
xp11_DataIdLookup[101][6]= "ADF2 card"
xp11_DataIdLookup[101][7]= "ADF2 r-brg"
xp11_DataIdLookup[101][8]= "ADF2 n-typ"

xp11_DataIdLookup[102][0]= "DME status"
xp11_DataIdLookup[102][1]= "DME nav01"
xp11_DataIdLookup[102][2]= "DME mode"
xp11_DataIdLookup[102][3]= "DME found"
xp11_DataIdLookup[102][4]= "DME dist"
xp11_DataIdLookup[102][5]= "DME speed"
xp11_DataIdLookup[102][6]= "DME time"
xp11_DataIdLookup[102][7]= "DME n-typ"
xp11_DataIdLookup[102][8]= "DME-3 freq"

xp11_DataIdLookup[103][0]= "GPS status"
xp11_DataIdLookup[103][1]= "GPS mode"
xp11_DataIdLookup[103][2]= "GPS index"
xp11_DataIdLookup[103][3]= "GPS dist - nm"
xp11_DataIdLookup[103][4]= "OSB mag"
xp11_DataIdLookup[103][5]= "crs mag"
xp11_DataIdLookup[103][6]= "rel brng"
xp11_DataIdLookup[103][7]= "hdef dots"
xp11_DataIdLookup[103][8]= "vdef dots"

xp11_DataIdLookup[104][0]= "Transponder status"
xp11_DataIdLookup[104][1]= "trans mode"
xp11_DataIdLookup[104][2]= "trans sett"
xp11_DataIdLookup[104][3]= "trans ID"
xp11_DataIdLookup[104][4]= "trans inter"
xp11_DataIdLookup[104][5]= ""
xp11_DataIdLookup[104][6]= ""
xp11_DataIdLookup[104][7]= ""
xp11_DataIdLookup[104][8]= ""

xp11_DataIdLookup[105][0]= "Marker staus"
xp11_DataIdLookup[105][1]= "Outer Marker - morse"
xp11_DataIdLookup[105][2]= "Middle Marker - morse"
xp11_DataIdLookup[105][3]= "Inner Marker - morse"
xp11_DataIdLookup[105][4]= "audio - active"
xp11_DataIdLookup[105][5]= ""
xp11_DataIdLookup[105][6]= ""
xp11_DataIdLookup[105][7]= ""
xp11_DataIdLookup[105][8]= ""

xp11_DataIdLookup[106][0]= "Electrical switches"
xp11_DataIdLookup[106][1]= "avio 0/1"
xp11_DataIdLookup[106][2]= "Navigation Lights (0/1)"
xp11_DataIdLookup[106][3]= "Beacon Light (0/1)"
xp11_DataIdLookup[106][4]= "Strob Light (0/1)"
xp11_DataIdLookup[106][5]= "Landing Lights (0/1)"
xp11_DataIdLookup[106][6]= "Taxi Lights (0/1)"
xp11_DataIdLookup[106][7]= ""
xp11_DataIdLookup[106][8]= ""

xp11_DataIdLookup[107][0]= "EFIS switches"
xp11_DataIdLookup[107][1]= "ECAM mode`"
xp11_DataIdLookup[107][2]= "EFIS sel 1"
xp11_DataIdLookup[107][3]= "EFIS sel 2"
xp11_DataIdLookup[107][4]= "HSI sel 1"
xp11_DataIdLookup[107][5]= "HSI sel 2"
xp11_DataIdLookup[107][6]= "HSI arc"
xp11_DataIdLookup[107][7]= "map r-sel"
xp11_DataIdLookup[107][8]= "map range"

xp11_DataIdLookup[108][0]= "AP, FD, HUD switches"
xp11_DataIdLookup[108][1]= "Ap - src"
xp11_DataIdLookup[108][2]= "fdir - mode"
xp11_DataIdLookup[108][3]= "fdir - ptch"
xp11_DataIdLookup[108][4]= "fdir - roll"
xp11_DataIdLookup[108][5]= ""
xp11_DataIdLookup[108][6]= "HUD power"
xp11_DataIdLookup[108][7]= "HUD brite"
xp11_DataIdLookup[108][8]= ""

xp11_DataIdLookup[109][0]= "Anti-ice switches"
xp11_DataIdLookup[109][1]= "deice - all"
xp11_DataIdLookup[109][2]= "deice inlet"
xp11_DataIdLookup[109][3]= "deice prop"
xp11_DataIdLookup[109][4]= "deice windo"
xp11_DataIdLookup[109][5]= "deice pito1"
xp11_DataIdLookup[109][6]= "deice piot2"
xp11_DataIdLookup[109][7]= "deice AoA"
xp11_DataIdLookup[109][8]= "devie wing"

xp11_DataIdLookup[110][0]= "Anti-ice and fuel switches"
xp11_DataIdLookup[110][1]= "alt air0"
xp11_DataIdLookup[110][2]= "alt air1"
xp11_DataIdLookup[110][3]= "auto ignit"
xp11_DataIdLookup[110][4]= "audo ignit"
xp11_DataIdLookup[110][5]= "manul ignit"
xp11_DataIdLookup[110][6]= "manul ignit"
xp11_DataIdLookup[110][7]= "l-eng tank"
xp11_DataIdLookup[110][8]= "r-eng tank"

xp11_DataIdLookup[111][0]= "Clutch and artificial stability switches"
xp11_DataIdLookup[111][1]= "prero engag"
xp11_DataIdLookup[111][2]= "prero level"
xp11_DataIdLookup[111][3]= "clutc ratio"
xp11_DataIdLookup[111][4]= ""
xp11_DataIdLookup[111][5]= "art pitch"
xp11_DataIdLookup[111][6]= "art roll"
xp11_DataIdLookup[111][7]= "yaw damp"
xp11_DataIdLookup[111][8]= "auto brake"

xp11_DataIdLookup[112][0]= "Misc switches"
xp11_DataIdLookup[112][1]= "tot energ"
xp11_DataIdLookup[112][2]= "radal feet"
xp11_DataIdLookup[112][3]= "prop sync"
xp11_DataIdLookup[112][4]= "fethr mode"
xp11_DataIdLookup[112][5]= "puffr power"
xp11_DataIdLookup[112][6]= "water scoop"
xp11_DataIdLookup[112][7]= "arrst hook"
xp11_DataIdLookup[112][8]= "chute deply"

xp11_DataIdLookup[113][0]= "Gen. Annunciations 1"
xp11_DataIdLookup[113][1]= "mast cau"
xp11_DataIdLookup[113][2]= "mast wat"
xp11_DataIdLookup[113][3]= "masy accp"
xp11_DataIdLookup[113][4]= "auto disco"
xp11_DataIdLookup[113][5]= "low vacum"
xp11_DataIdLookup[113][6]= "low volt"
xp11_DataIdLookup[113][7]= "fuel quant"
xp11_DataIdLookup[113][8]= "hyd press"

xp11_DataIdLookup[114][0]= "Gen. Annunciations 2"
xp11_DataIdLookup[114][1]= "yawda on"
xp11_DataIdLookup[114][2]= "sbrk on"
xp11_DataIdLookup[114][3]= "GPWS warn"
xp11_DataIdLookup[114][4]= "ice warn"
xp11_DataIdLookup[114][5]= "pitot off"
xp11_DataIdLookup[114][6]= "cabin althi"
xp11_DataIdLookup[114][7]= "afthr arm"
xp11_DataIdLookup[114][8]= "osps time"

xp11_DataIdLookup[115][0]= "Engine annunciations"
xp11_DataIdLookup[115][1]= "fuel press"
xp11_DataIdLookup[115][2]= "oil press"
xp11_DataIdLookup[115][3]= "oil temp"
xp11_DataIdLookup[115][4]= "inver warn"
xp11_DataIdLookup[115][5]= "gener warn"
xp11_DataIdLookup[115][6]= "chip detec"
xp11_DataIdLookup[115][7]= "engin fire"
xp11_DataIdLookup[115][8]= "ignit 0/1"

xp11_DataIdLookup[116][0]= "Autopilot armed status"
xp11_DataIdLookup[116][1]= "nav arm"
xp11_DataIdLookup[116][2]= "alt arm"
xp11_DataIdLookup[116][3]= "app arm"
xp11_DataIdLookup[116][4]= "vnav enab"
xp11_DataIdLookup[116][5]= "vnav warn"
xp11_DataIdLookup[116][6]= "vnav time"
xp11_DataIdLookup[116][7]= "gp enabl"
xp11_DataIdLookup[116][8]= ""

xp11_DataIdLookup[117][0]= "Autopilot modes"
xp11_DataIdLookup[117][1]= "auto throt"
xp11_DataIdLookup[117][2]= "mode hding"
xp11_DataIdLookup[117][3]= "mode alt"
xp11_DataIdLookup[117][4]= ""
xp11_DataIdLookup[117][5]= "bac 0/1"
xp11_DataIdLookup[117][6]= "app"
xp11_DataIdLookup[117][7]= ""
xp11_DataIdLookup[117][8]= "sync butn"

xp11_DataIdLookup[118][0]= "Autopilot values"
xp11_DataIdLookup[118][1]= "set speed"
xp11_DataIdLookup[118][2]= "set hding"
xp11_DataIdLookup[118][3]= "set vvi"
xp11_DataIdLookup[118][4]= "dial alt"
xp11_DataIdLookup[118][5]= "bac vnav alt"
xp11_DataIdLookup[118][6]= "use alt"
xp11_DataIdLookup[118][7]= "sync roll"
xp11_DataIdLookup[118][8]= "sync pitch"

xp11_DataIdLookup[119][0]= "Weapon status"
xp11_DataIdLookup[119][1]= "hdng delta"
xp11_DataIdLookup[119][2]= "ptch delta"
xp11_DataIdLookup[119][3]= "R d/sec"
xp11_DataIdLookup[119][4]= "Q d/sec"
xp11_DataIdLookup[119][5]= "rudd ratio"
xp11_DataIdLookup[119][6]= "elev ratio"
xp11_DataIdLookup[119][7]= "V kts"
xp11_DataIdLookup[119][8]= "dis ft"

xp11_DataIdLookup[120][0]= "Pressurization status"
xp11_DataIdLookup[120][1]= "set alt"
xp11_DataIdLookup[120][2]= "set vvi"
xp11_DataIdLookup[120][3]= "cabin alt"
xp11_DataIdLookup[120][4]= "cabin vvi"
xp11_DataIdLookup[120][5]= "test time"
xp11_DataIdLookup[120][6]= "diff psi"
xp11_DataIdLookup[120][7]= "dump all"
xp11_DataIdLookup[120][8]= "bleed src"

xp11_DataIdLookup[121][0]= "APU and GPU status"
xp11_DataIdLookup[121][1]= "APU runng"
xp11_DataIdLookup[121][2]= "APU N1"
xp11_DataIdLookup[121][3]= "APU rat"
xp11_DataIdLookup[121][4]= "GPU rat"
xp11_DataIdLookup[121][5]= "RAT rat"
xp11_DataIdLookup[121][6]= "APU amp"
xp11_DataIdLookup[121][7]= "GPU amp"
xp11_DataIdLookup[121][8]= "RAT amp"

xp11_DataIdLookup[122][0]= "Radar status"
xp11_DataIdLookup[122][1]= "targ select"
xp11_DataIdLookup[122][2]= ""
xp11_DataIdLookup[122][3]= ""
xp11_DataIdLookup[122][4]= ""
xp11_DataIdLookup[122][5]= ""
xp11_DataIdLookup[122][6]= ""
xp11_DataIdLookup[122][7]= ""
xp11_DataIdLookup[122][8]= ""

xp11_DataIdLookup[123][0]= "Hydraulic status"
xp11_DataIdLookup[123][1]= "eng-1 pump"
xp11_DataIdLookup[123][2]= "eng-2 pump"
xp11_DataIdLookup[123][3]= "ele pum"
xp11_DataIdLookup[123][4]= "RA pum"
xp11_DataIdLookup[123][5]= "hyd qty"
xp11_DataIdLookup[123][6]= "hyd qty"
xp11_DataIdLookup[123][7]= "hyd pres"
xp11_DataIdLookup[123][8]= "hyd pres"

xp11_DataIdLookup[124][0]= "Electrical and solar systems"
xp11_DataIdLookup[124][1]= "bus1 volt"
xp11_DataIdLookup[124][2]= "bus2 volt"
xp11_DataIdLookup[124][3]= "bus1 amp"
xp11_DataIdLookup[124][4]= "bus2 amp"
xp11_DataIdLookup[124][5]= "batt1 w-hr"
xp11_DataIdLookup[124][6]= "batt2 w-hr"
xp11_DataIdLookup[124][7]= "engin in W"
xp11_DataIdLookup[124][8]= "solar out W"

xp11_DataIdLookup[125][0]= "Icing status 1"
xp11_DataIdLookup[125][1]= "inlet ice"
xp11_DataIdLookup[125][2]= "inlet ine"
xp11_DataIdLookup[125][3]= "prop ice"
xp11_DataIdLookup[125][4]= "prop ice"
xp11_DataIdLookup[125][5]= "pitot ice"
xp11_DataIdLookup[125][6]= "pitot ice"
xp11_DataIdLookup[125][7]= "statc ice"
xp11_DataIdLookup[125][8]= "statc ice"

xp11_DataIdLookup[126][0]= "Icing status 2"
xp11_DataIdLookup[126][1]= "aoa ice"
xp11_DataIdLookup[126][2]= "aoa ice"
xp11_DataIdLookup[126][3]= "lwing ice"
xp11_DataIdLookup[126][4]= "rwing ice"
xp11_DataIdLookup[126][5]= "windo ice"
xp11_DataIdLookup[126][6]= ""
xp11_DataIdLookup[126][7]= "carb1 ice"
xp11_DataIdLookup[126][8]= "carb2 ice"

xp11_DataIdLookup[127][0]= "Warning status"
xp11_DataIdLookup[127][1]= "warn time"
xp11_DataIdLookup[127][2]= "caut time"
xp11_DataIdLookup[127][3]= "warn work"
xp11_DataIdLookup[127][4]= "caut work"
xp11_DataIdLookup[127][5]= "gear work"
xp11_DataIdLookup[127][6]= "gear warn"
xp11_DataIdLookup[127][7]= "stall warn"
xp11_DataIdLookup[127][8]= ""

xp11_DataIdLookup[128][0]= "Flight plan legs"
xp11_DataIdLookup[128][1]= "leg #"
xp11_DataIdLookup[128][2]= "leg type"
xp11_DataIdLookup[128][3]= "leg lat"
xp11_DataIdLookup[128][4]= "leg long"
xp11_DataIdLookup[128][5]= ""
xp11_DataIdLookup[128][6]= ""
xp11_DataIdLookup[128][7]= ""
xp11_DataIdLookup[128][8]= ""

xp11_DataIdLookup[129][0]= "Hardware options"
xp11_DataIdLookup[129][1]= "pedal nobrk"
xp11_DataIdLookup[129][2]= "pedal wibrk"
xp11_DataIdLookup[129][3]= "yoke pfc"
xp11_DataIdLookup[129][4]= "pedal pfc"
xp11_DataIdLookup[129][5]= "throt pfc"
xp11_DataIdLookup[129][6]= "cecon pfc"
xp11_DataIdLookup[129][7]= "switc pfc"
xp11_DataIdLookup[129][8]= "btogg pfc"

xp11_DataIdLookup[130][0]= "Camera location"
xp11_DataIdLookup[130][1]= "camra long"
xp11_DataIdLookup[130][2]= "camra lat"
xp11_DataIdLookup[130][3]= "camra ele"
xp11_DataIdLookup[130][4]= "camra hdng"
xp11_DataIdLookup[130][5]= "camra pitch"
xp11_DataIdLookup[130][6]= "camra roll"
xp11_DataIdLookup[130][7]= ""
xp11_DataIdLookup[130][8]= "camra clou"

xp11_DataIdLookup[131][0]= "Ground location"
xp11_DataIdLookup[131][1]= ""
xp11_DataIdLookup[131][2]= ""
xp11_DataIdLookup[131][3]= ""
xp11_DataIdLookup[131][4]= ""
xp11_DataIdLookup[131][5]= ""
xp11_DataIdLookup[131][6]= ""
xp11_DataIdLookup[131][7]= ""
xp11_DataIdLookup[131][8]= ""

xp11_DataIdLookup[132][0]= "Climb stats"
xp11_DataIdLookup[132][1]= "h-spd kt"
xp11_DataIdLookup[132][2]= "v-spd fpm"
xp11_DataIdLookup[132][3]= ""
xp11_DataIdLookup[132][4]= "mult VxVVI"
xp11_DataIdLookup[132][5]= ""
xp11_DataIdLookup[132][6]= ""
xp11_DataIdLookup[132][7]= ""
xp11_DataIdLookup[132][8]= ""

xp11_DataIdLookup[133][0]= "Cruise stats"
xp11_DataIdLookup[133][1]= "ff pph"
xp11_DataIdLookup[133][2]= "ff gph"
xp11_DataIdLookup[133][3]= "speed mph"
xp11_DataIdLookup[133][4]= "eta smpg"
xp11_DataIdLookup[133][5]= "etc nm/lb"
xp11_DataIdLookup[133][6]= "range sm"
xp11_DataIdLookup[133][7]= "endur hours"
xp11_DataIdLookup[133][8]= "mult VxMPG"

xp11_DataIdLookup[134][0]= "Landing gear steering"
xp11_DataIdLookup[134][1]= "Gear 1 deg"
xp11_DataIdLookup[134][2]= "Gear 2 deg"
xp11_DataIdLookup[134][3]= "Gear 3 deg"
xp11_DataIdLookup[134][4]= "Gear 4 deg"
xp11_DataIdLookup[134][5]= "Gear 5 deg"
xp11_DataIdLookup[134][6]= "Gear 6 deg"
xp11_DataIdLookup[134][7]= "Gear 7 deg"
xp11_DataIdLookup[134][8]= "Gear 8 deg"

xp11_DataIdLookup[135][0]= "Motion platform stats"
xp11_DataIdLookup[135][1]= "acc-x m/ss"
xp11_DataIdLookup[135][2]= "acc-y m/ss"
xp11_DataIdLookup[135][3]= "acc-z m/ss"
xp11_DataIdLookup[135][4]= "P rad/s"
xp11_DataIdLookup[135][5]= "Q rad/s"
xp11_DataIdLookup[135][6]= "R rad/s"
xp11_DataIdLookup[135][7]= ""
xp11_DataIdLookup[135][8]= ""

xp11_DataIdLookup[136][0]= "Joystick Raw Axis Deflections"
xp11_DataIdLookup[136][1]= "axis1 ratio"
xp11_DataIdLookup[136][2]= "axis2 ratio"
xp11_DataIdLookup[136][3]= "axis3 ratio"
xp11_DataIdLookup[136][4]= "axis4 ratio"
xp11_DataIdLookup[136][5]= "axis5 ratio"
xp11_DataIdLookup[136][6]= "axis6 ratio"
xp11_DataIdLookup[136][7]= "axis7 ratio"
xp11_DataIdLookup[136][8]= "axis8 ratio"

xp11_DataIdLookup[137][0]= "Gear forces"
xp11_DataIdLookup[137][1]= "norm lb"
xp11_DataIdLookup[137][2]= "axial lb"
xp11_DataIdLookup[137][3]= "side lb"
xp11_DataIdLookup[137][4]= "L lb-ft"
xp11_DataIdLookup[137][5]= "M lb-ft"
xp11_DataIdLookup[137][6]= "N lb-ft"
xp11_DataIdLookup[137][7]= ""
xp11_DataIdLookup[137][8]= ""

xp11_DataIdLookup[138][0]= "Servo Aileron / Elevator / Rudder"
xp11_DataIdLookup[138][1]= "elev servo"
xp11_DataIdLookup[138][2]= "ailrn servo"
xp11_DataIdLookup[138][3]= "ruddr servo"
xp11_DataIdLookup[138][4]= ""
xp11_DataIdLookup[138][5]= ""
xp11_DataIdLookup[138][6]= ""
xp11_DataIdLookup[138][7]= ""
xp11_DataIdLookup[138][8]= ""
