waitUntil {(ctrlText 1001) != ""};



{
    _config = (configFile >> "CfgVehicles" >> _x);
    _row = lnbAddRow [1500, [getText (_config >> "displayName"),"100", "10/10"]];
    lnbSetPicture [1500, [_row, 0], getText (_config >> "picture")];
    lnbSetPictureColor [1500,[_row,0],[1,1,1,1]];
} forEach ["MRAP_01_base_F", "B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F"];
