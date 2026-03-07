class CfgPatches
{
	class vdf_particles
	{
		requiredAddons[]=
		{
			"A3_Data_F_Loadorder"
		};
		requiredVersion=0.1;
		units[]=
		{
			"Particle_SmallSmoke_F",
			"Particle_MediumSmoke_F",
			"Particle_MediumFire_F",
			"Particle_BigFire_F"
		};
		weapons[]={};
	};
};

class CfgEditorCategories
{
	class EdCat_Effects
	{
		displayName="Effects";
	};
};

class CfgEditorSubcategories
{
	class EdSubcat_Fire
	{
		displayName="Fire";
	};
	class EdSubcat_Smoke
	{
		displayName="Smoke";
	};
};

class CfgVehicles
{
	class Thing;
	class Particle_Base_F: Thing
	{
		class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.0010700001;
			verticalOffsetWorld=0;
			init="''";
		};
		simulation="Fire";
		icon="\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_fire_in_flame_ca.paa";
		editorCategory="EdCat_Effects";
		class EventHandlers
		{
			postInit="if (is3DEN) then {	(_this # 0) spawn {_this enablesimulation true}	};	(_this # 0) inflame true;	(_this # 0) hideObject true;";
		};
	};
	class Particle_BigFire_F: Particle_Base_F
	{
		displayName="Big Fire";
		scope=2;
		scopeCurator=2;
		editorSubcategory="EdSubcat_Fire";
		icon="\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_fire_in_flame_ca.paa";
		class Effects
		{
			class Fire
			{
				simulation="particles";
				type="BigDestructionFire";
			};
			class FireSparks
			{
				simulation="particles";
				type="FireSparks";
			};
			class Smoke
			{
				simulation="particles";
				type="BigDestructionSmoke";
			};
			class Refract
			{
				simulation="particles";
				type="ObjectDestructionRefract";
			};
			class Light
			{
				simulation="light";
				type="BigFireLight";
			};
			class Sound
			{
				simulation="sound";
				type="Fire";
			};
		};
	};
	class Particle_MediumFire_F: Particle_Base_F
	{
		displayName="Medium Fire";
		scope=2;
		scopeCurator=2;
		editorSubcategory="EdSubcat_Fire";
		icon="\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_fire_in_flame_ca.paa";
		class Effects
		{
			class Fire
			{
				simulation="particles";
				type="MediumDestructionFire";
			};
			class Smoke
			{
				simulation="particles";
				type="MediumDestructionSmoke";
			};
			class Refract
			{
				simulation="particles";
				type="ObjectDestructionRefractSmall";
			};
			class Light
			{
				simulation="light";
				type="MediumFireLight";
			};
			class Sound
			{
				simulation="sound";
				type="Fire";
			};
		};
	};
	class Particle_MediumSmoke_F: Particle_Base_F
	{
		displayName="Medium Smoke";
		scope=2;
		scopeCurator=2;
		editorSubcategory="EdSubcat_Smoke";
		class Effects
		{
			class Smoke
			{
				simulation="particles";
				type="MediumDestructionSmoke";
			};
		};
	};
	class Particle_SmallSmoke_F: Particle_Base_F
	{
		displayName="Small Smoke";
		scope=2;
		scopeCurator=2;
		editorSubcategory="EdSubcat_Smoke";
		class Effects
		{
			class Smoke
			{
				simulation="particles";
				type="SmallDestructionSmoke";
			};
		};
	};
};

class CfgLights
{
	class ObjectDestructionLightSmall;
	class ObjectDestructionLight;
	class BigFireLight: ObjectDestructionLight
	{
		intensity="25000 * (power interpolate [0.1, 1.0, 0.7, 1.0])";
	};
	class MediumFireLight: ObjectDestructionLightSmall
	{
		intensity="3500 * (power interpolate [0.1, 1.0, 0.7, 1.0])";
	};
};
