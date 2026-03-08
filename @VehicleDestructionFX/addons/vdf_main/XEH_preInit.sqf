["vdf_thresholdVanilla", "SLIDER",   ["Damage threshold (vanilla)", "Vehicle damage threshold before burning starts (0.0 - 1.0)"], ["Vehicle Destruction FX", "Thresholds"], [0.1, 1.0, 0.50, 2], true] call CBA_fnc_addSetting;
["vdf_thresholdAce",     "SLIDER",   ["Damage threshold (ACE)",     "HitHull/HitBody threshold before burning starts (0.0 - 1.0)"], ["Vehicle Destruction FX", "Thresholds"], [0.1, 1.0, 0.88, 2], true] call CBA_fnc_addSetting;

["vdf_sleepBeforeFire",  "SLIDER",   ["Delay before smoke (sec)",   "Delay after threshold is reached before small smoke appears"], ["Vehicle Destruction FX", "Timings"], [1, 120, 10, 0], true] call CBA_fnc_addSetting;
["vdf_sleepSmallSmoke",  "SLIDER",   ["Small smoke duration (sec)",  "How long small smoke lasts before medium smoke"],             ["Vehicle Destruction FX", "Timings"], [1, 120, 10, 0], true] call CBA_fnc_addSetting;
["vdf_sleepMediumSmoke", "SLIDER",   ["Medium smoke duration (sec)", "How long medium smoke lasts before fire starts"],             ["Vehicle Destruction FX", "Timings"], [1, 120, 15, 0], true] call CBA_fnc_addSetting;
["vdf_sleepSmallFire",   "SLIDER",   ["Small fire duration (sec)",   "How long small fire lasts before big fire"],                  ["Vehicle Destruction FX", "Timings"], [1, 120, 10, 0], true] call CBA_fnc_addSetting;
["vdf_sleepBigFire",     "SLIDER",   ["Big fire duration (sec)",     "How long big fire lasts before vehicle explodes"],            ["Vehicle Destruction FX", "Timings"], [1, 120, 10, 0], true] call CBA_fnc_addSetting;

["vdf_extinguishChance", "SLIDER",   ["Extinguish chance (%)",       "Chance for AI crew with toolkit to extinguish at small fire stage"], ["Vehicle Destruction FX", "Extinguish"], [0, 100, 50, 0], true] call CBA_fnc_addSetting;
["vdf_toolkitClass",     "EDITBOX",  ["Toolkit classnames",          "Comma-separated list of toolkit classnames (e.g. ToolKit,MyToolKit)"], ["Vehicle Destruction FX", "Extinguish"], "ToolKit", true] call CBA_fnc_addSetting;

["vdf_debug",            "CHECKBOX", ["Debug hints",                 "Show hint messages on vehicle burn stages"],                  ["Vehicle Destruction FX", "Debug"], false, true] call CBA_fnc_addSetting;