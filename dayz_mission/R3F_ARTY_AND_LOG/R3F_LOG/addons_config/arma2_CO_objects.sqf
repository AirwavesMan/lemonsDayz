/**
 * English and French comments
 * Commentaires anglais et français
 * 
 * This file adds the ArmA 2 and Arrowhead objetcs in the configuration variables of the logistics system.
 * Fichier ajoutant les objets d'ArmA 2 et Arrowhead dans la configuration du système de logistique.
 * 
 * Important note : All the classes names which inherits from the ones used in configuration variables will be also available.
 * Note importante : Tous les noms de classes dérivant de celles utilisées dans les variables de configuration seront aussi valables.
 */

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of vehicles which can tow towable objects.
 * Liste des noms de classes des véhicules terrestres pouvant remorquer des objets remorquables.
 */
R3F_LOG_CFG_remorqueurs = R3F_LOG_CFG_remorqueurs +
[
	"Tractor",
	"GAZ_Vodnik",
	"S1203_TK_CIV_EP1",
	"V3S_Civ",
	"UralCivil",
	"Ural_CDF",
	"UralCivil2",
	"Ural_INS",
	"UAZ_RU",
	"hilux1_civil_3_open_EP1",
	"BAF_Offroad_D",
	"BAF_Offroad_W",
	"HMMWV_M998_crows_M2_DES_EP1",
	"ATV_US_EP1",
	"ATV_CZ_EP1",
	"UAZ_Unarmed_TK_EP1",
	"UAZ_Unarmed_TK_CIV_EP1",
	"UAZ_Unarmed_UN_EP1",
	"SUV_TK_CIV_EP1",
	"HMMWV_DZ"
];

/**
 * List of class names of towables objects.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_objets_remorquables = R3F_LOG_CFG_objets_remorquables +
[
	"UAZ_Unarmed_TK_EP1",
	"UAZ_Unarmed_TK_CIV_EP1",
	"UAZ_Unarmed_UN_EP1",
	"UAZ_RU",
	"ATV_US_EP1",
	"ATV_CZ_EP1",
	"SkodaBlue",
	"Skoda",
	"SkodaGreen",
	"Old_bike_TK_CIV_EP1",
	"Old_bike_TK_INS_EP1",
	"UH1H_DZ",
	"hilux1_civil_3_open",
	"Ikarus_TK_CIV_EP1",
	"Ikarus",
	"car_hatchback",
	"Fishing_Boat",
	"PBX",
	"Smallboat_1",
	"Volha_2_TK_CIV_EP1",
	"Volha_1_TK_CIV_EP1",
	"SUV_TK_CIV_EP1",
	"car_sedan",
	"hilux1_civil_3_open_EP1",
	"LandRover_CZ_EP1",
	"AN2_DZ",
	"Lada1_GDR",
	"Lada2_GDR",
	"Lada2_TK_CIV_EP1",
	"Lada4_GDR",
	"Lada5_GDR",
	"M1030_US_DES_EP1",
	"BAF_Offroad_D",
	"BAF_Offroad_W",
	"datsun1_civil_3_open",
	"Fishing_Boat_DZ",
	"PBX_DZ",
	"datsun1_civil_2_covered",
	"hilux1_civil_1_open",
	"hilux1_civil_2_covered",
	"Lada",
	"Lada1",
	"Lada2",
	"Lada1_TK_CIV_EP1",
	"LandRover_TK_CIV_EP1",
	"SkodaRed",
	"VolhaLimo_TK_CIV_EP1",
	"HMMWV_DZ",
	"MH60S",
	"HMMWV_M998_crows_M2_DES_EP1",
	"Policecar",
	"Mi171Sh_CZ_EP1",
	"MH6J_DZ",
	"AH6X_DZ"
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of air vehicles which can lift liftable objects.
 * Liste des noms de classes des véhicules aériens pouvant héliporter des objets héliportables.
 */
R3F_LOG_CFG_heliporteurs = R3F_LOG_CFG_heliporteurs +
[

];

/**
 * List of class names of liftable objects.
 * Liste des noms de classes des objets héliportables.
 */
R3F_LOG_CFG_objets_heliportables = R3F_LOG_CFG_objets_heliportables +
[

];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USSpecialWeaponsBox "weights" 5 units.
 * 
 * Cette section utilise une quantification du volume et/ou poids des objets.
 * Le référentiel arbitraire utilisé est : une caisse de munition de type USSpecialWeaponsBox "pèse" 5 unités.
 * 
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 * 
 * Note : la priorité d'une déclaration de capacité sur une autre correspond à leur ordre dans les tableaux.
 *   Par exemple : la classe "Truck" appartient à la classe "Car" (voir http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   Si "Truck" est déclaré avec une capacité de 140 avant "Car". Et que "Car" est déclaré après "Truck" avec une capacité de 40,
 *   Alors toutes les sous-classes appartenant à "Truck" auront une capacité de 140. Et toutes les sous-classes appartenant
 *   à "Car", exceptées celles de "Truck", auront une capacité de 40.
 */

/**
 * List of class names of (ground or air) vehicles which can transport transportable objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 * 
 * Liste des noms de classes des véhicules (terrestres ou aériens) pouvant transporter des objets transportables.
 * Le deuxième élément des tableaux est la capacité de chargement (en relation avec le coût de capacité des objets).
 */
R3F_LOG_CFG_transporteurs = R3F_LOG_CFG_transporteurs +
[
	
];

/**
 * List of class names of transportable objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 * 
 * Liste des noms de classes des objets transportables.
 * Le deuxième élément des tableaux est le coût de capacité (en relation avec la capacité des véhicules).
 */
R3F_LOG_CFG_objets_transportables = R3F_LOG_CFG_objets_transportables +
[
	
];


/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects moveable by player.
 * Liste des noms de classes des objets transportables par le joueur.
 */
R3F_LOG_CFG_objets_deplacables = R3F_LOG_CFG_objets_deplacables +
[

];