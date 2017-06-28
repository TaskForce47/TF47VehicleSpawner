/**
 *  @author Willard
 *  @description
 *  Spawns a vehicle
 *  @params none
 *  @return nothing
 */
 // get the config
_index = lnbCurSelRow 1500;

_configIndex = (call compile (lnbData [1500, [_index, 0]]));

_moduleConfig = tf47_modules_vs_config select _configIndex;
_marker = _moduleConfig select 0;
_vehicleClass = (_moduleConfig select 4) select _index;

_spawnCount = missionNameSpace getVariable 
    [format["tf47_core_vs_%1_spawnCount", _marker], 0];
// check for cap
if(_spawnCount >= (_moduleConfig select 2)) exitWith {};

// spawn the vehicle
_vehicle = createVehicle [_vehicleClass, getMarkerPos _marker, [], 0,
	"CAN_COLLIDE" ];
_vehicle setDir (markerDir _marker);
_vehicle setVariable ["tf47_core_vs_originMaker", _marker, true];

missionNameSpace setVariable 
    [format["tf47_core_vs_%1_spawnCount", _marker], _spawnCount + 1, true];

[] call tf47_modules_vs_fnc_initMain;

// handle death
_vehicle addEventHandler ["Killed", {
	_vehicle = _this select 0;
	_marker = _vehicle getVariable ["tf47_core_vs_originMaker", ""];
	_spawnCount = missionNameSpace getVariable 
    	[format["tf47_core_vs_%1_spawnCount", _marker], 0];
	missionNameSpace setVariable 
    	[format["tf47_core_vs_%1_spawnCount", _marker], _spawnCount - 1, true];
}];

// handle corescripts
if((_moduleConfig select 3) != -1 && 
	!isNil "tf47_core_ticketsystem_fnc_registerVehicle") then {
	[_vehicle, _moduleConfig select 3] call 
		tf47_core_ticketsystem_fnc_registerVehicle;
};

if((_moduleConfig select 1) > 0 && (count (_moduleConfig select 5)) > 0 &&
	!isNil "tf47_core_whitelist_fnc_registerWhitelist") then {
	[_vehicle, _moduleConfig select 1, _moduleConfig select 5] call 
		tf47_core_whitelist_fnc_registerWhitelist;
};