 
/*Mobilité douce V1.0*/
/*Creation des vues et triggers nécessaires à la gestion via l'application web-métier */
/*md_21_vues_xapps.sql */
/*PostGIS*/
/* GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Julien Houziaux*/

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--VUES

DROP VIEW if exists m_mobilite_3v.geo_v_mob_iti;
DROP VIEW if exists x_apps.xapps_geo_v_mob_troncon_affiche;
DROP VIEW if exists m_mobilite_3v.geo_v_mob_noeud;



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
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
-- Vue d'affichage pour un affichage distinct entre les différents mode d aménagements des tronçons
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
   




-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


COMMENT ON VIEW m_mobilite_3v.geo_v_mob_iti IS 'Vue applicative regénérant dynamiquement les itinéraires à partir des tronçons';
COMMENT ON VIEW x_apps.xapps_geo_v_mob_troncon_affiche IS 'Vue de gestion pour un affichage distinct entre les différents mode d aménagements des tronçons';
COMMENT ON VIEW m_mobilite_3v.geo_v_mob_noeud IS 'Vue de modélisation des noeuds des tronçons purement cartographique pour géo';



