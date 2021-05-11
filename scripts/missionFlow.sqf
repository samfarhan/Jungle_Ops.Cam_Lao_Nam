// Wait for a player to find the base.
call fnc_checkPlayersInAoBase;

// Wait for cache to be destroyed.
waitUntil {sleep 2; !alive TargetCache };
["taskMain", "SUCCEEDED"] call BIS_fnc_taskSetState;
//"vn_unsung_heroes" remoteExec ["playMusic"];
"vn_unsung_heroes" remoteExec ["fnc_smoothPlayMusic"];

// Choose extract LZ.
_lzSites = [lz_1, lz_2, lz_3, lz_4, lz_5, lz_6, lz_7, lz_8, lz_9, lz_10, lz_11, lz_12, lz_13, lz_14, lz_15, lz_16, lz_17];
_sitesWithinRadius = [];
{
	_dist = [position _x, AOPosition] call BIS_fnc_distance2D;
	// Within AO radius, and not the dropoff LZ.
	if(_dist < AORadius && _x != LZSite) then
	{
		_sitesWithinRadius append [_x];
	};
} forEach _lzSites;
PickupSite = _sitesWithinRadius call BIS_fnc_selectRandom;
LZExtractPosition = position PickupSite;
publicVariable "LZExtractPosition";

// Create marker on LZ extract.
_lzExtractMarker = createMarker ["MarkerLZExtract", LZExtractPosition];
_lzExtractMarker setMarkerType "mil_dot";
_lzExtractMarker setMarkerText "LZ Rome";
_lzExtractMarker setMarkerColor "ColorBLUFOR";
"MarkerLZInsert" setMarkerColor "ColorGrey";

// Create trigger around extract.
ExtractTrigger = createTrigger ["EmptyDetector", LZExtractPosition];
ExtractTrigger setTriggerArea [40, 40, 0, false];
ExtractTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
ExtractTrigger setTriggerStatements ["this", "PlayersAtExtract = true;", ""];

// Task players move to LZ.
PlayersAtExtract = false;
publicVariable "PlayersAtExtract";
[groupPlayers, "taskMoveExtract", ["Move to the extraction LZ.", "Extract", "LZ Rome"], LZExtractPosition, "ASSIGNED", 1, true, "move"] call BIS_fnc_taskCreate;

// Spawn AI at LZ, moving towards team leader.
call fnc_lzHostiles;

// Spawn AI at LZ and send to tracker.
/*
[leader groupPlayers] call VN_ms_fnc_tracker_tracksCreate;
[LZExtractPosition, 2, east, "VN"] call VN_ms_fnc_tracker_spawnGroup;
*/

waitUntil
{
	PlayersAtExtract
};

["taskMoveExtract", "SUCCEEDED"] call BIS_fnc_taskSetState;

// Send heli to extract LZ.
call fnc_heliWaypointPickup;

// Create extract task.
[groupPlayers, "taskWaitExtract", ["Wait for the chopper at the extraction LZ.", "Wait For Chopper", "Extract"], LZExtractPosition, "ASSIGNED", 1, true, "wait"] call BIS_fnc_taskCreate;

ExtractHeliArrived = false;
waitUntil { sleep 2; ExtractHeliArrived };

_smoke = "SmokeShellRed" createVehicle LZExtractPosition;
["taskWaitExtract", "SUCCEEDED"] call BIS_fnc_taskSetState;
[groupPlayers, "taskBoardExtract", ["Board the chopper at the extraction LZ.", "Board Chopper", "Extract"], LZExtractPosition, "ASSIGNED", 1, true, "getin"] call BIS_fnc_taskCreate;

// Wait for all players to board.
call fnc_checkPlayersInHeliReturn;

["taskBoardExtract", "SUCCEEDED"] call BIS_fnc_taskSetState;
"vn_up_here_looking_down" remoteExec ["fnc_smoothPlayMusic"];

// Create RTB task.
[groupPlayers, "taskRTB", ["Return to base.", "RTB", "Base"], helipadBase, "ASSIGNED", 1, true, "exit"] call BIS_fnc_taskCreate;

// Send heli back to base.
_wp = heliGroup2 addWaypoint [(position helipadBase), 0];
_wp setWaypointType "TR UNLOAD";
_wp setWaypointStatements ["true", "this execVM 'scripts\heliUnloadedAtBase.sqf';"];

waitUntil { sleep 2; HasRTB };

sleep 10;

_end = "End1" remoteExec ["BIS_fnc_endMission"];