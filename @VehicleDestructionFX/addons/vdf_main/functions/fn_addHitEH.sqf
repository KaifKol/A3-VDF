params ["_vdf"];

_vdf addEventHandler ["Hit", {
    params ["_veh", "_shooter", "_damage", "_instigator"];

    if (local _veh) then {
        private _currentCrew = crew _veh;
        if (count _currentCrew > 0) then {
            _veh setVariable ["vdf_lastCrew", _currentCrew, true];
        };
    } else {
        [_veh] remoteExec ["vdf_fnc_syncCrew", _veh];
    };

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