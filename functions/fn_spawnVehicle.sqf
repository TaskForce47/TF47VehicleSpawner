_index = lnbCurSelRow 1500;

_vehicleClass = lnbData [1500, [_index, 1]];
_marker = lnbData [1500, [_index, 0]];

_spawnCount = missionNameSpace getVariable 
    [format["tf47_core_vs_%1_spawnCount", _marker], 0];

if(_spawnCount >= (call compile (lnbData [1500, [_index, 2]]))) exitWith {};

_vehicle = _vehicleClass createVehicle 
	(getMarkerPos _marker);

_vehicle setVariable ["tf47_core_vs_originMaker", _marker, true];

missionNameSpace setVariable 
    [format["tf47_core_vs_%1_spawnCount", _marker], _spawnCount + 1, true];

[] call tf47_modules_vs_fnc_initMain;

_vehicle addEventHandler ["Killed", {
	_vehicle = _this select 0;
	_marker = _vehicle getVariable ["tf47_core_vs_originMaker", ""];
	_spawnCount = missionNameSpace getVariable 
    	[format["tf47_core_vs_%1_spawnCount", _marker], 0];
	missionNameSpace setVariable 
    	[format["tf47_core_vs_%1_spawnCount", _marker], _spawnCount - 1, true];
}];