_wp1 = heliGroup addWaypoint [LZInsertPosition, 0];
_wp1 setWaypointType "TR UNLOAD";
_wp1 setWaypointStatements ["true", "this execVM 'scripts\heliUnloaded.sqf';"];

_wp2 = heliGroup addWaypoint [(getMarkerPos "markerHeliLeave"), 1];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "{_x setDamage 1} forEach crew heli1; deleteVehicle heli1;"];

//"vn_trippin" remoteExec ["playMusic"];