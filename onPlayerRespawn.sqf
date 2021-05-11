// params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

if (!isServer)  exitwith {}; 

_newUnit = _this select 0;
if(RespawnEnabled && _newUnit == leader groupPlayers) then 
{
	TeamRespawnPoint = [west, leader groupPlayers, "Team Leader"] call BIS_fnc_addRespawnPosition;
};