/*Mobilite douce V1.0*/
/*Creation des triggers de la structure*/
/*md_20_vues_gestion.sql */
/*PostGIS*/
/*GeoCompiegnois - http://geo.compiegnois.fr/ */
/*Auteur : Julien Houziaux */






-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

-- VUES

DROP VIEW if exists m_mobilite_3v.geo_v_mob_troncon;

-- TRIGGERS

DROP TRIGGER if exists t_t1_modif_troncon ON m_mobilite_3v.geo_v_mob_troncon;
DROP TRIGGER if exists t_t9_geo_mobilite_3v_log ON m_mobilite_3v.geo_v_mob_troncon;



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DE GESTION                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


--##############################################################OUVELEC#############################################################

-- Vue de gestion des tronçons intégrant la segmentation dynamique et permettant la modification des données
CREATE OR REPLACE VIEW m_mobilite_3v.geo_v_mob_troncon
 AS
 SELECT tr.idtroncon,
    tr.id_osm,
    tr.id_on3v,
    tr.typ_res,
    tr.gest,
    tr.propriete,
    tr.d_service,
    tr.trafic_vit,
    tr.lumiere,
    tr.code_com_g,
    tr.commune_g,
    tr.ame_g,
    tr.avanc_g,
    tr.regime_g,
    tr.sens_g,
    tr.largeur_g,
    tr.local_g,
    tr.revet_g,
    tr.code_com_d,
    tr.commune_d,
    tr.ame_d,
    tr.avanc_d,
    tr.regime_d,
    tr.sens_d,
    tr.largeur_d,
    tr.local_d,
    tr.revet_d,
    tr.long_m,
    tr.src_geom,
    tr.observ,
    tr.verif,
    tr.op_sai,
    tr.date_sai,
    tr.date_maj,
	CASE
		WHEN tr.ame_d <> 'ZZ' AND tr.ame_g = 'ZZ' THEN '10'::character varying
		WHEN tr.ame_d = 'ZZ' AND tr.ame_g <> 'ZZ' THEN '20'::character varying
	ELSE '30'::character varying END
	as loc_ame,
    tr.geom
   FROM m_mobilite_3v.geo_mob_troncon tr;
  
  
  
  
  
-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                           TRIGGER                                                         ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- Trigger t_t1_modif_troncon pour la fonction de modification des troncons
CREATE TRIGGER t_t1_modif_troncon
    INSTEAD OF INSERT OR UPDATE OR DELETE
	ON m_mobilite_3v.geo_v_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_modif_troncon();
    

-- Trigger t_t9_geo_mobilite_3v_log
CREATE TRIGGER t_t9_geo_mobilite_3v_log
    INSTEAD OF INSERT OR DELETE OR UPDATE 
    ON m_mobilite_3v.geo_v_mob_troncon
    FOR EACH ROW
    EXECUTE PROCEDURE m_mobilite_3v.ft_m_geo_mobilite_3v_log();
    
    
    
-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

COMMENT ON VIEW m_mobilite_3v.geo_v_mob_troncon	IS 'Vue de gestion des tronçons intégrant la segmentation dynamique et permettant la modification des données';
