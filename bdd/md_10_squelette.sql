/**Mobilite douce V0.1*/
/*Creation du fichier complet*/
/* init_db_mobdouce.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet */

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
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_gratuit_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_protect_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_couvert_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_surv_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_booleen_lum_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_mobdouce_statut_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_mobdouce_etat_mob_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_mobdouce_type_accro_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_mobdouce_mobil_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_mobdouce_acces_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_mobdouce_protect_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl DROP CONSTRAINT IF EXISTS lt_gestio_proprio_fkey;


-- ## VUE
DROP VIEW IF EXISTS x_opendata.xopendata_an_v_statio_cycl;



-- ## CLASSE
drop table if exists m_mobilite_douce.geo_mobdouce_statio_cycl;
drop table if exists m_mobilite_douce.an_mobdouce_statio_cylc_media;

-- ## TABLE DE RELATION


-- ## DOMAINE DE VALEUR
drop table if exists m_mobilite_douce.lt_mobdouce_statut;
drop table if exists m_mobilite_douce.lt_mobdouce_etat_mob;
drop table if exists m_mobilite_douce.lt_mobdouce_typ_accro;
drop table if exists m_mobilite_douce.lt_mobdouce_mobil;
drop table if exists m_mobilite_douce.lt_mobdouce_acces;
drop table if exists m_mobilite_douce.lt_mobdouce_protect;

-- ## SEQUENCE
drop sequence if exists m_mobilite_douce.geo_mobdouce_statio_cycl_seq;
drop sequence if exists m_mobilite_douce.an_mobdouce_statio_cylc_media_seq;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       SCHEMA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- SCHEMA: m_mobilite_douce

-- DROP SCHEMA m_mobilite_douce ;
/*
CREATE SCHEMA m_mobilite_douce
    AUTHORIZATION [......];

COMMENT ON SCHEMA m_mobilite_douce
    IS 'Données géographiques métiers sur le thème de la mobilité douce (cycle, rando, piéton). Schéma proviosire remplaçant à terme m_mobilite sur la partie douce. La partie transport sera renommé m_transport';




*/
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINE  DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# lt_booleen ###############################################

-- liste de valeurs gérant le faux bouleen, cette liste est dans le schéma r_objet

-- ################################################################# lt_gestio_proprio ###############################################

-- liste de valeurs gérant les types de propriétaire et de gestionnaire, cette liste est dans le schéma r_objet


-- ################################################################# lt_mobdouce_statut ###############################################
 
-- m_mobilite_douce.lt_mobdouce_statut definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mobdouce_statut;

CREATE TABLE m_mobilite_douce.lt_mobdouce_statut (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mobdouce_statut_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mobdouce_statut_code_idx ON m_mobilite_douce.lt_mobdouce_statut USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mobdouce_statut IS 'Liste de valeurs du statut de l''équipement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_statut.code IS 'Code du statut de la version du tronçon sur la desserte en offre de transport';
COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_statut.valeur IS 'Libellé du statut de la version du tronçon sur la desserte en offre de transport';




INSERT INTO m_mobilite_douce.lt_mobdouce_statut(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Actif'),
  ('20','Inactif'),
  ('30','Projet')
  ;

 -- ################################################################# lt_mobdouce_etat_mob ###############################################
 
-- m_mobilite_douce.lt_mobdouce_etat_mob definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mobdouce_etat_mob;

CREATE TABLE m_mobilite_douce.lt_mobdouce_etat_mob (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mobdouce_etat_mob_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_etat_mob_idx ON m_mobilite_douce.lt_mobdouce_etat_mob USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mobdouce_etat_mob IS 'Liste de valeurs de l''état du mobilier de l''équipement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_statut.code IS 'Code de valeurs de l''état du mobilier de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_statut.valeur IS 'Libellé de valeurs de l''état du mobilier de l''équipement';




INSERT INTO m_mobilite_douce.lt_mobdouce_etat_mob(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Bon'),
  ('20','Moyen'),
  ('30','Vétuste')
  ;

-- ################################################################# lt_mobdouce_typ_accro ###############################################
 
-- m_mobilite_douce.lt_mobdouce_typ_accro definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mobdouce_typ_accro;

CREATE TABLE m_mobilite_douce.lt_mobdouce_typ_accro (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_typ_accro_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_typ_accro_idx ON m_mobilite_douce.lt_mobdouce_typ_accro USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mobdouce_typ_accro IS 'Liste de valeurs des types d''accroche';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_typ_accro.code IS 'Code de valeurs des types d''accroche';
COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_typ_accro.valeur IS 'Libellé de valeurs des types d''accroche';




INSERT INTO m_mobilite_douce.lt_mobdouce_typ_accro(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Roue'),
  ('20','Cadre'),
  ('21','Cadre et roue'),
  ('30','Sans accroche')
  ;
 
-- ################################################################# lt_mobdouce_mobil ###############################################
 
-- m_mobilite_douce.lt_mobdouce_mobil definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mobdouce_mobil;

CREATE TABLE m_mobilite_douce.lt_mobdouce_mobil (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_mobil_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_mobil_idx ON m_mobilite_douce.lt_mobdouce_mobil USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mobdouce_mobil IS 'Liste de valeurs des types d''accroche';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_mobil.code IS 'Code de valeurs des types d''accroche';
COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_mobil.valeur IS 'Libellé de valeurs des types d''accroche';




INSERT INTO m_mobilite_douce.lt_mobdouce_mobil(
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
  ('99','Autre');
 
-- ################################################################# lt_mobdouce_acces ###############################################
 
-- m_mobilite_douce.lt_mobdouce_acces definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mobdouce_acces;

CREATE TABLE m_mobilite_douce.lt_mobdouce_acces (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_acces_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_acces_idx ON m_mobilite_douce.lt_mobdouce_acces USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mobdouce_acces IS 'Liste des modes d''accès à l''emplacement de stationnement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_acces.code IS 'Code des modes d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_acces.valeur IS 'Libellé des modes d''accès à l''emplacement de stationnement';



INSERT INTO m_mobilite_douce.lt_mobdouce_acces(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Libre accès'),
  ('20','Abonnement ou inscription préalable'),
  ('30','Privé')
  ;
 
 -- ################################################################# lt_mobdouce_protect ###############################################
 
-- m_mobilite_douce.lt_mobdouce_protect definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mobdouce_protect;

CREATE TABLE m_mobilite_douce.lt_mobdouce_protect (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_protect_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_protect_idx ON m_mobilite_douce.lt_mobdouce_protect USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mobdouce_protect IS 'Liste des modes d''accès à l''emplacement de stationnement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_protect.code IS 'Code des modes d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.lt_mobdouce_protect.valeur IS 'Libellé des modes d''accès à l''emplacement de stationnement';




INSERT INTO m_mobilite_douce.lt_mobdouce_protect(
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

-- ################################################################# Séquence sur TABLE geo_mobdouce_statio_cycl_seq ###############################################

-- m_mobilite_douce.geo_mobdouce_statio_cycl_seq definition

-- DROP SEQUENCE m_mobilite_douce.geo_mobdouce_statio_cycl_seq;

CREATE SEQUENCE m_mobilite_douce.geo_mobdouce_statio_cycl_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;



ALTER sequence if EXISTS m_mobilite_douce.geo_mobdouce_statio_cycl_seq restart with 300;

-- ################################################################# Séquence sur TABLE an_mobdouce_statio_cylc_media ###############################################

-- m_mobilite_douce.an_mobdouce_statio_cylc_media_seq definition

-- DROP SEQUENCE m_mobilite_douce.an_mobdouce_statio_cylc_media_seq;

CREATE SEQUENCE m_mobilite_douce.an_mobdouce_statio_cylc_media_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ################################################################# TABLE geo_mobdouce_statio_cycl ###############################################

-- m_mobilite_douce.geo_mobdouce_statio_cycl

-- Drop table

-- DROP TABLE m_mobilite_douce.geo_mobdouce_statio_cycl;

CREATE TABLE m_mobilite_douce.geo_mobdouce_statio_cycl (
	id_statio text not null DEFAULT 'SC' || nextval('m_mobilite_douce.geo_mobdouce_statio_cycl_seq'::regclass),
	id_adresse int8,
	id_voie int8,
	complt_adr varchar(500),
	statut varchar(2) not null DEFAULT '10'::character varying,
	etat varchar(2) not null DEFAULT '00'::character varying,
	cap int2 not null default 0,
	cap_cargo int2,
	typ_accro varchar(2) not null default '00',
	mobil varchar(2) not null default '00',
	mobil_p varchar(50),
	acces varchar(2) not null default '00',
	gratuit varchar(2) not null default '00',
	protect varchar(2) not null default '00',
	couvert varchar(2) not null default '00',
	surv varchar(2)not null default '00',
	lum varchar(2) not null default '00',
	url text,
	an_pose integer,
	proprio varchar(2) NOT NULL DEFAULT '00',
	gestio varchar(2) NOT NULL DEFAULT '00',
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
	CONSTRAINT "geo_mob_statio_cycl_pkey" PRIMARY KEY (id_statio)
);
CREATE INDEX "geo_mob_statio_cycl_idx" ON m_mobilite_douce.geo_mobdouce_statio_cycl USING gist (geom);
COMMENT ON TABLE m_mobilite_douce.geo_mobdouce_statio_cycl IS 'Classe d''objet géographique localisant un ensemble cohérent d''équipements de stationnement cyclable';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.id_statio IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.id_adresse IS 'Identifiant de l''adresse';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.id_voie IS 'Identifiant de la voie';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.complt_adr IS 'Complément d''adresse';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.statut IS 'Statut de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.etat IS 'Etat de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.cap IS 'Nombre de places de stationnement disponibles sur l''emplacement y compris les places adaptées à des vélos spéciaux';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.cap_cargo IS 'Nombre de places de stationnement disponibles pour les vélos de grande taille';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.typ_accro IS 'Mode d''accrochage possible du vélo aux équipements de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.mobil IS 'Type de mobilier de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.mobil_p IS 'Précision sur le type de mobilier de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.acces IS 'Mode d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.gratuit IS 'L''usage de l''équipement de stationnement est-il gratuit ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.protect IS 'Protection du stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.couvert IS 'Le stationnement est-il couvert et est donc protégé de la pluie, de la neige et de la grêle ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.surv IS 'Le stationnement est-il surveillé par un gardien ou par de la vidéosurveillance ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.lum IS ' L''emplacement est-il éclairé la nuit (par de l''éclairage urbain ou dédié à l''emplacement) ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.url IS 'Site web d''information';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.an_pose IS 'Année de mise en service du stationnement vélo';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.proprio IS 'Nom de l''organisation propriétaire de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.gestio IS 'Nom de l''organisation gestionnaire de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.src_geom IS 'Référentiel géographique de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.src_annee IS 'Année du référentiel de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.epci IS 'EPCI d''assise de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.insee IS 'Code Insee  de la commune d''implantation de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.commune IS 'Commune d''implantation de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.dbupdate IS 'Date de mise à jour dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.x_l93 IS 'Coordonnées X en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mobdouce_statio_cycl.geom IS 'Classe d''objets géométrique';



  
       
ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_booleen_gratuit_fkey FOREIGN KEY (gratuit)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_booleen_couvert_fkey FOREIGN KEY (couvert)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_booleen_surv_fkey FOREIGN KEY (surv)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
       
ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_booleen_lum_fkey FOREIGN KEY (lum)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_mobdouce_statut_fkey FOREIGN KEY (statut)
        REFERENCES m_mobilite_douce.lt_mobdouce_statut (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;         
       
ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_mobdouce_etat_mob_fkey FOREIGN KEY (etat)
        REFERENCES m_mobilite_douce.lt_mobdouce_etat_mob (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;    

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_mobdouce_typ_accro_fkey FOREIGN KEY (typ_accro)
        REFERENCES m_mobilite_douce.lt_mobdouce_typ_accro (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_mobdouce_mobil_fkey FOREIGN KEY (mobil)
        REFERENCES m_mobilite_douce.lt_mobdouce_mobil (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_mobdouce_acces_fkey FOREIGN KEY (acces)
        REFERENCES m_mobilite_douce.lt_mobdouce_acces (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_mobdouce_protect_fkey FOREIGN KEY (protect)
        REFERENCES m_mobilite_douce.lt_mobdouce_protect (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;      
       

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_gestio_proprio_proprio_fkey FOREIGN KEY (proprio)
        REFERENCES r_objet.lt_gestio_proprio (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        
       

ALTER TABLE m_mobilite_douce.geo_mobdouce_statio_cycl
    ADD CONSTRAINT lt_gestio_proprio_gestio_fkey FOREIGN KEY (gestio)
        REFERENCES r_objet.lt_gestio_proprio (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

-- ################################################################# TABLE an_mobdouce_statio_cylc_media ###############################################

-- m_mobilite_douce.an_mobdouce_statio_cylc_media definition

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mobdouce_statio_cylc_media;

CREATE TABLE m_mobilite_douce.an_mobdouce_statio_cylc_media (
	gid int4 DEFAULT nextval('m_mobilite_douce.an_mobdouce_statio_cylc_media_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id text NULL, -- Identifiant unique du stationnement vélo
	media text NULL, -- Champ Média de GEO
	miniature bytea NULL, -- Champ miniature de GEO
	n_fichier text NULL, -- Nom du fichier
	t_fichier text NULL, -- Type de média dans GEO
	op_sai text NULL, -- opérateur intégrant le média
	date_sai timestamp DEFAULT 'now'::text::date NULL,
	CONSTRAINT an_mob_statio_cylc_media_pkey PRIMARY KEY (gid)
);
CREATE INDEX an_mob_statio_cylc_media_gid_idx ON m_mobilite_douce.an_mobdouce_statio_cylc_media USING btree (gid);
COMMENT ON TABLE m_mobilite_douce.an_mobdouce_statio_cylc_media IS 'Table des médias pour les stationnements cyclables';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.gid IS 'Identifiant unique non signifiant';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.id IS 'Identifiant unique du stationnement vélo';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.op_sai IS 'opérateur intégrant le média';
COMMENT ON COLUMN m_mobilite_douce.an_mobdouce_statio_cylc_media.date_sai IS 'Date de saisie du média';

 
       
       
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


-- #################################################################### FONCTION/TRIGGER ft_m_gestion_controle ###############################################

DROP FUNCTION IF EXISTS m_mobilite_douce.ft_m_gestion_controle();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_gestion_controle()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$


BEGIN


 -- automatisation des valeurs d'accroche en fonction du type de mobilier saisie (l'accroche peut-être saisie si le mobilier non)
IF new.mobil || new.typ_accro = '0000' then

RAISE EXCEPTION 'Vous devez obligatoirement renseigner un type d''accroche.<br><br>';

else
	if NEW.mobil IN ('10','30','50','11') THEN new.typ_accro := '21';
	elsif NEW.mobil IN ('20','40') THEN new.typ_accro := '10';
	elsif NEW.mobil = '90' THEN new.typ_accro := '30';
	elsif NEW.mobil = '60' THEN new.typ_accro := '20';
	end if;

END IF;

-- si gratuit l'accès ne peut être avec abonnement
if new.gratuit = 't' and new.acces = '20' then 
	 RAISE EXCEPTION 'Vous ne pouvez pas indiquer une gratuité d''accès avec un accès par abonnement.<br><br>';
end if;

-- année de mise en service doit être supérieur à 2000
if new.an_pose <= 2000 or new.an_pose > (extract(year from now())+1) then
	 RAISE EXCEPTION 'L''année de mise en service n''est pas cohérente.<br><br>';
end if;

-- la capacité des vélos de grande taille ne peut pas être supérieur à la capacité
if new.cap < new.cap_cargo then
	RAISE EXCEPTION 'Vous ne pouvez pas indiquer une capacité pour vélo de grande taille supérieure à la capacité totale.<br><br>';
end if;

  return new;
 
END;

$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_gestion_controle() IS 'Fonction gérant les contrôles de saisies et l''automatisation de certains attributs';




       
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TRIGGER                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ########################################## FONCTION/TRIGGER classe d'objets geo_mobdouce_statio_cycl ###############################################
DROP TRIGGER IF EXISTS t_t1_dbinsert ON m_mobilite_douce.geo_mobdouce_statio_cycl;
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.geo_mobdouce_statio_cycl for each row execute procedure public.ft_r_timestamp_dbinsert();

   
DROP TRIGGER IF EXISTS t_t2_dbupdate ON m_mobilite_douce.geo_mobdouce_statio_cycl;
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.geo_mobdouce_statio_cycl for each row execute procedure public.ft_r_timestamp_dbupdate();

DROP TRIGGER IF EXISTS t_t3_xyl93 ON m_mobilite_douce.geo_mobdouce_statio_cycl;
create trigger t_t3_xyl93 BEFORE
insert OR update
    on
    m_mobilite_douce.geo_mobdouce_statio_cycl for each row execute procedure public.ft_r_xy_l93();
 
DROP TRIGGER IF EXISTS t_t4_inseecommune ON m_mobilite_douce.geo_mobdouce_statio_cycl;
create trigger t_t4_inseecommune BEFORE
insert OR update
    on
    m_mobilite_douce.geo_mobdouce_statio_cycl for each row execute procedure public.ft_r_commune_pl();   

DROP TRIGGER IF EXISTS t_t5_autorite ON m_mobilite_douce.geo_mobdouce_statio_cycl;
create trigger t_t5_autorite BEFORE
insert OR update
    on
    m_mobilite_douce.geo_mobdouce_statio_cycl for each row execute procedure public.ft_r_autorite_competente();    
   
   
DROP TRIGGER IF EXISTS t_t6_gestion_controle ON m_mobilite_douce.geo_mobdouce_statio_cycl;
create trigger t_t6_gestion_controle BEFORE
insert OR update
    on
    m_mobilite_douce.geo_mobdouce_statio_cycl for each row execute procedure m_mobilite_douce.ft_m_gestion_controle();    


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

-- #################################################################### vue xopendata_an_v_statio_cycl ###############################################
-- x_opendata.xopendata_an_v_statio_cycl source

CREATE OR REPLACE VIEW x_opendata.xopendata_an_v_statio_cycl
AS 
SELECT
	s.id_statio AS id_local,
	null AS id_osm,
	s.insee as code_com,
	'[' || st_x(st_transform(s.geom, 4326))::numeric(8,7) || ',' || st_y(st_transform(s.geom, 4326))::numeric(9,7) || ']' as coordonneesxy,
	s.cap as capacite,
	s.cap_cargo as capacite_cargo,
	CASE WHEN ta.code <> '00' THEN ta.valeur ELSE '' END AS type_accroche,
	CASE WHEN m.code <> '00' THEN m.valeur ELSE '' END AS mobilier,
	CASE WHEN a.code <> '00' THEN a.valeur ELSE '' END AS acces,
	CASE WHEN s.gratuit NOT IN ('t','f') THEN '' ELSE
		CASE
			WHEN s.gratuit = 't' THEN 'true'
			WHEN s.gratuit = 'f' THEN 'false'
		ELSE '' END
	END AS gratuit,
	CASE WHEN pr.code <> '00' THEN pr.valeur ELSE '' END AS protection,
	CASE WHEN s.couvert NOT IN ('t','f') THEN '' ELSE
		CASE
			WHEN s.couvert = 't' THEN 'true'
			WHEN s.couvert = 'f' THEN 'false'
		ELSE '' END
	END as couverture,
	CASE WHEN s.surv NOT IN ('t','f') THEN '' ELSE
		CASE
			WHEN s.surv = 't' THEN 'true'
			WHEN s.surv = 'f' THEN 'false'
		ELSE '' END
	END as surveillance,
	CASE WHEN s.lum NOT IN ('t','f') THEN '' ELSE
		CASE
			WHEN s.lum = 't' THEN 'true'
			WHEN s.lum = 'f' THEN 'false'
		ELSE '' END
	END as lumiere,
	s.url as url_info,
	s.an_pose as d_service,
	CASE 
		WHEN s.epci = 'arc' THEN 'Agglomération de la Région de Compiègne et de la Basse Automne' 
		WHEN s.epci = 'cclo' THEN 'Communauté de Communes des Lisières de l''Oise' 
		WHEN s.epci = 'ccpe' THEN 'Communauté de Communes de la Plaine d''Estrées'
		WHEN s.epci = 'cc2v' THEN 'Communauté de Communes des Deux Vallées'
	ELSE '' end as source,
	p.valeur as proprietaire,
	g.valeur as gestionnaire,
	CASE WHEN s.dbupdate IS NULL THEN s.dbinsert ELSE s.dbinsert END as date_maj,
	s.observ as commentaires	
FROM
	m_mobilite_douce.geo_mobdouce_statio_cycl s
	JOIN r_objet.lt_gestio_proprio g ON s.gestio = g.code
	JOIN r_objet.lt_gestio_proprio p ON s.proprio = p.code
	JOIN m_mobilite_douce.lt_mobdouce_protect pr ON s.protect = pr.code
	JOIN m_mobilite_douce.lt_mobdouce_acces a ON s.acces = a.code
	JOIN m_mobilite_douce.lt_mobdouce_mobil m ON s.mobil = m.code
	JOIN m_mobilite_douce.lt_mobdouce_typ_accro ta ON s.typ_accro = ta.code
WHERE
	s.statut = '10'
;

COMMENT ON VIEW x_opendata.xopendata_an_v_statio_cycl IS 'Vue opendata des lieux de stationnements cyclables';









