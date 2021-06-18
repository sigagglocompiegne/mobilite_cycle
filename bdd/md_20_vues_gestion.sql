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

-- TRIGGERS

DROP TRIGGER if exists t_t1_modif_troncon ON m_mobilite_3v.geo_v_mob_troncon;

-- VUES

DROP VIEW if exists m_mobilite_3v.geo_v_mob_iti;
DROP VIEW if exists m_mobilite_3v.geo_v_mob_troncon;





-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DE GESTION                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


--##############################################################OUVELEC#############################################################
-- Vue applicative regénérant dynamiquement les itinéraires à partir des tronçons
CREATE OR REPLACE VIEW m_mobilite_3v.geo_v_mob_iti
AS
 SELECT
  i.iditi,
	i.num_iti,
	i.nom_off,
  i.num_loc,
	i.nom_usage,
  i.depart,
	i.via,
  i.arrivee,
	i.est_inscri,
	i.niv_inscri,
	i.nom_schema,
	i.an_inscri,
	i.an_ouvert,
	i.gest_iti,
	i.usag,
	i.usage_comm,
	i.voca_iti,
	i.typ_iti,
	i.mao,
	i.equip,
	i.descrip,
	i.cout,
	i.esti,
	i.url_site,
  i.observ,
	i.op_sai,
	i.date_sai,
	i.date_maj,
	st_linemerge(ST_Union(tr.geom)) as geom
  FROM m_mobilite_3v.lk_mob_ititroncon lk
    JOIN m_mobilite_3v.an_mob_itineraire i  ON lk.iditi = i.iditi
    JOIN m_mobilite_3v.geo_mob_troncon tr ON lk.idtroncon = tr.idtroncon
	group by i.iditi;
  
  
  
--##############################################################OUVELEC#############################################################
-- Vue de gestion des tronçons intégrant la segmentation dynamique et permettant la modification des données
CREATE OR REPLACE VIEW m_mobilite_3v.geo_v_mob_troncon
 AS
 SELECT
  tr.idtroncon,
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
    
    
    
    
    
-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

COMMENT ON VIEW m_mobilite_3v.geo_v_mob_iti IS 'Vue applicative regénérant dynamiquement les itinéraires à partir des tronçons';
COMMENT ON VIEW m_mobilite_3v.geo_v_mob_troncon	IS 'Vue de gestion des tronçons intégrant la segmentation dynamique et permettant la modification des données';
