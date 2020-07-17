# xp11-Lua-Dissector
**Wireshark Dissector for X-Plane11 UDP Packets**

To install simply download and copy the 4 scripts into Wireshark's "Personal Lua Plugins" folder or "Global Lua Plugins" folder.\
To locate this folder in Wireshark goto Help -> About -> Folders Tab.\
To check if the scripts are loaded goto Help -> About -> Plugins. The Type will be "lua script"\
Ctrl + Shift + L will reload Lua scripts without needing to restart.

- **xp11out.lua**: This script is for the packets that X-Plane sends out.\
Proto's are registered as "**xp11out.packetheader.fieldname**" so "**xp11out**" or "**xp11out.$packetheader$**" can be entered as a filter.

- **xp11in.lua**: This script is for the packets users send to X-Plane.\
Proto's are registered as "**xp11in.packetheader.fieldname**" so "**xp11in**" or "**xp11in.$packetheader$**" can be entered as a filter.

- **xpDATAlookups.lua**: 2D Lookup table containing the descriptive names for the DATA packets. Both Headers and Fields.

- **xplookups.lua**: Contains lookups for when the packet's field is an enum.


Note1: these scripts were developed and tested on Windows only. I have no means of testing them on other OS's.\
Note2: Split into 4 files simply because I was finding it annoying to keep scrolling up and down. There's no reason the code can't all be copy+pasted into one script.

Todo List:
- [ ] xp11in.lua - Check ISE6 packet (only ISE4 checked so far).
- [ ] Finish detailing the DATA packet fields (about 2/3rds complete).
- [ ] Display an upper+lower range limit in field descriptions where appropriate.
- [ ] Front pad any appended text for a field description so it lines up nicely.

Wish List:
- [ ] Recreate as one script and capture inbound RREF's / store the ID+DataRef / map it back for an outbound RREF so it can show the Dataref description.
- [ ] Use a colour filter / warning if a value is outside its range limits.
