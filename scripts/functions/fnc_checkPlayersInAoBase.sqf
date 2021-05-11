waitUntil
{
	BaseFound
};

["taskLocate", "SUCCEEDED"] call BIS_fnc_taskSetState;
[groupPlayers, "taskMain", ["Locate and destroy the VC cache.", "Destroy Cache", "Cache"], TargetCache, "CREATED", 1, true, "destroy"] call BIS_fnc_taskCreate;