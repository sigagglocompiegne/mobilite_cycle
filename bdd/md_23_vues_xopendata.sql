 
/*Mobilité douce V1.0*/
/*Creation des vues et triggers nécessaires à la gestion via l'application web-métier */
/*md_23_vues_opendata.sql */
/*PostGIS*/
/* GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Julien Houziaux*/



                                                    PAS ENCORE MIS EN PLACE



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- VUES

DROP VIEW if exists x_opendata.xopendata_geo_v_mob_opendata;



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


--##############################################################OUVELEC#############################################################
-- Vue d export opendata pour le PAN
CREATE OR REPLACE VIEW x_opendata.xopendata_geo_v_mob_opendata
 AS
 SELECT
   tr.idtroncon as id_local,
   tr.id_osm,
   tr.id_on3v,
   tr.typ_res as reseau_loc,
   --ITINERAIRE CY nom_loc
   --NUMERO ITINERAIRE CY num_iti
   tr.d_service,
   tr.acces_ame,
   tr.trafic_vit,
   tr.lumiere,
   tr.code_com_g,
   tr.ame_g,
   tr.avanc_g as statut_g,
   tr.regime_g,
   tr.sens_g,
   tr.largeur_g,
   tr.local_g,
   tr.code_com_d,
   tr.ame_d,
   tr.avanc_d as statut_d,
   tr.regime_d,
   tr.sens_d,
   tr.largeur_d,
   tr.local_d,
   tr.src_geom,
   tr.observ as comm,
   tr.op_sai as source,
   tr.date_sai,
   tr.date_maj,
   tr.geom
 FROM m_mobilite_3v.geo_mob_troncon as tr;


