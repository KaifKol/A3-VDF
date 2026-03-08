params ["_vdf"];

private _lastCrew = _vdf getVariable ["vdf_lastCrew", []];
private _hasAI = (_lastCrew findIf { !isNull _x && !isPlayer _x && alive _x }) != -1;
if (!_hasAI) exitWith { false };

private _toolkitClasses = (missionNamespace getVariable ["vdf_toolkitClass", "ToolKit"]) splitString ",";
private _cargoItems = (getItemCargo _vdf) select 0;
private _hasToolkit = (_toolkitClasses findIf { _x in _cargoItems }) != -1;
if (!_hasToolkit) exitWith { false };

private _chance = (missionNamespace getVariable ["vdf_extinguishChance", 50]) / 100;
if (random 1 > _chance) exitWith { false };

_vdf setVariable ["burning", false, true];

private _aceLoaded = missionNamespace getVariable ["vdf_aceLoaded", false];
if (_aceLoaded) then {
    _vdf setHitPointDamage ["HitHull", 0.5];
    _vdf setHitPointDamage ["HitBody", 0.5];
} else {
    _vdf setDamage [0.5, false];
};

["Extinguished by AI crew"] call vdf_fnc_debugHint;

true