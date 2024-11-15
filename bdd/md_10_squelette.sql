/**Mobilite douce V0.1*/
/*Creation du fichier complet*/
/* init_db_mobdouce.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteurs : Grégory Bodet */

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SUPPRESSION                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

begin;

-- ## VUE
drop view if exists m_mobilite_douce.xapps_an_v_amgt_cycl_tab;
drop view if exists m_mobilite_douce.xapps_an_v_cycl_tab1;
drop view if exists m_mobilite_douce.xapps_an_v_iti_ame_pan_tab;
drop view if exists m_mobilite_douce.xapps_an_v_iti_ame_tab;
drop view if exists m_mobilite_douce.xapps_an_v_iti_cycl_tab;
drop view if exists m_mobilite_douce.xapps_an_v_iti_tab;
drop view if exists m_mobilite_douce.xapps_geo_v_noeud_troncon_tab;
DROP VIEW IF EXISTS m_mobilite_douce.xapps_an_v_statio_cycl_tab1;

DROP VIEW IF EXISTS m_mobilite_douce.xopendata_an_v_mob_iti_cycl;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_an_v_statio_cycl;
DROP VIEW IF exists m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_geo_v_mob_iti_rand;


drop materialized view IF EXISTS m_mobilite_douce.xapps_geo_vmr_amgt_cycl_hors_planvelo_arc;
drop materialized view IF EXISTS m_mobilite_douce.xapps_geo_vmr_iti_cycl;
drop materialized view IF EXISTS m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_60159_gdpublic;
drop materialized view IF EXISTS m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_arc_gdpublic;
drop materialized view IF EXISTS m_mobilite_douce.xapps_geo_vmr_iti_rand;

drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_pan_typcode;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_acces;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_ame;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_local;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_regime;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_res;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_revet;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_tronc_sens;
drop MATERIALIZED view if exists m_mobilite_douce.lt_vmr_mob_troncon;
drop MATERIALIZED view if exists m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon;
drop MATERIALIZED view if exists m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat;
drop MATERIALIZED view if exists m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa;


-- ## CONTRAINTES
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_gratuit_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_protect_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_couvert_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_surv_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_lum_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_dbstatut_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_dbetat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_etat_mob_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_typ_accro_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_mobil_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_acces_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_proprio_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_statio_cycl DROP CONSTRAINT IF EXISTS lt_mob_statio_gestio_fkey;


ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_etat_avancement_dbetat_d_requal_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_etat_avancement_dbetat_g_requal_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_acces_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_ame_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_ame_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_ame_d_requal_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_ame_g_requal_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_conv_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_conv_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_dbetat_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_dbetat_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_dbstatut_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_local_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_local_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_lum_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_posi_dg_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_regime_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_regime_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_res_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_revet_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_revet_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_sens_d_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_sens_g_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_src_geom_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon DROP CONSTRAINT IF EXISTS lt_mob_tronc_typ_fkey;



ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_repere DROP CONSTRAINT IF EXISTS lt_mob_rep_typrep_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_repere DROP CONSTRAINT IF EXISTS lt_mob_rep_usarep_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_repere DROP CONSTRAINT IF EXISTS lt_mob_rep_dbetat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_repere DROP CONSTRAINT IF EXISTS lt_mob_rep_dbstatut_fkey;

ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_typsign_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_etat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_srcgeom_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_typpan_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_codepan_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_dbetat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.geo_mob_pan DROP CONSTRAINT IF EXISTS lt_mob_pan_dbstatut_fkey;

ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_cycl DROP CONSTRAINT IF EXISTS lt_mob_iti_usage_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_cycl DROP CONSTRAINT IF EXISTS lt_mob_iti_dbetat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_cycl DROP CONSTRAINT IF EXISTS lt_mob_iti_dbstatut_fkey;

ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand DROP CONSTRAINT IF EXISTS lt_mob_iti_pdipr_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand DROP CONSTRAINT IF EXISTS lt_mob_iti_pratrand_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand DROP CONSTRAINT IF EXISTS lt_mob_iti_typparc_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand DROP CONSTRAINT IF EXISTS lt_mob_iti_typrand_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand DROP CONSTRAINT IF EXISTS lt_mob_iti_dbetat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand DROP CONSTRAINT IF EXISTS lt_mob_iti_dbstatut_fkey;

ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_plan DROP CONSTRAINT IF EXISTS lt_mob_plan_usa_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_plan DROP CONSTRAINT IF EXISTS lt_mob_plan_niv_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_plan DROP CONSTRAINT IF EXISTS lt_mob_plan_dbetat_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_plan DROP CONSTRAINT IF EXISTS lt_mob_plan_dbstatut_fkey;

ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_media DROP CONSTRAINT IF EXISTS lt_mob_media_typdoc_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_pn DROP CONSTRAINT IF EXISTS lt_mob_pan_codepn_fkey;
ALTER TABLE IF EXISTS m_mobilite_douce.an_mob_pn DROP CONSTRAINT IF EXISTS lt_mob_pan_etat_mob_fkey;

ALTER TABLE IF EXISTS m_signalement.geo_mob_sign DROP CONSTRAINT IF EXISTS lt_mob_sign_traite_fkey;
  
-- ## CLASSE
drop table if exists m_mobilite_douce.geo_mob_statio_cycl;
drop table if exists m_mobilite_douce.an_mob_statio_cylc_media;
DROP TABLE IF EXISTS m_mobilite_douce.geo_mob_troncon;
DROP TABLE IF EXISTS m_mobilite_douce.geo_mob_repere;
DROP TABLE IF EXISTS m_mobilite_douce.geo_mob_pan;
DROP TABLE IF EXISTS m_signalement.geo_mob_sign;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_pn;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_iti_cycl;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_iti_rand;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_plan;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_media;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_pan_media;
DROP TABLE IF EXISTS m_mobilite_douce.an_mob_log;

-- ## TABLE DE RELATION
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_tronc_iti;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_iti_plan;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_rep_troncon;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_rep_iti;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_pan_iti;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_itirand_com;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_itirand_sign;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_iticycl_sign;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_tronc_iti_decoupe;
DROP TABLE IF EXISTS m_mobilite_douce.lk_mob_droit_delegue_iti;

-- ## DOMAINE DE VALEUR
drop table if exists m_mobilite_douce.lt_mob_etat;

drop table if exists m_mobilite_douce.lt_mob_statio_typ_accro;
drop table if exists m_mobilite_douce.lt_mob_statio_mobil;
drop table if exists m_mobilite_douce.lt_mob_statio_acces;
drop table if exists m_mobilite_douce.lt_mob_statio_protect;

drop table if exists m_mobilite_douce.lt_mob_tronc_res;
drop table if exists m_mobilite_douce.lt_mob_tronc_acces;
drop table if exists m_mobilite_douce.lt_mob_tronc_ame;
drop table if exists m_mobilite_douce.lt_mob_tronc_regime;
drop table if exists m_mobilite_douce.lt_mob_tronc_sens;
drop table if exists m_mobilite_douce.lt_mob_tronc_local;
drop table if exists m_mobilite_douce.lt_mob_tronc_revet;
drop table if exists m_mobilite_douce.lt_mob_tronc_typ;
drop table if exists m_mobilite_douce.lt_mob_tronc_dg;

drop table if exists m_mobilite_douce.lt_mob_rep_typrep;
drop table if exists m_mobilite_douce.lt_mob_rep_usarep;

drop table if exists m_mobilite_douce.lt_mob_pan_typpan;
drop table if exists m_mobilite_douce.lt_mob_pan_codepan;
drop table if exists m_mobilite_douce.lt_mob_pan_typsign;

drop table if exists m_mobilite_douce.lt_mob_iti_usage;

drop table if exists m_mobilite_douce.lt_mob_iti_pratrand;
drop table if exists m_mobilite_douce.lt_mob_iti_typrand;
drop table if exists m_mobilite_douce.lt_mob_iti_typparc;

drop table if exists m_mobilite_douce.lt_mob_plan_usage;
drop table if exists m_mobilite_douce.lt_mob_plan_niveau;

drop table if exists m_mobilite_douce.lt_mob_media_typdoc;





-- ## SEQUENCE
drop sequence if exists m_mobilite_douce.geo_mob_statio_cycl_seq;
drop sequence if exists m_mobilite_douce.an_mob_statio_cylc_media_seq;
drop sequence if exists m_mobilite_douce.geo_mob_troncon_seq;
drop sequence if exists m_mobilite_douce.geo_mob_repere_seq;
drop sequence if exists m_mobilite_douce.geo_mob_pan_seq;
drop sequence if exists m_mobilite_douce.an_mob_log_seq;
drop sequence if exists m_mobilite_douce.an_mob_media_seq;
drop sequence if exists m_mobilite_douce.an_mob_pn_seq;
drop sequence if exists m_mobilite_douce.an_mob_pan_media_seq;
drop sequence if exists m_mobilite_douce.lk_mob_tronc_iti_seq;
drop sequence if exists m_mobilite_douce.lk_mob_iti_plan_seq;
drop sequence if exists m_mobilite_douce.lk_mob_rep_troncon_seq;
drop sequence if exists m_mobilite_douce.lk_mob_rep_iti_seq;
drop sequence if exists m_mobilite_douce.lk_mob_pan_iti_seq;
drop sequence if exists m_mobilite_douce.lk_mob_itirand_com_seq;
drop sequence if EXISTS m_signalement.geo_mob_sign_id_seq;
drop sequence if EXISTS m_mobilite_douce.lk_mob_iticycl_sign_seq;
drop sequence if EXISTS m_mobilite_douce.lk_mob_itirand_sign_seq;
drop sequence if EXISTS m_mobilite_douce.lk_mob_tronc_iti_decoupe_seq;
drop sequence if EXISTS m_mobilite_douce.lk_mob_droit_delegue_iti_seq;




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



 -- ################################################################# lt_mob_etat ###############################################
 
-- m_mobilite_douce.lt_mob_etat definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_etat;

CREATE TABLE m_mobilite_douce.lt_mob_etat (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_etat_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_etat_idx ON m_mobilite_douce.lt_mob_etat USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_etat IS 'Liste de valeurs de l''état du mobilier de l''équipement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_etat.code IS 'Code de valeurs de l''état du mobilier de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_etat.valeur IS 'Libellé de valeurs de l''état du mobilier de l''équipement';



INSERT INTO m_mobilite_douce.lt_mob_etat(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Bon'),
  ('20','Moyen'),
  ('30','Vétuste')
  ;

-- ################################################################# lt_mob_statio_typ_accro ###############################################
 
-- m_mobilite_douce.lt_mob_statio_typ_accro definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_statio_typ_accro;

CREATE TABLE m_mobilite_douce.lt_mob_statio_typ_accro (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_statio_typ_accro_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_statio_typ_accro_idx ON m_mobilite_douce.lt_mob_statio_typ_accro USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_statio_typ_accro IS 'Liste de valeurs des types d''accroche';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_typ_accro.code IS 'Code de valeurs des types d''accroche';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_typ_accro.valeur IS 'Libellé de valeurs des types d''accroche';



INSERT INTO m_mobilite_douce.lt_mob_statio_typ_accro(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Roue'),
  ('20','Cadre'),
  ('21','Cadre et roue'),
  ('30','Sans accroche')
  ;
 
-- ################################################################# lt_mob_statio_mobil ###############################################
 
-- m_mobilite_douce.lt_mob_statio_mobil definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_statio_mobil;

CREATE TABLE m_mobilite_douce.lt_mob_statio_mobil (
	code varchar(2) NOT NULL, 
	valeur varchar(30) NULL, 
	CONSTRAINT lt_mob_statio_mobil_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_statio_mobil_idx ON m_mobilite_douce.lt_mob_statio_mobil USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_statio_mobil IS 'Liste de valeurs des types d''accroche';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_mobil.code IS 'Code de valeurs des types d''accroche';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_mobil.valeur IS 'Libellé de valeurs des types d''accroche';


INSERT INTO m_mobilite_douce.lt_mob_statio_mobil(
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
 
-- ################################################################# lt_mob_statio_acces ###############################################
 
-- m_mobilite_douce.lt_mob_statio_acces definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_statio_acces;

CREATE TABLE m_mobilite_douce.lt_mob_statio_acces (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_statio_acces_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_statio_acces_idx ON m_mobilite_douce.lt_mob_statio_acces USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_statio_acces IS 'Liste des modes d''accès à l''emplacement de stationnement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_acces.code IS 'Code des modes d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_acces.valeur IS 'Libellé des modes d''accès à l''emplacement de stationnement';



INSERT INTO m_mobilite_douce.lt_mob_statio_acces(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Libre accès'),
  ('20','Abonnement ou inscription préalable'),
  ('30','Privé')
  ;
 
 -- ################################################################# lt_mob_statio_protect ###############################################
 
-- m_mobilite_douce.lt_mob_statio_protect definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_statio_protect;

CREATE TABLE m_mobilite_douce.lt_mob_statio_protect (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_statio_protect_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_statio_protect_idx ON m_mobilite_douce.lt_mob_statio_protect USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_statio_protect IS 'Liste des modes d''accès à l''emplacement de stationnement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_protect.code IS 'Code des modes d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_statio_protect.valeur IS 'Libellé des modes d''accès à l''emplacement de stationnement';



INSERT INTO m_mobilite_douce.lt_mob_statio_protect(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Stationnement non fermé'),
  ('20','Consigne collective fermée'),
  ('30','Box individuel fermé'),
  ('99','Autre')
  ;
 
 -- ################################################################# lt_mob_tronc_res ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_res definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_res;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_res (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL,
	CONSTRAINT lt_mob_tronc_res_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_res_idx ON m_mobilite_douce.lt_mob_tronc_res USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_res IS 'Liste des types de réseau structurant local auquel appartient l''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_res.code IS 'Code des types de réseau structurant local auquel appartient l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_res.valeur IS 'Libellé des types de réseau structurant local auquel appartient l''aménagement';




INSERT INTO m_mobilite_douce.lt_mob_tronc_res(
            code, valeur,typ)
    VALUES
  ('00','Non renseigné'),
  ('10','REV'),
  ('20','Structurant'),
  ('99','Autre'),
  ('ZZ','Non concerné')
  ;
 
  -- ################################################################# lt_mob_tronc_acces ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_acces definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_acces;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_acces (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_tronc_acces_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_acces_idx ON m_mobilite_douce.lt_mob_tronc_acces USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_acces IS 'Liste des types d''accessibilité des aménagements par type de véhicule à deux roues non motorisé';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_acces.code IS 'Code des types d''accessibilité des aménagements par type de véhicule à deux roues non motorisé';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_acces.valeur IS 'Libellé des types d''accessibilité des aménagements par type de véhicule à deux roues non motorisé';




INSERT INTO m_mobilite_douce.lt_mob_tronc_acces(
            code, valeur
            VALUES
  ('00','Non renseigné'),
  ('10','Roller'),
  ('20','Vélo de route'),
  ('30','VTC'),
  ('40','VTT'),
  ('ZZ','Non cocnerné')
  ;
 
 
 -- ################################################################# lt_mob_tronc_ame ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_ame definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_ame;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_ame (
	code varchar(2) NOT NULL, 
	valeur varchar(80) NULL, 
	CONSTRAINT lt_mob_tronc_ame_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_ame_idx ON m_mobilite_douce.lt_mob_tronc_ame USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_ame IS 'Liste des types d''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_ame.code IS 'Code des types d''aménagement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_ame.valeur IS 'Libellé des types d''aménagement';



INSERT INTO m_mobilite_douce.lt_mob_tronc_ame(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Piste cyclable'),
  ('20','Bande cyclable'),
  ('21','Bande piétonne'),
  ('31','Double sens cyclable piste'),
  ('32','Double sens cyclable bande'),
  ('33','Double sens cyclable non matérialisé'),
  ('40','Voie verte'),
  ('50','Vélo rue'),
  ('60','Couloir bus+vélo'),
  ('71','Rampe'),
  ('72','Goulotte'),
  ('73','Trottoir élargi'),
  ('81','Aménagement mixte piéton vélo hors voie verte'),
  ('82','Chaussée à voie centrale banalisée (CVCB)'),
  ('83','Accotement revêtu hors CVCB'),
  ('84','Chaussée réservée temporairement'),
  ('85','Jalonnement'),
  ('90','Aucun (route, chemin, ...)'),
  ('99','Autre site propre'),
  ('ZZ','Non concerné')
  ;
 
 
 -- ################################################################# lt_mob_tronc_regime ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_regime definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_regime;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_regime (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_tronc_regime_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_regime_idx ON m_mobilite_douce.lt_mob_tronc_regime USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_regime IS 'Régime présent sur la voie';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_regime.code IS 'Code du régime présent sur la voie';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_regime.valeur IS 'Libellé du du régime présent sur la voie';



INSERT INTO m_mobilite_douce.lt_mob_tronc_regime(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Zone 30'),
  ('20','Aire piétonne'),
  ('30','Zone de rencontre'),
  ('40','En agglomération'),
  ('50','Hors agglomération'),
  ('99','Autre'),
  ('ZZ','Non concerné')
  ;
 
 -- ################################################################# lt_mob_tronc_sens ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_sens definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_sens;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_sens (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_tronc_sens_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_sens_idx ON m_mobilite_douce.lt_mob_tronc_sens USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_sens IS 'Sens de circulation de l''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_sens.code IS 'Code du sens de circulation de l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_sens.valeur IS 'Libellé du sens de circulation de l''aménagement';



INSERT INTO m_mobilite_douce.lt_mob_tronc_sens(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Unidirectionnel'),
  ('20','Bidirectionnel'),
  ('ZZ','Non concerné')
 ;
 
-- ################################################################# lt_mob_tronc_local ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_local definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_local;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_local (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_tronc_local_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_local_idx ON m_mobilite_douce.lt_mob_tronc_local USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_local IS 'Localisation de l''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_local.code IS 'Code de localisation de l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_local.valeur IS 'Libellé de localisation de l''aménagement';



INSERT INTO m_mobilite_douce.lt_mob_tronc_local(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Trottoir'),
  ('11','Parking'),
  ('20','Chaussée'),
  ('30','Intermédiaire'),
  ('40','Chemin'),
  ('41','Chemin balisé'),
  ('42','Chemin non balisé'),
  ('51','Passerelle'),
  ('52','Escalier'),
  ('ZZ','Non concerné')
 ;
 
-- ################################################################# lt_mob_tronc_revet ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_revet definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_revet;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_revet (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_tronc_revet_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_revet_idx ON m_mobilite_douce.lt_mob_tronc_revet USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_revet IS 'Niveau de qualité du revêtement de l''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_revet.code IS 'Code du niveau de qualité du revêtement de l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_revet.valeur IS 'Libellé du niveau de qualité du revêtement de l''aménagement';



INSERT INTO m_mobilite_douce.lt_mob_tronc_revet(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Lisse'),
  ('20','Rugueux'),
  ('30','Meuble'),
  ('ZZ','Non concerné')
 ;

-- ################################################################# lt_mob_tronc_typ ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_typ definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_typ;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_typ (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_tronc_typ_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_typ_idx ON m_mobilite_douce.lt_mob_tronc_typ USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_typ IS 'Type de tronçon';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_typ.code IS 'Code du type de tronçon';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_typ.valeur IS 'Libellé du type de tronçon';


INSERT INTO m_mobilite_douce.lt_mob_tronc_typ(
            code, valeur)
    VALUES
  ('10','Cyclable'),
  ('20','Piéton')
 ;


-- ################################################################# lt_mob_rep_typrep ###############################################
 
-- m_mobilite_douce.lt_mob_rep_typrep definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_rep_typrep;

CREATE TABLE m_mobilite_douce.lt_mob_rep_typrep (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_rep_typrep_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_rep_typrep_idx ON m_mobilite_douce.lt_mob_rep_typrep USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_rep_typrep IS 'Type de repère';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_rep_typrep.code IS 'Code du type de repère';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_rep_typrep.valeur IS 'Libellé du type de repère';



INSERT INTO m_mobilite_douce.lt_mob_rep_typrep(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Début/fin d''itinéraire'),
  ('20','Intersection d''itinéraire'),
  ('30','Bifurcation'),
  ('40','Accès POI'),
  ('50','Compteur'),
  ('60','Passage délicat'),
  ('70','Carrefour ou passage protégé'),
  ('80','SAS Vélo'),
  ('99','Autre')
 ;

-- ################################################################# lt_mob_rep_usarep ###############################################
 
-- m_mobilite_douce.lt_mob_rep_usarep definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_rep_usarep;

CREATE TABLE m_mobilite_douce.lt_mob_rep_usarep (
	code varchar(2) NOT NULL, 
	valeur varchar(40) NULL, 
	CONSTRAINT lt_mob_rep_usarep_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_rep_usarep_idx ON m_mobilite_douce.lt_mob_rep_usarep USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_rep_usarep IS 'Type de repère';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_rep_usarep.code IS 'Code du type de repère';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_rep_usarep.valeur IS 'Libellé du type de repère';



INSERT INTO m_mobilite_douce.lt_mob_rep_usarep(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Cyclable'),
  ('20','Piéton'),
  ('30','Cyclable et piéton')
 ;

-- ################################################################# lt_mob_pan_typpan ###############################################
 
-- m_mobilite_douce.lt_mob_pan_typpan definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_pan_typpan;

CREATE TABLE m_mobilite_douce.lt_mob_pan_typpan (
	code varchar(2) NOT NULL,
	typsign varchar(2) NOT NULL,
	typpan varchar(80) NULL, 
	CONSTRAINT lt_mob_pan_typpan_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_pan_typpan_idx ON m_mobilite_douce.lt_mob_pan_typpan USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_pan_typpan IS 'Type de panneau';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_typpan.code IS 'Code du type de panneau';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_typpan.typsign IS 'Code du type de signalétique';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_typpan.typpan IS 'Libellé du type de panneau';



INSERT INTO m_mobilite_douce.lt_mob_pan_typpan(
            code, typsign, typpan)
    VALUES
  ('00','00','Non renseigné'),
  ('10','10','Danger (type A)'),
  ('20','10','Intersection et priorité (type AB)'),
  ('30','10','Interdiction, obligation, stationnement, ... (type B)'),
  ('40','10','Indication (type C)'),
  ('50','10','Service (type CE)'),
  ('60','10','Panonceau (type M)'),
  ('71','20','Directionnel/Balisage (cyclable)'),
  ('72','30','Directionnel/Balisage (randonnée)'),
  ('80','10','Localisation (type E, EB))'),
  ('90','10','Signalisation lumineuse (type R)')
 ;

-- ################################################################# lt_mob_pan_codepan ###############################################
 
-- m_mobilite_douce.lt_mob_pan_codepan definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_pan_codepan;

CREATE TABLE m_mobilite_douce.lt_mob_pan_codepan (
	code varchar(50) NOT NULL, 
	typpan varchar(2) NOT NULL,
	url varchar(255) NULL, 
	CONSTRAINT lt_mob_pan_codepan_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_pan_codepan_idx ON m_mobilite_douce.lt_mob_pan_codepan USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_pan_codepan IS 'Code officiel du panneau';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_codepan.code IS 'Code officiel du panneau';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_codepan.typpan IS 'Type de panneau (code liste lt_mob_pan_typpan)';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_codepan.url IS 'URL d''accès au symbole du panneau';



-- ################################################################# lt_mob_pan_typsign ###############################################
 
-- m_mobilite_douce.lt_mob_pan_typsign definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_pan_typsign;

CREATE TABLE m_mobilite_douce.lt_mob_pan_typsign (
	code varchar(2) NOT NULL, 
	valeur varchar(80) NOT NULL,
	CONSTRAINT lt_mob_pan_typsign_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_pan_typsign_idx ON m_mobilite_douce.lt_mob_pan_typsign USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_pan_typsign IS 'Liste des types de signalétique';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_typsign.code IS 'Code du type de signalétique';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_pan_typsign.valeur IS 'Type de signalétique';



INSERT INTO m_mobilite_douce.lt_mob_pan_typsign(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Signalétique routière'),
  ('20','Signalétique directionnelle cyclable'),
  ('30','Signalétique directionnelle de randonnées');

-- ################################################################# lt_mob_iti_usage ###############################################
 
-- m_mobilite_douce.lt_mob_iti_usage definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_iti_usage;

CREATE TABLE m_mobilite_douce.lt_mob_iti_usage (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_iti_usage_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_iti_usage_idx ON m_mobilite_douce.lt_mob_iti_usage USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_iti_usage IS 'Usages des itinéraires cyclables';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_usage.code IS 'Code des usages des itinéraires cyclables';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_usage.valeur IS 'Valeur des usages des itinéraires cyclables';


INSERT INTO m_mobilite_douce.lt_mob_iti_usage(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Utilitaire'),
  ('20','Touristique'),
  ('30','Utilitaire et touristique')
 ;

-- ################################################################# lt_mob_iti_pratrand ###############################################
 
-- m_mobilite_douce.lt_mob_iti_pratrand definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_iti_pratrand;

CREATE TABLE m_mobilite_douce.lt_mob_iti_pratrand (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_iti_pratrand_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_iti_pratrand_idx ON m_mobilite_douce.lt_mob_iti_pratrand USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_iti_pratrand IS 'Pratiques des itinéraires de randonnées';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_pratrand.code IS 'Code des pratiques des itinéraires de randonnées';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_pratrand.valeur IS 'Valeur des pratiques des itinéraires de randonnées';



INSERT INTO m_mobilite_douce.lt_mob_iti_pratrand(
            code, valeur)
    VALUES
  ('10','Pédestre'),
  ('20','Trail'),
  ('31','VTT'),
  ('32','Cyclo'),
  ('40','Gravel'),
  ('50','Accessible à tous'),
  ('99','Autre')
 ;

-- ################################################################# lt_mob_iti_typrand ###############################################
 
-- m_mobilite_douce.lt_mob_iti_typrand definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_iti_typrand;

CREATE TABLE m_mobilite_douce.lt_mob_iti_typrand (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_iti_typrand_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_iti_typrand_idx ON m_mobilite_douce.lt_mob_iti_typrand USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_iti_typrand IS 'Type des itinéraires de randonnées';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_typrand.code IS 'Code des types des itinéraires de randonnées';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_typrand.valeur IS 'Valeur des types des itinéraires de randonnées';



INSERT INTO m_mobilite_douce.lt_mob_iti_typrand(
            code, valeur)
    VALUES
  ('00','Non renseigné'),    
  ('10','Aller-Retour'),
  ('20','Boucle'),
  ('30','Aller Simple'),
  ('40','Itinérance'),
  ('50','Etape')
  ;

 -- ################################################################# lt_mob_iti_typparc ###############################################
 
-- m_mobilite_douce.lt_mob_iti_typparc definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_iti_typparc;

CREATE TABLE m_mobilite_douce.lt_mob_iti_typparc (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_iti_typparc_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_iti_typparc_idx ON m_mobilite_douce.lt_mob_iti_typparc USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_iti_typparc IS 'Type de parcours de randonnées';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_typparc.code IS 'Code des types de parcours de randonnées';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_iti_typparc.valeur IS 'Valeur des types de parcours de randonnées';



INSERT INTO m_mobilite_douce.lt_mob_iti_typparc(
            code, valeur)
    VALUES
  ('00','Non renseigné'),    
  ('10','Parcours d''interprétation'),
  ('20','Chemin de randonnée'),
  ('99','Autre')
  ;
 -- ################################################################# lt_mob_plan_usage ###############################################
 
-- m_mobilite_douce.lt_mob_plan_usage definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_plan_usage;

CREATE TABLE m_mobilite_douce.lt_mob_plan_usage (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_plan_usage_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_plan_usage_idx ON m_mobilite_douce.lt_mob_plan_usage USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_plan_usage IS 'Mobilités douces concernées par le plan';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_plan_usage.code IS 'Code des mobilités douces concernées par le plan';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_plan_usage.valeur IS 'Valeur des mobilités douces concernées par le plan';



INSERT INTO m_mobilite_douce.lt_mob_plan_usage(
            code, valeur)
    VALUES
  ('10','Cyclable'),
  ('20','Piétonne'),
  ('30','Cyclable/Piétonne'),
  ('99','Autre')
  ;

 -- ################################################################# lt_mob_plan_niveau ###############################################
 
-- m_mobilite_douce.lt_mob_plan_niveau definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_plan_niveau;

CREATE TABLE m_mobilite_douce.lt_mob_plan_niveau (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_plan_niveau_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_plan_niveau_idx ON m_mobilite_douce.lt_mob_plan_niveau USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_plan_niveau IS 'Niveau administratif du schéma dans lequel sont inscrits les itinéraires';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_plan_niveau.code IS 'Code du niveau administratif du schéma dans lequel sont inscrits les itinéraires';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_plan_niveau.valeur IS 'Valeur du niveau administratif du schéma dans lequel sont inscrits les itinéraires';



INSERT INTO m_mobilite_douce.lt_mob_plan_niveau(
            code, valeur)
    VALUES
  ('10','Européen'),
  ('20','National'),
  ('30','Régional'),
  ('40','Départemental'),
  ('50','Intercommunal'),
  ('60','Communal')
  ;
 
 -- ################################################################# lt_mob_media_typdoc ###############################################
 
-- m_mobilite_douce.lt_mob_media_typdoc definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_media_typdoc;

CREATE TABLE m_mobilite_douce.lt_mob_media_typdoc (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_media_typdoc_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_media_typdoc_idx ON m_mobilite_douce.lt_mob_media_typdoc USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_media_typdoc IS 'Type de documents joints';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_media_typdoc.code IS 'Code du type de documents joints';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_media_typdoc.valeur IS 'Valeur du type de documents joints';



INSERT INTO m_mobilite_douce.lt_mob_media_typdoc(
            code, valeur)
    VALUES
  ('00','Non renseigné'),
  ('10','Photographie'),
  ('20','Plan de travaux'),
  ('30','Plan d''aménagement (schéma directeur, ...)'),
  ('40','Présentation'),
  ('41','Fiche projet'),
  ('50','Arrêté de classement'),
  ('60','Concention de gestion'),
  ('99','Autre')
  ;
 
   -- ################################################################# lt_mob_tronc_dg ###############################################
 
-- m_mobilite_douce.lt_mob_tronc_dg definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lt_mob_tronc_dg;

CREATE TABLE m_mobilite_douce.lt_mob_tronc_dg (
	code varchar(2) NOT NULL, 
	valeur varchar(255) NULL, 
	CONSTRAINT lt_mob_tronc_dg_pkey PRIMARY KEY (code)
);
CREATE INDEX lt_mob_tronc_dg_idx ON m_mobilite_douce.lt_mob_tronc_dg USING btree (code);
COMMENT ON TABLE m_mobilite_douce.lt_mob_tronc_dg IS 'Position de l''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_dg.code IS 'Code de la position de l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.lt_mob_tronc_dg.valeur IS 'Valeur de la position de l''aménagement';



INSERT INTO m_mobilite_douce.lt_mob_tronc_dg(
            code, valeur)
    VALUES
  ('11','A droite (par défaut si ne jouxte pas de voirie de circulation)'),
  ('12','A gauche'),
  ('20','A droite et à gauche')
  ;
 
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# Séquence sur TABLE geo_mob_statio_cycl_seq ###############################################

-- m_mobilite_douce.geo_mob_statio_cycl_seq definition

-- DROP SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq;

CREATE SEQUENCE m_mobilite_douce.geo_mob_statio_cycl_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE an_mob_statio_cylc_media_seq ###############################################

-- m_mobilite_douce.an_mob_statio_cylc_media_seq definition

-- DROP SEQUENCE m_mobilite_douce.an_mob_statio_cylc_media_seq;

CREATE SEQUENCE m_mobilite_douce.an_mob_statio_cylc_media_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE geo_mob_troncon ###############################################

-- m_mobilite_douce.geo_mob_troncon_seq definition

-- DROP SEQUENCE m_mobilite_douce.geo_mob_troncon_seq;

CREATE SEQUENCE m_mobilite_douce.geo_mob_troncon_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE geo_mob_repere_seq ###############################################

-- m_mobilite_douce.geo_mob_repere_seq definition

-- DROP SEQUENCE m_mobilite_douce.geo_mob_repere_seq;

CREATE SEQUENCE m_mobilite_douce.geo_mob_repere_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE geo_mob_pan_seq ###############################################

-- m_mobilite_douce.geo_mob_sup_seq definition

-- DROP SEQUENCE m_mobilite_douce.geo_mob_pan_seq;

CREATE SEQUENCE m_mobilite_douce.geo_mob_pan_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE an_mob_media_seq ###############################################

-- m_mobilite_douce.an_mob_media_seq definition

-- DROP SEQUENCE m_mobilite_douce.an_mob_media_seq;

CREATE SEQUENCE m_mobilite_douce.an_mob_media_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE an_mob_pan_media_seq ###############################################

-- m_mobilite_douce.an_mob_pan_media_seq definition

-- DROP SEQUENCE m_mobilite_douce.an_mob_pan_media_seq;

CREATE SEQUENCE m_mobilite_douce.an_mob_pan_media_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE an_mob_log_seq ###############################################

-- m_mobilite_douce.an_mob_log_seq definition

-- DROP SEQUENCE m_mobilite_douce.an_mob_log_seq;

CREATE SEQUENCE m_mobilite_douce.an_mob_log_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;



-- ################################################################# Séquence sur TABLE lk_mob_tronc_iti_seq ###############################################

-- m_mobilite_douce.lk_mob_tronc_iti_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_tronc_iti_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_tronc_iti_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE lk_mob_iti_plan_seq ###############################################

-- m_mobilite_douce.lk_mob_iti_plan_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_iti_plan_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_iti_plan_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE lk_mob_droit_delegue_iti_seq ###############################################

-- m_mobilite_douce.lk_mob_droit_delegue_iti_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_droit_delegue_iti_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_droit_delegue_iti_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;




-- ################################################################# Séquence sur TABLE lk_mob_rep_troncon_seq ###############################################

-- m_mobilite_douce.lk_mob_rep_troncon_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_rep_troncon_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_rep_troncon_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;

-- ################################################################# Séquence sur TABLE lk_mob_rep_iti_seq ###############################################

-- m_mobilite_douce.lk_mob_rep_iti_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_rep_iti_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_rep_iti_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE lk_mob_itirand_com_seq ###############################################

-- m_mobilite_douce.lk_mob_itirand_com_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_itirand_com_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_itirand_com_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE an_mob_pn_seq ###############################################

-- m_mobilite_douce.an_mob_pn_seq definition

-- DROP SEQUENCE m_mobilite_douce.an_mob_pn_seq;

CREATE SEQUENCE m_mobilite_douce.an_mob_pn_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;




-- ################################################################# Séquence sur TABLE geo_mob_sign_id_seq ###############################################

-- m_signalement.geo_mob_sign_id_seq definition

-- DROP SEQUENCE m_signalement.geo_mob_sign_id_seq;

CREATE SEQUENCE m_signalement.geo_mob_sign_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;

-- ################################################################# Séquence sur TABLE lk_mob_itirand_sign_seq ###############################################

-- m_mobilite_douce.lk_mob_itirand_sign_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_itirand_sign_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_itirand_sign_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE lk_mob_iticycl_sign_seq ###############################################

-- m_mobilite_douce.lk_mob_iticycl_sign_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_iticycl_sign_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_iticycl_sign_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE lk_mob_pan_iti_seq ###############################################

-- m_mobilite_douce.lk_mob_pan_iti_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_pan_iti_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_pan_iti_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;


-- ################################################################# Séquence sur TABLE lk_mob_tronc_iti_decoupe_seq ###############################################

-- m_mobilite_douce.lk_mob_tronc_iti_decoupe_seq definition

-- DROP SEQUENCE m_mobilite_douce.lk_mob_tronc_iti_decoupe_seq;

CREATE SEQUENCE m_mobilite_douce.lk_mob_tronc_iti_decoupe_seq
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


-- ################################################################# TABLE geo_mob_statio_cycl ###############################################

-- m_mobilite_douce.geo_mob_statio_cycl

-- Drop table

-- DROP TABLE m_mobilite_douce.geo_mob_statio_cycl;

CREATE TABLE m_mobilite_douce.geo_mob_statio_cycl (
	id_statio text not null DEFAULT 'SC' || nextval('m_mobilite_douce.geo_mob_statio_cycl_seq'::regclass),
	id_adresse int8,
	id_voie int8,
	complt_adr varchar(500),
	dbetat varchar(2) not null DEFAULT '40'::character varying,
	dbstatut varchar(2) not null DEFAULT '10'::character varying,
	etat_mob varchar(2) not null DEFAULT '10'::character varying,
	cap int2 not null default 0,
	cap_cargo int2,
	typ_accro varchar(2) not null default '00',
	mobil varchar(2) not null default '00',
	mobil_p varchar(50),
	acces varchar(2) not null default '00',
	gratuit varchar(2) not null default '00',
	protect varchar(2) not null default '00',
	couvert varchar(1) not null default '0',
	surv varchar(1)not null default '0',
	lum varchar(1) not null default '0',
	url text,
	an_pose integer,
	proprio varchar(2) NOT NULL DEFAULT '00',
	gestio text NOT NULL DEFAULT '00',
	proprio_a text,
	gestio_a text,
	src_geom varchar(100) not null default '21',
	src_annee varchar(4) not null default '2021' ,
	observ varchar(1000),
	epci varchar(5) not null,
	insee varchar(5) not null,
	commune varchar(80) not null,
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
	x_l93 numeric(9, 2) not null,
	y_l93 numeric(10, 2) not null,
	geom geometry(point, 2154) not NULL,
	CONSTRAINT "geo_mob_statio_cycl_pkey" PRIMARY KEY (id_statio)
);
CREATE INDEX "geo_mob_statio_cycl_idx" ON m_mobilite_douce.geo_mob_statio_cycl USING gist (geom);
COMMENT ON TABLE m_mobilite_douce.geo_mob_statio_cycl IS 'Classe d''objet géographique localisant un ensemble cohérent d''équipements de stationnement cyclable';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.id_statio IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.id_adresse IS 'Identifiant de l''adresse';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.id_voie IS 'Identifiant de la voie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.complt_adr IS 'Complément d''adresse';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.dbetat IS 'Niveau d''avancement de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.dbstatut IS 'Statut de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.etat_mob IS 'Etat physique de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.cap IS 'Nombre de places de stationnement disponibles sur l''emplacement y compris les places adaptées à des vélos spéciaux';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.cap_cargo IS 'Nombre de places de stationnement disponibles pour les vélos de grande taille';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.typ_accro IS 'Mode d''accrochage possible du vélo aux équipements de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.mobil IS 'Type de mobilier de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.mobil_p IS 'Précision sur le type de mobilier de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.acces IS 'Mode d''accès à l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.gratuit IS 'L''usage de l''équipement de stationnement est-il gratuit ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.protect IS 'Protection du stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.couvert IS 'Le stationnement est-il couvert et est donc protégé de la pluie, de la neige et de la grêle ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.surv IS 'Le stationnement est-il surveillé par un gardien ou par de la vidéosurveillance ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.lum IS ' L''emplacement est-il éclairé la nuit (par de l''éclairage urbain ou dédié à l''emplacement) ?';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.url IS 'Site web d''information';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.an_pose IS 'Année de mise en service du stationnement vélo';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.proprio IS 'Nom de l''organisation d''entretien de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.gestio IS 'Nom de l''aménageur de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.proprio_a IS 'Autre organisation d''entretien de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.gestioè_a IS 'Autre aménageur de l''emplacement de stationnement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.src_geom IS 'Référentiel géographique de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.src_annee IS 'Année du référentiel de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.epci IS 'EPCI d''assise de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.insee IS 'Code Insee  de la commune d''implantation de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.commune IS 'Commune d''implantation de l''équipement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.dbupdate IS 'Date de mise à jour dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.x_l93 IS 'Coordonnées X en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_statio_cycl.geom IS 'Classe d''objets géométrique';


  
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_gratuit_fkey FOREIGN KEY (gratuit)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_couvert_fkey FOREIGN KEY (couvert)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_surv_fkey FOREIGN KEY (surv)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_lum_fkey FOREIGN KEY (lum)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_dbetat_fkey FOREIGN KEY (dbetat)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;         
       
       
ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_etat_mob_fkey FOREIGN KEY (etat_mob)
        REFERENCES m_mobilite_douce.lt_mob_etat (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;    

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_typ_accro_fkey FOREIGN KEY (typ_accro)
        REFERENCES m_mobilite_douce.lt_mob_statio_typ_accro (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_mobil_fkey FOREIGN KEY (mobil)
        REFERENCES m_mobilite_douce.lt_mob_statio_mobil (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_acces_fkey FOREIGN KEY (acces)
        REFERENCES m_mobilite_douce.lt_mob_statio_acces (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_protect_fkey FOREIGN KEY (protect)
        REFERENCES m_mobilite_douce.lt_mob_statio_protect (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;      
       

ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_proprio_fkey FOREIGN KEY (proprio)
        REFERENCES r_objet.lt_gestio_proprio (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

       ALTER TABLE m_mobilite_douce.geo_mob_statio_cycl
    ADD CONSTRAINT lt_mob_statio_gestio_fkey FOREIGN KEY (gestio)
        REFERENCES r_objet.lt_gestio_proprio (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;   

       
-- ################################################################# TABLE geo_mob_troncon ###############################################

       
-- m_mobilite_douce.geo_mob_troncon

-- Drop table

-- DROP TABLE m_mobilite_douce.geo_mob_troncon;
       
CREATE TABLE m_mobilite_douce.geo_mob_troncon (
    id_tronc text DEFAULT 'TC' || nextval('m_mobilite_douce.geo_mob_troncon_seq'::regclass) NOT NULL,
    typ_mob character varying(2) NOT NULL DEFAULT '10',
    typ_res character varying(2) NOT NULL DEFAULT '00',
    acces_ame character varying(2) NOT NULL DEFAULT '00',
    trafic_vit integer,
    lum character varying(1) NOT NULL DEFAULT '0',
    dbstatut character varying(2) NOT NULL DEFAULT '10',
    posi_dg character varying(2) NOT NULL DEFAULT '10',
    ame_d character varying(2) NOT NULL,
    dbetat_d character varying(2) NOT NULL DEFAULT '00',
    an_prog_d integer,
    d_service_d integer,
    regime_d character varying(2) NOT NULL DEFAULT '00',
    sens_d character varying(2) NOT NULL default '00',
    largeur_d double precision,
    local_d character varying(2) NOT NULL DEFAULT '00',
    revet_d character varying(2) NOT NULL DEFAULT '00',
    lin_d integer NOT NULL,
    cout_d integer,
    subv_d integer,    
    com_g boolean DEFAULT 'true',
    mame_g boolean DEFAULT 'true',
    ame_g character varying(2) NOT NULL,
    dbetat_g character varying(2) NOT NULL DEFAULT '00',
    an_prog_g integer,
    d_service_g integer,
    regime_g character varying(2) NOT NULL DEFAULT '00',
    sens_g character varying(2) NOT NULL default '00',
    largeur_g double precision,
    local_g character varying(2) NOT NULL DEFAULT '00',
    revet_g character varying(2) NOT NULL DEFAULT '00',
    lin_g integer NOT NULL,
    cout_g integer,
    subv_g integer,    
    proprio_d text NOT NULL DEFAULT '00',
    gestio_d text NOT NULL DEFAULT '00',
    proprio_g text NOT NULL DEFAULT '00',
    gestio_g text NOT NULL DEFAULT '00',
    proprio_a_d text,
    gestio_a_d text,
    proprio_a_g text,
    gestio_a_g text,
    requal_g bool DEFAULT false NOT NULL, -- Attribut permettant de de signaler une requalification de l'aménagement de gauche existant
	requal_d bool DEFAULT false NOT NULL, -- Attribut permettant de de signaler une requalification de l'aménagement de droite existant
	reqame_g varchar(2) DEFAULT 'ZZ'::character varying NOT NULL, -- Nouvel aménagement projeté à gauche après requalification
	reqame_d varchar(2) DEFAULT 'ZZ'::character varying NOT NULL, -- Nouvel aménagement projeté à droite après requalification
	reqam_dbetat_g varchar(2) DEFAULT 'ZZ'::character varying NOT NULL, -- Etat d'avancement du nouvel aménagement projeté à gauche après requalification
	reqam_dbetat_d varchar(2) DEFAULT 'ZZ'::character varying NOT NULL, -- Etat d'avancement du nouvel aménagement projeté à gauche après requalification
    conv_d character varying(1) NOT NULL DEFAULT 'f',
    conv_g character varying(1) NOT NULL DEFAULT 'f',
	src_geom character varying(2) NOT NULL DEFAULT '21',
	src_annee varchar(4) NOT NULL DEFAULT '2021' ,
	observ varchar(1000),
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
    insee_d character varying(5) NOT NULL,
	commune_d character varying(80) NOT NULL,
	epci_d character varying(5) NOT NULL,
	insee_g character varying(5),
	commune_g character varying(80),
	epci_g character varying(5),
	epci character varying(5),
	geom public.geometry(MultiLineString,2154),
	
CONSTRAINT "geo_mob_troncon_pkey" PRIMARY KEY (id_tronc)
);
CREATE INDEX "geo_mob_troncon_idx" ON m_mobilite_douce.geo_mob_troncon USING gist (geom);

COMMENT ON TABLE m_mobilite_douce.geo_mob_troncon IS 'Classe d''objet géographique localisant un tronçon d''aménagement cyclable/piéton unique';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.id_tronc IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.typ_mob IS 'Type de mobilité douce';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.typ_res IS 'Type de réseau structurant local auquel appartient l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.acces_ame IS 'Accessibilité des aménagements par type de véhicule à deux roues non motorisé (hiérarchisation, si ROLLER, les autres possibles)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.trafic_vit IS 'Vitesse maximale autorisée pour le trafic adjacent à l''aménagement, en km/h. La vitesse 5 km/h correspond à une vitesse à l''allure du pas';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.lum IS 'Présence d''éclairage';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.posi_dg IS 'Indique les informations à remplir selon que l''aménagement est à droite à gauche ou les deux';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.dbstatut IS 'Statut de l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.ame_d IS 'Type d''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.dbetat_d IS 'Etat d''avancement (Niveau de réalisation) de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.an_prog_d IS 'Année de programmation de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.d_service_d IS 'Année de mise en service de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.regime_d IS 'Régime présent sur la voie de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.sens_d IS 'Sens de circulation de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.largeur_d IS 'Largeur de l''aménagement de droite (en mètre)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.local_d IS 'Localisation de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.revet_d IS 'Niveau de qualité du revêtement de l''aménagement de droite qualifié par rapport à la pratique du vélo';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.lin_d IS 'Linéaire en mètre du tronçon de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.cout_d IS 'Coût en euro HT de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.subv_d IS 'Subvention reçu en euro HT de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.com_g IS 'Information sur le fait que la commune de gauche soit la même que la commune de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.mame_g IS 'Information sur le fait que l''aménagement de gauche soit la même que l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.ame_g IS 'Type d''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.dbetat_g IS 'Etat d''avancement (Niveau de réalisation) de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.an_prog_g IS 'Année de programmation de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.d_service_g IS 'Année de mise en service de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.regime_g IS 'Régime présent sur la voie de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.sens_g IS 'Sens de circulation de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.largeur_g IS 'Largeur de l''aménagement de gauche (en mètre)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.local_g IS 'Localisation de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.revet_g IS 'Niveau de qualité du revêtement de l''aménagement de gauche qualifié par rapport à la pratique du vélo';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.lin_g IS 'Linéaire en mètre du tronçon de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.cout_g IS 'Coût en euro HT de l''aménagement de gauche (attribut plus utilisé à l''échelle du tronçon)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.subv_g IS 'Subvention reçu en euro HT de l''aménagement de gauche (attribut plus utilisé à l''échelle du tronçon)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.proprio_d IS 'Nom de l''organisme d''entretien de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.proprio_g IS 'Nom de l''organisme d''entretien de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.gestio_d IS 'Nom de l''aménageur de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.gestio_g IS 'Nom de l''aménageur de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.proprio_a_d IS 'Autre organisme d''entretien de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.proprio_a_g IS 'Autre organisme d''entretien de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.gestio_a_d IS 'Autre aménageur de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.gestio_a_g IS 'Autre aménageur de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.conv_d IS 'Tronçon de l''aménagement de droite sous convention de gestion';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.conv_g IS 'Tronçon de l''aménagement de gauche sous convention de gestion';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.observ IS 'Commentaires divers';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.src_geom IS 'Code du référentiel géographique utilisé pour la saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.src_annee IS 'Année du référentiel géographique';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.op_sai IS 'Opérateur de la saisie de la donnée';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.op_maj IS 'Opérateur de la dernière mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.dbinsert IS 'date de saisie de la donnée';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.dbupdate IS 'date de mise à jour de la donnée';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.insee_d IS 'Libellé de la commune de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.commune_d IS 'Libellé de la commune de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.insee_g IS 'Libellé de la commune de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.commune_g IS 'Libellé de la commune de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.epci_d IS 'EPCI d''assise de l''aménagement de droite';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.epci_g IS 'EPCI d''assise de l''aménagement de gauche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.epci IS 'EPCI de saisie de l''aménagement';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.geom IS 'Géométrie des objets saisis';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.requal_g IS 'Attribut permettant de de signaler une requalification de l''aménagement de gauche existant';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.requal_d IS 'Attribut permettant de de signaler une requalification de l''aménagement de droite existant';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.reqame_g IS 'Nouvel aménagement projeté à gauche après requalification';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.reqame_d IS 'Nouvel aménagement projeté à droite après requalification';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.reqam_dbetat_g IS 'Etat d''avancement du nouvel aménagement projeté à gauche après requalification';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_troncon.reqam_dbetat_d IS 'Etat d''avancement du nouvel aménagement projeté à gauche après requalification';


       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_res_fkey FOREIGN KEY (typ_res)
        REFERENCES m_mobilite_douce.lt_mob_tronc_res (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;   

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_typ_fkey FOREIGN KEY (typ_mob)
        REFERENCES m_mobilite_douce.lt_mob_tronc_typ (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT _fkey FOREIGN KEY (acces_ame)
        REFERENCES m_mobilite_douce. (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_lum_fkey FOREIGN KEY (lum)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
    
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_ame_d_fkey FOREIGN KEY (ame_d)
        REFERENCES m_mobilite_douce.lt_mob_tronc_ame (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;      
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_ame_g_fkey FOREIGN KEY (ame_g)
        REFERENCES m_mobilite_douce.lt_mob_tronc_ame (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;       
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_dbetat_d_fkey FOREIGN KEY (dbetat_d)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;   

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_dbetat_g_fkey FOREIGN KEY (dbetat_g)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION;                 
      
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_regime_d_fkey FOREIGN KEY (regime_d)
        REFERENCES m_mobilite_douce.lt_mob_tronc_regime (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_regime_g_fkey FOREIGN KEY (regime_g)
        REFERENCES m_mobilite_douce.lt_mob_tronc_regime (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;       
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_sens_d_fkey FOREIGN KEY (sens_d)
        REFERENCES m_mobilite_douce.lt_mob_tronc_sens (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_sens_g_fkey FOREIGN KEY (sens_g)
        REFERENCES m_mobilite_douce.lt_mob_tronc_sens (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;    
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_local_d_fkey FOREIGN KEY (local_d)
        REFERENCES m_mobilite_douce.lt_mob_tronc_local (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;   

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_local_g_fkey FOREIGN KEY (local_g)
        REFERENCES m_mobilite_douce.lt_mob_tronc_local (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        
 
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_revet_d_fkey FOREIGN KEY (revet_d)
        REFERENCES m_mobilite_douce.lt_mob_tronc_revet (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_revet_g_fkey FOREIGN KEY (revet_g)
        REFERENCES m_mobilite_douce.lt_mob_tronc_revet (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_posi_dg_fkey FOREIGN KEY (posi_dg)
        REFERENCES m_mobilite_douce.lt_mob_tronc_dg (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_conv_d_fkey FOREIGN KEY (conv_d)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_conv_g_fkey FOREIGN KEY (conv_g)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;          

ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_src_geom_fkey FOREIGN KEY (src_geom)
        REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;    
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_etat_avancement_dbetat_g_requal_fkey FOREIGN KEY (reqam_dbetat_g)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_etat_avancement_dbetat_d_requal_fkey FOREIGN KEY (reqam_dbetat_d)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_ame_d_requal_fkey FOREIGN KEY (reqame_d)
        REFERENCES m_mobilite_douce.lt_mob_tronc_ame (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
ALTER TABLE m_mobilite_douce.geo_mob_troncon
    ADD CONSTRAINT lt_mob_tronc_ame_g_requal_fkey FOREIGN KEY (reqame_g)
        REFERENCES m_mobilite_douce.lt_mob_tronc_ame (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       

       
-- ################################################################# TABLE geo_mob_repere ###############################################

-- m_mobilite_douce.geo_mob_repere

-- Drop table

-- DROP TABLE m_mobilite_douce.geo_mob_repere;

CREATE TABLE m_mobilite_douce.geo_mob_repere (
	id_rep text not null DEFAULT 'RC' || nextval('m_mobilite_douce.geo_mob_repere_seq'::regclass),
	libelle varchar(255),
	typ_rep varchar(2) not null DEFAULT '00'::character varying,
	typ_rep_a varchar(255),
    num_compt text,
    url_compt text,
	usa_rep varchar(2) not null DEFAULT '00'::character varying,
	dbetat varchar(2) not null DEFAULT '40'::character varying,
	dbstatut varchar(2) not null DEFAULT '10'::character varying,
	gestio text NOT NULL DEFAULT '00',
	proprio text NOT NULL DEFAULT '00',
	gestio_a text,
	proprio_a text,	
	observ varchar(1000),
	epci varchar(5) not null,
	insee varchar(5) not null,
	commune varchar(80) not null,
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
	x_l93 numeric(9, 2) not null,
	y_l93 numeric(10, 2) not null,
	geom geometry(point, 2154) not NULL,
	CONSTRAINT "geo_mob_repere_pkey" PRIMARY KEY (id_rep)
);
CREATE INDEX "geo_mob_repere_idx" ON m_mobilite_douce.geo_mob_repere USING gist (geom);
COMMENT ON TABLE m_mobilite_douce.geo_mob_repere IS 'Classe d''objet géographique localisant les rèpères sur les tronçons d''aménagement';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.id_rep IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.libelle IS 'Numéro, nom ou description utilisé comme désignation du point de repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.typ_rep IS 'Type de repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.typ_rep_a IS 'Autre type de repère (si typ_rep = autre)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.num_compt IS 'N° du compteur (si typ_rep = compteur)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.url_compt IS 'URL d''accès aux statistiques du compteur (lien externe) (si typ_rep = compteur)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.usa_rep IS 'Usage principal du repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.dbstatut IS 'Statut du repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.dbetat IS 'Etat d''avancement (Niveau de réalisation) du repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.gestio IS 'Aménageur';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.proprio IS 'Organisme d''entretien';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.gestio_a IS 'Autre aménageur';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.proprio_a IS 'Autre organisme d''entretien';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.epci IS 'EPCI d''assise du repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.insee IS 'Code Insee  de la commune d''implantation du repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.commune IS 'Commune d''implantation du repère';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.dbupdate IS 'Date de mise à jour dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.x_l93 IS 'Coordonnées X en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_repere.geom IS 'Classe d''objets géométrique';


  
       
ALTER TABLE m_mobilite_douce.geo_mob_repere
    ADD CONSTRAINT lt_mob_rep_typrep_fkey FOREIGN KEY (typ_rep)
        REFERENCES m_mobilite_douce.lt_mob_rep_typrep (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

 ALTER TABLE m_mobilite_douce.geo_mob_repere
    ADD CONSTRAINT lt_mob_rep_usarep_fkey FOREIGN KEY (usa_rep)
        REFERENCES m_mobilite_douce.lt_mob_rep_usarep (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;
       
ALTER TABLE m_mobilite_douce.geo_mob_repere
    ADD CONSTRAINT lt_mob_rep_dbetat_fkey FOREIGN KEY (dbetat)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.geo_mob_repere
    ADD CONSTRAINT lt_mob_rep_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION;        

-- ################################################################# TABLE geo_mob_pan ###############################################

-- m_mobilite_douce.geo_mob_pan

-- Drop table

-- DROP TABLE m_mobilite_douce.geo_mob_pan;

CREATE TABLE m_mobilite_douce.geo_mob_pan (
	id_pan text not null DEFAULT 'P' || nextval('m_mobilite_douce.geo_mob_pan_seq'::regclass),
	id_tronc text, --not null,
	typ_sign varchar(2) not null DEFAULT '00'::character varying,
	typ_pan varchar(2) not null DEFAULT '00'::character varying,
	code_pan varchar(50) not null DEFAULT '00'::character varying,
	etat_mob varchar(2) not null DEFAULT '00'::character varying,
	an_pose integer,    
	azimuth integer,
    rattach text,
    dbetat varchar(2) not null DEFAULT '40'::character varying,
	dbstatut varchar(2) not null DEFAULT '10'::character varying,
    proprio text NOT NULL DEFAULT '00',
    gestio text NOT NULL DEFAULT '00',
	proprio_a text,
    gestio_a text,    
	observ varchar(1000),
	src_geom character varying(2) NOT NULL DEFAULT '21',
	src_annee varchar(4) NOT NULL DEFAULT '2021' ,
	insee character varying(5) NOT NULL,
	commune character varying(80) NOT NULL,
	epci character varying(5) NOT NULL,
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
	x_l93 numeric(9,2) NOT NULL,
	y_l93 numeric(10,2) NOT NULL,
	geom public.geometry(point,2154),
	CONSTRAINT "geo_mob_pan_pkey" PRIMARY KEY (id_pan)
);
CREATE INDEX "geo_mob_sup_idx" ON m_mobilite_douce.geo_mob_pan USING gist (geom);
COMMENT ON TABLE m_mobilite_douce.geo_mob_pan IS 'Classe d''objet décrivant les panneaux routiers, directionnel cyclable et de randonnées';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.id_pan IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.id_tronc IS 'Identifiant du tronçon le plus proche';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.typ_pan IS 'Type de panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.code_pan IS 'Code officiel du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.typ_sign IS 'Type de signalisation';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.etat_mob IS 'Etat du support';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.azimuth IS 'Angle en degrés entre la direction du panneau dans son axe de lecture et le nord. Indique la direction vers laquelle l''information portée par le panneau s''applique.';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.rattach IS 'Référence le tronçon de route sur lequel s''applique la directive inscrite sur le panneau.';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.an_pose IS 'Année de pose';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.dbstatut IS 'Statut du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.dbetat IS 'Etat d''avancement (Niveau de réalisation) du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.proprio IS 'Nom de l''organisme d''entretien du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.gestio IS 'Nom de l''aménageur du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.proprio_a IS 'Autre organisme d''entretien du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.gestio_a IS 'Autre aménageur du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.src_geom IS 'Code du référentiel géographique utilisé pour la saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.src_annee IS 'Année du référentiel géographique';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.epci IS 'EPCI d''assise du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.insee IS 'Code Insee  de la commune d''implantation du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.commune IS 'Commune d''implantation du panneau';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.dbupdate IS 'Date de mise à jour dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.x_l93 IS 'Coordonnées X en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.y_l93 IS 'Coordonnées Y en Lambert 93';
COMMENT ON COLUMN m_mobilite_douce.geo_mob_pan.geom IS 'Classe d''objets géométrique';



ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_typsign_fkey FOREIGN KEY (typ_sign)
        REFERENCES m_mobilite_douce.lt_mob_pan_typsign (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 

ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_etat_fkey FOREIGN KEY (etat_mob)
        REFERENCES m_mobilite_douce.lt_mob_etat (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
      
       
ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_srcgeom_fkey FOREIGN KEY (src_geom)
        REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;         

ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_typpan_fkey FOREIGN KEY (typ_pan)
        REFERENCES m_mobilite_douce.lt_mob_pan_typpan (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_codepan_fkey FOREIGN KEY (code_pan)
        REFERENCES m_mobilite_douce.lt_mob_pan_codepan (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;     
       
ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_dbetat_fkey FOREIGN KEY (dbetat)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.geo_mob_pan
    ADD CONSTRAINT lt_mob_pan_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
       ON UPDATE NO ACTION ON DELETE NO ACTION;        

-- ################################################################# TABLE geo_mob_sign ###############################################       
       
-- m_signalement.geo_mob_sign definition

-- Drop table

-- DROP TABLE m_signalement.geo_mob_sign;

CREATE TABLE m_signalement.geo_mob_sign (
	id_sign int4 DEFAULT nextval('m_signalement.geo_mob_sign_id_seq'::regclass) NOT NULL, -- Identifiant interne
	type_int text, -- Type d'intervention
	lieu_prec text,
	date_sign date,
	traite character varying(1) not null DEFAULT '1',
	observ character varying(1000) NULL, -- Observations diverses, description du signalement
	insee character varying(5) NULL, -- Code insee de la commune
	commune character varying(80) NULL, -- Libellé de la commune
	epci character varying(5) not null,
	x_l93 numeric(8, 2) NULL, -- Coordonnées X en lambert 93
	y_l93 numeric(9, 2) NULL, -- Coordonnées Y en lambert 93
	dbinsert timestamp without time zone NULL, -- Date de saisie
	dbupdate timestamp without time zone NULL, -- Date de mise à jour
	op_sai character varying(254) NULL, -- Personne ou profil de connexion ayant saisie le signalement
	op_maj character varying(80) NULL, -- Opérateur de mise à jour
	geom public.geometry(point, 2154) NULL, -- Géométrie des objets
	CONSTRAINT geo_mob_sign_pkey PRIMARY KEY (id_sign)
	);
	
CREATE INDEX geo_mob_sign_geom_idx ON m_signalement.geo_mob_sign USING gist (geom);
COMMENT ON TABLE m_signalement.geo_mob_sign IS 'Table géopgraphique contenant les signalements sur la base des mobilités douces';

-- Column comments

COMMENT ON COLUMN m_signalement.geo_mob_sign.id_sign IS 'Identifiant interne';
COMMENT ON COLUMN m_signalement.geo_mob_sign.insee IS 'Code insee de la commune';
COMMENT ON COLUMN m_signalement.geo_mob_sign.commune IS 'Libellé de la commune';
COMMENT ON COLUMN m_signalement.geo_mob_sign.type_int IS 'Type d''intervention';
COMMENT ON COLUMN m_signalement.geo_mob_sign.lieu_prec IS 'Précision du lieu';
COMMENT ON COLUMN m_signalement.geo_mob_sign.traite IS 'Traitement de la demande';
COMMENT ON COLUMN m_signalement.geo_mob_sign.date_sign IS 'Date du signalement';
COMMENT ON COLUMN m_signalement.geo_mob_sign.observ IS 'Observations diverses, description du signalement';
COMMENT ON COLUMN m_signalement.geo_mob_sign.op_sai IS 'Personne ou profil de connexion ayant saisie le signalement';
COMMENT ON COLUMN m_signalement.geo_mob_sign.x_l93 IS 'Coordonnées X en lambert 93';
COMMENT ON COLUMN m_signalement.geo_mob_sign.y_l93 IS 'Coordonnées Y en lambert 93';
COMMENT ON COLUMN m_signalement.geo_mob_sign.dbinsert IS 'Date de saisie';
COMMENT ON COLUMN m_signalement.geo_mob_sign.dbupdate IS 'Date de mise à jour';
COMMENT ON COLUMN m_signalement.geo_mob_sign.geom IS 'Géométrie des objets';
COMMENT ON COLUMN m_signalement.geo_mob_sign.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_signalement.geo_mob_sign.epci IS 'EPCI';


ALTER TABLE m_signalement.geo_mob_sign
    ADD CONSTRAINT lt_mob_sign_traite_fkey FOREIGN KEY (traite)
        REFERENCES m_signalement.lt_traite_sig (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 

-- ################################################################# TABLE an_mob_pn ###############################################

-- m_mobilite_douce.an_mob_pn

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_pn;

CREATE TABLE m_mobilite_douce.an_mob_pn (
	id_pn text not null DEFAULT 'PN' || nextval('m_mobilite_douce.an_mob_pn_seq'::regclass) || '_',
	id_pan text NOT NULL,
	code_pn CHARACTER varying(5) NOT NULL DEFAULT '00',
	inscrip_pn text,
	etat_mob CHARACTER varying(2) NOT NULL DEFAULT '00',
	an_pose integer,
	observ varchar(1000),
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
		CONSTRAINT "an_mob_pn_pkey" PRIMARY KEY (id_pn)
);
COMMENT ON TABLE m_mobilite_douce.an_mob_pn IS 'Classe d''objet attributaire des pannonceaux associés au panneau de la signalisation routière';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.id_pn IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.id_pan IS 'Identifiant unique interne du panneau de signalisation routière';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.code_pn IS 'Code officiel du pannonceau';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.inscrip_pn IS 'Inscription sur le pannonceau';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.etat_mob IS 'Etat du pannonceau';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.an_pose IS 'Année de pose du pannonceau si différent du panneau';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pn.dbupdate IS 'Date de mise à jour dans la base de données';


ALTER TABLE m_mobilite_douce.an_mob_pn
    ADD CONSTRAINT lt_mob_etat_mob_fkey FOREIGN KEY (etat_mob)
        REFERENCES m_mobilite_douce.lt_mob_etat (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
ALTER TABLE m_mobilite_douce.an_mob_pn
    ADD CONSTRAINT lt_mob_pan_codepn_fkey FOREIGN KEY (code_pn)
        REFERENCES m_mobilite_douce.lt_mob_pan_codepan (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;       

-- ################################################################# TABLE an_mob_iti_cycl ###############################################

-- m_mobilite_douce.an_mob_iti_cycl

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_iti_cycl;

CREATE TABLE m_mobilite_douce.an_mob_iti_cycl (
	id_iticycl text not null DEFAULT uuid_generate_v4(),
	numero character varying(20),
	nomoff character varying(255),
	nomusage character varying(255),
	depart character varying(255),
	via character varying(255),
    arrivee character varying(255),
    dbetat character varying(2) NOT NULL DEFAULT '40',
    dbstatut character varying(2) NOT NULL DEFAULT '10',
    usa_iti character varying(2) NOT NULL DEFAULT '00',
    lieu_d text,
    instruc text,
    url character varying(255),
	d_prog integer,	
	d_service integer,
	p_long integer,
	p_ame text default '00',
	p_mao text default '00',
	p_coutm integer,
	p_cout int4,
	p_subv int4,
    gestio text NOT NULL DEFAULT '00',
    proprio text NOT NULL DEFAULT '00',
	gestio_a text,
    proprio_a text,    
    itivar boolean NOT NULL DEFAULT FALSE,
    id_itivar text,
    n_itivar character varying(255),
	observ varchar(1000),
	epci text,
	maj_geom bool DEFAULT false NULL, -- Attribut volatile permettant d'activer ou non la mise à jour de la géométrie dans la partie GdPublic
	maj_att bool DEFAULT false NULL, -- Attribut volatile permettant d'activer ou non la mise à jour des modifications attributaires dans la partie GdPublic
	sup_gdpublic bool DEFAULT false NULL, -- Attribut volatile permettant de supprimer un itinéraire dans la partie GdPublic
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
		CONSTRAINT "an_mob_iti_cycl_pkey" PRIMARY KEY (id_iticycl)
);
COMMENT ON TABLE m_mobilite_douce.an_mob_iti_cycl IS 'Classe d''objet attributaire des itinéraires cyclables';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.id_iticycl IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.numero IS 'Numérotation de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.nomoff IS 'Nom officiel de l''itinéraire, à défaut celui présent sur les document de communication';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.nomusage IS 'Autre nom ou appellation de l’itinéraire en usage';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.depart IS 'Nom de la localité située au départ de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.arrivee IS 'Nom de la localité située à l’arrivée de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.dbetat IS 'Etat d''avancement (Niveau d''avancement) de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.dbstatut IS 'Statut de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.usa_iti IS 'Usage principale de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.lieu_d IS 'Principaux lieux desservis';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.instruc IS 'Description détaillée (pas à pas) du tracé de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.url IS 'Référence du site internet faisant la promotion de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.d_prog IS 'Année de programmation de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.d_service IS 'Année d''ouverture de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.p_long IS 'Longueur prévisionnel';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.p_ame IS 'Aménagement prévisionnel';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.p_mao IS 'MAO du projet';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.p_coutm IS 'Coût estimatif au mètre linéaire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.p_cout IS 'Coût total du projet';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.p_subv IS 'Subvention reçue';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.gestio IS 'Nom de l''aménageur de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.proprio IS 'Nom de l''organisme d''entretien de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.gestio_a IS 'Autre aménageur de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.proprio_a IS 'Autre organisme d''entretien de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.itivar IS 'Variante d''un itinéraire maître';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.id_itivar IS 'Identifiant de l''itinéraire maître';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.n_itivar IS 'Libellé de la variante';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.epci IS 'EPCI d''assise de l''itinértaire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.maj_geom IS 'Attribut volatile permettant d''activer ou non la mise à jour de la géométrie dans la partie GdPublic';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.maj_att IS 'Attribut volatile permettant d''activer ou non la mise à jour des modifications attributaires dans la partie GdPublic';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.sup_gdpublic IS 'Attribut volatile permettant de supprimer un itinéraire dans la partie GdPublic';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_cycl.dbupdate IS 'Date de mise à jour dans la base de données';


ALTER TABLE m_mobilite_douce.an_mob_iti_cycl
    ADD CONSTRAINT lt_mob_iti_dbetat_fkey FOREIGN KEY (dbetat)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.an_mob_iti_cycl
    ADD CONSTRAINT lt_mob_iti_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            
       
       
ALTER TABLE m_mobilite_douce.an_mob_iti_cycl
    ADD CONSTRAINT lt_mob_iti_usage_fkey FOREIGN KEY (usa_iti)
        REFERENCES m_mobilite_douce.lt_mob_iti_usage (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;           

       
-- ################################################################# TABLE an_mob_iti_rand ###############################################

-- m_mobilite_douce.an_mob_iti_rand

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_iti_rand;

CREATE TABLE m_mobilite_douce.an_mob_iti_rand (
	id_itirand text not null DEFAULT uuid_generate_v4(),
	numero character varying(10),
	nomoff character varying(255) not null,
	nomusage character varying(255),
	prat_iti character varying(2) NOT NULL DEFAULT '10',
	typ_iti character varying(2) NOT NULL DEFAULT '00',
	typ_parc character varying(2) NOT NULL DEFAULT '00',
    dbetat character varying(2) NOT NULL DEFAULT '40',
    dbstatut character varying(2) NOT NULL DEFAULT '10',
	depart character varying(255),
    arrivee character varying(255),
    duree double PRECISION,
    balisage text,
    lin_iti double PRECISION,
    diff_iti text,
    alti_max integer,
    alti_min integer,
    deni_pos integer,
    deni_neg integer,
    instruc text,
    present_d text,
    present_c text,
    theme text,
    recommand text,
    accessi text,
    acces_r text,
    acces_tc text,
    park_inf text,
    park_loc text,
    typ_sol text,
    pdipr character varying(1) NOT NULL DEFAULT '0',
    pdipr_d date,
    contact character varying(255),
    url text,
   	p_cout int4,
	p_subv int4,
    gestio text NOT NULL DEFAULT '00',
    proprio text NOT NULL DEFAULT '00',
    gestio_a text,
    proprio_a text,
    observ varchar(1000),
	epci text not null,
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
		CONSTRAINT "an_mob_iti_rand_pkey" PRIMARY KEY (id_itirand)
);
COMMENT ON TABLE m_mobilite_douce.an_mob_iti_rand IS 'Classe d''objet attributaire des itinéraires de randonnées';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.id_itirand IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.id_uuid IS 'Identifiant unique sous la forme UUID V4';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.numero IS 'Numérotation de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.nomoff IS 'Nom officiel de l''itinéraire, à défaut celui présent sur les document de communication';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.nomusage IS 'Autre nom ou appellation de l’itinéraire en usage';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.prat_iti IS 'Pratique de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.typ_iti IS 'Type d''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.typ_parc IS 'Type de parcours';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.dbetat IS 'Etat d''avancement (Niveau d''avancement) de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.dbstatut IS 'Statut de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.depart IS 'Nom de la localité située au départ de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.arrivee IS 'Nom de la localité située à l’arrivée de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.duree IS 'Durée de l''itinéraire en heures';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.balisage IS 'Balisage(s) utilisé(s) sur l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.lin_iti IS 'Longueur de l''itinéraire (en mètres)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.diff_iti IS 'Difficulté de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.alti_max IS 'Altitude maximum de l''itinéraire (en mètres)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.alti_min IS 'Altitude minimum de l''itinéraire (en mètres)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.deni_pos IS 'Dénivelé positif de l''itinéraire (en mètres)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.deni_neg IS 'Dénivelé négatif de l''itinéraire (en mètres)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.instruc IS 'Description détaillée (pas à pas) du tracé de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.present_d IS 'Présentation détaillée de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.present_c IS 'Présentation courte résumant l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.theme IS 'Thèmes ou mots-clefs caractérisant l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.recommand IS 'Recommandations sur l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.accessi IS 'Accessibilité de l''itinéraire à des publics particuliers';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.acces_r IS 'Informations sur les accès routiers';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.acces_tc IS 'Informations sur les accès en transports en commun';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.park_inf IS 'Informations sur le parking';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.park_loc IS 'Localisation du parking (coordonnées lat/long en JSON)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.typ_sol IS 'Types de sol sur lesquels se parcourt l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.pdipr IS 'Inscription au PDIPR';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.pdipr_d IS 'Date d''inscription au PDIPR';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.contact IS 'Email de contact de la structure publicatrice du jeu de données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.url IS 'URL de la fiche source de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.p_cout IS 'Coût total du projet';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.p_subv IS 'Subvention reçue';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.gestio IS 'Aménageur';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.proprio IS 'Entretien';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.gestio_a IS 'Autre Aménageur';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.proprio_a IS 'Autre organisme d''entretien';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.epci IS 'EPCI d''assise de l''itinértaire';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_iti_rand.dbupdate IS 'Date de mise à jour dans la base de données';


ALTER TABLE m_mobilite_douce.an_mob_iti_rand
    ADD CONSTRAINT lt_mob_iti_pratrand_fkey FOREIGN KEY (prat_iti)
        REFERENCES m_mobilite_douce.lt_mob_iti_pratrand (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.an_mob_iti_rand
    ADD CONSTRAINT lt_mob_iti_typrand_fkey FOREIGN KEY (typ_iti)
        REFERENCES m_mobilite_douce.lt_mob_iti_typrand (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;           

ALTER TABLE m_mobilite_douce.an_mob_iti_rand
    ADD CONSTRAINT lt_mob_iti_pdipr_fkey FOREIGN KEY (pdipr)
        REFERENCES r_objet.lt_booleen (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;  
       
ALTER TABLE m_mobilite_douce.an_mob_iti_rand
    ADD CONSTRAINT lt_mob_iti_typparc_fkey FOREIGN KEY (typ_parc)
        REFERENCES m_mobilite_douce.lt_mob_iti_typparc (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        
              
    
ALTER TABLE m_mobilite_douce.an_mob_iti_rand
    ADD CONSTRAINT lt_mob_iti_dbetat_fkey FOREIGN KEY (dbetat)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.an_mob_iti_rand
    ADD CONSTRAINT lt_mob_iti_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION; 
       
-- ################################################################# TABLE an_mob_plan ###############################################

-- m_mobilite_douce.an_mob_plan

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_plan;

CREATE TABLE m_mobilite_douce.an_mob_plan (
	id_plan text not null DEFAULT uuid_generate_v4(),
	libelle text,
	usa_plan character varying(2) NOT NULL,
	plan_niv character varying(2) NOT NULL,
	d_appro integer,
	url character varying(255),
	gestio text,
	dbetat character varying(2) NOT NULL DEFAULT '40',
    dbstatut character varying(2) NOT NULL DEFAULT '10',
    observ varchar(1000),
	epci varchar(5),
	op_sai varchar(50) not null,
	op_maj varchar(50),
	dbinsert timestamp without time zone DEFAULT now(),
	dbupdate timestamp without time zone,
		CONSTRAINT "an_mob_plan_pkey" PRIMARY KEY (id_plan)
);
COMMENT ON TABLE m_mobilite_douce.an_mob_plan IS 'Classe d''objet attributaire des plans de circulations douces';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.id_plan IS 'Identifiant unique interne';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.libelle IS 'Libellé du plan, du schéma d''aménagement';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.usa_plan IS 'Types de mobilités douces concernées par le plan';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.plan_niv IS 'Niveau administratif du schéma dans lequel sont inscrits les itinéraires';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.dbetat IS 'Etat d''avancement (Niveau d''avancement) du plan';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.dbstatut IS 'Statut du plan';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.gestio IS 'Aménageur';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.d_appro IS 'Année d''approbation';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.url IS 'Référence du site internet faisant référence au schéma, plan …';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.observ IS 'Commentaire(s)';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.epci IS 'EPCI du plan';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.op_maj IS 'Opérateur de mise à jour';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.dbinsert IS 'Date d''insertion dans la base de données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_plan.dbupdate IS 'Date de mise à jour dans la base de données';


ALTER TABLE m_mobilite_douce.an_mob_plan
    ADD CONSTRAINT lt_mob_plan_usa_fkey FOREIGN KEY (usa_plan)
        REFERENCES m_mobilite_douce.lt_mob_plan_usage (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.an_mob_plan
    ADD CONSTRAINT lt_mob_plan_niv_fkey FOREIGN KEY (plan_niv)
        REFERENCES m_mobilite_douce.lt_mob_plan_niveau (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;     
       
ALTER TABLE m_mobilite_douce.an_mob_plan
    ADD CONSTRAINT lt_mob_plan_dbetat_fkey FOREIGN KEY (dbetat)
        REFERENCES r_objet.lt_etat_avancement (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;            

ALTER TABLE m_mobilite_douce.an_mob_plan
    ADD CONSTRAINT lt_mob_plan_dbstatut_fkey FOREIGN KEY (dbstatut)
        REFERENCES r_objet.lt_statut (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        MEDIA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

              
-- ################################################################# TABLE an_mob_statio_cylc_media ###############################################

-- m_mobilite_douce.an_mob_statio_cylc_media definition

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_statio_cylc_media;

CREATE TABLE m_mobilite_douce.an_mob_statio_cylc_media (
	gid int4 DEFAULT nextval('m_mobilite_douce.an_mob_statio_cylc_media_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id text NULL, -- Identifiant unique du stationnement vélo
	media text NULL, -- Champ Média de GEO
	miniature bytea NULL, -- Champ miniature de GEO
	n_fichier text NULL, -- Nom du fichier
	t_fichier text NULL, -- Type de média dans GEO
	op_sai text NULL, -- opérateur intégrant le média
	dbinsert timestamp DEFAULT 'now'::text::date NULL,
	CONSTRAINT an_mob_statio_cylc_media_pkey PRIMARY KEY (gid)
);
CREATE INDEX an_mob_statio_cylc_media_gid_idx ON m_mobilite_douce.an_mob_statio_cylc_media USING btree (gid);
COMMENT ON TABLE m_mobilite_douce.an_mob_statio_cylc_media IS 'Table des médias pour les stationnements cyclables';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.gid IS 'Identifiant unique non signifiant';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.id IS 'Identifiant unique du stationnement vélo';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.op_sai IS 'opérateur intégrant le média';
COMMENT ON COLUMN m_mobilite_douce.an_mob_statio_cylc_media.dbinsert IS 'Date de saisie du média';


-- ################################################################# TABLE an_mob_media ###############################################

-- m_mobilite_douce.an_mob_media definition

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_media;

CREATE TABLE m_mobilite_douce.an_mob_media (
	gid int4 DEFAULT nextval('m_mobilite_douce.an_mob_media_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id text NULL, -- Identifiant unique du stationnement vélo
	media text NULL, -- Champ Média de GEO
	miniature bytea NULL, -- Champ miniature de GEO
	n_fichier text NULL, -- Nom du fichier
	t_fichier text NULL, -- Type de média dans GEO
	t_doc CHARACTER varying(2) NOT NULL DEFAULT '00',
	t_doc_p CHARACTER varying(255),
	op_sai text NULL, -- opérateur intégrant le média
	dbinsert timestamp DEFAULT 'now'::text::date NULL,
	CONSTRAINT an_mob_media_pkey PRIMARY KEY (gid)
);
CREATE INDEX an_mob_media_gid_idx ON m_mobilite_douce.an_mob_media USING btree (gid);
COMMENT ON TABLE m_mobilite_douce.an_mob_media IS 'Table des médias pour les plans, itinéraires cyclables et aménagements';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_media.gid IS 'Identifiant unique non signifiant';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.id IS 'Identifiant unique de l''objet vélo';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.t_doc IS 'Type de documents';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.t_doc_p IS 'Précisions sur le type de documents';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.op_sai IS 'opérateur intégrant le média';
COMMENT ON COLUMN m_mobilite_douce.an_mob_media.dbinsert IS 'Date de saisie du média';


ALTER TABLE m_mobilite_douce.an_mob_media
    ADD CONSTRAINT lt_mob_media_typdoc_fkey FOREIGN KEY (t_doc)
        REFERENCES m_mobilite_douce.lt_mob_media_typdoc (code) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION;        

-- ################################################################# TABLE an_mob_pan_media ###############################################

-- m_mobilite_douce.an_mob_pan_media definition

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_pan_media;

CREATE TABLE m_mobilite_douce.an_mob_pan_media (
	gid int4 DEFAULT nextval('m_mobilite_douce.an_mob_pan_media_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id text NULL, -- Identifiant unique du stationnement vélo
	media text NULL, -- Champ Média de GEO
	miniature bytea NULL, -- Champ miniature de GEO
	n_fichier text NULL, -- Nom du fichier
	t_fichier text NULL, -- Type de média dans GEO
	op_sai text NULL, -- opérateur intégrant le média
	dbinsert timestamp DEFAULT 'now'::text::date NULL,
	CONSTRAINT an_mob_pan_media_pkey PRIMARY KEY (gid)
);
CREATE INDEX an_mob_pan_media_gid_idx ON m_mobilite_douce.an_mob_pan_media USING btree (gid);
COMMENT ON TABLE m_mobilite_douce.an_mob_pan_media IS 'Table des médias pour les repères, panneaux routiers et directionnels';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.gid IS 'Identifiant unique non signifiant';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.id IS 'Identifiant unique du panneau';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.t_fichier IS 'Type de média dans GEO';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.op_sai IS 'opérateur intégrant le média';
COMMENT ON COLUMN m_mobilite_douce.an_mob_pan_media.dbinsert IS 'Date de saisie du média';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                 TABLE DE RELATION                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# TABLE lk_mob_tronc_iti ###############################################

-- m_mobilite_douce.lk_mob_tronc_iti definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_tronc_iti;

CREATE TABLE m_mobilite_douce.lk_mob_tronc_iti (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_tronc_iti_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_tronc text,
	id_iti text,
	CONSTRAINT lk_mob_tronc_iti_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_tronc_iti_id_idx ON m_mobilite_douce.lk_mob_tronc_iti USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_tronc_iti IS 'Table de relation entre les itinéraires et les tronçons';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_tronc_iti.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_tronc_iti.id_tronc IS 'Identifiant du tronçon';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_tronc_iti.id_iti IS 'Identifiant de l''itinéraire';

-- ################################################################# TABLE lk_mob_tronc_iti_decoupe ###############################################

-- m_mobilite_douce.lk_mob_tronc_iti_decoupe definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_tronc_iti_decoupe;

CREATE TABLE m_mobilite_douce.lk_mob_tronc_iti_decoupe (
	id int4 NOT NULL, -- Identifiant unique de la relation supprimé par un découpage de ligne
	id_tronc text NULL, -- Identifiant du tronçon supprimé par un découpage de ligne
	id_iti text NULL, -- Identifiant de l'itinéraire supprimé par un découpage de ligne
	CONSTRAINT lk_mob_tronc_iti_decoupe_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_tronc_iti_decoupe_idx ON m_mobilite_douce.lk_mob_tronc_iti_decoupe USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_tronc_iti_decoupe IS 'Table de relation entre les itinéraires et les tronçons suite à un découpe de ligne';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_tronc_iti_decoupe.id IS 'Identifiant unique de la relation supprimé par un découpage de ligne';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_tronc_iti_decoupe.id_tronc IS 'Identifiant du tronçon supprimé par un découpage de ligne';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_tronc_iti_decoupe.id_iti IS 'Identifiant de l''itinéraire supprimé par un découpage de ligne';


-- ################################################################# TABLE lk_mob_iti_plan ###############################################

-- m_mobilite_douce.lk_mob_iti_plan definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_iti_plan;

CREATE TABLE m_mobilite_douce.lk_mob_iti_plan (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_iti_plan_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_iti text,
	id_plan text,
	CONSTRAINT lk_mob_iti_plan_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_iti_plan_id_idx ON m_mobilite_douce.lk_mob_iti_plan USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_iti_plan IS 'Table de relation entre l''itnéraire et son plan de mise en oeuvre';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_iti_plan.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_iti_plan.id_iti IS 'Identifiant de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_iti_plan.id_plan IS 'Identifiant du plan';

-- ################################################################# TABLE lk_mob_droit_delegue_iti ###############################################

-- m_mobilite_douce.lk_mob_droit_delegue_iti definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_droit_delegue_iti;

CREATE TABLE m_mobilite_douce.lk_mob_droit_delegue_iti (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_droit_delegue_iti_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_iti text,
	epci_ad text,
	CONSTRAINT lk_mob_droit_delegue_iti_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_droit_delegue_iti_id_idx ON m_mobilite_douce.lk_mob_droit_delegue_iti USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_droit_delegue_iti IS 'Table de relation entre l''itnéraire et les EPCI ayant droit';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_droit_delegue_iti.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_droit_delegue_iti.id_iti IS 'Identifiant de l''itinéraire';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_droit_delegue_iti.epci_ad IS 'EPCI ayant un droit délégué';

-- ################################################################# TABLE lk_mob_rep_troncon ###############################################

-- m_mobilite_douce.lk_mob_rep_troncon definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_rep_troncon;

CREATE TABLE m_mobilite_douce.lk_mob_rep_troncon (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_rep_troncon_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_rep text,
	id_tronc text,
	CONSTRAINT lk_mob_rep_troncon_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_rep_troncon_id_idx ON m_mobilite_douce.lk_mob_rep_troncon USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_rep_troncon IS 'Table de relation entre les repères et les tronçons';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_rep_troncon.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_rep_troncon.id_rep IS 'Identifiant du repère cyclable';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_rep_troncon.id_tronc IS 'Identifiant du tronçon';


-- ################################################################# TABLE lk_mob_rep_iti ###############################################

-- m_mobilite_douce.lk_mob_rep_iti definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_rep_iti;

CREATE TABLE m_mobilite_douce.lk_mob_rep_iti (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_rep_iti_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_rep text,
	id_iti text,
	CONSTRAINT lk_mob_rep_iti_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_rep_iti_id_idx ON m_mobilite_douce.lk_mob_rep_iti USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_rep_iti IS 'Table de relation entre les repères et les itinéraires';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_rep_iti.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_rep_iti.id_rep IS 'Identifiant du repère cyclable';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_rep_iti.id_iti IS 'Identifiant de l''itinéraire';


-- ################################################################# TABLE lk_mob_pan_iti ###############################################

-- m_mobilite_douce.lk_mob_pan_iti definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_pan_iti;

CREATE TABLE m_mobilite_douce.lk_mob_pan_iti (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_pan text,
	id_iti text,
	CONSTRAINT lk_mob_pan_iti_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_pan_iti_id_idx ON m_mobilite_douce.lk_mob_pan_iti USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_pan_iti IS 'Table de relation entre les panneaux et les itinéraires';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_pan_iti.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_pan_iti.id_pan IS 'Identifiant du panneau';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_pan_iti.id_iti IS 'Identifiant de l''itinéraire';



-- ################################################################# TABLE lk_mob_itirand_com ###############################################

-- m_mobilite_douce.lk_mob_itirand_com definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_itirand_com;

CREATE TABLE m_mobilite_douce.lk_mob_itirand_com (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_itirand_com_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_itirand text,
	insee CHARACTER VARYING(5),
	CONSTRAINT lk_mob_itirand_com_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_itirand_com_id_idx ON m_mobilite_douce.lk_mob_itirand_com USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_itirand_com IS 'Table de relation permettant de lister les communes traversées par un itinéraire de randonnée';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_itirand_com.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_itirand_com.id_itirand IS 'Identifiant de l''itinéraire de randonnée';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_itirand_com.insee IS 'Code insee de la commune traversée';


-- ################################################################# TABLE lk_mob_itirand_sign ###############################################

-- m_mobilite_douce.lk_mob_itirand_sign definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_itirand_sign;

CREATE TABLE m_mobilite_douce.lk_mob_itirand_sign (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_itirand_sign_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_itirand text,
	id_sign int4,
	CONSTRAINT lk_mob_itirand_sign_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_itirand_sign_idx ON m_mobilite_douce.lk_mob_itirand_sign USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_itirand_sign IS 'Table de relation permettant un signalement à un itinéraire de randonnée';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_itirand_sign.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_itirand_sign.id_itirand IS 'Identifiant de l''itinéraire de randonnées';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_itirand_sign.id_sign IS 'Identifiant du signalement';


-- ################################################################# TABLE lk_mob_iticycl_sign ###############################################

-- m_mobilite_douce.lk_mob_iticycl_sign definition

-- Drop table

-- DROP TABLE m_mobilite_douce.lk_mob_iticycl_sign;

CREATE TABLE m_mobilite_douce.lk_mob_iticycl_sign (
	id int4 DEFAULT nextval('m_mobilite_douce.lk_mob_iticycl_sign_seq'::regclass) NOT NULL, -- Identifiant unique non signifiant
	id_iticycl text,
	id_sign int4,
	CONSTRAINT lk_mob_iticycl_sign_pkey PRIMARY KEY (id)
);
CREATE INDEX lk_mob_iticycl_sign_idx ON m_mobilite_douce.lk_mob_iticycl_sign USING btree (id);
COMMENT ON TABLE m_mobilite_douce.lk_mob_iticycl_sign IS 'Table de relation permettant un signalement à un itinéraire cyclable';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.lk_mob_iticycl_sign.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_iticycl_sign.id_iticycl IS 'Identifiant de l''itinéraire cyclable';
COMMENT ON COLUMN m_mobilite_douce.lk_mob_iticycl_sign.id_sign IS 'Identifiant du signalement';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     LOG                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# TABLE an_mob_log ###############################################


-- m_mobilite_douce.an_mob_log definition

-- Drop table

-- DROP TABLE m_mobilite_douce.an_mob_log;

CREATE TABLE m_mobilite_douce.an_mob_log (
	idlog int4 DEFAULT nextval('m_mobilite_douce.an_mob_log_seq'::regclass) NOT NULL, -- Identifiant unique
	tablename varchar(80) NOT NULL, -- Nom de la classe concernée par une opération
	type_ope text NOT NULL, -- Type d'opération
	dataold text NULL, -- Anciennes données
	datanew text NULL, -- Nouvelles données
	dbupdate timestamp DEFAULT now() NULL, -- Date d'exécution de l'opération
	CONSTRAINT an_mob_log_pkey PRIMARY KEY (idlog)
);
COMMENT ON TABLE m_mobilite_douce.an_mob_log IS 'Table des opérations effectuées sur les données modilités douces à l''insert, update et delete';

-- Column comments

COMMENT ON COLUMN m_mobilite_douce.an_mob_log.idlog IS 'Identifiant unique';
COMMENT ON COLUMN m_mobilite_douce.an_mob_log.tablename IS 'Nom de la classe concernée par une opération';
COMMENT ON COLUMN m_mobilite_douce.an_mob_log.type_ope IS 'Type d''opération';
COMMENT ON COLUMN m_mobilite_douce.an_mob_log.dataold IS 'Anciennes données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_log.datanew IS 'Nouvelles données';
COMMENT ON COLUMN m_mobilite_douce.an_mob_log.dbupdate IS 'Date d''exécution de l''opération';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     FONCTION                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- #################################################################### FONCTION/TRIGGER ft_m_controle_delete_plan_after ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_controle_delete_plan_after();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_controle_delete_plan_after()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

-- je supprime un plan après avoir sélectionner l'attribut Statut dans les métadonnées = supprimé, je supprime aussi les associations à un itinéraire
--IF (select count(*) from m_mobilite_douce.an_mob_plan where dbstatut = '12') >= 1 then
    --raise exception 'ok';
	---if old.dbstatut = '11' and new.dbstatut = '12' THEN
	--raise exception 'ok --> %', old.id_plan;
	raise exception 'ok --> %', old.id_plan;
	    if old.dbstatut = '11' then
	    raise exception 'ok --> %', old.id_plan;
		DELETE FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_plan = old.id_plan;	
		DELETE FROM m_mobilite_douce.an_mob_plan WHERE id_plan = old.id_plan;	
		end if;
	--end if;
--END IF;

return old;

END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_controle_delete_plan_after() IS 'Fonction trigger pour la suppression des plans des données';



-- #################################################################### FONCTION/TRIGGER ft_m_controle_saisie_iticycl ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_controle_saisie_iticycl();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_controle_saisie_iticycl()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


	
IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN	
     
	IF NEW.d_prog < 2000 OR NEW.d_prog > 2050 THEN 
		RAISE EXCEPTION '<font color="#FF0000"><b>L''année de programmation se semble pas cohérente (saisir une année entre 2000 et 2050). Se rapprocher du service SIG de l''Agglomération de Compiègne si besoin.</b></font><br><br>';
	END IF;

	IF NEW.d_service < 1980 OR NEW.d_service > 2050 THEN 
		RAISE EXCEPTION '<font color="#FF0000"><b>L''année de mise en service se semble pas cohérente (saisir une année entre 1980 et 2050). Se rapprocher du service SIG de l''Agglomération de Compiègne si besoin.</b></font><br><br>';
	END IF;

	-- si variante nomoffn depart, via et arrivée, lieu desservi et description, url doit être à null
	if new.itivar is true then
		new.nomoff := null;
		new.depart := null;
	    new.via := null;
	    new.arrivee := null;
	    new.lieu_d := null;
	    new.instruc := null;
	    new.url := null;
    end if;

	
    -- si variant et pas d'itinéraire maitre, erreur
   	if new.itivar is TRUE AND (new.id_itivar is null or trim(new.id_itivar) = '') then
   	    RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un itinéraire maître.</b></font><br><br>';
    END IF;
     -- si variant et pas de nom, erreur
   	if new.itivar is TRUE AND (new.n_itivar is null or trim(new.n_itivar) = '') then
    	RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un nom pour la variante.</b></font><br><br>';
    END IF;
  
	
	-- si pas une variante nomoff obligatoire
    if new.itivar is false and (new.nomoff is null or trim(new.nomoff) = '') then
    	RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un nom officiel de l''itinéraire.</b></font><br><br>';
    end if;

   
  -- gestionnaire à remplir
   if new.gestio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur.</b></font><br><br>';
   end if;
  
  -- entretien à remplir
   if new.proprio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un organisme d''entretien.</b></font><br><br>';
   end if;

   -- cohérence des cases à cocher multiple (si NR ou ZZ ou aucun pas autres choses)
   -- pour améangement
   if length(new.p_ame) <> 2 and (new.p_ame like '%00%' or new.p_ame like '%ZZ%') then 
   	    RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménagement.</b></font><br><br>';
   end if;
   
   -- pour MOA
   if length(new.p_mao) <> 2 and (new.p_mao like '%00%' or new.p_mao like '%ZZ%') then 
   	    RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre MAO.</b></font><br><br>';
   end if;
   -- pour gestionnaire
   if length(new.gestio) <> 2 and (new.gestio like '%00%' or new.gestio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur.</b></font><br><br>';
   end if;

   -- pour entretien
   if length(new.proprio) <> 2 and (new.proprio like '%00%' or new.proprio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien.</b></font><br><br>';
   end if;
	--raise exception 'ok';
	new.gestio_a := CASE WHEN new.gestio like '%99%' then new.gestio_a else null end;
	new.proprio_a := CASE WHEN new.proprio like '%99%' then new.proprio_a else null end;

  
IF (TG_OP = 'UPDATE') THEN

-- si passage de variante à pas variante
   if old.itivar is true and new.itivar is false then 
   	new.n_itivar := null;
    new.id_itivar := null;
   
    if new.nomoff is null or trim(new.nomoff) = '' then 
    	RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un nom officiel de l''itinéraire.</b></font><br><br>';
    end if;
   
   end if;

-- gestion des états et status si supprimer une première fois  
	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' THEN
		NEW.dbstatut = '10';
	END IF;
END IF;

  
end if;

IF (TG_OP = 'DELETE') THEN

	/*
  	IF (SELECT count(*) FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_iti = old.id_iticycl) >= 1 THEN

  		RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas supprimer l''itinéraire car il est associé à un plan.</b></font><br><br>';  	 	
		ELSE IF (SELECT count(*) FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = old.id_iticycl) >= 1 THEN
	
  			RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas supprimer l''itinéraire car il est associé à un aménagement.</b></font><br><br>';  	 	
		else
	return old;
	end if;
	end if;
  	

	DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = old.id_iticycl;
	DELETE FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = old.id_iticycl;
	*/
	/*
	UPDATE m_mobilite_douce.an_mob_iti_cycl SET dbstatut = '12', dbetat = 'ZZ' WHERE id_iticycl = OLD.id_iticycl;
	*/
	if old.dbstatut = '10' then
		UPDATE m_mobilite_douce.an_mob_iti_cycl SET dbstatut = '11' WHERE id_iticycl = OLD.id_iticycl AND OLD.dbstatut = '10';
	ELSE
		DELETE FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_iti = OLD.id_iticycl;
	    DELETE FROM m_mobilite_douce.lk_mob_iticycl_sign WHERE id_iticycl = OLD.id_iticycl;
	    DELETE FROM m_mobilite_douce.lk_mob_pan_iti WHERE id_iti = OLD.id_iticycl;
	    DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = OLD.id_iticycl;
	    DELETE FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = OLD.id_iticycl;
		return old;
	end if;

END IF;

return new;

END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_controle_saisie_iticycl() IS 'Fonction trigger contrôlant la saisie des itinéraires cyclables et assurant la cohérence des données';


-- #################################################################### FONCTION/TRIGGER ft_m_controle_saisie_itirand ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_controle_saisie_itirand();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_controle_saisie_itirand()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN	
     /*
    if (TG_OP = 'INSERT') then
    	new.id_uuid := uuid_generate_v4();
    end if;
*/
    if new.nomoff is null or trim(new.nomoff) = '' then 
    	RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un nom officiel de l''itinéraire.</b></font><br><br>';
    end if;
   
  
  -- gestionnaire à remplir
   if new.gestio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur.</b></font><br><br>';
   end if;

  -- proprio à remplir
   if new.proprio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un organisme d''entretien.</b></font><br><br>';
   end if;
  
  
   -- pour gestionnaire
   if length(new.gestio) <> 2 and (new.gestio like '%00%' or new.gestio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur.</b></font><br><br>';
   end if;

   -- pour entretien
   if length(new.proprio) <> 2 and (new.proprio like '%00%' or new.proprio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien.</b></font><br><br>';
   end if;

	new.gestio_a := CASE WHEN new.gestio like '%99%' then new.gestio_a else null end;
	new.proprio_a := CASE WHEN new.proprio like '%99%' then new.proprio_a else null end;

IF (TG_OP = 'UPDATE') THEN

-- gestion des états et status si supprimer une première fois
	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' THEN
		NEW.dbstatut = '10';
	END IF;
END IF;  
  
end if;

IF (TG_OP = 'DELETE') THEN
  	/*IF (SELECT count(*) FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_iti = old.id_itirand) >= 1 THEN
  		RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas supprimer l''itinéraire car il est associé à un plan.</b></font><br><br>';  	 	
	ELSE IF (SELECT count(*) FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = old.id_itirand) >= 1 THEN
  		RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas supprimer l''itinéraire car il est associé à un aménagement.</b></font><br><br>';  	 	
	else
	return old;
	end if;
	END IF;

	DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = old.id_itirand;
	DELETE FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = old.id_itirand;
	*/
	if old.dbstatut = '10' then
		UPDATE m_mobilite_douce.an_mob_iti_rand SET dbstatut = '11' WHERE id_itirand = OLD.id_itirand AND OLD.dbstatut = '10';
	ELSE
		DELETE FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_iti = OLD.id_itirand;
	    DELETE FROM m_mobilite_douce.lk_mob_itirand_sign WHERE id_itirand = OLD.id_itirand;
 	    DELETE FROM m_mobilite_douce.lk_mob_itirand_com WHERE id_itirand = OLD.id_itirand;
	    DELETE FROM m_mobilite_douce.lk_mob_pan_iti WHERE id_iti = OLD.id_itirand;
	    DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = OLD.id_itirand;
	    DELETE FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = OLD.id_itirand;
		return old;
	end if;


END IF;

return new;

END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_controle_saisie_itirand() IS 'Fonction trigger contrôlant la saisie des itinéraires de randonnées et assurant la cohérence des données';


-- #################################################################### FONCTION/TRIGGER ft_m_controle_saisie_plan ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_controle_saisie_plan();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_controle_saisie_plan()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN	
	
IF NEW.d_appro < 1980 OR NEW.d_appro > 2050 THEN 
	RAISE EXCEPTION '<font color="#FF0000"><b>L''année d''approbation du plan se semble pas cohérente (saisir une année entre 1980 et 2050). Se rapprocher du service SIG de l''Agglomération de Compiègne si besoin.</b></font><br><br>';
END IF;

	-- pour gestionnaire
   	if length(new.gestio) <> 2 and (new.gestio like '%00%' or new.gestio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur.</b></font><br><br>';
  	 end if;

IF (TG_OP = 'UPDATE') THEN

	-- pour gestionnaire
   	if length(new.gestio) <> 2 and (new.gestio like '%00%' or new.gestio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur.</b></font><br><br>';
  	 end if;

	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' THEN
		NEW.dbstatut = '10';
	END IF;
END IF;

end if;

IF (TG_OP = 'DELETE') THEN
  	/*IF (SELECT count(*) FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_plan = old.id_plan) >= 1 THEN
  		RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas supprimer un plan si des itinéraires y sont liés.</b></font><br><br>';  	 	
	else
	return old;
	end if;
	*/
    --raise exception 'table origine --> %', TG_NAME     ;
    if old.dbstatut = '10' then
		UPDATE m_mobilite_douce.an_mob_plan SET dbstatut = '11' WHERE id_plan = OLD.id_plan AND OLD.dbstatut = '10';
	ELSE
		DELETE FROM m_mobilite_douce.lk_mob_iti_plan WHERE id_plan = OLD.id_plan;
		return old;
	end if;
    

END IF;

return new;

END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_controle_saisie_plan() IS 'Fonction trigger contrôlant la saisie des plans et assurant la cohérence des données';


-- #################################################################### FONCTION/TRIGGER ft_m_moddouce_delegue ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_moddouce_delegue();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_moddouce_delegue()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


IF NEW.epci_ad IS NULL THEN
	RETURN OLD;
END IF;



RETURN NEW;

end;

$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_moddouce_delegue() IS 'Fonction gérant la non insertion d''valeur null dans les droit délégué';


-- #################################################################### FONCTION/TRIGGER ft_m_moddouce_droit_delegue_after ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_moddouce_droit_delegue_after();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_moddouce_droit_delegue_after()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN


DELETE FROM m_mobilite_douce.lk_mob_droit_delegue_iti WHERE epci_ad IS NULL;

return new;

END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_moddouce_droit_delegue_after() IS 'Fonction trigger la suppression d''un droit délégué';



-- #################################################################### FONCTION/TRIGGER ft_m_moddouce_log ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_moddouce_log();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_moddouce_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

DECLARE v_idlog integer;
DECLARE v_dataold text;
DECLARE v_datanew text;
DECLARE v_name_table character varying(254);

BEGIN

-- INSERT
IF (TG_OP = 'INSERT') THEN

  v_idlog := nextval('m_mobilite_douce.an_mob_log_seq'::regclass);
  v_datanew := ROW(NEW.*)::text; ------------------------------------ On concatène tous les attributs dans un seul

  ---
  INSERT INTO m_mobilite_douce.an_mob_log (idlog, tablename, type_ope, dataold, datanew, dbupdate)
  SELECT
  v_idlog,
  TG_TABLE_NAME,
  'INSERT',
  NULL,
  v_datanew,
  now();

  ---
  
  RETURN NEW;
  

-- UPDATE
ELSIF (TG_OP = 'UPDATE') THEN 
  ---
  
   v_idlog := nextval('m_mobilite_douce.an_mob_log_seq'::regclass);
  v_dataold := ROW(OLD.*)::text;------------------------------------ On concatène tous les anciens attributs dans un seul
  v_datanew := ROW(NEW.*)::text;------------------------------------ On concatène tous les nouveaux attributs dans un seul	
  v_name_table := TG_TABLE_NAME;

  ---
  
  INSERT INTO m_mobilite_douce.an_mob_log (idlog, tablename,  type_ope, dataold, datanew, dbupdate)
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
  ---
  
  v_idlog := nextval('m_mobilite_douce.an_mob_log_seq'::regclass);
  v_dataold := ROW(OLD.*)::text;------------------------------------ On concatène tous les anciens attributs dans un seul
  v_name_table := TG_TABLE_NAME;

  ---
  
  INSERT INTO m_mobilite_douce.an_mob_log (idlog, tablename,  type_ope, dataold, datanew, dbupdate)
  SELECT
  v_idlog,
  v_name_table,
  'DELETE',
  v_dataold,
  NULL,
  now();
  RETURN OLD;
  

END IF;

end;

$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_moddouce_log() IS 'Fonction gérant l''insertion d''une opération effectuée sur les données mobilités douces dans la table des logs';


-- #################################################################### FONCTION/TRIGGER ft_m_refresh_iti ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_refresh_iti();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_refresh_iti()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

--declare v_typ_rep text;

begin

IF (TG_OP = 'INSERT') then	

-- rafraichissement des vues matérialisées des tronçons par aménagement et état d'avancement
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa;

-- rafraichissement des vues matérialisées cyclables et des randonnées pour l'affichage dans le contexte de carte de GEO
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_cycl;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_rand;

END IF;

IF (TG_OP = 'DELETE') then	

-- rafraichissement des vues matérialisées des tronçons par aménagement et état d'avancement
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa;

-- rafraichissement des vues matérialisées cyclables et des randonnées pour l'affichage dans le contexte de carte de GEO
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_cycl;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_rand;

END IF;

IF (TG_OP = 'UPDATE') and (st_equals(new.geom,old.geom) is false
 OR new.ame_d <> old.ame_d OR new.ame_g <> old.ame_g or new.dbetat_d <> old.dbetat_d or new.dbetat_g <> old.dbetat_g or new.gestio_g <> old.gestio_g 
or new.gestio_d <> old.gestio_d or new.proprio_g <> old.proprio_g or new.proprio_d <> old.proprio_d or new.regime_d <> old.regime_d  or new.regime_g <> old.regime_g) then	

-- rafraichissement des vues matérialisées des tronçons par aménagement et état d'avancement
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa;

-- rafraichissement des vues matérialisées cyclables et des randonnées pour l'affichage dans le contexte de carte de GEO
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_cycl;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_rand;

END IF;

RETURN NEW;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_refresh_iti() IS 'Fonction gérant le rafraichissement des itinéraires pour l''affichage dans les contextes de carte de GEO';


-- #################################################################### FONCTION/TRIGGER ft_m_refresh_iti_lk ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_refresh_iti_lk();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_refresh_iti_lk()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

--declare v_typ_rep text;

begin



-- rafraichissement des vues matérialisées des tronçons par aménagement et état d'avancement
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa;

-- rafraichissement des vues matérialisées cyclables et des randonnées pour l'affichage dans le contexte de carte de GEO
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_cycl;
refresh materialized view m_mobilite_douce.xapps_geo_vmr_iti_rand;





RETURN NEW;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_refresh_iti_lk() IS 'Fonction gérant le rafraichissement des itinéraires pour l''affichage dans les contextes de carte de GEO à partir de la modification des tables de liens';



-- #################################################################### FONCTION/TRIGGER ft_m_refresh_planvelo ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_refresh_planvelo();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_refresh_planvelo()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$


BEGIN

	--raise exception 'reponse --> %', new.gestio || '-' || new.maj_att || '-' || new.maj_geom;
	-- si l'utilisateur a coché mise à jour de la geom, seule la géométrie de l'itinéraire sera mis à jour dans l'application gd public
	IF NEW.maj_geom IS TRUE AND NEW.maj_att IS FALSE THEN
		
		-- si projet arc
		if new.gestio = '04' then

		UPDATE m_mobilite_douce.geo_mob_iti_cycl_planvelo_arc_gdpublic set geom = (select geom from m_mobilite_douce.xapps_geo_vmr_iti_cycl where id_iticycl = new.id_iticycl)
		where id_iticycl = new.id_iticycl;
		
		DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_arc_gdpublic where id_iticycl = new.id_iticycl;
		INSERT INTO m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_arc_gdpublic (id_rep,libelle,geom,id_iticycl)
			SELECT
				r.idrep,
				r.libelle,
				r.geom,
				iti.id_iticycl
			FROM m_mobilite_douce.geo_mob_repere r
				JOIN m_mobilite_douce.lk_mob_rep_iti lk ON lk.id_rep = r.id_rep
				JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
			WHERE iti.id_iticycl = new.id_iticycl
			group by r.id_rep, iti.id_iticycl;
	

		end if;	
		-- si projet ville
		if new.gestio = '05' then

		UPDATE m_mobilite_douce.geo_mob_iti_cycl_planvelo_60159_gdpublic set geom = (select geom from m_mobilite_douce.xapps_geo_vmr_iti_cycl where id_iticycl = new.id_iticycl)
		where id_iticycl = new.id_iticycl;
		
		DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_60159_gdpublic where id_iticycl = new.id_iticycl;
		INSERT INTO m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_60159_gdpublic (id_rep,libelle,geom,id_iticycl)
			SELECT
				r.idrep,
				r.libelle,
				r.geom,
				iti.id_iticycl
			FROM m_mobilite_douce.geo_mob_repere r
				JOIN m_mobilite_douce.lk_mob_rep_iti lk ON lk.id_rep = r.id_rep
				JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
			WHERE iti.id_iticycl = new.id_iticycl
			group by r.id_rep, iti.id_iticycl;
	
		end if;	

		NEW.maj_geom := FALSE;
	
	END IF;

	-- si l'utilisateur a coché mise à jour attributaire et géométrie, l'itinéraire sera mis à jour dans l'application gd public
	IF NEW.maj_geom IS TRUE AND NEW.maj_att IS true THEN
	
		-- si projet arc
		if new.gestio = '04' then

		DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_planvelo_arc_gdpublic where id_iticycl = new.id_iticycl;
		INSERT INTO m_mobilite_douce.geo_mob_iti_cycl_planvelo_arc_gdpublic (id_iticycl,numero,nomoff,nomusage,depart,via,arrivee,dbetat,dbstatut,usa_iti,lieu_d,
		instruc,url,d_prog,d_service,p_long,p_ame,p_mao,p_coutm,p_cout,gestio,itivar,id_itivar,n_itivar,observ,epci,op_sai,op_maj,
		dbinsert,dbupdate,geom)
		SELECT
			iti.id_iticycl,iti.numero,iti.nomoff,iti.nomusage,iti.depart,iti.via,iti.arrivee,iti.dbetat,iti.dbstatut,iti.usa_iti,iti.lieu_d,
			iti.instruc,iti.url,iti.d_prog,iti.d_service,iti.p_long,iti.p_ame,iti.p_mao,iti.p_coutm,iti.p_cout,iti.gestio,iti.itivar,iti.id_itivar,
			iti.n_itivar,iti.observ,iti.epci,iti.op_sai,iti.op_maj,iti.dbinsert,iti.dbupdate,
			st_union(t.geom)
		FROM m_mobilite_douce.geo_mob_troncon t
			JOIN m_mobilite_douce.lk_mob_tronc_iti lk ON lk.id_tronc = t.id_tronc
			JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
			WHERE iti.id_iticycl = NEW.id_iticycl
		group by iti.id_iticycl; 	
	
	
		DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_arc_gdpublic where id_iticycl = new.id_iticycl;
		INSERT INTO m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_arc_gdpublic (id_rep,libelle,geom,id_iticycl)
			SELECT
				r.idrep,
				r.libelle,
				r.geom,
				iti.id_iticycl
			FROM m_mobilite_douce.geo_mob_repere r
				JOIN m_mobilite_douce.lk_mob_rep_iti lk ON lk.id_rep = r.id_rep
				JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
			WHERE iti.id_iticycl = new.id_iticycl
			group by r.id_rep, iti.id_iticycl;
	
		end if;	
		-- si projet ville
		if new.gestio = '05' then

		DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_60159_gdpublic where id_iticycl = new.id_iticycl;
		INSERT INTO m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_60159_gdpublic (id_iticycl,numero,nomoff,nomusage,depart,via,arrivee,dbetat,dbstatut,usa_iti,lieu_d,
		instruc,url,d_prog,d_service,p_long,p_ame,p_mao,p_coutm,p_cout,gestio,itivar,id_itivar,n_itivar,observ,epci,op_sai,op_maj,
		dbinsert,dbupdate,geom)
		SELECT
			iti.id_iticycl,iti.numero,iti.nomoff,iti.nomusage,iti.depart,iti.via,iti.arrivee,iti.dbetat,iti.dbstatut,iti.usa_iti,iti.lieu_d,
			iti.instruc,iti.url,iti.d_prog,iti.d_service,iti.p_long,iti.p_ame,iti.p_mao,iti.p_coutm,iti.p_cout,iti.gestio,iti.itivar,iti.id_itivar,
			iti.n_itivar,iti.observ,iti.epci,iti.op_sai,iti.op_maj,iti.dbinsert,iti.dbupdate,
			st_union(t.geom)
		FROM m_mobilite_douce.geo_mob_troncon t
			JOIN m_mobilite_douce.lk_mob_tronc_iti lk ON lk.id_tronc = t.id_tronc
			JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
			WHERE iti.id_iticycl = NEW.id_iticycl
		group by iti.id_iticycl;
		
		DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_60159_gdpublic where id_iticycl = new.id_iticycl;
		INSERT INTO m_mobilite_douce.geo_mob_iti_cycl_rep_planvelo_60159_gdpublic (id_rep,libelle,geom,id_iticycl)
			SELECT
				r.idrep,
				r.libelle,
				r.geom,
				iti.id_iticycl
			FROM m_mobilite_douce.geo_mob_repere r
				JOIN m_mobilite_douce.lk_mob_rep_iti lk ON lk.id_rep = r.id_rep
				JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
			WHERE iti.id_iticycl = new.id_iticycl
			group by r.id_rep, iti.id_iticycl;

		end if;	

		NEW.maj_geom := FALSE;
		NEW.maj_att := FALSE;
	
	END IF;

    -- si l'utilisateur a coché mise à jour attributaire, seuls les attributs de l'itinéraire seront mis à jour dans l'application gd public
	IF NEW.maj_geom IS false AND NEW.maj_att IS true THEN
	--raise exception 'ok';
	-- si projet arc
		if new.gestio = '04' then
		--raise exception 'reponse --> %', new.id_iticycl;
		UPDATE m_mobilite_douce.geo_mob_iti_cycl_planvelo_arc_gdpublic set 
			(numero,nomoff,nomusage,depart,via,arrivee,dbetat,dbstatut,usa_iti,lieu_d,instruc,url,d_prog,d_service,p_long,p_ame,p_mao,p_coutm,p_cout,gestio,itivar,id_itivar,
			n_itivar,observ,epci,op_sai,op_maj,dbinsert,dbupdate) = 
			(SELECT numero,nomoff,nomusage,depart,via,arrivee,dbetat,dbstatut,usa_iti,lieu_d,instruc,url,d_prog,d_service,
			p_long,p_ame,p_mao,p_coutm,p_cout,gestio,itivar,id_itivar,n_itivar,observ,epci,op_sai,op_maj,dbinsert,dbupdate 
			from m_mobilite_douce.an_mob_iti_cycl where id_iticycl = new.id_iticycl)
		where id_iticycl = new.id_iticycl;
		
		end if;	
		-- si projet ville
		if new.gestio = '05' then

		UPDATE m_mobilite_douce.geo_mob_iti_cycl_planvelo_60159_gdpublic set 
			(numero,nomoff,nomusage,depart,via,arrivee,dbetat,dbstatut,usa_iti,lieu_d,instruc,url,d_prog,d_service,p_long,p_ame,p_mao,p_coutm,p_cout,gestio,itivar,id_itivar,
			n_itivar,observ,epci,op_sai,op_maj,dbinsert,dbupdate) = 
			(SELECT numero,nomoff,nomusage,depart,via,arrivee,dbetat,dbstatut,usa_iti,lieu_d,instruc,url,d_prog,d_service,
			p_long,p_ame,p_mao,p_coutm,p_cout,gestio,itivar,id_itivar,n_itivar,observ,epci,op_sai,op_maj,dbinsert,dbupdate 
			from m_mobilite_douce.an_mob_iti_cycl where id_iticycl = new.id_iticycl)
		where id_iticycl = new.id_iticycl;
	
		end if;	

		NEW.maj_att := false;
	
	END IF;

	-- si l'utilisateur a coché cette case, l'itinéraire sera supprimé de l'application grand public
	IF NEW.sup_gdpublic IS true THEN

		IF NEW.gestio = '04' then
			DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_planvelo_arc_gdpublic WHERE id_iticycl = NEW.id_iticycl;
		END IF;
		IF NEW.gestio = '05' then
			DELETE FROM m_mobilite_douce.geo_mob_iti_cycl_planvelo_60159_gdpublic WHERE id_iticycl = NEW.id_iticycl;
		END IF;
	
		NEW.sup_gdpublic := FALSE;
	
	END IF;

return new;

END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_refresh_planvelo() IS 'Fonction trigger gérant la mise à jour de l''application Plan Vélo ARC';


-- #################################################################### FONCTION/TRIGGER ft_m_repere_controle ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_repere_controle();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_repere_controle()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

	
	
IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN

if (TG_OP = 'INSERT') then

NEW.insee := (select DISTINCT insee FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);
NEW.commune := (select DISTINCT commune FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);  

end if;

-- si mon repère n'est pas un début fin d'itinéraire je prends par défaut tous tronçons en association sinon je laisse l'utilisateur le faire
if new.typ_rep not in ('10','30') and new.dbstatut = '10' then

-- insertion d'au moins un identifiant de tronçon dans la table de relation tronçon-repère (les autres doivent l'être manuellement)
DELETE FROM m_mobilite_douce.lk_mob_rep_troncon WHERE id_rep = NEW.id_rep;
with req_insert as 
(
select distinct new.id_rep, t.id_tronc from m_mobilite_douce.geo_mob_troncon t
		where st_intersects(t.geom,st_buffer(NEW.geom,1)) is TRUE
		AND new.id_rep || '-' || t.id_tronc NOT IN (SELECT lk.id_rep || '-' || lk.id_tronc FROM m_mobilite_douce.lk_mob_rep_troncon lk)
)
insert into m_mobilite_douce.lk_mob_rep_troncon (id, id_rep, id_tronc)
select nextval('m_mobilite_douce.lk_mob_rep_troncon_seq'::regclass), i.id_rep, i.id_tronc from req_insert i;


-- si mon repère n'est pas un début fin d'itinéraire je prends par défaut tous les itinéraires en association sinon je laisse l'utilisateur le faire

-- insertion des relations repère-itinéraire
DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_rep = NEW.id_rep;
with req_insert as 
(
select distinct new.id_rep, iti.id_iti  from m_mobilite_douce.geo_mob_troncon t
	left join m_mobilite_douce.lk_mob_tronc_iti iti on iti.id_tronc = t.id_tronc
	where st_intersects(t.geom,st_buffer(NEW.geom,1)) is true
	AND new.id_rep || '-' || iti.id_iti NOT IN (SELECT lk.id_rep || '-' || lk.id_iti FROM m_mobilite_douce.lk_mob_rep_iti lk)
)
insert into m_mobilite_douce.lk_mob_rep_iti (id, id_rep, id_iti)
select nextval('m_mobilite_douce.lk_mob_rep_iti_seq'::regclass), i.id_rep, i.id_iti from req_insert i;

end if;

 -- gestionnaire à remplir
   if new.gestio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur.</b></font><br><br>';
   end if;
  
  -- entretien à remplir
   if new.proprio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un organisme d''entretien.</b></font><br><br>';
   end if;

  -- pour gestionnaire
   if length(new.gestio) <> 2 and (new.gestio like '%00%' or new.gestio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur.</b></font><br><br>';
   end if;

  -- pour entretien
   if length(new.proprio) <> 2 and (new.proprio like '%00%' or new.proprio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien.</b></font><br><br>';
   end if;

  IF (TG_OP = 'UPDATE') then

    -- gestion de la remise en actif du panneau
	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' then
	
		NEW.dbstatut = '10';
	END IF;

    if st_equals(old.geom, new.geom) is false then
   		NEW.insee := (select DISTINCT insee FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);
		NEW.commune := (select DISTINCT commune FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);  

    end if;

	new.gestio_a := CASE WHEN new.gestio like '%99%' then new.gestio_a else null end;
	new.proprio_a := CASE WHEN new.proprio like '%99%' then new.proprio_a else null end;


  END IF;  
 

  
END IF;

IF (TG_OP = 'DELETE') THEN

	if old.dbstatut = '10' then

		UPDATE m_mobilite_douce.geo_mob_repere SET dbstatut = '11' WHERE id_rep = OLD.id_rep AND OLD.dbstatut = '10';
	else
	
		--je supprime les relations aux itinéraires
		DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_rep = OLD.id_rep;
		--je supprime les relations aux tronçons
		DELETE FROM m_mobilite_douce.lk_mob_rep_troncon WHERE id_rep = OLD.id_rep;
	
		return old;
	end if;

END IF;

return new;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_repere_controle() IS 'Fonction gérant les contrôles de saisies et les informations automatiquement remplies des repères';



-- #################################################################### FONCTION/TRIGGER ft_m_statio_controle ###############################################
-- DROP FUNCTION m_mobilite_douce.ft_m_statio_controle();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_statio_controle()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$


BEGIN

IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN	
-- contrôle de saisie sur EPCI (ne peut pas saisir sur une autre EPCI que la sienne)
	
if new.op_maj is null and 
	(select count(*) from custom_attributes ca where name = 'ccocom' and user_login = NEW.op_sai
	   and values like '%' ||
	   (select insee from r_osm.geo_vm_osm_commune_grdc where st_intersects(new.geom,geom))
	   || '%'
	) = 0 
	then raise exception '<font color="#FF0000"><b>Vous ne pouvez pas saisir un lieu de stationnement cyclable en dehors de votre EPCI.</font></b><br><br>';
end if;
if new.op_maj is not null and
(select count(*) from custom_attributes ca where name = 'ccocom' and user_login = NEW.op_maj
	   and values like '%' ||
	   (select insee from r_osm.geo_vm_osm_commune_grdc where st_intersects(new.geom,geom))
	   || '%'
	) = 0 
	then raise exception '<font color="#FF0000"><b>Vous ne pouvez pas modifier/déplacer un lieu de stationnement cyclable en dehors de votre EPCI.</font></b><br><br>';

end if;	

 -- automatisation des valeurs d'accroche en fonction du type de mobilier saisie (l'accroche peut-être saisie si le mobilier non)
IF new.mobil || new.typ_accro = '0000' then

RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez obligatoirement renseigner un type d''accroche ou un mobilier.</font></b><br><br>';

else
	if NEW.mobil IN ('10','30','50','11') THEN new.typ_accro := '21';
	elsif NEW.mobil IN ('20','40') THEN new.typ_accro := '10';
	elsif NEW.mobil = '90' THEN new.typ_accro := '30';
	elsif NEW.mobil = '60' THEN new.typ_accro := '20';
end if;

	new.gestio_a := CASE WHEN new.gestio like '%99%' then new.gestio_a else null end;
	new.proprio_a := CASE WHEN new.proprio like '%99%' then new.proprio_a else null end;


END IF;

/*
-- supprimer ici le contrôle car un abonnement peut-être gratuit
-- si gratuit l'accès ne peut être avec abonnement
if new.gratuit = 't' and new.acces = '20' then 
	 RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer une gratuité d''accès avec un accès par abonnement.</font></b><br><br>';
end if;
*/
-- année de mise en service doit être supérieur à 2000
if new.an_pose <= 2000 or new.an_pose > (extract(year from now())+1) then
	 RAISE EXCEPTION 'L''année de mise en service n''est pas cohérente.<br><br>';
end if;

-- la capacité des vélos de grande taille ne peut pas être supérieur à la capacité
if new.cap < new.cap_cargo then
	RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer une capacité pour vélo de grande taille supérieure à la capacité totale.</font></b><br><br>';
end if;

IF (TG_OP = 'UPDATE') THEN

	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' THEN
		NEW.dbstatut = '10';
	END IF;
END IF;

END IF;

IF (TG_OP = 'DELETE') THEN

	-- gestion des états et des statuts à la supression
	if old.dbstatut = '10' then
		UPDATE m_mobilite_douce.geo_mob_statio_cycl SET dbstatut = '11' WHERE id_statio = OLD.id_statio AND OLD.dbstatut = '10';
	ELSE
		return old;
	end if;

END IF;

  return new;

 
END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_statio_controle() IS 'Fonction gérant les contrôles de saisies et l''automatisation de certains attributs';


-- #################################################################### FONCTION/TRIGGER ft_m_statio_controle_media ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_statio_controle_media();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_statio_controle_media()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN
raise exception 'id --> %',new.id;
	
if (select count(*) from m_mobilite_douce.geo_mob_statio_cycl where id_statio = new.id AND dbstatut = '11') > 1 then
	-- ATTENTION : GEO ne renvoit pas le message enoncé mais [object Object]
	raise exception '<font color="#FF0000"><b>Vous ne pouvez pas insérer, modifier ou supprimer un média sur un stationnement de la corbeille.</font></b><br><br>';
	
end if;


return new;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_statio_controle_media() IS 'Fonction gérant la non suppression, mise à jour ou insertion d''un média à un stationnement inactif';


-- #################################################################### FONCTION/TRIGGER ft_m_suppan_controle ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_suppan_controle();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_suppan_controle()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN
	

IF (TG_TABLE_NAME = 'geo_mob_pan') THEN
	
IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN


	-- contrôle saisie
	-- année de pose doit être supérieur à 2000
	if new.an_pose is not null and new.an_pose <= 2000 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>L''année de pose doit être supérieure à l''an 2000.</font></b><br><br>';
	end if;

 -- gestionnaire à remplir
   if new.gestio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur.</b></font><br><br>';
   end if;
  
  -- entretien à remplir
   if new.proprio is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un organisme d''entretien.</b></font><br><br>';
   end if;
	
	-- pour gestionnaire
   	if length(new.gestio) <> 2 and (new.gestio like '%00%' or new.gestio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur.</b></font><br><br>';
  	 end if;

	-- pour entretien
   	if length(new.proprio) <> 2 and (new.proprio like '%00%' or new.proprio like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien.</b></font><br><br>';
  	 end if;

  	IF (TG_OP = 'INSERT') then
	-- fonction pour intégrer automatiquement l'identifiant du tronçon le plus proche au support de panneau
	NEW.id_tronc := (
	SELECT t.id_tronc FROM m_mobilite_douce.geo_mob_troncon t WHERE st_distance(t.geom,new.geom) < 7
	group by t.id_tronc order by min(st_distance(t.geom,new.geom)) limit 1
	);
     
	-- insertion des relations panneaux itinéraires
	
 	with req_insert as 
	(
	select new.id_pan, iti.id_iti  from m_mobilite_douce.geo_mob_troncon t
		left join m_mobilite_douce.lk_mob_tronc_iti iti on iti.id_tronc = t.id_tronc
		where t.id_tronc = NEW.id_tronc and iti.id_iti is not null
		AND new.id_pan || '-' || iti.id_iti NOT IN (SELECT lk.id_pan || '-' || lk.id_iti FROM m_mobilite_douce.lk_mob_pan_iti lk)
	)
	insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
	select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_insert i;

	NEW.insee := (select DISTINCT insee FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);
	NEW.commune := (select DISTINCT commune FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);  

	new.gestio_a := CASE WHEN new.gestio like '%99%' then new.gestio_a else null end;
	new.proprio_a := CASE WHEN new.proprio like '%99%' then new.proprio_a else null end;


    END IF;
   
    IF (TG_OP = 'UPDATE') AND ST_Equals(new.geom,OLD.geom) IS false then
  

		NEW.insee := (select DISTINCT insee FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);
		NEW.commune := (select DISTINCT commune FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(NEW.geom,c.geom) IS true);  

    
    -- fonction pour intégrer automatiquement l'identifiant du tronçon le plus proche au support de panneau
	NEW.id_tronc := (
	SELECT t.id_tronc FROM m_mobilite_douce.geo_mob_troncon t WHERE st_distance(t.geom,new.geom) < 7
	group by t.id_tronc order by min(st_distance(t.geom,new.geom)) limit 1
	);
    
	-- suppression des anciennes relations panneaux-itinéraires
	DELETE FROM m_mobilite_douce.lk_mob_pan_iti WHERE id_pan = NEW.id_pan;
	-- insertion des relations panneaux itinéraires
	with req_insert as 
	(
	select new.id_pan, iti.id_iti  from m_mobilite_douce.geo_mob_troncon t
		left join m_mobilite_douce.lk_mob_tronc_iti iti on iti.id_tronc = t.id_tronc
		where t.id_tronc = NEW.id_tronc and iti.id_iti is not null
		AND new.id_pan || '-' || iti.id_iti NOT IN (SELECT lk.id_pan || '-' || lk.id_iti FROM m_mobilite_douce.lk_mob_pan_iti lk)
	)
	insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
	select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_insert i;
   end IF;
  
  IF (TG_OP = 'UPDATE') THEN
    -- gestion de la remise en actif du panneau
	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' THEN
		NEW.dbstatut = '10';
	END IF;

	new.gestio_a := CASE WHEN new.gestio like '%99%' then new.gestio_a else null end;
	new.proprio_a := CASE WHEN new.proprio like '%99%' then new.proprio_a else null end;

  END IF;
  
END IF;

IF (TG_OP = 'DELETE') THEN

/*
	DELETE FROM m_mobilite_douce.an_mob_pn WHERE id_pan = OLD.id_pan;
	DELETE FROM m_mobilite_douce.lk_mob_pan_iti WHERE id_pan = OLD.id_pan;
	return old;
*/

-- gestion des suppressions d'objets par le statut (attention ici avec le découpage qui supprime le tronçon découpé 
	if old.dbstatut = '10' then
		UPDATE m_mobilite_douce.geo_mob_pan SET dbstatut = '11' WHERE id_pan = OLD.id_pan AND OLD.dbstatut = '10';
	ELSE
		--je supprime les pannonceaux liés au panneau supprimé
		DELETE FROM m_mobilite_douce.an_mob_pn WHERE id_pan = OLD.id_pan;
		--je supprime les relations aux itinéraires
		DELETE FROM m_mobilite_douce.lk_mob_pan_iti WHERE id_pan = OLD.id_pan;
	
		return old;
	end if;

END IF;



END IF;

return new;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_suppan_controle() IS 'Fonction gérant les contrôles de saisies et les informations automatiquement remplies des panneaux';


-- #################################################################### FONCTION/TRIGGER ft_m_suppan_rep_controle_update_troncon ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_suppan_rep_controle_update_troncon();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_suppan_rep_controle_update_troncon()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

--declare v_id_pan text;

BEGIN

IF (TG_OP = 'INSERT') then
	--raise exception 'je passe ici après fusion 1';
    -- je récupère l'iDPAN le plus proche du tronçon
    --v_id_pan := (SELECT p.id_pan FROM m_mobilite_douce.geo_mob_pan p WHERE st_distance(new.geom,p.geom) < 8 LIMIT 1) ;

    --raise exception '--> %', new.id_tronc || (SELECT p.id_pan FROM m_mobilite_douce.geo_mob_pan p WHERE st_distance(new.geom,p.geom) < 8 LIMIT 1) ;

	-- POUR LES PANNEAUX
    -- nouvel référence de tronçon au panneau le plus près
  	UPDATE m_mobilite_douce.geo_mob_pan SET id_tronc = new.id_tronc 
	where geo_mob_pan.id_pan IN (SELECT p.id_pan FROM m_mobilite_douce.geo_mob_pan p WHERE st_distance(new.geom,p.geom) < 7) ;
 	/*raise exception 'je passe ici pour la réaffectation des panneaux --> %', (
 	select string_agg(p.id_pan || iti.id_iti,',')   from m_mobilite_douce.geo_mob_troncon t
		left join m_mobilite_douce.lk_mob_tronc_iti iti on iti.id_tronc = t.id_tronc
		left join m_mobilite_douce.geo_mob_pan p on p.id_tronc = new.id_tronc
		where st_distance(new.geom,p.geom) < 7 and iti.id_iti is not null 
		and p.id_pan || '-' || iti.id_iti not in (select i.id_pan || '-' || i.id_iti from m_mobilite_douce.lk_mob_pan_iti i));
	*/
	-- insertion des relations panneaux/itinéraires 
	with req_maj_iti_pan as
	(
		select p.id_pan, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_pan p, m_mobilite_douce.geo_mob_troncon t
		WHERE p.id_tronc = ti.id_tronc and t.id_tronc = new.id_tronc and st_distance(t.geom,p.geom) < 7 and p.id_pan || '-' || ti.id_iti
		not in (select i.id_pan || '-' || i.id_iti from m_mobilite_douce.lk_mob_pan_iti i WHERE i.id_iti IS NOT null 
		and i.id_pan || '-' || i.id_iti IS NOT null)
	)
	insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
	select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_maj_iti_pan i;

	-- POUR LES REPERES
	with req_insert as 
	(
		select r.id_rep, new.id_tronc from m_mobilite_douce.geo_mob_repere r
		where st_intersects(new.geom,st_buffer(r.geom,1)) is true
		AND r.id_rep || '-' || new.id_tronc NOT IN (SELECT lk.id_rep || '-' || lk.id_tronc FROM m_mobilite_douce.lk_mob_rep_troncon lk)
	)
	insert into m_mobilite_douce.lk_mob_rep_troncon (id, id_rep, id_tronc)
	select nextval('m_mobilite_douce.lk_mob_rep_troncon_seq'::regclass), i.id_rep, i.id_tronc from req_insert i;	

END IF;

-- si je modifie la géométrie du tronçon en deça de 7m, je ne relance pas les moulinettes

IF (TG_OP = 'UPDATE') and St_Equals(new.geom,OLD.geom) IS false then

IF ST_HausdorffDistance(old.geom, new.geom) > 7 then 
   -- raise exception 'je passe ici après fusion 2';
    --raise exception 'je passe dans le contrôle NEW.GEOM <> OLD.GEOM pour mise à jour panneau';
	-- POUR LES PANNEAUX
	-- je supprime les liens panneaux itinéraires
	DELETE FROM m_mobilite_douce.lk_mob_pan_iti WHERE id_pan IN (select p.id_pan from m_mobilite_douce.geo_mob_pan p 
	where p.id_tronc = old.id_tronc);
	
	-- je mets à blanc l'id tronc qui a été modifié
	UPDATE m_mobilite_douce.geo_mob_pan set id_tronc = null where id_tronc = old.id_tronc;

	-- je recalcul l'id_tronc à réaffecter
	UPDATE m_mobilite_douce.geo_mob_pan SET id_tronc = new.id_tronc 
	where geo_mob_pan.id_pan IN (SELECT p.id_pan FROM m_mobilite_douce.geo_mob_pan p WHERE st_distance(new.geom,p.geom) < 7) ;

	-- RECOPIER DU DESSUS QUAND REVU
	with req_maj_iti_pan as
	(
		select p.id_pan, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_pan p, m_mobilite_douce.geo_mob_troncon t
		WHERE p.id_tronc = ti.id_tronc and t.id_tronc = old.id_tronc and st_distance(t.geom,p.geom) < 7 and p.id_pan || '-' || ti.id_iti
		not in (select i.id_pan || '-' || i.id_iti from m_mobilite_douce.lk_mob_pan_iti i WHERE i.id_iti IS NOT null 
		and i.id_pan || '-' || i.id_iti IS NOT null)
	)
	insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
	select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_maj_iti_pan i;
	
    -- peut supprimer si pas de panneau
	-- la supprimer sera impossible si dans le trigger principale du tronçon des panneaux sont rattachés à ce tronçon


	-- POUR LES REPERES
	-- je supprime les liens repères itinéraires
    --raise exception 'je passe bien ici';
	DELETE FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_rep IN (select p.id_rep from m_mobilite_douce.geo_mob_repere p
	where st_intersects(st_buffer(p.geom,1), old.geom) is true);

	-- je supprime les liens repères tronçons
    --raise exception 'je passe bien ici';
	DELETE FROM m_mobilite_douce.lk_mob_rep_troncon WHERE id_rep IN (select p.id_rep from m_mobilite_douce.geo_mob_repere p
	where st_intersects(st_buffer(p.geom,1), old.geom) is true);

	-- réaffectation des liens repères/troncons
	with req_insert as 
	(
		select r.id_rep, new.id_tronc from m_mobilite_douce.geo_mob_repere r
		where st_intersects(new.geom,st_buffer(r.geom,1)) is true
		AND r.id_rep || '-' || new.id_tronc NOT IN (SELECT lk.id_rep || '-' || lk.id_tronc FROM m_mobilite_douce.lk_mob_rep_troncon lk)
	)
	insert into m_mobilite_douce.lk_mob_rep_troncon (id, id_rep, id_tronc)
	select nextval('m_mobilite_douce.lk_mob_rep_troncon_seq'::regclass), i.id_rep, i.id_tronc from req_insert i;
	
	-- je résinsère répere itinéraire
	with req_maj_iti_rep as
	(
		select r.id_rep, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_repere r, m_mobilite_douce.geo_mob_troncon t
		where ti.id_tronc = t.id_tronc and r.typ_rep not in ('10','30') and t.dbstatut = '10' and st_intersects(st_buffer(r.geom,1),t.geom) is true 
		and r.id_rep || '-' || ti.id_iti not in (select i.id_rep || '-' || i.id_iti from m_mobilite_douce.lk_mob_rep_iti i WHERE i.id_iti IS NOT null
		and i.id_rep || '-' || i.id_iti is not null)
	)
	insert into m_mobilite_douce.lk_mob_rep_iti (id, id_rep, id_iti)
	select nextval('m_mobilite_douce.lk_mob_rep_iti_seq'::regclass), i.id_rep, i.id_iti from req_maj_iti_rep i;

END IF;
END IF;



return new;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_suppan_rep_controle_update_troncon() IS 'Fonction gérant la réattribution des tronçons et itinéraires à chaque panneau si un tronçon est saisi après un panneau ou une modification géométrique du tronçon';


-- #################################################################### FONCTION/TRIGGER ft_m_troncon_controle ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_troncon_controle();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_troncon_controle()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

DECLARE v_insee CHARACTER varying(5);
DECLARE v_commune CHARACTER varying(80);
DECLARE v_seq integer;

BEGIN

IF (TG_OP = 'INSERT') OR (TG_OP = 'UPDATE') THEN
	

v_insee	 := (select DISTINCT insee FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(st_pointonsurface(ST_Envelope(NEW.geom)),c.geom) IS true);
v_commune := (select DISTINCT commune FROM r_osm.geo_vm_osm_commune_grdc_plus c WHERE st_intersects(st_pointonsurface(ST_Envelope(NEW.geom)),c.geom) IS true);  




-- controle sur la position à droite ou à gauche selon l'aménagement et la régime

-- certains aménagements ne peuvent qu'être saisi à droite
/*IF NEW.posi_dg IN ('12','20') and (new.ame_d in ('31','32','33','71','72','81','82','84','90','99') or new.ame_g in ('31','32','33','71','72','81','82','84','90','99')) then
	 RAISE EXCEPTION '<font color="#FF0000"><b>L''amnégament saisi ne peut qu''être qu''à droite. Merci de corriger votre saisie.</font></b><br><br>';
end if;
*/
-- le niveau d'avancement ne peut pas être à non concerné si un aménagement est renseigné
if new.ame_d <> 'ZZ' and new.dbetat_d = 'ZZ' then
	 RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer un niveau d''avancemenent à "Non concerné" si vous indiquez un aménagement à droite.</font></b><br><br>';
end if ;

if new.ame_g <> 'ZZ' and new.dbetat_g = 'ZZ' then
	 RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer un niveau d''avancemenent à "Non concerné" si vous indiquez un aménagement à gauche.</font></b><br><br>';
end if ;



-- si mon aménagement n'est qu'à droite
IF NEW.posi_dg = '11' then

	-- le régime de circulation doit être indiqué pour des aménagements sur chaussée
/*	if new.ame_d in ('20','21','31','32','33','60','73','82','83','84','85','90') and new.regime_d = '00' then
		RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer le régime de circulation sur la chaussée où se situe l''aménagement.</font></b><br><br>';
	end if;
*/

	-- contrôle sur la requalification (si je coche je doit obligatoirement remplir l'aménagement prévu et son état d'avancement)
    IF NEW.requal_d is true AND (NEW.reqame_d IS NULL OR NEW.reqame_d = '') AND (NEW.reqam_dbetat_d IS NULL OR NEW.reqam_dbetat_d = '') THEN
       RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer une requalification de l''aménagement de droite sans renseigner le futur aménagement et son état d''avancement.</font></b><br><br>';
    END IF;
	IF NEW.requal_d is false then
		NEW.reqame_d := 'ZZ';
		NEW.reqam_dbetat_d := 'ZZ';
	end if;

	-- le niveau d'avancement ne peut pas être à non renseigné
	if new.dbetat_d = '00' then
		 RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un niveau d''avancemenent autre que non renseigné.</font></b><br><br>';
	end if ;

    -- année de programmation doit être supérieur à 2000
	if new.an_prog_d is not null and new.an_prog_d <= 2000 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>L''année de programmation d''un tronçon de droite n''est pas cohérente.</font></b><br><br>';
	end if;	

    -- largeur cohérente <=5m
	if new.largeur_d is not null and new.largeur_d >= 5 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>La largeur de droite n''est pas cohérente (supérieur à 5 mètres).</font></b><br><br>';
	end if;	

 	--IF (NEW.lin_d IS NULL OR NEW.lin_d = 0) THEN
	NEW.lin_d=ST_Length(new.geom)::integer;
	--END IF;
 	NEW.lin_g := 0;


	NEW.com_g := TRUE;
	NEW.insee_d := v_insee;
	NEW.insee_g := v_insee;
	NEW.commune_d := v_commune;
	NEW.commune_g := v_commune;
	new.gestio_a_g := CASE WHEN new.gestio_g like '%99%' then new.gestio_a_g else null end;
	new.proprio_a_g := CASE WHEN new.proprio_g like '%99%' then new.proprio_a_g else null end;
	new.gestio_a_d := CASE WHEN new.gestio_d like '%99%' then new.gestio_a_d else null end;
	new.proprio_a_d := CASE WHEN new.proprio_d like '%99%' then new.proprio_a_d else null end;

	IF v_insee IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445',
	'60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_d := 'cclo';
  	ELSIF  v_insee IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_d := 'arc';
  	ELSIF v_insee IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_d := 'ccpe';
  	ELSIF v_insee IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_d := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_d := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_d := 'ccps';
  	ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_d := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_d := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_d := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_d := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_d := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_d := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
  	THEN new.epci_d := 'ccpc';

  	ELSE new.epci_d := null;
    END IF;
   
   	IF v_insee IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_g := 'cclo';
  	ELSIF  v_insee IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_g := 'arc';
  	ELSIF v_insee IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_g := 'ccpe';
  	ELSIF v_insee IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_g := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_g := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_g := 'ccps';
  ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_g := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_g := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_g := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_g := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_g := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_g := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
    THEN new.epci_d := 'ccpc';
	ELSE new.epci_g := null;
    END IF;
   
	new.ame_g := 'ZZ';
	new.dbetat_g := 'ZZ';
	new.an_prog_g := null;
	new.d_service_g := null;
	new.regime_g := 'ZZ';
	new.sens_g := 'ZZ';
	new.largeur_g := null;
	new.local_g := 'ZZ';
	new.revet_g := 'ZZ';
    NEW.cout_g := null;
    NEW.subv_g := null;
    NEW.proprio_g := 'ZZ';
    NEW.gestio_g := 'ZZ';
    NEW.conv_g := 'z';

   
   -- si voie verte ou assimilé le régime est à non concerné ainsi que la localisation
   IF NEW.ame_d IN ('40','71','99') THEN
    new.local_d := 'ZZ';
   END IF;
   
END IF;



-- si mon aménagement n'est qu'à gauche
IF NEW.posi_dg = '12' then

		-- le régime de circulation doit être indiqué pour des aménagements sur chaussée
/*	if new.ame_g in ('20','21','31','32','33','60','73','82','83','84','85','90') and new.regime_g = '00' then
		RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer le régime de circulation sur la chaussée où se situe l''aménagement.</font></b><br><br>';
	end if;
*/

	-- contrôle sur la requalification (si je coche je doit obligatoirement remplir l'aménagement prévu et son état d'avancement)
    IF NEW.requal_g is true AND (NEW.reqame_g IS NULL OR NEW.reqame_g = '') AND (NEW.reqam_dbetat_g IS NULL OR NEW.reqam_dbetat_g = '') THEN
       RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer une requalification de l''aménagement de gauche sans renseigner le futur aménagement et son état d''avancement.</font></b><br><br>';
    END IF;
	IF NEW.requal_g is false then
		NEW.reqame_g := 'ZZ';
		NEW.reqam_dbetat_g := 'ZZ';
	end if;
	-- le niveau d'avancement ne peut pas être à non renseigné
	if new.dbetat_g = '00' then
		 RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un niveau d''avancemenent autre que non renseigné.</font></b><br><br>';
	end if ;

   -- année de programmation doit être supérieur à 2000
	if new.an_prog_g is not null and new.an_prog_g <= 2000 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>L''année de programmation du tronçon de gauche n''est pas cohérente.</font></b><br><br>';
	end if;	

	    -- largeur cohérente <=5m
	if new.largeur_d is not null and new.largeur_d >= 5 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>La largeur du tronçon de gauche n''est pas cohérente (supérieur à 5 mètres).</font></b><br><br>';
	end if;	

 	--IF (NEW.lin_g IS NULL OR NEW.lin_g = 0) THEN
	NEW.lin_g=ST_Length(new.geom)::integer;
	--END IF;
 	NEW.lin_d := 0;
 
	NEW.insee_d := v_insee;
	NEW.insee_g := v_insee;
	NEW.commune_d := v_commune;
	NEW.commune_g := v_commune;
	new.gestio_a_g := CASE WHEN new.gestio_g like '%99%' then new.gestio_a_g else null end;
	new.proprio_a_g := CASE WHEN new.proprio_g like '%99%' then new.proprio_a_g else null end;
	new.gestio_a_d := CASE WHEN new.gestio_d like '%99%' then new.gestio_a_d else null end;
	new.proprio_a_d := CASE WHEN new.proprio_d like '%99%' then new.proprio_a_d else null end;

	IF v_insee IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_d := 'cclo';
  	ELSIF  v_insee IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_d := 'arc';
  	ELSIF v_insee IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_d := 'ccpe';
  	ELSIF v_insee IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_d := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_d := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_d := 'ccps';
  ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_d := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_d := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_d := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_d := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_d := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_d := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
 		THEN new.epci_d := 'ccpc';
  	ELSE new.epci_d := null;
    END IF;
   	IF v_insee IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_g := 'cclo';
  	ELSIF  v_insee IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_g := 'arc';
  	ELSIF v_insee IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_g := 'ccpe';
  	ELSIF v_insee IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_g := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_g := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_g := 'ccps';
  	ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_g := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_g := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_g := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_g := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_g := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_g := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
  	THEN new.epci_g := 'ccpc';
  	ELSE new.epci_g := null;
    END IF;

    NEW.com_g := TRUE;
	new.ame_d := 'ZZ';
	new.dbetat_d := 'ZZ';
	new.an_prog_d := null;
	new.d_service_d := null;
	new.regime_d := 'ZZ';
	new.sens_d := 'ZZ';
	new.largeur_d := null;
	new.local_d := 'ZZ';
	new.revet_d := 'ZZ';
    NEW.cout_d := null;
    NEW.subv_d := null;
    NEW.proprio_d := 'ZZ';
    NEW.gestio_d := 'ZZ';
    NEW.conv_d := 'z';
   
     -- si voie verte le régime est à non concerné ainsi que la localisation
   IF NEW.ame_g IN ('40','71','99') THEN
    new.local_d := 'ZZ';
   END IF;
  
END IF;


-- si mon aménagement est à gauche et à droite
IF NEW.posi_dg = '20' then


	-- contrôle sur la requalification (si je coche je doit obligatoirement remplir l'aménagement prévu et son état d'avancement)
    IF NEW.requal_g is true AND (NEW.reqame_g IS NULL OR NEW.reqame_g = '') AND (NEW.reqam_dbetat_g IS NULL OR NEW.reqam_dbetat_g = '') THEN
       RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer une requalification de l''aménagement de gauche sans renseigner le futur aménagement et son état d''avancement.</font></b><br><br>';
    END IF;
	IF NEW.requal_g is false then
		NEW.reqame_g := 'ZZ';
		NEW.reqam_dbetat_g := 'ZZ';
	end if;	

	-- contrôle sur la requalification (si je coche je doit obligatoirement remplir l'aménagement prévu et son état d'avancement)
    IF NEW.requal_d is true AND (NEW.reqame_d IS NULL OR NEW.reqame_d = '') AND (NEW.reqam_dbetat_d IS NULL OR NEW.reqam_dbetat_d = '') THEN
       RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer une requalification de l''aménagement de droite sans renseigner le futur aménagement et son état d''avancement.</font></b><br><br>';
    END IF;
	IF NEW.requal_d is false then
		NEW.reqame_d := 'ZZ';
		NEW.reqam_dbetat_d := 'ZZ';
	end if;

 	--IF NEW.lin_g IS null or NEW.lin_g = 0  THEN
	NEW.lin_g=ST_Length(new.geom)::integer;
	--END IF;
	--IF NEW.lin_d IS null or NEW.lin_d = 0 THEN
	NEW.lin_d=ST_Length(new.geom)::integer;
	--END IF;
-- si commune identique
    IF NEW.com_g IS TRUE then
		NEW.insee_d := v_insee;
		NEW.insee_g := v_insee;
		NEW.commune_d := v_commune;
		NEW.commune_g := v_commune;

	IF v_insee IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_d := 'cclo';
  	ELSIF  v_insee IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_d := 'arc';
  	ELSIF v_insee IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_d := 'ccpe';
  	ELSIF v_insee IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_d := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_d := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_d := 'ccps';
  ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_d := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_d := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_d := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_d := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_d := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_d := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
  	  	THEN new.epci_d := 'ccpc';
  	ELSE new.epci_d := null;
    END IF;
   	IF v_insee IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_g := 'cclo';
  	ELSIF  v_insee IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_g := 'arc';
  	ELSIF v_insee IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_g := 'ccpe';
  	ELSIF v_insee IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_g := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_g := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_g := 'ccps';
  ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_g := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_g := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_g := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_g := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_g := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_g := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
  	  	THEN new.epci_g := 'ccpc';
  	ELSE new.epci_g := null;
    END IF;
   
	ELSE
	
	IF NEW.insee_g IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_g := 'cclo';
  	ELSIF  NEW.insee_g IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_g := 'arc';
  	ELSIF NEW.insee_g IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_g := 'ccpe';
  	ELSIF NEW.insee_g IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_g := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_g := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_g := 'ccps';
  ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_g := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_g := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_g := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_g := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_g := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_g := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
  	  	THEN new.epci_g := 'ccpc';
  	ELSE new.epci_g := null;
    END IF;
   
	IF NEW.insee_d IN ('60025','60032','60064','60072','60145','60167','60171','60184','60188','60305','60324','60438','60445','60491','60534','60569','60572','60593','60641','60647')
  	THEN new.epci_d := 'cclo';
  	ELSIF  NEW.insee_d IN ('60023','60067','60068','60070','60151','60156','60159','60323','60325','60326','60337','60338','60382','60402','60447','60578','60579','60597','60600','60665','60667','60674')
    THEN new.epci_d := 'arc';
  	ELSIF NEW.insee_d IN ('60024','60036','60040','60078','60125','60149','60152','60210','60223','60229','60254','60284','60308','60318','60369','60424','60441','60531','60540')
  	THEN new.epci_d := 'ccpe';
  	ELSIF NEW.insee_d IN ('60043','60119','60147','60150','60368','60373','60378','60392','60423','60492','60501','60537','60582','60636','60642','60654')
  	THEN new.epci_d := 'cc2v';
    elsif v_insee IN ('60129','60610','60488','60676','60118','60189')
  	THEN new.epci_d := 'ccpn';
    ELSIF v_insee IN ('60126','60206','60383','60386','60675','60689','60273','60166','60048','60408','60281','60632')
  	THEN new.epci_d := 'ccps';
  ELSIF v_insee IN ('60440','60553','60177','60137')
  	THEN new.epci_d := 'ccpp';
  	ELSIF v_insee IN ('60247','60375','60130')
  	THEN new.epci_d := 'ccc';
  	ELSIF v_insee IN ('60562','60587','60563','60050','60509','60508','60536','60680')
  	THEN new.epci_d := 'ccpoh';
  	ELSIF v_insee IN ('60525','60560')
  	THEN new.epci_d := 'ccsso';
  	ELSIF v_insee IN ('60650','60543','60274','60481','60430')
  	THEN new.epci_d := 'ccpv';
  	ELSIF v_insee IN ('02644','02528','02514','02795','02673','02562','02527','02762','02034')
  	THEN new.epci_d := 'ccrv';
  	ELSIF v_insee IN ('02093','02140')
  	  	THEN new.epci_d := 'ccpc';
  	ELSE new.epci_d := null;
    END IF;
   
	END IF;

		new.gestio_a_d := CASE WHEN new.gestio_d like '%99%' then new.gestio_a_d else null end;
		new.proprio_a_d := CASE WHEN new.proprio_d like '%99%' then new.proprio_a_d else null end;
		new.gestio_a_g := CASE WHEN new.gestio_g like '%99%' then new.gestio_a_g else null end;
		new.proprio_a_g := CASE WHEN new.proprio_g like '%99%' then new.proprio_a_g else null end;	

    -- si aménagement identique
    IF NEW.mame_g IS TRUE then
    	new.ame_g := new.ame_d;
        new.dbetat_g := new.dbetat_d;
        new.regime_g := new.regime_d;
        new.sens_g := new.sens_d;
        new.sens_g := new.sens_d;
        new.largeur_g := new.largeur_d;
        new.local_g := new.local_d;
        new.revet_g := new.revet_d;
        new.revet_g := new.revet_d;
        new.an_prog_g := new.an_prog_d;
        new.cout_g := new.cout_d;
        new.subv_g := new.subv_d;
        new.d_service_g := new.d_service_d;
        new.gestio_g := new.gestio_d;
        new.proprio_g := new.proprio_d;
        new.conv_g := new.conv_d;
        new.requal_g := new.requal_d;
		new.reqame_g := new.reqame_d;
		new.reqam_dbetat_g := new.reqam_dbetat_d;
		new.gestio_a_g := new.gestio_a_d;
		new.proprio_a_g := new.proprio_a_d;

    end if;

   	-- le régime de circulation doit être indiqué pour des aménagements sur chaussée
/*	if (new.ame_d in ('20','21','31','32','33','60','73','82','83','84','85','90') and new.regime_d = '00') or  (new.ame_g in ('20','21','31','32','33','60','73','82','83','84','85','90') and new.regime_g = '00') then
		RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer le régime de circulation sur la chaussée où se situe l''aménagement.</font></b><br><br>';
	end if;
  */ 
	-- le niveau d'avancement ne peut pas être à non renseigné
	if new.dbetat_d = '00' or new.dbetat_g = '00' then
		 RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un niveau d''avancemenent autre que non renseigné.</font></b><br><br>';
	end if ;

   -- si voie verte le régime est à non concerné ainsi que la localisation
   IF NEW.ame_d IN ('40','71','99') THEN
    new.local_d := 'ZZ';
   END IF;
   IF NEW.ame_g IN ('40','71','99') THEN
    new.local_g := 'ZZ';
   END IF;
   
END IF;

	-- contrôle saisie
	-- année de programmation doit être supérieur à 2000
	if new.an_prog_d is not null and new.an_prog_d <= 2000 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>L''année de programmation du tronçon de droite n''est pas cohérente.</font></b><br><br>';
	end if;	

	   -- année de programmation doit être supérieur à 2000
	if new.an_prog_g is not null and new.an_prog_g <= 2000 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>L''année de programmation du tronçon de gauche n''est pas cohérente.</font></b><br><br>';
	end if;	

	-- largeur cohérente <=5m
	if new.largeur_d is not null and new.largeur_d >= 5 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>La largeur du tronçon de droite n''est pas cohérente (supérieur à 5 mètres).</font></b><br><br>';
	end if;	
 
	-- largeur cohérente <=5m
	if new.largeur_g is not null and new.largeur_g >= 5 then
		 RAISE EXCEPTION '<font color="#FF0000"><b>La largeur du tronçon de gauche n''est pas cohérente (supérieur à 5 mètres).</font></b><br><br>';
	end if;	


/*****/
-- gestion des entretiens et aménageurs non renseignés


	-- pour gestionnaire à droite null
   if NEW.posi_dg = '11' and new.gestio_d is null then
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur à droite.</b></font><br><br>';
   end if;
   -- pour gestionnaire à gauche null
   if NEW.posi_dg = '12' and new.gestio_g is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur à gauche.</b></font><br><br>';
   end if;

   -- pour gestionnaire à gauche et à droite
  if NEW.posi_dg = '20' and (new.gestio_g is null or new.gestio_d is null) then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un aménageur à droite ou à gauche.</b></font><br><br>';
   end if;

	-- pour entretien à droite null
   if NEW.posi_dg = '11' and new.proprio_d is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un organisme d''entretien à droite.</b></font><br><br>';
   end if;
   -- pour entretien à gauche null
   if NEW.posi_dg = '12' and new.proprio_g is null then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous devez indiquer un organisme d''entretien à gauche.</b></font><br><br>';
   end if;

   -- pour entretien à gauche et à droite null
  if NEW.posi_dg = '20' and (new.proprio_g is null or new.proprio_d is null) then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien à droite ou à gauche.</b></font><br><br>';
   end if;


/*****/

	-- pour gestionnaire à droite
   if NEW.posi_dg = '11' and length(new.gestio_d) <> 2 and (new.gestio_d like '%00%' or new.gestio_d like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur à droite.</b></font><br><br>';
   end if;
   -- pour gestionnaire à gauche
   if NEW.posi_dg = '12' and length(new.gestio_g) <> 2 and (new.gestio_g like '%00%' or new.gestio_g like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur à gauche.</b></font><br><br>';
   end if;

   -- pour gestionnaire à gauche et à droite
  if NEW.posi_dg = '20' and ((length(new.gestio_g) <> 2 and (new.gestio_g like '%00%' or new.gestio_g like '%ZZ%')) or
   (length(new.gestio_d) <> 2 and (new.gestio_d like '%00%' or new.gestio_d like '%ZZ%'))) then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre aménageur à droite ou à gauche.</b></font><br><br>';
   end if;

	-- pour entretien à droite
   if NEW.posi_dg = '11' and length(new.proprio_d) <> 2 and (new.proprio_d like '%00%' or new.proprio_d like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien à droite.</b></font><br><br>';
   end if;
   -- pour entretien à gauche
   if NEW.posi_dg = '12' and length(new.proprio_g) <> 2 and (new.proprio_g like '%00%' or new.proprio_g like '%ZZ%') then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme à gauche.</b></font><br><br>';
   end if;

   -- pour entretien à gauche et à droite
  if NEW.posi_dg = '20' and ((length(new.proprio_g) <> 2 and (new.proprio_g like '%00%' or new.proprio_g like '%ZZ%')) or
   (length(new.proprio_d) <> 2 and (new.proprio_d like '%00%' or new.proprio_d like '%ZZ%'))) then 
   	  RAISE EXCEPTION '<font color="#FF0000"><b>Vous ne pouvez pas indiquer "Non renseigné" ou "Non concerné" avec un autre organisme d''entretien à droite ou à gauche.</b></font><br><br>';
   end if;


	
   -- si type de mobilité = piéton, sens de circulation par défaut à ZZ 
   if new.typ_mob = '20' then
   	  new.sens_g := 'ZZ'; 	
   	  new.sens_d := 'ZZ';
   end if;

IF (TG_OP = 'UPDATE') THEN
    --raise exception 'après fusion passe ici 1';
	-- quand je réactive un tronçon
	IF old.dbstatut <> NEW.dbstatut AND NEW.dbstatut = '10' THEN
		NEW.dbstatut = '10';
	--raise exception 'nv tronc --> %',new.id_tronc || '-' || old.id_tronc;
	--raise exception 'après fusion passe ici 2';
	-- réaffectation de l'idtronc dans geo_mob_pan
	update m_mobilite_douce.geo_mob_pan set id_tronc = new.id_tronc 
    where geo_mob_pan.id_pan IN (select p.id_pan from m_mobilite_douce.geo_mob_pan p, m_mobilite_douce.geo_mob_troncon t where st_distance(p.geom,t.geom) < 7 and t.id_tronc = new.id_tronc);
	
   	-- réaffectation des itinéraires aux panneaux
   	with req_maj_iti_pan as
	(
		select p.id_pan, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_pan p, m_mobilite_douce.geo_mob_troncon t
		WHERE p.id_tronc = ti.id_tronc and t.id_tronc = new.id_tronc and st_distance(t.geom,p.geom) < 7 and p.id_pan || '-' || ti.id_iti
		not in (select i.id_pan || '-' || i.id_iti from m_mobilite_douce.lk_mob_pan_iti i WHERE i.id_iti IS NOT null 
		and i.id_pan || '-' || i.id_iti IS NOT null)
	)
	insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
	select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_maj_iti_pan i; 
	
	-- réaffectation de la relation repère/itinéraire   
	with req_maj_iti_rep as
	(
		select r.id_rep, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_repere r, m_mobilite_douce.geo_mob_troncon t
		where t.id_tronc = ti.id_tronc and r.typ_rep not in ('10','30') and t.id_tronc = NEW.id_tronc and st_intersects(st_buffer(r.geom,1),t.geom) is true and r.id_rep || '-' || ti.id_iti
		not in (select i.id_rep || '-' || i.id_iti from m_mobilite_douce.lk_mob_rep_iti i WHERE i.id_iti IS NOT null
		and i.id_rep || '-' || i.id_iti is not null)
	)
		insert into m_mobilite_douce.lk_mob_rep_iti (id, id_rep, id_iti)
		select nextval('m_mobilite_douce.lk_mob_rep_iti_seq'::regclass), i.id_rep, i.id_iti from req_maj_iti_rep i;
   
	-- réaffectation des relations repères/tronçons
	with req_insert as 
	(
		select r.id_rep, new.id_tronc from m_mobilite_douce.geo_mob_repere r
		where st_intersects(new.geom,st_buffer(r.geom,1)) is true
		AND r.id_rep || '-' || new.id_tronc NOT IN (SELECT lk.id_rep || '-' || lk.id_tronc FROM m_mobilite_douce.lk_mob_rep_troncon lk)
	)
	insert into m_mobilite_douce.lk_mob_rep_troncon (id, id_rep, id_tronc)
	select nextval('m_mobilite_douce.lk_mob_rep_troncon_seq'::regclass), i.id_rep, i.id_tronc from req_insert i;	
		
	END IF;

	IF old.dbstatut <> NEW.dbstatut AND new.dbstatut = '11' then
	--raise exception 'après fusion passe ici 3';
	-- si mon tronçon est découpé je sauvegarde les relations tronçon iti dans ma table de passage (le tronçon découpé n'est pas supprimé mais mis en inactif)
	if (select count(*) from m_mobilite_douce.lk_mob_tronc_iti where id_tronc = old.id_tronc) > 0 then
        
      	with req_insert as
    	(
    	select 'TC' || currval('m_mobilite_douce.geo_mob_troncon_seq') as id_tronc_new, id_tronc, id_iti from m_mobilite_douce.lk_mob_tronc_iti where id_tronc = old.id_tronc
    	)
    	insert into m_mobilite_douce.lk_mob_tronc_iti_decoupe (id, id_tronc,id_iti)
    	select nextval('m_mobilite_douce.lk_mob_tronc_iti_decoupe_seq'::regclass), id_tronc_new, i.id_iti from req_insert i;
    	with req_insert as
    	(
    	select 'TC' || currval('m_mobilite_douce.geo_mob_troncon_seq')-1 as id_tronc_new, id_tronc, id_iti from m_mobilite_douce.lk_mob_tronc_iti where id_tronc = old.id_tronc
    	)
    	insert into m_mobilite_douce.lk_mob_tronc_iti_decoupe (id, id_tronc,id_iti)
    	select nextval('m_mobilite_douce.lk_mob_tronc_iti_decoupe_seq'::regclass), id_tronc_new, i.id_iti from req_insert i;
  		
	    -- je supprime les relations repère/itinéraires
    	delete from m_mobilite_douce.lk_mob_rep_iti where id_rep IN (select id_rep from m_mobilite_douce.lk_mob_rep_troncon where id_tronc = old.id_tronc);
    	-- je supprime les relations repère/troncon
    	delete from m_mobilite_douce.lk_mob_rep_troncon where id_tronc = old.id_tronc;
    	-- je supprime les relations panneau_iti
    	delete from m_mobilite_douce.lk_mob_pan_iti where id_pan in (select id_pan from m_mobilite_douce.geo_mob_pan where id_tronc = old.id_tronc);
    	-- je mets à null l'id_tronc présent dans la classe d'objets geo_mob_pan
    	update m_mobilite_douce.geo_mob_pan set id_tronc = null where id_tronc = old.id_tronc;	
    
    END IF;
		
	end if;


END IF;
  
  
END IF;

IF (TG_OP = 'DELETE') then
	--raise exception 'après fusion passe ici 4';
	--raise exception 'passe dans delete tronçon contrôle';
    -- gestion des suppressions d'objets par le statut (attention ici avec le découpage qui supprime le tronçon découpé 
	if old.dbstatut = '10' THEN
	    --raise EXCEPTION 'ok';
		-- je mets à jour le statut en inactif (1er suppression)
		UPDATE m_mobilite_douce.geo_mob_troncon SET dbstatut = '11' WHERE id_tronc = OLD.id_tronc AND OLD.dbstatut = '10';
	--raise exception 'après fusion passe ici 5 --> %', old.id_tronc;
	else
	--raise exception 'après fusion passe ici 6 --> %', old.id_tronc;
		-- je supprime les repères si lié au tronçon
    	--delete from m_mobilite_douce.geo_mob_repere 
    	--where id_rep IN (select id_rep from m_mobilite_douce.lk_mob_rep_troncon where id_tronc = old.id_tronc);
    	-- je supprime les relations tronc / iti
		delete from m_mobilite_douce.lk_mob_tronc_iti where id_tronc = old.id_tronc;
		-- je supprime les relations tronc / repère
	   -- raise exception 'je passe pour supprimer relation tronc-iti après 2nd supression --> %',old.id_tronc;
    	delete from m_mobilite_douce.lk_mob_rep_troncon	where id_tronc = old.id_tronc;
    	-- la suppression lk_mob_rep_iti se fait quand je supprime geo_mob_repere
	    
   		-- je supprime les médias associés
		delete from m_mobilite_douce.an_mob_media where id = old.id_tronc;
	
	return old;
	end if;

END IF;

return new;

end;

$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_troncon_controle() IS 'Fonction gérant les contrôles de saisies et les informations automatiquement remplies liées à la particularité des infos de droites et de gauche';



-- #################################################################### FONCTION/TRIGGER ft_m_troncon_controle_after ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_troncon_controle_after();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_troncon_controle_after()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

--declare v_typ_rep text;

BEGIN

IF (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') THEN	

--raise exception 'je passe dans le insert update de la fonction ft_m_troncon_controle_after';
-- quand j'ajoute un itinétaire à un tronçon, je l'ajoute à mes repères présent sauf pour les début.fin itinéraire, à gérer à la main
--RAISE EXCEPTION 'je mets à jour une assoxcaition d''itinéraire --> %', new.id_tronc;	
with req_maj_iti_rep as
(
	select r.id_rep, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_repere r, m_mobilite_douce.geo_mob_troncon t
	where t.id_tronc = ti.id_tronc and r.typ_rep not in ('10','30') and t.id_tronc = NEW.id_tronc and st_intersects(st_buffer(r.geom,1),t.geom) is true 
	and r.id_rep || '-' || ti.id_iti not in (select i.id_rep || '-' || i.id_iti from m_mobilite_douce.lk_mob_rep_iti i WHERE i.id_iti IS NOT null
	and i.id_rep || '-' || i.id_iti is not null)

)
insert into m_mobilite_douce.lk_mob_rep_iti (id, id_rep, id_iti)
select nextval('m_mobilite_douce.lk_mob_rep_iti_seq'::regclass), i.id_rep, i.id_iti from req_maj_iti_rep i;

-- j'ajoute panneau itinéraire

with req_maj_iti_pan as
(
	select distinct p.id_pan, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_pan p, m_mobilite_douce.geo_mob_troncon t
	WHERE p.id_tronc = ti.id_tronc and t.id_tronc = new.id_tronc and st_distance(t.geom,p.geom) < 7 and p.id_pan || '-' || ti.id_iti
	not in (select i.id_pan || '-' || i.id_iti from m_mobilite_douce.lk_mob_pan_iti i WHERE i.id_iti IS NOT null 
	and i.id_pan || '-' || i.id_iti IS NOT null)

)
	insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
	select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_maj_iti_pan i;

-- gestion si je découpe un tronçon et que celui d'origine était rattaché à un ou plusieurs itinéraires
-- à voir si fait ici avec un after ou en before
--RAISE EXCEPTION 'ok passe ici --> %', NEW.id_tronc || '-' || NEW.id_iti ;

/*
-- ajout des droits délégués
	UPDATE m_mobilite_douce.geo_mob_troncon 
  	SET epci_acces = epci || (select epci_cg from m_mobilite_douce.an_mob_iti_cycl where id_iticycl = NEW.id_iti) WHERE
  	geo_mob_troncon.id_tronc = NEW.id_tronc;
*/
return new;

end if;


-- à la suppression d'une association itinéraire tronçon, je dois supprimer l'association repère itinéraire et panneau itinéraire
IF (TG_OP = 'DELETE') then
--RAISE EXCEPTION 'ok passe ici --> %', old.id_tronc;
--raise exception 'je passe dans le delete de la fonction ft_m_troncon_controle_after';
--je supprime tout (repère itinéraire)
delete from m_mobilite_douce.lk_mob_rep_iti 
where id_rep in (select t.id_rep from m_mobilite_douce.lk_mob_rep_troncon t where t.id_tronc = old.id_tronc);
--je supprime tout (panneau itinéraire)
delete from m_mobilite_douce.lk_mob_pan_iti 
where id_pan in (select t.id_pan from m_mobilite_douce.geo_mob_pan t where t.id_tronc = old.id_tronc);


-- je résinsère répere itinéraire
with req_maj_iti_rep as
(
select r.id_rep, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_repere r, m_mobilite_douce.geo_mob_troncon t
where ti.id_tronc = t.id_tronc and r.typ_rep not in ('10','30') and t.dbstatut = '10' and st_intersects(st_buffer(r.geom,1),t.geom) is true 
and r.id_rep || '-' || ti.id_iti not in (select i.id_rep || '-' || i.id_iti from m_mobilite_douce.lk_mob_rep_iti i WHERE i.id_iti IS NOT null
and i.id_rep || '-' || i.id_iti is not null)

)
insert into m_mobilite_douce.lk_mob_rep_iti (id, id_rep, id_iti)
select nextval('m_mobilite_douce.lk_mob_rep_iti_seq'::regclass), i.id_rep, i.id_iti from req_maj_iti_rep i;

-- je résinsère panneau itinéraire

with req_maj_iti_pan as
(
select p.id_pan, ti.id_iti from m_mobilite_douce.lk_mob_tronc_iti ti, m_mobilite_douce.geo_mob_pan p, m_mobilite_douce.geo_mob_troncon t
WHERE p.id_tronc = ti.id_tronc and t.id_tronc = old.id_tronc and st_distance(t.geom,p.geom) < 7 and p.id_pan || '-' || ti.id_iti
not in (select i.id_pan || '-' || i.id_iti from m_mobilite_douce.lk_mob_pan_iti i WHERE i.id_iti IS NOT null 
and i.id_pan || '-' || i.id_iti IS NOT null)

)
insert into m_mobilite_douce.lk_mob_pan_iti (id, id_pan, id_iti)
select nextval('m_mobilite_douce.lk_mob_pan_iti_seq'::regclass), i.id_pan, i.id_iti from req_maj_iti_pan i;

/*
--RAISE EXCEPTION 'ok passe ici --> %', old.id_tronc;
-- suppression des droits délégués
	UPDATE m_mobilite_douce.geo_mob_troncon 
  	SET epci_acces = epci WHERE
  	geo_mob_troncon.id_tronc = OLD.id_tronc;
	*/

return old;

end if;


end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_troncon_controle_after() IS 'Fonction gérant l''association des itinéraires aux repères (+ association aux tronçons) et aux panneaux si ajout d''itinéraire au tronçon';



-- #################################################################### FONCTION/TRIGGER ft_m_troncon_controle_after_decoupe ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_m_troncon_controle_after_decoupe();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_m_troncon_controle_after_decoupe()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$


BEGIN

if st_equals(new.geom, old.geom) is false then

if (select count(*) from m_mobilite_douce.lk_mob_tronc_iti_decoupe) >= 2 then 
	--raise exception 'passe dans decoupe after --> %',(select count(*) from m_mobilite_douce.lk_mob_tronc_iti_decoupe)  ;
	
	insert into m_mobilite_douce.lk_mob_tronc_iti (id,id_tronc,id_iti)
	select nextval('m_mobilite_douce.lk_mob_tronc_iti_seq'::regclass), d.id_tronc, d.id_iti from m_mobilite_douce.lk_mob_tronc_iti_decoupe d
    WHERE id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.geo_mob_troncon) 
    AND d.id_tronc || '-' || d.id_iti NOT IN (SELECT id_tronc || '-' || id_iti FROM m_mobilite_douce.lk_mob_tronc_iti);
   
	-- je supprime tout dans la table temporaire stockant les relations de l'objet découpé (qui sera supprimé) avec les itinéraires
	DELETE from m_mobilite_douce.lk_mob_tronc_iti_decoupe;
	--raise exception 'passe apres insertion';
	else
	--raise exception 'je passe dans découpe si 1 tronçon';
	-- si moins de 1 tronçon, sans doute issu d'une 1ere suppression donc pas découpé, je supprime 
	DELETE from m_mobilite_douce.lk_mob_tronc_iti_decoupe;
end if;
end if;

return new;

end;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_m_troncon_controle_after_decoupe() IS 'Fonction test pour réintégrer les relations d'' tronçon découpé';


-- #################################################################### FONCTION/TRIGGER ft_r_autorite_competente_user_login_iti ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_r_autorite_competente_user_login_iti();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_r_autorite_competente_user_login_iti()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

--IF (TG_OP = 'INSERT') THEN
--RAIsE EXCEPTION 'Gestio --> %', new.gestio; 
  if (new.gestio like '%01%' or new.gestio like '%02%' or new.gestio like '%03%' or new.gestio like '%ZZ%') then
--RAISE EXCEPTION 'ok';
  	new.epci := 'all';
    --new.epci_access := 'all';


  ELSE
  -- function récupérant l'EPCI d'appartenance affecté à l'utilisateur
   NEW.epci := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
	  /* if new.epci_cg_d = false then
		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
		NEW.epci_cg := null;
		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) uniquement pour l'EPCI maitre
  		
  		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);
		
  	   else
   		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg;
   		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) aux EPCI maître et esclave
		-- et uniquement sur commune de l'EPCI esclave
		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);

	   end if;
*/
  end if;
return new;
--END IF;


/*
IF (TG_OP = 'UPDATE') THEN

-- uniquement si attribut de de gestion, epci_cg_d changent
IF (OLD.gestio <> NEW.gestio) OR (OLD.epci_cg_d <> NEW.epci_cg_d) THEN

  if (new.gestio like '%01%' or new.gestio like '%02%' or new.gestio like '%03%' or new.gestio like '%ZZ%') then
  	new.epci := 'all';
    new.epci_access := 'all';
  ELSE
  -- function récupérant l'EPCI d'appartenance affecté à l'utilisateur
   NEW.epci := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
	   if new.epci_cg_d = false then
		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
		NEW.epci_cg := null;
		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) uniquement pour l'EPCI maitre
  		
  		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);

 	   else
   		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg;
   		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) aux EPCI maître et esclave
		-- et uniquement sur commune de l'EPCI esclave
		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);
	
	   end if;
  end if;
return new;
END IF;
return new;
END IF;

*/
END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_r_autorite_competente_user_login_iti() IS 'Fonction trigger affecter l''autorité compétente en fonction de l''utilisateur de saisie';



-- #################################################################### FONCTION/TRIGGER ft_r_autorite_competente_user_login_rep ###############################################

-- DROP FUNCTION m_mobilite_douce.ft_r_autorite_competente_user_login_rep();

CREATE OR REPLACE FUNCTION m_mobilite_douce.ft_r_autorite_competente_user_login_rep()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

BEGIN

IF (TG_OP = 'INSERT') THEN

  	NEW.epci := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
	 
   if new.epci_cg_d = false then
		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
		NEW.epci_cg := null;
		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) uniquement pour l'EPCI maitre
  		
  		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);
		
  		UPDATE m_mobilite_douce.geo_mob_repere
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) WHERE
  		geo_mob_repere.id_rep IN (SELECT id_rep FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = NEW.id_iticycl);
  	
 	   else
   		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg;
   		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) aux EPCI maître et esclave
		-- et uniquement sur commune de l'EPCI esclave
		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);
	
  		UPDATE m_mobilite_douce.geo_mob_repere 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg WHERE
  		geo_mob_repere.id_rep IN (SELECT id_rep FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = NEW.id_iticycl);
  	
	end if;
return new;
END IF;



IF (TG_OP = 'UPDATE') THEN

-- uniquement si attribut de de gestion, epci_cg_d changent
IF (OLD.gestio <> NEW.gestio) OR (OLD.epci_cg_d <> NEW.epci_cg_d) THEN

  if (new.gestio like '%01%' or new.gestio like '%02%' or new.gestio like '%03%' or new.gestio like '%ZZ%') then
  	new.epci := 'all';
    new.epci_access := 'all';
  ELSE
  -- function récupérant l'EPCI d'appartenance affecté à l'utilisateur
   NEW.epci := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
	   if new.epci_cg_d = false then
		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai);
		NEW.epci_cg := null;
		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) uniquement pour l'EPCI maitre
  		
  		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);
		
  		UPDATE m_mobilite_douce.geo_mob_repere
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) WHERE
  		geo_mob_repere.id_rep IN (SELECT id_rep FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = NEW.id_iticycl);
  	
 	   else
   		NEW.epci_acces := (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg;
   		-- ventilation des droits aux objets liés aux itinéraires (panneaux, repère, tronçon) aux EPCI maître et esclave
		-- et uniquement sur commune de l'EPCI esclave
		UPDATE m_mobilite_douce.geo_mob_troncon 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg WHERE
  		geo_mob_troncon.id_tronc IN (SELECT id_tronc FROM m_mobilite_douce.lk_mob_tronc_iti WHERE id_iti = NEW.id_iticycl);
	
  		UPDATE m_mobilite_douce.geo_mob_repere 
  		SET epci_acces = (select values from custom_attributes ca where name = 'epci' and user_login = NEW.op_sai) || NEW.epci_cg WHERE
  		geo_mob_repere.id_rep IN (SELECT id_rep FROM m_mobilite_douce.lk_mob_rep_iti WHERE id_iti = NEW.id_iticycl);
  	
	   end if;
  end if;
return new;
END IF;
return new;
END IF;


END;
$function$
;

COMMENT ON FUNCTION m_mobilite_douce.ft_r_autorite_competente_user_login_rep() IS 'Fonction trigger affecter l''autorité compétente en fonction de l''utilisateur de saisie';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TRIGGER                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_iti_cycl ###############################################

create trigger t_t0_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure m_mobilite_douce.ft_m_controle_saisie_iticycl();
    
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
    
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure ft_r_timestamp_dbinsert();
    
    
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure ft_r_timestamp_dbupdate();
   
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure m_mobilite_douce.ft_r_autorite_competente_user_login_iti();
   
create trigger t_t8_refresh_iti after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure m_mobilite_douce.ft_m_refresh_iti_lk();
   
create trigger t_t91_planvelo before
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure m_mobilite_douce.ft_m_refresh_planvelo();
   
create trigger t_t9_droit_delegue after
update
    on
    m_mobilite_douce.an_mob_iti_cycl for each row execute procedure m_mobilite_douce.ft_m_moddouce_droit_delegue_after();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_iti_rand ###############################################

create trigger t_t0_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_iti_rand for each row execute procedure m_mobilite_douce.ft_m_controle_saisie_itirand();
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_iti_rand for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_iti_rand for each row execute procedure ft_r_timestamp_dbinsert();
   
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.an_mob_iti_rand for each row execute procedure ft_r_timestamp_dbupdate();
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.an_mob_iti_rand for each row execute procedure m_mobilite_douce.ft_r_autorite_competente_user_login_iti();
   
create trigger t_t8_refresh_iti after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_iti_rand for each row execute procedure m_mobilite_douce.ft_m_refresh_iti_lk():
    
    

-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_media ###############################################

    create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_media for each row execute procedure ft_r_timestamp_dbinsert();
   


-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_pan_media ###############################################

create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_pan_media for each row execute procedure ft_r_timestamp_dbinsert();

-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_plan ###############################################

create trigger t_t0_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_plan for each row execute procedure m_mobilite_douce.ft_m_controle_saisie_plan();
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_plan for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_plan for each row execute procedure ft_r_timestamp_dbinsert();
   
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.an_mob_plan for each row execute procedure ft_r_timestamp_dbupdate();
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.an_mob_plan for each row execute procedure m_mobilite_douce.ft_r_autorite_competente_user_login_iti();   

-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_pn ###############################################

create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.an_mob_pn for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_pn for each row execute procedure ft_r_timestamp_dbinsert();
   
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.an_mob_pn for each row execute procedure ft_r_timestamp_dbupdate();   

-- ########################################## FONCTION/TRIGGER classe d'objets an_mob_statio_cylc_media ###############################################
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.an_mob_statio_cylc_media for each row execute procedure ft_r_timestamp_dbinsert()  ; 
   
   
-- ########################################## FONCTION/TRIGGER classe d'objets geo_mob_pan ###############################################

create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_pan for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.geo_mob_pan for each row execute procedure ft_r_timestamp_dbinsert();
   
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.geo_mob_pan for each row execute procedure ft_r_timestamp_dbupdate();
   
create trigger t_t3_xyl93 before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_pan for each row execute procedure ft_r_xy_l93();
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_pan for each row execute procedure ft_r_autorite_competente_user_login();
   
create trigger t_t6_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_pan for each row execute procedure m_mobilite_douce.ft_m_suppan_controle();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets geo_mob_repere ###############################################

   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_repere for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.geo_mob_repere for each row execute procedure ft_r_timestamp_dbinsert();
   
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.geo_mob_repere for each row execute procedure ft_r_timestamp_dbupdate();
   
create trigger t_t3_xyl93 before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_repere for each row execute procedure ft_r_xy_l93();
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_repere for each row execute procedure ft_r_autorite_competente_user_login();
   
create trigger t_t6_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_repere for each row execute procedure m_mobilite_douce.ft_m_repere_controle();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets geo_mob_statio_cycl ###############################################

   create trigger t_t0_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure m_mobilite_douce.ft_m_statio_controle();
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure ft_r_timestamp_dbinsert();
   
   create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure ft_r_timestamp_dbupdate();

   create trigger t_t3_xyl93 before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure ft_r_xy_l93();
   
create trigger t_t4_inseecommune before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure ft_r_commune_pl();
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_statio_cycl for each row execute procedure ft_r_autorite_competente_user_login();
   
   
   
-- ########################################## FONCTION/TRIGGER classe d'objets geo_mob_troncon ###############################################   
   
create trigger t_t0_controle before
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure m_mobilite_douce.ft_m_troncon_controle();
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t10_after_decoupe after
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure m_mobilite_douce.ft_m_troncon_controle_after_decoupe();
   
   create trigger t_t1_dbinsert before
insert
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure ft_r_timestamp_dbinsert();
   
create trigger t_t2_dbupdate before
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure ft_r_timestamp_dbupdate();
   
create trigger t_t5_autorite before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure ft_r_autorite_competente_user_login();
   
create trigger t_t7_majpan_rep before
insert
    or
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure m_mobilite_douce.ft_m_suppan_rep_controle_update_troncon();
   
create trigger t_t8_refresh_iti after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.geo_mob_troncon for each row execute procedure m_mobilite_douce.ft_m_refresh_iti();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_droit_delegue_iti ###############################################      
   
create trigger t_t1_controle before
insert
    on
    m_mobilite_douce.lk_mob_droit_delegue_iti for each row execute procedure m_mobilite_douce.ft_m_moddouce_delegue();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_iti_plan ###############################################

create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_iti_plan for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_iticycl_sign ###############################################   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_iticycl_sign for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_itirand_com ###############################################   
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_itirand_com for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_itirand_sign ###############################################

create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_itirand_sign for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();   
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_pan_iti ###############################################   
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_pan_iti for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_rep_iti ###############################################

create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_rep_iti for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
-- ########################################## FONCTION/TRIGGER classe d'objets lk_mob_tronc_iti ###############################################   
   
create trigger t_t0_controle after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_tronc_iti for each row execute procedure m_mobilite_douce.ft_m_troncon_controle_after();
   
create trigger t_t100_log after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_tronc_iti for each row execute procedure m_mobilite_douce.ft_m_moddouce_log();
   
create trigger t_t1_refresh_iti after
insert
    or
delete
    or
update
    on
    m_mobilite_douce.lk_mob_tronc_iti for each row execute procedure m_mobilite_douce.ft_m_refresh_iti_lk();   
   
   
