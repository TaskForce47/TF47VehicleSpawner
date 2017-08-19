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

_nearestObjects = nearestObjects [getMarkerPos _marker, 
	["LandVehicle","Air", "Ship"], 5];

if(count _nearestObjects < 1) exitWith {};

[_nearestObjects select 0, {
	_vehicle = _this;
	_vehicle setFuel 0;
	if(!(_vehicle isKindOf "UAV")) then {
		{
			_x action ["GetOut", _vehicle];
		} forEach crew _vehicle;

		// delete ai and dead/dc people
		{
			_vehicle deleteVehicleCrew _x;
		} forEach (crew _vehicle);

		waitUntil {count (crew _vehicle) == 0};

		_vehicle lock true;
	};

	_vehicle setVariable ["tf47_core_ticketsystem_despawn", true, true];
	_handle = _vehicle getVariable ["tf47_core_ticketsystem_timeoutHandle", -1];
	if(_handle != -1) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
	sleep 1;

	_vehicle setPos [0,0,0];
	sleep 5;

	_vehicle setDamage 1;
	sleep 30;
	deleteVehicle _vehicle;
}] remoteExec ["bis_fnc_spawn", 2]; 