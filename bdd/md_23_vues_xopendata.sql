 
/*Mobilité douce V1.0*/
/*Creation des vues Open Data */
/*md_23_vues_opendata.sql */
/*PostGIS*/
/* GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- VUES

DROP VIEW IF EXISTS m_mobilite_douce.xopendata_an_v_mob_iti_cycl;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_an_v_statio_cycl;
DROP VIEW IF exists m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_geo_v_mob_iti_rand;


