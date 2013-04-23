//Animated Helicrashs for DayZ 1.7.6.1
//Version 0.2
//Release Date: 05. April 2013
//Author: Grafzahl
//Thread-URL: http://opendayz.net/threads/animated-helicrashs-0-1-release.9084/

private["_useStatic","_crashDamage","_lootRadius","_preWaypoints","_preWaypointPos","_endTime","_startTime","_safetyPoint","_heliStart","_deadBody","_exploRange","_heliModel","_lootPos","_list","_craters","_dummy","_wp2","_wp3","_landingzone","_aigroup","_wp","_helipilot","_crash","_crashwreck","_smokerand","_staticcoords","_pos","_dir","_position","_num","_config","_itemType","_itemChance","_weights","_index","_iArray","_crashModel","_lootTable","_guaranteedLoot","_randomizedLoot","_frequency","_variance","_spawnChance","_spawnMarker","_spawnRadius","_spawnFire","_permanentFire","_crashName"];

//_crashModel	= _this select 0;
//_lootTable	= _this select 1;
_guaranteedLoot = _this select 0;
_randomizedLoot = _this select 1;
_frequency	= _this select 2;
_variance	= _this select 3;
_spawnChance	= _this select 4;
_spawnMarker	= _this select 5;
_spawnRadius	= _this select 6;
_spawnFire	= _this select 7;
_fadeFire	= _this select 8;

if(count _this > 9) then {
	_useStatic = _this select 9;
} else {
	_useStatic = false;
};

//temp value. might crash if not enough elements in the array
_useStatic = true;

if(count _this > 10) then {
	_preWaypoints	= _this select 10;
} else {
	_preWaypoints = 1;
};

if(count _this > 11) then {
	_crashDamage = _this select 11;
} else {
	_crashDamage = 1;
};

diag_log(format["CRASHSPAWNER: Starting spawn logic for animated helicrashs - written by Grafzahl [SC:%1||PW:%2||CD:%3]", str(_useStatic), str(_preWaypoints), _crashDamage]);

while {true} do {
	private["_timeAdjust","_timeToSpawn","_spawnRoll","_crash","_hasAdjustment","_newHeight","_adjustedPos"];
	// Allows the variance to act as +/- from the spawn frequency timer
	_timeAdjust = round(random(_variance * 2) - _variance);
	_timeToSpawn = time + _frequency + _timeAdjust;

	//Random Heli-Type
	_heliModel = ["UH1H_DZ","Mi17_DZ"] call BIS_fnc_selectRandom;

	//Random-Startpositions, Adjust this for other Maps then Chernarus
	_heliStart = [[6993.7007,173.05298,300],[1623.715,218.18848,300]] call BIS_fnc_selectRandom;

	//A Backup Waypoint, if not Chernarus, set some Coordinates far up in the north (behind all possible Crashsites)
	_safetyPoint = [7492.6675, 15263.042];

	//Settings for the Standard UH1H_DZ
	_crashModel = "UH1Wreck_DZ";
	_exploRange = 195;
	_lootRadius = 0.35;

	//Adjust Wreck and Range of Explosion if its a Mi17_DZ
	if(_heliModel == "Mi17_DZ") then {
		_crashModel = "Mi8Wreck";
		_exploRange = 200;
		_lootRadius = 0.3;
	};

	//Crash loot - just uncomment the one you wish to use by default with 50cals is enabled.
    //Table including 50 cals
	
	// LEMON, can we might be able to create a custom loot list just for choppers.
	// we can then put in all those cool guns but only make them spawn on crash sites.
    _lootTable = ["Military"] call BIS_fnc_selectRandom;
    //Table without 50 cals
    //_lootTable = ["Military","HeliCrash_No50s","MilitarySpecial"] call BIS_fnc_selectRandom;

	_crashName	= getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");

	diag_log(format["CRASHSPAWNER: %1%2 chance to start a crashing %3 with loot table '%4' at %5", round(_spawnChance * 100), '%', _crashName, _lootTable, _timeToSpawn]);

	// Apprehensive about using one giant long sleep here given server time variances over the life of the server daemon
	while {time < _timeToSpawn} do {
		sleep 5;
	};

	_spawnRoll = random 1;

	// Percentage roll
	if (_spawnRoll <= _spawnChance) then {

/*
==================================================================================================
		_staticcoords give you the possibility to organize your crashsites!

		Crashsites close to cherno or electro would be possible with that.
		Use the editor for your map, create some vehicles or triggers at points where you
		want your crashside (aprox), save it and extract all coordinates and put them in this
		2D-Array. If you dont know how to do this, dont use _staticcoords.

		I would advise you to create at least 100 positions, otherwise its too easy for your players
		to find the crash-locations after some time of playing on your server.

		!!!!!After you put in the coordinates you have to set _useStatic to true inside
		your server_monitor.sqf, default is false!!!!!
==================================================================================================
*/

		_staticcoords =	[
							[2377.43,5297.54],
							[4590.08,9730.84],
							[4146.13,6642.86],
							[7174.14,9347.83],
							[7140.63,3960.55],
							[607.655,8531.14],
							[2060.6,6752.86],
							[2806.02,5122.63],
							[8006.6,9184.82],
							[602.741,11728.3],
							[5363.58,7698.37],
							[4979.64,4738.79],
							[10166.5,4812.54],
							[9663.62,10683.9],
							[4937.35,9580.6],
							[6266.41,8935.71],
							[7240.83,9841.8],
							[5670.49,11577.0],
							[11576.5,7220.47],
							[2357.85,5005.62],
							[10939.5,9342.48],
							[4882.78,6545.08],
							[8839.59,7810.57],
							[1902.14,7130.52],
							[9323.2,7666.79],
							[8853.8,7882.94],
							[5053.17,8905.91],
							[8293.51,5712.32],
							[7281.36,6485.34],
							[8644.46,10452.5],
							[4684.67,11884.2],
							[5692.95,11980.2],
							[10231.8,10168.1],
							[7613.71,11834.0],
							[7777.43,8725.18],
							[6620.34,4243.31],
							[8007.13,11466.4],
							[10299.0,11765.1],
							[728.733,11576.8],
							[6801.08,8215.28],
							[9395.5,8364.97],
							[10782.6,6382.9],
							[8753.96,8282.43],
							[9661.87,10969.3],
							[9888.94,10338.7],
							[8042.58,8257.58],
							[7615.82,4483.63],
							[5804.03,7178.44],
							[7884.47,4107.49],
							[11096.6,7718.56],
							[4960.69,5966.24],
							[5323.92,8620.13],
							[6765.64,7857.26],
							[9696.96,11616.4],
							[5725.41,10538.5],
							[2836.2,7541.4],
							[4673.08,8928.43],
							[5728.57,3404.78],
							[8771.85,5294.15],
							[5110.9,6514.59],
							[5949.85,6509.79],
							[6341.34,3274.86],
							[639.065,11761.8],
							[9516.93,3822.4],
							[7243.46,9763.94],
							[11502.3,9798.13],
							[7536.68,5879.17],
							[5386.75,4451.23],
							[7876.93,8518.09],
							[1347.64,10384.5],
							[5489.75,7853.42],
							[3516.35,5470.76],
							[708.553,7234.2],
							[2213.26,7149.74],
							[10696.3,11430.0],
							[8729.04,5518.82],
							[6468.91,5058.36],
							[661.701,10351.8],
							[5616.27,7231.73],
							[6641.57,4229.16],
							[5225.31,4826.27],
							[626.255,10251.2],
							[7772.34,9767.65],
							[3074.15,10541.6],
							[2589.66,4528.4],
							[10204.1,11960.1],
							[712.238,10976.6],
							[1687.36,3943.79],
							[8925.92,5845.67],
							[9181.24,11996.4],
							[7765.85,7815.93],
							[8820.99,7214.42],
							[1253.58,5151.33],
							[6666.14,10904.6],
							[1808.96,5390.42],
							[10799.7,6033.94],
							[929.478,7180.78],
							[5127.57,6094.09],
							[9336.89,6726.49],
							[6028.81,6773.32],
							[10796.5,3236.41],
							[1843.53,9193.61],
							[3692.7,4006.97],
							[7482.46,8717.9],
							[8084.51,7378.94],
							[10808.4,5293.74],
							[4315.81,11851.5],
							[9284.6,10098.3],
							[3371.23,9368.98],
							[5761.56,7548.55],
							[9075.95,5548.62],
							[6653.68,9640.75],
							[6812.49,7732.15],
							[3993.82,4403.98],
							[6491.37,8746.06],
							[5087.73,3935.42],
							[2926.75,11907.5],
							[10534.0,9304.44],
							[3123.98,5058.91],
							[10427.1,3179.42],
							[3869.75,9893.99],
							[9597.64,3665.15],
							[8049.77,6223.32],
							[5319.36,11846.8],
							[2459.45,6752.45],
							[2414.71,8845.76],
							[3438.08,10044.6],
							[8520.75,11481.1],
							[3496.69,9686.9],
							[622.219,9763.12],
							[8123.29,7651.13],
							[10065.8,4505.88],
							[8031.7,10760.5],
							[10845.8,7129.01],
							[8393.18,3881.58],
							[8098.55,8522.48],
							[5297.78,8527.43],
							[4225.8,3826.1],
							[896.488,6873.57],
							[688.198,11708.9],
							[984.577,6119.22],
							[10531.2,10199.5],
							[4278.44,11246.1],
							[4198.25,5670.57],
							[5764.19,3769.11],
							[5262.33,4232.32],
							[4781.18,11130.2],
							[1173.21,11563.8],
							[8297.19,9032.66],
							[2412.08,8485.54],
							[8010.99,3467.95],
							[8668.85,7205.5],
							[4166.66,10937.4],
							[7270.83,8860.86],
							[3557.06,4973.35],
							[10607.3,8717.35],
							[9731.71,7882.67],
							[9597.29,8349.86],
							[10916.0,11379.2],
							[5748.93,3959.59],
							[11761.8,5008.51],
							[8002.39,6857.64],
							[608.532,10542.7],
							[5016.84,4495.03],
							[5020.0,5163.83],
							[7424.37,8261.97],
							[2719.86,11880.0],
							[5542.92,4707.89],
							[5278.3,10414.3],
							[2529.12,6362.3],
							[6694.39,10716.9],
							[9608.88,3100.32],
							[10966.0,11972.1],
							[10073.4,10003.6],
							[3931.0,8753.2],
							[2664.94,6331.67],
							[6832.14,9204.05],
							[3318.58,4183.71],
							[5546.96,4619.45],
							[988.964,4836.57],
							[5977.92,6334.28],
							[5670.14,7354.91],
							[5242.15,5388.22],
							[3164.52,8166.66],
							[2382.24,11233.2],
							[4512.0,6354.61],
							[3241.38,10842.4],
							[2305.39,3815.39],
							[1764.04,11014.7],
							[2999.92,7535.77],
							[8090.48,11187.2],
							[10760.7,5591.88],
							[9236.51,3155.11],
							[700.481,6151.63],
							[6053.73,9113.27],
							[1823.0,7056.08],
							[10679.6,10087.3],
							[3699.54,10798.4],
							[3516.52,4242.76],
							[9639.76,5113.7],
							[1316.75,6449.23],
							[4965.43,5500.83],
							[5121.07,8480.32],
							[9474.64,7274.3],
							[1354.83,11255.3],
							[4830.66,10254.9],
							[6329.4,8920.33],
							[7044.12,10247.9],
							[3792.72,10943.3],
							[8010.46,8888.05],
							[1982.51,11839.5],
							[4647.99,4001.61],
							[516.407,4350.84],
							[11023.0,7434.97],
							[11064.8,6560.19],
							[10715.6,11429.2],
							[8515.83,6903.37],
							[6299.57,8754.84],
							[9671.7,8836.83],
							[7537.73,9521.14],
							[11522.8,4899.19],
							[4286.69,6354.33],
							[8928.91,11173.1],
							[2427.34,5852.26],
							[3314.37,8469.61],
							[3105.21,5611.66],
							[9499.03,11160.9],
							[6479.08,9596.4],
							[6343.79,3901.77],
							[10259.7,11223.1],
							[9745.75,10980.7],
							[9819.27,8591.29],
							[9176.33,7134.22],
							[4179.12,11367.9],
							[10907.7,6776.76],
							[4074.18,6517.34],
							[1225.51,5483.39],
							[5211.09,10846.8],
							[9937.89,4543.51],
							[3580.57,7011.18],
							[6463.29,10115.9],
							[6122.17,3327.32],
							[10663.0,7575.33],
							[4563.06,8715.43],
							[6162.7,5371.6],
							[2438.75,3833.24],
							[2899.72,9287.96],
							[9016.47,10497.7],
							[4398.29,9545.86],
							[3427.38,10682.1],
							[9903.85,4247.57],
							[11317.3,5433.81],
							[9911.75,11049.6],
							[8785.54,7665.69],
							[3047.65,3096.47],
							[6727.56,4465.51],
							[4620.79,3779.14],
							[6196.74,9614.94],
							[8841.87,10966.5],
							[793.659,11399.7],
							[9898.06,5833.72],
							[4452.16,10925.2],
							[1642.61,10026.2],
							[8008.88,7920.57],
							[10587.0,10779.9],
							[9343.38,11095.9],
							[2844.1,7985.39],
							[8065.74,11960.9],
							[5180.03,5533.79],
							[9475.86,9517.43],
							[6619.29,8296.3],
							[7111.32,8087.43],
							[4869.27,11388.8],
							[8227.18,9806.92],
							[3514.06,10147.4],
							[5010.88,8312.23],
							[7518.6,8331.6],
							[7051.66,9058.48],
							[1715.96,11315.1],
							[8934.35,4828.61],
							[8737.81,5629.37],
							[4812.06,6918.48],
							[7410.86,7639.6],
							[7073.77,5134.3],
							[2064.98,9688.13],
							[8908.2,3073.81],
							[10492.2,4181.24],
							[2011.64,4659.28],
							[8225.25,8437.75],
							[4797.67,3378.69],
							[11392.6,4439.14],
							[5575.91,5522.67],
							[1322.9,11715.0],
							[11515.9,7096.6],
							[11969.4,10159.9],
							[6929.36,11300.2],
							[6940.24,10783.9],
							[3924.68,10681.7],
							[8497.06,7903.4],
							[5448.86,4051.87],
							[4834.87,9889.73],
							[8930.84,6261.77],
							[2192.91,3468.64],
							[7632.49,5399.35],
							[5043.34,6800.65],
							[8635.51,10732.7],
							[8614.63,11931.0],
							[7009.55,6794.61],
							[620.113,7030.4],
							[7063.77,3421.26],
							[903.683,9728.23],
							[9553.25,3883.23],
							[5409.73,7531.38],
							[6492.6,11889.5],
							[4365.83,6560.33],
							[11667.9,4077.55],
							[1129.52,4189.34],
							[10463.4,6376.03],
							[2948.68,7577.52],
							[4269.49,4857.44],
							[8017.13,5831.79],
							[6228.15,10357.8],
							[7913.95,4126.99],
							[4823.12,7767.86],
							[4138.41,4892.88],
							[3253.83,3095.92],
							[4930.33,4452.87],
							[3139.77,9352.78],
							[1184.97,3596.76],
							[4698.35,9671.93],
							[6600.86,4308.4],
							[9562.55,3380.61],
							[5061.94,11638.3],
							[7850.78,8752.51],
							[4528.84,9837.82],
							[5146.87,4770.1],
							[6855.3,4084.42],
							[5521.86,6885.52],
							[11057.1,6609.63],
							[10977.1,5460.04],
							[4952.09,7089.32],
							[672.756,6966.13],
							[569.05,10633.8],
							[4177.54,9817.22],
							[6303.78,8421.0],
							[2843.4,8065.04],
							[4983.68,3040.17],
							[8484.6,6746.41],
							[9269.5,11021.0],
							[6892.86,8985.42],
							[4789.07,6992.09],
							[3860.1,8640.17],
							[7829.9,4111.34],
							[8236.13,4087.3],
							[6151.82,8353.16],
							[7816.74,4680.98],
							[11840.1,7639.87],
							[6999.55,9807.88],
							[6509.79,10678.7],
							[4423.03,7372.22],
							[4125.95,7500.07],
							[10239.0,4604.21],
							[9386.37,6594.79],
							[6346.77,9279.44],
							[4518.49,6298.03],
							[6669.65,3111.58],
							[4598.68,4414.56],
							[2541.58,5950.31],
							[8489.51,11930.3],
							[3674.63,8824.75],
							[918.247,9869.27],
							[8946.1,3930.06],
							[7384.01,5248.7],
							[6552.96,11083.5],
							[9327.76,3284.61],
							[5927.04,9880.67],
							[2145.18,8290.4],
							[5675.58,8128.76],
							[1354.31,3540.05],
							[6082.51,7011.59],
							[3185.57,6149.85],
							[3512.66,6715.78],
							[5620.3,11979.9],
							[2722.49,9121.93],
							[4533.05,9043.1],
							[1723.68,5067.15],
							[3260.5,6575.71],
							[1180.76,7698.37],
							[8414.23,3174.2],
							[645.382,3363.99],
							[778.744,5355.95],
							[10500.8,3617.64],
							[8959.96,9385.19],
							[5184.95,8950.54],
							[6658.77,8986.11],
							[9562.9,8342.58],
							[11956.4,11201.1],
							[1455.55,3629.04],
							[11765.7,5981.21],
							[4536.39,11357.2],
							[9791.9,6144.36]
		];

		if(_useStatic) then {
			_position = _staticcoords call BIS_fnc_selectRandom;
		} else {
			_position = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
		};
		//DEFAULT: GET COORDS FROM BIS_fnc_findSafePos, COMMENT OUT IF YOU USE _STATICCOORDS

		//satchel
		_str="Mayday, Mayday, Mayday .. This is Taiphoz Foxtrot 5, we are going down.......";
		[nil,nil,rHINT,_str] call RE;
		
		diag_log(format["CRASHSPAWNER: %1 started flying from %2 to %3 NOW!(TIME:%4||LT:%5)", _crashName,  str(_heliStart), str(_position), round(time), _lootTable]);

		
		//Spawn the AI-Heli flying in the air
		_startTime = time;
		_crashwreck = createVehicle [_heliModel,_heliStart, [], 0, "FLY"];

		//Make sure its not destroyed by the Hacker-Killing-Cleanup (Thanks to Sarge for the hint)
		_crashwreck setVariable["Sarge",1];

		_crashwreck engineOn true;
		_crashwreck flyInHeight 120;
		_crashwreck forceSpeed 80;
		_crashwreck setspeedmode "LIMITED";

		// side chat mayday test code Satchel.
		//_crashwreck  globalChat "MayDay MayDay MayDay, Taipgoz Fox 1 is low on fuel, Requesting .<static>......"

		//if above dont work.. try
		// globalChat "MayDay MayDay MayDay, Taipgoz Fox 1 is low on fuel, Requesting .<static>......"
		
		//Create an Invisibile Landingpad at the Crashside-Coordinates
		_landingzone = createVehicle ["HeliHEmpty", [_position select 0, _position select 1,0], [], 0, "CAN_COLLIDE"];
		_landingzone setVariable["Sarge",1];

		//Only a Woman could crash a Heli this way...
		_aigroup = creategroup civilian;
		_helipilot = _aigroup createUnit ["SurvivorW2_DZ",getPos _crashwreck,[],0,"FORM"];
		_helipilot moveindriver _crashwreck;
		_helipilot assignAsDriver _crashwreck;

		sleep 0.5;

		if(_preWaypoints > 0) then {
			for "_x" from 1 to _preWaypoints do {
				if(_useStatic) then {
					_preWaypointPos = _staticcoords call BIS_fnc_selectRandom;
				} else {
					_preWaypointPos = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
				};
				diag_log(format["CRASHSPAWNER: Adding Pre-POC-Waypoint #%1 on %2", _x,str(_preWaypointPos)]);
				_wp = _aigroup addWaypoint [_preWaypointPos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "CARELESS";
			};
		};

		_wp2 = _aigroup addWaypoint [position _landingzone, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";

		//Even when the Heli flys to high, it will burn when reaching its Waypoint
		_wp2 setWaypointStatements ["true", "_crashwreck setdamage 1;"];

		//Adding a last Waypoint up in the North, so the Heli doesnt Hover at WP1 (OR2)
		//and would also come back to WP1 if somehow it doesnt explode.
		_wp3 = _aigroup addWaypoint [_safetyPoint, 0];
		_wp3 setWaypointType "CYCLE";
		_wp3 setWaypointBehaviour "CARELESS";

		//Get some more Speed when close to the Crashpoint and go on even if Heli died or hit the ground
		waituntil {(_crashwreck distance _position) <= 1000 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
			_crashwreck flyInHeight 95;
			_crashwreck forceSpeed 140;
			_crashwreck setspeedmode "NORMAL";

		//BOOOOOOM!
		waituntil {(_crashwreck distance _position) <= _exploRange || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
			//Taking out the Tailrotor would be more realistic, but makes the POC not controllable
			//_crashwreck setHit ["mala vrtule", 1];
			_crashwreck setdamage 1;
			_crashwreck setfuel 0;
			//satchel line bellow
			//_crashwreck	MessageText = "<Taiph**...May**y.... Goi*g...... down near %2>";
			
			
			//displaying where the crash took place.
			//_pos = [getpos _crashwreck select 0, getpos _crashwreck select 1,0];
			_satchels_x = getpos _crashwreck select 0;
			_satchels_y = getpos _crashwreck select 1;
			//trying 12k rather than 14k
			_str = (format["Were going down... near at [ %1,%2 ]!", _satchels_x, (15000-_satchels_y)]);
			[nil,nil,rHINT,_str] call RE;
			
			diag_log(format["CRASHSPAWNER: %1 just exploded at %2!, ", _crashName, str(getPosATL _crashwreck)]);

			//She cant survive this :(
			_helipilot setdamage 1;

			//Giving the crashed Heli some time to find its "Parkingposition"
			sleep 13;

		//Get position of the helis wreck, but make sure its on the ground;
		_pos = [getpos _crashwreck select 0, getpos _crashwreck select 1,0];

		//saving the direction of the wreck(not used right now)
		_dir = getdir _crashwreck; 

		//Send Public Variable so every client can delete the craters around the new Wreck (musst be added in init.sqf)
		heliCrash = _pos;
		publicVariable "heliCrash";
		
		//Clean Up the Crashsite
		deletevehicle _crashwreck;
		deletevehicle _helipilot;
		deletevehicle _landingzone;

		//Animation is done, lets create the actual Crashside
		_crash = createVehicle [_crashModel, _pos, [], 0, "CAN_COLLIDE"];
		_crash setVariable["Sarge",1];

		//If you want all Grass around the crashsite to be cutted: Uncomment the next Line (Noobmode)
		//_crashcleaner = createVehicle ["ClutterCutter_EP1", _pos, [], 0, "CAN_COLLIDE"];

		//Setting the Direction would add realism, but it sucks because of the bugged model when not on plane ground.
		//If you want it anyways, just uncomment the next line
		//_crash setDir _dir;

		// I don't think this is needed (you can't get "in" a crash), but it was in the original DayZ Crash logic
		dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_crash];

		_crash setVariable ["ObjectID",1,true];

		//Make it burn (or not)
		if (_spawnFire) then {
			//["dayzFire",[_crash,2,time,false,_fadeFire]] call broadcastRpcCallAll;
			dayzFire = [_crash,2,time,false,_fadeFire];
			publicVariable "dayzFire";
			_crash setvariable ["fadeFire",_fadeFire,true];
		};

		_num        = round(random 5) + 5;
 
        _config = configFile >> "CfgBuildingLoot" >> _lootTable;
        _itemTypes = [["SCAR_H_LNG_Sniper", "weapon"], ["FN_FAL","weapon"], ["M14_EP1","weapon"], ["FN_FAL_ANPVS4","weapon"], ["Mk_48_DZ","weapon"], ["M249_DZ","weapon"], ["BAF_L85A2_RIS_SUSAT","weapon"], ["DMR","weapon"], ["G36C","weapon"], ["G36C_camo","weapon"], ["SCAR_H_CQC_CCO", "weapon"], ["G36_C_SD_camo","weapon"], ["G36A_camo","weapon"], ["G36K_camo","weapon"], ["", "military"], ["MedBox0", "object"], ["NVGoggles", "weapon"], ["AmmoBoxSmall_556", "object"], ["AmmoBoxSmall_762", "object"], ["Skin_Camo1_DZ", "magazine"], ["Skin_Soldier1_DZ", "magazine"], ["Skin_Sniper1_DZ", "magazine"], ["SVD_CAMO","weapon"], ["M24","weapon"], ["M4A1_AIM_SD_camo","weapon"], ["Sa58P_EP1","weapon"], ["Sa58V_CCO_EP1","weapon"], ["Sa58V_EP1","weapon"], ["Sa58V_RCO_EP1","weapon"], ["M4SPR","weapon"]];
        _itemChance = [0.01, 0.02, 0.05, 0.01, 0.03, 0.05, 0.01, 0.06, 0.03, 0.02, 0.01, 0.01, 0.02, 0.02, 0.9, 0.09, 0.01, 0.04, 0.05, 0.05, 0.01, 0.05, 0.05, 0.04, 0.03, 0.05, 0.05, 0.05, 0.04, 0.04];
        _weights = [];
        _weights = [_itemType,_itemChance] call fnc_buildWeightedArray;
        _cntWeights = count _weights;
        _index = _weights call BIS_fnc_selectRandom;

		//Creating the Lootpiles outside of the _crashModel
		for "_x" from 1 to _num do {
			//Create loot
			_index = floor(random _cntWeights);
			_index = _weights select _index;
			_itemType = _itemTypes select _index;

			//Let the Loot spawn in a non-perfect circle around _crashModel
			_lootPos = [_pos, ((random 2) + (sizeOf(_crashModel) * _lootRadius)), random 360] call BIS_fnc_relPos;
			[_itemType select 0, _itemType select 1, _lootPos, 0] call spawn_loot;

			diag_log(format["CRASHSPAWNER: Loot spawn at '%1' with loot table '%2'", _lootPos, sizeOf(_crashModel)]); 

			// ReammoBox is preferred parent class here, as WeaponHolder wouldn't match MedBox0 and other such items.
			_nearby = _pos nearObjects ["ReammoBox", sizeOf(_crashModel)];
			{
				_x setVariable ["permaLoot",true];
			} forEach _nearBy;
		};

		//Adding 5 dead soldiers around the wreck, poor guys
		for "_x" from 1 to 5 do {
			_lootPos = [_pos, ((random 4)+3), random 360] call BIS_fnc_relPos;
			_deadBody = createVehicle[["Body1","Body2"] call BIS_fnc_selectRandom,_lootPos,[], 0, "CAN_COLLIDE"];
			_deadBody setDir (random 360);
		};
		_endTime = time - _startTime;
		diag_log(format["CRASHSPAWNER: Crash completed! Wreck at: %2 - Runtime: %1 Seconds || Distance from calculated POC: %3 meters", round(_endTime), str(getPos _crash), round(_position distance _crash)]); 
	};
};