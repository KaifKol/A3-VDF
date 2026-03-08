params ["_vdf", "_toolkitClasses"];
if !(local _vdf) exitWith { false };

private _cargo = _vdf getItemCargo;
(_toolkitClasses findIf { _x in _cargo }) != -1