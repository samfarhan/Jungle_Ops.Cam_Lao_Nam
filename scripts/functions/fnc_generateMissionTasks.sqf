_accObjectiveMarkers = "AccurateObjectiveMarkers" call BIS_fnc_getParamValue;

[groupPlayers, "taskLocate", ["Locate the VC base.", "Locate Base", "Base"], BasePosition, "CREATED", 1, true, "search"] call BIS_fnc_taskCreate;

if(_accObjectiveMarkers == 0) then
{
	["taskLocate", AOPosition] call BIS_fnc_taskSetDestination;
};

/*
// Find all buildings in the area.
_buildingList = nearestObjects [AOPosition, ["house"], AORadius - ObjectiveRadius];
_possibleBuildingList = [];

{
    if([_x, 2] call BIS_fnc_isBuildingEnterable) then
    {
      _possibleBuildingList pushBack _x;
    };
} forEach _buildingList;

// Select a random building, and a point inside it.
_building = selectRandom _possibleBuildingList;
_buildingPositions = [_building] call BIS_fnc_buildingPositions;
_cachePosition = selectRandom _buildingPositions;

_cachePosition = [AOPosition, 1, AORadius - ObjectiveRadius, 3, 0, 0.7, 0, [], AOPosition] call BIS_fnc_findSafePos;

TargetCache = ([_cachePosition, 0, "Box_FIA_Wps_F", sideEmpty] call BIS_fnc_spawnVehicle) select 0;
clearItemCargoGlobal TargetCache;
clearMagazineCargoGlobal TargetCache;
clearWeaponCargoGlobal TargetCache;
zeus1 addCuratorEditableObjects [[TargetCache], false];

_accObjectiveMarkers = paramsArray select 4;

[groupPlayers, "taskMain", ["Locate and destroy the VC cache.", "Destroy Cache", "Cache"], TargetCache, "CREATED", 1, true, "destroy"] call BIS_fnc_taskCreate;

if(_accObjectiveMarkers == 0) then
{
	["taskMain", AOPosition] call BIS_fnc_taskSetDestination
};

ObjectivePosition = _cachePosition;
ObjectivePosition;
*/