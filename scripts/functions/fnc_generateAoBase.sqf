_campComposition = 
[
	["Land_vn_o_bunker_04",[4.5415,3.75391,0],54.1742,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_02",[2.48389,-5.6709,-0.107368],145.148,1,0,[],"","",true,false], 
	["Land_vn_o_prop_cong_cage_03",[2.23877,-5.35718,0],144.808,1,0,[],"","",true,false], 
	["Land_vn_o_bunker_02",[-6.09424,5.21094,0],338.043,1,0,[],"","",true,false], 
	["Land_vn_o_shelter_02",[-2.68018,-7.30591,0],181.31,1,0,[],"","",true,false], 
	["Logic",[-2.625,-6.92041,0],0,1,0,[],"","",true,false], 
	["vn_o_vc_static_dshkm_high_01",[-5.81885,4.57959,0.13279],337.82,1,0.047728,[],"","",true,false], 
	["Land_vn_o_wallfoliage_01",[-8.4292,-0.670898,0],183.007,1,0,[],"","",true,false], 
	["Land_vn_o_wallfoliage_01",[-7.43262,-4.82935,0],152.441,1,0,[],"","",true,false]
];

_baseLocations = [base_1, base_2, base_3, base_4, base_5, base_6, base_7, base_8, base_9, base_10, base_11, base_12, base_13];

// Select a base location.
_sitesWithinRadius = [];
{
	_dist = [position _x, AOPosition] call BIS_fnc_distance2D;
	// Within AO radius - Objective radius.
	if(_dist < (AORadius - ObjectiveRadius)) then
	{
		_sitesWithinRadius append [_x];
	};
} forEach _baseLocations;
_spawnPos = position (_sitesWithinRadius call BIS_fnc_selectRandom);

_base = [_spawnPos, 0, _campComposition] call BIS_fnc_ObjectsMapper;
zeus1 addCuratorEditableObjects [_base, false];
BasePosition = _spawnPos;
publicVariable "BasePosition";

_cachePosition = _spawnPos vectorAdd ((_campComposition select 5) select 1);
TargetCache = ([_cachePosition, 0, "Box_FIA_Wps_F", sideEmpty] call BIS_fnc_spawnVehicle) select 0;
clearItemCargoGlobal TargetCache;
clearMagazineCargoGlobal TargetCache;
clearWeaponCargoGlobal TargetCache;
TargetCache addMagazineCargoGlobal ["vn_mine_m112_remote_mag", 5];
zeus1 addCuratorEditableObjects [[TargetCache], false];

ObjectivePosition = _cachePosition;
publicVariable "ObjectivePosition";

// Create trigger around base.
BaseTrigger = createTrigger ["EmptyDetector", _spawnPos];
BaseTrigger setTriggerArea [15, 15, 0, false];
BaseTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
BaseTrigger setTriggerStatements ["this", "BaseFound = true;", ""];