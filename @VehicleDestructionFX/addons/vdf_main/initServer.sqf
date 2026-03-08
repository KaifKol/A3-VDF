fnc_vdf_addHitEH = {
    params ["_vdf"];
    _vdf addEventHandler ["Hit", {
        params ["_veh", "_shooter", "_damage", "_instigator"];
        private _attacker = objNull;
        if (!isNull _instigator && {_instigator isKindOf "Man"}) then {
            _attacker = _instigator;
        } else {
            if (!isNull _shooter && {!(_shooter isEqualTo _veh)}) then {
                _attacker = _shooter;
            };
        };
        if (!isNull _attacker) then {
            _veh setVariable ["vdf_lastAttacker", _attacker, true];
        };
    }];
};

if (isServer) then {
    private _aceLoaded = isClass (configFile >> "CfgPatches" >> "ace_main");
    private _threshold = 0.50;
    if (_aceLoaded) then { _threshold = 0.88; };
    missionNamespace setVariable ["vdf_aceLoaded", _aceLoaded];
    missionNamespace setVariable ["vdf_threshold", _threshold];

    // === CBA SETTINGS ===
    ["vdf_sleepBeforeFire",  "SLIDER",   ["Delay before smoke (sec)",    "Delay after threshold is reached before small smoke appears"], "Vehicle Destruction FX", [1, 120, 10, 0], true] call CBA_fnc_addSetting;
    ["vdf_sleepSmallSmoke",  "SLIDER",   ["Small smoke duration (sec)",   "How long small smoke lasts before medium smoke"],             "Vehicle Destruction FX", [1, 120, 10, 0], true] call CBA_fnc_addSetting;
    ["vdf_sleepMediumSmoke", "SLIDER",   ["Medium smoke duration (sec)",  "How long medium smoke lasts before fire starts"],             "Vehicle Destruction FX", [1, 120, 15, 0], true] call CBA_fnc_addSetting;
    ["vdf_sleepSmallFire",   "SLIDER",   ["Small fire duration (sec)",    "How long small fire lasts before big fire"],                  "Vehicle Destruction FX", [1, 120, 10, 0], true] call CBA_fnc_addSetting;
    ["vdf_sleepBigFire",     "SLIDER",   ["Big fire duration (sec)",      "How long big fire lasts before vehicle explodes"],            "Vehicle Destruction FX", [1, 120, 10, 0], true] call CBA_fnc_addSetting;
    ["vdf_debug",            "CHECKBOX", ["Debug hints",                  "Show hint messages on vehicle burn stages"],                  "Vehicle Destruction FX", false, true] call CBA_fnc_addSetting;
    // ====================

    missionNamespace setVariable ["fnc_vdf_debugHint", {
        params ["_msg"];
        if !(missionNamespace getVariable ["vdf_debug", false]) exitWith {};
        [format ["[VDF] %1", _msg]] remoteExec ["hint", 0];
    }];

    missionNamespace setVariable ["fnc_vdf_initVehicle", {
        params ["_vdf"];
        if (!(_vdf isKindOf "AllVehicles") || {_vdf isKindOf "Man"}) exitWith {};

        if (local _vdf) then {
            [_vdf] call fnc_vdf_addHitEH;
        } else {
            [_vdf] remoteExec ["fnc_vdf_addHitEH", _vdf];
        };

        [_vdf, missionNamespace getVariable "vdf_aceLoaded", missionNamespace getVariable "vdf_threshold"] spawn {
            params ["_vdf", "_aceLoaded", "_threshold"];

            private _fnc_debug = missionNamespace getVariable "fnc_vdf_debugHint";

            waitUntil {
                sleep 0.5;
                if (isNull _vdf || {!alive _vdf}) exitWith {true};
                if (_aceLoaded) then {
                    private _hull = _vdf getHitPointDamage "HitHull";
                    private _body = _vdf getHitPointDamage "HitBody";
                    (_hull >= _threshold || _body >= _threshold)
                } else {
                    (damage _vdf >= _threshold)
                };
            };

            if (isNull _vdf || {!alive _vdf}) exitWith {};
            if (_vdf getVariable ["burning", false]) exitWith {};
            if (damage _vdf >= 1) exitWith {};

            _vdf setVariable ["burning", true, true];
            ["Burning: " + typeOf _vdf] call _fnc_debug;

            sleep (missionNamespace getVariable "vdf_sleepBeforeFire");
            if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith {};

            ["Stage: Small smoke"] call _fnc_debug;
            private _p1 = "Particle_SmallSmoke_F" createVehicle (getPos _vdf);
            _p1 attachTo [_vdf, [0, 0, -1.5]];

            sleep (missionNamespace getVariable "vdf_sleepSmallSmoke");
            if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p1; };

            ["Stage: Medium smoke"] call _fnc_debug;
            private _p2 = "Particle_MediumSmoke_F" createVehicle (getPos _vdf);
            _p2 attachTo [_vdf, [0, 0, -1.5]];
            deleteVehicle _p1;

            sleep (missionNamespace getVariable "vdf_sleepMediumSmoke");
            if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p2; };

            ["Stage: Small fire"] call _fnc_debug;
            private _p3 = "Particle_MediumFire_F" createVehicle (getPos _vdf);
            _p3 attachTo [_vdf, [0, 0, -1]];
            deleteVehicle _p2;

            sleep (missionNamespace getVariable "vdf_sleepSmallFire");
            if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p3; };

            ["Stage: Big fire"] call _fnc_debug;
            private _p4 = "Particle_BigFire_F" createVehicle (getPos _vdf);
            _p4 attachTo [_vdf, [0, 0, -1.5]];
            deleteVehicle _p3;

            sleep (missionNamespace getVariable "vdf_sleepBigFire");
            if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p4; };

            ["Stage: Exploding"] call _fnc_debug;
            deleteVehicle _p4;

            private _killer = _vdf getVariable ["vdf_lastAttacker", objNull];
            if (!isNull _killer) then {
                _vdf setDamage [1, true, _killer];
            } else {
                _vdf setDamage [1, true];
            };
        };
    }];

    [] spawn {
        sleep 3;
        {
            [_x] call (missionNamespace getVariable "fnc_vdf_initVehicle");
        } forEach vehicles;
    };

    addMissionEventHandler ["EntityCreated", {
        params ["_entity"];
        [_entity] spawn {
            params ["_entity"];
            sleep 0.1;
            [_entity] call (missionNamespace getVariable "fnc_vdf_initVehicle");
        };
    }];
};
