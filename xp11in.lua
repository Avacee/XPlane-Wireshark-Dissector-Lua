local xp11in_info = 
{
    version = "1.0.1",
    author = "Avacee",
    description = "This plugin parses UDP packets inbound to X-Plane 11.",
    repository = "https://github.com/avacee/xp11-Lua-Dissector"
}

set_plugin_info(xp11in_info)

--local d = require('debug')
require "xp11lookups"

xp11in = Proto("xp11in","X-Plane 11 (In)")
xp11in.fields.header= ProtoField.string("xp11in.header", "Header")

xp11in_acfn = Proto("xp11in.acfn", "X-Plane 11 ACFN (Load Aircraft)")
xp11in_acfn.fields.index = ProtoField.int32("xp11in.acfn.index","Index")
xp11in_acfn.fields.path = ProtoField.string("xp11in.acfn.path","Path")
xp11in_acfn.fields.livery = ProtoField.int32("xp11in.acfn.livery","Livery")

xp11in_acpr = Proto("xp11in.acpr","X-Plane 11 ACPR (Load and Position Aircraft)")
xp11in_acpr.fields.index = ProtoField.int32("xp11in.acpr.index","Index")
xp11in_acpr.fields.path = ProtoField.string("xp11in.acpr.path","Path")
xp11in_acpr.fields.livery = ProtoField.int32("xp11in.acpr.livery","Livery")
xp11in_acpr.fields.starttype = ProtoField.int32("xp11in.acpr.starttype","Start Type")
xp11in_acpr.fields.aircraftindex = ProtoField.int32("xp11in.acpr.aircraftindex","Aircraft Index")
xp11in_acpr.fields.ICAO = ProtoField.string("xp11in.acpr.ICAO","ICAO")
xp11in_acpr.fields.runwayindex = ProtoField.int32("xp11in.acpr.runwayindex","Runway Index")
xp11in_acpr.fields.runwaydirection = ProtoField.int32("xp11in.acpr.runwaydirection","Runway Direction")
xp11in_acpr.fields.latitude = ProtoField.double("xp11in.acpr.latitude","Latitude")
xp11in_acpr.fields.longitude = ProtoField.double("xp11in.acpr.longitude","Longitude")
xp11in_acpr.fields.elevation = ProtoField.double("xp11in.acpr.elevation","Elevation")
xp11in_acpr.fields.trueheading = ProtoField.double("xp11in.acpr.trueheading","True Heading")
xp11in_acpr.fields.speed = ProtoField.double("xp11in.acpr.speed","Speed")

xp11in_alrt = Proto("xp11in.alrt","X-Plane 11 ALRT (Message Alert)")
xp11in_alrt.fields.line1 = ProtoField.string("xp11in.alrt.line1","Line 1")
xp11in_alrt.fields.line2 = ProtoField.string("xp11in.alrt.line2","Line 2")
xp11in_alrt.fields.line3 = ProtoField.string("xp11in.alrt.line3","Line 3")
xp11in_alrt.fields.line4 = ProtoField.string("xp11in.alrt.line4","Line 4")

xp11in_cmnd = Proto("xp11in.cmnd"," X-Plane 11 CMND (Command Packet)")
xp11in_cmnd.fields.command = ProtoField.string("xp11in.cmnd.command","Command")

xp11in_data = Proto("xp11in.data", "X-Plane 11 DATA (Data Input)")
xp11in_data.fields.id = ProtoField.float("xp11in.data.id","ID")
xp11in_data.fields.value = ProtoField.float("xp11in.data.value","Value")

xp11in_dcoc = Proto("xp11in.dcoc", "X-Plane 11 DCOC (Enable Cockpit DATA output)")
xp11in_dcoc.fields.id = ProtoField.int32("xp11in.dcoc.id","ID")

xp11in_dref = Proto("xp11in.dref", "X-Plane 11 DREF (Set DataRef)")
xp11in_dref.fields.value = ProtoField.float("xp11in.dref.value","Value")
xp11in_dref.fields.dataref = ProtoField.string("xp11in.dref.dataref","DataRef")

xp11in_dsel = Proto("xp11in.dsel", "X-Plane 11 DSEL (Enable UDP DATA output)")
xp11in_dsel.fields.id = ProtoField.int32("xp11in.dsel.id","ID")

xp11in_fail = Proto("xp11in.fail"," X-Plane 11 FAIL (Fail System by ID)")
xp11in_fail.fields.id = ProtoField.string("xp11in.fail.id","System ID")

xp11in_flir = Proto("xp11in.flir"," X-Plane 11 FLIR (Request FLIR Data) - Last Supported 11.41 - Obsolete in 11.50")
xp11in_flir.fields.framerate = ProtoField.string("xp11in.flir.framerate","Frame Rate")

xp11in_ise4 = Proto("xp11in.ise4","X-Plane 11 ISE4 (ip4 Network Configuration)")
xp11in_ise4.fields.machinetype = ProtoField.int32("xp11in.ise4.machinetpye","Machine Type")
xp11in_ise4.fields.address = ProtoField.string("xp11in.ise4.address","IP Address")
xp11in_ise4.fields.port = ProtoField.string("xp11in.ise4.port","Port")
xp11in_ise4.fields.useip = ProtoField.int32("xp11in.ise4.useip","Use IP")

xp11in_ise6 = Proto("xp11in.ise6","X-Plane 11 ISE6 (ip6 Network Configuration)")
xp11in_ise6.fields.machinetype = ProtoField.int32("xp11in.ise6.machinetpye","Machine Type")
xp11in_ise6.fields.address = ProtoField.string("xp11in.ise6.address","IP Address")
xp11in_ise6.fields.port = ProtoField.string("xp11in.ise6.port","Port")
xp11in_ise6.fields.useip = ProtoField.int32("xp11in.ise6.useip","Use IP")

xp11in_lsnd = Proto("xp11in.lsnd","X-Plane 11 LSND (Loop a Sound)")
xp11in_lsnd.fields.index = ProtoField.int32("xp11in.lsnd.index","Index (0-4)")
xp11in_lsnd.fields.speed = ProtoField.float("xp11in.lsnd.speed","Relative Speed (0->1)")
xp11in_lsnd.fields.volume = ProtoField.float("xp11in.lsnd.volume","Relative Volume (0->1")
xp11in_lsnd.fields.filename = ProtoField.string("xp11in.lsnd.filename","Filename")

xp11in_nfal = Proto("xp11in.nfal","X-Plane 11 NFAL (Fail a NavAid)")
xp11in_nfal.fields.navaidcode = ProtoField.string("xp11in.nfal.navaidcode","Nav Aid Code")

xp11in_nrec = Proto("xp11in.nrec","X-Plane 11 NREC (Recover a NavAid)")
xp11in_nrec.fields.navaidcode = ProtoField.string("xp11in.nrec.navaidcode","Nav Aid Code")

xp11in_objl = Proto("xp11in.objl","X-Plane 11 OBJL (Place an Object)")
xp11in_objl.fields.index = ProtoField.int32("xp11in.objl.index","Index")
xp11in_objl.fields.latitude = ProtoField.double("xp11in.objl.latitude","Latitude")
xp11in_objl.fields.longitude = ProtoField.double("xp11in.objl.longitude","Longitude")
xp11in_objl.fields.elevation = ProtoField.double("xp11in.objl.elevation","Elevation")
xp11in_objl.fields.psi = ProtoField.float("xp11in.objl.psi","True Heading")
xp11in_objl.fields.theta = ProtoField.float("xp11in.objl.theta","Pitch")
xp11in_objl.fields.phi = ProtoField.float("xp11in.objl.phi","Roll")
xp11in_objl.fields.onground = ProtoField.int32("xp11in.objl.onground","Is On Ground")
xp11in_objl.fields.smokesize = ProtoField.float("xp11in.objl.smokesize","Smoke Size")

xp11in_objn = Proto("xp11in.objn","X-Plane 11 OBJN (Load an Object)")
xp11in_objn.fields.index = ProtoField.int32("xp11in.objn.index","Index")
xp11in_objn.fields.filename = ProtoField.string("xp11in.objn.filename","Filename")

xp11in_prel = Proto("xp11in.prel", "X-Plane 11 PREL (Position Aircraft)")
xp11in_prel.fields.starttype = ProtoField.int32("xp11in.prel.starttype","Start Type")
xp11in_prel.fields.aircraftindex = ProtoField.int32("xp11in.prel.aircraftindex","Aircraft Index")
xp11in_prel.fields.ICAO = ProtoField.string("xp11in.prel.ICAO","ICAO")
xp11in_prel.fields.runwayindex = ProtoField.int32("xp11in.prel.runwayindex","Runway Index")
xp11in_prel.fields.runwaydirection = ProtoField.int32("xp11in.prel.runwaydirection","Runway Direction")
xp11in_prel.fields.latitude = ProtoField.double("xp11in.prel.latitude","Latitude")
xp11in_prel.fields.longitude = ProtoField.double("xp11in.prel.longitude","Longitude")
xp11in_prel.fields.elevation = ProtoField.double("xp11in.prel.elevation","Elevation")
xp11in_prel.fields.trueheading = ProtoField.double("xp11in.prel.trueheading","True Heading")
xp11in_prel.fields.speed = ProtoField.double("xp11in.prel.speed","Speed")

xp11in_quit = Proto("xp11in.quit","X-Plane 11 QUIT (Exit X-Plane)")

xp11in_radr = Proto("xp11in.radr","X-Plane 11 RADR (Request RADR packets)")
xp11in_radr.fields.pointcount = ProtoField.string("xp11in.rpos.pointcount","Points Per Frame")

xp11in_reco = Proto("xp11in.reco","X-Plane 11 RECO (Recover a System)")
xp11in_reco.fields.systemid = ProtoField.string("xp11in.reco.systemid","System ID")

xp11in_reco = Proto("xp11in.rese","X-Plane 11 RESE (Reset all failed Systems)")

xp11in_rpos = Proto("xp11in.rpos","X-Plane 11 RPOS (Request RPOS packets)")
xp11in_rpos.fields.frequency = ProtoField.string("xp11in.rpos.frequency","Frequency")

xp11in_rref = Proto("xp11in.rref", "X-Plane 11 RREF (Request/Receive DataRef/s by ID)")
xp11in_rref.fields.id = ProtoField.float("xp11in.rref.id", "RREF ID")
xp11in_rref.fields.value = ProtoField.float("xp11in.rref.value", "Value")
xp11in_rref.fields.dataref = ProtoField.string("xp11in.rref.dataref","DataRef")

xp11in_shut = Proto("xp11in.shut","X-Plane 11 SHUT (Shutdown the computer X-Plane is on)")

xp11in_simo = Proto("xp11in.simo","X-Plane 11 SIMO (Load/Save a Movie or Situation)")
xp11in_simo.fields.action = ProtoField.int32("xp11in.simo.action","ActionID")
xp11in_simo.fields.filename = ProtoField.string("xp11in.simo.filename","Filename")

xp11in_soun = Proto("xp11in.soun","X-Plane 11 SOUN (Play a Sound Once)")
xp11in_soun.fields.speed = ProtoField.float("xp11in.soun.speed","Relative Speed (0->1)")
xp11in_soun.fields.volume = ProtoField.float("xp11in.soun.volume","Relative Volume (0->1")
xp11in_soun.fields.filename = ProtoField.string("xp11in.soun.filename","Filename")

xp11in_ssnd = Proto("xp11in.ssnd","X-Plane 11 SSND (Stop looping a Sound)")
xp11in_ssnd.fields.index = ProtoField.int32("xp11in.ssnd.index","Index (0-4)")
xp11in_ssnd.fields.speed = ProtoField.float("xp11in.ssnd.speed","Relative Speed (0->1)")
xp11in_ssnd.fields.volume = ProtoField.float("xp11in.ssnd.volume","Relative Volume (0->1")
xp11in_ssnd.fields.filename = ProtoField.string("xp11in.ssnd.filename","Filename")

xp11in_ucoc = Proto("xp11in.ucoc", "X-Plane 11 UCOC (Disable Cockpit output)")
xp11in_ucoc.fields.id = ProtoField.int32("xp11in.ucoc.id","ID")

xp11in_usel = Proto("xp11in.usel", "X-Plane 11 USEL (Disable UDP DATA output)")
xp11in_usel.fields.id = ProtoField.int32("xp11in.usel.id","ID")

xp11in_vehx = Proto("xp11in.vehx", "X-Plane 11 VEHX (Place Vehicle)")
xp11in_vehx.fields.id = ProtoField.int32("xp11in.vehx.id","ID")
xp11in_vehx.fields.latitude = ProtoField.double("xp11in.vehx.latitude","Latitude")
xp11in_vehx.fields.longitude = ProtoField.double("xp11in.vehx.longitude","Longitude")
xp11in_vehx.fields.elevation = ProtoField.double("xp11in.vehx.elevation","Elevation")
xp11in_vehx.fields.heading = ProtoField.float("xp11in.vehx.heading","Heading")
xp11in_vehx.fields.pitch = ProtoField.float("xp11in.vehx.pitch","Pitch")
xp11in_vehx.fields.roll = ProtoField.float("xp11in.vehx.roll","Roll")

local function dissectACFN(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_acfn, buffer)
  subtree:add_le(xp11in_acfn.fields.index,buffer(0,4))
  subtree:add_le(xp11in_acfn.fields.path,buffer(4,150))
  subtree:add_le(xp11in_acfn.fields.livery, buffer(156,4))
end

local function dissectACPR(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_acpr, buffer)
  subtree:add_le(xp11in_acpr.fields.index,buffer(0,4))
  subtree:add_le(xp11in_acpr.fields.path,buffer(4,150))
  subtree:add_le(xp11in_acpr.fields.livery, buffer(156,4))
  subtree:add_le(xp11in_prel.fields.starttype,buffer(160,4))
  subtree:add_le(xp11in_prel.fields.aircraftindex,buffer(164,4))
  subtree:add_le(xp11in_prel.fields.ICAO,buffer(168,8))
  subtree:add_le(xp11in_prel.fields.runwayindex,buffer(176,4))
  subtree:add_le(xp11in_prel.fields.runwaydirection ,buffer(180,4))
  subtree:add_le(xp11in_prel.fields.latitude ,buffer(184,8))
  subtree:add_le(xp11in_prel.fields.longitude  ,buffer(192,8))
  subtree:add_le(xp11in_prel.fields.elevation  ,buffer(200,8))
  subtree:add_le(xp11in_prel.fields.trueheading  ,buffer(208,8))
  subtree:add_le(xp11in_prel.fields.speed ,buffer(216,8))
end

local function dissectALRT(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_alrt, buffer())
  subtree:add(xp11in_alrt.fields.line1,buffer(0,240))
  subtree:add(xp11in_alrt.fields.line1,buffer(240,240))
  subtree:add(xp11in_alrt.fields.line1,buffer(480,240))
  subtree:add(xp11in_alrt.fields.line1,buffer(720,240))
end

local function dissectCMND(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_cmnd, buffer)
  subtree:add(xp11in_cmnd.fields.command, buffer)
end

local function dissectDATA(buffer, pinfo, tree)
  local recordCount = buffer:len() / 36
  local subtree = tree:add(xp11in_data, buffer()):append_text(" RecordCount = " .. recordCount)
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

local function dissectDCOC(buffer, pinfo, tree)
  local idcount = (buffer:len()-1) / 4
  local subtree = tree:add(xp11in_dcoc, buffer):append_text(" Count = " .. idcount)
  subtree:add("Item Count = [" .. idcount .. "]")
  for i=0,idcount-1, 1 do
    subtree:add_le(xp11in_dcoc.fields.id,buffer(i*4,4)) 
  end
end

local function dissectDREF(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_dref, buffer)
  subtree:add_le(xp11in_dref.fields.value,buffer(0,4))
  subtree:add_le(xp11in_dref.fields.dataref, buffer(4))
end

local function dissectDSEL(buffer, pinfo, tree)
  local idcount = (buffer:len()-1) / 4
  local subtree = tree:add(xp11in_dsel, buffer):append_text(" Count = " .. idcount)
  for i=0,idcount-1, 1 do
    subtree:add_le(xp11in_dsel.fields.id,buffer(i*4,4)) 
  end
end

local function dissectFAIL(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_fail, buffer)
  subtree:add(xp11in_fail.fields.id, buffer)
end

local function dissectFLIR(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_flir, buffer)
  subtree:add_le(xp11in_flir.fields.framerate, buffer)
end

local function dissectISE4(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_ise, buffer)
  subtree:add_le(xp11in_ise.fields.machinetype,buffer(0,4)):append_text("   " .. xp11_MachineTypeLookup[buffer(0,4):le_int()])
  subtree:add_le(xp11in_ise.fields.address, buffer(4,16))
  subtree:add_le(xp11in_ise.fields.port, buffer(20,8))
  subtree:add_le(xp11in_ise.fields.useip, buffer(28,4))
end

local function dissectISE6(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_ise6, buffer)
  subtree:add_le(xp11in_ise6.fields.machinetype,buffer(0,4)):append_text("   " .. xp11_MachineTypeLookup[buffer(0,4):le_int()])
  subtree:add_le(xp11in_ise6.fields.address, buffer(4,65))
  subtree:add_le(xp11in_ise6.fields.port, buffer(69,6))
  subtree:add_le(xp11in_ise6.fields.useip, buffer(76,4))
end

local function dissectLSND(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_lsnd, buffer)
  subtree:add_le(xp11in_lsnd.fields.index,buffer(0,4))
  subtree:add_le(xp11in_lsnd.fields.speed, buffer(4,4))
  subtree:add_le(xp11in_lsnd.fields.volume, buffer(8,4))
  subtree:add(xp11in_lsnd.fields.filename, buffer(12))
end

local function dissectNFAL(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_nfal, buffer)
  subtree:add(xp11in_nfal.fields.navaidcode, buffer)
end

local function dissectNREC(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_nrec, buffer)
  subtree:add(xp11in_nrec.fields.navaidcode, buffer)
end

local function dissectOBJL(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_objl, buffer)
  subtree:add_le(xp11in_objl.fields.index ,buffer(0,4))
  subtree:add_le(xp11in_objl.fields.latitude,buffer(4,8))
  subtree:add_le(xp11in_objl.fields.longitude ,buffer(12,8))
  subtree:add_le(xp11in_objl.fields.elevation ,buffer(20,8))
  subtree:add_le(xp11in_objl.fields.psi ,buffer(28,4))
  subtree:add_le(xp11in_objl.fields.theta ,buffer(32,4))
  subtree:add_le(xp11in_objl.fields.phi ,buffer(36,4))
  subtree:add_le(xp11in_objl.fields.onground ,buffer(40,4))
  subtree:add_le(xp11in_objl.fields.smokesize ,buffer(44,4))
end

local function dissectOBJN(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_objn, buffer)
  subtree:add_le(xp11in_objn.fields.index ,buffer(0,4))
  subtree:add(xp11in_objn.fields.filename,buffer(4))
end

local function dissectPREL(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_prel, buffer)
  subtree:add_le(xp11in_prel.fields.starttype,buffer(0,4)):append_text("  " .. xp11_StartTypeLookup[buffer(0,4):le_int()])
  subtree:add_le(xp11in_prel.fields.aircraftindex,buffer(4,4))
  subtree:add_le(xp11in_prel.fields.ICAO,buffer(8,8))
  subtree:add_le(xp11in_prel.fields.runwayindex,buffer(16,4))
  subtree:add_le(xp11in_prel.fields.runwaydirection ,buffer(20,4))
  subtree:add_le(xp11in_prel.fields.latitude ,buffer(24,8))
  subtree:add_le(xp11in_prel.fields.longitude  ,buffer(32,8))
  subtree:add_le(xp11in_prel.fields.elevation  ,buffer(40,8))
  subtree:add_le(xp11in_prel.fields.trueheading  ,buffer(48,8))
  subtree:add_le(xp11in_prel.fields.speed ,buffer(56,8))
end

local function dissectQUIT(buffer, pinfo, tree)
  -- There is no data within the QUIT packet as it is simply "QUIT\0"
  -- This stub is only here for subdissector to have something to call and not throw an error
end

local function dissectRADR(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_radr, buffer)
  subtree:add_le(xp11in_radr.fields.pointcount, buffer)
end

local function dissectRECO(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_reco, buffer)
  subtree:add(xp11in_reco.fields.systemid, buffer)
end

local function dissectRESE(buffer, pinfo, tree)
  -- There is no data within the RESE packet as it is simply "RESE\0"
  -- This stub is only here for subdissector to have something to call and not throw an error
end

local function dissectRPOS(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_rpos, buffer)
  subtree:add_le(xp11in_rpos.fields.frequency, buffer)
end

local function dissectRREF(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_rref, buffer)
  subtree:add_le(xp11in_rref.fields.id, buffer(0, 4))
  subtree:add_le(xp11in_rref.fields.value, buffer(4, 4))
  subtree:add_le(xp11in_rref.fields.dataref, buffer(8, 400))
end

local function dissectSHUT(buffer, pinfo, tree)
  -- There is no data within the SHUT packet as it is simply "SHUT\0"
  -- This stub is only here for subdissector to have something to call and not throw an error
end

local function dissectSIMO(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_simo, buffer)
  subtree:add_le(xp11in_simo.fields.action, buffer(0, 4)):append_text("  " .. xp11_SituationLookup[buffer(0, 4):le_int()])
  subtree:add(xp11in_simo.fields.filename, buffer(4))
end

local function dissectSOUN(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_soun, buffer)
  subtree:add_le(xp11in_soun.fields.speed, buffer(0,4))
  subtree:add_le(xp11in_soun.fields.volume, buffer(4,4))
  subtree:add(xp11in_soun.fields.filename, buffer(8))
end

local function dissectSSND(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_ssnd, buffer)
  subtree:add_le(xp11in_ssnd.fields.index,buffer(0,4))
  subtree:add_le(xp11in_ssnd.fields.speed, buffer(4,4))
  subtree:add_le(xp11in_ssnd.fields.volume, buffer(8,4))
  subtree:add(xp11in_ssnd.fields.filename, buffer(12))
end

local function dissectUCOC(buffer, pinfo, tree)
  local idcount = (buffer:len()-1) / 4
  local subtree = tree:add(xp11in_ucoc, buffer):append_text(" Count = " .. idcount)
  for i=0,idcount-1, 1 do
    subtree:add_le(xp11in_ucoc.fields.id,buffer(i*4,4)) 
  end
end

local function dissectUSEL(buffer, pinfo, tree)
  local idcount = (buffer:len()-1) / 4
  local subtree = tree:add(xp11in_usel, buffer):append_text(" Count = " .. idcount)
  for i=0,idcount-1, 1 do
    subtree:add_le(xp11in_usel.fields.id,buffer(i*4,4)) 
  end
end

local function dissectVEHX(buffer, pinfo, tree)
  local subtree = tree:add(xp11in_vehx,buffer)
  subtree:add_le(xp11in_vehx.fields.id,buffer(0,4))
  subtree:add_le(xp11in_vehx.fields.latitude ,buffer(4,8))
  subtree:add_le(xp11in_vehx.fields.longitude  ,buffer(12,8))
  subtree:add_le(xp11in_vehx.fields.elevation  ,buffer(20,8))
  subtree:add_le(xp11in_vehx.fields.heading ,buffer(28,4))
  subtree:add_le(xp11in_vehx.fields.pitch ,buffer(32,4))
  subtree:add_le(xp11in_vehx.fields.roll ,buffer(36,4))
end

local subdissectors = {
  ACFN = dissectACFN, -- Checked
  ACPR = dissectACPR, -- Checked
  ALRT = dissectALRT, -- Checked
  CMND = dissectCMND, -- Checked
  DATA = dissectDATA, -- Checked
  DCOC = dissectDCOC, -- Checked
  DREF = dissectDREF, -- Checked
  DSEL = dissectDSEL, -- Checked
  FAIL = dissectFAIL, -- Checked
  ISE4 = dissectISE4, -- Checked
  ISE6 = dissectISE6,
  LSND = dissectLSND, -- Doesn't play audio - bug submitted.
  NFAL = dissectNFAL, -- Doesn't throw a wobbly but no way to check the Navaid Status when I don't know the ID<>Navaid Map.
  NREC = dissectNREC, -- Doesn't throw a wobbly but no way to check the Navaid Status when I don't know the ID<>Navaid Map.
  OBJL = dissectOBJL, -- Checked
  OBJN = dissectOBJN, -- Checked 
  PREL = dissectPREL, -- Checked
  QUIT = dissectQUIT, -- Checked
  RADR = dissectRADR, -- Checked
  RECO = dissectRECO, -- Checked
  RESE = dissectRESE, -- Checked
  RPOS = dissectRPOS, -- Checked
  RREF = dissectRREF, -- Checked
  SHUT = dissectSHUT, -- Checked (Note: doesn't show up as shutdown is in progress before Wireshark has time to show it)
  SIMO = dissectSIMO, -- Checked
  SOUN = dissectSOUN, -- Checked
  SSND = dissectSSND, -- No way to check if audio stops looping as LSND doesn't appear to work.
  UCOC = dissectUCOC, -- Checked
  USEL = dissectUSEL, -- Checked
  FLIR = dissectFLIR, -- Checked
  VEHX = dissectVEHX, -- Checked
}

function xp11in.dissector(buffer, pinfo, tree)
  local headerbytes = buffer(0, 4)
  local header = headerbytes:string()
  pinfo.cols.protocol = "xp11in (" .. header .. ")"
  local subtree = tree:add(xp11in, buffer(), "X-Plane 11, Header:", header)
  subtree:add(xp11in.fields.header, headerbytes)
  local db = buffer(5)
  subtree:add(db, "[Packet Length: " .. db:len() .. "]")
  subdissectors[header](db, pinfo, tree)
end

ut = DissectorTable.get("udp.port")
ut:add(49000, xp11in); -- Default value - must match X-Plane->Settings->Network->UDP Ports->Port we receive on (legacy)