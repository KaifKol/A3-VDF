params ["_vdf"];
if !(local _vdf) exitWith {};

private _currentCrew = crew _vdf;
if (count _currentCrew > 0) then {
    _vdf setVariable ["vdf_lastCrew", _currentCrew, true];
};