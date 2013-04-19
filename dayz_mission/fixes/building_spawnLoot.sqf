private["_obj","_type","_config","_positions","_iPos","_nearBy","_itemType","_itemTypes","_itemChances","_lootChance","_weights","_cntWeights","_index","_LootClass"];

_obj = 			_this select 0;
_type = 		typeOf _obj;
_config = 		configFile >> "CfgBuildingLoot" >> _type;
_positions =	[] + getArray (_config >> "lootPos");
//_itemTypes =	[] + getArray (_config >> "itemType"); // Default System
_lootChance =	getNumber (_config >> "lootChance");

//------------------//
//CUSTOM LOOT SPAWNS//
//------------------//
_itemTypes = []; //Initialise array
_itemChance = []; //Initialise array

diag_log "SPAWNING WITH CUSTOM LOOT";//Remove This line after testing

switch (_type) do { //Assign building classes
	case "Land_HouseV_1I4": { _LootClass = "Residential"; };
	case "Land_kulna": { _LootClass = "Residential"; };
	case "Land_Ind_Workshop01_04": { _LootClass = "Industrial"; };
	case "Land_hut06": { _LootClass = "Residential"; };
	case "Land_Hlidac_budka": { _LootClass = "Residential"; };
	case "Land_HouseV2_02_Interier": { _LootClass = "Residential"; };
	case "Land_A_Pub_01": { _LootClass = "Residential"; };
	case "Land_Shed_wooden": { _LootClass = "Residential"; };
	case "Land_HouseBlock_A1_1": { _LootClass = "Residential"; };
	case "Land_A_MunicipalOffice": { _LootClass = "Residential"; };
	case "Land_ruin_01": { _LootClass = "Residential"; };
	case "Land_HouseV2_04_interier": { _LootClass = "Residential"; };
	case "Land_HouseV2_01A": { _LootClass = "Residential"; };
	case "Land_psi_bouda": { _LootClass = "Residential"; };
	case "Land_KBud": { _LootClass = "Residential"; };
	case "Land_A_Castle_Bergfrit": { _LootClass = "Residential"; };
	case "Land_A_Castle_Stairs_A": { _LootClass = "Residential"; };
	case "Land_A_Castle_Gate": { _LootClass = "Residential"; };
	case "Land_sara_domek_zluty": { _LootClass = "Residential"; };
	case "Land_Church_01": { _LootClass = "Residential"; };
	case "Land_Church_03": { _LootClass = "Residential"; };
	case "Land_HouseB_Tenement": { _LootClass = "Residential"; };
	case "Land_Panelak": { _LootClass = "Residential"; };
	case "Land_Panelak2": { _LootClass = "Residential"; };
	case "Land_rail_station_big": { _LootClass = "Residential"; };
	case "Land_A_Office01": { _LootClass = "Residential"; };
	case "Land_A_Office02": { _LootClass = "Residential"; };
	case "Land_Ind_Workshop01_01": { _LootClass = "Industrial"; };
	case "Land_Ind_Garage01": { _LootClass = "Industrial"; };
	case "Land_Ind_Workshop01_02": { _LootClass = "Industrial"; };
	case "Land_Ind_Workshop01_L": { _LootClass = "Industrial"; };
	case "Land_Hangar_2": { _LootClass = "Industrial"; };
	case "Land_A_FuelStation_Build": { _LootClass = "Industrial"; };
	case "Land_Shed_Ind02": { _LootClass = "Industrial"; };
	case "Land_Misc_PowerStation": { _LootClass = "Industrial"; };
	case "Land_Shed_W01": { _LootClass = "Industrial"; };
	case "Land_Tovarna2": { _LootClass = "Industrial"; };
	case "Land_Ind_Vysypka": { _LootClass = "Industrial"; };
	case "Land_A_BuildingWIP": { _LootClass = "Industrial"; };
	case "Land_A_TVTower_Base": { _LootClass = "Industrial"; };
	case "Land_Misc_Cargo1Ao": { _LootClass = "Industrial"; };
	case "Land_Misc_Cargo1Bo": { _LootClass = "Industrial"; };
	case "Land_Nav_Boathouse": { _LootClass = "Industrial"; };
	case "Land_wagon_box": { _LootClass = "Industrial"; };
	case "Land_Rail_House_01": { _LootClass = "Industrial"; };
	case "Land_A_GeneralStore_01a": { _LootClass = "Supermarket"; };
	case "Land_A_GeneralStore_01": { _LootClass = "Supermarket"; };
	case "Land_A_Hospital": { _LootClass = "Hospital"; };
	case "MASH": { _LootClass = "Hospital"; };
	case "MASH_EP1": { _LootClass = "Hospital"; };
	case "USMC_WarfareBFieldhHospital": { _LootClass = "Hospital"; };
	case "Land_a_stationhouse": { _LootClass = "Military"; };
	case "Land_Mil_ControlTower": { _LootClass = "Military"; };
	case "Land_SS_hangar": { _LootClass = "Military"; };
	case "Land_Mil_House": { _LootClass = "Military"; };
	case "Camp": { _LootClass = "Military"; };
	case "CampEast": { _LootClass = "Military"; };
	case "CampEast_EP1": { _LootClass = "Military"; };
	case "Land_Mil_Barracks_i": { _LootClass = "MilitarySpecial"; };
	case "Land_Misc_deerstand": { _LootClass = "Hunting"; };
	case "Land_stodola_old_open": { _LootClass = "Farm"; };
	case "Land_Farm_Cowshed_a": { _LootClass = "Farm"; };
	case "Land_stodola_open": { _LootClass = "Farm"; };
	case "Land_Barn_W_01": { _LootClass = "Farm"; };
	case "Land_Barn_W_02": { _LootClass = "Farm"; };
	default { _LootClass = "Residential"; };
};

switch (_LootClass) do { //Find correct loot
	case "Residential": {
		_itemTypes = [
			["ItemSodaMdew","magazine"],
			["ItemWatch","generic"],
			["ItemCompass","generic"],
			["ItemMap","weapon"],
			["Makarov","weapon"],
			["Colt1911","weapon"],
			["ItemFlashlight","generic"],
			["ItemKnife","generic"],
			["ItemMatchbox","generic"],
			["","generic"],
			["LeeEnfield","weapon"],
			["revolver_EP1","weapon"],
			["M4SPR","weapon"],
			
			["DZ_Assault_Pack_EP1","object"], // 12
			["DZ_Czech_Vest_Puch","object"], // 12-0
			["DZ_ALICE_Pack_EP1","object"], // 16
			["DZ_TK_Assault_Pack_EP1","object"], // 16
			["DZ_British_ACU","object"], // 18
			
			["Winchester1866","weapon"],
			["WeaponHolder_ItemTent","object"],
			["","military"],
			["","trash"],
			["Crossbow_DZ","weapon"],
			["Binocular","weapon"],
			["PartWoodPile","magazine"],
			["Skin_Camo1_DZ","magazine"],
			["Skin_Sniper1_DZ","magazine"],
			["WeaponHolder_ItemCrowbar","object"],
			["MR43","weapon"] // Remember the last object doesn't not need a comma
		 ];
		_itemChance = [
			0.01,
			0.15,
			0.05,
			0.03,
			0.13,
			0.05,
			0.03,
			0.08,
			0.06,
			2,
			0.06,
			0.04,
			0.02,
			0.05, //12
			0.04, // 12-0
			0.02, //16
			0.02, //16
			0.01, //18
			0.01,
			0.01,
			0.03,
			0.5,
			0.01,
			0.06,
			0.06,
			0.01,
			0.01,
			0.08,
			0.03
		];
	};
	case "Industrial": {
		_itemTypes = [
			["","generic"],
			["","trash"],
			["","military"],
			["WeaponHolder_PartGeneric","object"],
			["WeaponHolder_PartWheel","object"],
			["WeaponHolder_PartFueltank","object"],
			["WeaponHolder_PartEngine","object"],
			["WeaponHolder_PartGlass","object"],
			["WeaponHolder_PartVRotor","object"],
			["WeaponHolder_ItemJerrycan","object"],
			["WeaponHolder_ItemHatchet","object"],
			["ItemKnife","military"],
			["ItemToolbox","weapon"],
			["ItemWire","magazine"],
			["ItemSandbag","magazine"],
			["ItemTankTrap","magazine"],
			["20Rnd_9x39_SP5_VSS","magazine"],
			["ItemEtool","weapon"]
		];
		_itemChance = [
			0.18,
			0.20,
			0.04,
			0.04,
			0.05,
			0.02,
			0.02,
			0.04,
			0.02,
			0.04,
			0.11,
			0.07,
			0.06,
			0.15,
			0.15,
			0.15,
			0.10,
			0.10
		];
	};
	case "Farm": {
		_itemTypes = [
			["WeaponHolder_ItemJerrycan","object"],
			["","generic"],
			["huntingrifle","weapon"],
			["LeeEnfield","weapon"],
			["Winchester1866","weapon"],
			["","trash"],
			["Crossbow_DZ","weapon"],
			["PartWoodPile","magazine"],
			["WeaponHolder_ItemHatchet","object"],
			["MR43","weapon"],
			["WeaponHolder_ItemMachete","object"],
			["M4SPR","weapon"]
		];
		_itemChance = [
			0.06,
			0.28,
			0.01,
			0.04,
			0.03,
			0.22,
			0.03,
			0.11,
			0.17,
			0.06,
			0.03,
			0.05
		];
	};
	case "Supermarket": {
		_itemTypes = [
			["ItemWatch","generic"],
			["ItemCompass","generic"],
			["ItemMap","weapon"],
			["Makarov","weapon"],
			["Colt1911","weapon"],
			["ItemFlashlight","generic"],
			["ItemKnife","generic"],
			["ItemMatchbox","generic"],
			["","generic"],
			["LeeEnfield","weapon"],
			["revolver_EP1","weapon"],
			["huntingrifle","weapon"],
					
			["DZ_Assault_Pack_EP1","object"], // 12
			["DZ_Czech_Vest_Puch","object"], // 12-0
			["DZ_ALICE_Pack_EP1","object"], // 16
			["DZ_TK_Assault_Pack_EP1","object"], // 16
			["DZ_British_ACU","object"], // 18
			
			["Winchester1866","weapon"],
			["WeaponHolder_ItemTent","object"],
			["","food"],
			["","trash"],
			["Crossbow_DZ","weapon"],
			["Binocular","weapon"],
			["PartWoodPile","magazine"],
			["MR43","weapon"]
		];
		_itemChance = [
			0.15,
			0.01,
			0.05,
			0.02,
			0.02,
			0.05,
			0.02,
			0.05,
			0.05,
			0.01,
			0.01,
			0.01,
			0.05, //12
			0.04, // 12-0
			0.02, //16
			0.02, //16
			0.01, //18
			0.01,
			0.01,
			0.2,
			0.15,
			0.06,
			0.02,
			0.02,
			0.01
		];
	};
	case "Hospital": {
		_itemTypes =	[
			["","trash"],
			["","hospital"],
			["MedBox0","object"]
		];
		_itemChance = [
			0.2,
			1,
			0.2
		];
	};
	case "Military": {
		_itemTypes = [
			["M9","weapon"],//1
			["M16A2","weapon"],//2
			["M16A2GL","weapon"],//3
			["M9SD","weapon"],//4
			["AK_74","weapon"],//5
			["M4A1_Aim","weapon"],//6
			["AKS_74_kobra","weapon"],//7
			["AKS_74_U","weapon"],//8
			["AK_47_M","weapon"],//9
			["M24","weapon"],//10
			["M1014","weapon"],//11
			["DMR","weapon"],//12
			["M4A1","weapon"],//13
			["M14_EP1","weapon"],//14
			["UZI_EP1","weapon"],//15
			["Remington870_lamp","weapon"],//16
			["glock17_EP1","weapon"],//17
			["MP5A5","weapon"],//18
			["MP5SD","weapon"],//19
			["M4A3_CCO_EP1","weapon"],//20
			["Binocular","weapon"],//21
			["ItemFlashlightRed","military"],//22
			["ItemKnife","military"],//23
			["ItemGPS","weapon"],//24
			["ItemMap","military"],//25
			["SVD_NSPU_EP1","weapon"], //lemons------------------//26
			["M4A3_RCO_GL_EP1","weapon"],//27
			["SCAR_H_CQC_CCO","weapon"],//28
			["VSS_vintorez","weapon"],//29
			["M16A4_GL","weapon"],//30
			["BAF_L85A2_RIS_ACOG","weapon"],//31
			["20Rnd_762x51_B_SCAR","object"],//32
			["AK_107_pso","weapon"],   //new---------------//33
			["M16A4","weapon"],//34
			["M4A1_Aim_camo","weapon"],//35
			["Saiga12K","weapon"],//36
			["Pecheneg","weapon"],//37
			["M24_des_EP1","weapon"],//38
			
			
			["DZ_ALICE_Pack_EP1","object"], // 39
			["DZ_TK_Assault_Pack_EP1","object"], // 40
			["DZ_British_ACU","object"], // 41
			["DZ_CivilBackpack_EP1","object"], // 42
			["DZ_Backpack_EP1","object"], // 43
			
			//Normal
			["","medical"],//44
			["","generic"],//45
			["","military"],//46
			//["Body","object"],
			["ItemEtool","weapon"],//47
			["ItemSandbag","magazine"],//48
			["Sa58P_EP1","weapon"],//49
			["Sa58V_EP1","weapon"],//50
			["BAF_L85A2_RIS_Holo","weapon"]//51
		];
		_itemChance = [
			0.05,//1
			0.05,//2
			0.01,//3
			0.02,//4
			0.15,//5
			0.01,//6
			0.08,//7
			0.05,//8
			0.05,//9
			0.01,//10
			0.10,//11
			0.01,//12
			0.02,//13
			0.01,//14
			0.05,//15
			0.08,//16
			0.10,//17
			0.04,//18
			0.02,//19
			0.01,//20
			0.06,//21
			0.10,//22
			0.10,//23
			0.01,//24
			0.05,//25
			0.01, //lemons--------------------------//26
			0.09,//27
			0.01,//28
			0.05,//29
			0.02,//30
			0.02,//31
			0.04,//32
			0.04, //new------//33
			0.06,//34
			0.09,//35
			0.07,//36
			0.04,//37
			0.01,//38
			//Bags
			0.08, //39
			0.08, //40
			0.06, //41
			0.01, //42
			0.01, //43 //bag end
			0.10, //44
			1.00, //45
			2.50, //46
			//0.20,
			0.05,//47
			0.02,//48
			0.03,//49
			0.03,//50
			0.01//51
		];
	};
	case "MilitarySpecial": {
		_itemTypes = [
			["M16A2","weapon"],//1
			["M16A2GL","weapon"],//2
			["M249_DZ","weapon"],//3
			["M9SD","weapon"],//4
			//["M136","weapon"],
			["AK_74","weapon"],//5
			["M4A1_Aim","weapon"],//6
			["AKS_74_kobra","weapon"],//7
			["AKS_74_U","weapon"],//8
			["AK_47_M","weapon"],//9
			["M24","weapon"],//10
			["SVD_CAMO","weapon"],//11
			["M1014","weapon"],//12
			//["M107_DZ","weapon"],
			["DMR","weapon"],//13
			["M4A1","weapon"],//14
			["M14_EP1","weapon"],//15
			["UZI_EP1","weapon"],//16
			["Remington870_lamp","weapon"],//17
			["glock17_EP1","weapon"],//18
			["M240_DZ","weapon"],//19
			["M4A1_AIM_SD_camo","weapon"],//20
			["M16A4_ACG","weapon"],//21
			["M4A1_HWS_GL_camo","weapon"],//22
			["Mk_48_DZ","weapon"],//23
			["M4A3_CCO_EP1","weapon"],//24
			["AKS_GOLD","weapon"], //Lemons-------//25
			["M4A3_RCO_GL_EP1","weapon"],//26
			["SCAR_H_CQC_CCO","weapon"],//27
			["VSS_vintorez","weapon"],//28
			["FN_FAL","weapon"],//29
			["BAF_L85A2_RIS_ACOG","weapon"],//30
			["RPK_74","weapon"],//31
			["M79_EP1","weapon"],//32
			["20Rnd_9x39_SP5_VSS","magazine"],//33
			["AK_107_pso","weapon"],   //new---------------//34
			["M16A4","weapon"],//35
			["M4A1_Aim_camo","weapon"],//36
			["Saiga12K","weapon"],//37
			["Pecheneg","weapon"],//38
			["BAF_LRR_scoped_W","weapon"],//39
			["SCAR_H_LNG_Sniper","weapon"],//40
			["SCAR_L_STD_HOLO","weapon"],//41
			["Mk13_EP1","weapon"],//42
			
			
			//Ammo
			["AmmoBoxSmall_556","object"],//43
			["AmmoBoxSmall_762","object"],//44

			["NVGoggles","weapon"],//45
			["Binocular","weapon"],//46
			["ItemFlashlightRed","military"],//47
			["ItemKnife","military"],//48
			["ItemGPS","weapon"],//49
			["ItemMap","military"],//50
			["Binocular_Vector","military"],//51

			["DZ_ALICE_Pack_EP1","object"],//52 // 16
			["DZ_TK_Assault_Pack_EP1","object"],//53 // 16
			["DZ_British_ACU","object"],//54 // 18
			["DZ_CivilBackpack_EP1","object"],//55 // 24
			["DZ_Backpack_EP1","object"],//56 // 24		

			["","medical"],//57
			["","generic"],//58
			["","military"],//59
			//["Body","object"],
			["PipeBomb","magazine"],//60
			["Sa58V_RCO_EP1","weapon"],//61
			["Sa58V_CCO_EP1","weapon"],//62
			//["G36_C_SD_camo","weapon"],
			["M40A3","weapon"],//63
			["100Rnd_762x54_PK","magazine"]//64
		];
		_itemChance = [
			0.02,//1
			0.05,//2
			0.01,//3
			0.02,//4
			//0.01, //m136
			0.07,//5
			0.02,//6
			0.07,//7
			0.07,//8
			0.07,//9
			0.01,//10
			0.01,//11
			0.20,//12
			//0.01,
			0.02,//13
			0.07,//14
			0.03,//15
			0.08,//16
			0.07,//17
			0.08,//18
			0.01,//19
			0.04,//20
			0.05,//21
			0.02,//22
			0.01,//23
			0.08,//24
			0.02,//25 //lemon
			0.07,//26 //lemons--------------------------
			0.07,//27
			0.04,//28
			0.06,//29
			0.05,//30
			0.06,//31
			0.06,//32
			0.06,//33 //new-----
			0.08,//34
			0.06,//35
			0.07,//36
			0.04,//37
			0.02,//38
			0.02,//39
			0.02,//40
			0.02,//42
			0.02,//43		
			
			0.04,//44 //amo
			0.02,//45
			0.01,//46 //NVGoggles
			0.04,//47
			0.05,//48
			0.05,//49
			0.01,//50 //ItemGPS
			0.03,//51
			0.01,//52
			//Bags
			0.08,//53 //16
			0.08,//54 //16
			0.06,//55 //18
			0.01,//56 //24
			0.01,//57 //DZ_Backpack_EP1 24
			0.30,//58

			1.00,//59
			5.00,//60 //military
			//0.20,
			0.01,//61 //PipeBomb
			0.01,//62 //Sa58V_RCO_EP1
			0.01,//63 //Sa58V_CCO_EP1
			//0.01, //["G36_C_SD_camo","weapon"],
			0.02,//64 // M40A3
			0.01//65	//["100Rnd_762x54_PK","magazine"]
		];
	};
	case "Hunting": {
		_itemTypes = [
			["ItemMap","weapon"],
			["ItemFlashlight","generic"],
			["ItemKnife","generic"],
			["ItemMatchbox","generic"],
			["Crossbow_DZ","weapon"],
			["","military"],
			["WeaponHolder_ItemMachete", "object"],
			["huntingrifle","weapon"],
			["","hunter"]
		];
		_itemChance = [
			0.08,
			0.05,
			0.04,
			0.06,
			0.03,
			2.00,
			0.03,
			0.60,
			3.00
		];
	};
};
//------------------//
//CUSTOM LOOT SPAWNS//
//------------------//
{
	if ((random 1) < _lootChance) then {
		_iPos = _obj modelToWorld _x;
		_nearBy = nearestObjects [_iPos, ["WeaponHolder","WeaponHolderBase"], 1];
		if (count _nearBy == 0) then {
			private["_index"];
			_weights = [_itemTypes,_itemChance] call fnc_buildWeightedArray;
			_index = _weights call BIS_fnc_selectRandom;
			_itemType = _itemTypes select _index;
			[_itemType select 0, _itemType select 1 , _iPos, 0.0]  call spawn_loot;
		};
	};
} forEach _positions;