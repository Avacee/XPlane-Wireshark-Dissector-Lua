# xp11-Lua-Dissector
**Wireshark Dissector for X-Plane UDP Packets**

To install simply download and copy xplane.lua into Wireshark's "Personal Lua Plugins" folder or "Global Lua Plugins" folder.\
To locate this folder in Wireshark goto Help -> About -> Folders Tab.\
To check if the script is loaded goto Help -> About -> Plugins. The Type will be "lua script"\
Ctrl + Shift + L will reload Lua scripts without needing to restart.

The proto declaration is "xplane" and the protofields have been added using the format xplane.$header$.$element".
So to view only BECN packets the display filter will be "xplane.becn"
Conversely to see all packet except BECN (as there are so many) filter on "xplane && !xplane.becn"
To only see those **DATA** packets with an index of 0 (Frame Rate info) filter on "xplane.data.id == 0"

There is now a Preference for the **BECN** port number (Default 49707)

Todo List:
- [ ] Check **ISE6** packet (only **ISE4** checked so far).
- [X] Finish detailing the **DATA** packet fields (about 2/3rds complete).
- [ ] Display an upper+lower range limit in field descriptions where appropriate.
- [ ] Front pad any appended text for a field description so it lines up nicely.
- [ ] Add more Datarefs in the **DATA** field description when there's a 1-1 relationship.

Wish List:
- [X] Recreate as one script
- [ ] Capture inbound **RREF** packets, store the ID+Dataref then map it back for an outbound **RREF** so it can show the Dataref description.
- [ ] Use a colour filter / warning if a value is outside its range limits.
