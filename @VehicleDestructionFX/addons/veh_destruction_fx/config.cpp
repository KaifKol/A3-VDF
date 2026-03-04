class CfgPatches {
    class veh_destruction_fx {
        name = "Vehicle Destruction FX";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {
            "cba_main"
        };
    };
};

class Extended_PostInit_EventHandlers {
    class veh_destruction_fx {
        isGlobal = 0;
        serverOnly = 1;
        init = "if (isServer) then { execVM 'veh_destruction_fx\initServer.sqf' };";
    };
};