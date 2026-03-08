missionNamespace setVariable ["vdf_aceLoaded", isClass (configFile >> "CfgPatches" >> "ace_main")];

[] spawn {
    sleep 3;
    { [_x] call vdf_fnc_initVehicle; } forEach vehicles;
};

addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    [_entity] spawn {
        params ["_entity"];
        sleep 0.1;
        [_entity] call vdf_fnc_initVehicle;
    };
}];