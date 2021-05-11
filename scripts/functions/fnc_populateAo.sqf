_group1 = ["vn_o_men_vc_local_27", "vn_o_men_vc_local_02", "vn_o_men_vc_local_06", "vn_o_men_vc_local_07", "vn_o_men_vc_local_05"];
_group2 = ["vn_o_men_vc_local_13", "vn_o_men_vc_local_19", "vn_o_men_vc_local_17", "vn_o_men_vc_local_32", "vn_o_men_vc_local_05"];
_group3 = ["vn_o_men_vc_local_01", "vn_o_men_vc_local_14", "vn_o_men_vc_local_11", "vn_o_men_vc_local_21", "vn_o_men_vc_local_08"];
_groups = [_group1, _group2, _group3];

//[configfile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_04"]

_numSquads = "EnemySquads" call BIS_fnc_getParamValue;
_baseSquads = round (_numSquads / 2.0);

// Spawn AI in AO.
for "_i" from 1 to _numSquads do
{
	_groupToSpawn = _groups call BIS_fnc_selectRandom;
	_spawnPos = [AOPosition, 1, AORadius - LZBufferRadius, 3, 0, 0.7, 0, [], AOPosition] call BIS_fnc_findSafePos;
	_group = [_spawnPos, east, _groupToSpawn] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;
	_nul = [leader _group, "MarkerAOUps"] execVM "scripts\UPS.sqf";

	//_group = [_spawnPos, 2, east, "VN"] call VN_ms_fnc_tracker_spawnGroup;
	zeus1 addCuratorEditableObjects [units _group, true];
};

// Spawn AI at base.
for "_i" from 1 to _baseSquads do
{
	_groupToSpawn = _groups call BIS_fnc_selectRandom;
	_spawnPos = [BasePosition, 50, ObjectiveRadius, 3, 0, 0.7, 0, [], BasePosition] call BIS_fnc_findSafePos;
	_group = [_spawnPos, east, _groupToSpawn] call BIS_fnc_spawnGroup;
	_group deleteGroupWhenEmpty true;
	_nul = [leader _group, "MarkerObjectiveUps"] execVM "scripts\UPS.sqf";

	//_group = [_spawnPos, 2, east, "VN"] call VN_ms_fnc_tracker_spawnGroup;
	zeus1 addCuratorEditableObjects [units _group, true];
};