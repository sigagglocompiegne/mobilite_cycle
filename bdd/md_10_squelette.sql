/*Mobilité douce V1.0*/
/*Creation du squelette de la base et de ses déclencheurs*/
/*md_10_squelette.sql */
/*PostGIS*/
/*GeoCompiegnois - http://geo.compiegnois.fr/ */
/*Auteur : Julien Houziaux */

/*
SOMMAIRE :
 - DROP
 - SCHEMA
 - SEQUENCES
 - DOMAINE DE VALEURS
 - CLASSES OBJETS
 - FONCTIONS
 - TRIGGERS
 - COMMENTAIRES
*/

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- SCHEMA

DROP SCHEMA if exits m_mobilite_3v CASCADE;

-- CLASSES

DROP TABLE if EXISTS m_mobilite_3v.an_mob_itineraire;
DROP TABLE if EXISTS m_mobilite_3v.geo_mob_troncon;
DROP TABLE if EXISTS m_mobilite_3v.geo_mob_carrefour;
DROP TABLE if EXISTS m_mobilite_3v.an_mob_media;
DROP TABLE if EXISTS m_mobilite_3v.lk_mob_ititroncon;

-- DOMAINE DE VALEUR

DROP TABLE if exists m_mobilite_3v.lt_mob_etat_inscri;
DROP TABLE if exists m_mobilite_3v.lt_mob_niv_inscri;
DROP TABLE if exists m_mobilite_3v.lt_mob_gest_iti;
DROP TABLE if exists m_mobilite_3v.lt_mob_usage;
DROP TABLE if exists m_mobilite_3v.lt_mob_typres;
DROP TABLE if exists m_mobilite_3v.lt_mob_gest;
DROP TABLE if exists m_mobilite_3v.lt_mob_booleen;
DROP TABLE if exists m_mobilite_3v.lt_mob_ame;
DROP TABLE if exists m_mobilite_3v.lt_mob_avanc;
DROP TABLE if exists m_mobilite_3v.lt_mob_regime;
DROP TABLE if exists m_mobilite_3v.lt_mob_sens;
DROP TABLE if exists m_mobilite_3v.lt_mob_voca_iti;
DROP TABLE if exists m_mobilite_3v.lt_mob_local;
DROP TABLE if exists m_mobilite_3v.lt_mob_revet;
DROP TABLE if exists m_mobilite_3v.lt_mob_vitesse;
DROP TABLE if exists m_mobilite_3v.lt_mob_carrefour;

-- SEQUENCES 

DROP SEQUENCE m_mobilite_3v.mob_objet_seq_id CASCADE;
-DROP SEQUENCE m_mobilite_3v.mob_lk_gid CASCADE;

-- FONCTIONS

DROP FUNCTION if exists m_mobilite_3v.ft_commune_via_insee() CASCADE;
DROP FUNCTION if exists m_mobilite_3v.ft_modif_troncon() CASCADE;
DROP FUNCTION if exists m_mobilite_3v.ft_m_refresh_view_iti();
DROP FUNCTION m_mobilite_3v.ft_m_itineraire_delete_lk();

-- TRIGGERS

DROP TRIGGER if exists t_t1_date_sai ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER if exists t_t2_date_maj ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER if exists t_t3_iti_delete ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER t_t4_refresh_view_after ON m_mobilite_3v.an_mob_itineraire;

DROP TRIGGER if exists t_t2_date_sai ON m_mobilite_3v.geo_mob_troncon;
DROP TRIGGER if exists t_t3_date_maj ON m_mobilite_3v.geo_mob_troncon;
DROP TRIGGER if exists t_t4_long_m ON m_mobilite_3v.geo_mob_troncon;
DROP TRIGGER if exists t_t5_commune ON m_mobilite_3v.geo_mob_troncon;

DROP TRIGGER if exists t_t1_modif_troncon ON m_mobilite_3v.geo_v_mob_troncon;

DROP TRIGGER if exists t_t1_date_sai ON m_mobilite_3v.geo_mob_carrefour;
DROP TRIGGER if exists t_t2_date_maj ON m_mobilite_3v.geo_mob_carrefour;

DROP TRIGGER if exists t_t1_refresh_view_iti ON m_mobilite_3v.lk_mob_ititroncon;




-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           SCHEMA                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- Données métiers sur le thème des aménagements cyclables
CREATE SCHEMA m_mobilite_3v





-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         SEQUENCE                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ OBJETS ##################################################

-- Sequence pour nos nouveaux troncons, itinéraires et carrefours 
CREATE SEQUENCE m_mobilite_3v.mob_objet_seq_id
    START WITH 3000
    INCREMENT BY 1;
	
--############################################################ OBJETS ##################################################

-- Sequence pour nos gid
CREATE SEQUENCE m_mobilite_3v.mob_lk_gid
    START WITH 1000
    INCREMENT BY 1;





-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                    DOMAINES DE VALEURS                                                  ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ SITUATION ##################################################

-- Liste de valeurs d inscription à un schéma de développement des véloroutes
CREATE TABLE m_mobilite_3v.lt_mob_etat_inscri(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_etat_inscri_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_etat_inscri (code, valeur)
	VALUES ('00', 'Non renseigné'), ('10', 'Ne sais pas (inconnu)'), ('20', 'Non'), ('30', 'Oui');

--############################################################ SITUATION ##################################################

-- Liste de valeurs du niveau adminsitratif du schéma de développement des véloroutes
CREATE TABLE m_mobilite_3v.lt_mob_niv_inscri(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_niv_inscri_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_niv_inscri (code, valeur)
	VALUES ('00', 'Non renseigné'), ('10', 'Européen'), ('20', 'National'), ('30', 'Régional'), ('40', 'Départemental'), ('50', 'Intercommunal'), ('60', 'Communal'), ('70', 'Infracommunal');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des gestionnaires d itinéraire
CREATE TABLE m_mobilite_3v.lt_mob_gest_iti(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_gest_iti_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_gest_iti (code, valeur)
	VALUES ('10', 'ARC'), ('20', 'CCPE'), ('30', 'CCLO');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des usages
CREATE TABLE m_mobilite_3v.lt_mob_usage(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_usage_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_usage (code, valeur)
	VALUES  ('10', 'Cyclable'), ('20', 'Piéton');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des types de réseau
CREATE TABLE m_mobilite_3v.lt_mob_typres(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_typres_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_typres (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'REV'), ('20', 'STRUCTURANT'), ('30', 'AUTRE');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des gestionnaires
CREATE TABLE m_mobilite_3v.lt_mob_gest(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_gest_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_gest (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'État'), ('20', 'Région'), ('30', 'Département'), ('40', 'Intercommunalité'), ('50', 'Commune'), ('60', 'Privé');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des faux booléens
CREATE TABLE m_mobilite_3v.lt_mob_booleen(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_booleen_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_booleen (code, valeur)
	VALUES  ('0', 'Non renseigné'), ('f', 'Non'), ('t', 'Oui'), ('z', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des aménagements cyclables
CREATE TABLE m_mobilite_3v.lt_mob_ame(
	code varchar(2),
	valeur varchar(50),
	url varchar(255),
	modele varchar(3),
-- Contrainte
	CONSTRAINT lt_mob_ame_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_ame (code, valeur)
	VALUES  ('10', 'Non aménagé'), ('11', 'Non aménagé (jalonnement)'), ('20', 'Piste cyclable'), ('30', 'Bande cyclable'),  ('41', 'Double sens cyclable piste'), ('42', 'Double sens cyclable bande'), ('43', 'Double sens cyclable non matérialisé'), ('50', 'Voie verte'), ('60', 'Vélo rue'), ('61', 'Couloir Bus+Vélo'), ('62', 'Rampe'), ('63', 'Goulotte'), ('64', 'Aménagement mixte piéton-vélo (hors voie verte)'), ('70', 'Chaussée à voie centrale banalisée'), ('71', 'Accotement revêtu hors CVCB'), ('99', 'Autre'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des avancées de projets
CREATE TABLE m_mobilite_3v.lt_mob_avanc(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_avanc_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_avanc (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Esquisse'), ('20', 'Avant-projet'), ('30', 'Provisoire'), ('40', 'En travaux'), ('50', 'En service'), ('60', 'Supprimé'), ('70', 'Abandonné'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des régimes présent sur la voie adjacente
CREATE TABLE m_mobilite_3v.lt_mob_regime(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_regime_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_regime (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Zone 30'), ('20', 'Aire piétonne'), ('30', 'Zone de rencontre'), ('40', 'En agglomération'), ('50', 'Hors agglomération'), ('60', 'Autre'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs du sens de circulation des tronçons cyclables
CREATE TABLE m_mobilite_3v.lt_mob_sens(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_sens_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_sens (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Unidirectionnel'), ('20', 'Bidirectionnel'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs de vocation de l itinéraire
CREATE TABLE m_mobilite_3v.lt_mob_voca_iti(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_voca_iti_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_voca_iti (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Loisirs'), ('20', 'Utilitaire');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des localisations des aménagements
CREATE TABLE m_mobilite_3v.lt_mob_local(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_local_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_local (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Trottoir'), ('20', 'Intermédiaire'), ('30', 'Chaussée'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des types de revêtements et leur coût (hors foncier)
CREATE TABLE m_mobilite_3v.lt_mob_revet(
	code varchar(2),
	valeur varchar(50),
	prix_m decimal(8,2),
-- Contrainte
	CONSTRAINT lt_mob_revet_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_revet (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Lisse'), ('11', '....'), ('20', 'Meuble'), ('21', '....'), ('30', 'Rugueux'), ('31', '....'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des vitesses présentes sur une voie adjacentes
CREATE TABLE m_mobilite_3v.lt_mob_vitesse(
	code varchar(2),
	valeur varchar(20),
-- Contrainte
	CONSTRAINT lt_mob_vitesse_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_vitesse (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', '10'), ('11', '15'), ('20', '20'), ('21', '25'), ('30', '30'), ('40', '40'), ('50', '50'), ('60', '60'), ('70', '70'), ('80', '80'), ('90', '90'), ('ZZ', 'Non concerné');

--############################################################ SITUATION ##################################################

-- Liste de valeurs des types de carrefour et leur modèle
CREATE TABLE m_mobilite_3v.lt_mob_carrefour(
	code varchar(2),
	valeur varchar(50),
	modele varchar(3),
-- Contrainte
	CONSTRAINT lt_mob_carrefour_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_carrefour (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'SAS vélo'), ('20', 'Traversée'), ('30', 'Feux aménagés');






-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CLASSES OBJETS                                                   ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--################################################################# NOEUD #######################################################

-- TABLE Table alphanumérique recensant l ensemble des itinéraires déclarés sur le Pays Compiégnois
CREATE TABLE m_mobilite_3v.an_mob_itineraire(
	iditi text, --Identifiant unique (clé primaire) de l'itinéraire
	num_iti varchar(10), -- Numéro de l'itinéraire des schémas supra-intercommunaux
	num_loc varchar(10), -- Numéro de l'itinéraire local
	nom_off varchar(100), -- Nom officiel ou à défaut celui mentionné dans un document de communication grand public
	nom_usage varchar(100), -- Autre nom ou appellation de l'itinéraire en usage
	depart varchar(80), -- Nom de la localité située au départ
	via varchar(254), -- Localité ou lieu intermédiaire entre le départ et l'arrivée de l'itinéraire
	arrivee varchar(80), -- Nom de la localité située à l'arrivée
	est_inscri varchar(2), -- Précise si l'itinéraire est inscrit à un schéma de développement des véloroutes
	niv_inscri varchar(2), -- Niveau administratif du schéma dans lequel l'itinéraire est inscrit et numéroté
	nom_schema varchar(100), -- Libellé du schéma d'inscription
	an_inscri varchar(4), -- Année d'approbation du schéma dans lequel l'itinéraire est inscrit et numéroté
	an_ouvert varchar(4), -- Indique l'année d'ouverture de l'itinéraire
	gest_iti varchar(2), -- Gestion sur l'itinéraire en terme d'action sur les données
	usag varchar(2), -- Usage principal de l'itinéraire
	usage_comm boolean default false, -- diffusion des données au grand public
	voca_iti varchar(10), -- Vocation de l'itinéraire
	typ_iti varchar(40), -- Typologie des aménagements cyclables prévus dans le cadre d'un projet d'itinéraires en projet
	mao varchar(100), -- Maître d'ouvrage de l'itinéraire en projet ou en cours de travaux
	equip varchar(5000), -- Liste d'équipements potentiellement proche ou desservis par l'itinéraire
	descrip varchar(5000), -- Description de l'itinéraire (parcours, …)
	cout varchar(10), -- Estimation du coût au mètre linéaire de l''aménagement de l''itinéraire
	esti varchar(10), -- Estimation en euros de l''aménagement de l''itinéraire
	url_site varchar(254), -- Lien Http vers une page web
	observ varchar(1000), -- Commentaires
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone,  -- Date de saisie de la donnée
	date_maj timestamp without time zone, -- Date de mise à jour de la donnée
	
	CONSTRAINT an_mob_itineraire_pkey PRIMARY KEY (iditi), -- Clé primaire de la table
    CONSTRAINT lt_mob_etat_inscri_fkey FOREIGN KEY (est_inscri)
        REFERENCES m_mobilite_3v.lt_mob_etat_inscri (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeur lt_mob_etat_inscri
    CONSTRAINT lt_mob_niv_inscri_fkey FOREIGN KEY (niv_inscri)
        REFERENCES m_mobilite_3v.lt_mob_niv_inscri (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeur lt_mob_niv_inscri
	CONSTRAINT lt_mob_gest_iti_fkey FOREIGN KEY (gest_iti)
        REFERENCES m_mobilite_3v.lt_mob_gest_iti (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeur lt_mob_gest_iti
	CONSTRAINT lt_mob_usage_fkey FOREIGN KEY (usag)
        REFERENCES m_mobilite_3v.lt_mob_usage (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION -- Liste de valeur lt_mob_usage
);

--################################################################# NOEUD #######################################################

-- Table géographique représentant les tronçons d aménagement cyclables sur le Pays Compiégnois
CREATE TABLE m_mobilite_3v.geo_mob_troncon(
	idtroncon text, -- Identifiant unique (clé primaire) du tronçon
	id_osm varchar(30), -- Identifiant unique du tronçon sur OpenStreetMap
	id_on3v varchar(30), -- Identifiant unique du tronçon sur le standard 3V
	typ_res varchar(2), -- Type de réseau local
	gest varchar(2), -- Gestionnaire de l'infrastructure
	propriete varchar(2), -- Propriétaire de l'infrastructure
	d_service varchar(4), -- Année de mise en service
	trafic_vit varchar(2), -- Vitesse maximale du trafic adjacent
	lumiere varchar(1), -- Présence d'éclairage
	code_com_g varchar(5), -- Code insee de la commune à gauche de l'aménagement
	commune_g varchar(80), -- Libellé de la commune à gauche de l'aménagement
	ame_g varchar(2), -- Type d'aménagement de gauche
	avanc_g varchar(2), -- Niveau d'avancement en terme de projet à gauche
	regime_g varchar(2), -- Régime présent sur la voie de gauche
	sens_g varchar(2), -- Sens de circulation de l'aménagement de gauche
	largeur_g varchar(2), -- Largeur en mètre de l'aménagement de gauche
	local_g varchar(2), -- Localisation de l'aménagement de gauche
	revet_g varchar(2), -- Type de revêtement du tronçon de gauche
	code_com_d varchar(5), -- Code insee de la commune à droite de l'aménagement
	commune_d varchar(80), -- Libellé de la commune à droite de l'aménagement
	ame_d varchar(2), -- Type d'aménagement de droite
	avanc_d varchar(2), -- Niveau d'avancement en terme de projet à droite
	regime_d varchar(2), -- Régime présent sur la voie de droite
	sens_d varchar(2), -- Sens de circulation de l'aménagement de droite
	largeur_d varchar(2), -- Largeur en m de l'aménagement de droite
	local_d varchar(2), -- Localisation de l'aménagement de droite
	revet_d varchar(2), -- Type de revêtement du tronçon de droite
	long_m integer, -- Longueur en mètre du tronçon
	src_geom varchar(2), -- Référentiel utilisé pour la digitalisation de la géométrie
	observ varchar(1000), -- Commentaires
	verif boolean default false, -- attribut spécifiant que l'utilisaetur a vérifier l'exactitude du tronçon
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone, -- Date de saisie de la donnée
	date_maj timestamp without time zone, -- Date de mise à jour de la donnée
	geom geometry(LineString, 2154), -- Géométrie de l'objet
	
	CONSTRAINT geo_mob_troncon_pkey PRIMARY KEY (idtroncon), -- Clé primaire de la table
    CONSTRAINT typres_fkey FOREIGN KEY (typ_res)
        REFERENCES m_mobilite_3v.lt_mob_typres (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_typres
    CONSTRAINT lt_mob_gest_fkey FOREIGN KEY (gest)
        REFERENCES m_mobilite_3v.lt_mob_gest (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_gest
	CONSTRAINT lt_mob_gest_proprio_fkey FOREIGN KEY (propriete)
        REFERENCES m_mobilite_3v.lt_mob_gest (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_gest
	CONSTRAINT lt_mob_vitesse_fkey FOREIGN KEY (trafic_vit)
        REFERENCES m_mobilite_3v.lt_mob_vitesse (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_vitesse
	CONSTRAINT lt_mob_booleen_fkey FOREIGN KEY (lumiere)
        REFERENCES m_mobilite_3v.lt_mob_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_booleen
	CONSTRAINT lt_mob_ame_g_fkey FOREIGN KEY (ame_g)
        REFERENCES m_mobilite_3v.lt_mob_ame (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_ame
	CONSTRAINT lt_mob_ame_d_fkey FOREIGN KEY (ame_d)
        REFERENCES m_mobilite_3v.lt_mob_ame (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_ame
	CONSTRAINT lt_mob_avanc_g_fkey FOREIGN KEY (avanc_g)
        REFERENCES m_mobilite_3v.lt_mob_avanc (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_avanc
	CONSTRAINT lt_mob_avanc_d_fkey FOREIGN KEY (avanc_d)
        REFERENCES m_mobilite_3v.lt_mob_avanc (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_avanc
	CONSTRAINT lt_mob_regime_g_fkey FOREIGN KEY (regime_g)
        REFERENCES m_mobilite_3v.lt_mob_regime (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_regime
	CONSTRAINT lt_mob_regime_d_fkey FOREIGN KEY (regime_d)
        REFERENCES m_mobilite_3v.lt_mob_regime (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_regime
	CONSTRAINT lt_mob_sens_g_fkey FOREIGN KEY (sens_g)
        REFERENCES m_mobilite_3v.lt_mob_sens (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_sens
	CONSTRAINT lt_mob_sens_d_fkey FOREIGN KEY (sens_d)
        REFERENCES m_mobilite_3v.lt_mob_sens (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_sens
	CONSTRAINT lt_mob_local_g_fkey FOREIGN KEY (local_g)
        REFERENCES m_mobilite_3v.lt_mob_local (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_local
	CONSTRAINT lt_mob_local_d_fkey FOREIGN KEY (local_d)
        REFERENCES m_mobilite_3v.lt_mob_local (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_local
	CONSTRAINT lt_mob_revet_g_fkey FOREIGN KEY (revet_g)
        REFERENCES m_mobilite_3v.lt_mob_revet (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_revet
	CONSTRAINT lt_mob_revet_d_fkey FOREIGN KEY (revet_d)
        REFERENCES m_mobilite_3v.lt_mob_revet (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_revet
	CONSTRAINT lt_mob_src_geom_fkey FOREIGN KEY (src_geom)
        REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION -- Liste de valeurs des sources géométriques
);

--################################################################# NOEUD #######################################################

-- Table de relation permettant le rattachement des tronçons à un ou plusieurs itinéraires
CREATE TABLE m_mobilite_3v.lk_mob_ititroncon(
	gid bigint, -- Identifiant unique (clé primaire) de la relation
	idtroncon text, -- Identifiant unique du tronçon
	iditi text, -- Identifiant unique de l'itinéraire
	CONSTRAINT lk_mob_ititroncon_pkey PRIMARY KEY (gid) -- Clé primaire de la table
);

--################################################################# NOEUD #######################################################

-- Table géographique représentant la localisation des carrefours aménagés sur des intersections de tronçons cyclables sur le Pays Compiégnois
CREATE TABLE m_mobilite_3v.geo_mob_carrefour(
	idcarrefour text, -- Identifiant unique (clé primaire) du tronçon
	libelle varchar(255), -- 
	typ_car varchar(2), -- Type de carrefour
	avanc varchar(2), -- Niveau d'avancement en terme de projet
	insee varchar(5), -- Code insee de la commune d'implantation
	commune varchar(80), -- Nom de la commune d'implantation
	observ varchar(1000), -- Commentaires
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone, -- Date de saisie de la donnée
	date_maj timestamp without time zone, -- Date de mise à jour de la donnée
	geom geometry(Point, 2154), -- Géométrie de l'objet
	CONSTRAINT geo_mob_carrefour_pkey PRIMARY KEY (idcarrefour), -- Clé primaire de la table
    CONSTRAINT lt_mob_carrefour_fkey FOREIGN KEY (typ_car)
        REFERENCES m_mobilite_3v.lt_mob_carrefour (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_carrefour
    CONSTRAINT lt_mob_avanc_fkey FOREIGN KEY (avanc)
        REFERENCES m_mobilite_3v.lt_mob_avanc (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION -- Liste de valeurs lt_mob_avanc
);
--################################################################# NOEUD #######################################################

-- Table alphanumérique gérant la liste des documents associés aux objets cyclables
CREATE TABLE m_mobilite_3v.an_mob_media(
	qid bigint, -- Identifiant unique (clé primaire) du média
	gid text, -- Identifiant de l'objet référence
	media text, -- Champ Média de GEO
	miniature bytea, -- Champ miniature de GEO
	n_fichier text, -- Nom du fichier
	t_fichier text, -- Type de média dans GEO
	l_prec varchar(1000), -- Précision sur le document
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone, -- Date de saisie
	CONSTRAINT an_mob_media_pkey PRIMARY KEY (qid) -- Clé primaire de la table
);





-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         FONCTIONS                                                       ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

--################################################################# FONCTION #######################################################

-- Fonction m_mobilite_3v.ft_commune_via_insee() recupérant les noms des communes via leur code insee
CREATE FUNCTION m_mobilite_3v.ft_commune_via_insee()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
-- Selectionne le nom des communes en fonction du code insee choisi par l'utilisateur
new.commune_g = (SELECT c.commune FROM r_osm.geo_vm_osm_commune_oise c WHERE c.insee = new.code_com_g);
new.commune_d = (SELECT c.commune FROM r_osm.geo_vm_osm_commune_oise c WHERE c.insee = new.code_com_d);
return new;
end;
$BODY$;

--################################################################# FONCTION #######################################################

-- Fonction m_mobilite_3v.ft_modif_troncon() modifiant la table des troncons quand il y a une insertion, un update ou une suppression 
CREATE FUNCTION m_mobilite_3v.ft_modif_troncon()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
-- déclaration d'une variable de type entier v_count stockant le nombre d'intersection entre un tronçon modifié et les limites communes
DECLARE v_count integer;
BEGIN
-- INSERTION D'UN NOUVELLE ELEMENT DANS LA TABLE
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO m_mobilite_3v.geo_mob_troncon(idtroncon,id_osm,id_on3v,typ_res,gest,propriete,d_service,trafic_vit,lumiere,code_com_g,commune_g,ame_g,avanc_g,regime_g,sens_g,largeur_g,local_g,revet_g,code_com_d,commune_d,ame_d,avanc_d,regime_d,sens_d,largeur_d,local_d,revet_d,src_geom,observ,verif,op_sai,geom)
			SELECT 'T' || nextval('m_mobilite_3v.mob_objet_seq_id'),
			new.id_osm,
			new.id_on3v,
			new.typ_res,
			new.gest,
			new.propriete,
			new.d_service,
			new.trafic_vit,
			new.lumiere,
			new.code_com_g,
			new.commune_g,
			new.ame_g,
			new.avanc_g, 
			new.regime_g,
			new.sens_g,
			new.largeur_g,
			new.local_g, 
			new.revet_g, 
			new.code_com_d,
			new.commune_d,
			new.ame_d,
			new.avanc_d,
			new.regime_d, 
			new.sens_d,
			new.largeur_d,
			new.local_d, 
			new.revet_d, 
			new.src_geom, 
			new.observ,
			new.verif,	
			new.op_sai,
			(ST_Dump(st_intersection(new.geom,c.geom))).geom AS geom from r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE;
-- mise A JOUR DU TRONCON
	ELSIF (TG_OP) = 'UPDATE' THEN
		-- je vérifie si le tronçon a été modifié
		IF st_equals(new.geom,old.geom) IS TRUE THEN
			-- je mets à jour les attribtus mais pas la géométrie
			UPDATE m_mobilite_3v.geo_mob_troncon 
				SET id_osm 		 =  new.id_osm,	
					id_on3v 	 =  new.id_on3v, 
					typ_res 	 =  new.typ_res, 
					gest 		 =  new.gest, 		
					propriete 	 =  new.propriete,
					d_service 	 =  new.d_service,
					trafic_vit 	 =  new.trafic_vit,
					lumiere 	 =  new.lumiere, 
					code_com_g	 =  new.code_com_g,
					commune_g 	 =  new.commune_g,
					ame_g		 =  new.ame_g,		
					avanc_g 	 =  new.avanc_g, 
					regime_g 	 =  new.regime_g, 
					sens_g 		 =  new.sens_g, 	
					largeur_g	 =  new.largeur_g,
					local_g 	 =  new.local_g, 
					revet_g 	 =  new.revet_g, 
					code_com_d 	 =  new.code_com_d,
					commune_d 	 =  new.commune_d,
					ame_d 		 =  new.ame_d, 		
					avanc_d 	 =  new.avanc_d, 
					regime_d	 =  new.regime_d,
					sens_d 		 =  new.sens_d, 	
					largeur_d	 =  new.largeur_d,
					local_d 	 =  new.local_d, 
					revet_d 	 =  new.revet_d,
					long_m		 =  new.long_m,
					src_geom 	 =  new.src_geom, 
					observ 		 =  new.observ,		
					verif 		 =  new.verif, 		
					op_sai       =  new.op_sai,
					geom         =  new.geom
				WHERE idtroncon = new.idtroncon;			
		ELSE
			-- je compte les intersections avec les communes
			-- si le résultat est inférieur ou égale à 1, le tronçon est toujours dans la même commune mais modifié
			IF (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE) <= 1 THEN
				-- je mets à jour les données pour 1 tronçon
				UPDATE  m_mobilite_3v.geo_mob_troncon 
					SET id_osm 		 =  new.id_osm,	
						id_on3v 	 =  new.id_on3v, 
						typ_res 	 =  new.typ_res, 
						gest 		 =  new.gest, 		
						propriete 	 =  new.propriete,
						d_service 	 =  new.d_service,
						trafic_vit 	 =  new.trafic_vit,
						lumiere 	 =  new.lumiere, 
						code_com_g	 =  new.code_com_g,
						commune_g 	 =  new.commune_g,
						ame_g		 =  new.ame_g,		
						avanc_g 	 =  new.avanc_g, 
						regime_g 	 =  new.regime_g, 
						sens_g 		 =  new.sens_g, 	
						largeur_g	 =  new.largeur_g,
						local_g 	 =  new.local_g, 
						revet_g 	 =  new.revet_g, 
						code_com_d 	 =  new.code_com_d,
						commune_d 	 =  new.commune_d,
						ame_d 		 =  new.ame_d, 		
						avanc_d 	 =  new.avanc_d, 
						regime_d	 =  new.regime_d,
						sens_d 		 =  new.sens_d, 	
						largeur_d	 =  new.largeur_d,
						local_d 	 =  new.local_d, 
						revet_d 	 =  new.revet_d,
						long_m		 =  new.long_m,
						src_geom 	 =  new.src_geom, 
						observ 		 =  new.observ,		
						verif 		 =  new.verif, 		
						op_sai       =  new.op_sai,
						geom 		 =  new.geom 
					WHERE idtroncon = new.idtroncon ;
			-- si le résultat est supérieur à 1, le tronçon sera découpé en plusieurs parties
			ELSE
				-- suppression de l'ancien tronçon qui sera découpé
				DELETE FROM m_mobilite_3v.geo_mob_troncon t WHERE t.idtroncon = old.idtroncon;
				-- insertion des tronçons découpés
				INSERT INTO m_mobilite_3v.geo_mob_troncon(idtroncon,id_osm,id_on3v,typ_res,gest,propriete,d_service,trafic_vit,lumiere,code_com_g,commune_g,ame_g,avanc_g,regime_g,sens_g,largeur_g,local_g,revet_g,code_com_d,commune_d,ame_d,avanc_d,regime_d,sens_d,largeur_d,local_d,revet_d,src_geom,observ,verif,op_sai,geom)
					SELECT 'T' || nextval('m_mobilite_3v.mob_objet_seq_id'::regclass),
					new.id_osm,
					new.id_on3v,
					new.typ_res,
					new.gest,
					new.propriete,
					new.d_service,
					new.trafic_vit,
					new.lumiere,
					new.code_com_g,
					new.commune_g,
					new.ame_g,
					new.avanc_g, 
					new.regime_g,
					new.sens_g,
					new.largeur_g,
					new.local_g, 
					new.revet_g, 
					new.code_com_d,
					new.commune_d,
					new.ame_d,
					new.avanc_d,
					new.regime_d, 
					new.sens_d,
					new.largeur_d,
					new.local_d, 
					new.revet_d, 
					new.src_geom, 
					new.observ,
					new.verif,	
					new.op_sai,
					(ST_Dump(st_intersection(new.geom,c.geom))).geom AS geom from r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE AND st_geometrytype((st_intersection(new.geom,c.geom))) = 'ST_LineString';
				-- j'initialise la variable v_count avec le nombre d'intersection remontée
				v_count := (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE);			
				-- requête mettant à jour la table des relations tronçon-itinéraire
				WITH
				--  je sélectionne les tronçons qui viennent d'être intégrés à la table des tronçons (ex : si 2 tronçons nouveaux, je récupère les 2 derniers dans la table des tronçons)
				req_tr AS
				(SELECT idtroncon FROM m_mobilite_3v.geo_mob_troncon ORDER BY date_sai DESC LIMIT v_count),
				-- je sélectionne les itinéraires affectés à l'ancien tronçon (supprimé)
				req_iti AS
				(SELECT iditi FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = old.idtroncon)
				-- insertion dans la table des relations troncon-itinéraire
				INSERT INTO m_mobilite_3v.lk_mob_ititroncon (idtroncon,iditi, gid)
				select 
					req_tr.idtroncon,
					req_iti.iditi,
					nextval('m_mobilite_3v.mob_lk_gid'::regclass) FROM req_tr,req_iti, m_mobilite_3v.mob_lk_gid;
				-- suppression dans la table des relations troncon-itinéraire, des relations du tronçon supprimé
				DELETE FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = old.idtroncon;
			END IF;
		END IF;
-- SUPPRESSION DU TRONCON
	ELSIF (TG_OP) = 'DELETE' THEN
		-- Suppression du troncon dans la table des troncons
		DELETE FROM m_mobilite_3v.geo_mob_troncon t WHERE t.idtroncon = old.idtroncon;
		-- Suppression du troncon dans la liste de lien troncon-itinéraire
		DELETE FROM m_mobilite_3v.lk_mob_ititroncon i WHERE i.idtroncon = old.idtroncon;
	END IF;
RETURN new;
END;
$BODY$;


--################################################################# FONCTION #######################################################
-- fonction de rafraichissement de la vue materialisée
CREATE FUNCTION m_mobilite_3v.ft_m_refresh_view_iti()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
   REFRESH MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_iti;
   return new;
END;
$BODY$;


--################################################################# FONCTION #######################################################
-- fonction trigger pour la suppression des relations tronçons-itinéraire dans la table lk_mob_ititroncon
CREATE FUNCTION m_mobilite_3v.ft_m_itineraire_delete_lk()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
   DELETE FROM m_mobilite_3v.lk_mob_ititroncon WHERE iditi = old.iditi;
   return new;
END;
$BODY$;





-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         TRIGGERS                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################



-- Trigger sur la table an_mob_itineraire
--################################################################# TRIGGER #######################################################
-- Trigger t_t1_date_sai pour la fonction ecrivant la date de saisie
CREATE TRIGGER t_t1_date_sai
    BEFORE INSERT 
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# TRIGGER #######################################################
-- Trigger t_t2_date_maj pour la fonction ecrivant la date de mise a jour 
CREATE TRIGGER t_t2_date_maj
    BEFORE UPDATE 
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# TRIGGER #######################################################
CREATE TRIGGER t_t3_iti_delete
    BEFORE DELETE
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_itineraire_delete_lk();
--################################################################# TRIGGER #######################################################
CREATE TRIGGER t_t4_refresh_view_after
    AFTER DELETE
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_refresh_view_iti();


-- Trigger sur la table geo_mob_troncon
--################################################################# TRIGGER #######################################################
-- Trigger t_t2_date_sai pour la fonction ecrivant la date de saisie
CREATE TRIGGER t_t2_date_sai
    BEFORE INSERT
    ON m_mobilite_3v.geo_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# TRIGGER #######################################################
-- Trigger t_t3_date_maj pour la fonction ecrivant la date de mise a jour
CREATE TRIGGER t_t3_date_maj
    BEFORE UPDATE
    ON m_mobilite_3v.geo_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# TRIGGER #######################################################
-- Trigger t_t4_long_m pour la fonction calculant la longueur du tracé
CREATE TRIGGER t_t4_long_m
    BEFORE UPDATE OR INSERT
    ON m_mobilite_3v.geo_mob_troncon 
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_longm_maj();
--################################################################# TRIGGER #######################################################
-- Trigger t_t5_commune pour la fonction recuperant le nom de la commune (CHANGER LE NOM DE LA TABLE (Oise))
CREATE TRIGGER t_t5_commune
    BEFORE UPDATE OR INSERT
    ON m_mobilite_3v.geo_mob_troncon 
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_commune_via_insee();
    

-- Trigger sur la table geo_mob_carrefour
--################################################################# TRIGGER #######################################################
-- Trigger t_t1_date_sai pour la fonction ecrivant la date de saisie
CREATE TRIGGER t_t1_date_sai
    BEFORE INSERT 
    ON m_mobilite_3v.geo_mob_carrefour
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# TRIGGER #######################################################
-- Trigger t_t2_date_maj pour la fonction ecrivant la date de mise a jour
CREATE TRIGGER t_t2_date_maj
    BEFORE UPDATE 
    ON m_mobilite_3v.geo_mob_carrefour
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();


-- Trigger sur la table lk_mob_ititroncon
--################################################################# TRIGGER #######################################################
-- Trigger t_t1_refresh_view_iti pour le rafraichissement de la vue métérialisée
CREATE TRIGGER t_t1_refresh_view_iti
    AFTER INSERT OR UPDATE OR DELETE 
    ON m_mobilite_3v.lk_mob_ititroncon
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_refresh_view_iti();
    
  
    
    
    
-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################



COMMENT ON SCHEMA m_mobilite_3v IS 'Données métiers sur le thème des aménagements cyclables';
COMMENT ON TABLE m_mobilite_3v.lt_mob_etat_inscri IS 'Liste de valeurs d inscription à un schéma de développement des véloroutes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_etat_inscri.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_etat_inscri.valeur IS 'Libellé de la valeur dinscription';

COMMENT ON TABLE m_mobilite_3v.lt_mob_niv_inscri IS 'Liste de valeurs du niveau adminsitratif du schéma de développement des véloroutes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_niv_inscri.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_niv_inscri.valeur IS 'Libellé de la valeur du niveau';

COMMENT ON TABLE m_mobilite_3v.lt_mob_gest_iti IS 'Liste de valeurs des gestionnaires d itinéraire';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest_iti.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest_iti.valeur IS 'Libellé de la valeur du gestionnaire';

COMMENT ON TABLE m_mobilite_3v.lt_mob_usage IS 'Liste de valeurs des usages';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_usage.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_usage.valeur IS 'Libellé de la valeur des usages';

COMMENT ON TABLE m_mobilite_3v.lt_mob_typres IS 'Liste de valeurs des types de réseau';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_typres.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_typres.valeur IS 'Libellé de la valeur des types de réseau locaux';

COMMENT ON TABLE m_mobilite_3v.lt_mob_gest IS 'Liste de valeurs des gestionnaires';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest.valeur IS 'Libellé de la valeur des gestionnaires';

COMMENT ON TABLE m_mobilite_3v.lt_mob_booleen 	IS 'Liste de valeurs des faux booléens';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_booleen.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_booleen.valeur IS 'Libellé de la valeur des faux booléens';

COMMENT ON TABLE m_mobilite_3v.lt_mob_ame IS 'Liste de valeurs des aménagements cyclables';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.valeur IS 'Libellé de la valeur des aménagements cyclables';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.url IS 'Lien URL vers la documentation nationale';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.modele IS 'Code du modèle d aménagement';
	
COMMENT ON TABLE m_mobilite_3v.lt_mob_avanc IS 'Liste de valeurs des avancées de projets';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_avanc.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_avanc.valeur IS 'Libellé de la valeur des aménagements cyclables';

COMMENT ON TABLE m_mobilite_3v.lt_mob_regime IS 'Liste de valeurs des régimes présent sur la voie adjacente';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_regime.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_regime.valeur IS 'Libellé de la valeur des régimes';

COMMENT ON TABLE m_mobilite_3v.lt_mob_sens IS 'Liste de valeurs du sens de circulation des tronçons cyclables';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_sens.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_sens.valeur IS 'Libellé de la valeur des régimes';

COMMENT ON TABLE m_mobilite_3v.lt_mob_voca_iti IS 'Liste de valeurs de vocation de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_voca_iti.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_voca_iti.valeur IS 'Libellé de la valeur des vocations';

COMMENT ON TABLE m_mobilite_3v.lt_mob_local IS 'Liste de valeurs des localisations des aménagements';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_local.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_local.valeur IS 'Libellé de la valeur des régimes';

COMMENT ON TABLE m_mobilite_3v.lt_mob_revet IS 'Liste de valeurs des types de revêtements et leur coût (hors foncier)';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_revet.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_revet.valeur IS 'Libellé de la valeur des régimes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_revet.prix_m IS 'Prix moyen au mètre linéaire';

COMMENT ON TABLE m_mobilite_3v.lt_mob_vitesse IS 'Liste de valeurs des vitesses présentes sur une voie adjacentes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_vitesse.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_vitesse.valeur IS 'Libellé de la valeur des régimes';

COMMENT ON TABLE m_mobilite_3v.lt_mob_carrefour IS 'Liste de valeurs des types de carrefour et leur modèle';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_carrefour.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_carrefour.valeur IS 'Libellé de la valeur des régimes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_carrefour.modele IS 'Code du modèle de carrefour';

COMMENT ON TABLE m_mobilite_3v.an_mob_itineraire IS 'Table alphanumérique recensant l ensemble des itinéraires déclarés sur le Pays Compiégnois (en projet ou ouvert)';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.iditi is 'Identifiant unique (clé primaire) de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.num_iti is 'Numéro de l itinéraire des schémas supra-intercommunaux';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.num_loc is 'Numéro de l itinéraire local';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.nom_off is 'Nom officiel ou à défaut celui mentionné dans un document de communication grand public';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.nom_usage is 'Autre nom ou appellation de l itinéraire en usage';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.depart is 'Nom de la localité située au départ';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.arrivee is 'Nom de la localité située à l arrivée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.est_inscri is 'Précise si l itinéraire est inscrit à un schéma de développement des véloroutes';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.niv_inscri is 'Niveau administratif du schéma dans lequel l itinéraire est inscrit et numéroté';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.nom_schema is 'Libellé du schéma d inscription';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.an_inscri is 'Année d approbation du schéma dans lequel l itinéraire est inscrit et numéroté';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.an_ouvert is 'Indique l année d ouverture de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.gest_iti is 'Gestion sur l itinéraire en terme d action sur les données';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.usag is 'Usage principal de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.observ is 'Commentaires';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.op_sai is 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.date_sai is 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.date_maj is 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.usage_comm is 'diffusion des données au grand public';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.via is 'Localité ou lieu intermédiaire entre le départ et l arrivée de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.voca_iti is 'Vocation de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.typ_iti is 'Typologie des aménagements cyclables prévus dans le cadre d un projet d itinéraires en projet';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.mao is 'Maître d ouvrage de l itinéraire en projet ou en cours de travaux';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.equip is 'Liste d équipements potentiellement proche ou desservis par l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.descrip is 'Description de l itinéraire (parcours, …)';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.cout is 'Estimation du coût au mètre linéaire de l aménagement de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.esti is 'Estimation en euros de l aménagement de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.url_site is 'Lien Http vers une page web';

COMMENT ON TABLE m_mobilite_3v.geo_mob_troncon IS 'Table géographique représentant les tronçons d aménagement cyclables sur le Pays Compiégnois';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.idtroncon is 'Identifiant unique (clé primaire) du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.id_osm is 'Identifiant unique du tronçon sur OpenStreetMap';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.id_on3v is 'Identifiant unique du tronçon sur le standard 3V';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.typ_res is 'Type de réseau local';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.gest is 'Gestionnaire de l infrastructure';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.propriete is 'Propriétaire de l infrastructure';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.d_service is 'Année de mise en service';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.trafic_vit is 'Vitesse maximale du trafic adjacent';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.lumiere is 'Présence d éclairage';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.code_com_g is 'Code insee de la commune à gauche de l aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.commune_g is 'Libellé de la commune à gauche de l aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.ame_g is 'Type d aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.avanc_g is 'Niveau d avancement en terme de projet à gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.regime_g is 'Régime présent sur la voie de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.sens_g is 'Sens de circulation de l aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.largeur_g is 'Largeur en mètre de l aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.local_g is 'Localisation de l aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.revet_g is 'Type de revêtement du tronçon de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.code_com_d is 'Code insee de la commune à droite de l aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.commune_d is 'Libellé de la commune à droite de l aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.ame_d is 'Type d aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.avanc_d is 'Niveau d avancement en terme de projet à droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.regime_d is 'Régime présent sur la voie de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.sens_d is 'Sens de circulation de l aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.largeur_d is 'Largeur en mètre de l aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.local_d is 'Localisation de l aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.revet_d is 'Type de revêtement du tronçon de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.long_m is 'Longueur en mètre du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.src_geom is 'Référentiel utilisé pour la digitalisation de la géométrie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.observ is 'Commentaires';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.op_sai is 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.date_sai is 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.date_maj is 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.geom is 'Géométrie de l objet';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.verif is 'attribut spécifiant que l utilisaetur a vérifier l exactitude du tronçon';

COMMENT ON TABLE m_mobilite_3v.lk_mob_ititroncon IS 'Table de relation permettant le rattachement des tronçons à un ou plusieurs itinéraires';
COMMENT ON COLUMN m_mobilite_3v.lk_mob_ititroncon.gid is 'Identifiant unique (clé primaire) de la relation';
COMMENT ON COLUMN m_mobilite_3v.lk_mob_ititroncon.idtroncon is 'Identifiant unique du tronçon';
COMMENT ON COLUMN m_mobilite_3v.lk_mob_ititroncon.iditi is 'Identifiant unique de litinéraire';

COMMENT ON TABLE m_mobilite_3v.geo_mob_carrefour IS 'Table géographique représentant la localisation des carrefours aménagés sur des intersections de tronçons cyclables sur le Pays Compiégnois';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.idcarrefour is 'Identifiant unique (clé primaire) du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.libelle is 'Libellé du carrefour';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.typ_car is 'Type de carrefour';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.avanc is 'Niveau d avancement en terme de projet';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.insee is 'Code insee de la commune d implantation';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.commune is 'Nom de la commune d implantation';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.observ is 'Commentaires';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.op_sai is 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.date_sai is 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.date_maj is 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.geom is 'Géométrie de l objet';

COMMENT ON TABLE m_mobilite_3v.an_mob_media IS 'Table alphanumérique gérant la liste des documents associés aux objets cyclables';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.qid is 'Identifiant uniqueue (clé primaire) du média';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.gid is 'Identifiant de l objet référence';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.media is 'Champ Média de GEO';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.miniature is 'Champ miniature de GEO';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.n_fichier is 'Nom du fichier';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.t_fichier is 'Type de média dans GEO';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.l_prec is 'Précision sur le document';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.op_sai is 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.date_sai is 'Date de saisie';

COMMENT ON FUNCTION m_mobilite_3v.ft_modif_troncon() IS 'Fonction trigger pour la modification de la table geo_mob_troncon';
COMMENT ON FUNCTION m_mobilite_3v.ft_commune_via_insee() IS 'Fonction trigger recupérant les noms des communes via leur code insee';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_refresh_view_iti() IS 'Fonction trigger pour le rafraichissement de la vue des itinéraires après suppression d un itinéraire';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_itineraire_delete_lk() IS 'Fonction trigger pour la suppression des relations tronçons-itinéraire dans la table lk_mob_ititroncon';
