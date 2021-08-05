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
 - APPLICATIF
*/

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- SCHEMA

DROP SCHEMA if exists m_mobilite_3v;

-- CLASSES

DROP TABLE if exists m_mobilite_3v.an_mob_itineraire;
DROP TABLE if exists m_mobilite_3v.an_mob_media;
DROP TABLE if exists m_mobilite_3v.an_mob_equstatio;
DROP TABLE if exists m_mobilite_3v.an_mob_log;
DROP TABLE if exists m_mobilite_3v.lk_mob_ititroncon;
DROP TABLE if exists m_mobilite_3v.geo_mob_troncon;
DROP TABLE if exists m_mobilite_3v.geo_mob_carrefour;
DROP TABLE if exists m_mobilite_3v.geo_mob_lieustatio;

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
DROP TABLE if exists m_mobilite_3v.lt_mob_statio_mobi;
DROP TABLE if exists m_mobilite_3v.lt_mob_statio_accro;
DROP TABLE if exists m_mobilite_3v.lt_mob_statio_acces;
DROP TABLE if exists m_mobilite_3v.lt_mob_statio_protec;

-- SEQUENCES 

DROP SEQUENCE if exists m_mobilite_3v.mob_objet_seq_id;
DROP SEQUENCE if exists m_mobilite_3v.mob_lk_gid;
DROP SEQUENCE if exists m_mobilite_3v.mob_media_seq_gid;
DROP SEQUENCE if exists m_mobilite_3v.an_mob_equstatio_seq_id;
DROP SEQUENCE if exists m_mobilite_3v.an_mob_log_seq_id;

-- FONCTIONS

DROP FUNCTION if exists m_mobilite_3v.ft_commune_via_insee_troncon_cy();
DROP FUNCTION if exists m_mobilite_3v.ft_modif_troncon();
DROP FUNCTION if exists m_mobilite_3v.ft_m_refresh_view_iti();
DROP FUNCTION if exists m_mobilite_3v.ft_m_itineraire_delete_lk();
DROP FUNCTION if exists m_mobilite_3v.ft_m_mobi_capacite();
DROP FUNCTION if exists m_mobilite_3v.ft_m_equstatio_delete();
DROP FUNCTION if exists m_mobilite_3v.ft_m_geo_mobilite_3v_log();
DROP FUNCTION if exists m_mobilite_3v.ft_m_refresh_view_troncon_affiche();

-- TRIGGERS

DROP TRIGGER if exists t_t1_date_sai ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER if exists t_t2_date_maj ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER if exists t_t3_iti_delete ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER if exists t_t4_refresh_view_after ON m_mobilite_3v.an_mob_itineraire;
DROP TRIGGER if exists t_t9_geo_mobilite_3v_log ON m_mobilite_3v.an_mob_itineraire;

DROP TRIGGER if exists t_t2_date_sai ON m_mobilite_3v.geo_mob_troncon;
DROP TRIGGER if exists t_t3_date_maj ON m_mobilite_3v.geo_mob_troncon;
DROP TRIGGER if exists t_t4_long_m ON m_mobilite_3v.geo_mob_troncon;
DROP TRIGGER if exists t_t5_commune ON m_mobilite_3v.geo_mob_troncon;
DROp TRIGGER if exists t_t6_refresh_view_iti ON m_mobilite_3v.geo_mob_troncon;

DROP TRIGGER if exists t_t1_date_sai ON m_mobilite_3v.geo_mob_carrefour;
DROP TRIGGER if exists t_t2_date_maj ON m_mobilite_3v.geo_mob_carrefour;
DROP TRIGGER if exists t_t3_commune ON m_mobilite_3v.geo_mob_carrefour;
DROP TRIGGER if exists t_t9_geo_mobilite_3v_log ON m_mobilite_3v.geo_mob_carrefour;

DROP TRIGGER if exists t_t1_refresh_view_iti ON m_mobilite_3v.lk_mob_ititroncon;
DROP TRIGGER if exists t_t9_geo_mobilite_3v_log ON m_mobilite_3v.lk_mob_ititroncon;

DROP TRIGGER if exists t_t1_date_sai ON m_mobilite_3v.geo_mob_lieustatio;
DROP TRIGGER if exists t_t2_date_maj ON m_mobilite_3v.geo_mob_lieustatio;
DROP TRIGGER if exists t_t3_coord_l93 ON m_mobilite_3v.geo_mob_lieustatio;
DROP TRIGGER if exists t_t4_coord_longlat ON m_mobilite_3v.geo_mob_lieustatio;
DROP TRIGGER if exists t_t5_commune ON m_mobilite_3v.geo_mob_lieustatio;
DROP TRIGGER if exists t_t6_equ_delete ON m_mobilite_3v.geo_mob_lieustatio;
DROP TRIGGER if exists t_t9_geo_mobilite_3v_log ON m_mobilite_3v.geo_mob_lieustatio;

DROP TRIGGER if exists t_t1_date_sai ON m_mobilite_3v.an_mob_equstatio;
DROP TRIGGER if exists t_t2_date_maj ON m_mobilite_3v.an_mob_equstatio;
DROP TRIGGER if exists t_t3_capacite_sum ON m_mobilite_3v.an_mob_equstatio;
DROP TRIGGER if exists t_t9_geo_mobilite_3v_log ON m_mobilite_3v.an_mob_equstatio;


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


--############################################################ mob_objet_seq_id ##################################################

-- Sequence pour nos nouveaux troncons, itinéraires, carrefours et stationnements (geo_mob_troncon, an_mob_itineraire, geo_mob_carrefour, geo_mob_lieustatio)
CREATE SEQUENCE m_mobilite_3v.mob_objet_seq_id
    START WITH 3000
    INCREMENT BY 1;
	
--############################################################ mob_lk_gid ##################################################

-- Sequence sur la liste de liens itinéraires-tronçons (lk_mib_ititroncon)
CREATE SEQUENCE m_mobilite_3v.mob_lk_gid
    START WITH 1000
    INCREMENT BY 1;

--############################################################ mob_media_seq_gid ##################################################

-- Sequence sur la table des médias (an_mob_media)
CREATE SEQUENCE m_mobilite_3v.mob_media_seq_gid
    START WITH 66
    INCREMENT BY 1;

--############################################################ an_mob_equstatio_seq_id ##################################################

-- Sequence sur la table des équipements de stationnement (an_mob_equstatio)
CREATE SEQUENCE m_mobilite_3v.an_mob_equstatio_seq_id
    START WITH 200
    INCREMENT BY 1;

--############################################################ an_mob_log_seq_id ##################################################

CREATE SEQUENCE m_mobilite_3v.an_mob_log_seq_id
    START WITH 1
    INCREMENT BY 1;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                    DOMAINES DE VALEURS                                                  ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ lt_mob_etat_inscri ##################################################

-- Liste de valeurs d'inscription à un schéma de développement des véloroutes
CREATE TABLE m_mobilite_3v.lt_mob_etat_inscri(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_etat_inscri_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_etat_inscri (code, valeur)
	VALUES ('00', 'Non renseigné'), ('10', 'Ne sais pas (inconnu)'), ('20', 'Non'), ('30', 'Oui');
ALTER TABLE m_mobilite_3v.lt_mob_etat_inscri OWNER to sig_stage;

--############################################################ lt_mob_niv_inscri ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_niv_inscri OWNER to sig_stage;

--############################################################ lt_mob_gest_iti ##################################################

-- Liste de valeurs des gestionnaires d'itinéraire
CREATE TABLE m_mobilite_3v.lt_mob_gest_iti(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_gest_iti_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_gest_iti (code, valeur)
	VALUES ('10', 'ARC'), ('20', 'CCPE'), ('30', 'CCLO');
ALTER TABLE m_mobilite_3v.lt_mob_gest_iti OWNER to sig_stage;

--############################################################ lt_mob_usage ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_usage OWNER to sig_stage;

--############################################################ lt_mob_typres ##################################################

-- Liste de valeurs des types de réseau
CREATE TABLE m_mobilite_3v.lt_mob_typres(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_typres_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_typres (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'REV (Réseau Express Vélo)'), ('20', 'STRUCTURANT'), ('30', 'AUTRE');
ALTER TABLE m_mobilite_3v.lt_mob_typres OWNER to sig_stage;

--############################################################ lt_mob_gest ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_gest OWNER to sig_stage;

--############################################################ lt_mob_booleen ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_booleen OWNER to sig_stage;

--############################################################ lt_mob_ame ##################################################

-- Liste de valeurs des aménagements cyclables
CREATE TABLE m_mobilite_3v.lt_mob_ame(
	code varchar(2),
	valeur varchar(50),
	url varchar(255),
	modele varchar(3),
	affichage integer,
-- Contrainte
	CONSTRAINT lt_mob_ame_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_ame (code, valeur, affichage)
	VALUES  ('10', 'Non aménagé (route)', 16), ('11', 'Non aménagé (jalonnement)', 12), ('20', 'Piste cyclable', 1), ('30', 'Bande cyclable', 3),  ('41', 'Double sens cyclable piste', 4), ('42', 'Double sens cyclable bande', 5), ('43', 'Double sens cyclable non matérialisé', 6), ('50', 'Voie verte', 2), ('60', 'Vélo rue', 8), ('61', 'Couloir Bus+Vélo', 9), ('62', 'Rampe', 14), ('63', 'Goulotte', 15), ('64', 'Aménagement mixte piéton-vélo (hors voie verte) (ASP)', 7), ('70', 'Chaussée à voie centrale banalisée', 11), ('71', 'Accotement revêtu hors CVCB', 10), ('99', 'Autre', 13), ('ZZ', 'Non concerné', 17);
ALTER TABLE m_mobilite_3v.lt_mob_ame OWNER to sig_stage;

--############################################################ lt_mob_avanc ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_avanc OWNER to sig_stage;

--############################################################ lt_mob_regime ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_regime OWNER to sig_stage;

--############################################################ lt_mob_sens ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_sens OWNER to sig_stage;

--############################################################ lt_mob_voca_iti ##################################################

-- Liste de valeurs de vocation de l'itinéraire
CREATE TABLE m_mobilite_3v.lt_mob_voca_iti(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_voca_iti_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_voca_iti (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Loisirs'), ('20', 'Utilitaire');
ALTER TABLE m_mobilite_3v.lt_mob_voca_iti OWNER to sig_stage;

--############################################################ lt_mob_local ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_local OWNER to sig_stage;

--############################################################ lt_mob_revet ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_revet OWNER to sig_stage;

--############################################################ lt_mob_vitesse ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_vitesse OWNER to sig_stage;

--############################################################ lt_mob_carrefour ##################################################

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
ALTER TABLE m_mobilite_3v.lt_mob_carrefour OWNER to sig_stage;

--############################################################ lt_mob_statio_mobi ##################################################

-- Liste de valeurs des types de mobilier des stationnements cyclables
CREATE TABLE m_mobilite_3v.lt_mob_statio_mobi(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_statio_mobi_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_statio_mobi (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Arceau'), ('20', 'Ratelier'), ('30', 'Rack double étage'), ('40', 'Crochet'), ('50', 'Support guidon'), ('60', 'Potelet'), ('70', 'Arceau vélo grande taille'), ('80', 'Aucun équipement'), ('99', 'Autre');
ALTER TABLE m_mobilite_3v.lt_mob_statio_mobi OWNER to sig_stage;

--############################################################ lt_mob_statio_accro ##################################################

-- Liste de valeurs des types d'accroche des stationnements cyclables
CREATE TABLE m_mobilite_3v.lt_mob_statio_accro(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_statio_accro_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_statio_accro (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Cadre'), ('20', 'Roue'), ('30', 'Cadre et roue'), ('40', 'Sans accroche'), ('99', 'Autre');
ALTER TABLE m_mobilite_3v.lt_mob_statio_accro OWNER to sig_stage;

--############################################################ lt_mob_statio_acces ##################################################

-- Liste de valeurs des types d'accès aux stationnements cyclables
CREATE TABLE m_mobilite_3v.lt_mob_statio_acces(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_statio_acces_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_statio_acces (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Libre accès'), ('20', 'Abonnement ou inscription préalable'), ('30', 'Privé');
ALTER TABLE m_mobilite_3v.lt_mob_statio_acces OWNER to sig_stage;

--############################################################ lt_mob_statio_protec ##################################################

-- Liste de valeurs des types de protection des stationnements cyclables
CREATE TABLE m_mobilite_3v.lt_mob_statio_protec(
	code varchar(2),
	valeur varchar(50),
-- Contrainte
	CONSTRAINT lt_mob_statio_protec_pkey PRIMARY KEY (code) -- Clé primaire de la table
);
-- Valeurs
INSERT INTO m_mobilite_3v.lt_mob_statio_protec (code, valeur)
	VALUES  ('00', 'Non renseigné'), ('10', 'Stationnement non fermé'), ('20', 'Consigne collective fermée'), ('30', 'Box individuel fermé'), ('99', 'Autre');
ALTER TABLE m_mobilite_3v.lt_mob_statio_protec OWNER to sig_stage;


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CLASSES OBJETS                                                   ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--################################################################# an_mob_itineraire #######################################################

-- Table alphanumérique recensant l'ensemble des itinéraires déclarés sur le Pays Compiégnois
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
	cout varchar(10), -- Estimation du coût au mètre linéaire de l'aménagement de l'itinéraire
	esti varchar(10), -- Estimation en euros de l'aménagement de l'itinéraire
	url_site varchar(254), -- Lien Http vers une page web
	observ varchar(1000), -- Commentaires
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone,  -- Date de saisie de la donnée
	date_maj timestamp without time zone, -- Date de mise à jour de la donnée
-- Contraintes
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
ALTER TABLE m_mobilite_3v.an_mob_itineraire OWNER to sig_stage;

--################################################################# geo_mob_troncon #######################################################

-- Table géographique représentant les tronçons d'aménagements cyclables sur le Pays Compiégnois
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
-- Contraintes
    CONSTRAINT geo_mob_troncon_pkey PRIMARY KEY (idtroncon), -- Clé primaire de la table
    CONSTRAINT lt_mob_typres_fkey FOREIGN KEY (typ_res)
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
ALTER TABLE m_mobilite_3v.geo_mob_troncon OWNER to sig_stage;

--################################################################# lk_mob_ititroncon #######################################################

-- Table de relations permettant le rattachement des tronçons à un ou plusieurs itinéraires
CREATE TABLE m_mobilite_3v.lk_mob_ititroncon(
	gid bigint NOT NULL DEFAULT nextval('m_mobilite_3v.mob_lk_gid'::regclass), -- Identifiant unique (clé primaire) de la relation
	idtroncon text, -- Identifiant unique du tronçon
	iditi text, -- Identifiant unique de l'itinéraire
-- Contrainte
    CONSTRAINT lk_mob_ititroncon_pkey PRIMARY KEY (gid) -- Clé primaire de la table
);
ALTER TABLE m_mobilite_3v.lk_mob_ititroncon OWNER to sig_stage;

--################################################################# geo_mob_carrefour #######################################################

-- Table géographique représentant la localisation des carrefours aménagés sur des intersections de tronçons cyclables sur le Pays Compiégnois
CREATE TABLE m_mobilite_3v.geo_mob_carrefour(
	idcarrefour text  NOT NULL DEFAULT ('C'::text || nextval('m_mobilite_3v.mob_objet_seq_id'::regclass)), -- Identifiant unique (clé primaire) du tronçon
	libelle varchar(255), -- Libellé
	typ_car varchar(2), -- Type de carrefour
	avanc varchar(2), -- Niveau d'avancement en terme de projet
	insee varchar(5), -- Code insee de la commune d'implantation
	commune varchar(80), -- Nom de la commune d'implantation
	observ varchar(1000), -- Commentaires
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone, -- Date de saisie de la donnée
	date_maj timestamp without time zone, -- Date de mise à jour de la donnée
	geom geometry(Point, 2154), -- Géométrie de l'objet
-- Contraintes
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
ALTER TABLE m_mobilite_3v.geo_mob_carrefour OWNER to sig_stage;

--################################################################# an_mob_media #######################################################

-- Table alphanumérique gérant la liste des documents associés aux objets cyclables
CREATE TABLE m_mobilite_3v.an_mob_media(
	gid bigint NOT NULL DEFAULT nextval('m_mobilite_3v.mob_media_seq_gid'::regclass), -- Identifiant unique (clé primaire) du média
	id text,  -- Identifiant de l'objet référence
	media text, -- Champ Média de GEO
	miniature bytea, -- Champ miniature de GEO
	n_fichier text, -- Nom du fichier
	t_fichier text, -- Type de média dans GEO
	l_prec varchar(1000), -- Précision sur le document
	op_sai varchar(20), -- Opérateur de saisie
	date_sai timestamp without time zone, -- Date de saisie
-- Contrainte
    CONSTRAINT an_mob_media_pkey PRIMARY KEY (gid) -- Clé primaire de la table
);
ALTER TABLE m_mobilite_3v.an_mob_media OWNER to sig_stage;

--################################################################# geo_mob_lieustatio #######################################################

-- Table géographique représentant la localisation des lieux de stationnements cyclables
CREATE TABLE m_mobilite_3v.geo_mob_lieustatio(
	idlieustatio text NOT NULL DEFAULT ('S'::text || nextval('m_mobilite_3v.mob_objet_seq_id'::regclass)), -- Identifiant unique (clé primaire) du lieu de stationnement
	id_osm varchar(30), -- Identifiant unique du lieu de stationnement sur OpenStreetMap
	capacite integer, -- Capacité de stationnement du lieu
	capacite_gt integer, -- Capacité de stationnement du lieu pour des vélos de grandes tailles
	acces varchar(2), -- Moyen d'accès au lieu
	protection varchar(2), -- niveau de protection du lieu
	gratuit boolean default true, -- Stationnement gratuit ou payant
	surveillance boolean default false, -- Présence de surveillance
	couverture boolean default false,  -- Présence d'un toit protégeant des intempéries
	lumiere boolean default false, -- Présence d'éclairage
	gest varchar(2), -- Gestionnaire de l'infrastructure
	propriete varchar(2), -- Propriétaire de l'infrastructure
	a_service varchar(4), -- Année d'installation
	avanc varchar(2), -- Niveau d'avancement en terme de projet
	url varchar(255), -- Lien vers un site d'information du lieu
	adresse varchar(255), -- Adresse précise ou libellé de la voie d'implantation du lieu de stationnement
	cmplt_adr varchar(255), -- Complément de l'adresse d'implantation du lieu de stationnement
	insee varchar(5), -- code insee de la commune du stationnement
	commune varchar(80),  -- nom de la commune du stationnement 
	observ varchar(1000), -- commentaire
	verif boolean DEFAULT false,
	date_sai timestamp without time zone,  -- Date de saisie de la donnée
	date_maj timestamp without time zone,  -- Date de mise à jour de la donnée
	op_sai varchar(20),  -- opérateur de saisie de la donnée 
	src_geom varchar(2), -- Référentiel utilisé pour la digitalisation de la géométrie
	x_l93 double precision, -- Coordonnée X en Lambert 93
	y_l93 double precision, -- Coordonnée Y en Lambert 93
	x_wgs84 decimal(9,7), -- Longitude
	y_wgs84 decimal(9,7), -- Latitude
	geom geometry(Point,2154), -- géométrie de la donnée
-- Contraintes
    CONSTRAINT geo_mob_lieustatio_pkey PRIMARY KEY (idlieustatio), -- Clé primaire de la table
    CONSTRAINT lt_mob_statio_acces_fkey FOREIGN KEY (acces)
        REFERENCES m_mobilite_3v.lt_mob_statio_acces (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_statio_acces
    CONSTRAINT lt_mob_statio_protec_fkey FOREIGN KEY (protection)
        REFERENCES m_mobilite_3v.lt_mob_statio_protec (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_statio_protec
    CONSTRAINT lt_mob_gest_fkey FOREIGN KEY (gest)
        REFERENCES m_mobilite_3v.lt_mob_gest (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_gest
    CONSTRAINT lt_mob_gest_proprio_fkey FOREIGN KEY (propriete)
        REFERENCES m_mobilite_3v.lt_mob_gest (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_gest
    CONSTRAINT lt_mob_avanc_fkey FOREIGN KEY (avanc)
        REFERENCES m_mobilite_3v.lt_mob_avanc (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION, -- Liste de valeurs lt_mob_avanc
    CONSTRAINT lt_src_geom_fkey FOREIGN KEY (src_geom)
        REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION -- Liste de valeurs lt_src_geom
);
ALTER TABLE m_mobilite_3v.geo_mob_lieustatio OWNER to sig_stage;

--################################################################# an_mob_equstatio #######################################################

-- Table alphanumérique stockant les différents équipements cyclables
CREATE TABLE m_mobilite_3v.an_mob_equstatio(
   	idequstatio integer NOT NULL DEFAULT nextval('m_mobilite_3v.an_mob_equstatio_seq_id'::regclass), -- Identifiant unique de l'équipement
	idlieustatio text, -- Identifiant du lieu de stationnement
	typ_mobi varchar(40), -- Type de mobilier du lieu de stationnement
	typ_accro varchar(2), -- Type d'accroche du lieu de stationnement
	capacite_e integer, -- Capacité de stationnement du type d'accroche
	capacite_gt_e integer,  -- Capacité de stationnement en grande taille du type d'accroche
	date_sai timestamp without time zone,  -- Date de saisie de la donnée
	date_maj timestamp without time zone,  -- Date de mise à jour de la donnée
	op_sai varchar(20), -- Opérateur de saisie de la donnée
-- Contraintes
    CONSTRAINT an_mob_equstatio_pkey PRIMARY KEY (idequstatio), -- Clé primaire de la table
    CONSTRAINT lt_mob_statio_accro_fkey FOREIGN KEY (typ_accro)
        REFERENCES m_mobilite_3v.lt_mob_statio_accro (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION -- Liste de valeurs lt_mob_statio_accro
);
ALTER TABLE m_mobilite_3v.an_mob_equstatio OWNER to sig_stage;


--################################################################# an_mob_log #######################################################

-- Table alphanumérique stockant les différents équipements cyclables
CREATE TABLE m_mobilite_3v.an_mob_log(
    idlog integer NOT NULL,
    tablename character varying(80) COLLATE pg_catalog."default" NOT NULL,
    type_ope text COLLATE pg_catalog."default" NOT NULL,
    dataold character varying(10000) COLLATE pg_catalog."default",
    datanew character varying(10000) COLLATE pg_catalog."default",
    date_maj timestamp without time zone,
    CONSTRAINT an_mob_log_pkey PRIMARY KEY (idlog)
)
WITH (OIDS = FALSE)
TABLESPACE pg_default;
ALTER TABLE m_mobilite_3v.an_mob_log OWNER to sig_stage;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         FONCTIONS                                                       ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

--################################################################# ft_commune_via_insee_troncon_cy #######################################################

-- Fonction m_mobilite_3v.ft_commune_via_insee_troncon_cy() recupérant les noms des communes via leur code insee
CREATE FUNCTION m_mobilite_3v.ft_commune_via_insee_troncon_cy()
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
ALTER FUNCTION m_mobilite_3v.ft_commune_via_insee_troncon_cy() OWNER TO sig_stage;

--################################################################# ft_modif_troncon #######################################################

-- Fonction m_mobilite_3v.ft_modif_troncon() modifiant la table des tronçons quand il y a une insertion, un update ou une suppression 
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
	    -- si aménagement à droite
		if new.loc_ame = '10' then
			-- contrôle si ame_d = piste cyclable et si revêtement est différent de lisse
			IF new.ame_d = '20' AND new.revet_d NOT LIKE '1%' THEN
				INSERT INTO x_apps.xapps_an_v_mob_erreur VALUES	(
					nextval('x_apps.xapps_an_v_mob_erreur_gid_seq'::regclass),
					new.idtroncon,
					'Une piste cyclable est forcément avec un revêtement lisse. Merci de modifier votre saisie.',
					now()
				);
			END IF;
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
				new.code_com_d,
				new.commune_d,
				'ZZ',
				'ZZ', 
				'ZZ',
				'ZZ',
				new.largeur_g,
				'ZZ', 
				'ZZ',
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
		-- si aménagement à gauche
		elsif new.loc_ame = '20' then
			-- contrôle si ame_g = piste cyclable et si revêtement est différent de lisse
			IF new.ame_g = '20' AND new.revet_g NOT LIKE '1%' THEN
				INSERT INTO x_apps.xapps_an_v_mob_erreur VALUES	(
					nextval('x_apps.xapps_an_v_mob_erreur_gid_seq'::regclass),
					new.idtroncon,
					'Une piste cyclable est forcément avec un revêtement lisse. Merci de modifier votre saisie.',
					now()
				);
			END IF;
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
				new.code_com_g,
				new.commune_g,
				'ZZ',
				'ZZ', 
				'ZZ',
				'ZZ',
				new.largeur_d,
				'ZZ', 
				'ZZ',
				new.src_geom, 
				new.observ,
				new.verif,	
				new.op_sai,
				(ST_Dump(st_intersection(new.geom,c.geom))).geom AS geom from r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE;
		-- si aménagement à gauche et à droite
		elsif new.loc_ame = '30' then
			-- contrôle si ame_d = piste cyclable et si revêtement est différent de lisse ou si ame_g = piste cyclable et si revêtement est différent de lisse
			IF (new.ame_d = '20' AND new.revet_d NOT LIKE '1%') OR (new.ame_g = '20' AND new.revet_g NOT LIKE '1%') THEN
				INSERT INTO x_apps.xapps_an_v_mob_erreur VALUES (
					nextval('x_apps.xapps_an_v_mob_erreur_gid_seq'::regclass),
					new.idtroncon,
					'Une piste cyclable est forcément avec un revêtement lisse. Merci de modifier votre saisie.',
					now()
				);
			END IF;
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
		end if;
-- MISE A JOUR DU TRONCON
	ELSIF (TG_OP) = 'UPDATE' THEN
	    	-- si aménagement à droite
		if new.loc_ame = '10' then
			-- contrôle si ame_d = piste cyclable et si revêtement est différent de lisse
			IF new.ame_d = '20' AND new.revet_d NOT LIKE '1%' THEN
				INSERT INTO x_apps.xapps_an_v_mob_erreur VALUES (
					nextval('x_apps.xapps_an_v_mob_erreur_gid_seq'::regclass),
					new.idtroncon,
					'Une piste cyclable est forcément avec un revêtement lisse.' || 'Vous avez saisi <b><u>' || (SELECT valeur FROM m_mobilite_3v.lt_mob_revet WHERE code=new.revet_d) || '</u></b> Merci de modifier votre saisie.',
					now()
				);
			END IF;
			-- je vérifie si la géométrie du tronçon a été modifié
			IF st_equals(new.geom,OLD.geom) IS TRUE THEN
			-- je mets à jour les attributs mais pas la géométrie
			UPDATE m_mobilite_3v.geo_mob_troncon 
				SET id_osm 		 =  new.id_osm,	
					id_on3v 	 =  new.id_on3v, 
					typ_res 	 =  new.typ_res, 
					gest 		 =  new.gest, 		
					propriete 	 =  new.propriete,
					d_service 	 =  new.d_service,
					trafic_vit 	 =  new.trafic_vit,
					lumiere 	 =  new.lumiere, 
					code_com_g	 =  new.code_com_d,
					commune_g 	 =  new.commune_d,
					ame_g		 =  'ZZ',		
					avanc_g 	 =  'ZZ', 
					regime_g 	 =  'ZZ', 
					sens_g 		 =  'ZZ', 	
					largeur_g	 =  new.largeur_g,
					local_g 	 =  'ZZ', 
					revet_g 	 =  'ZZ', 
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
					op_sai           =  new.op_sai,
					geom             =  new.geom
				WHERE idtroncon = new.idtroncon;			
		ELSE
			-- je compte les intersections avec les communes
			-- si le résultat est inférieur ou égale à 1, le tronçon est toujours dans la même commune mais avec une géométrie modifiée
			IF (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE) <= 1 THEN
			    -- je mets à jour les données pour 1 tronçon
				UPDATE  m_mobilite_3v.geo_mob_troncon 
					SET id_osm 	 =  new.id_osm,	
					    id_on3v 	 =  new.id_on3v, 
					    typ_res 	 =  new.typ_res, 
					    gest 	 =  new.gest, 		
					    propriete 	 =  new.propriete,
					    d_service 	 =  new.d_service,
					    trafic_vit 	 =  new.trafic_vit,
					    lumiere 	 =  new.lumiere, 
					    code_com_g	 =  new.code_com_d,
					    commune_g 	 =  new.commune_d,
					    ame_g	 =  'ZZ',		
					    avanc_g 	 =  'ZZ', 
					    regime_g 	 =  'ZZ', 
					    sens_g 	 =  'ZZ', 	
					    largeur_g	 =  new.largeur_g,
					    local_g 	 =  'ZZ', 
					    revet_g 	 =  'ZZ', 
					    code_com_d 	 =  new.code_com_d,
					    commune_d 	 =  new.commune_d,
					    ame_d 	 =  new.ame_d, 		
					    avanc_d 	 =  new.avanc_d, 
					    regime_d	 =  new.regime_d,
					    sens_d 	 =  new.sens_d, 	
					    largeur_d	 =  new.largeur_d,
					    local_d 	 =  new.local_d, 
					    revet_d 	 =  new.revet_d,
					    long_m	 =  new.long_m,
					    src_geom 	 =  new.src_geom, 
					    observ 	 =  new.observ,		
					    verif 	 =  new.verif, 		
					    op_sai       =  new.op_sai,
					    geom 	 =  new.geom 
					WHERE idtroncon = new.idtroncon;
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
					new.code_com_d,
					new.commune_d,
					'ZZ',		
					'ZZ', 
					'ZZ', 
					'ZZ', 	
					new.largeur_g,
					'ZZ', 
					'ZZ', 
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
					(ST_Dump(st_intersection(new.geom,c.geom))).geom AS geom from r_osm.geo_vm_osm_commune_oise c
					WHERE st_intersects(new.geom,c.geom) IS TRUE 
					AND st_geometrytype((st_intersection(new.geom,c.geom))) = 'ST_LineString';
				-- j'initialise la variable v_count avec le nombre d'intersection remontée
				v_count := (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE);			
				-- requête mettant à jour la table des relations tronçon-itinéraire
				WITH
				--  je sélectionne les tronçons qui viennent d'être intégrés à la table des tronçons (ex : si 2 tronçons nouveaux, je récupère les 2 derniers dans la table des tronçons)
				req_tr AS
				(SELECT idtroncon FROM m_mobilite_3v.geo_mob_troncon ORDER BY date_sai DESC LIMIT v_count),
				-- je sélectionne les itinéraires affectés à l'ancien tronçon supprimé car découpé
				req_iti AS
				(SELECT iditi FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = OLD.idtroncon)
				-- insertion dans la table des relations troncon-itinéraire
				INSERT INTO m_mobilite_3v.lk_mob_ititroncon (idtroncon,iditi, gid)
				select req_tr.idtroncon, req_iti.iditi, nextval('m_mobilite_3v.mob_lk_gid'::regclass)
				FROM req_tr,req_iti, m_mobilite_3v.mob_lk_gid;
				-- suppression dans la table des relations troncon-itinéraire, des relations du tronçon supprimé
				DELETE FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = old.idtroncon;
			END IF;
		END IF;
		-- si aménagement à gauche
		elsif new.loc_ame = '20' then
				-- contrôle si ame_g = piste cyclable et si revêtement est différent de lisse
				IF new.ame_g = '20' AND new.revet_g NOT LIKE '1%' THEN
				INSERT INTO x_apps.xapps_an_v_mob_erreur VALUES (
					nextval('x_apps.xapps_an_v_mob_erreur_gid_seq'::regclass),
					new.idtroncon,
					'Une piste cyclable est forcément avec un revêtement lisse. Merci de modifier votre saisie.',
					now()
				);
			END IF;
		
			-- je vérifie si le tronçon a été modifié
			IF st_equals(new.geom,OLD.geom) IS TRUE THEN
			-- je mets à jour les attributs mais pas la géométrie
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
					code_com_d 	 =  new.code_com_g,
					commune_d 	 =  new.commune_g,
					ame_d 		 =  'ZZ', 		
					avanc_d 	 =  'ZZ', 
					regime_d	 =  'ZZ',
					sens_d 		 =  'ZZ', 	
					largeur_d	 =  new.largeur_g,
					local_d 	 =  'ZZ', 
					revet_d 	 =  'ZZ',
					long_m		 =  new.long_m,
					src_geom 	 =  new.src_geom, 
					observ 		 =  new.observ,		
					verif 		 =  new.verif, 		
					op_sai       	 =  new.op_sai,
					geom       	 =  new.geom
				WHERE idtroncon = new.idtroncon;			
		ELSE
			-- je compte les intersections avec les communes
			-- si le résultat est inférieur ou égale à 1, le tronçon est toujours dans la même commune mais modifié
			IF (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE) <= 1 THEN
			    -- je mets à jour les données pour 1 tronçon
				UPDATE  m_mobilite_3v.geo_mob_troncon 
					SET id_osm 	 =  new.id_osm,	
					    id_on3v 	 =  new.id_on3v, 
					    typ_res 	 =  new.typ_res, 
					    gest 	 =  new.gest, 		
					    propriete 	 =  new.propriete,
					    d_service 	 =  new.d_service,
					    trafic_vit 	 =  new.trafic_vit,
					    lumiere 	 =  new.lumiere, 
					    code_com_g	 =  new.code_com_g,
					    commune_g 	 =  new.commune_g,
					    ame_g	 =  new.ame_g,		
					    avanc_g 	 =  new.avanc_g, 
					    regime_g 	 =  new.regime_g, 
					    sens_g 	 =  new.sens_g, 	
					    largeur_g	 =  new.largeur_g,
					    local_g 	 =  new.local_g, 
					    revet_g 	 =  new.revet_g, 
					    code_com_d 	 =  new.code_com_g,
					    commune_d 	 =  new.commune_g,
					    ame_d 	 =  'ZZ', 		
					    avanc_d 	 =  'ZZ', 
					    regime_d	 =  'ZZ',
					    sens_d 	 =  'ZZ', 	
					    largeur_d	 =  new.largeur_g,
					    local_d 	 =  'ZZ', 
					    revet_d 	 =  'ZZ',
					    long_m	 =  new.long_m,
					    src_geom 	 =  new.src_geom, 
					    observ 	 =  new.observ,		
					    verif 	 =  new.verif, 		
					    op_sai       =  new.op_sai,
					    geom 	 =  new.geom 
					WHERE idtroncon = new.idtroncon;
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
					new.code_com_g,
					new.commune_g,
					'ZZ', 		
					'ZZ', 
					'ZZ',
					'ZZ', 	
					new.largeur_g,
					'ZZ', 
					'ZZ',
					new.src_geom, 
					new.observ,
					new.verif,	
					new.op_sai,
					(ST_Dump(st_intersection(new.geom,c.geom))).geom AS geom from r_osm.geo_vm_osm_commune_oise c
					WHERE st_intersects(new.geom,c.geom) IS TRUE 
					AND st_geometrytype((st_intersection(new.geom,c.geom))) = 'ST_LineString';
				-- j'initialise la variable v_count avec le nombre d'intersection remontée
				v_count := (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE);			
				-- requête mettant à jour la table des relations tronçon-itinéraire
				WITH
				-- je sélectionne les tronçons qui viennent d'être intégrés à la table des tronçons (ex : si 2 tronçons nouveaux, je récupère les 2 derniers dans la table des tronçons)
				req_tr AS
				(SELECT idtroncon FROM m_mobilite_3v.geo_mob_troncon ORDER BY date_sai DESC LIMIT v_count),
				-- je sélectionne les itinéraires affectés à l'ancien tronçon supprimé car découpé
				req_iti AS
				(SELECT iditi FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = OLD.idtroncon)
				-- insertion dans la table des relations troncon-itinéraire
				INSERT INTO m_mobilite_3v.lk_mob_ititroncon (idtroncon,iditi, gid)
				select req_tr.idtroncon, req_iti.iditi, nextval('m_mobilite_3v.mob_lk_gid'::regclass)
				FROM req_tr,req_iti, m_mobilite_3v.mob_lk_gid;
				-- suppression dans la table des relations troncon-itinéraire, des relations du tronçon supprimé
				DELETE FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = OLD.idtroncon;
			END IF;
		END IF;
		-- si aménagement à droite et à gauche
		elsif new.loc_ame = '30' then
			-- contrôle si ame_d = piste cyclable et si revêtement est différent de lisse ou si ame_g = piste cyclable et si revêtement est différent de lisse
			IF (new.ame_d = '20' AND new.revet_d NOT LIKE '1%') OR (new.ame_g = '20' AND new.revet_g NOT LIKE '1%') THEN
				INSERT INTO x_apps.xapps_an_v_mob_erreur VALUES (
					nextval('x_apps.xapps_an_v_mob_erreur_gid_seq'::regclass),
					new.idtroncon,
					'Une piste cyclable est forcément avec un revêtement lisse. Merci de modifier votre saisie.',
					now()
				);
			END IF;
		
			-- je vérifie si le tronçon a été modifié
			IF st_equals(new.geom,OLD.geom) IS TRUE THEN
			-- je mets à jour les attributs mais pas la géométrie
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
					op_sai       	 =  new.op_sai,
					geom        	 =  new.geom
				WHERE idtroncon = new.idtroncon;			
		ELSE
			-- je compte les intersections avec les communes
			-- si le résultat est inférieur ou égale à 1, le tronçon est toujours dans la même commune mais modifié
			IF (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE) <= 1 THEN
			    -- je mets à jour les données pour 1 tronçon
				UPDATE  m_mobilite_3v.geo_mob_troncon 
					SET id_osm 	 =  new.id_osm,	
					    id_on3v 	 =  new.id_on3v, 
					    typ_res 	 =  new.typ_res, 
					    gest 	 =  new.gest, 		
					    propriete 	 =  new.propriete,
					    d_service 	 =  new.d_service,
					    trafic_vit 	 =  new.trafic_vit,
					    lumiere 	 =  new.lumiere, 
					    code_com_g	 =  new.code_com_g,
					    commune_g 	 =  new.commune_g,
					    ame_g	 =  new.ame_g,		
					    avanc_g 	 =  new.avanc_g, 
					    regime_g 	 =  new.regime_g, 
					    sens_g 	 =  new.sens_g, 	
					    largeur_g	 =  new.largeur_g,
					    local_g 	 =  new.local_g, 
					    revet_g 	 =  new.revet_g, 
					    code_com_d 	 =  new.code_com_d,
					    commune_d 	 =  new.commune_d,
					    ame_d 	 =  new.ame_d, 		
					    avanc_d 	 =  new.avanc_d, 
					    regime_d	 =  new.regime_d,
					    sens_d 	 =  new.sens_d, 	
					    largeur_d	 =  new.largeur_d,
					    local_d 	 =  new.local_d, 
					    revet_d 	 =  new.revet_d,
					    long_m	 =  new.long_m,
					    src_geom 	 =  new.src_geom, 
					    observ 	 =  new.observ,		
					    verif 	 =  new.verif, 		
					    op_sai       =  new.op_sai,
					    geom 	 =  new.geom 
					WHERE idtroncon = new.idtroncon;
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
					(ST_Dump(st_intersection(new.geom,c.geom))).geom AS geom from r_osm.geo_vm_osm_commune_oise c
					WHERE st_intersects(new.geom,c.geom) IS TRUE 
					AND st_geometrytype((st_intersection(new.geom,c.geom))) = 'ST_LineString';
				-- j'initialise la variable v_count avec le nombre d'intersection remontée
				v_count := (SELECT count(*) FROM r_osm.geo_vm_osm_commune_oise c WHERE st_intersects(new.geom,c.geom) IS TRUE);			
				-- requête mettant à jour la table des relations tronçon-itinéraire
				WITH
				--  je sélectionne les tronçons qui viennent d'être intégrés à la table des tronçons (ex : si 2 tronçons nouveaux, je récupère les 2 derniers dans la table des tronçons)
				req_tr AS
				(SELECT idtroncon FROM m_mobilite_3v.geo_mob_troncon ORDER BY date_sai DESC LIMIT v_count),
				-- je sélectionne les itinéraires affectés à l'ancien tronçon supprimé car découpé
				req_iti AS
				(SELECT iditi FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = OLD.idtroncon)
				-- insertion dans la table des relations troncon-itinéraire
				INSERT INTO m_mobilite_3v.lk_mob_ititroncon (idtroncon,iditi, gid)
				select req_tr.idtroncon, req_iti.iditi, nextval('m_mobilite_3v.mob_lk_gid'::regclass)
				FROM req_tr,req_iti, m_mobilite_3v.mob_lk_gid;
				-- suppression dans la table des relations troncon-itinéraire, des relations du tronçon supprimé
				DELETE FROM m_mobilite_3v.lk_mob_ititroncon WHERE idtroncon = OLD.idtroncon;
			END IF;
		END IF;
	end if;
-- SUPPRESSION D'UN TRONCON
	ELSIF (TG_OP) = 'DELETE' THEN
		DELETE FROM m_mobilite_3v.geo_mob_troncon t WHERE t.idtroncon = old.idtroncon;
		DELETE FROM m_mobilite_3v.lk_mob_ititroncon i WHERE i.idtroncon = old.idtroncon;
	END IF;
	RETURN new;
END;
$BODY$;
ALTER FUNCTION m_mobilite_3v.ft_modif_troncon() OWNER TO sig_stage;


--################################################################# ft_m_refresh_view_iti #######################################################

-- Fonction de rafraichissement de la vue materialisée
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
ALTER FUNCTION m_mobilite_3v.ft_m_refresh_view_iti() OWNER TO sig_stage;


--################################################################# ft_m_itineraire_delete_lk #######################################################

-- Fonction pour la suppression des relations tronçons-itinéraire dans la table lk_mob_ititroncon
CREATE FUNCTION m_mobilite_3v.ft_m_itineraire_delete_lk()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
     DELETE FROM m_mobilite_3v.lk_mob_ititroncon WHERE iditi = old.iditi;
     return old;
END;
$BODY$;
ALTER FUNCTION m_mobilite_3v.ft_m_itineraire_delete_lk() OWNER TO sig_stage;


--################################################################# ft_m_mobi_capacite #######################################################

-- Fonction pour sommer les différentes capacités entre-elles
CREATE FUNCTION m_mobilite_3v.ft_m_mobi_capacite()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
IF TG_OP = 'INSERT' THEN
UPDATE m_mobilite_3v.geo_mob_lieustatio
	set capacite = (SELECT SUM(capacite_e) FROM m_mobilite_3v.an_mob_equstatio e WHERE e.idlieustatio = NEW.idlieustatio),
	    capacite_gt = (SELECT SUM(capacite_gt_e) FROM m_mobilite_3v.an_mob_equstatio e WHERE e.idlieustatio = NEW.idlieustatio)
	where geo_mob_lieustatio.idlieustatio = NEW.idlieustatio;
END IF;
IF TG_OP IN ('UPDATE','DELETE') THEN
UPDATE m_mobilite_3v.geo_mob_lieustatio
	set capacite = (SELECT SUM(capacite_e) FROM m_mobilite_3v.an_mob_equstatio e WHERE e.idlieustatio = OLD.idlieustatio),
	    capacite_gt = (SELECT SUM(capacite_gt_e) FROM m_mobilite_3v.an_mob_equstatio e WHERE e.idlieustatio = OLD.idlieustatio)
	where geo_mob_lieustatio.idlieustatio = OLD.idlieustatio;	
END IF;
	return new;
END;
$BODY$;
ALTER FUNCTION m_mobilite_3v.ft_m_mobi_capacite() OWNER TO sig_stage;


--################################################################# ft_m_equstatio_delete #######################################################

-- Fonction pour supprimer les équipements de stationnements liés au lieu de stationnement supprimé
CREATE FUNCTION m_mobilite_3v.ft_m_equstatio_delete()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
     DELETE FROM m_mobilite_3v.an_mob_equstatio WHERE idlieustatio = old.idlieustatio;
     return old;
END;
$BODY$;
ALTER FUNCTION m_mobilite_3v.ft_m_equstatio_delete() OWNER TO sig_stage;

--################################################################# ft_m_geo_mobilite_3v_log #######################################################

-- Fonction permettant de recenser toutes les modifications effectuées
CREATE FUNCTION m_mobilite_3v.ft_m_geo_mobilite_3v_log()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE v_idlog integer;
DECLARE v_dataold character varying(10000);
DECLARE v_datanew character varying(10000);
DECLARE v_name_table character varying(254);
BEGIN
	-- INSERT
	IF (TG_OP = 'INSERT') THEN
		v_idlog := nextval('m_mobilite_3v.an_mob_log_seq_id'::regclass); 
		v_datanew := ROW(NEW.*); ------------------------------------ On concatène tous les attributs dans un seul
		INSERT INTO m_mobilite_3v.an_mob_log (idlog, tablename, type_ope, dataold, datanew, date_maj)
			SELECT
			   v_idlog,
			   TG_TABLE_NAME,
			   'INSERT',
			   NULL,
			   v_datanew,
			   now();
	  	RETURN NEW;
	-- UPDATE
	ELSIF (TG_OP = 'UPDATE') THEN 
	  	v_idlog := nextval('m_mobilite_3v.an_mob_log_seq_id'::regclass);
	  	v_dataold := ROW(OLD.*);------------------------------------ On concatène tous les anciens attributs dans un seul
	  	v_datanew := ROW(NEW.*);------------------------------------ On concatène tous les nouveaux attributs dans un seul	
	  	v_name_table := TG_TABLE_NAME;
	  	INSERT INTO m_mobilite_3v.an_mob_log (idlog, tablename,  type_ope, dataold, datanew, date_maj)
	  		SELECT
	  		   v_idlog,
	  		   v_name_table,
	  		   'UPDATE',
	  		   v_dataold,
	  		   v_datanew,
	  		   now();
	  	RETURN NEW;
	-- DELETE
	ELSIF (TG_OP = 'DELETE') THEN 
	        v_idlog := nextval('m_mobilite_3v.an_mob_log_seq_id'::regclass);
	        v_dataold := ROW(OLD.*);------------------------------------ On concatène tous les anciens attributs dans un seul
	        v_name_table := TG_TABLE_NAME;
	        INSERT INTO m_mobilite_3v.an_mob_log (idlog, tablename,  type_ope, dataold, datanew, date_maj)
	        	SELECT
	        	   v_idlog,
	        	   v_name_table,
	        	   'DELETE',
	        	   v_dataold,
	        	   null,
	        	   now();
	        RETURN NEW;
	END IF;
END;
$BODY$;
ALTER FUNCTION m_mobilite_3v.ft_m_geo_mobilite_3v_log() OWNER TO sig_stage;


--################################################################# ft_m_refresh_view_troncon_affiche #######################################################

-- Fonction permettant de rafraichir la vue matérialisée de l'affichage des tronçons dans GEO
CREATE FUNCTION m_mobilite_3v.ft_m_refresh_view_troncon_affiche()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	REFRESH MATERIALIZED VIEW x_apps.xapps_geo_vmr_mob_troncon_affiche;
	return new;
END;
$BODY$;
ALTER FUNCTION m_mobilite_3v.ft_m_refresh_view_troncon_affiche() OWNER TO sig_stage;





-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         TRIGGERS                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################



-- Trigger sur la table an_mob_itineraire
--################################################################# t_t1_date_sai #######################################################
-- Trigger t_t1_date_sai pour la fonction ecrivant la date de saisie
CREATE TRIGGER t_t1_date_sai
    BEFORE INSERT 
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# t_t2_date_maj #######################################################
-- Trigger t_t2_date_maj pour la fonction ecrivant la date de mise a jour 
CREATE TRIGGER t_t2_date_maj
    BEFORE UPDATE 
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# t_t3_iti_delete #######################################################
-- Trigger t_t3_iti_delete pour la fonction de suppression des lien tronçon-itinéraire
CREATE TRIGGER t_t3_iti_delete
    BEFORE DELETE
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_itineraire_delete_lk();
--################################################################# t_t4_refresh_view_after #######################################################
-- Trigger t_t4_refresh_view_after pour la fonction de rafraichissement des itinéraires à chaque modification
CREATE TRIGGER t_t4_refresh_view_after
    AFTER DELETE
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_refresh_view_iti();
--################################################################# t_t9_geo_mobilite_3v_log #######################################################
-- Trigger t_t9_geo_mobilite_3v_log pour la fonction permettant d'enregistrer toutes les modifications effectuées dans la base
CREATE TRIGGER t_t9_geo_mobilite_3v_log
    AFTER INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.an_mob_itineraire
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_geo_mobilite_3v_log();



-- Trigger sur la table geo_mob_troncon
--################################################################# t_t2_date_sai #######################################################
-- Trigger t_t2_date_sai pour la fonction ecrivant la date de saisie
CREATE TRIGGER t_t2_date_sai
    BEFORE INSERT
    ON m_mobilite_3v.geo_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# t_t3_date_maj #######################################################
-- Trigger t_t3_date_maj pour la fonction ecrivant la date de mise a jour
CREATE TRIGGER t_t3_date_maj
    BEFORE UPDATE
    ON m_mobilite_3v.geo_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# t_t4_long_m #######################################################
-- Trigger t_t4_long_m pour la fonction calculant la longueur du tracé
CREATE TRIGGER t_t4_long_m
    BEFORE INSERT OR UPDATE
    ON m_mobilite_3v.geo_mob_troncon 
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_longm_maj();
--################################################################# t_t5_commune #######################################################
-- Trigger t_t5_commune pour la fonction recuperant le nom de la commune (CHANGER LE NOM DE LA TABLE (Oise))
CREATE TRIGGER t_t5_commune
    BEFORE INSERT OR UPDATE
    ON m_mobilite_3v.geo_mob_troncon 
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_commune_via_insee_troncon_cy();
--################################################################# t_t6_refresh_view_iti #######################################################
-- Trigger t_t6_refresh_view_iti pour la fonction de rafraichissement des itinéraires à chaque modification
CREATE TRIGGER t_t6_refresh_view_iti
    AFTER INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.geo_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_refresh_view_iti();



-- Trigger sur la table geo_mob_carrefour
--################################################################# t_t1_date_sai #######################################################
-- Trigger t_t1_date_sai pour la fonction ecrivant la date de saisie
CREATE TRIGGER t_t1_date_sai
    BEFORE INSERT 
    ON m_mobilite_3v.geo_mob_carrefour
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# t_t2_date_maj #######################################################
-- Trigger t_t2_date_maj pour la fonction ecrivant la date de mise a jour
CREATE TRIGGER t_t2_date_maj
    BEFORE UPDATE 
    ON m_mobilite_3v.geo_mob_carrefour
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# t_t3_commune #######################################################
-- Trigger t_t3_commune pour la fonction ecrivant la commune avec une requête spatiale
CREATE TRIGGER t_t3_commune
    BEFORE INSERT OR UPDATE 
    ON m_mobilite_3v.geo_mob_carrefour
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_commune_pl();
--################################################################# t_t9_geo_mobilite_3v_log #######################################################
-- Trigger t_t9_geo_mobilite_3v_log pour la fonction permettant d'enregistrer toutes les modifications effectuées dans la base
CREATE TRIGGER t_t9_geo_mobilite_3v_log
    AFTER INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.geo_mob_carrefour
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_geo_mobilite_3v_log();



-- Trigger sur la table lk_mob_ititroncon
--################################################################# t_t1_refresh_view_iti #######################################################
-- Trigger t_t1_refresh_view_iti pour le rafraichissement de la vue métérialisée
CREATE TRIGGER t_t1_refresh_view_iti
    AFTER INSERT OR UPDATE OR DELETE 
    ON m_mobilite_3v.lk_mob_ititroncon
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_refresh_view_iti();
--################################################################# t_t9_geo_mobilite_3v_log #######################################################
-- Trigger t_t9_geo_mobilite_3v_log pour la fonction permettant d'enregistrer toutes les modifications effectuées dans la base
CREATE TRIGGER t_t9_geo_mobilite_3v_log
    AFTER INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.lk_mob_ititroncon
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_geo_mobilite_3v_log();
  
   
   
-- Trigger sur la table geo_mob_lieustatio
--################################################################# t_t1_date_sai #######################################################
-- Trigger pour l'insertion de la date
-- Trigger: t_t1_date_sai
CREATE TRIGGER t_t1_date_sai
    BEFORE INSERT 
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# t_t2_date_maj #######################################################
-- Trigger t_t2_date_maj pour la mise a jour de la date
CREATE TRIGGER t_t2_date_maj
    BEFORE UPDATE 
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# t_t3_coord_l93 #######################################################
-- Trigger t_t3_coord_l93 pour l'insertion ou la mise a jour des coordonnées L93 
CREATE TRIGGER t_t3_coord_l93
    BEFORE INSERT OR UPDATE
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_xy_l93();
--################################################################# t_t4_coord_longlat #######################################################
-- Trigger t_t4_coord_longlat pour l'insertion ou la mise a jour des coordonnées long lat
CREATE TRIGGER t_t4_coord_longlat
    BEFORE INSERT OR UPDATE 
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_xy_wgs84();
--################################################################# t_t5_commune #######################################################
-- Trigger t_t5_commune pour la fonction ecrivant la commune avec une requête spatiale
CREATE TRIGGER t_t5_commune
    BEFORE INSERT OR UPDATE 
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_commune_pl(); 
--################################################################# t_t6_equ_delete #######################################################
-- Trigger t_t6_equ_delete pour la fonction de suppression de lien avec les équipements de stationnement
CREATE TRIGGER t_t6_equ_delete
    AFTER DELETE
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_equstatio_delete();
--################################################################# t_t9_geo_mobilite_3v_log #######################################################
-- Trigger t_t9_geo_mobilite_3v_log pour la fonction permettant d'enregistrer toutes les modifications effectuées dans la base
CREATE TRIGGER t_t9_geo_mobilite_3v_log
    AFTER INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.geo_mob_lieustatio
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_geo_mobilite_3v_log();
    
    
    
 -- Trigger sur la table an_mob_equstatio
--################################################################# t_t1_date_sai #######################################################
-- Trigger t_t1_date_sai pour l'insertion de la date
CREATE TRIGGER t_t1_date_sai
    BEFORE INSERT 
    ON m_mobilite_3v.an_mob_equstatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_sai();
--################################################################# t_t2_date_maj #######################################################
-- Trigger t_t2_date_maj pour la mise a jour de la date
CREATE TRIGGER t_t2_date_maj
    BEFORE UPDATE 
    ON m_mobilite_3v.an_mob_equstatio
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();
--################################################################# t_t3_capacite_sum #######################################################
-- Trigger: t_t3_capacite_sum pour l'insertion,la mise a jour ou la suppression des capacités de stationnement cyclable
CREATE TRIGGER t_t3_capacite_sum
    AFTER INSERT OR UPDATE OR DELETE
    ON m_mobilite_3v.an_mob_equstatio
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_mobi_capacite();
--################################################################# t_t9_geo_mobilite_3v_log #######################################################
-- Trigger t_t9_geo_mobilite_3v_log pour la fonction permettant d'enregistrer toutes les modifications effectuées dans la base
CREATE TRIGGER t_t9_geo_mobilite_3v_log
    AFTER INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.an_mob_equstatio
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_geo_mobilite_3v_log();
    
    
    
    
-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


COMMENT ON SCHEMA m_mobilite_3v IS 'Données métiers sur le thème des aménagements cyclables';

COMMENT ON TABLE m_mobilite_3v.lt_mob_etat_inscri IS 'Liste de valeurs d''inscription à un schéma de développement des véloroutes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_etat_inscri.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_etat_inscri.valeur IS 'Libellé de la valeur d''inscription';

COMMENT ON TABLE m_mobilite_3v.lt_mob_niv_inscri IS 'Liste de valeurs du niveau adminsitratif du schéma de développement des véloroutes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_niv_inscri.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_niv_inscri.valeur IS 'Libellé de la valeur du niveau';

COMMENT ON TABLE m_mobilite_3v.lt_mob_gest_iti IS 'Liste de valeurs des gestionnaires d''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest_iti.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest_iti.valeur IS 'Libellé de la valeur des gestionnaires de l''itinéraire';

COMMENT ON TABLE m_mobilite_3v.lt_mob_usage IS 'Liste de valeurs des usages';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_usage.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_usage.valeur IS 'Libellé de la valeur des usages';

COMMENT ON TABLE m_mobilite_3v.lt_mob_typres IS 'Liste de valeurs des types de réseau';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_typres.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_typres.valeur IS 'Libellé de la valeur des types de réseau locaux';

COMMENT ON TABLE m_mobilite_3v.lt_mob_gest IS 'Liste de valeurs des gestionnaires';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_gest.valeur IS 'Libellé de la valeur des gestionnaires';

COMMENT ON TABLE m_mobilite_3v.lt_mob_booleen IS 'Liste de valeurs des faux booléens';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_booleen.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_booleen.valeur IS 'Libellé de la valeur des faux booléens';

COMMENT ON TABLE m_mobilite_3v.lt_mob_ame IS 'Liste de valeurs des aménagements cyclables';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.valeur IS 'Libellé de la valeur des aménagements cyclables';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.url IS 'Lien URL vers la documentation nationale';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.modele IS 'Code du modèle d''aménagement';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_ame.affichage IS 'Permet le tri de la liste dans géo';
	
COMMENT ON TABLE m_mobilite_3v.lt_mob_avanc IS 'Liste de valeurs des avancées de projets';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_avanc.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_avanc.valeur IS 'Libellé de la valeur des avancements des aménagements cyclables';

COMMENT ON TABLE m_mobilite_3v.lt_mob_regime IS 'Liste de valeurs des régimes présent sur la voie adjacente';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_regime.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_regime.valeur IS 'Libellé de la valeur des régimes';

COMMENT ON TABLE m_mobilite_3v.lt_mob_sens IS 'Liste de valeurs du sens de circulation des tronçons cyclables';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_sens.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_sens.valeur IS 'Libellé de la valeur des sens de circulation';

COMMENT ON TABLE m_mobilite_3v.lt_mob_voca_iti IS 'Liste de valeurs de vocation de l itinéraire';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_voca_iti.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_voca_iti.valeur IS 'Libellé de la valeur des vocations des itinéraires';

COMMENT ON TABLE m_mobilite_3v.lt_mob_local IS 'Liste de valeurs des localisations des aménagements';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_local.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_local.valeur IS 'Libellé de la valeur des localisations des aménagements';

COMMENT ON TABLE m_mobilite_3v.lt_mob_revet IS 'Liste de valeurs des types de revêtements et leur coût (hors foncier)';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_revet.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_revet.valeur IS 'Libellé de la valeur des revêtements';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_revet.prix_m IS 'Prix moyen au mètre linéaire';

COMMENT ON TABLE m_mobilite_3v.lt_mob_vitesse IS 'Liste de valeurs des vitesses présentes sur une voie adjacentes';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_vitesse.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_vitesse.valeur IS 'Libellé de la valeur des vitesses de circulation';

COMMENT ON TABLE m_mobilite_3v.lt_mob_carrefour IS 'Liste de valeurs des types de carrefour et leur modèle';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_carrefour.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_carrefour.valeur IS 'Libellé de la valeur des carrefours';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_carrefour.modele IS 'Code du modèle de carrefour';

COMMENT ON TABLE m_mobilite_3v.lt_mob_statio_mobi IS 'Liste de valeurs des différents mobilier de stationnement';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_mobi.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_mobi.valeur IS 'Libellé de la valeur des mobiliers de stationnement';

COMMENT ON TABLE m_mobilite_3v.lt_mob_statio_accro IS 'Liste de valeurs des différents type d''accroche de stationnement';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_accro.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_accro.valeur IS 'Libellé de la valeur des accroches de stationnement';

COMMENT ON TABLE m_mobilite_3v.lt_mob_statio_acces IS 'Liste de valeurs des différents mode d accès aux lieux de stationnement';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_acces.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_acces.valeur IS 'Libellé de la valeur des modes d''accès aux lieux de stationnement';

COMMENT ON TABLE m_mobilite_3v.lt_mob_statio_protec IS 'Liste de valeurs des différents type de protection des stationnements';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_protec.code IS 'Code de la valeur';
COMMENT ON COLUMN m_mobilite_3v.lt_mob_statio_protec.valeur IS 'Libellé de la valeur des protections des stationnements';

COMMENT ON TABLE m_mobilite_3v.an_mob_itineraire IS 'Table alphanumérique recensant l ensemble des itinéraires déclarés sur le Pays Compiégnois (en projet ou ouvert)';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.iditi IS 'Identifiant unique (clé primaire) de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.num_iti IS 'Numéro de l''itinéraire des schémas supra-intercommunaux';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.num_loc IS 'Numéro de l''itinéraire local';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.nom_off IS 'Nom officiel ou à défaut celui mentionné dans un document de communication grand public';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.nom_usage IS 'Autre nom ou appellation de l''itinéraire en usage';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.depart IS 'Nom de la localité située au départ';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.arrivee IS 'Nom de la localité située à l''arrivée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.est_inscri IS 'Précise si l''itinéraire est inscrit à un schéma de développement des véloroutes';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.niv_inscri IS 'Niveau administratif du schéma dans lequel l''itinéraire est inscrit et numéroté';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.nom_schema IS 'Libellé du schéma d''inscription';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.an_inscri IS 'Année d''approbation du schéma dans lequel l''itinéraire est inscrit et numéroté';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.an_ouvert IS 'Indique l''année d ouverture de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.gest_iti IS 'Gestion sur l''itinéraire en terme d''action sur les données';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.usag IS 'Usage principal de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.observ IS 'Commentaires';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.date_sai IS 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.usage_comm IS 'diffusion des données au grand public';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.via IS 'Localité ou lieu intermédiaire entre le départ et l''arrivée de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.voca_iti IS 'Vocation de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.typ_iti IS 'Typologie des aménagements cyclables prévus dans le cadre d un projet d''itinéraires en projet';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.mao IS 'Maître d ouvrage de l''itinéraire en projet ou en cours de travaux';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.equip IS 'Liste d''équipements potentiellement proche ou desservis par l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.descrip IS 'Description de l''itinéraire (parcours, …)';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.cout IS 'Estimation du coût au mètre linéaire de l''aménagement de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.esti IS 'Estimation en euros de l aménagement de l''itinéraire';
COMMENT ON COLUMN m_mobilite_3v.an_mob_itineraire.url_site IS 'Lien Http vers une page web';

COMMENT ON TABLE m_mobilite_3v.geo_mob_troncon IS 'Table géographique représentant les tronçons d''aménagement cyclables sur le Pays Compiégnois';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.idtroncon IS 'Identifiant unique (clé primaire) du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.id_osm IS 'Identifiant unique du tronçon sur OpenStreetMap';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.id_on3v IS 'Identifiant unique du tronçon sur le standard 3V';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.typ_res IS 'Type de réseau local';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.gest IS 'Gestionnaire de l''infrastructure';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.propriete IS 'Propriétaire de l''infrastructure';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.d_service IS 'Année de mise en service';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.trafic_vit IS 'Vitesse maximale du trafic adjacent';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.lumiere IS 'Présence d''éclairage';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.code_com_g IS 'Code insee de la commune à gauche de l''aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.commune_g IS 'Libellé de la commune à gauche de l''aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.ame_g IS 'Type d''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.avanc_g IS 'Niveau d''avancement en terme de projet à gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.regime_g IS 'Régime présent sur la voie de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.sens_g IS 'Sens de circulation de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.largeur_g IS 'Largeur en mètre de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.local_g IS 'Localisation de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.revet_g IS 'Type de revêtement du tronçon de gauche';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.code_com_d IS 'Code insee de la commune à droite de l''aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.commune_d IS 'Libellé de la commune à droite de l''aménagement';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.ame_d IS 'Type d''aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.avanc_d IS 'Niveau d''avancement en terme de projet à droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.regime_d IS 'Régime présent sur la voie de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.sens_d IS 'Sens de circulation de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.largeur_d IS 'Largeur en mètre de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.local_d IS 'Localisation de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.revet_d IS 'Type de revêtement du tronçon de droite';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.long_m IS 'Longueur en mètre du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.src_geom IS 'Référentiel utilisé pour la digitalisation de la géométrie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.observ IS 'Commentaires';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.date_sai IS 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.verif IS 'attribut spécifiant que l''utilisaetur a vérifier l''exactitude du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_troncon.geom IS 'Géométrie de l''objet';

COMMENT ON TABLE m_mobilite_3v.lk_mob_ititroncon IS 'Table de relation permettant le rattachement des tronçons à un ou plusieurs itinéraires';
COMMENT ON COLUMN m_mobilite_3v.lk_mob_ititroncon.gid IS 'Identifiant unique (clé primaire) de la relation';
COMMENT ON COLUMN m_mobilite_3v.lk_mob_ititroncon.idtroncon IS 'Identifiant unique du tronçon';
COMMENT ON COLUMN m_mobilite_3v.lk_mob_ititroncon.iditi IS 'Identifiant unique de l''itinéraire';

COMMENT ON TABLE m_mobilite_3v.geo_mob_carrefour IS 'Table géographique représentant la localisation des carrefours aménagés sur des intersections de tronçons cyclables sur le Pays Compiégnois';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.idcarrefour IS 'Identifiant unique (clé primaire) du tronçon';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.libelle IS 'Libellé du carrefour';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.typ_car IS 'Type de carrefour';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.avanc IS 'Niveau d''avancement en terme de projet';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.insee IS 'Code insee de la commune d''implantation';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.commune IS 'Nom de la commune d''implantation';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.observ IS 'Commentaires';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.date_sai IS 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_carrefour.geom IS 'Géométrie de l''objet';

COMMENT ON TABLE m_mobilite_3v.an_mob_media IS 'Table alphanumérique gérant la liste des documents associés aux objets cyclables';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.gid IS 'Identifiant unique (clé primaire) du média';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.id IS 'Identifiant de l''objet référence';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.l_prec IS 'Précision sur le document';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_3v.an_mob_media.date_sai IS 'Date de saisie';

COMMENT ON TABLE m_mobilite_3v.geo_mob_lieustatio IS 'Table géographique représentant la localisation des lieux de stationnements cyclables sur le Pays Compiégnois';			
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.idlieustatio IS 'Identifiant unique (clé primaire) du lieu de stationnement';								                            
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.id_osm IS 'Identifiant unique du tronçon sur OpenStreetMap';                                                                      
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.capacite IS 'Capacité de stationnement du lieu';                                                                                    
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.capacite_gt IS 'Capacité de stationnement du lieu pour des vélos de grandes tailles';      
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.acces IS 'Moyen d''accès au lieu';                       							
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.protection IS 'niveau de protection du lieu';                                             
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.gratuit IS 'Stationnement gratuit ou payant';                                          
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.surveillance IS 'Présence de surveillance';                                                 
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.couverture IS 'Présence d''un toit protégeant des intempéries';                            
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.lumiere IS 'Présence d''éclairage';                                                                      
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.gest IS 'gestionnaire de l''infrastucture';                                                           
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.propriete IS 'Propriétaire de l''infrastucture';                         	                                
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.a_service IS 'Année d''installation';                                                                                                       
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.avanc IS 'Niveau d''avancement en terme de projet';	                                                                                                
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.url IS 'Lien vers un site d''information du lieu';       	                                                                                                
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.adresse IS 'Adresse précise ou libellé de la voie d''implantation du lieu de stationnement';     
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.cmplt_adr IS 'Complément de l''adresse d''implantation du lieu de stationnement';     
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.insee IS 'Code insee de la commune du stationnement';                                                 
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.commune IS 'Nom de la commune du stationnement';                      
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.observ IS 'Commentaire';                                                                               
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.date_sai IS 'Date de saisie de la donnée';                                                               
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.op_sai IS 'Opérateur de saisie de la donnée';	                
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.src_geom IS 'Référentiel utilisé pour la digitalisation de la géométrie';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.x_l93 IS 'Coordonnée X en Lambert 93';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.y_l93 IS 'Coordonnée Y en Lambert 93';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.x_wgs84 IS 'Longitude';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.y_wgs84 IS 'Latitude';
COMMENT ON COLUMN m_mobilite_3v.geo_mob_lieustatio.geom IS 'Géométrie de la donnée';

COMMENT ON TABLE m_mobilite_3v.an_mob_equstatio IS 'Table alphanumérique stockant les différents équipements cyclables sur le Pays Compiégnois';			
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.idequstatio IS 'Identifiant unique de l''équipement';
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.idlieustatio IS 'Identifiant du lieu de stationnement';	
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.typ_mobi IS 'Type de mobilier du lieu de stationnement';                                                 
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.typ_accro IS 'Type d''accroche du lieu de stationnement';                                                  
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.capacite_e IS 'Capacité de stationnement du type d''accroche';
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.capacite_gt_e IS 'Capacité de stationnement en grande taille du type d''accroche';
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.date_sai IS 'Date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_3v.an_mob_equstatio.op_sai IS 'opérateur de saisie de la donnée';

COMMENT ON TABLE m_mobilite_3v.an_mob_log IS 'Table des opérations sur les données aménagements cyclables';
COMMENT ON COLUMN m_mobilite_3v.an_mob_log.idlog IS 'Identifiant unique de l''opération';
COMMENT ON COLUMN m_mobilite_3v.an_mob_log.tablename IS 'Nom de la table concernée par l''opération sur l''entité';
COMMENT ON COLUMN m_mobilite_3v.an_mob_log.type_ope IS 'Type l''opération sur l''entité';
COMMENT ON COLUMN m_mobilite_3v.an_mob_log.dataold IS 'Valeur ancienne avant l''opération sur l''entité';
COMMENT ON COLUMN m_mobilite_3v.an_mob_log.datanew IS 'Valeur nouvelle après l''opération sur l''entité';
COMMENT ON COLUMN m_mobilite_3v.an_mob_log.date_maj IS 'Horodatage de l''opération sur la donnée aménagements cyclables';

COMMENT ON FUNCTION m_mobilite_3v.ft_modif_troncon() IS 'Fonction pour la modification de la table geo_mob_troncon';
COMMENT ON FUNCTION m_mobilite_3v.ft_commune_via_insee_troncon_cy() IS 'Fonction recupérant les noms des communes via leur code insee';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_refresh_view_iti() IS 'Fonction pour le rafraichissement de la vue des itinéraires après suppression d''un itinéraire';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_itineraire_delete_lk() IS 'Fonction pour la suppression des relations tronçons-itinéraire dans la table lk_mob_ititroncon';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_mobi_capacite() IS 'Fonction permettant la somme des différentes capacités en fonction du type d accroche';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_equstatio_delete() IS 'Fonction pour la suppression des relations équipements et lieux de stationnements dans la table an_mob_equstatio';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_geo_mobilite_3v_log() IS 'Fonction permettant de recenser toutes les modifications effectuées';
COMMENT ON FUNCTION m_mobilite_3v.ft_m_refresh_view_troncon_affiche() IS 'Fonction trigger pour le rafraichissement de la vue des tronçons';



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         APPLICATIF                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- SUR LA TABLE geo_v_mob_troncon
--########################################################### CHAMPS CALCULÉS ######################################################
-- Affiche_message :
		-- <center><font size=2 color="#FF0000"><b><i>La gauche ou la droite se détermine par rapport au sens de saisie du tronçon.</i></b></font></center>

-- Amenagement_recherche : 
		-- {ame_g};{ame_d}

-- Avancement recherche :
		-- {avanc_g};{avanc_d}

-- Commune_recherche : 
		-- {code_com_g};{code_com_d}
		
-- Controle_d_service :
		CASE WHEN {d_service} IS NULL OR {d_service} = '' THEN
			'non'
		ELSE
			CASE WHEN {d_service}::integer BETWEEN 0 AND 1980 THEN 'oui'
			     WHEN {d_service}::integer <0 THEN 'oui'
			     WHEN {d_service}::integer > to_char(now(),'YYYY')::integer+10 THEN 'oui'
			     ELSE 'non'
		        END
		END;
		
-- Recherche_affiche :
		-- <tr><td><b><u>Commune(s) :</u></b> {recherche_commune}</td></tr><br>
		-- <tr><td><b><u>Aménagement(s) :</u></b> {recherche_ame}</td></tr><br>

-- Recherche_ame : 
		(WITH
		 -- LES DEUX ET <> ZZ
		 req_tot AS(
			(WITH
			 	-- A DROITE SI GAUCHE <> ZZ
	 			req_d AS (select {idtroncon}, lt.valeur as valeur1, a.valeur as valeur11 from m_mobilite_3v.lt_mob_ame lt, m_mobilite_3v.lt_mob_avanc a where lt.code = {ame_d} AND a.code = {avanc_d} AND {ame_g} <> 'ZZ' AND {ame_d} <> 'ZZ' AND {ame_g} <> {ame_d}),
				
				-- A GAUCHE SI DROITE <> ZZ
				req_g AS (select {idtroncon}, lt.valeur as valeur2, a.valeur as valeur21 from m_mobilite_3v.lt_mob_ame lt, m_mobilite_3v.lt_mob_avanc a where lt.code = {ame_g} AND a.code = {avanc_g} AND {ame_g} <> 'ZZ' AND {ame_d} <> 'ZZ' AND {ame_g} <> {ame_d})
				SELECT {idtroncon}, valeur1 || ' (' || valeur11 || ') et ' || valeur2 || ' (' || valeur21 || ')' as ame_dg FROM req_d, req_g WHERE req_d.idtroncon = req_g.idtroncon)
			UNION ALL
			(WITH
				 -- A DROITE SI GAUCHE = ZZ
				req_d AS (select {idtroncon}, lt.valeur as ame_dg, a.valeur as valeura from m_mobilite_3v.lt_mob_ame lt, m_mobilite_3v.lt_mob_avanc a where lt.code = {ame_d} AND a.code = {avanc_d} AND {ame_g} = 'ZZ')
				SELECT {idtroncon}, ame_dg || ' (' || valeura || ')' FROM req_d)
			UNION ALL
			(WITH
			 	-- A GAUCHE SI DROITE = ZZ
			 	req_g AS (select {idtroncon}, lt.valeur as ame_dg, a.valeur as valeurb from m_mobilite_3v.lt_mob_ame lt, m_mobilite_3v.lt_mob_avanc a where lt.code = {ame_g} AND a.code = {avanc_g} AND {ame_d} = 'ZZ')
				SELECT {idtroncon}, ame_dg || ' (' || valeurb || ')' FROM req_g)
			UNION ALL
			(WITH
			 	-- UNE SORTIE SI DROITE = GAUCHE ET SI <> ZZ
				req_d AS (select {idtroncon}, lt.valeur as ame_dg, CASE WHEN ((SELECT a.code FROM m_mobilite_3v.lt_mob_avanc a WHERE a.code = {avanc_g}) = (SELECT a.code FROM m_mobilite_3v.lt_mob_avanc a WHERE a.code = {avanc_d})) THEN (SELECT a.valeur FROM m_mobilite_3v.lt_mob_avanc a WHERE a.code = {avanc_d}) ELSE (SELECT a.valeur FROM m_mobilite_3v.lt_mob_avanc a WHERE a.code = {avanc_g}) || ', ' || (SELECT a.valeur FROM m_mobilite_3v.lt_mob_avanc a WHERE a.code = {avanc_d}) END as valeura from m_mobilite_3v.lt_mob_ame lt where lt.code = {ame_d} AND {ame_g} <> 'ZZ' AND {ame_d} <> 'ZZ' AND {ame_g} = {ame_d})
				SELECT {idtroncon}, ame_dg || ' (' || valeura || ')' FROM req_d )
			 )
		 SELECT ame_dg FROM req_tot)

-- recherche_commune :
		(WITH
		 req_tot AS(
			(WITH
				comm_d AS (select {idtroncon}, {commune_d} as comm_dg where {commune_d} = {commune_g})
				SELECT {idtroncon}, comm_dg FROM comm_d)		
			UNION ALL					
			(WITH
				comm_gd AS (select {idtroncon}, {commune_d} || ', ' || {commune_g} as comm_dg where {commune_d} <> {commune_g})
				SELECT {idtroncon}, comm_dg FROM comm_gd)	
		)
		SELECT comm_dg FROM req_tot)

-- Revetement_recherche :
		-- {revet_g};{revet_d}
		
-- verif_topo :
		(SELECT string_agg(ST_Crosses(a.geom,b.geom)::text,';') FROM m_mobilite_3v.geo_mob_troncon a, m_mobilite_3v.geo_mob_troncon b WHERE st_intersects(a.geom,b.geom) IS TRUE AND a.idtroncon = {idtroncon} AND b.idtroncon <> {idtroncon})



-- SUR LA TABLE geo_mob_lieustatio
--########################################################### CHAMPS CALCULÉS ######################################################
-- Controle_a_service :
		CASE WHEN {a_service} IS NULL OR {a_service} = '' THEN
			'non'
		ELSE
			CASE WHEN {a_service}::integer BETWEEN 0 AND 1980 THEN 'oui'
		             WHEN {a_service}::integer <0 THEN 'oui'
		             WHEN {a_service}::integer > to_char(now(),'YYYY')::integer+10 THEN 'oui'
			     ELSE 'non'
		        END
		END;
		
-- Controle_protection :
		CASE WHEN {acces} = '10' THEN
			CASE WHEN {protection} = '00' OR {protection} = '99' OR {protection} = '10' THEN 'non'
		    	ELSE 'oui'
		   	END
		ELSE 'non'
		END;

-- recherche_affiche : 
		-- <tr ><td><b><u>Commune :</u></b> {commune}<td></tr><br>
		-- <tr ><td><b><u>Adresse :</u></b> {adresse}<td></tr><br>
		-- <tr ><td><b><u>Capacité totale :</u></b> {capacite}<td></tr>



-- SUR LA TABLE geo_mob_carrefour
--########################################################### CHAMPS CALCULÉS ######################################################
-- infobulle_affiche : 
		-- <tr><td><b><u>Commune :</u></b> {commune}</td></tr><br>
		-- <tr><td><b><u>Type :</u></b> {recherche_typcar} ({recherche avanc})</td></tr><br>
		
-- recherche_avanc :
		(select lt.valeur from m_mobilite_3v.lt_mob_avanc lt where lt.code = {avanc})
		
-- recherche_affiche : 
		-- <tr><td><b><u>Commune :</u></b> {commune}</td></tr><br>
		-- <tr><td><b><u>Type :</u></b> {recherche_typcar} ({recherche avanc})</td></tr><br>
		
-- recherche_typcar :
		(select lt.valeur from m_mobilite_3v.lt_mob_carrefour lt where lt.code = {typ_car})



-- SUR LA TABLE geo_vmr_mob_iti
--########################################################### CHAMPS CALCULÉS ######################################################
-- affiche_num_nom_iti : 
		CASE WHEN {num_loc} IS NULL THEN ({nom_off} )
		 ELSE ( {num_loc} || ' - ' || {nom_off} )
		 END

-- infobulle_affiche :
		-- <tr><td bgcolor="#79C24D"><b>{affiche_num_nom_iti}</b></td></tr>
		-- <tr ><td><b><u>Départ :</u></b> {depart}</td></tr>
		-- <tr><td><b><u>Arrivée :</u></b> {arrivee}</td></tr>
		-- <tr><td><b><u>Via :</u></b> {via}</td></tr>



-- SUR LA TABLE an_mob_itineraire
--########################################################### CHAMPS CALCULÉS ######################################################
-- affiche_analyse :
		-- Tracé de l'itinéraire

-- affiche_iti :
		CASE WHEN {num_loc} is null then ({nom_off} )
		ELSE ( {num_loc} || ' - ' || {nom_off} )
		END;

-- controle_an_inscri :
		CASE WHEN {an_inscri} IS NULL OR {an_inscri} = '' THEN 'non'
		ELSE
			CASE WHEN {an_inscri}::integer BETWEEN 0 AND 1980 THEN 'oui'
		        WHEN {an_inscri}::integer <0 THEN 'oui'
		        WHEN {an_inscri}::integer > to_char(now(),'YYYY')::integer+10 THEN 'oui'
			ELSE 'non'
		        END
		END;
		
-- controle_an_ouvert :
		CASE WHEN {an_ouvert} IS NULL OR {an_ouvert} = '' THEN 'non'
		ELSE
			CASE WHEN {an_ouvert}::integer BETWEEN 0 AND 1980 THEN 'oui'
		        WHEN {an_ouvert}::integer <0 THEN 'oui'
		        WHEN {an_ouvert}::integer > to_char(now(),'YYYY')::integer+10 THEN 'oui'
			ELSE 'non'
		        END
		END;

-- info_bulle_affiche :
		-- <tr><td bgcolor="#79C24D"><b>{affiche_iti}</b></td></tr><br>
		-- <tr ><td><b><u>Départ :</u></b> {depart}</td></tr><br>
		-- <tr><td><b><u>Arrivée :</u></b> {arrivee}</td></tr><br>
		-- <tr><td><b><u>Via :</u></b> {via}</td></tr><br>



-- SUR LA TABLE xapps_geo_v_mob_troncon_affiche
--########################################################### CHAMPS CALCULÉS ######################################################
-- infobulle_affiche :
		-- {infobulle_ame} ({infobulle_avanc})

-- infobulle_ame :
		(select lt.valeur from m_mobilite_3v.lt_mob_ame lt where lt.code = {ame})
		
-- infobulle_avanc :
		(select lt.valeur from m_mobilite_3v.lt_mob_avanc lt where lt.code = {avanc})
















