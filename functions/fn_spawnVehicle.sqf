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

if(count (nearestObjects 
	[getMarkerPos _marker, ["LandVehicle","Air", "Ship"], 5]) >= 1)
	exitWith {
	systemChat "Es gibt nicht genug Platz um dieses Fahrzeug zu spawnen!";
};

// spawn the vehicle
_vehicle = createVehicle [_vehicleClass, getMarkerPos _marker, [], 0,
	"CAN_COLLIDE" ];
_vehicle setDir (markerDir _marker);
missionNamespace setVariable 
        [format ["tf47_core_vs_originMarker_%1", 
        (_vehicle call BIS_fnc_netId)], _marker, true];
//_vehicle setVariable ["tf47_core_vs_originMaker", _marker, true];

missionNameSpace setVariable [format["tf47_core_vs_%1_spawnCount", _marker], _spawnCount + 1, true];

[] call tf47_modules_vs_fnc_initMain;

// handle death
_vehicle addMPEventHandler["MPKilled", {
	if(isServer) then {
		_veh = _this select 0;
		_marker = missionNamespace getVariable 
			[format ["tf47_core_vs_originMarker_%1", 
        	(_veh call BIS_fnc_netId)], ""];
		//_marker = _veh getVariable ["tf47_core_vs_originMaker", ""];
		_spawnCount = missionNameSpace getVariable 
			[format["tf47_core_vs_%1_spawnCount", _marker], 0];
		missionNameSpace setVariable 
			[format["tf47_core_vs_%1_spawnCount", _marker], _spawnCount - 1, 
			true];
	};
}];

// handle corescripts
if((_moduleConfig select 3) != -1 && 
	!isNil "tf47_core_ticketsystem_fnc_registerVehicle") then {
	[_vehicle, _moduleConfig select 3] remoteExecCall 
		["tf47_core_ticketsystem_fnc_registerVehicle", 2];
};

if((_moduleConfig select 1) > 0 && (count (_moduleConfig select 5)) > 0 &&
	!isNil "tf47_core_whitelist_fnc_registerWhitelist") then {
	[_vehicle, _moduleConfig select 1, _moduleConfig select 5] remoteExecCall 
		["tf47_core_whitelist_fnc_registerWhitelist", 2];
};

//equip fries
if(isNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) 
	>> "ace_fastroping_enabled")) then {
	[_vehicle] remoteExecCall ["ace_fastroping_fnc_equipFRIES", 2];
};