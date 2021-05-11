// Logic flow =>
// fnc_generateAoBase => fnc_generateMissionTasks => fnc_generateInitialTasks => fnc_generateAoMarkers => 
// fnc_checkPlayersInHeliDepart => fnc_heliWaypointDropoff => TeamInserted => fnc_populateAo => missionFlow.sqf =>
// fnc_checkPlayersInAoBase => !alive TargetCache => PlayersAtExtract => fnc_heliWaypointPickup => fnc_checkPlayersInHeliReturn => HasRTB

// Set weather from parameters.
_rain = "EnvRain" call BIS_fnc_getParamValue;
_fog = "EnvFog" call BIS_fnc_getParamValue;
_lightning = "EnvLightning" call BIS_fnc_getParamValue;
0 setRain _rain;
0 setFog _fog;
0 setLightnings _lightning;
forceWeatherChange;

// Set respawn from parameters.
_respawnOn = "RespawnOn" call BIS_fnc_getParamValue;
RespawnEnabled = false;
if(_respawnOn == 1) then 
{
	RespawnEnabled = true;
};
_respawnTickets = "RespawnTickets" call BIS_fnc_getParamValue;
if(RespawnEnabled) then 
{
	[west, _respawnTickets] call BIS_fnc_respawnTickets;
	// Add respawn to team leader.
	TeamRespawnPoint = [west, leader groupPlayers, "Team Leader"] call BIS_fnc_addRespawnPosition;
}
else 
{
	[west, -100] call BIS_fnc_respawnTickets;
};

// Select AO site.
_aoSites = [site1, site2, site3, site4];
AOPosition = getPos (_aoSites call BIS_fnc_selectRandom);
publicVariable "AOPosition";
AORadius = 1500;
publicVariable "AORadius";
ObjectiveRadius = 250;
publicVariable "ObjectiveRadius";
LZBufferRadius = 300;

// Select an LZ.
_lzRadius = 400;
_lzSites = [lz_1, lz_2, lz_3, lz_4, lz_5, lz_6, lz_7, lz_8, lz_9, lz_10, lz_11, lz_12, lz_13, lz_14, lz_15, lz_16, lz_17];
_sitesWithinRadius = [];
{
	_dist = [position _x, AOPosition] call BIS_fnc_distance2D;
	// Outside AO radius - LZBufferRadius, within AO radius + LZ radius.
	if(_dist > (AORadius - LZBufferRadius) && _dist < (AORadius + LZBufferRadius)) then
	{
		_sitesWithinRadius append [_x];
	};
} forEach _lzSites;
LZSite = _sitesWithinRadius call BIS_fnc_selectRandom;
LZInsertPosition = position LZSite;
publicVariable "LZInsertPosition";
//_helipadInsert = ([LZInsertPosition, 0, "Land_HelipadEmpty_F", sideEmpty] call BIS_fnc_spawnVehicle) select 0;

// Spawn target base.
BaseFound = false;
publicVariable "BaseFound";
call fnc_generateAoBase;

// Generate tasks for mission.
call fnc_generateMissionTasks;

// Create initial tasks.
call fnc_generateInitialTasks;

// Create MP markers.
_markers = call fnc_generateAoMarkers;
AOMarker = _markers select 0;
ObjectiveMarker = _markers select 1;
ObjectiveTextMarker = _markers select 2;
LZInsertMarker = _markers select 3;

// Activate tracker module to populate AO.
/*
[] call VN_ms_fnc_tracker_preInit;
[[AOPosition, AORadius, AORadius, 0], east, { true; }, 2] call VN_ms_fnc_tracker_overlord_init;
[trackerModule, units groupPlayers, true] call VN_ms_module_fnc_tracker_ao;
trackerModule setPosATL AOPosition;
"scripts\addTrackerGroupsToZeus.sqf" call BIS_fnc_execVM;
*/

// Wait for all players to board heli.
call fnc_checkPlayersInHeliDepart;

// Move to LZ mission.
[groupPlayers, "moveToLZ", ["Move to LZ.", "Insert", "LZ Tokyo"], LZInsertPosition, "ASSIGNED", 1, true, "land"] call BIS_fnc_taskCreate;

TeamInserted = false;
publicVariable "TeamInserted";
// Send helicopter to LZ.
call fnc_heliWaypointDropoff;

// Play a tune.
"vn_trippin" remoteExec ["fnc_smoothPlayMusic"];

// Wait for insertion to finish.
waitUntil { TeamInserted };

// Add track at LZ.
//[leader groupPlayers] call VN_ms_fnc_tracker_tracksCreate;

// Spawn enemies in AO.
call fnc_populateAo;

// Start mission flow.
"scripts\missionFlow.sqf" call BIS_fnc_execVM;