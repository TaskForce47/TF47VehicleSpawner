waitUntil {(ctrlText 1001) != ""};


_nearestMarker = [tf47_modules_vs_config_allMarkers, player] call 
    BIS_fnc_nearestPosition;

_index = -1;

{
    if((_x select 0) _nearestMarker) then {
        _index = _forEachIndex;
    };
} forEach tf47_modules_vs_config;

_curConfig = tf47_modules_vs_config select _index;

{
    _config = (configFile >> "CfgVehicles" >> _x);
    _row = lnbAddRow [1500, [getText (_config >> "displayName"), 
        _curConfig select 3, "10/10"]];
    lnbSetPicture [1500, [_row, 0], getText (_config >> "picture")];
    lnbSetPictureColor [1500,[_row,0],[1,1,1,1]];
} forEach (_curConfig select 4);
