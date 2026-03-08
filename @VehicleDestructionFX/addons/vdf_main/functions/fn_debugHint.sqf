params ["_msg"];
if !(missionNamespace getVariable ["vdf_debug", false]) exitWith {};
[format ["[VDF] %1", _msg]] remoteExec ["hint", 0];