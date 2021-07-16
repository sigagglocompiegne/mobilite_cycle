 
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

DROP VIEW if exists x_apps.xapps_geo_v_mob_troncon_affiche;
DROP VIEW if exists m_mobilite_3v.geo_v_mob_noeud;
DROP VIEW if exists x_apps.xapps_an_v_mob3v_tab1;
DROP VIEW if exists x_apps.xapps_an_v_mob3v_tab2;

DROP MATERIALIZED VIEW if exists m_mobilite_3v.geo_vmr_mob_iti;


-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################



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
   



--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher la longueur totale d aménagements cyclables en services dans GEO
CREATE OR REPLACE VIEW xapps.xapps_an_v_mob3v_tab1
 AS
 WITH req_t AS (
	select row_number() over() as gid, round((sum(long_m::decimal)/1000),2) as long_km from m_mobilite_3v.geo_mob_troncon 
	where ((ame_d <> '10' and ame_d <> '11' and ame_d <> 'ZZ') or (ame_g <> '10' and ame_g <> '11' and ame_g <> 'ZZ')) and (avanc_d = '50' or avanc_g = '50')
 )
 SELECT
    tab.gid,
	tab.long_km
 FROM req_t tab;



--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher le pourcentage d aménagements cyclables différents dans GEO
CREATE OR REPLACE VIEW xapps.xapps_an_v_mob3v_tab2
 AS
	WITH
	req_droite AS
	(
		select DISTINCT
			lt.code,
			lt.valeur,
			round((sum(tr.long_m::decimal)/1000),2) as long_km 
		from m_mobilite_3v.lt_mob_ame lt 
		LEFT JOIN m_mobilite_3v.geo_mob_troncon tr ON tr.ame_d = lt.code
		WHERE ame_d <> 'ZZ' and ame_d <> '10' and ame_d <> '11' and avanc_d = '50'
		GROUP BY lt.code, lt.valeur
			ORDER BY lt.code
	),
	req_gauche AS
	(
		select 
			lt.code,
			lt.valeur,
			round((sum(tr.long_m::decimal)/1000),2) as long_km 
		from m_mobilite_3v.geo_mob_troncon tr, m_mobilite_3v.lt_mob_ame lt 
		where ame_g <> 'ZZ' and ame_g <> '10' and ame_g <> '11' and avanc_g = '50' AND tr.ame_g = lt.code
		group by lt.code, lt.valeur
	)
SELECT
	lt.code,
	lt.valeur as nom_ame,
	(CASE WHEN d.long_km IS NULL THEN 0 ELSE d.long_km END) +
	(CASE WHEN g.long_km IS NULL THEN 0 ELSE g.long_km END) as long_km,
	
	round(
		((CASE WHEN d.long_km IS NULL THEN 0 ELSE d.long_km END) +
		(CASE WHEN g.long_km IS NULL THEN 0 ELSE g.long_km END))/
		(
			WITH
				req_droite AS
				(
					select 1::integer as id, round((sum(long_m::decimal)/1000),2) as long_km from m_mobilite_3v.geo_mob_troncon 
					where ame_d <> '10' and ame_d <> '11' and ame_d <> 'ZZ' AND avanc_d = '50'
			),
				req_gauche AS
				(
					select 1::integer as id, round((sum(long_m::decimal)/1000),2) as long_km from m_mobilite_3v.geo_mob_troncon 
					where ame_g <> '10' and ame_g <> '11' and ame_g <> 'ZZ' AND avanc_g = '50'
			)
				SELECT
				d.long_km + g.long_km as long_km
				FROM
				req_droite d, req_gauche g
				WHERE d.id = g.id
			)
	*100,2)
AS long_km_p

FROM m_mobilite_3v.lt_mob_ame lt
LEFT JOIN req_droite d ON d.code = lt.code
LEFT JOIN req_gauche g ON g.code = lt.code
GROUP BY lt.code, lt.valeur,d.long_km,g.long_km;



--##############################################################OUVELEC#############################################################
-- Vue matérialisée regénérant les itinéraires à partir des tronçons
CREATE MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_iti
AS
 SELECT 
    ROW_NUMBER() OVER () AS gid,
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
    t.ame,
    st_linemerge(st_union(t.geom)) AS geom
   FROM m_mobilite_3v.lk_mob_ititroncon lk
     JOIN m_mobilite_3v.an_mob_itineraire i ON lk.iditi = i.iditi
     JOIN x_apps.xapps_geo_v_mob_troncon_affiche t ON lk.idtroncon = t.idtroncon
   GROUP BY i.iditi, t.ame


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


COMMENT ON VIEW x_apps.xapps_geo_v_mob_troncon_affiche IS 'Vue de gestion pour un affichage distinct entre les différents mode d aménagements des tronçons';
COMMENT ON VIEW m_mobilite_3v.geo_v_mob_noeud IS 'Vue de modélisation des noeuds des tronçons purement cartographique pour géo';
COMMENT ON VIEW xapps.xapps_an_v_mob3v_tab1 IS 'Vue permettant d afficher la longueur totale d aménagements cyclables en service dans GEO';
COMMENT ON VIEW xapps.xapps_an_v_mob3v_tab2 IS 'Vue permettant d afficher le pourcentage d aménagements cyclables différents dans GEO';

COMMENT ON MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_iti IS 'Vue permettant d afficher la longueur totale d aménagements cyclables en services dans GEO';
