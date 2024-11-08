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
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_an_v_statio_cycl_tab1;
drop view if exists m_mobilite_douce.xapps_geo_v_noeud_troncon_tab;
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
drop view if exists m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon;
drop view if exists m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat;
drop view if exists m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa;


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
	couvert varchar(1) not null default '00',
	surv varchar(1)not null default '00',
	lum varchar(1) not null default '00',
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
   
   
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                             VUE APPLICATIVE                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- #################################################################### vue xapps_an_v_amgt_cycl_tab ###############################################
   
 -- m_mobilite_douce.xapps_an_v_amgt_cycl_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_amgt_cycl_tab
AS WITH req_epci_dg AS (
        ( SELECT t.ame_d AS ame,
            t.gestio_d AS gestio,
            t.proprio_d AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            sum(t.lin_d) AS lineaire,
            t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_d::text = ea.code::text
          WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci_d, ea.valeur, ea.code, t.gestio_d, t.proprio_d
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_g AS ame,
            t.gestio_g AS gestio,
            t.proprio_g AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            sum(t.lin_g) AS lineaire,
            t.epci_g AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_g::text = ea.code::text
          WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci_g, ea.valeur, ea.code, t.gestio_g, t.proprio_g
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_g AS ame,
            t.gestio_g AS gestio,
            t.proprio_g AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            sum(t.lin_g) AS lineaire,
            t.epci_g AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_g::text = ea.code::text
          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbetat_g::text = '40'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci_g, ea.valeur, ea.code, t.gestio_g, t.proprio_g
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_d AS ame,
            t.gestio_d AS gestio,
            t.proprio_d AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            sum(t.lin_d) AS lineaire,
            t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_d::text = ea.code::text
          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbetat_d::text = '40'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci_d, ea.valeur, ea.code, t.gestio_d, t.proprio_d
          ORDER BY am.valeur)
        ), req_epci AS (
         SELECT DISTINCT t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
        )
 SELECT e.epci,
    d.ame,
    d.gestio,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(d.gestio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_g g
             LEFT JOIN r_objet.lt_gestio_proprio l ON g.code = l.code::text) AS lib_gestio,
    d.proprio,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(d.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_p p
             LEFT JOIN r_objet.lt_gestio_proprio l ON p.code = l.code::text) AS lib_proprio,
    d.cod_avancement,
    d.avancement,
    d.lib_ame,
        CASE
            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
            ELSE sum(d.lineaire)
        END AS lineaire
   FROM req_epci e
     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
  WHERE e.epci::text = ANY (ARRAY['arc'::character varying::text, 'cc2v'::character varying::text, 'ccpe'::character varying::text, 'cclo'::character varying::text])
  GROUP BY e.epci, d.ame, d.lib_ame, d.avancement, d.cod_avancement, d.gestio, d.proprio;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_amgt_cycl_tab IS 'Vue attributaire pour la génération du TAB (synthèse du linéaire d''aménagement en service par EPCI )';

   
-- #################################################################### vue xapps_an_v_cycl_tab1 ###############################################

-- m_mobilite_douce.xapps_an_v_cycl_tab1 source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_cycl_tab1
AS WITH req_lin_double AS (
         WITH req_epci_dg AS (
                ( SELECT t.ame_d AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_d) AS lineaire,
                    t.epci_d AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_g::text = 'ZZ'::text AND t.ame_d::text <> '90'::text AND t.ame_d::text <> '00'::text AND t.dbetat_d::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_d, am.valeur, t.epci_d
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_g AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_g) AS lineaire,
                    t.epci_g AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_d::text = 'ZZ'::text AND t.ame_g::text <> '90'::text AND t.ame_g::text <> '00'::text AND t.dbetat_g::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_g, am.valeur, t.epci_g
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_g AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_g) AS lineaire,
                    t.epci_g AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.ame_g::text <> '90'::text AND t.ame_g::text <> '00'::text AND t.dbetat_g::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_g, am.valeur, t.epci_g
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_d AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_d) AS lineaire,
                    t.epci_d AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.ame_d::text <> '90'::text AND t.ame_d::text <> '00'::text AND t.dbetat_d::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_d, am.valeur, t.epci_d
                  ORDER BY am.valeur)
                ), req_epci AS (
                 SELECT DISTINCT geo_vm_osm_epci_grdc.epci,
                    geo_vm_osm_epci_grdc.lib_epci
                   FROM r_osm.geo_vm_osm_epci_grdc
                )
         SELECT e_1.epci,
            e_1.lib_epci,
                CASE
                    WHEN sum(d_1.lineaire) IS NULL THEN 0::numeric
                    ELSE sum(d_1.lineaire)
                END AS lineaire_ame_2
           FROM req_epci e_1
             LEFT JOIN req_epci_dg d_1 ON e_1.epci = d_1.epci::text
          GROUP BY e_1.epci, e_1.lib_epci
        ), req_lin_simple_1 AS (
         WITH req_epci_dg_1 AS (
                ( SELECT t.ame_d AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_d) AS lineaire,
                    t.epci_d AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_g::text = 'ZZ'::text AND t.ame_d::text <> '90'::text AND t.ame_d::text <> '00'::text AND t.dbetat_d::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_d, am.valeur, t.epci_d
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_g AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_g) AS lineaire,
                    t.epci_g AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_d::text = 'ZZ'::text AND t.ame_g::text <> '90'::text AND t.ame_g::text <> '00'::text AND t.dbetat_g::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_g, am.valeur, t.epci_g
                  ORDER BY am.valeur)
                ), req_epci AS (
                 SELECT DISTINCT geo_vm_osm_epci_grdc.epci,
                    geo_vm_osm_epci_grdc.lib_epci
                   FROM r_osm.geo_vm_osm_epci_grdc
                )
         SELECT e_1.epci,
            e_1.lib_epci,
                CASE
                    WHEN sum(d1_1.lineaire) IS NULL THEN 0::numeric
                    ELSE sum(d1_1.lineaire)
                END AS lineaire_ame_11
           FROM req_epci e_1
             LEFT JOIN req_epci_dg_1 d1_1 ON e_1.epci = d1_1.epci::text
          GROUP BY e_1.epci, e_1.lib_epci
        ), req_lin_simple_2 AS (
         WITH req_epci_dg_2 AS (
                ( SELECT t.ame_g AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_g) AS lineaire,
                    t.epci_g AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.ame_g::text <> '90'::text AND t.ame_g::text <> '00'::text AND t.dbetat_g::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_g, am.valeur, t.epci_g
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_d AS ame,
                    am.valeur AS lib_ame,
                    sum(t.lin_d) AS lineaire,
                    t.epci_d AS epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                  WHERE t.typ_mob::text = '10'::text AND t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.ame_d::text <> '90'::text AND t.ame_d::text <> '00'::text AND t.dbetat_d::text = '40'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_d, am.valeur, t.epci_d
                  ORDER BY am.valeur)
                ), req_epci AS (
                 SELECT DISTINCT geo_vm_osm_epci_grdc.epci,
                    geo_vm_osm_epci_grdc.lib_epci
                   FROM r_osm.geo_vm_osm_epci_grdc
                )
         SELECT e_1.epci,
            e_1.lib_epci,
            count(*) AS nb,
                CASE
                    WHEN sum(d2_1.lineaire) IS NULL THEN 0::numeric
                    ELSE
                    CASE
                        WHEN count(*) >= 2 THEN sum(d2_1.lineaire) / 2::numeric
                        ELSE sum(d2_1.lineaire)
                    END
                END AS lineaire_ame_12
           FROM req_epci e_1
             LEFT JOIN req_epci_dg_2 d2_1 ON e_1.epci = d2_1.epci::text
          GROUP BY e_1.epci, e_1.lib_epci
        ), req_voie AS (
         SELECT
                CASE
                    WHEN t.cepci::text = '200067965'::text THEN 'arc'::text
                    WHEN t.cepci::text = '246000897'::text THEN 'ccpe'::text
                    WHEN t.cepci::text = '246000749'::text THEN 'cclo'::text
                    WHEN t.cepci::text = '246000772'::text THEN 'cc2v'::text
                    ELSE NULL::text
                END AS epci,
            sum(t.long_troncon) AS lineaire_voie
           FROM x_apps.xapps_geo_vmr_troncon_voirie t
             LEFT JOIN r_voie.lt_type_tronc tt ON tt.valeur::text = t.type_tronc::text
          WHERE (t.cepci::text = ANY (ARRAY['200067965'::character varying::text, '246000749'::character varying::text, '246000897'::character varying::text, '246000772'::character varying::text])) AND (tt.code::text <> ALL (ARRAY['15'::character varying::text, '30'::character varying::text, '31'::character varying::text, '33'::character varying::text, '40'::character varying::text, '41'::character varying::text, '99'::character varying::text, 'ZZ'::character varying::text, '00'::character varying::text, '12'::character varying::text]))
          GROUP BY t.cepci
        ), req_statio AS (
         SELECT s_1.epci,
            count(*) AS nb_lieu,
            sum(s_1.cap) AS nb_place
           FROM m_mobilite_douce.geo_mob_statio_cycl s_1
          WHERE s_1.dbetat::text = '40'::text AND s_1.dbstatut::text = '10'::text
          GROUP BY s_1.epci
        ), req_nb_i_cycl AS (
         SELECT i.epci,
            count(*) AS nb_iti
           FROM m_mobilite_douce.an_mob_iti_cycl i
          WHERE i.epci IS NOT NULL AND i.dbetat::text = '40'::text AND i.dbstatut::text = '10'::text
          GROUP BY i.epci
        ), req_lin_i_cycl AS (
         SELECT i.epci,
            round(sum(st_length(t.geom))::numeric, 0) AS long_iti
           FROM m_mobilite_douce.an_mob_iti_cycl i
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti ti ON ti.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.geo_mob_troncon t ON t.id_tronc = ti.id_tronc
          WHERE i.dbetat::text = '40'::text AND i.dbstatut::text = '10'::text AND i.epci IS NOT NULL
          GROUP BY i.epci
        ), req_nb_i_rand AS (
         SELECT i.epci,
            count(*) AS nb_iti
           FROM m_mobilite_douce.an_mob_iti_rand i
          WHERE i.epci IS NOT NULL AND i.dbetat::text = '40'::text AND i.dbstatut::text = '10'::text
          GROUP BY i.epci
        ), req_lin_i_rand AS (
         SELECT i.epci,
            round(sum(st_length(t.geom))::numeric, 0) AS long_iti
           FROM m_mobilite_douce.an_mob_iti_rand i
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti ti ON ti.id_iti = i.id_itirand
             LEFT JOIN m_mobilite_douce.geo_mob_troncon t ON t.id_tronc = ti.id_tronc
          WHERE i.dbetat::text = '40'::text AND i.dbstatut::text = '10'::text AND i.epci IS NOT NULL
          GROUP BY i.epci
        ), req_epci AS (
         SELECT DISTINCT geo_vm_osm_epci_grdc.epci,
            geo_vm_osm_epci_grdc.lib_epci,
                CASE
                    WHEN geo_vm_osm_epci_grdc.epci = 'arc'::text THEN 'https://geo.compiegnois.fr/documents/metiers/mob/logo/logo_arc.png'::text
                    WHEN geo_vm_osm_epci_grdc.epci = 'ccpe'::text THEN 'https://geo.compiegnois.fr/documents/metiers/mob/logo/logo_ccpe.png'::text
                    WHEN geo_vm_osm_epci_grdc.epci = 'cclo'::text THEN 'https://geo.compiegnois.fr/documents/metiers/mob/logo/logo_cclo.png'::text
                    WHEN geo_vm_osm_epci_grdc.epci = 'cc2v'::text THEN 'https://geo.compiegnois.fr/documents/metiers/mob/logo/logo_cc2v.png'::text
                    ELSE NULL::text
                END AS logo_epci
           FROM r_osm.geo_vm_osm_epci_grdc
        )
 SELECT e.epci,
    e.lib_epci,
    e.logo_epci,
        CASE
            WHEN d.lineaire_ame_2 IS NULL THEN 0::numeric
            ELSE d.lineaire_ame_2
        END AS lineaire_ame_2,
        CASE
            WHEN (d1.lineaire_ame_11 + d2.lineaire_ame_12) IS NULL THEN 0::numeric
            ELSE d1.lineaire_ame_11 + d2.lineaire_ame_12
        END AS lineaire_ame_1,
        CASE
            WHEN (d1.lineaire_ame_11 + d2.lineaire_ame_12) IS NULL THEN 0::numeric
            ELSE d1.lineaire_ame_11 + d2.lineaire_ame_12
        END / v.lineaire_voie::numeric * 100::numeric AS ratio_v_ame,
        CASE
            WHEN s.nb_lieu IS NULL THEN 0::bigint
            ELSE s.nb_lieu
        END AS nb_lieu,
        CASE
            WHEN s.nb_place IS NULL THEN 0::bigint
            ELSE s.nb_place
        END AS nb_place,
        CASE
            WHEN ic.nb_iti IS NULL THEN 0::bigint
            ELSE ic.nb_iti
        END AS nb_iti_cycl,
        CASE
            WHEN lc.long_iti IS NULL THEN 0::numeric
            ELSE lc.long_iti
        END AS long_iti_cylc,
        CASE
            WHEN ir.nb_iti IS NULL THEN 0::bigint
            ELSE ir.nb_iti
        END AS nb_iti_rand,
        CASE
            WHEN lr.long_iti IS NULL THEN 0::numeric
            ELSE lr.long_iti
        END AS long_iti_rand
   FROM req_epci e
     LEFT JOIN req_lin_double d ON e.epci = d.epci
     LEFT JOIN req_lin_simple_1 d1 ON e.epci = d1.epci
     LEFT JOIN req_lin_simple_2 d2 ON e.epci = d2.epci
     LEFT JOIN req_statio s ON e.epci = s.epci::text
     LEFT JOIN req_nb_i_cycl ic ON e.epci = ic.epci
     LEFT JOIN req_lin_i_cycl lc ON e.epci = lc.epci
     LEFT JOIN req_nb_i_rand ir ON e.epci = ir.epci
     LEFT JOIN req_lin_i_rand lr ON e.epci = lr.epci
     LEFT JOIN req_voie v ON e.epci = v.epci;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_cycl_tab1 IS 'Vue attributaire des indicateurs génériques cyclables par EPCI';

   
-- #################################################################### vue xapps_an_v_iti_ame_pan_tab ###############################################

 -- m_mobilite_douce.xapps_an_v_iti_ame_pan_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_iti_ame_pan_tab
AS WITH req_pan AS (
         SELECT s.id_pan,
            i.id_iticycl,
            r.id_itirand,
            i.dbstatut AS dbstatut_iti_cycl,
            r.dbstatut AS dbstatut_iti_rand,
            i.dbetat AS dbetat_iti_cycl,
            r.dbetat AS dbetat_iti_rand,
            count(s.code_pan) AS nb_pan,
            s.code_pan,
            cp.url AS url_pan,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.geo_mob_pan s ON s.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.lt_mob_pan_codepan cp ON cp.code::text = s.code_pan::text
          WHERE (i.id_iticycl IS NOT NULL OR r.id_itirand IS NOT NULL) AND cp.url IS NOT NULL
          GROUP BY i.id_iticycl, cp.url, t.epci, s.code_pan, r.id_itirand, s.id_pan, i.dbstatut, r.dbstatut, i.dbetat, r.dbetat
        ), req_pn AS (
         SELECT s.id_pan,
            i.id_iticycl,
            r.id_itirand,
            count(p_1.code_pn) AS nb_pn,
            cp.url AS url_pn,
            p_1.code_pn,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.geo_mob_pan s ON s.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_pn p_1 ON p_1.id_pan = s.id_pan
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.lt_mob_pan_codepan cp ON cp.code::text = p_1.code_pn::text
          WHERE (i.id_iticycl IS NOT NULL OR r.id_itirand IS NOT NULL) AND cp.url IS NOT NULL
          GROUP BY i.id_iticycl, cp.url, t.epci, p_1.code_pn, r.id_itirand, s.id_pan
        )
 SELECT row_number() OVER () AS id,
    pan.id_iticycl,
    pan.id_itirand,
    pan.dbstatut_iti_cycl,
    pan.dbstatut_iti_rand,
    pan.dbetat_iti_cycl,
    pan.dbetat_iti_rand,
    pan.nb_pan,
    pan.code_pan,
    pan.url_pan,
        CASE
            WHEN pn.nb_pn IS NULL THEN 0::bigint
            ELSE pn.nb_pn
        END AS nb_pn,
    pn.code_pn,
    pn.url_pn,
    p.gestio,
    p.proprio,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(p.gestio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_g g
             LEFT JOIN r_objet.lt_gestio_proprio l ON g.code = l.code::text) AS lib_gestio,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(p.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_p p_1
             LEFT JOIN r_objet.lt_gestio_proprio l ON p_1.code = l.code::text) AS lib_proprio,
    pan.epci
   FROM m_mobilite_douce.geo_mob_pan p
     LEFT JOIN req_pan pan ON pan.id_pan = p.id_pan
     LEFT JOIN req_pn pn ON pn.id_pan = p.id_pan
  WHERE (pan.id_iticycl IS NOT NULL OR pan.id_itirand IS NOT NULL) AND (pan.dbstatut_iti_cycl::text = '10'::text OR pan.dbstatut_iti_rand::text = '10'::text);

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_iti_ame_pan_tab IS 'Vue attributaire pour la génération du TAB (liste des panneaux présent sur l''itinéraire)';

   
-- #################################################################### vue xapps_an_v_iti_ame_tab ###############################################

-- m_mobilite_douce.xapps_an_v_iti_ame_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_iti_ame_tab
AS WITH req_fin AS (
         WITH req_epci_dg AS (
                ( SELECT t.ame_d AS ame,
                    am.valeur AS lib_ame,
                    s.valeur AS dbetat,
                    sum(t.lin_d) AS lineaire,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    i_2.id_iticycl,
                    r.id_itirand,
                    t.id_tronc,
                    i_2.numero,
                    i_2.nomoff,
                    i_2.dbetat AS dbetat_iti_cycl,
                    r.dbetat AS dbetat_iti_rand,
                    i_2.dbstatut AS dbstatut_iti_cycl,
                    r.dbstatut AS dbstatut_iti_rand,
                    p.id_plan,
                    p.libelle AS libelle_plan,
                    t.epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i_2 ON i_2.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i_2.id_iticycl
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                  WHERE t.ame_g::text = 'ZZ'::text AND (i_2.dbstatut::text = '10'::text OR r.dbstatut::text = '10'::text)
                  GROUP BY t.ame_d, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbetat, r.dbetat, i_2.dbstatut, r.dbstatut
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_g AS ame,
                    am.valeur AS lib_ame,
                    s.valeur AS dbetat,
                    sum(t.lin_g) AS lineaire,
                    t.gestio_g AS gestio,
                    t.proprio_g AS proprio,
                    i_2.id_iticycl,
                    r.id_itirand,
                    t.id_tronc,
                    i_2.numero,
                    i_2.nomoff,
                    i_2.dbetat AS dbetat_iti_cycl,
                    r.dbetat AS dbetat_iti_rand,
                    i_2.dbstatut AS dbstatut_iti_cycl,
                    r.dbstatut AS dbstatut_iti_rand,
                    p.id_plan,
                    p.libelle AS libelle_plan,
                    t.epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i_2 ON i_2.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i_2.id_iticycl
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                  WHERE t.ame_d::text = 'ZZ'::text AND (i_2.dbstatut::text = '10'::text OR r.dbstatut::text = '10'::text)
                  GROUP BY t.ame_g, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbetat, r.dbetat, i_2.dbstatut, r.dbstatut
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_g AS ame,
                    am.valeur AS lib_ame,
                    s.valeur AS dbetat,
                    sum(t.lin_g) AS lineaire,
                    t.gestio_g AS gestio,
                    t.proprio_g AS proprio,
                    i_2.id_iticycl,
                    r.id_itirand,
                    t.id_tronc,
                    i_2.numero,
                    i_2.nomoff,
                    i_2.dbetat AS dbetat_iti_cycl,
                    r.dbetat AS dbetat_iti_rand,
                    i_2.dbstatut AS dbstatut_iti_cycl,
                    r.dbstatut AS dbstatut_iti_rand,
                    p.id_plan,
                    p.libelle AS libelle_plan,
                    t.epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i_2 ON i_2.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i_2.id_iticycl
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                  WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND (i_2.dbstatut::text = '10'::text OR r.dbstatut::text = '10'::text)
                  GROUP BY t.ame_g, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbetat, r.dbetat, i_2.dbstatut, r.dbstatut
                  ORDER BY am.valeur)
                UNION ALL
                ( SELECT t.ame_d AS ame,
                    am.valeur AS lib_ame,
                    s.valeur AS dbetat,
                    sum(t.lin_d) AS lineaire,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    i_2.id_iticycl,
                    r.id_itirand,
                    t.id_tronc,
                    i_2.numero,
                    i_2.nomoff,
                    i_2.dbetat AS dbetat_iti_cycl,
                    r.dbetat AS dbetat_iti_rand,
                    i_2.dbstatut AS dbstatut_iti_cycl,
                    r.dbstatut AS dbstatut_iti_rand,
                    p.id_plan,
                    p.libelle AS libelle_plan,
                    t.epci
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i_2 ON i_2.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i_2.id_iticycl
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                  WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND (i_2.dbstatut::text = '10'::text OR r.dbstatut::text = '10'::text)
                  GROUP BY t.ame_d, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbstatut, r.dbstatut, i_2.dbetat, r.dbetat
                  ORDER BY am.valeur)
                )
         SELECT d.ame,
            d.lib_ame,
            d.dbetat,
                CASE
                    WHEN sum(d.lineaire) IS NULL THEN 0::numeric
                    ELSE sum(d.lineaire)
                END AS lineaire,
            d.gestio,
            d.proprio,
            d.id_iticycl,
            d.id_itirand,
            d.id_tronc,
            d.numero,
            d.nomoff,
            d.id_plan,
            d.libelle_plan,
            d.epci,
            d.dbstatut_iti_cycl,
            d.dbstatut_iti_rand,
            i_1.n_itivar,
            i_1.id_itivar
           FROM req_epci_dg d
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i_1 ON i_1.id_iticycl = d.id_iticycl
          WHERE d.id_iticycl IS NOT NULL OR d.id_itirand IS NOT NULL
          GROUP BY d.ame, d.lib_ame, d.dbetat, d.id_iticycl, d.numero, d.nomoff, d.id_plan, d.libelle_plan, d.epci, d.id_tronc, i_1.n_itivar, i_1.numero, i_1.nomoff, i_1.id_itivar, d.id_itirand, d.dbstatut_iti_cycl, d.dbstatut_iti_rand, d.gestio, d.proprio
        )
 SELECT row_number() OVER () AS gid,
    req_fin.ame,
    req_fin.lib_ame,
    req_fin.dbetat,
    req_fin.lineaire,
    req_fin.gestio,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(req_fin.gestio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_g g
             LEFT JOIN r_objet.lt_gestio_proprio l ON g.code = l.code::text) AS lib_gestio,
    req_fin.proprio,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(req_fin.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_p p
             LEFT JOIN r_objet.lt_gestio_proprio l ON p.code = l.code::text) AS lib_proprio,
    req_fin.id_iticycl,
    req_fin.id_itirand,
    req_fin.id_tronc,
    req_fin.numero,
    req_fin.nomoff,
    s1.valeur AS dbstatut_iti_cycl,
    s2.valeur AS dbstatut_iti_rand,
    req_fin.id_plan,
    req_fin.libelle_plan,
    req_fin.epci,
    req_fin.n_itivar,
    req_fin.id_itivar,
        CASE
            WHEN req_fin.n_itivar IS NULL OR req_fin.n_itivar::text = ''::text THEN
            CASE
                WHEN req_fin.numero IS NOT NULL OR req_fin.numero::text <> ''::text THEN req_fin.numero::text || ' - '::text
                ELSE ''::text
            END || req_fin.nomoff::text
            ELSE (((req_fin.n_itivar::text || ' (variante de l''itinéraire '::text) ||
            CASE
                WHEN req_fin.numero IS NOT NULL OR req_fin.numero::text <> ''::text THEN req_fin.numero::text || ' - '::text
                ELSE ''::text
            END) || req_fin.nomoff::text) || ')'::text
        END AS lib_n_itivar
   FROM req_fin
     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = req_fin.id_itivar
     LEFT JOIN r_objet.lt_statut s1 ON s1.code::text = req_fin.dbstatut_iti_cycl::text
     LEFT JOIN r_objet.lt_statut s2 ON s2.code::text = req_fin.dbstatut_iti_rand::text;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_iti_ame_tab IS 'Vue attributaire pour la génération du TAB (statut et type d''aménagement par itinéraire)';


   
   
-- #################################################################### vue xapps_an_v_iti_cycl_tab ###############################################   

-- m_mobilite_douce.xapps_an_v_iti_cycl_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_iti_cycl_tab
AS WITH req_epci_dg AS (
        ( SELECT t.ame_d AS ame,
            am.valeur AS lib_ame,
            s.valeur AS dbetat,
            sum(t.lin_d) AS lineaire,
            i.id_iticycl,
            i.numero,
            i.nomoff,
            i.dbstatut,
            p.id_plan,
            p.libelle AS libelle_plan,
            t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_g::text = 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci_d, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_g AS ame,
            am.valeur AS lib_ame,
            s.valeur AS dbetat,
            sum(t.lin_g) AS lineaire,
            i.id_iticycl,
            i.numero,
            i.nomoff,
            i.dbstatut,
            p.id_plan,
            p.libelle AS libelle_plan,
            t.epci_g AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_d::text = 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci_g, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_g AS ame,
            am.valeur AS lib_ame,
            s.valeur AS dbetat,
            sum(t.lin_g) AS lineaire,
            i.id_iticycl,
            i.numero,
            i.nomoff,
            i.dbstatut,
            p.id_plan,
            p.libelle AS libelle_plan,
            t.epci_g AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci_g, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_d AS ame,
            am.valeur AS lib_ame,
            s.valeur AS dbetat,
            sum(t.lin_d) AS lineaire,
            i.id_iticycl,
            i.numero,
            i.nomoff,
            i.dbstatut,
            p.id_plan,
            p.libelle AS libelle_plan,
            t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci_d, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        ), req_epci AS (
         SELECT DISTINCT t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
        )
 SELECT e.epci,
    d.ame,
    d.lib_ame,
    d.dbetat,
    d.dbstatut,
        CASE
            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
            ELSE sum(d.lineaire)
        END AS lineaire,
    d.id_iticycl,
    d.numero,
    d.nomoff,
    d.id_plan,
    d.libelle_plan
   FROM req_epci e
     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
  WHERE d.id_iticycl IS NOT NULL
  GROUP BY e.epci, d.ame, d.lib_ame, d.dbstatut, d.dbetat, d.id_iticycl, d.numero, d.nomoff, d.id_plan, d.libelle_plan;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_iti_cycl_tab IS 'Vue attributaire pour la génération du TAB (synthèse du linéaire d''aménagement en service par EPCI et par itinéraire (dont plan) )';


-- #################################################################### vue xapps_an_v_iti_tab ###############################################

-- m_mobilite_douce.xapps_an_v_iti_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_iti_tab
AS ( WITH req_epci_dg AS (
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_d) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            i.id_iticycl,
            NULL::text AS id_itirand,
            i.numero,
            i.nomoff,
            i.n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_g::text = 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_g) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            i.id_iticycl,
            NULL::text AS id_itirand,
            i.numero,
            i.nomoff,
            i.n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_d::text = 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_g) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            i.id_iticycl,
            NULL::text AS id_itirand,
            i.numero,
            i.nomoff,
            i.n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_d) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            i.id_iticycl,
            NULL::text AS id_itirand,
            i.numero,
            i.nomoff,
            i.n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        ), req_epci AS (
         SELECT DISTINCT t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
        )
 SELECT row_number() OVER () AS id,
    e.epci,
        CASE
            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
            ELSE sum(d.lineaire)
        END AS lineaire,
        CASE
            WHEN d.cout IS NULL THEN 0::numeric
            ELSE d.cout::numeric
        END AS cout,
        CASE
            WHEN d.subv IS NULL THEN 0::numeric
            ELSE d.subv::numeric
        END AS subv,
    d.dbetat,
    d.id_iticycl,
    d.id_itirand,
    d.numero,
    d.nomoff,
        CASE
            WHEN d.n_itivar IS NULL OR d.n_itivar::text = ''::text THEN
            CASE
                WHEN d.numero IS NOT NULL OR d.numero::text <> ''::text THEN d.numero::text || ' - '::text
                ELSE ''::text
            END || d.nomoff::text
            ELSE (((d.n_itivar::text || ' (variante de l''itinéraire '::text) ||
            CASE
                WHEN d.numero IS NOT NULL OR d.numero::text <> ''::text THEN d.numero::text || ' - '::text
                ELSE ''::text
            END) || d.nomoff::text) || ')'::text
        END AS aff_nom_iti
   FROM req_epci e
     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
  WHERE d.id_iticycl IS NOT NULL
  GROUP BY e.epci, d.id_iticycl, d.id_itirand, d.numero, d.nomoff, d.dbetat, d.cout, d.subv, d.n_itivar)
UNION ALL
( WITH req_epci_dg AS (
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_d) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            NULL::text AS id_iticycl,
            i.id_itirand,
            i.numero,
            i.nomoff,
            NULL::text AS n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_g::text = 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_g) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            NULL::text AS id_iticycl,
            i.id_itirand,
            i.numero,
            i.nomoff,
            NULL::text AS n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_d::text = 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_g) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            NULL::text AS id_iticycl,
            i.id_itirand,
            i.numero,
            i.nomoff,
            NULL::text AS n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT s.valeur AS dbetat,
            sum(t.lin_d) AS lineaire,
            i.p_cout AS cout,
            i.p_subv AS subv,
            NULL::text AS id_iticycl,
            i.id_itirand,
            i.numero,
            i.nomoff,
            NULL::text AS n_itivar,
            t.epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND i.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, s.valeur, p.id_plan, p.libelle
          ORDER BY am.valeur)
        ), req_epci AS (
         SELECT DISTINCT t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
        )
 SELECT row_number() OVER () AS id,
    e.epci,
        CASE
            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
            ELSE sum(d.lineaire)
        END AS lineaire,
        CASE
            WHEN d.cout IS NULL THEN 0::numeric
            ELSE d.cout::numeric
        END AS cout,
        CASE
            WHEN d.subv IS NULL THEN 0::numeric
            ELSE d.subv::numeric
        END AS subv,
    d.dbetat,
    d.id_iticycl,
    d.id_itirand,
    d.numero,
    d.nomoff,
        CASE
            WHEN d.n_itivar IS NULL OR d.n_itivar = ''::text THEN
            CASE
                WHEN d.numero IS NOT NULL OR d.numero::text <> ''::text THEN d.numero::text || ' - '::text
                ELSE ''::text
            END || d.nomoff::text
            ELSE (((d.n_itivar || ' (variante de l''itinéraire '::text) ||
            CASE
                WHEN d.numero IS NOT NULL OR d.numero::text <> ''::text THEN d.numero::text || ' - '::text
                ELSE ''::text
            END) || d.nomoff::text) || ')'::text
        END AS aff_nom_iti
   FROM req_epci e
     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
  WHERE d.id_itirand IS NOT NULL
  GROUP BY e.epci, d.id_iticycl, d.id_itirand, d.numero, d.nomoff, d.dbetat, d.cout, d.subv, d.n_itivar);

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_iti_tab IS 'Vue attributaire pour la génération du TAB (synthèse du linéaire d''aménagement en service par EPCI et par itinéraire )';


-- #################################################################### vue xapps_an_v_statio_cycl_tab1 ###############################################

-- m_mobilite_douce.xapps_an_v_statio_cycl_tab1 source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_statio_cycl_tab1
AS WITH req_commune AS (
         SELECT geo_mob_statio_cycl.insee,
            geo_mob_statio_cycl.commune,
            geo_mob_statio_cycl.epci,
            sum(
                CASE
                    WHEN geo_mob_statio_cycl.cap IS NULL THEN 0
                    ELSE geo_mob_statio_cycl.cap::integer
                END) AS cap,
            sum(
                CASE
                    WHEN geo_mob_statio_cycl.cap_cargo IS NULL THEN 0
                    ELSE geo_mob_statio_cycl.cap_cargo::integer
                END) AS cap_cargo
           FROM m_mobilite_douce.geo_mob_statio_cycl
          WHERE geo_mob_statio_cycl.dbetat::text = '40'::text AND geo_mob_statio_cycl.dbstatut::text = '10'::text
          GROUP BY geo_mob_statio_cycl.insee, geo_mob_statio_cycl.commune, geo_mob_statio_cycl.epci
        ), req_nb_lieu AS (
         SELECT geo_mob_statio_cycl.insee,
            geo_mob_statio_cycl.commune,
            geo_mob_statio_cycl.epci,
            count(*) AS nb_lieu
           FROM m_mobilite_douce.geo_mob_statio_cycl
          WHERE geo_mob_statio_cycl.dbetat::text = '40'::text AND geo_mob_statio_cycl.dbstatut::text = '10'::text
          GROUP BY geo_mob_statio_cycl.insee, geo_mob_statio_cycl.commune, geo_mob_statio_cycl.epci
        )
 SELECT c.insee,
    c.commune,
    c.epci,
    c.cap,
    c.cap_cargo,
    l.nb_lieu
   FROM req_commune c,
    req_nb_lieu l
  WHERE c.insee::text = l.insee::text
  ORDER BY l.insee;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_statio_cycl_tab1 IS 'Vue attributaire pour la génération du TAB (synthèse par commune )';



-- #################################################################### vue xapps_geo_v_noeud_troncon_tab ###############################################

-- m_mobilite_douce.xapps_geo_v_noeud_troncon_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_geo_v_noeud_troncon_tab
AS WITH req_tronc AS (
         SELECT t.id_tronc,
            i.id_iticycl,
            r.id_itirand,
            t.epci,
            st_startpoint((st_dump(t.geom)).geom) AS geom
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
          WHERE t.dbstatut::text = '10'::text
        UNION ALL
         SELECT t.id_tronc,
            i.id_iticycl,
            r.id_itirand,
            t.epci,
            st_endpoint((st_dump(t.geom)).geom) AS geom
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
             LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
          WHERE t.dbstatut::text = '10'::text
        )
 SELECT row_number() OVER () AS gid,
    req_tronc.id_tronc,
    req_tronc.id_iticycl,
    req_tronc.id_itirand,
    req_tronc.epci,
    req_tronc.geom::geometry(Point,2154) AS geom
   FROM req_tronc;

COMMENT ON VIEW m_mobilite_douce.xapps_geo_v_noeud_troncon_tab IS 'Vue géographique des extrémités des tronçons';




-- #################################################################### vue lt_vmr_mob_pan_typcode ###############################################

-- m_mobilite_douce.lt_vmr_mob_pan_typcode source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_pan_typcode
TABLESPACE pg_default
AS SELECT ts.code AS code_typsign,
    ts.valeur AS val_typsign,
    tp.code AS code_typpan,
    tp.typpan AS val_typpan,
    cp.code AS code_pan,
    cp.url
   FROM m_mobilite_douce.lt_mob_pan_typsign ts
     LEFT JOIN m_mobilite_douce.lt_mob_pan_typpan tp ON ts.code::text = tp.typsign::text
     LEFT JOIN m_mobilite_douce.lt_mob_pan_codepan cp ON cp.typpan::text = tp.code::text
  WHERE tp.code::text <> '60'::text
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_pan_typcode IS 'Vue matériliasée des types et codes des panneaux pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_acces ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_acces source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_acces
TABLESPACE pg_default
AS SELECT lt_mob_tronc_acces.code,
    lt_mob_tronc_acces.valeur,
        CASE
            WHEN lt_mob_tronc_acces.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying]::text[]) THEN '10'::text
            ELSE '20'::text
        END AS typ
   FROM m_mobilite_douce.lt_mob_tronc_acces
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_acces IS 'Vue matériliasée des accès par type de mobilité pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_ame ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_ame source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_ame
TABLESPACE pg_default
AS WITH req_final AS (
        ( WITH req_tot AS (
                 WITH req_ame_dg AS (
                         SELECT lt_mob_tronc_ame.code,
                            lt_mob_tronc_ame.valeur,
                                CASE
                                    WHEN lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '21'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[]) THEN '11'::text
                                    ELSE NULL::text
                                END AS dg
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                        UNION ALL
                         SELECT lt_mob_tronc_ame.code,
                            lt_mob_tronc_ame.valeur,
                                CASE
                                    WHEN lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '21'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[]) THEN '12'::text
                                    ELSE NULL::text
                                END AS dg
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                        UNION ALL
                         SELECT lt_mob_tronc_ame.code,
                            lt_mob_tronc_ame.valeur,
                                CASE
                                    WHEN lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '21'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[]) THEN '20'::text
                                    ELSE NULL::text
                                END AS dg
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                        )
                 SELECT req_ame_dg.code,
                    req_ame_dg.valeur,
                    req_ame_dg.dg
                   FROM req_ame_dg
                  WHERE req_ame_dg.dg IS NOT NULL
                  ORDER BY req_ame_dg.code
                )
         SELECT req_tot.code,
            req_tot.valeur,
            req_tot.dg,
                CASE
                    WHEN req_tot.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[]) THEN '10'::text
                    ELSE NULL::text
                END AS typ
           FROM req_tot)
        UNION ALL
        ( WITH req_tot AS (
                 WITH req_ame_dg AS (
                         SELECT lt_mob_tronc_ame.code,
                            lt_mob_tronc_ame.valeur,
                                CASE
                                    WHEN lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '21'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[]) THEN '11'::text
                                    ELSE NULL::text
                                END AS dg
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                        UNION ALL
                         SELECT lt_mob_tronc_ame.code,
                            lt_mob_tronc_ame.valeur,
                                CASE
                                    WHEN lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '21'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[]) THEN '12'::text
                                    ELSE NULL::text
                                END AS dg
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                        UNION ALL
                         SELECT lt_mob_tronc_ame.code,
                            lt_mob_tronc_ame.valeur,
                                CASE
                                    WHEN lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '21'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[]) THEN '20'::text
                                    ELSE NULL::text
                                END AS dg
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                        )
                 SELECT req_ame_dg.code,
                    req_ame_dg.valeur,
                    req_ame_dg.dg
                   FROM req_ame_dg
                  WHERE req_ame_dg.dg IS NOT NULL
                  ORDER BY req_ame_dg.code
                )
         SELECT req_tot.code,
            req_tot.valeur,
            req_tot.dg,
                CASE
                    WHEN req_tot.code::text = ANY (ARRAY['00'::character varying, '21'::character varying, '90'::character varying, 'ZZ'::character varying]::text[]) THEN '20'::text
                    ELSE NULL::text
                END AS typ
           FROM req_tot)
        )
 SELECT req_final.code,
    req_final.valeur,
    req_final.dg,
    req_final.typ
   FROM req_final
  WHERE req_final.typ IS NOT NULL
  ORDER BY req_final.code
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_ame IS 'Vue matérialisée des aménagements par position pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_local ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_local source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_local
TABLESPACE pg_default
AS SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '00'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '41'::character varying, '42'::character varying, '51'::character varying, '52'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '10'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '20'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '31'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '32'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '33'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '40'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = 'ZZ'::text
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '50'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '60'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '71'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = 'ZZ'::text
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '72'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = 'ZZ'::text
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '73'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['11'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '81'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = 'ZZ'::text
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '82'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '83'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '84'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '85'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '90'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, '40'::character varying, '41'::character varying, '42'::character varying, '51'::character varying, '52'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_local.code,
    lt_mob_tronc_local.valeur,
    '99'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_local
  WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_local IS 'Vue matérialisée des localisations des aménagements pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_regime ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_regime source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_regime
TABLESPACE pg_default
AS SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '00'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '10'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '20'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '31'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '32'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '33'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '40'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '50'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '60'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '71'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '72'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '73'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '81'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '82'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '83'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '84'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '85'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '90'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    '99'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_regime.code,
    lt_mob_tronc_regime.valeur,
    'ZZ'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_regime
  WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, 'ZZ'::character varying]::text[])
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_regime IS 'Vue matérialisée des régimes de circulation pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_res ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_res source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_res
TABLESPACE pg_default
AS SELECT lt_mob_tronc_res.code,
    lt_mob_tronc_res.valeur,
        CASE
            WHEN lt_mob_tronc_res.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '99'::character varying]::text[]) THEN '10'::text
            ELSE '20'::text
        END AS typ
   FROM m_mobilite_douce.lt_mob_tronc_res
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_res IS 'Vue matérialisée des types de réseaux pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_revet ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_revet source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_revet
TABLESPACE pg_default
AS SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '00'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '10'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '20'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '31'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '32'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '33'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '40'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '50'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '60'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '71'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '72'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '73'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '81'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '82'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '83'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '84'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '85'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '90'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    '99'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_revet.code,
    lt_mob_tronc_revet.valeur,
    'ZZ'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_revet
  WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_revet IS 'Vue matérialisée des revêtements des aménagements pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_tronc_sens ###############################################

-- m_mobilite_douce.lt_vmr_mob_tronc_sens source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_sens
TABLESPACE pg_default
AS SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '00'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '10'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '20'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '31'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '32'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '33'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '40'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '50'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '60'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '71'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '72'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '73'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '81'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '82'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '83'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '84'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '85'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '90'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    '99'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
UNION ALL
 SELECT lt_mob_tronc_sens.code,
    lt_mob_tronc_sens.valeur,
    'ZZ'::text AS ame
   FROM m_mobilite_douce.lt_mob_tronc_sens
  WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, 'ZZ'::character varying]::text[])
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_tronc_sens IS 'Vue matérialisée des sens de circulation pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue lt_vmr_mob_troncon ###############################################

-- m_mobilite_douce.lt_vmr_mob_troncon source

CREATE MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_troncon
TABLESPACE pg_default
AS WITH req_cycle_1 AS (
         WITH req_niv1 AS (
                 SELECT '1' AS niv,
                    lt_mob_tronc_typ.code AS code_typmob,
                    lt_mob_tronc_typ.valeur AS val_typmob
                   FROM m_mobilite_douce.lt_mob_tronc_typ
                  WHERE lt_mob_tronc_typ.code::text = '10'::text
                ), req_niv2 AS (
                 SELECT '1' AS niv,
                    lt_mob_tronc_acces.code AS code_acces,
                    lt_mob_tronc_acces.valeur AS val_access
                   FROM m_mobilite_douce.lt_mob_tronc_acces
                ), req_niv3 AS (
                 SELECT '1' AS niv,
                    lt_mob_tronc_res.code AS code_struct,
                        CASE
                            WHEN lt_mob_tronc_res.valeur::text = 'REV'::text THEN 'Résau Express Vélo (REV)'::character varying
                            ELSE lt_mob_tronc_res.valeur
                        END AS val_struct
                   FROM m_mobilite_douce.lt_mob_tronc_res
                ), req_niv4 AS (
                 SELECT '1' AS niv,
                    lt_mob_tronc_dg.code AS code_dg,
                    lt_mob_tronc_dg.valeur AS val_dg
                   FROM m_mobilite_douce.lt_mob_tronc_dg
                )
         SELECT n1.niv::text AS niv,
            n1.code_typmob::text AS code_typmob,
            n1.val_typmob::text AS val_typmob,
            n2.code_acces::text AS code_acces,
            n2.val_access::text AS val_access,
            n3.code_struct::text AS code_struct,
            n3.val_struct::text AS val_struct,
            n4.code_dg::text AS code_dg,
            n4.val_dg::text AS val_dg
           FROM req_niv1 n1
             LEFT JOIN req_niv2 n2 ON n1.niv::text = n2.niv::text
             LEFT JOIN req_niv3 n3 ON n1.niv::text = n3.niv::text
             LEFT JOIN req_niv4 n4 ON n1.niv::text = n4.niv::text
          ORDER BY n1.code_typmob, n2.code_acces, n3.code_struct, n4.code_dg
        ), req_niv5 AS (
        (
                (
                        (
                                (
(
  (
    (
      (
        (
          (
             SELECT '0011'::text AS code_dg,
                lt_mob_tronc_ame.code AS code_ame,
                lt_mob_tronc_ame.valeur AS val_ame
               FROM m_mobilite_douce.lt_mob_tronc_ame
              WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
            UNION
             SELECT '0012'::text AS code_dg,
                lt_mob_tronc_ame.code AS code_ame,
                lt_mob_tronc_ame.valeur AS val_ame
               FROM m_mobilite_douce.lt_mob_tronc_ame
              WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
            UNION
             SELECT '0020'::text AS code_dg,
                lt_mob_tronc_ame.code AS code_ame,
                lt_mob_tronc_ame.valeur AS val_ame
               FROM m_mobilite_douce.lt_mob_tronc_ame
              WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
          ) UNION ALL
           SELECT '1011'::text AS code_dg,
              lt_mob_tronc_ame.code AS code_ame,
              lt_mob_tronc_ame.valeur AS val_ame
             FROM m_mobilite_douce.lt_mob_tronc_ame
            WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '71'::character varying, '73'::character varying, '81'::character varying, '83'::character varying, '84'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        ) UNION
         SELECT '1012'::text AS code_dg,
            lt_mob_tronc_ame.code AS code_ame,
            lt_mob_tronc_ame.valeur AS val_ame
           FROM m_mobilite_douce.lt_mob_tronc_ame
          WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '71'::character varying, '73'::character varying, '83'::character varying, 'ZZ'::character varying]::text[])
        UNION
         SELECT '1020'::text AS code_dg,
            lt_mob_tronc_ame.code AS code_ame,
            lt_mob_tronc_ame.valeur AS val_ame
           FROM m_mobilite_douce.lt_mob_tronc_ame
          WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '71'::character varying, '73'::character varying, '83'::character varying, 'ZZ'::character varying]::text[])
      ) UNION ALL
       SELECT '2011'::text AS code_dg,
          lt_mob_tronc_ame.code AS code_ame,
          lt_mob_tronc_ame.valeur AS val_ame
         FROM m_mobilite_douce.lt_mob_tronc_ame
        WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
    ) UNION
     SELECT '2012'::text AS code_dg,
        lt_mob_tronc_ame.code AS code_ame,
        lt_mob_tronc_ame.valeur AS val_ame
       FROM m_mobilite_douce.lt_mob_tronc_ame
      WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
    UNION
     SELECT '2020'::text AS code_dg,
        lt_mob_tronc_ame.code AS code_ame,
        lt_mob_tronc_ame.valeur AS val_ame
       FROM m_mobilite_douce.lt_mob_tronc_ame
      WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
  ) UNION ALL
   SELECT '3011'::text AS code_dg,
      lt_mob_tronc_ame.code AS code_ame,
      lt_mob_tronc_ame.valeur AS val_ame
     FROM m_mobilite_douce.lt_mob_tronc_ame
    WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
) UNION
 SELECT '3012'::text AS code_dg,
    lt_mob_tronc_ame.code AS code_ame,
    lt_mob_tronc_ame.valeur AS val_ame
   FROM m_mobilite_douce.lt_mob_tronc_ame
  WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
UNION
 SELECT '3020'::text AS code_dg,
    lt_mob_tronc_ame.code AS code_ame,
    lt_mob_tronc_ame.valeur AS val_ame
   FROM m_mobilite_douce.lt_mob_tronc_ame
  WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
                                ) UNION ALL
                                 SELECT '4011'::text AS code_dg,
                                    lt_mob_tronc_ame.code AS code_ame,
                                    lt_mob_tronc_ame.valeur AS val_ame
                                   FROM m_mobilite_douce.lt_mob_tronc_ame
                                  WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
                        ) UNION
                         SELECT '4012'::text AS code_dg,
                            lt_mob_tronc_ame.code AS code_ame,
                            lt_mob_tronc_ame.valeur AS val_ame
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                          WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
                        UNION
                         SELECT '4020'::text AS code_dg,
                            lt_mob_tronc_ame.code AS code_ame,
                            lt_mob_tronc_ame.valeur AS val_ame
                           FROM m_mobilite_douce.lt_mob_tronc_ame
                          WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
                ) UNION ALL
                 SELECT 'ZZ11'::text AS code_dg,
                    lt_mob_tronc_ame.code AS code_ame,
                    lt_mob_tronc_ame.valeur AS val_ame
                   FROM m_mobilite_douce.lt_mob_tronc_ame
                  WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '31'::character varying, '32'::character varying, '33'::character varying, '40'::character varying, '50'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '81'::character varying, '82'::character varying, '83'::character varying, '84'::character varying, '85'::character varying, '90'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        ) UNION
         SELECT 'ZZ12'::text AS code_dg,
            lt_mob_tronc_ame.code AS code_ame,
            lt_mob_tronc_ame.valeur AS val_ame
           FROM m_mobilite_douce.lt_mob_tronc_ame
          WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
        UNION
         SELECT 'ZZ20'::text AS code_dg,
            lt_mob_tronc_ame.code AS code_ame,
            lt_mob_tronc_ame.valeur AS val_ame
           FROM m_mobilite_douce.lt_mob_tronc_ame
          WHERE lt_mob_tronc_ame.code::text = ANY (ARRAY['00'::character varying, '20'::character varying, '60'::character varying, '71'::character varying, '72'::character varying, '73'::character varying, '83'::character varying, '85'::character varying, 'ZZ'::character varying]::text[])
        ), req_niv6 AS (
         SELECT '00'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
        UNION ALL
         SELECT '10'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '20'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '31'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '32'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '33'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '40'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '50'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '60'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '71'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '72'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '73'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '81'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '82'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '83'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '84'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '85'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '90'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '99'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, '40'::character varying, '50'::character varying, '99'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT 'ZZ'::text AS code_ame,
            lt_mob_tronc_regime.code AS code_reg,
            lt_mob_tronc_regime.valeur AS val_reg
           FROM m_mobilite_douce.lt_mob_tronc_regime
          WHERE lt_mob_tronc_regime.code::text = ANY (ARRAY['00'::character varying, 'ZZ'::character varying]::text[])
        ), req_niv7 AS (
         SELECT '00'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '10'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '20'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '31'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '32'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '33'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '40'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '50'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '60'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '71'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '72'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '73'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '81'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '82'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '83'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '84'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '85'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '90'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '99'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT 'ZZ'::text AS code_ame,
            lt_mob_tronc_sens.code AS code_sens,
            lt_mob_tronc_sens.valeur AS val_sens
           FROM m_mobilite_douce.lt_mob_tronc_sens
          WHERE lt_mob_tronc_sens.code::text = ANY (ARRAY['00'::character varying, 'ZZ'::character varying]::text[])
        ), req_niv8 AS (
         SELECT '00'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '41'::character varying, '42'::character varying, '51'::character varying, '52'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '10'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '20'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '31'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '32'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '33'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '40'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '50'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '60'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '71'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '30'::character varying, '51'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '72'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '51'::character varying, '52'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '73'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['11'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '81'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, '30'::character varying, '40'::character varying, '41'::character varying, '42'::character varying, '51'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '82'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '83'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '84'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '85'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '90'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '99'::text AS code_ame,
            lt_mob_tronc_local.code AS code_local,
            lt_mob_tronc_local.valeur AS val_local
           FROM m_mobilite_douce.lt_mob_tronc_local
          WHERE lt_mob_tronc_local.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '11'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        ), req_niv9 AS (
         SELECT '00'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '10'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '20'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '31'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '32'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '33'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '40'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '50'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '60'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '71'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '72'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '73'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '81'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '82'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '83'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '84'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '85'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['10'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '90'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT '99'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
        UNION ALL
         SELECT 'ZZ'::text AS code_ame,
            lt_mob_tronc_revet.code AS code_revet,
            lt_mob_tronc_revet.valeur AS val_revet
           FROM m_mobilite_douce.lt_mob_tronc_revet
          WHERE lt_mob_tronc_revet.code::text = ANY (ARRAY['00'::character varying, '10'::character varying, '20'::character varying, '30'::character varying, 'ZZ'::character varying]::text[])
        )
 SELECT c1.niv,
    c1.code_typmob,
    c1.val_typmob,
    c1.code_acces,
    c1.val_access,
    c1.code_struct,
    c1.val_struct,
    c1.code_dg,
    c1.val_dg,
    n5.code_ame,
    n5.val_ame,
    n6.code_reg,
    n6.val_reg,
    n7.code_sens,
    n7.val_sens,
    n8.code_local,
    n8.val_local,
    n9.code_revet,
    n9.val_revet
   FROM req_cycle_1 c1
     LEFT JOIN req_niv5 n5 ON (c1.code_acces || c1.code_dg) = n5.code_dg
     LEFT JOIN req_niv6 n6 ON n5.code_ame::text = n6.code_ame
     LEFT JOIN req_niv7 n7 ON n5.code_ame::text = n7.code_ame
     LEFT JOIN req_niv8 n8 ON n5.code_ame::text = n8.code_ame
     LEFT JOIN req_niv9 n9 ON n5.code_ame::text = n9.code_ame
  ORDER BY c1.code_typmob, c1.code_acces, c1.code_struct, c1.code_dg, n5.code_ame, n6.code_reg, n7.code_sens, n8.code_local, n9.code_revet
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.lt_vmr_mob_troncon IS 'Vue matériliasée qualifiant les tronçons aménagés pour la gestion des listes imbriquées dans GEO';


-- #################################################################### vue xapps_geo_vmr_amgt_cycl_hors_planvelo_arc ###############################################

-- m_mobilite_douce.xapps_geo_vmr_amgt_cycl_hors_planvelo_arc source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_amgt_cycl_hors_planvelo_arc
TABLESPACE pg_default
AS SELECT iti.id_iticycl,
    iti.numero,
    iti.nomoff,
    iti.nomusage,
    iti.depart,
    iti.via,
    iti.arrivee,
    iti.dbetat,
    iti.dbstatut,
    iti.usa_iti,
    iti.lieu_d,
    iti.instruc,
    iti.url,
    iti.d_prog,
    iti.d_service,
    iti.p_long,
    iti.p_ame,
    iti.p_mao,
    iti.p_coutm,
    iti.p_cout,
    iti.gestio,
    iti.itivar,
    iti.id_itivar,
    iti.n_itivar,
    iti.observ,
    iti.epci,
    iti.maj_geom,
    iti.maj_att,
    iti.sup_gdpublic,
    iti.op_sai,
    iti.op_maj,
    iti.dbinsert,
    iti.dbupdate,
    st_union(t.geom) AS geom
   FROM m_mobilite_douce.geo_mob_troncon t
     JOIN m_mobilite_douce.lk_mob_tronc_iti lk ON lk.id_tronc = t.id_tronc
     JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
  WHERE iti.gestio = '04'::text AND iti.epci = 'arc'::text AND NOT (iti.id_iticycl IN ( SELECT i.id_iticycl
           FROM m_mobilite_douce.an_mob_iti_cycl i
             JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
             JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
          WHERE p.id_plan = '5e7c86d2-994b-42cf-969f-c314a25ba2c8'::text))
  GROUP BY iti.id_iticycl
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_amgt_cycl_hors_planvelo_arc IS 'Vue géographique matérialisée des aménagements cyclables hors plan vélo 2021-2026 géré par l''ARC et en service';


-- #################################################################### vue xapps_geo_vmr_iti_cycl ###############################################

-- m_mobilite_douce.xapps_geo_vmr_iti_cycl source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_cycl
TABLESPACE pg_default
AS SELECT i.id_iticycl,
    i.numero,
    i.nomoff,
    i.n_itivar,
    i.epci,
    i.dbetat,
    i.dbstatut,
        CASE
            WHEN ltn.valeur IS NOT NULL THEN ltn.valeur::text
            ELSE
            CASE
                WHEN i.gestio = '01'::text THEN 'National'::text
                WHEN i.gestio = '02'::text THEN 'Régional'::text
                WHEN i.gestio = '03'::text THEN 'Départemental'::text
                WHEN i.gestio = '04'::text THEN 'Intercommunal'::text
                WHEN i.gestio = '05'::text THEN 'Communal'::text
                ELSE ''::text
            END
        END AS niveau,
    round(sum(st_length(t.geom))::numeric, 0) AS long_iti,
    string_agg(DISTINCT p.id_plan, ','::text) AS code_idplan,
    st_union(st_multi(st_linemerge(t.geom)))::geometry(MultiLineString,2154) AS geom
   FROM m_mobilite_douce.geo_mob_troncon t
     JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON t.id_tronc = lki.id_tronc
     JOIN m_mobilite_douce.an_mob_iti_cycl i ON lki.id_iti = i.id_iticycl
     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
     LEFT JOIN m_mobilite_douce.lt_mob_plan_niveau ltn ON ltn.code::text = p.plan_niv::text
  WHERE t.dbstatut::text = '10'::text AND i.dbstatut::text = '10'::text
  GROUP BY i.id_iticycl, ltn.valeur
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_cycl IS 'Vue géographique matérialisée gérant l''affichage des itinéraires cyclables';


-- #################################################################### vue xapps_geo_vmr_iti_cycl_rep_planvelo_60159_gdpublic ###############################################

-- m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_60159_gdpublic source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_60159_gdpublic
TABLESPACE pg_default
AS SELECT r.id_rep,
    r.libelle,
    r.typ_rep,
    r.typ_rep_a,
    r.num_compt,
    r.url_compt,
    r.usa_rep,
    r.dbetat,
    r.dbstatut,
    r.gestio,
    r.observ,
    r.epci,
    r.insee,
    r.commune,
    r.op_sai,
    r.op_maj,
    r.dbinsert,
    r.dbupdate,
    r.x_l93,
    r.y_l93,
    r.geom,
    iti.id_iticycl
   FROM m_mobilite_douce.geo_mob_repere r
     JOIN m_mobilite_douce.lk_mob_rep_iti lk ON lk.id_rep = r.id_rep
     JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
     JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = iti.id_iticycl
     JOIN m_mobilite_douce.an_mob_plan plan ON plan.id_plan = lkp.id_plan
  WHERE plan.id_plan = '5e7c86d2-994b-42cf-969f-c314a25ba2c8'::text AND iti.gestio = '05'::text AND r.typ_rep::text = '10'::text
  GROUP BY r.id_rep, iti.id_iticycl
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_60159_gdpublic IS 'Vue géographique matérialisée des repères (début/fin) des itinéraires cyclables du plan vélo 2021-2026 géré par l''ARC';


-- #################################################################### vue xapps_geo_vmr_iti_cycl_rep_planvelo_arc_gdpublic ###############################################

-- m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_arc_gdpublic source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_arc_gdpublic
TABLESPACE pg_default
AS SELECT r.id_rep,
    r.libelle,
    r.typ_rep,
    r.typ_rep_a,
    r.num_compt,
    r.url_compt,
    r.usa_rep,
    r.dbetat,
    r.dbstatut,
    r.gestio,
    r.observ,
    r.epci,
    r.insee,
    r.commune,
    r.op_sai,
    r.op_maj,
    r.dbinsert,
    r.dbupdate,
    r.x_l93,
    r.y_l93,
    r.geom,
    iti.id_iticycl
   FROM m_mobilite_douce.geo_mob_repere r
     JOIN m_mobilite_douce.lk_mob_rep_iti lk ON lk.id_rep = r.id_rep
     JOIN m_mobilite_douce.an_mob_iti_cycl iti ON iti.id_iticycl = lk.id_iti
     JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = iti.id_iticycl
     JOIN m_mobilite_douce.an_mob_plan plan ON plan.id_plan = lkp.id_plan
  WHERE plan.id_plan = '5e7c86d2-994b-42cf-969f-c314a25ba2c8'::text AND iti.gestio = '04'::text AND r.typ_rep::text = '10'::text
  GROUP BY r.id_rep, iti.id_iticycl
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_cycl_rep_planvelo_arc_gdpublic IS 'Vue géographique matérialisée des repères (début/fin) des itinéraires cyclables du plan vélo 2021-2026 géré par l''ARC';

-- #################################################################### vue xapps_geo_vmr_iti_rand ###############################################

-- m_mobilite_douce.xapps_geo_vmr_iti_rand source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_rand
TABLESPACE pg_default
AS SELECT i.id_itirand,
    i.numero,
    i.nomoff,
        CASE
            WHEN i.numero IS NOT NULL OR i.numero::text <> ''::text THEN ((i.numero::text || ' - '::text) || i.nomoff::text)::character varying
            ELSE i.nomoff
        END AS itineraire,
    string_agg(DISTINCT p.id_plan, ','::text) AS code_idplan,
    i.epci,
    i.dbetat,
    i.dbstatut,
    st_union(st_multi(st_linemerge(t.geom))) AS geom
   FROM m_mobilite_douce.geo_mob_troncon t
     JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON t.id_tronc = lki.id_tronc
     JOIN m_mobilite_douce.an_mob_iti_rand i ON lki.id_iti = i.id_itirand
     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
  WHERE t.dbstatut::text = '10'::text AND i.dbstatut::text = '10'::text
  GROUP BY i.id_itirand, i.numero, i.nomoff, i.epci
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_iti_rand IS 'Vue géographique matérialisée gérant l''affichage des itinéraires de randonnées';


-- #################################################################### vue xapps_geo_vmr_mob_amgt_troncon ###############################################

-- m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon
TABLESPACE pg_default
AS WITH req_t AS (
        ( WITH req_d AS (
                 SELECT t.id_tronc,
                    t.ame_d AS ame,
                    t.dbetat_d AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_d AS regime,
                    t.local_d AS local,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    t.epci,
                    i.id_iticycl,
                    r.id_itirand,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    (st_dump(t.geom)).geom AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE t.ame_g::text = 'ZZ'::text AND (t.ame_d::text = ANY (ARRAY['10'::character varying::text, '31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            d.id_tronc,
            d.ame,
            d.dbetat,
            d.dbstatut,
            d.typ_mob,
            d.regime,
            d.local,
            d.gestio,
            d.proprio,
            d.epci,
            string_agg(d.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(d.id_itirand, ','::text) AS code_iditirand,
            string_agg(d.id_plan, ','::text) AS code_idplan,
            st_multi(d.geom) AS geom
           FROM req_d d
          GROUP BY d.id_tronc, d.ame, d.dbstatut, d.typ_mob, d.dbetat, d.geom, d.local, d.epci, d.regime, d.gestio, d.proprio)
        UNION ALL
        ( WITH req_d1 AS (
                 SELECT t.id_tronc,
                    t.ame_d AS ame,
                    t.dbetat_d AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_d AS regime,
                    t.local_d AS local,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    t.epci,
                    i.id_iticycl,
                    r.id_itirand,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    (st_dump(t.geom)).geom AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE t.ame_g::text = 'ZZ'::text AND (t.ame_d::text = ANY (ARRAY['31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            d.id_tronc,
            d.ame,
            d.dbetat,
            d.dbstatut,
            d.typ_mob,
            d.regime,
            d.local,
            d.gestio,
            d.proprio,
            d.epci,
            string_agg(d.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(d.id_itirand, ','::text) AS code_iditirand,
            string_agg(d.id_plan, ','::text) AS code_idplan,
            st_multi(d.geom) AS geom
           FROM req_d1 d
          GROUP BY d.id_tronc, d.ame, d.dbstatut, d.typ_mob, d.dbetat, d.geom, d.local, d.epci, d.regime, d.gestio, d.proprio)
        UNION ALL
        ( WITH req_d_chaussee AS (
                 SELECT t.id_tronc,
                    t.ame_d AS ame,
                    t.dbetat_d AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_d AS regime,
                    t.local_d AS local,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    t.epci,
                    i.id_iticycl,
                    r.id_itirand,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, '-4'::integer::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE (t.ame_g::text <> 'ZZ'::text OR t.ame_d::text <> 'ZZ'::text) AND (t.ame_d::text <> ALL (ARRAY['31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            d.id_tronc,
            d.ame,
            d.dbetat,
            d.dbstatut,
            d.typ_mob,
            d.regime,
            d.local,
            d.gestio,
            d.proprio,
            d.epci,
            string_agg(d.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(d.id_itirand, ','::text) AS code_iditirand,
            string_agg(d.id_plan, ','::text) AS code_idplan,
            st_multi(d.geom) AS geom
           FROM req_d_chaussee d
          GROUP BY d.id_tronc, d.ame, d.dbstatut, d.typ_mob, d.dbetat, d.geom, d.local, d.epci, d.regime, d.gestio, d.proprio)
        UNION ALL
        ( WITH req_g_chaussee AS (
                 SELECT t.id_tronc,
                    t.ame_g AS ame,
                    t.dbetat_g AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_g AS regime,
                    t.local_g AS local,
                    t.gestio_g AS gestio,
                    t.proprio_g AS proprio,
                    t.epci,
                    i.id_iticycl,
                    r.id_itirand,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, 4::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE (t.ame_g::text <> 'ZZ'::text OR t.ame_d::text <> 'ZZ'::text) AND (t.ame_g::text <> ALL (ARRAY['31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            g.id_tronc,
            g.ame,
            g.dbetat,
            g.dbstatut,
            g.typ_mob,
            g.regime,
            g.local,
            g.gestio,
            g.proprio,
            g.epci,
            string_agg(g.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(g.id_itirand, ','::text) AS code_iditirand,
            string_agg(g.id_plan, ','::text) AS code_idplan,
            st_multi(g.geom) AS geom
           FROM req_g_chaussee g
          GROUP BY g.id_tronc, g.ame, g.dbstatut, g.typ_mob, g.dbetat, g.geom, g.local, g.epci, g.regime, g.gestio, g.proprio)
        UNION ALL
        ( WITH req_g AS (
                 SELECT t.id_tronc,
                    t.ame_g AS ame,
                    t.dbetat_g AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_g AS regime,
                    t.local_g AS local,
                    t.gestio_g AS gestio,
                    t.proprio_g AS proprio,
                    t.epci,
                    i.id_iticycl,
                    r.id_itirand,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    (st_dump(t.geom)).geom AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE t.ame_d::text = 'ZZ'::text AND (t.ame_g::text = ANY (ARRAY['10'::character varying::text, '31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            g.id_tronc,
            g.ame,
            g.dbetat,
            g.dbstatut,
            g.typ_mob,
            g.regime,
            g.local,
            g.gestio,
            g.proprio,
            g.epci,
            string_agg(g.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(g.id_itirand, ','::text) AS code_iditirand,
            string_agg(g.id_plan, ','::text) AS code_idplan,
            st_multi(g.geom) AS geom
           FROM req_g g
          GROUP BY g.id_tronc, g.ame, g.dbstatut, g.typ_mob, g.dbetat, g.geom, g.local, g.epci, g.regime, g.gestio, g.proprio)
        )
 SELECT row_number() OVER () AS gid,
    req_t.id_tronc,
    req_t.ame,
    req_t.dbetat,
    req_t.dbstatut,
    req_t.typ_mob,
    req_t.regime,
    req_t.local,
    req_t.gestio,
    req_t.proprio,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(req_t.gestio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_g g
             LEFT JOIN r_objet.lt_gestio_proprio l ON g.code = l.code::text) AS lib_gestio,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(req_t.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_p p
             LEFT JOIN r_objet.lt_gestio_proprio l ON p.code = l.code::text) AS lib_proprio,
    req_t.epci,
    req_t.code_iditicycl,
    req_t.code_iditirand,
    req_t.code_idplan,
    req_t.geom::geometry(MultiLineString,2154) AS geom
   FROM req_t
  WHERE req_t.ame::text <> 'ZZ'::text
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon IS 'Vue géographique gérant l''affichage des aménagements';


-- #################################################################### vue xapps_geo_vmr_mob_amgt_troncon_etat ###############################################

-- m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat
TABLESPACE pg_default
AS WITH req_t AS (
        ( WITH req_d AS (
                 SELECT t.id_tronc,
                    t.ame_d AS ame,
                    t.dbetat_d AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_d AS regime,
                    t.local_d AS local,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    i.id_iticycl,
                    r.id_itirand,
                    t.epci,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, 2::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE t.ame_g::text = 'ZZ'::text AND (t.ame_d::text = ANY (ARRAY['10'::character varying::text, '31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            d.id_tronc,
            d.ame,
            d.dbetat,
            d.dbstatut,
            d.typ_mob,
            d.regime,
            d.local,
            d.gestio,
            d.proprio,
            d.epci,
            string_agg(d.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(d.id_itirand, ','::text) AS code_iditirand,
            string_agg(d.id_plan, ','::text) AS code_idplan,
            st_multi(d.geom) AS geom
           FROM req_d d
          GROUP BY d.id_tronc, d.ame, d.dbstatut, d.typ_mob, d.regime, d.dbetat, d.geom, d.local, d.epci, d.gestio, d.proprio)
        UNION ALL
        ( WITH req_d1 AS (
                 SELECT t.id_tronc,
                    t.ame_d AS ame,
                    t.dbetat_d AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_d AS regime,
                    t.local_d AS local,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    i.id_iticycl,
                    r.id_itirand,
                    t.epci,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, 2::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE t.ame_g::text = 'ZZ'::text AND (t.ame_d::text = ANY (ARRAY['31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            d.id_tronc,
            d.ame,
            d.dbetat,
            d.dbstatut,
            d.typ_mob,
            d.regime,
            d.local,
            d.gestio,
            d.proprio,
            d.epci,
            string_agg(d.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(d.id_itirand, ','::text) AS code_iditirand,
            string_agg(d.id_plan, ','::text) AS code_idplan,
            st_multi(d.geom) AS geom
           FROM req_d1 d
          GROUP BY d.id_tronc, d.ame, d.dbstatut, d.dbetat, d.typ_mob, d.regime, d.geom, d.local, d.epci, d.gestio, d.proprio)
        UNION ALL
        ( WITH req_d_chaussee AS (
                 SELECT t.id_tronc,
                    t.ame_d AS ame,
                    t.dbetat_d AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_d AS regime,
                    t.local_d AS local,
                    t.gestio_d AS gestio,
                    t.proprio_d AS proprio,
                    i.id_iticycl,
                    r.id_itirand,
                    t.epci,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, '-2'::integer::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE (t.ame_g::text <> 'ZZ'::text OR t.ame_d::text <> 'ZZ'::text) AND (t.ame_d::text <> ALL (ARRAY['31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            d.id_tronc,
            d.ame,
            d.dbetat,
            d.dbstatut,
            d.typ_mob,
            d.regime,
            d.local,
            d.gestio,
            d.proprio,
            d.epci,
            string_agg(d.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(d.id_itirand, ','::text) AS code_iditirand,
            string_agg(d.id_plan, ','::text) AS code_idplan,
            st_multi(d.geom) AS geom
           FROM req_d_chaussee d
          GROUP BY d.id_tronc, d.ame, d.dbstatut, d.typ_mob, d.regime, d.dbetat, d.geom, d.local, d.epci, d.gestio, d.proprio)
        UNION ALL
        ( WITH req_g_chaussee AS (
                 SELECT t.id_tronc,
                    t.ame_g AS ame,
                    t.dbetat_g AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_g AS regime,
                    t.local_g AS local,
                    t.gestio_g AS gestio,
                    t.proprio_g AS proprio,
                    i.id_iticycl,
                    r.id_itirand,
                    t.epci,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, 2::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE (t.ame_g::text <> 'ZZ'::text OR t.ame_d::text <> 'ZZ'::text) AND (t.ame_g::text <> ALL (ARRAY['31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            g.id_tronc,
            g.ame,
            g.dbetat,
            g.dbstatut,
            g.typ_mob,
            g.regime,
            g.local,
            g.gestio,
            g.proprio,
            g.epci,
            string_agg(g.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(g.id_itirand, ','::text) AS code_iditirand,
            string_agg(g.id_plan, ','::text) AS code_idplan,
            st_multi(g.geom) AS geom
           FROM req_g_chaussee g
          GROUP BY g.id_tronc, g.ame, g.dbstatut, g.typ_mob, g.regime, g.dbetat, g.geom, g.local, g.epci, g.gestio, g.proprio)
        UNION ALL
        ( WITH req_g AS (
                 SELECT t.id_tronc,
                    t.ame_g AS ame,
                    t.dbetat_g AS dbetat,
                    t.dbstatut,
                    t.typ_mob,
                    t.regime_g AS regime,
                    t.local_g AS local,
                    t.gestio_g AS gestio,
                    t.proprio_g AS proprio,
                    i.id_iticycl,
                    r.id_itirand,
                    t.epci,
                        CASE
                            WHEN p.id_plan IS NOT NULL THEN p.id_plan
                            ELSE ''::text
                        END ||
                        CASE
                            WHEN pr.id_plan IS NOT NULL THEN pr.id_plan
                            ELSE ''::text
                        END AS id_plan,
                    st_offsetcurve((st_dump(t.geom)).geom, 2::double precision, 'quad_segs=4 join=round'::text) AS geom
                   FROM m_mobilite_douce.geo_mob_troncon t
                     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                     LEFT JOIN m_mobilite_douce.an_mob_iti_rand r ON r.id_itirand = lki.id_iti
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_iticycl
                     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkpr ON lkpr.id_iti = r.id_itirand
                     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                     LEFT JOIN m_mobilite_douce.an_mob_plan pr ON pr.id_plan = lkpr.id_plan
                  WHERE t.ame_d::text = 'ZZ'::text AND (t.ame_g::text = ANY (ARRAY['10'::character varying::text, '31'::character varying::text, '32'::character varying::text, '33'::character varying::text, '40'::character varying::text, '50'::character varying::text, '71'::character varying::text, '72'::character varying::text, '81'::character varying::text, '82'::character varying::text, '90'::character varying::text, '99'::character varying::text])) AND t.local_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                )
         SELECT row_number() OVER () AS gid,
            g.id_tronc,
            g.ame,
            g.dbetat,
            g.dbstatut,
            g.typ_mob,
            g.regime,
            g.local,
            g.gestio,
            g.proprio,
            g.epci,
            string_agg(g.id_iticycl, ','::text) AS code_iditicycl,
            string_agg(g.id_itirand, ','::text) AS code_iditirand,
            string_agg(g.id_plan, ','::text) AS code_idplan,
            st_multi(g.geom) AS geom
           FROM req_g g
          GROUP BY g.id_tronc, g.ame, g.dbstatut, g.dbetat, g.typ_mob, g.regime, g.geom, g.local, g.epci, g.gestio, g.proprio)
        )
 SELECT row_number() OVER () AS gid,
    req_t.id_tronc,
    req_t.ame,
    req_t.dbetat,
    req_t.dbstatut,
    req_t.typ_mob,
    req_t.regime,
    req_t.local,
    req_t.gestio,
    req_t.proprio,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(req_t.gestio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_g g
             LEFT JOIN r_objet.lt_gestio_proprio l ON g.code = l.code::text) AS lib_gestio,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(req_t.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, chr(10)) AS string_agg
           FROM req_p p
             LEFT JOIN r_objet.lt_gestio_proprio l ON p.code = l.code::text) AS lib_proprio,
    req_t.epci,
    req_t.code_iditicycl,
    req_t.code_iditirand,
    req_t.code_idplan,
    req_t.geom::geometry(MultiLineString,2154) AS geom
   FROM req_t
  WHERE req_t.ame::text <> 'ZZ'::text AND req_t.id_tronc = 'TC353'::text
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_etat IS 'Vue géographique gérant l''affichage des aménagements par état d''avancement (décalage du tronçon)';


-- #################################################################### vue xapps_geo_vmr_mob_amgt_troncon_requa ###############################################

-- m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa source

CREATE MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa
TABLESPACE pg_default
AS SELECT geo_mob_troncon.id_tronc,
    st_buffer(geo_mob_troncon.geom, 2::double precision, 'endcap=flat join=round'::text) AS geom
   FROM m_mobilite_douce.geo_mob_troncon
  WHERE geo_mob_troncon.requal_g IS TRUE OR geo_mob_troncon.requal_d IS TRUE
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_mobilite_douce.xapps_geo_vmr_mob_amgt_troncon_requa IS 'Vue géographique gérant l''affichage des aménagements en requalification';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                             VUE OPEN DATA                                                                    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- #################################################################### vue xopendata_an_v_mob_iti_cycl ###############################################

-- m_mobilite_douce.xopendata_an_v_mob_iti_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_an_v_mob_iti_cycl
AS SELECT c.numero,
    c.nomoff AS nomofficiel,
    c.nomusage,
    c.depart,
    c.arrivee,
    'Non'::text AS estinscrit,
    np.valeur,
    p.d_appro,
    c.url AS siteweb,
    c.d_service AS anneeouverture
   FROM m_mobilite_douce.an_mob_iti_cycl c
     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = c.id_iticycl
     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
     LEFT JOIN m_mobilite_douce.lt_mob_plan_niveau np ON np.code::text = p.plan_niv::text
  WHERE c.dbetat::text = '40'::text AND c.dbstatut::text = '10'::text AND ((p.plan_niv::text = ANY (ARRAY['50'::character varying, '60'::character varying]::text[])) OR p.plan_niv IS NULL);

COMMENT ON VIEW m_mobilite_douce.xopendata_an_v_mob_iti_cycl IS 'Vue opendata des itinéraires cyclables en service avec un statut actif pour les itinéraires de niveau commune/interco';


-- #################################################################### vue xopendata_an_v_statio_cycl ###############################################

-- m_mobilite_douce.xopendata_an_v_statio_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_an_v_statio_cycl
AS SELECT s.id_statio AS id_local,
    NULL::text AS id_osm,
    s.insee AS code_com,
    ((('['::text || st_x(st_transform(s.geom, 4326))::numeric(8,7)) || ','::text) || st_y(st_transform(s.geom, 4326))::numeric(9,7)) || ']'::text AS coordonneesxy,
    s.cap AS capacite,
    s.cap_cargo AS capacite_cargo,
        CASE
            WHEN ta.code::text <> '00'::text THEN ta.valeur
            ELSE ''::character varying
        END AS type_accroche,
        CASE
            WHEN m.code::text <> '00'::text THEN m.valeur
            ELSE ''::character varying
        END AS mobilier,
        CASE
            WHEN a.code::text <> '00'::text THEN a.valeur
            ELSE ''::character varying
        END AS acces,
        CASE
            WHEN s.gratuit::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.gratuit::text = 't'::text THEN 'true'::text
                WHEN s.gratuit::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS gratuit,
        CASE
            WHEN pr.code::text <> '00'::text THEN pr.valeur
            ELSE ''::character varying
        END AS protection,
        CASE
            WHEN s.couvert::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.couvert::text = 't'::text THEN 'true'::text
                WHEN s.couvert::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS couverture,
        CASE
            WHEN s.surv::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.surv::text = 't'::text THEN 'true'::text
                WHEN s.surv::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS surveillance,
        CASE
            WHEN s.lum::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.lum::text = 't'::text THEN 'true'::text
                WHEN s.lum::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS lumiere,
    s.url AS url_info,
    s.an_pose AS d_service,
        CASE
            WHEN s.epci::text = 'arc'::text THEN 'Agglomération de la Région de Compiègne et de la Basse Automne'::text
            WHEN s.epci::text = 'cclo'::text THEN 'Communauté de Communes des Lisières de l''Oise'::text
            WHEN s.epci::text = 'ccpe'::text THEN 'Communauté de Communes de la Plaine d''Estrées'::text
            WHEN s.epci::text = 'cc2v'::text THEN 'Communauté de Communes des Deux Vallées'::text
            ELSE ''::text
        END AS source,
    g.valeur AS proprietaire,
    p.valeur AS gestionnaire,
        CASE
            WHEN s.dbupdate IS NULL THEN s.dbinsert
            ELSE s.dbinsert
        END AS date_maj,
    s.observ AS commentaires
   FROM m_mobilite_douce.geo_mob_statio_cycl s
     JOIN r_objet.lt_gestio_proprio g ON s.gestio = g.code::text
     JOIN r_objet.lt_gestio_proprio p ON s.proprio = p.code::text
     JOIN m_mobilite_douce.lt_mob_statio_protect pr ON s.protect::text = pr.code::text
     JOIN m_mobilite_douce.lt_mob_statio_acces a ON s.acces::text = a.code::text
     JOIN m_mobilite_douce.lt_mob_statio_mobil m ON s.mobil::text = m.code::text
     JOIN m_mobilite_douce.lt_mob_statio_typ_accro ta ON s.typ_accro::text = ta.code::text
  WHERE s.dbetat::text = '40'::text AND s.dbstatut::text = '10'::text;

COMMENT ON VIEW m_mobilite_douce.xopendata_an_v_statio_cycl IS 'Vue opendata des lieux de stationnements cyclables actifs et en service';


-- #################################################################### vue xopendata_geo_v_mob_amgt_cycl ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl
AS SELECT t.id_tronc AS id_local,
    upper(replace(r.valeur::text, 'é'::text, 'E'::text)) AS reseau_loc,
    string_agg(
        CASE
            WHEN p.plan_niv IS NULL OR (p.plan_niv::text = ANY (ARRAY['50'::character varying::text, '60'::character varying::text])) THEN (
            CASE
                WHEN c.numero IS NOT NULL OR c.numero::text <> ''::text THEN c.numero
                ELSE ''::character varying
            END::text || ' - '::text) || c.nomoff::text
            ELSE NULL::text
        END, ':'::text) AS nom_loc,
    NULL::text AS id_osm,
    string_agg(
        CASE
            WHEN p.plan_niv::text = ANY (ARRAY['10'::character varying::text, '20'::character varying::text, '30'::character varying::text]) THEN (
            CASE
                WHEN c.numero IS NOT NULL OR c.numero::text <> ''::text THEN c.numero
                ELSE ''::character varying
            END::text || ' - '::text) || c.nomoff::text
            ELSE NULL::text
        END, ':'::text) AS num_iti,
    t.insee_d,
    upper(replace(replace(ad.valeur::text, 'é'::text, 'E'::text), 'ê'::text, 'E'::text)) AS ame_d,
    upper(replace(rd.valeur::text, 'é'::text, 'E'::text)) AS regime_d,
    upper(replace(sd.valeur::text, 'é'::text, 'E'::text)) AS sens_d,
    t.largeur_d,
    upper(replace(ld.valeur::text, 'é'::text, 'E'::text)) AS local_d,
    upper(replace(std.valeur::text, 'é'::text, 'E'::text)) AS statut_d,
    upper(replace(rvd.valeur::text, 'é'::text, 'E'::text)) AS revet_d,
    t.insee_g,
    upper(replace(replace(ag.valeur::text, 'é'::text, 'E'::text), 'ê'::text, 'E'::text)) AS ame_g,
    upper(replace(rg.valeur::text, 'é'::text, 'E'::text)) AS regime_g,
    upper(replace(sg.valeur::text, 'é'::text, 'E'::text)) AS sens_g,
    t.largeur_g,
    upper(replace(lg.valeur::text, 'é'::text, 'E'::text)) AS local_g,
    upper(replace(stg.valeur::text, 'é'::text, 'E'::text)) AS statut_g,
    upper(replace(rvg.valeur::text, 'é'::text, 'E'::text)) AS revet_g,
    upper(replace(a.valeur::text, 'é'::text, 'E'::text)) AS acces_ame,
    to_char(t.dbupdate, 'YYYY-MM-DD'::text) AS date_maj,
    t.trafic_vit,
        CASE
            WHEN t.lum::text = 'f'::text THEN 'false'::text
            WHEN t.lum::text = 't'::text THEN 'true'::text
            ELSE NULL::text
        END AS lumiere,
        CASE
            WHEN t.d_service_g = t.d_service_d THEN t.d_service_d
            WHEN t.d_service_g IS NULL OR t.d_service_d IS NOT NULL THEN t.d_service_d
            WHEN t.d_service_d IS NULL OR t.d_service_g IS NOT NULL THEN t.d_service_g
            WHEN t.d_service_d IS NULL OR t.d_service_g IS NULL THEN NULL::integer
            WHEN t.d_service_g > t.d_service_d THEN t.d_service_d
            WHEN t.d_service_g < t.d_service_d THEN t.d_service_g
            ELSE NULL::integer
        END AS d_service,
    t.observ AS comm,
        CASE
            WHEN t.epci_d::text = 'arc'::text THEN 'Agglomération de la Région de Compiègne et de la Basse Automne'::text
            WHEN t.epci_d::text = 'cclo'::text THEN 'Communauté de Communes des Lisières de l''Oise'::text
            WHEN t.epci_d::text = 'ccpe'::text THEN 'Communauté de Communes de la Plaine d''Estrées'::text
            WHEN t.epci_d::text = 'cc2v'::text THEN 'Communauté de Communes des Deux Vallées'::text
            ELSE ''::text
        END AS source,
    t.epci_d,
    'Lambert 93'::text AS project_c,
        CASE
            WHEN t.src_geom::text = '00'::text THEN NULL::text::character varying
            ELSE src.valeur
        END AS ref_geo,
    t.geom
   FROM m_mobilite_douce.geo_mob_troncon t
     JOIN m_mobilite_douce.lt_mob_tronc_res r ON r.code::text = t.typ_res::text
     JOIN m_mobilite_douce.lt_mob_tronc_acces a ON a.code::text = t.acces_ame::text
     JOIN m_mobilite_douce.lt_mob_tronc_ame ad ON ad.code::text = t.ame_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_ame ag ON ag.code::text = t.ame_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_regime rg ON rg.code::text = t.regime_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_regime rd ON rd.code::text = t.regime_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_sens sg ON sg.code::text = t.sens_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_sens sd ON sd.code::text = t.sens_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_local lg ON lg.code::text = t.local_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_local ld ON ld.code::text = t.local_d::text
     JOIN r_objet.lt_etat_avancement stg ON stg.code::text = t.dbetat_g::text
     JOIN r_objet.lt_etat_avancement std ON std.code::text = t.dbetat_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_revet rvg ON rvg.code::text = t.revet_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_revet rvd ON rvd.code::text = t.revet_d::text
     JOIN r_objet.lt_booleen lu ON lu.code::text = t.lum::text
     JOIN r_objet.lt_src_geom src ON src.code::text = t.src_geom::text
     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_iti = t.id_tronc
     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl c ON c.id_iticycl = lki.id_iti
     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_plan = c.id_iticycl
     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
  WHERE t.typ_mob::text = '10'::text AND (t.dbetat_d::text = '40'::text OR t.dbetat_g::text = '40'::text) AND t.dbstatut::text = '10'::text
  GROUP BY t.id_tronc, r.valeur, t.insee_d, ad.valeur, rd.valeur, sd.valeur, ld.valeur, std.valeur, rvd.valeur, ag.valeur, rg.valeur, sg.valeur, lg.valeur, stg.valeur, rvg.valeur, src.valeur, t.geom, a.valeur;

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl IS 'Vue opendata des aménagements cyclables';


-- #################################################################### vue xopendata_geo_v_mob_iti_rand ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_iti_rand source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_iti_rand
AS SELECT r.id_itirand AS id_local,
        CASE
            WHEN r.epci = 'arc'::text THEN 'Agglomération de la Région de Compiègne et de la Basse Automne'::text
            WHEN r.epci = 'cclo'::text THEN 'Communauté de Communes des Lisières de l''Oise'::text
            WHEN r.epci = 'ccpe'::text THEN 'Communauté de Communes de la Plaine d''Estrées'::text
            WHEN r.epci = 'cc2v'::text THEN 'Communauté de Communes des Deux Vallées'::text
            ELSE ''::text
        END AS producteur,
    r.contact,
    r.id_itirand AS uuid,
    r.url,
    NULL::text AS id_osm,
    r.nomoff AS nom_itineraire,
        CASE
            WHEN pr.valeur::text = 'VTT'::text THEN 'VTT'::text
            WHEN pr.valeur::text = 'Equestre'::text THEN 'équestre'::text
            ELSE lower(pr.valeur::text)
        END AS pratique,
        CASE
            WHEN tr.valeur::text = 'Etape'::text THEN 'étape'::text
            ELSE lower(tr.valeur::text)
        END AS type_itineraire,
    string_agg(lc.commune::text, ','::text) AS communes_nom,
    string_agg(lkr.insee::text, ','::text) AS communes_code,
    r.depart,
    r.arrivee,
    r.duree,
    r.balisage,
    r.lin_iti AS longueur,
    r.diff_iti AS difficulte,
    r.alti_max AS altitude_max,
    r.alti_min AS altitude_min,
    r.deni_pos AS denivele_positif,
    r.deni_neg AS denivele_negatif,
    r.instruc AS instructions,
    r.present_d AS presentation,
    r.present_c AS presentation_courte,
    r.theme AS themes,
    r.recommand AS recommandations,
    r.accessi AS accessibilite,
    r.acces_r AS acces_routier,
    r.acces_tc AS transports_commun,
    r.park_inf AS parking_info,
    r.park_loc AS parking_geometrie,
    to_char(r.dbinsert, 'YYYY-MM-DD'::text) AS date_creation,
    to_char(r.dbupdate, 'YYYY-MM-DD'::text) AS date_modification,
    NULL::text AS medias,
    NULL::text AS itineraire_parent,
    r.typ_sol AS type_sol,
        CASE
            WHEN r.pdipr::text = 'f'::text THEN 'false'::text
            WHEN r.pdipr::text = 't'::text THEN 'true'::text
            ELSE NULL::text
        END AS pdipr_inscription,
    to_char(r.pdipr_d::timestamp with time zone, 'YYYY-MM-DD'::text) AS pdipr_date_inscription,
    r.epci,
    st_union(st_linemerge(t.geom)) AS geom
   FROM m_mobilite_douce.an_mob_iti_rand r
     JOIN m_mobilite_douce.lt_mob_iti_pratrand pr ON r.prat_iti::text = pr.code::text
     JOIN m_mobilite_douce.lt_mob_iti_typrand tr ON r.typ_iti::text = tr.code::text
     LEFT JOIN m_mobilite_douce.lk_mob_itirand_com lkr ON lkr.id_itirand = r.id_itirand
     LEFT JOIN r_osm.geo_vm_osm_commune_grdc_plus lc ON lc.insee::text = lkr.insee::text
     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_iti = r.id_itirand
     LEFT JOIN m_mobilite_douce.geo_mob_troncon t ON t.id_tronc = lki.id_tronc
  WHERE st_linemerge(t.geom) IS NOT NULL AND r.dbetat::text = '40'::text AND r.dbstatut::text = '10'::text
  GROUP BY r.id_itirand, r.epci, r.contact, r.url, r.nomoff, pr.valeur, tr.valeur, r.depart, r.arrivee, r.duree, r.balisage, r.lin_iti, r.diff_iti, r.alti_max, r.alti_min, r.deni_pos, r.deni_neg, r.instruc, r.present_d, r.present_c, r.theme, r.recommand, r.accessi, r.acces_r, r.acces_tc, r.park_inf, r.park_loc, r.dbinsert, r.dbupdate, r.typ_sol, r.pdipr, r.pdipr_d;

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_iti_rand IS 'Vue opendata des itinéraires de randonnées en service et avec un statut actif';


