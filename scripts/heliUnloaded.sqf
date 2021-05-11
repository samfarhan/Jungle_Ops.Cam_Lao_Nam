["moveToLZ", "SUCCEEDED"] call BIS_fnc_taskSetState;

TeamInserted = true;
publicVariable "TeamInserted";

if(RespawnEnabled) then 
{
	[west, LZInsertPosition] call BIS_fnc_addRespawnPosition;
}