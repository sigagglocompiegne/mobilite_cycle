 
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

DROP VIEW if exists m_mobilite_3v.geo_v_mob_noeud;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab1_apc;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab1_epci;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab2_apc;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab2_epci;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab3;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab31;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab32;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab11_apc;
DROP VIEW if exists m_mobilite_3v.xapps_an_v_mob3v_tab11_epci;

DROP MATERIALIZED VIEW if exists m_mobilite_3v.geo_vmr_mob_iti;
DROP MATERIALIZED VIEW if exists m_mobilite_3v.old_geo_vmr_mob_iti;
DROP MATERIALIZED VIEW if exists m_mobilite_3v.xapps_geo_vmr_mob_iti_deparr;
DROP MATERIALIZED VIEW if exists m_mobilite_3v.geo_vmr_mob_triti_nonamenage;

DROP MATERIALIZED VIEW if exists x_apps.xapps_geo_vmr_mob_troncon_affiche;

-- TABLES D'ERREUR

DROP TABLE if exists x_apps.xapps_an_v_mob_erreur;

-- INDEX

 DROP INDEX if exists x_apps.idx_xapps_an_v_mob_erreur_id;

-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


--##############################################################OUVELEC#############################################################
-- Vue d'affichage pour un affichage distinct entre les différents mode d'aménagements des tronçons
CREATE MATERIALIZED VIEW x_apps.xapps_geo_vmr_mob_troncon_affiche
 AS
 WITH req_t AS (
           SELECT tr.idtroncon, tr.ame_d AS ame, tr.avanc_d AS avanc, st_offsetcurve(tr.geom, - 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
           WHERE (tr.ame_g::text = 'ZZ'::text OR tr.ame_g::text = '10'::text OR tr.ame_g::text = '11'::text) AND tr.ame_d::text <> '20'::text AND tr.ame_d::text <> '50'::text
        UNION ALL
           SELECT tr.idtroncon, tr.ame_d AS ame, tr.avanc_d AS avanc, st_offsetcurve(tr.geom, - 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
           WHERE tr.ame_g::text = tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text
        UNION ALL
           SELECT tr.idtroncon, tr.ame_g AS ame, tr.avanc_g AS avanc, st_offsetcurve(tr.geom, 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
           WHERE tr.ame_g::text = tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text
        UNION ALL
           SELECT tr.idtroncon, tr.ame_d AS ame, tr.avanc_d AS avanc, st_offsetcurve(tr.geom, - 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
           WHERE tr.ame_g::text <> tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text
        UNION ALL
           SELECT tr.idtroncon, tr.ame_g AS ame, tr.avanc_g AS avanc, st_offsetcurve(tr.geom, 4::double precision, 'quad_segs=4 join=round'::text) AS geom
           FROM m_mobilite_3v.geo_mob_troncon tr
           WHERE tr.ame_g::text <> tr.ame_d::text AND tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text
        UNION ALL
           SELECT tr.idtroncon, tr.ame_d AS ame, tr.avanc_d AS avanc, tr.geom
           FROM m_mobilite_3v.geo_mob_troncon tr
           WHERE tr.ame_g::text = 'ZZ'::text AND (tr.ame_d::text = '20'::text OR tr.ame_d::text = '50'::text))
 SELECT row_number() OVER () AS gid, t.idtroncon, t.ame, t.avanc, t.geom
 FROM req_t t;
ALTER TABLE x_apps.xapps_geo_vmr_mob_troncon_affiche OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue de modélisation des noeuds des tronçons purement cartographique pour géo
CREATE OR REPLACE VIEW m_mobilite_3v.geo_v_mob_noeud
 AS
  -- selection des points de départ et d'arrivée de chaque tronçon
  SELECT tr.idtroncon, st_union(st_startpoint(tr.geom), st_endpoint(tr.geom)) AS geom 
  FROM m_mobilite_3v.geo_mob_troncon tr;
ALTER TABLE m_mobilite_3v.geo_v_mob_noeud OWNER TO sig_stage;
   

--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher la longueur totale d aménagements cyclables en service dans GEO à l''échelle du Pays
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab1_apc
 AS
 WITH req_droite AS (
	     -- selection de la somme (en km) des longueurs des tronçons de droite aménagés et en service sur l'ensemble de l'APC
             SELECT 1 AS id, round(sum(geo_mob_troncon.long_m::numeric) / 1000::numeric, 2) AS long_km 
	     FROM m_mobilite_3v.geo_mob_troncon 
	     WHERE geo_mob_troncon.ame_d::text <> '10'::text AND geo_mob_troncon.ame_d::text <> '11'::text AND geo_mob_troncon.ame_d::text <> 'ZZ'::text AND geo_mob_troncon.avanc_d::text = '50'::text), 
      req_gauche AS (
	     -- selection de la somme (en km) des longueurs des tronçons de gauche aménagés et en service sur l'ensemble de l'APC
             SELECT 1 AS id, round(sum(geo_mob_troncon.long_m::numeric) / 1000::numeric, 2) AS long_km 
	     FROM m_mobilite_3v.geo_mob_troncon 
	     WHERE geo_mob_troncon.ame_g::text <> '10'::text AND geo_mob_troncon.ame_g::text <> '11'::text AND geo_mob_troncon.ame_g::text <> 'ZZ'::text AND geo_mob_troncon.avanc_g::text = '50'::text), 
      req_statio AS (
	     -- selection de la somme des places de stationnement cyclable en service sur l'ensemble de l'APC
             SELECT 1 AS id, sum(geo_mob_lieustatio.capacite) AS nb_statio 
	     FROM m_mobilite_3v.geo_mob_lieustatio 
	     WHERE geo_mob_lieustatio.avanc::text = '50'::text)
 SELECT 1 AS gid, d.long_km + g.long_km AS long_km, s.nb_statio 
 FROM req_droite d, req_gauche g, req_statio s 
 WHERE d.id = g.id AND d.id = s.id;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab1_apc OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher la longueur totale d aménagements cyclables en service par EPCI  dans GEO et la capacité en stationnement ouvert
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab1_epci
 AS
 WITH req_droite AS (
	   -- selection de la somme (en km) des longueurs des tronçons de droite aménagés et en service par EPCI
           SELECT e_1.lib_epci_m AS epci, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
           FROM m_mobilite_3v.geo_mob_troncon tr, r_administratif.an_geo g_1, r_osm.geo_osm_epci e_1
           WHERE tr.code_com_d::text = g_1.insee::text AND g_1.epci::text = e_1.cepci::text AND tr.ame_d::text <> '10'::text AND tr.ame_d::text <> '11'::text AND tr.ame_d::text <> 'ZZ'::text AND tr.avanc_d::text = '50'::text
           GROUP BY e_1.lib_epci_m), 
      req_gauche AS (
	   -- selection de la somme (en km) des longueurs des tronçons de gauche aménagés et en service par EPCI
           SELECT e_1.lib_epci_m AS epci, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
           FROM m_mobilite_3v.geo_mob_troncon tr, r_administratif.an_geo g_1, r_osm.geo_osm_epci e_1
           WHERE tr.code_com_g::text = g_1.insee::text AND g_1.epci::text = e_1.cepci::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text AND tr.ame_g::text <> 'ZZ'::text AND tr.avanc_g::text = '50'::text
           GROUP BY e_1.lib_epci_m),
      req_statio AS (
	   -- selection de la somme des places de stationnement cyclable en service par EPCI
           SELECT e_1.lib_epci_m AS epci, sum(s_1.capacite) AS nb_statio
           FROM m_mobilite_3v.geo_mob_lieustatio s_1, r_administratif.an_geo g_1, r_osm.geo_osm_epci e_1
           WHERE s_1.insee::text = g_1.insee::text AND g_1.epci::text = e_1.cepci::text AND s_1.avanc::text = '50'::text
           GROUP BY e_1.lib_epci_m)
 SELECT row_number() OVER () AS gid,
 	e.lib_epci_m,
        CASE WHEN d.long_km IS NULL AND g.long_km IS NOT NULL THEN g.long_km
             WHEN g.long_km IS NULL AND d.long_km IS NOT NULL THEN d.long_km
             WHEN g.long_km IS NOT NULL AND d.long_km IS NOT NULL THEN d.long_km + g.long_km
             WHEN g.long_km IS NULL AND d.long_km IS NULL THEN 0::numeric
             ELSE NULL::numeric
        END AS long_km,
        CASE WHEN s.nb_statio IS NOT NULL THEN s.nb_statio
             ELSE 0::bigint
        END AS nb_statio
 FROM r_osm.geo_osm_epci e
     LEFT JOIN req_droite d ON e.lib_epci_m::text = d.epci::text
     LEFT JOIN req_gauche g ON e.lib_epci_m::text = g.epci::text
     LEFT JOIN req_statio s ON e.lib_epci_m::text = s.epci::text WHERE e.lib_epci_m IS NOT NULL;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab1_epci OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue permettant d'afficher le pourcentage d'aménagements cyclables différents dans GEO à l''échelle de l''APC
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab2_apc
 AS
 WITH req_droite AS (
	  -- selection du nom de l'aménagement et de la somme (en km) des longueurs des tronçons de droite aménagés et en service sur l'ensemble de l'APC
          SELECT DISTINCT lt_1.code, lt_1.valeur, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
          FROM m_mobilite_3v.lt_mob_ame lt_1
              LEFT JOIN m_mobilite_3v.geo_mob_troncon tr ON tr.ame_d::text = lt_1.code::text
          WHERE tr.ame_d::text <> 'ZZ'::text AND tr.ame_d::text <> '10'::text AND tr.ame_d::text <> '11'::text AND tr.avanc_d::text = '50'::text
          GROUP BY lt_1.code, lt_1.valeur
          ORDER BY lt_1.code), 
      req_gauche AS (
	  -- selection du nom de l'aménagement et de la somme (en km) des longueurs des tronçons de gauche aménagés et en service sur l'ensemble de l'APC
          SELECT lt_1.code, lt_1.valeur, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
          FROM m_mobilite_3v.geo_mob_troncon tr, m_mobilite_3v.lt_mob_ame lt_1
          WHERE tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text AND tr.avanc_g::text = '50'::text AND tr.ame_g::text = lt_1.code::text
          GROUP BY lt_1.code, lt_1.valeur)
 -- selection de la somme des longueurs (zéro si null) et calcul du pourcentage par aménagement
 SELECT lt.code,
 	lt.valeur AS nom_ame,
        CASE WHEN d.long_km IS NULL THEN 0::numeric
             ELSE d.long_km
        END +
        CASE WHEN g.long_km IS NULL THEN 0::numeric
             ELSE g.long_km
        END AS long_km,
    	round((CASE WHEN d.long_km IS NULL THEN 0::numeric
            	ELSE d.long_km
               END +
               CASE WHEN g.long_km IS NULL THEN 0::numeric
           	    ELSE g.long_km
               END) / (( WITH req_droite AS ( --------------- calcul du dénominateur
		       		    -- selection de la somme des tronçons de droite (en km) qui sont aménagés
				    SELECT 1 AS id, round(sum(geo_mob_troncon.long_m::numeric) / 1000::numeric, 2) AS long_km
				    FROM m_mobilite_3v.geo_mob_troncon
				    WHERE geo_mob_troncon.ame_d::text <> '10'::text AND geo_mob_troncon.ame_d::text <> '11'::text AND geo_mob_troncon.ame_d::text <> 'ZZ'::text AND geo_mob_troncon.avanc_d::text = '50'::text),
			      req_gauche AS (
				    -- selection de la somme des tronçons de gauche (en km) qui sont aménagés
				    SELECT 1 AS id, round(sum(geo_mob_troncon.long_m::numeric) / 1000::numeric, 2) AS long_km
				    FROM m_mobilite_3v.geo_mob_troncon
				    WHERE geo_mob_troncon.ame_g::text <> '10'::text AND geo_mob_troncon.ame_g::text <> '11'::text AND geo_mob_troncon.ame_g::text <> 'ZZ'::text AND geo_mob_troncon.avanc_g::text = '50'::text)
			 SELECT d_1.long_km + g_1.long_km AS long_km
			 FROM req_droite d_1, req_gauche g_1
			 WHERE d_1.id = g_1.id)) * 100::numeric, 2) AS long_km_p ----- le tout multiplié par 100 pour créer un pourcentage
 FROM m_mobilite_3v.lt_mob_ame lt
     LEFT JOIN req_droite d ON d.code::text = lt.code::text
     LEFT JOIN req_gauche g ON g.code::text = lt.code::text
 GROUP BY lt.code, lt.valeur, d.long_km, g.long_km;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab2_apc OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher le pourcentage d aménagements cyclables par EPCI dans GEO (graphique)
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab2_epci
 AS
 WITH req_tot AS (
	   -- selection du nom de l'aménagement et de la somme (en km) des longueurs des tronçons de droite aménagés et en service par EPCI
           (SELECT DISTINCT e.lib_epci_m AS epci, lt_1.code, lt_1.valeur, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
           FROM m_mobilite_3v.lt_mob_ame lt_1
               LEFT JOIN m_mobilite_3v.geo_mob_troncon tr ON tr.ame_d::text = lt_1.code::text
               LEFT JOIN r_administratif.an_geo g ON tr.code_com_d::text = g.insee::text
               LEFT JOIN r_osm.geo_osm_epci e ON e.cepci::text = g.epci::text
           WHERE tr.ame_d::text <> 'ZZ'::text AND tr.ame_d::text <> '10'::text AND tr.ame_d::text <> '11'::text AND tr.avanc_d::text = '50'::text
           GROUP BY lt_1.code, lt_1.valeur, e.lib_epci_m
           ORDER BY e.lib_epci_m, lt_1.code)
        UNION ALL
	   -- selection du nom de l'aménagement et de la somme (en km) des longueurs des tronçons de gauche aménagés et en service par EPCI
           (SELECT e.lib_epci_m AS epci, lt_1.code, lt_1.valeur, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
           FROM m_mobilite_3v.lt_mob_ame lt_1
              LEFT JOIN m_mobilite_3v.geo_mob_troncon tr ON tr.ame_g::text = lt_1.code::text
              LEFT JOIN r_administratif.an_geo g ON tr.code_com_g::text = g.insee::text
              LEFT JOIN r_osm.geo_osm_epci e ON e.cepci::text = g.epci::text
           WHERE tr.ame_g::text <> 'ZZ'::text AND tr.ame_g::text <> '10'::text AND tr.ame_g::text <> '11'::text AND tr.avanc_g::text = '50'::text AND tr.ame_g::text = lt_1.code::text
           GROUP BY lt_1.code, lt_1.valeur, e.lib_epci_m
           ORDER BY e.lib_epci_m, lt_1.code))
 SELECT t.epci, t.code, t.valeur AS nom_ame, sum(t.long_km) AS long_km
 FROM req_tot t
 GROUP BY t.epci, t.code, t.valeur
 ORDER BY t.epci;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab2_epci OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue tableau de bord pour synthèse nombre total d''itinéraire et leur km (Chiffres clés des itinéraires cyclables) afficher avec le filtre du paramètre global
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab3
 AS
 SELECT i.iditi, i.nom_off, i.num_loc,
        CASE WHEN sum(t.long_m) > 0 AND sum(t.long_m) IS NOT NULL THEN sum(t.long_m) / 1000
             ELSE 0::bigint
        END AS long_km
 FROM m_mobilite_3v.an_mob_itineraire i, m_mobilite_3v.lk_mob_ititroncon l, m_mobilite_3v.geo_mob_troncon t
 WHERE i.iditi = l.iditi AND l.idtroncon = t.idtroncon
 GROUP BY i.iditi, i.nom_off, i.num_loc;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab3 OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue tableau de bord pour synthèse nombre total d''itinéraire et leur km (Chiffres clés des itinéraires cyclables)
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab31
 AS
 WITH req_nb AS (
           SELECT 1 AS gid, count(*) AS nb_iti
           FROM m_mobilite_3v.an_mob_itineraire), 
      req_liti AS (
           SELECT 1 AS gid, sum(t.long_m) / 1000 AS long_km
           FROM m_mobilite_3v.an_mob_itineraire i, m_mobilite_3v.lk_mob_ititroncon l, m_mobilite_3v.geo_mob_troncon t
           WHERE i.iditi = l.iditi AND l.idtroncon = t.idtroncon
           GROUP BY 1::integer)
 SELECT 1 AS gid, req_nb.nb_iti, req_liti.long_km
 FROM req_liti, req_nb
 WHERE req_liti.gid = req_nb.gid;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab31 OWNER TO postgres;


--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher un graphique avec le pourcentage des différents aménagements cyclables pour l''itinéraire sélectionné (paramètre global) dans GEO.
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab32
 AS
 WITH req_droite AS (
           SELECT DISTINCT i.iditi, lt_1.code, lt_1.valeur, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
           FROM m_mobilite_3v.lt_mob_ame lt_1
               LEFT JOIN m_mobilite_3v.geo_mob_troncon tr ON tr.ame_d::text = lt_1.code::text
               LEFT JOIN m_mobilite_3v.lk_mob_ititroncon lk ON lk.idtroncon = tr.idtroncon
               LEFT JOIN m_mobilite_3v.an_mob_itineraire i ON i.iditi = lk.iditi
           WHERE tr.ame_d::text <> 'ZZ'::text AND tr.avanc_d::text = '50'::text
           GROUP BY lt_1.code, lt_1.valeur, i.iditi
           ORDER BY lt_1.code),
      req_gauche AS (
           SELECT i.iditi, lt_1.code, lt_1.valeur, round(sum(tr.long_m::numeric) / 1000::numeric, 2) AS long_km
           FROM m_mobilite_3v.lt_mob_ame lt_1
               LEFT JOIN m_mobilite_3v.geo_mob_troncon tr ON tr.ame_g::text = lt_1.code::text
               LEFT JOIN m_mobilite_3v.lk_mob_ititroncon lk ON lk.idtroncon = tr.idtroncon
               LEFT JOIN m_mobilite_3v.an_mob_itineraire i ON i.iditi = lk.iditi
          WHERE tr.ame_g::text <> 'ZZ'::text AND tr.avanc_g::text = '50'::text AND tr.ame_g::text = lt_1.code::text
          GROUP BY lt_1.code, lt_1.valeur, i.iditi)
 SELECT d.iditi, lt.code, lt.valeur AS nom_ame,
        CASE WHEN d.long_km IS NULL THEN 0::numeric
             ELSE d.long_km
        END +
        CASE WHEN g.long_km IS NULL THEN 0::numeric
             ELSE g.long_km
        END AS long_km,
    round((CASE WHEN d.long_km IS NULL THEN 0::numeric
                ELSE d.long_km
           END +
           CASE WHEN g.long_km IS NULL THEN 0::numeric
                ELSE g.long_km
           END) / (( WITH req_droite AS (
                                 SELECT 1 AS id, round(sum(geo_mob_troncon.long_m::numeric) / 1000::numeric, 2) AS long_km
                                 FROM m_mobilite_3v.geo_mob_troncon
                                 WHERE geo_mob_troncon.ame_d::text <> '10'::text AND geo_mob_troncon.ame_d::text <> '11'::text AND geo_mob_troncon.ame_d::text <> 'ZZ'::text AND geo_mob_troncon.avanc_d::text = '50'::text), 
		          req_gauche AS (
                 	         SELECT 1 AS id, round(sum(geo_mob_troncon.long_m::numeric) / 1000::numeric, 2) AS long_km
                   		 FROM m_mobilite_3v.geo_mob_troncon
                  		 WHERE geo_mob_troncon.ame_g::text <> '10'::text AND geo_mob_troncon.ame_g::text <> '11'::text AND geo_mob_troncon.ame_g::text <> 'ZZ'::text AND geo_mob_troncon.avanc_g::text = '50'::text)
         	     SELECT d_1.long_km + g_1.long_km AS long_km
           	     FROM req_droite d_1, req_gauche g_1
          	     WHERE d_1.id = g_1.id)) * 100::numeric, 2) AS long_km_p
 FROM m_mobilite_3v.lt_mob_ame lt
     LEFT JOIN req_droite d ON d.code::text = lt.code::text
     LEFT JOIN req_gauche g ON g.code::text = lt.code::text
 GROUP BY lt.code, lt.valeur, d.long_km, g.long_km, d.iditi, g.iditi;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab32 OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher le tableau des informations des stationnements cyclables en service dans GEO
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab11_apc
 AS
 SELECT sta.idlieustatio,
    	sta.commune,
   	 sta.gratuit,
    	sta.capacite,
    	sta.capacite_gt,
    	(SELECT DISTINCT lt.valeur
         FROM m_mobilite_3v.lt_mob_avanc lt, m_mobilite_3v.geo_mob_lieustatio p
         WHERE p.avanc::text = lt.code::text AND p.avanc::text = '50'::text) AS avanc
 FROM m_mobilite_3v.geo_mob_lieustatio sta
 WHERE geo_mob_lieustatio.avanc::text = '50'::text;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab11_apc OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue permettant d afficher le tableau des informations des stationnements cyclables en service par EPCI dans GEO
CREATE OR REPLACE VIEW m_mobilite_3v.xapps_an_v_mob3v_tab11_epci
 AS
 SELECT pa.idlieustatio,
    pa.commune,
    pa.gratuit,
    pa.capacite,
    pa.capacite_gt,
    e_1.lib_epci_m AS epci,
    (SELECT DISTINCT lt.valeur
     FROM m_mobilite_3v.lt_mob_avanc lt, m_mobilite_3v.geo_mob_lieustatio pa_1
     WHERE pa_1.avanc::text = lt.code::text AND pa_1.avanc::text = '50'::text) AS avanc
 FROM m_mobilite_3v.geo_mob_lieustatio pa, r_osm.geo_osm_epci e_1, r_administratif.an_geo g_1
 WHERE pa.avanc::text = '50'::text AND pa.insee::text = g_1.insee::text AND g_1.epci::text = e_1.cepci::text;
ALTER TABLE m_mobilite_3v.xapps_an_v_mob3v_tab11_epci OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue matérialisée regénérant les itinéraires à partir des tronçons
DROP MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_iti;

CREATE MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_iti
TABLESPACE pg_default
AS
 SELECT row_number() OVER () AS gid,
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
    	st_linemerge(st_union(tr.geom)) AS geom
 FROM m_mobilite_3v.lk_mob_ititroncon lk
     JOIN m_mobilite_3v.an_mob_itineraire i ON lk.iditi = i.iditi
     JOIN m_mobilite_3v.geo_mob_troncon tr ON lk.idtroncon = tr.idtroncon
 WHERE i.iditi = 'I3'::text
 GROUP BY i.iditi
WITH DATA;
ALTER TABLE m_mobilite_3v.geo_vmr_mob_iti OWNER TO sig_stage;
    

--##############################################################OUVELEC#############################################################
-- ANCIENNE Vue matérialisée regénérant les itinéraires à partir des tronçons
CREATE MATERIALIZED VIEW m_mobilite_3v.old_geo_vmr_mob_iti
TABLESPACE pg_default
AS
 SELECT row_number() OVER () AS gid,
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
    tr.idtroncon,
    CASE WHEN tr.ame::text = '10'::text OR tr.ame::text = '11'::text THEN 'non aménagé'::text
         WHEN tr.ame::text = 'ZZ'::text THEN 'non concerné'::text
         ELSE 'aménagé'::text
    END AS ame,
    st_linemerge(st_union(tr.geom)) AS geom
 FROM m_mobilite_3v.lk_mob_ititroncon lk
     JOIN m_mobilite_3v.an_mob_itineraire i ON lk.iditi = i.iditi
     JOIN x_apps.xapps_geo_v_mob_troncon_affiche tr ON lk.idtroncon = tr.idtroncon
 GROUP BY i.iditi, tr.idtroncon, tr.ame
WITH DATA;
ALTER TABLE m_mobilite_3v.old_geo_vmr_mob_iti OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue matérialisée regénérant les itinéraires à partir des tronçons
CREATE MATERIALIZED VIEW m_mobilite_3v.xapps_geo_vmr_mob_iti_deparr
TABLESPACE pg_default
AS
 WITH req_t AS (
            SELECT i.iditi, i.depart AS terminus, st_startpoint(st_linemerge(st_union(tr.geom))) AS geom
            FROM m_mobilite_3v.lk_mob_ititroncon lk
               JOIN m_mobilite_3v.an_mob_itineraire i ON lk.iditi = i.iditi
               JOIN m_mobilite_3v.geo_mob_troncon tr ON lk.idtroncon = tr.idtroncon
            WHERE i.iditi = 'I3'::text
            GROUP BY i.iditi
        UNION ALL
            SELECT i.iditi, i.arrivee AS terminus, st_endpoint(st_linemerge(st_union(tr.geom))) AS geom
            FROM m_mobilite_3v.lk_mob_ititroncon lk
               JOIN m_mobilite_3v.an_mob_itineraire i ON lk.iditi = i.iditi
               JOIN m_mobilite_3v.geo_mob_troncon tr ON lk.idtroncon = tr.idtroncon
            WHERE i.iditi = 'I3'::text
            GROUP BY i.iditi)
 SELECT row_number() OVER () AS gid, t.iditi, t.terminus, t.geom
 FROM req_t t
WITH DATA;
ALTER TABLE m_mobilite_3v.xapps_geo_vmr_mob_iti_deparr OWNER TO sig_stage;


--##############################################################OUVELEC#############################################################
-- Vue matérialisée regénérant les itinéraires à partir des tronçons
CREATE MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_triti_nonamenage
TABLESPACE pg_default
AS
 SELECT row_number() OVER () AS gid, i.iditi, tr.geom
 FROM m_mobilite_3v.lk_mob_ititroncon lk
     JOIN m_mobilite_3v.an_mob_itineraire i ON lk.iditi = i.iditi
     JOIN m_mobilite_3v.geo_mob_troncon tr ON lk.idtroncon = tr.idtroncon
 WHERE tr.ame_d::text = '10'::text OR tr.ame_d::text = '11'::text OR tr.ame_g::text = '10'::text OR tr.ame_g::text = '11'::text
WITH DATA;
ALTER TABLE m_mobilite_3v.geo_vmr_mob_triti_nonamenage OWNER TO sig_stage;


-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      TABLES D'ERREUR                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

--##############################################################OUVELEC#############################################################
CREATE TABLE x_apps.xapps_an_v_mob_erreur(
    gid integer NOT NULL,
    id text COLLATE pg_catalog."default",
    erreur character varying(500) COLLATE pg_catalog."default",
    horodatage timestamp without time zone,
    CONSTRAINT xapps_an_v_mob_erreur_pkey PRIMARY KEY (gid)
)
WITH (OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE x_apps.xapps_an_v_mob_erreur OWNER to create_sig;



-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      	  INDEX     	                                                 ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

--##############################################################INDEX#############################################################

CREATE INDEX idx_xapps_an_v_mob_erreur_id
    ON x_apps.xapps_an_v_mob_erreur USING btree
    (id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                       COMMENTAIRES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

COMMENT ON MATERIALIZED VIEW x_apps.xapps_geo_vmr_mob_troncon_affiche IS 'Vue de gestion pour un affichage distinct entre les différents mode d''aménagements des tronçons';

COMMENT ON VIEW m_mobilite_3v.geo_v_mob_noeud IS 'Vue de modélisation des noeuds des tronçons purement cartographique pour géo';

COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab1_apc IS 'Vue permettant d''afficher la longueur totale d''aménagements cyclables en service dans GEO à l''échelle du Pays';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab1_epci IS 'Vue permettant d''afficher la longueur totale d''aménagements cyclables en service par EPCI  dans GEO et la capacité en stationnement ouvert';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab2_apc IS 'Vue permettant d''afficher le pourcentage d''aménagements cyclables différents dans GEO à l''échelle de l''APC';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab2_epci IS 'Vue permettant d''afficher le pourcentage d''aménagements cyclables par EPCI dans GEO (graphique)';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab3 IS 'Vue tableau de bord pour synthèse nombre total d''itinéraire et leur km (Chiffres clés des itinéraires cyclables) afficher avec le filtre du paramètre global';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab31 IS 'Vue tableau de bord pour synthèse nombre total d''itinéraire et leur km (Chiffres clés des itinéraires cyclables)';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab32 IS 'Vue permettant d''afficher un graphique avec le pourcentage des différents aménagements cyclables pour l''itinéraire sélectionné (paramètre global) dans GEO';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab11_apc IS 'Vue permettant d''afficher le tableau des informations des stationnements cyclables en service dans GEO';
COMMENT ON VIEW m_mobilite_3v.xapps_an_v_mob3v_tab11_epci IS 'Vue permettant d''afficher le tableau des informations des stationnements cyclables en service par EPCI dans GEO';

COMMENT ON MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_iti IS 'Vue matérialisée regénérant les itinéraires à partir des tronçons';
COMMENT ON MATERIALIZED VIEW m_mobilite_3v.old_geo_vmr_mob_iti IS 'Vue matérialisée regénérant les itinéraires à partir des tronçons';
COMMENT ON MATERIALIZED VIEW m_mobilite_3v.xapps_geo_vmr_mob_iti_deparr IS 'Vue matérialisée regénérant les itinéraires à partir des tronçons';
COMMENT ON MATERIALIZED VIEW m_mobilite_3v.geo_vmr_mob_triti_nonamenage IS 'Vue matérialisée regénérant les itinéraires à partir des tronçons';

COMMENT ON TABLE x_apps.xapps_an_v_mob_erreur IS 'Table gérant les messages d''erreurs de sécurité remontés dans GEO suite à des enregistrements sur la donnée aménagement cyclable';
COMMENT ON COLUMN x_apps.xapps_an_v_mob_erreur.gid IS 'Identifiant unique';
COMMENT ON COLUMN x_apps.xapps_an_v_mob_erreur.id IS 'Identifiant de l''objet';
COMMENT ON COLUMN x_apps.xapps_an_v_mob_erreur.erreur IS 'Message';
COMMENT ON COLUMN x_apps.xapps_an_v_mob_erreur.horodatage IS 'Date (avec heure) de génération du message (ce champ permet de filtrer l''affichage < x seconds dans GEo)';
