 
/*Mobilité douce V1.0*/
/*Creation des vues nécessaires à l'exploitation des données dans l'interface applicative */
/*md_21_vues_xapps.sql */
/*PostGIS*/
/* GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


drop view if exists m_mobilite_douce.xapps_an_v_amgt_cycl_tab;
drop view if exists m_mobilite_douce.xapps_an_v_cycl_tab1;
drop view if exists m_mobilite_douce.xapps_an_v_iti_ame_pan_tab;
drop view if exists m_mobilite_douce.xapps_an_v_iti_ame_tab;
drop view if exists m_mobilite_douce.xapps_an_v_iti_cycl_tab;
drop view if exists m_mobilite_douce.xapps_an_v_iti_tab;
drop view if exists xapps_an_v_statio_cycl_tab1;
drop view if exists m_mobilite_douce.xapps_geo_v_noeud_troncon_tab;


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
