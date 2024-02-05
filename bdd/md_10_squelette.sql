/**Mobilite douce V0.1*/
/*Creation du fichier complet*/
/* init_db_mobdouce.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet */

/*
#################################################################### SUIVI CODE SQL ####################################################################

2024-02-02 : GB / initialisation de la structure du fichier

*/
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SUPPRESSION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ## VUE

-- ## CONTRAINTES
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_cap_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_cap_cargo_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_gratuit_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_protect_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_couvert_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_surv_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_lum_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statut_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_etat_mob_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_type_accro_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_mobil_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_acces_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_protect_fkey;


-- ## VUE




-- ## CLASSE
drop table if exists m_mobilite_douce.geo_mob_statio_cycl;

-- ## TABLE DE RELATION


-- ## DOMAINE DE VALEUR
drop table if exists m_mobilite_douce.lt_mob_statut;
drop table if exists m_mobilite_douce.lt_mob_etat_mob;
drop table if exists m_mobilite_douce.lt_mob_typ_accro;
drop table if exists m_mobilite_douce.lt_mob_mobil;
drop table if exists m_mobilite_douce.lt_mob_acces;
drop table if exists m_mobilite_douce.lt_mob_protect;

-- ## SEQUENCE
drop sequence if exists m_mobilite_douce.geo_mob_statio_cycl_seq;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       SCHEMA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- SCHEMA: m_mobilite_douce

-- DROP SCHEMA m_mobilite_douce ;
/*
CREATE SCHEMA m_mobilite_douce
    AUTHORIZATION create_sig;

COMMENT ON SCHEMA m_mobilite_douce
    IS 'Données géographiques métiers sur le thème de la mobilité douce (cycle, rando, piéton). Schéma proviosire remplaçant à terme m_mobilite sur la partie douce. La partie transport sera renommé m_transport';

GRANT ALL ON SCHEMA m_mobilite_douce TO create_sig;
GRANT ALL ON SCHEMA m_mobilite_douce TO postgres;
GRANT ALL ON SCHEMA m_mobilite_douce TO sig_read;
GRANT ALL ON SCHEMA m_mobilite_douce TO sig_edit;


-- Permissions

ALTER DEFAULT PRIVILEGES IN SCHEMA m_mobilite GRANT TRUNCATE, REFERENCES, INSERT, TRIGGER, SELECT, UPDATE, DELETE ON TABLES TO create_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_mobilite GRANT TRUNCATE, REFERENCES, INSERT, TRIGGER, SELECT, UPDATE, DELETE ON TABLES TO sig_create;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_mobilite GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES TO sig_edit;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_mobilite GRANT SELECT ON TABLES TO sig_read;

*/
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINE  DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# lt_booleen ###############################################

-- liste de valeurs gérant le faux bouleen, cette liste est dans le schéma r_objet

-- ################################################################# lt_mob_statut ###############################################
 
-- m_mobilite_douce.lt_mob_statut definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_statut;

CREATE TABLE m_mobilite_douce.lt_mob_statut (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_statut_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_statut_code_idx ON m_mobilite_douce.lt_mob_statut USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_statut IS 'Liste de valeurs du statut de l''équipement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_statut.code IS 'Code du statut de la version du tronçon sur la desserte en offre de transport';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_statut.valeur IS 'Libellé du statut de la version du tronçon sur la desserte en offre de transport';

-- Permissions

ALTER TABLE m_mobilite_douce.lt_mob_statut OWNER TO create_sig;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_statut TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.lt_mob_statut TO sig_read;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_statut TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.lt_mob_statut TO sig_edit;


INSERT INTO m_mobilite_douce.lt_mob_statut(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Actif'),
  ('20','Inactif'),
  ('30','Projet')
  ;

 -- ################################################################# lt_mob_etat_mob ###############################################
 
-- m_mobilite_douce.lt_mob_etat_mob definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_etat_mob;

CREATE TABLE m_mobilite_douce.lt_mob_etat_mob (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_etat_mob_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_etat_mob_idx ON m_mobilite_douce.lt_mob_etat_mob USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_etat_mob IS 'Liste de valeurs de l''état du mobilier de l''équipement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_statut.code IS 'Code de valeurs de l''état du mobilier de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_statut.valeur IS 'Libellé de valeurs de l''état du mobilier de l''équipement';

-- Permissions

ALTER TABLE m_mobilite_douce.lt_mob_etat_mob OWNER TO create_sig;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_etat_mob TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.lt_mob_etat_mob TO sig_read;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_etat_mob TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.lt_mob_etat_mob TO sig_edit;


INSERT INTO m_mobilite_douce.lt_mob_etat_mob(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Bon'),
  ('20','Moyen'),
  ('30','Vétuste')
  ;

-- ################################################################# lt_mob_typ_accro ###############################################
 
-- m_mobilite_douce.lt_mob_typ_accro definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_typ_accro;

CREATE TABLE m_mobilite_douce.lt_mob_typ_accro (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_typ_accro_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_typ_accro_idx ON m_mobilite_douce.lt_mob_typ_accro USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_typ_accro IS 'Liste de valeurs des types d''accroche';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_typ_accro.code IS 'Code de valeurs des types d''accroche';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_typ_accro.valeur IS 'Libellé de valeurs des types d''accroche';

-- Permissions

ALTER TABLE m_mobilite_douce.lt_mob_typ_accro OWNER TO create_sig;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_typ_accro TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.lt_mob_typ_accro TO sig_read;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_typ_accro TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.lt_mob_typ_accro TO sig_edit;


INSERT INTO m_mobilite_douce.lt_mob_typ_accro(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Roue'),
  ('20','Cadre'),
  ('21','Cadre et roue'),
  ('30','Sans accroche')
  ;
 
-- ################################################################# lt_mob_mobil ###############################################
 
-- m_mobilite_douce.lt_mob_mobil definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_mobil;

CREATE TABLE m_mobilite_douce.lt_mob_mobil (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_mobil_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_mobil_idx ON m_mobilite_douce.lt_mob_mobil USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_mobil IS 'Liste de valeurs des types d''accroche';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_mobil.code IS 'Code de valeurs des types d''accroche';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_mobil.valeur IS 'Libellé de valeurs des types d''accroche';

-- Permissions

ALTER TABLE m_mobilite_douce.lt_mob_mobil OWNER TO create_sig;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_mobil TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.lt_mob_mobil TO sig_read;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_mobil TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.lt_mob_mobil TO sig_edit;


INSERT INTO m_mobilite_douce.lt_mob_mobil(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Arceau'),
  ('11','Arceau vélo grande taille'),
  ('20','Ratelier'),
  ('30','Rack double étage'),
  ('40','Crochet'),
  ('50','Support guidon'),
  ('60','Potelet'),
  ('90','Aucun équipement'),
  ('99','Autre')
  ;
 
-- ################################################################# lt_mob_acces ###############################################
 
-- m_mobilite_douce.lt_mob_acces definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_acces;

CREATE TABLE m_mobilite_douce.lt_mob_acces (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_acces_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_acces_idx ON m_mobilite_douce.lt_mob_acces USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_acces IS 'Liste des modes d''accès à l''emplacement de stationnement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_acces.code IS 'Code des modes d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_acces.valeur IS 'Libellé des modes d''accès à l''emplacement de stationnement';

-- Permissions

ALTER TABLE m_mobilite_douce.lt_mob_acces OWNER TO create_sig;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_acces TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.lt_mob_acces TO sig_read;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_acces TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.lt_mob_acces TO sig_edit;


INSERT INTO m_mobilite_douce.lt_mob_acces(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Libre accès'),
  ('20','Abonnement ou inscription préalable'),
  ('30','Privé')
  ;
 
 -- ################################################################# lt_mob_protect ###############################################
 
-- m_mobilite_douce.lt_mob_protect definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_protect;

CREATE TABLE m_mobilite_douce.lt_mob_protect (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_protect_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_protect_idx ON m_mobilite_douce.lt_mob_protect USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_protect IS 'Liste des modes d''accès à l''emplacement de stationnement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_protect.code IS 'Code des modes d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_protect.valeur IS 'Libellé des modes d''accès à l''emplacement de stationnement';

-- Permissions

ALTER TABLE m_mobilite_douce.lt_mob_protect OWNER TO create_sig;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_protect TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.lt_mob_protect TO sig_read;
GRANT ALL ON TABLE m_mobilite_douce.lt_mob_protect TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.lt_mob_protect TO sig_edit;


INSERT INTO m_mobilite_douce.lt_mob_protect(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Stationnement non fermé'),
  ('20','Consigne collective fermée'),
  ('30','Box individuel fermé'),
  ('99','Autre')
  ;
 
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# Séquence sur TABLE an_erp_objet ###############################################

-- m_mobilite_douce.geo_mob_statio_cycl_seq definition

-- DROP SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq;

CREATE SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq TO create_sig;
GRANT ALL ON SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq TO public;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE geo_mob_statio_cycl ###############################################

-- m_mobilite_douce.geo_mob_statio_cycl

-- Drop table

-- DROP TABLE m_mobilite_douce.geo_mob_statio_cycl;

CREATE TABLE m_mobilite_douce.geo_mob_statio_cycl (
	id_local text not null DEFAULT 'SC' || nextval('m_mobilite_douce.geo_mob_statio_cycl_seq'::regclass),
	id_adresse int8,
	complt_adr varchar(500),
	statut varchar(2) not null DEFAULT '10'::character varying,
	etat varchar(2) not null DEFAULT '00'::character varying,
	cap varchar(2) not null default '00',
	cap_cargo varchar(2) not null default '00',
	typ_accro varchar(2) not null default '00',
	mobil varchar(2) not null default '00',
	acces varchar(2) not null default '00',
	gratuit varchar(2) not null default '00',
	protect varchar(2) not null default '00',
	couvert varchar(2) not null default '00',
	surv varchar(2)not null default '00',
	lum varchar(2) not null default '00',
	url text,
	an_pose integer,
	proprio varchar(2),
	gestio varchar(500),
	src_geom varchar(100) not null default '21',
	src_annee varchar(4) not null default '2021' ,
	observ varchar(1000),
	epci varchar(5) not null,
	insee varchar(5) not null,
	commune varchar(80) not null,
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp not null DEFAULT now(),
	dbupdate timestamp,
	x_l93 numeric(9, 2) not null,
	y_l93 numeric(10, 2) not null,
	geom geometry(point, 2154) not NULL,
	CONSTRAINT "geo_mob_statio_cycl_pkey" PRIMARY KEY (id_local)
);
CREATE INDEX "geo_mob_statio_cycl_idx" ON m_mobilite_douce.geo_mob_statio_cycl USING gist (geom);
COMMENT ON TABLE m_mobilite_douce.geo_mob_statio_cycl IS 'Classe d''objet géographique localisant un ensemble cohérent d''équipements de stationnement cyclable';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.id_local IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.id_adresse IS 'Identifiant de l''adresse';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.complt_adr IS 'Complément d''adresse';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.statut IS 'Statut de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.etat IS 'Etat de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.cap IS 'Nombre de places de stationnement disponibles sur l''emplacement y compris les places adaptées à des vélos spéciaux';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.cap_cargo IS 'Nombre de places de stationnement disponibles pour les vélos de grande taille';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.typ_accro IS 'Mode d''accrochage possible du vélo aux équipements de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.mobil IS 'Type de mobilier de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.acces IS 'Mode d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.gratuit IS 'L''usage de l''équipement de stationnement est-il gratuit ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.protect IS 'Protection du stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.couvert IS 'Le stationnement est-il couvert et est donc protégé de la pluie, de la neige et de la grêle ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.surv IS 'Le stationnement est-il surveillé par un gardien ou par de la vidéosurveillance ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.lum IS ' L''emplacement est-il éclairé la nuit (par de l''éclairage urbain ou dédié à l''emplacement) ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.url IS 'Protection du stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.an_pose IS 'Année de mise en service du stationnement vélo';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.proprio IS 'Nom de l''organisation propriétaire de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.gestio IS 'Nom de l''organisation gestionnaire de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.src_geom IS 'Référentiel géographique de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.src_annee IS 'Année du référentiel de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.epci IS 'EPCI d''assise de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.insee IS 'Code Insee  de la commune d''implantation de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.commune IS 'Commune d''implantation de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.dbinsert IS 'Date d''insertion danbs la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.dbupdate IS 'Date de mise à jour dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.x_l93 IS 'Coordonnées X en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.geom IS 'Classe d''objets géométrique';

-- Permissions

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl OWNER TO sig_create;
GRANT TRUNCATE, INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.geo_mob_statio_cycl TO sig_create;
GRANT TRUNCATE, INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.geo_mob_statio_cycl TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.geo_mob_statio_cycl TO sig_read;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_mobilite_douce.geo_mob_statio_cycl TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.geo_mob_statio_cycl TO postgres;

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_cap_fkey FOREIGN KEY (cap)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_cap_cargo_fkey FOREIGN KEY (cap_cargo)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;       
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_gratuit_fkey FOREIGN KEY (gratuit)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_protect_fkey FOREIGN KEY (protect)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_couvert_fkey FOREIGN KEY (couvert)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_surv_fkey FOREIGN KEY (surv)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_booleen_lum_fkey FOREIGN KEY (lum)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statut_fkey FOREIGN KEY (lum)
        REFERENCES m_mobilite_douce.lt_mob_statut (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;         
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_etat_mob_fkey FOREIGN KEY (lum)
        REFERENCES m_mobilite_douce.lt_mob_etat_mob (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;    

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_typ_accro_fkey FOREIGN KEY (typ_accro)
        REFERENCES m_mobilite_douce.lt_mob_typ_accro (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_mobil_fkey FOREIGN KEY (mobil)
        REFERENCES m_mobilite_douce.lt_mob_mobil (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_acces_fkey FOREIGN KEY (acces)
        REFERENCES m_mobilite_douce.lt_mob_acces (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_protect_fkey FOREIGN KEY (protect)
        REFERENCES m_mobilite_douce.lt_mob_protect (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;         
       
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        MEDIA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                    CONTRAINTE                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


        
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       INDEX                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     FONCTION                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### FONCTION/TRIGGER ft_m_refresh_adresse_erp ###############################################

       
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TRIGGER                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                             VUE APPLICATIVE                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

   



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                             VUE OPEN DATA                                                                    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       DROITS                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

/* cf grégory */



