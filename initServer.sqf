fnc_generateAoMarkers = compile preprocessFile "scripts\functions\fnc_generateAoMarkers.sqf";
fnc_generateInitialTasks = compile preprocessFile "scripts\functions\fnc_generateInitialTasks.sqf";
fnc_generateMissionTasks = compile preprocessFile "scripts\functions\fnc_generateMissionTasks.sqf";
fnc_checkPlayersInAoBase = compile preprocessFile "scripts\functions\fnc_checkPlayersInAoBase.sqf";
fnc_checkPlayersInHeliDepart = compile preprocessFile "scripts\functions\fnc_checkPlayersInHeliDepart.sqf";
fnc_checkPlayersInHeliReturn = compile preprocessFile "scripts\functions\fnc_checkPlayersInHeliReturn.sqf";
fnc_heliWaypointDropoff = compile preprocessFile "scripts\functions\fnc_heliWaypointDropoff.sqf";
fnc_heliWaypointPickup = compile preprocessFile "scripts\functions\fnc_heliWaypointPickup.sqf";
fnc_populateAo = compile preprocessFile "scripts\functions\fnc_populateAo.sqf";
fnc_generateAoBase = compile preprocessFile "scripts\functions\fnc_generateAoBase.sqf";
fnc_smoothPlayMusic = compile preprocessFile "scripts\functions\fnc_smoothPlayMusic.sqf";
fnc_lzHostiles = compile preprocessFile "scripts\functions\fnc_lzHostiles.sqf";

// Init mission.
_null = [] execVM "scripts\generateMission.sqf";

["VN_B_air_UH1D_01_02", position heliIntroSpawn] call VN_ms_fnc_spawnAmbHeli;