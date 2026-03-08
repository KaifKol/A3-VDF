class CfgPatches {
    class vdf_main {
        name = "Vehicle Destruction FX";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.98;
        requiredAddons[] = {
            "cba_main",
            "cba_settings"
        };
    };
};

class CfgFunctions {
    class vdf {
        tag = "vdf";
        class functions {
            file = "vdf_main\functions";
            class initVehicle {};
            class addHitEH    {};
            class debugHint   {};
        };
    };
};

class Extended_PreInit_EventHandlers {
    class vdf_main {
        isGlobal = 1;
        init = "call compile preprocessFileLineNumbers 'vdf_main\XEH_preInit.sqf';";
    };
};

class Extended_PostInit_EventHandlers {
    class vdf_main {
        isGlobal = 0;
        serverOnly = 1;
        init = "call compile preprocessFileLineNumbers 'vdf_main\XEH_postInit.sqf';";
    };
};