waitUntil {(ctrlText 1001) != ""};

lnbClear 1500;

_nearestMarker = [tf47_modules_vs_config_allMarkers, player] call 
    BIS_fnc_nearestPosition;

_index = -1;

{
    if((_x select 0) == _nearestMarker) then {
        _index = _forEachIndex;
    };
} forEach tf47_modules_vs_config;

_curConfig = tf47_modules_vs_config select _index;

_spawnCount = missionNameSpace getVariable 
    [format["tf47_core_vs_%1_spawnCount", _nearestMarker], 0];

{
    _config = (configFile >> "CfgVehicles" >> _x);
    _row = lnbAddRow [1500, [getText (_config >> "displayName"), 
        str (_curConfig select 3), format["%1/%2", _spawnCount, _curConfig select 2]]];
    lnbSetPicture [1500, [_row, 0], getText (_config >> "picture")];
    lnbSetPictureColor [1500,[_row,0],[1,1,1,1]];
    // ToDo: Test
    lnbSetData [1500, [_row, 0], _nearestMarker];
    lnbSetData [1500, [_row, 1], _x];
    lnbSetData [1500, [_row, 2], str (_curConfig select 2)];
} forEach (_curConfig select 4);
