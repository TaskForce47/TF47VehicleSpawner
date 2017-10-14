/**
 *  @author Willard
 *  @description
 *  Spawns a vehicle
 *  @params none
 *  @return nothing
 */
 // get the config
_index = lnbCurSelRow 1500;

diag_log lnbData [1500, [_index, 0]];

_data = call compile lnbData [1500, [_index, 0]];

diag_log _data;

_marker = _data select 0;
_vehicleClass = _data select 1;

if(count (nearestObjects 
	[getMarkerPos _marker, ["LandVehicle","Air", "Ship"], 5]) >= 1)
	exitWith {
	systemChat "Es gibt nicht genug Platz um dieses Fahrzeug zu spawnen!";
};

// spawn the vehicle
_vehicle = createVehicle [_vehicleClass, getMarkerPos _marker, [], 0,
	"CAN_COLLIDE" ];
_vehicle setDir (markerDir _marker);

// handle corescripts
if((_data select 3) != -1 && 
	!isNil "tf47_core_ticketsystem_fnc_registerVehicle") then {
	[_vehicle, _data select 3] remoteExecCall 
		["tf47_core_ticketsystem_fnc_registerVehicle", 2];
};

if((_data select 2) > 0 && (count (_data select 4)) > 0 &&
	!isNil "tf47_core_whitelist_fnc_registerWhitelist") then {
	[_vehicle, _data select 2, _data select 4] remoteExecCall 
		["tf47_core_whitelist_fnc_registerWhitelist", 2];
};

//equip fries
if(isNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) 
	>> "ace_fastroping_enabled")) then {
	[_vehicle] remoteExecCall ["ace_fastroping_fnc_equipFRIES", 2];
};