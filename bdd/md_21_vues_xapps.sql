 
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
drop view if exists m_mobilite_douce.xapps_an_v_statio_cycl_tab1;
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
            t.requal_g AS requal,
            sum(t.lin_d) AS lineaire,
            t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_d::text = ea.code::text
          WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci_d, ea.valeur, ea.code, t.gestio_d, t.proprio_d, t.requal_g
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_g AS ame,
            t.gestio_g AS gestio,
            t.proprio_g AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            t.requal_g AS requal,
            sum(t.lin_g) AS lineaire,
            t.epci_g AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_g::text = ea.code::text
          WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci_g, ea.valeur, ea.code, t.gestio_g, t.proprio_g, t.requal_g
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_g AS ame,
            t.gestio_g AS gestio,
            t.proprio_g AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            t.requal_g AS requal,
            sum(t.lin_g) AS lineaire,
            t.epci_g AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_g::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_g::text = ea.code::text
          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbetat_g::text = '40'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_g, am.valeur, t.epci_g, ea.valeur, ea.code, t.gestio_g, t.proprio_g, t.requal_g
          ORDER BY am.valeur)
        UNION ALL
        ( SELECT t.ame_d AS ame,
            t.gestio_d AS gestio,
            t.proprio_d AS proprio,
            am.valeur AS lib_ame,
            ea.code AS cod_avancement,
            ea.valeur AS avancement,
            t.requal_d AS requal,
            sum(t.lin_d) AS lineaire,
            t.epci_d AS epci
           FROM m_mobilite_douce.geo_mob_troncon t
             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
             LEFT JOIN r_objet.lt_etat_avancement ea ON t.dbetat_d::text = ea.code::text
          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbetat_d::text = '40'::text AND t.dbstatut::text = '10'::text
          GROUP BY t.ame_d, am.valeur, t.epci_d, ea.valeur, ea.code, t.gestio_d, t.proprio_d, t.requal_d
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
    d.requal,
    d.lib_ame,
        CASE
            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
            ELSE sum(d.lineaire)
        END AS lineaire
   FROM req_epci e
     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
  WHERE e.epci::text = ANY (ARRAY['arc'::character varying::text, 'cc2v'::character varying::text, 'ccpe'::character varying::text, 'cclo'::character varying::text])
  GROUP BY e.epci, d.ame, d.lib_ame, d.avancement, d.cod_avancement, d.gestio, d.proprio, d.requal;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_amgt_cycl_tab IS 'Vue attributaire pour la génération du TAB (synthèse du linéaire d''aménagement en service par EPCI )';

-- Permissions

ALTER TABLE m_mobilite_douce.xapps_an_v_amgt_cycl_tab OWNER TO sig_create;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_amgt_cycl_tab TO sig_create;
GRANT DELETE, SELECT, INSERT, TRUNCATE, UPDATE ON TABLE m_mobilite_douce.xapps_an_v_amgt_cycl_tab TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_amgt_cycl_tab TO sig_read;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_amgt_cycl_tab TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_amgt_cycl_tab TO postgres;
   
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

-- Permissions

ALTER TABLE m_mobilite_douce.xapps_an_v_cycl_tab1 OWNER TO sig_create;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_cycl_tab1 TO sig_create;
GRANT DELETE, SELECT, INSERT, TRUNCATE, UPDATE ON TABLE m_mobilite_douce.xapps_an_v_cycl_tab1 TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_cycl_tab1 TO sig_read;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_cycl_tab1 TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_cycl_tab1 TO postgres;
   
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
                    t.requal_d AS requal,
                    t.reqame_d AS ame_requal,
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
                  WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_d, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbetat, r.dbetat, i_2.dbstatut, r.dbstatut, t.requal_d, t.reqame_d
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
                    t.requal_g AS requal,
                    t.reqame_g AS ame_requal,
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
                  WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_g, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbetat, r.dbetat, i_2.dbstatut, r.dbstatut, t.requal_g, t.reqame_g
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
                    t.requal_g AS requal,
                    t.reqame_g AS ame_requal,
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
                  WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_g, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbetat, r.dbetat, i_2.dbstatut, r.dbstatut, t.requal_g, t.reqame_g
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
                    t.requal_d AS requal,
                    t.reqame_d AS ame_requal,
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
                  WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                  GROUP BY t.ame_d, am.valeur, t.epci, i_2.id_iticycl, i_2.numero, i_2.nomoff, s.valeur, p.id_plan, r.id_itirand, p.libelle, t.id_tronc, i_2.dbstatut, r.dbstatut, i_2.dbetat, r.dbetat, t.requal_d, t.reqame_d
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
            d.requal,
            d.ame_requal,
            i_1.n_itivar,
            i_1.id_itivar
           FROM req_epci_dg d
             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i_1 ON i_1.id_iticycl = d.id_iticycl
          WHERE d.id_iticycl IS NOT NULL OR d.id_itirand IS NOT NULL
          GROUP BY d.ame, d.lib_ame, d.dbetat, d.id_iticycl, d.numero, d.nomoff, d.id_plan, d.libelle_plan, d.epci, d.id_tronc, i_1.n_itivar, i_1.numero, i_1.nomoff, i_1.id_itivar, d.id_itirand, d.dbstatut_iti_cycl, d.dbstatut_iti_rand, d.gestio, d.proprio, d.requal, d.ame_requal
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
        CASE
            WHEN ame.valeur::text <> 'Non concerné'::text AND ame.valeur::text <> 'Non renseigné'::text THEN ame.valeur
            ELSE 'Non'::character varying
        END AS requal,
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
     LEFT JOIN r_objet.lt_statut s2 ON s2.code::text = req_fin.dbstatut_iti_rand::text
     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame ame ON ame.code::text = req_fin.ame_requal::text;

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_iti_ame_tab IS 'Vue attributaire pour la génération du TAB (statut et type d''aménagement par itinéraire)';

-- Permissions

ALTER TABLE m_mobilite_douce.xapps_an_v_iti_ame_tab OWNER TO sig_create;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_iti_ame_tab TO sig_create;
GRANT DELETE, SELECT, INSERT, TRUNCATE, UPDATE ON TABLE m_mobilite_douce.xapps_an_v_iti_ame_tab TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_iti_ame_tab TO sig_read;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_iti_ame_tab TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_iti_ame_tab TO postgres;
   
   
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

-- Permissions

ALTER TABLE m_mobilite_douce.xapps_an_v_iti_cycl_tab OWNER TO sig_create;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_iti_cycl_tab TO sig_create;
GRANT DELETE, SELECT, INSERT, TRUNCATE, UPDATE ON TABLE m_mobilite_douce.xapps_an_v_iti_cycl_tab TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_iti_cycl_tab TO sig_read;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_iti_cycl_tab TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_iti_cycl_tab TO postgres;

-- #################################################################### vue xapps_an_v_iti_tab ###############################################
-- m_mobilite_douce.xapps_an_v_iti_tab source

CREATE OR REPLACE VIEW m_mobilite_douce.xapps_an_v_iti_tab
AS ( WITH req_tot_cycl AS (
         WITH req_fin_cycl AS (
                 WITH req_epci_dg AS (
                        ( SELECT sum(t.lin_d) AS lineaire,
                            t.dbetat_d AS dbetat,
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
                          WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_d, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_d
                          ORDER BY am.valeur)
                        UNION ALL
                        ( SELECT sum(t.lin_g) AS lineaire,
                            t.dbetat_g AS dbetat,
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
                          WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_g, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_g
                          ORDER BY am.valeur)
                        UNION ALL
                        ( SELECT sum(t.lin_g) AS lineaire,
                            t.dbetat_d AS dbetat,
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
                          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_g, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_d
                          ORDER BY am.valeur)
                        UNION ALL
                        ( SELECT sum(t.lin_d) AS lineaire,
                            t.dbetat_d AS dbetat,
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
                          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_d, am.valeur, t.epci, i.id_iticycl, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_d
                          ORDER BY am.valeur)
                        ), req_epci AS (
                         SELECT DISTINCT t.epci_d AS epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                        )
                 SELECT e.epci,
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
                    a.valeur AS dbetat,
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
                     LEFT JOIN r_objet.lt_etat_avancement a ON a.code::text = d.dbetat::text
                  WHERE d.id_iticycl IS NOT NULL
                  GROUP BY e.epci, d.id_iticycl, d.id_itirand, d.numero, d.nomoff, d.cout, d.subv, d.n_itivar, a.valeur
                )
         SELECT row_number() OVER () AS id,
            req_fin_cycl.epci,
            sum(req_fin_cycl.lineaire) AS lineaire,
            req_fin_cycl.cout,
            req_fin_cycl.subv,
            string_agg(DISTINCT ((req_fin_cycl.dbetat::text || ' '::text) || req_fin_cycl.lineaire) || 'm'::text, '-'::text) AS dbetat,
            req_fin_cycl.id_iticycl,
            req_fin_cycl.id_itirand,
            req_fin_cycl.numero,
            req_fin_cycl.nomoff,
            req_fin_cycl.aff_nom_iti
           FROM req_fin_cycl
          GROUP BY req_fin_cycl.epci, req_fin_cycl.cout, req_fin_cycl.subv, req_fin_cycl.id_iticycl, req_fin_cycl.id_itirand, req_fin_cycl.numero, req_fin_cycl.nomoff, req_fin_cycl.aff_nom_iti
        ), req_tot_cycl_requa AS (
         WITH req_fin_cycl_requa AS (
                 WITH req_epci_dg AS (
                         SELECT sum(t.lin_d) AS lineaire,
                            t.reqame_d AS reqame,
                            i.id_iticycl,
                            NULL::text AS id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                          WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_d::text <> 'ZZ'::text
                          GROUP BY t.ame_d, t.epci, i.id_iticycl, t.reqame_d
                        UNION ALL
                         SELECT sum(t.lin_g) AS lineaire,
                            t.reqame_g AS reqame,
                            i.id_iticycl,
                            NULL::text AS id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                          WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_g::text <> 'ZZ'::text
                          GROUP BY t.ame_g, t.epci, i.id_iticycl, t.reqame_g
                        UNION ALL
                         SELECT sum(t.lin_g) AS lineaire,
                            t.reqame_d AS reqame,
                            i.id_iticycl,
                            NULL::text AS id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_d::text <> 'ZZ'::text
                          GROUP BY t.ame_g, t.epci, i.id_iticycl, t.reqame_d
                        UNION ALL
                         SELECT sum(t.lin_d) AS lineaire,
                            t.reqame_d AS reqame,
                            i.id_iticycl,
                            NULL::text AS id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_cycl i ON i.id_iticycl = lki.id_iti
                          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_d::text <> 'ZZ'::text
                          GROUP BY t.ame_d, t.epci, i.id_iticycl, t.reqame_d
                        ), req_epci AS (
                         SELECT DISTINCT t.epci_d AS epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                        )
                 SELECT e.epci,
                        CASE
                            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
                            ELSE sum(d.lineaire)
                        END AS lineaire,
                    ame.valeur AS reqame,
                    d.id_iticycl,
                    d.id_itirand
                   FROM req_epci e
                     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame ame ON ame.code::text = d.reqame::text
                  WHERE d.id_iticycl IS NOT NULL
                  GROUP BY e.epci, d.id_iticycl, d.id_itirand, ame.valeur
                )
         SELECT row_number() OVER () AS id,
            req_fin_cycl_requa.epci,
            'En requalification (tronçon en service) : '::text || string_agg(((req_fin_cycl_requa.reqame::text || ' '::text) || req_fin_cycl_requa.lineaire) || 'm'::text, ','::text) AS reqame,
            req_fin_cycl_requa.id_iticycl,
            req_fin_cycl_requa.id_itirand
           FROM req_fin_cycl_requa
          GROUP BY req_fin_cycl_requa.epci, req_fin_cycl_requa.id_iticycl, req_fin_cycl_requa.id_itirand
        )
 SELECT f.epci,
    f.lineaire,
    f.cout,
    f.subv,
    f.dbetat,
        CASE
            WHEN fr.reqame IS NOT NULL THEN fr.reqame
            ELSE ' '::text
        END AS reqame,
    f.id_iticycl,
    f.id_itirand,
    f.numero,
    f.nomoff,
    f.aff_nom_iti
   FROM req_tot_cycl f
     LEFT JOIN req_tot_cycl_requa fr ON f.id_iticycl = fr.id_iticycl)
UNION ALL
( WITH req_tot_rand AS (
         WITH req_fin_rand AS (
                 WITH req_epci_dg AS (
                        ( SELECT sum(t.lin_d) AS lineaire,
                            t.dbetat_d AS dbetat,
                            i.p_cout AS cout,
                            i.p_subv AS subv,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            i.numero,
                            i.nomoff,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
                             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
                             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                          WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_d, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_d
                          ORDER BY am.valeur)
                        UNION ALL
                        ( SELECT sum(t.lin_g) AS lineaire,
                            t.dbetat_g AS dbetat,
                            i.p_cout AS cout,
                            i.p_subv AS subv,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            i.numero,
                            i.nomoff,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
                             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
                             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                          WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_g, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_g
                          ORDER BY am.valeur)
                        UNION ALL
                        ( SELECT sum(t.lin_g) AS lineaire,
                            t.dbetat_d AS dbetat,
                            i.p_cout AS cout,
                            i.p_subv AS subv,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            i.numero,
                            i.nomoff,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_g::text
                             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
                             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_g, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_d
                          ORDER BY am.valeur)
                        UNION ALL
                        ( SELECT sum(t.lin_d) AS lineaire,
                            t.dbetat_d AS dbetat,
                            i.p_cout AS cout,
                            i.p_subv AS subv,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            i.numero,
                            i.nomoff,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN r_objet.lt_etat_avancement s ON s.code::text = t.dbetat_d::text
                             LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame am ON t.ame_d::text = am.code::text
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                             LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = i.id_itirand
                             LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
                          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text
                          GROUP BY t.ame_d, am.valeur, t.epci, i.id_itirand, i.numero, i.nomoff, p.id_plan, p.libelle, t.dbetat_d
                          ORDER BY am.valeur)
                        ), req_epci AS (
                         SELECT DISTINCT t.epci_d AS epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                        )
                 SELECT e.epci,
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
                    a.valeur AS dbetat,
                    d.id_iticycl,
                    d.id_itirand,
                    d.numero,
                    d.nomoff,
                        CASE
                            WHEN d.numero IS NOT NULL OR d.numero::text <> ''::text THEN d.numero::text || ' - '::text
                            ELSE ''::text
                        END || d.nomoff::text AS aff_nom_iti
                   FROM req_epci e
                     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
                     LEFT JOIN r_objet.lt_etat_avancement a ON a.code::text = d.dbetat::text
                  WHERE d.id_itirand IS NOT NULL
                  GROUP BY e.epci, d.id_iticycl, d.id_itirand, d.numero, d.nomoff, d.cout, d.subv, a.valeur
                )
         SELECT row_number() OVER () AS id,
            req_fin_rand.epci,
            sum(req_fin_rand.lineaire) AS lineaire,
            req_fin_rand.cout,
            req_fin_rand.subv,
            string_agg(DISTINCT ((req_fin_rand.dbetat::text || ' '::text) || req_fin_rand.lineaire) || 'm'::text, '-'::text) AS dbetat,
            req_fin_rand.id_iticycl,
            req_fin_rand.id_itirand,
            req_fin_rand.numero,
            req_fin_rand.nomoff,
            req_fin_rand.aff_nom_iti
           FROM req_fin_rand
          GROUP BY req_fin_rand.epci, req_fin_rand.cout, req_fin_rand.subv, req_fin_rand.id_iticycl, req_fin_rand.id_itirand, req_fin_rand.numero, req_fin_rand.nomoff, req_fin_rand.aff_nom_iti
        ), req_tot_rand_requa AS (
         WITH req_fin_rand_requa AS (
                 WITH req_epci_dg AS (
                         SELECT sum(t.lin_d) AS lineaire,
                            t.reqame_d AS reqame,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                          WHERE t.ame_g::text = 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_d::text <> 'ZZ'::text
                          GROUP BY t.ame_d, t.epci, i.id_itirand, t.reqame_d
                        UNION ALL
                         SELECT sum(t.lin_g) AS lineaire,
                            t.reqame_g AS reqame,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                          WHERE t.ame_d::text = 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_g::text <> 'ZZ'::text
                          GROUP BY t.ame_g, t.epci, i.id_itirand, t.reqame_g
                        UNION ALL
                         SELECT sum(t.lin_g) AS lineaire,
                            t.reqame_d AS reqame,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                          WHERE t.ame_d::text <> 'ZZ'::text AND t.ame_g::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_d::text <> 'ZZ'::text
                          GROUP BY t.ame_g, t.epci, i.id_itirand, t.reqame_d
                        UNION ALL
                         SELECT sum(t.lin_d) AS lineaire,
                            t.reqame_d AS reqame,
                            NULL::text AS id_iticycl,
                            i.id_itirand,
                            t.epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                             LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_tronc = t.id_tronc
                             LEFT JOIN m_mobilite_douce.an_mob_iti_rand i ON i.id_itirand = lki.id_iti
                          WHERE t.ame_g::text <> 'ZZ'::text AND t.ame_d::text <> 'ZZ'::text AND t.dbstatut::text = '10'::text AND t.reqame_d::text <> 'ZZ'::text
                          GROUP BY t.ame_d, t.epci, i.id_itirand, t.reqame_d
                        ), req_epci AS (
                         SELECT DISTINCT t.epci_d AS epci
                           FROM m_mobilite_douce.geo_mob_troncon t
                        )
                 SELECT e.epci,
                        CASE
                            WHEN sum(d.lineaire) IS NULL THEN 0::numeric
                            ELSE sum(d.lineaire)
                        END AS lineaire,
                    ame.valeur AS reqame,
                    d.id_iticycl,
                    d.id_itirand
                   FROM req_epci e
                     LEFT JOIN req_epci_dg d ON e.epci::text = d.epci::text
                     LEFT JOIN m_mobilite_douce.lt_mob_tronc_ame ame ON ame.code::text = d.reqame::text
                  WHERE d.id_itirand IS NOT NULL
                  GROUP BY e.epci, d.id_iticycl, d.id_itirand, ame.valeur
                )
         SELECT row_number() OVER () AS id,
            req_fin_rand_requa.epci,
            'En requalification (tronçon en service) : '::text || string_agg(((req_fin_rand_requa.reqame::text || ' '::text) || req_fin_rand_requa.lineaire) || 'm'::text, ','::text) AS reqame,
            req_fin_rand_requa.id_iticycl,
            req_fin_rand_requa.id_itirand
           FROM req_fin_rand_requa
          GROUP BY req_fin_rand_requa.epci, req_fin_rand_requa.id_iticycl, req_fin_rand_requa.id_itirand
        )
 SELECT f.epci,
    f.lineaire,
    f.cout,
    f.subv,
    f.dbetat,
        CASE
            WHEN fr.reqame IS NOT NULL THEN fr.reqame
            ELSE ' '::text
        END AS reqame,
    f.id_iticycl,
    f.id_itirand,
    f.numero,
    f.nomoff,
    f.aff_nom_iti
   FROM req_tot_rand f
     LEFT JOIN req_tot_rand_requa fr ON f.id_itirand = fr.id_itirand);

COMMENT ON VIEW m_mobilite_douce.xapps_an_v_iti_tab IS 'Vue attributaire pour la génération du TAB (synthèse du linéaire d''aménagement en service par EPCI et par itinéraire )';

-- Permissions

ALTER TABLE m_mobilite_douce.xapps_an_v_iti_tab OWNER TO sig_create;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_iti_tab TO sig_create;
GRANT DELETE, SELECT, INSERT, TRUNCATE, UPDATE ON TABLE m_mobilite_douce.xapps_an_v_iti_tab TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_iti_tab TO sig_read;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_iti_tab TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_iti_tab TO postgres;

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

-- Permissions

ALTER TABLE m_mobilite_douce.xapps_an_v_statio_cycl_tab1 OWNER TO sig_create;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_statio_cycl_tab1 TO sig_create;
GRANT DELETE, SELECT, INSERT, TRUNCATE, UPDATE ON TABLE m_mobilite_douce.xapps_an_v_statio_cycl_tab1 TO create_sig;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_statio_cycl_tab1 TO sig_read;
GRANT SELECT ON TABLE m_mobilite_douce.xapps_an_v_statio_cycl_tab1 TO sig_edit;
GRANT ALL ON TABLE m_mobilite_douce.xapps_an_v_statio_cycl_tab1 TO postgres;

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




