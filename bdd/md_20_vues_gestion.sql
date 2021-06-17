/*Aménagement cyclable V0.5*/
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
DROP VIEW if exists x_apps.xapps_geo_v_mob_troncon_affiche;
DROP VIEW if exists m_mobilite_3v.geo_v_mob_noeud;
DROP VIEW if exists x_opendata.xopendata_geo_v_mob_opendata;





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



--##############################################################OUVELEC#############################################################
-- Vue de gestion pour un affichage distinct entre les différents mode d aménagements des tronçons
CREATE OR REPLACE VIEW x_apps.xapps_geo_v_mob_troncon_affiche
AS
 WITH req_t AS (
         SELECT tr.idtroncon,
            tr.ame_d AS ame,
            tr.avanc_d AS avanc,
            tr.geom
           FROM m_mobilite_3v.geo_mob_troncon tr
          WHERE tr.ame_g::text = 'ZZ'::text OR tr.ame_g::text = '10'::text
        UNION ALL
         SELECT tr.idtroncon,
            tr.ame_d AS ame,
            tr.avanc_d AS avanc,
            st_offsetcurve(tr.geom, - 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
          WHERE tr.ame_g::text = tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text
        UNION ALL
         SELECT tr.idtroncon,
            tr.ame_g AS ame,
            tr.avanc_g AS avanc,
            st_offsetcurve(tr.geom, 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
          WHERE tr.ame_g::text = tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text
        UNION ALL
         SELECT tr.idtroncon,
            tr.ame_d AS ame,
            tr.avanc_d AS avanc,
            st_offsetcurve(tr.geom, - 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
          WHERE tr.ame_g::text <> tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text
        UNION ALL
         SELECT tr.idtroncon,
            tr.ame_g AS ame,
            tr.avanc_g AS avanc,
            st_offsetcurve(tr.geom, 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
          WHERE tr.ame_g::text <> tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text
        )
 SELECT row_number() OVER () AS gid,
    t.idtroncon,
    t.ame,
    t.avanc,
    t.geom
 FROM req_t t;



--##############################################################OUVELEC#############################################################
-- Vue de modélisation des noeuds des tronçons purement cartographique pour géo
CREATE OR REPLACE VIEW m_mobilite_3v.geo_v_mob_noeud
 AS
 SELECT
 	tr.idtroncon,
	st_Union(st_startpoint(tr.geom), st_endpoint(tr.geom)) as geom 
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
COMMENT ON VIEW x_apps.xapps_geo_v_mob_troncon_affiche IS 'Vue de gestion pour un affichage distinct entre les différents mode d aménagements des tronçons';
COMMENT ON VIEW m_mobilite_3v.geo_v_mob_noeud IS 'Vue de modélisation des noeuds des tronçons purement cartographique pour géo';
