params ["_vdf"];
if (!(_vdf isKindOf "AllVehicles") || {_vdf isKindOf "Man"}) exitWith {};

if (local _vdf) then {
    [_vdf] call vdf_fnc_addHitEH;
} else {
    [_vdf] remoteExec ["vdf_fnc_addHitEH", _vdf];
};

[_vdf, missionNamespace getVariable "vdf_aceLoaded"] spawn {
    params ["_vdf", "_aceLoaded"];

    private _threshold = if (_aceLoaded) then {
        missionNamespace getVariable ["vdf_thresholdAce", 0.88]
    } else {
        missionNamespace getVariable ["vdf_thresholdVanilla", 0.50]
    };

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
    ["Burning: " + typeOf _vdf] call vdf_fnc_debugHint;

    sleep (missionNamespace getVariable "vdf_sleepBeforeFire");
    if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith {};

    ["Stage: Small smoke"] call vdf_fnc_debugHint;
    private _p1 = "Particle_SmallSmoke_F" createVehicle (getPos _vdf);
    _p1 attachTo [_vdf, [0, 0, -1.5]];

    sleep (missionNamespace getVariable "vdf_sleepSmallSmoke");
    if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p1; };

    ["Stage: Medium smoke"] call vdf_fnc_debugHint;
    private _p2 = "Particle_MediumSmoke_F" createVehicle (getPos _vdf);
    _p2 attachTo [_vdf, [0, 0, -1.5]];
    deleteVehicle _p1;

    sleep (missionNamespace getVariable "vdf_sleepMediumSmoke");
    if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p2; };

    ["Stage: Small fire"] call vdf_fnc_debugHint;
    private _p3 = "Particle_MediumFire_F" createVehicle (getPos _vdf);
    _p3 attachTo [_vdf, [0, 0, -1]];
    deleteVehicle _p2;

    sleep (missionNamespace getVariable "vdf_sleepSmallFire");
    if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p3; };

    ["Stage: Big fire"] call vdf_fnc_debugHint;
    private _p4 = "Particle_BigFire_F" createVehicle (getPos _vdf);
    _p4 attachTo [_vdf, [0, 0, -1.5]];
    deleteVehicle _p3;

    sleep (missionNamespace getVariable "vdf_sleepBigFire");
    if (isNull _vdf || {!alive _vdf} || {damage _vdf >= 1}) exitWith { deleteVehicle _p4; };

    ["Stage: Exploding"] call vdf_fnc_debugHint;
    deleteVehicle _p4;

    private _killer = _vdf getVariable ["vdf_lastAttacker", objNull];
    if (!isNull _killer) then {
        _vdf setDamage [1, true, _killer];
    } else {
        _vdf setDamage [1, true];
    };
};