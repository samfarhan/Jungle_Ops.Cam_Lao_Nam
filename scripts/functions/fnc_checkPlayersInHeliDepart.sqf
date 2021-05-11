waitUntil
{
	sleep 1;
	_allPlayers = call BIS_fnc_listPlayers;
	_livingPlayers = {alive _x} count _allPlayers;
	_playersInHeli = {alive _x && _x in heli1} count _allPlayers;
	_livingPlayers > 0 && _playersInHeli == _livingPlayers;
};
["taskArmUp", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskBoardHeli", "SUCCEEDED"] call BIS_fnc_taskSetState;
