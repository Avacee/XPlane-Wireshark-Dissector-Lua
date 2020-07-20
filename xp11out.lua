local xp11out_info = 
{
    version = "1.0.1",
    author = "Avacee",
    description = "This plugin parses outbound UDP packets from X-Plane 11.",
    repository = "https://github.com/avacee/xp11-Lua-Dissector"
}

set_plugin_info(xp11out_info)

--local d = require('debug')
require "xp11lookups"
require "xp11Datalookups"

xp11out = Proto("xp11out","X-Plane 11 (Out)")
xp11out.fields.header= ProtoField.string("xp11out.header", "Header")

xp11out_becn = Proto("xp11out.becn"," X-Plane 11 BECN (Beacon Packet)")
xp11out_becn.fields.major = ProtoField.uint8("xp11out.becn.major", "Major Version")
xp11out_becn.fields.minor = ProtoField.uint8("xp11out.becn.minor", "Minor Version")
xp11out_becn.fields.appid = ProtoField.int32("xp11out.becn.appid", "Host ID")
xp11out_becn.fields.version = ProtoField.int32("xp11out.becn.version", "Version Number")
xp11out_becn.fields.role = ProtoField.uint32("xp11out.becn.role", "Role")
xp11out_becn.fields.port = ProtoField.uint16("xp11out.becn.port", "Port")
xp11out_becn.fields.name = ProtoField.stringz("xp11out.becn.name", "Computer Name")

xp11out_data = Proto("xp11out.data", "X-Plane 11 DATA (Data Output)")
xp11out_data.fields.id = ProtoField.float("xp11out.data.id","ID")
xp11out_data.fields.value = ProtoField.float("xp11out.data.value","Value")

xp11out_dref = Proto("xp11out.dref", "X-Plane 11 DREF (DataRef)")
xp11out_dref.fields.value = ProtoField.float("xp11out.dref.value","Value")
xp11out_dref.fields.dataref = ProtoField.string("xp11out.dref.dataref","DataRef")

xp11out_flir = Proto("xp11out.flir"," X-Plane 11 FLIR (FLIR Image Data)")
xp11out_flir.fields.height = ProtoField.int16("xp11in.flir.height","Height")
xp11out_flir.fields.width = ProtoField.int16("xp11in.flir.width","Width")
xp11out_flir.fields.frameindex = ProtoField.char("xp11in.flir.frameindex","Frame Index")
xp11out_flir.fields.framecount = ProtoField.char("xp11in.flir.framecount","Frame Count")
xp11out_flir.fields.imagedata = ProtoField.none("Xp11.flir.imagedata","Image Data (DXT1 Encoded)")

xp11out_radr = Proto("xp11out.radr", "X-Plane 11 RADR (Weather Radar)")
xp11out_radr.fields.longitude = ProtoField.float("xp11out.radr.longitude", "Longitude")
xp11out_radr.fields.latitude = ProtoField.float("xp11out.radr.latitude", "Latitude")
xp11out_radr.fields.precipitation = ProtoField.char("xp11out.radr.precipitation", "Precipitation")
xp11out_radr.fields.height = ProtoField.float("xp11out.radr.height", "Storm Top")

xp11out_rpos = Proto("xp11out.rpos", "X-Plane 11 RPOS (Position)")
xp11out_rpos.fields.longitude = ProtoField.double("xp11out.rpos.longitude", "Longitude")
xp11out_rpos.fields.latitude = ProtoField.double("xp11out.rpos.latitude", "Latitude")
xp11out_rpos.fields.elevation = ProtoField.double("xp11out.rpos.elevation", "Altitude (metres above mean sea level)")
xp11out_rpos.fields.height = ProtoField.float("xp11out.rpos.height", "Height (metres above ground)")
xp11out_rpos.fields.theta = ProtoField.float("xp11out.rpos.theta", "Pitch (degrees)")
xp11out_rpos.fields.psi = ProtoField.float("xp11out.rpos.psi", "True Heading (degrees)")
xp11out_rpos.fields.phi = ProtoField.float("xp11out.rpos.phi", "Roll (degrees)")
xp11out_rpos.fields.vx = ProtoField.float("xp11out.rpos.vx", "Velocity (east)")
xp11out_rpos.fields.vy = ProtoField.float("xp11out.rpos.vy", "Velocity (vertical)")
xp11out_rpos.fields.vz = ProtoField.float("xp11out.rpos.vz", "Velocity (south)")
xp11out_rpos.fields.rollrate = ProtoField.float("xp11out.rpos.rollrate", "Roll Rate")
xp11out_rpos.fields.pitchrate = ProtoField.float("xp11out.rpos.pitchrate", "Pitch Rate")
xp11out_rpos.fields.yawrate = ProtoField.float("xp11out.rpos.yawrate", "Yaw Rate")

xp11out_rref = Proto("xp11out.rref", "X-Plane 11 RREF (DataRef by ID)")
xp11out_rref.fields.id = ProtoField.int32("xp11out.rref.id", "RREF ID")
xp11out_rref.fields.value = ProtoField.float("xp11out.rref.value", "Value")
xp11out_rref.fields.dataref = ProtoField.string("xp11out.rref.dataref","DataRef")

local function dissectBECN(buffer, pinfo, tree)
  local subtree = tree:add(xp11out_becn, buffer)
  subtree:add_le(xp11out_becn.fields.major,buffer(0,1))
  subtree:add_le(xp11out_becn.fields.minor ,buffer(1,1))
  subtree:add_le(xp11out_becn.fields.appid ,buffer(2,4))
  subtree:add_le(xp11out_becn.fields.version ,buffer(6,4))
  subtree:add_le(xp11out_becn.fields.role ,buffer(10,4)):append_text("   " .. xp11_BeaconTypeLookup[buffer(10,4):le_int()])
  subtree:add_le(xp11out_becn.fields.port ,buffer(14,2))
  subtree:add_le(xp11out_becn.fields.name ,buffer(16,buffer:len()-16))
end

local function dissectDATA(buffer, pinfo, tree)
  local recordCount = buffer:len() / 36
  local subtree = tree:add(xp11out_data, buffer()):append_text(" RecordCount = " .. recordCount)
  for i=0, recordCount-1, 1 do
    local index = buffer(i*36,4):le_uint()
    local desc = xp11_DataIdLookup[index][0]
    if desc == nil then
      desc = "Unknown - " .. index
    end
    local branch = subtree:add(buffer(i*36,36), "ID:  " .. index .. "  " .. desc)
    for j=1,8,1 do
      local offset = (i*36) + j*4
      branch:add_le(buffer(offset,4), "[" .. j .. "]:  " .. buffer(offset, 4):le_float() .. "  " .. xp11_DataIdLookup[index][j])
    end
  end
end

local function dissectDREF(buffer, pinfo, tree)
  local subtree = tree:add(xp11out_dref, buffer)
  subtree:add_le(xp11out_dref.fields.value,buffer(0,4))
  subtree:add(xp11out_dref.fields.dataref, buffer(4))
end

local function dissectFLIR(buffer, pinfo, tree)
  local subtree = tree:add(xp11out_flir, buffer)
  subtree:add_le(xp11out_flir.fields.height,buffer(0,2))
  subtree:add_le(xp11out_flir.fields.width,buffer(2,2))
  subtree:add_le(xp11out_flir.fields.frameindex,buffer(4,1))
  subtree:add_le(xp11out_flir.fields.framecount,buffer(5,1))
  --subtree:add_le(xp11out_fliat.fields.imagedata,buffer(6,buffer:len()-6)
end

local function dissectRADR(buffer, pinfo, tree)
  local count = buffer:len() / 13
  local subtree = tree:add(xp11out_radr, buffer()):append_text(" Count = " .. count)
  for i = 0, count - 1 do
    local branch = subtree:add(xp11out_radr, buffer(i * 13,13)):set_text("Radr " .. i)
    branch:add_le(xp11out_radr.fields.longitude, buffer(i * 13,4))
    branch:add_le(xp11out_radr.fields.latitude, buffer((i * 13) + 4,4))
    branch:add_le(xp11out_radr.fields.precipitation, buffer((i * 13) + 8,1))
    branch:add_le(xp11out_radr.fields.height, buffer((i * 13) + 9,4))
  end
end

local function dissectRPOS(buffer, pinfo, tree)
  local subtree = tree:add(xp11out_rpos, buffer())
  subtree:add_le(xp11out_rpos.fields.longitude, buffer(0, 8))
  subtree:add_le(xp11out_rpos.fields.latitude, buffer(8, 8))
  subtree:add_le(xp11out_rpos.fields.elevation, buffer(16, 8))
  subtree:add_le(xp11out_rpos.fields.height, buffer(24, 4))
  subtree:add_le(xp11out_rpos.fields.theta, buffer(28, 4))
  subtree:add_le(xp11out_rpos.fields.psi, buffer(32, 4))
  subtree:add_le(xp11out_rpos.fields.phi, buffer(36, 4))
  subtree:add_le(xp11out_rpos.fields.vx, buffer(40, 4))
  subtree:add_le(xp11out_rpos.fields.vy, buffer(44, 4))
  subtree:add_le(xp11out_rpos.fields.vz, buffer(48, 4))
  subtree:add_le(xp11out_rpos.fields.rollrate, buffer(52, 4))
  subtree:add_le(xp11out_rpos.fields.pitchrate, buffer(56, 4))
  subtree:add_le(xp11out_rpos.fields.yawrate, buffer(60, 4))
end

local function dissectRREF(buffer, pinfo, tree)
  local rrefcount = buffer:len() / 8
  local subtree = tree:add(xp11out_rref, buffer):append_text(" rref count = " .. rrefcount)
  for i = 0, rrefcount - 1, 1 do
    local branch = subtree:add(buffer(i*8,8), "RREF - Index [" .. i .. "]")
    branch:add_le(xp11out_rref.fields.id, buffer(i*8, 4))
    branch:add_le(xp11out_rref.fields.value, buffer((i*8) + 4, 4))
  end
end

local subdissectors = {
  BECN = dissectBECN, -- Checked
  DATA = dissectDATA, -- Checked
  DREF = dissectDREF, -- Checked
  FLIR = dissectFLIR, -- Checked
  RADR = dissectRADR, -- Checked
  RPOS = dissectRPOS, -- Checked
  RREF = dissectRREF, -- Checked
}

function xp11out.dissector(buffer, pinfo, tree)
  local headerbytes = buffer(0, 4)
  local header = headerbytes:string()
  if ((pinfo.src_port == 49001 or pinfo.src_port == 49002 or pinfo.src_port == 49707) and subdissectors[header] ~= nil) then
    pinfo.cols.protocol = "xp11out (" .. header .. ")"
    local subtree = tree:add(xp11out, buffer(), "X-Plane 11, Header:", header)
    subtree:add(xp11out.fields.header, headerbytes)
    local db = buffer(5)
    subtree:add(db, "[Packet Length: " .. db:len() .. "]")
    subdissectors[header](db, pinfo, tree)
    return true
  else
    return false
  end
end

xp11out:register_heuristic("udp",  xp11out.dissector)

-- ut = DissectorTable.get("udp.port")
-- ut:add(49001, xp11out); -- Default value - must match X-Plane->Settings->Network->UDP Ports->Port we send from (legacy)
-- ut:add(49002, xp11out); -- FLIR is emitted from 49002
-- ut:add(49707, xp11out); -- BECN is multicast to 239.255.1.1:49707