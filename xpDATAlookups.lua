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

xp11_DataIdLookup[84][0]= "Wing ground effect lift"
xp11_DataIdLookup[85][0]= "Wing ground effect drag"
xp11_DataIdLookup[86][0]= "Wing ground effect wash"
xp11_DataIdLookup[87][0]= "Stabilizer ground effect lift"
xp11_DataIdLookup[88][0]= "Stabilizer ground effect drag"
xp11_DataIdLookup[89][0]= "Stabilizer ground effect wash"
xp11_DataIdLookup[90][0]= "Propeller ground effect lift"
xp11_DataIdLookup[91][0]= "Propeller ground effect drag"
xp11_DataIdLookup[92][0]= "Wing lift"
xp11_DataIdLookup[93][0]= "Wing drag"
xp11_DataIdLookup[94][0]= "Stabilizer lift"
xp11_DataIdLookup[95][0]= "Stabilizer drag"
xp11_DataIdLookup[96][0]= "COM1 and COM2 radio freqs"
xp11_DataIdLookup[97][0]= "NAV1 and NAV2 radio freqs"
xp11_DataIdLookup[98][0]= "NAV1 and NAV2 OBS"
xp11_DataIdLookup[99][0]= "NAV1 deflection"
xp11_DataIdLookup[100][0]= "NAV2 deflection"
xp11_DataIdLookup[101][0]= "ADF1 and ADF2 statuses"
xp11_DataIdLookup[102][0]= "DME status"
xp11_DataIdLookup[103][0]= "GPS tatus"
xp11_DataIdLookup[104][0]= "Xpdr status"
xp11_DataIdLookup[105][0]= "Marker staus"
xp11_DataIdLookup[106][0]= "Electrical switches"
xp11_DataIdLookup[107][0]= "EFIS switches"
xp11_DataIdLookup[108][0]= "AP, FD, HUD switches"
xp11_DataIdLookup[109][0]= "Anti-ice switches"
xp11_DataIdLookup[110][0]= "Anti-ice and fuel switches"
xp11_DataIdLookup[111][0]= "Clutch and artificial stability switches"
xp11_DataIdLookup[112][0]= "Misc switches"
xp11_DataIdLookup[113][0]= "Gen. Annunciations 1"
xp11_DataIdLookup[114][0]= "Gen. Annunciations 2"
xp11_DataIdLookup[115][0]= "Engine annunciations"
xp11_DataIdLookup[116][0]= "Autopilot armed status"
xp11_DataIdLookup[117][0]= "Autopilot modes"
xp11_DataIdLookup[118][0]= "Autopilot values"
xp11_DataIdLookup[119][0]= "Weapon status"
xp11_DataIdLookup[120][0]= "Pressurization status"
xp11_DataIdLookup[121][0]= "APU and GPU status"
xp11_DataIdLookup[122][0]= "Radar status"
xp11_DataIdLookup[123][0]= "Hydraulic status"
xp11_DataIdLookup[124][0]= "Electrical and solar systems"
xp11_DataIdLookup[125][0]= "Icing status 1"
xp11_DataIdLookup[126][0]= "Icing status 2"
xp11_DataIdLookup[127][0]= "Warning status"
xp11_DataIdLookup[128][0]= "Flight plan legs"
xp11_DataIdLookup[129][0]= "Hardware options"
xp11_DataIdLookup[130][0]= "Camera location"
xp11_DataIdLookup[131][0]= "Ground location"
xp11_DataIdLookup[132][0]= "Climb stats"
xp11_DataIdLookup[133][0]= "Cruise stats"
xp11_DataIdLookup[134][0]= "Landing gear steering"
xp11_DataIdLookup[135][0]= "Motion platform stats"
xp11_DataIdLookup[136][0]= "Joystick Raw Axis Deflections"
xp11_DataIdLookup[137][0]= "Gear forces"
xp11_DataIdLookup[138][0]= "Servo Aileron / Elevator / Rudder"

