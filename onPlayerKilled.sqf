//params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];

if (!isServer)  exitwith {}; 

_oldUnit = _this select 0;
if(RespawnEnabled && _oldUnit == leader groupPlayers) then 
{
	TeamRespawnPoint call BIS_fnc_removeRespawnPosition;
};