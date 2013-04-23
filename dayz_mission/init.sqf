/*	
	INITILIZATION
*/
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance = 762;					//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;


// Satchel, trying to auto update the database.
//Send the key
// Waiting for a reply from 
// http://opendayz.net/threads/sql-999-method.9596/
//
//_key = format["CHILD:999:UPDATE instance_deployable d LEFT JOIN (SELECT DISTINCT d.owner_id, s.unique_id FROM instance_deployable d LEFT JOIN survivor s ON s.id = d.owner_id WHERE s.is_dead =1 ) AS dead ON dead.owner_id = d.owner_id LEFT JOIN survivor live ON live.unique_id = dead.unique_id SET d.owner_id = live.id WHERE live.is_dead =0", dayZ_instance];
//_data = "HiveEXT" callExtension _key;
//diag_log("SERVER: Updated Build ID's...");

//
// SATCHEL


//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//enableRadio false;					//disable radio messages to be heard and shown in the left lower corner of the screen

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";		//Compile regular functions
//base building  and Parts
call compile preprocessFileLineNumbers "compiles.sqf";							//removeparts
call compile preprocessFileLineNumbers "dayz_code\init\variables.sqf"; //Initializes custom variables
call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf"; //Compile custom compiles
call compile preprocessFileLineNumbers "dayz_code\init\settings.sqf"; //Initialize custom clientside settings
progressLoadingScreen 1.0;
//custom loot tables
building_spawnLoot = compile preprocessFileLineNumbers "fixes\building_spawnLoot.sqf";
//remove crap of streets
stream_locationCheck = {
};
"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if ((!isServer) && (isNull player) ) then
{
waitUntil {!isNull player};
waitUntil {time > 3};
};

if ((!isServer) && (player != player)) then
{
  waitUntil {player == player};
  waitUntil {time > 3};
};
player_wearClothes = compile preprocessFileLineNumbers "fixes\player_wearClothes.sqf";
if (isServer) then {
axe_server_lampObjs =    compile preprocessFileLineNumbers "lights\fnc_returnLampWS.sqf";
    "axeLampObjects" addPublicVariableEventHandler {_id = (_this select 1) spawn axe_server_lampObjs};
//Addin
	dogOwner = [];
//Addin
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//StreetLightslemonswin
	[] execVM "lights\street_lights.sqf";
	[] execVM "Scripts\kh_actions.sqf";
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
//Addin
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death; _nul = [] execVM "addin\plrInit.sqf";}];
	//dayZ original _id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor =    [] execFSM "fixes\player_monitor.fsm"; "heliCrash" addPublicVariableEventHandler {
        _list = nearestObjects [_this select 1, ["CraterLong"], 100];
        {deleteVehicle _x;} foreach _list;
    };
	_nul = [] execVM "addin\plrInit.sqf";
//Addin
};
call compile preprocessFileLineNumbers "addons\UPSMON\scripts\Init_UPSMON.sqf";
//R3F EXECVM
execVM "R3F_ARTY_AND_LOG\init.sqf"
// SHK
call compile preprocessfile "addons\SHK_pos\shk_pos_init.sqf";
// run SAR_AI
[] execVM "addons\SARGE\SAR_AI_init.sqf";
[5,true,10,1,true,7] execFSM "Dayz_time\core_time.fsm";