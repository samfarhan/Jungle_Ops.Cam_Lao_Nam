while {true} do
{
	_groups = [trackerModule] call VN_ms_module_fnc_tracker_aoGroups;
	{
		zeus1 addCuratorEditableObjects [_x, true];
	} forEach _groups;
	sleep 5;
};