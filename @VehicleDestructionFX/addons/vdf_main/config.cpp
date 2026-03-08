class CfgPatches {
    class vdf {
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
    class vdf {
        isGlobal = 0;
        serverOnly = 1;
        init = "if (isServer) then { execVM 'vdf_main\initServer.sqf' };";
    };
};