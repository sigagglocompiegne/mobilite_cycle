 
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


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                             VUE OPEN DATA                                                                    ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- #################################################################### vue xopendata_an_v_mob_iti_cycl ###############################################

-- m_mobilite_douce.xopendata_an_v_mob_iti_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_an_v_mob_iti_cycl
AS SELECT c.numero,
    c.nomoff AS nomofficiel,
    c.nomusage,
    c.depart,
    c.arrivee,
    'Non'::text AS estinscrit,
    np.valeur,
    p.d_appro,
    c.url AS siteweb,
    c.d_service AS anneeouverture
   FROM m_mobilite_douce.an_mob_iti_cycl c
     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_iti = c.id_iticycl
     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
     LEFT JOIN m_mobilite_douce.lt_mob_plan_niveau np ON np.code::text = p.plan_niv::text
  WHERE c.dbetat::text = '40'::text AND c.dbstatut::text = '10'::text AND ((p.plan_niv::text = ANY (ARRAY['50'::character varying, '60'::character varying]::text[])) OR p.plan_niv IS NULL);

COMMENT ON VIEW m_mobilite_douce.xopendata_an_v_mob_iti_cycl IS 'Vue opendata des itinéraires cyclables en service avec un statut actif pour les itinéraires de niveau commune/interco';


-- #################################################################### vue xopendata_an_v_statio_cycl ###############################################

-- m_mobilite_douce.xopendata_an_v_statio_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_an_v_statio_cycl
AS SELECT s.id_statio AS id_local,
    NULL::text AS id_osm,
    s.insee AS code_com,
    ((('['::text || st_x(st_transform(s.geom, 4326))::numeric(8,7)) || ','::text) || st_y(st_transform(s.geom, 4326))::numeric(9,7)) || ']'::text AS coordonneesxy,
    s.cap AS capacite,
    s.cap_cargo AS capacite_cargo,
        CASE
            WHEN ta.code::text <> '00'::text THEN ta.valeur
            ELSE ''::character varying
        END AS type_accroche,
        CASE
            WHEN m.code::text <> '00'::text THEN m.valeur
            ELSE ''::character varying
        END AS mobilier,
        CASE
            WHEN a.code::text <> '00'::text THEN a.valeur
            ELSE ''::character varying
        END AS acces,
        CASE
            WHEN s.gratuit::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.gratuit::text = 't'::text THEN 'true'::text
                WHEN s.gratuit::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS gratuit,
        CASE
            WHEN pr.code::text <> '00'::text THEN pr.valeur
            ELSE ''::character varying
        END AS protection,
        CASE
            WHEN s.couvert::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.couvert::text = 't'::text THEN 'true'::text
                WHEN s.couvert::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS couverture,
        CASE
            WHEN s.surv::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.surv::text = 't'::text THEN 'true'::text
                WHEN s.surv::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS surveillance,
        CASE
            WHEN s.lum::text <> ALL (ARRAY['t'::character varying::text, 'f'::character varying::text]) THEN ''::text
            ELSE
            CASE
                WHEN s.lum::text = 't'::text THEN 'true'::text
                WHEN s.lum::text = 'f'::text THEN 'false'::text
                ELSE ''::text
            END
        END AS lumiere,
    s.url AS url_info,
    s.an_pose AS d_service,
        CASE
            WHEN s.epci::text = 'arc'::text THEN 'Agglomération de la Région de Compiègne et de la Basse Automne'::text
            WHEN s.epci::text = 'cclo'::text THEN 'Communauté de Communes des Lisières de l''Oise'::text
            WHEN s.epci::text = 'ccpe'::text THEN 'Communauté de Communes de la Plaine d''Estrées'::text
            WHEN s.epci::text = 'cc2v'::text THEN 'Communauté de Communes des Deux Vallées'::text
            ELSE ''::text
        END AS source,
    g.valeur AS proprietaire,
    p.valeur AS gestionnaire,
        CASE
            WHEN s.dbupdate IS NULL THEN s.dbinsert
            ELSE s.dbinsert
        END AS date_maj,
    s.observ AS commentaires
   FROM m_mobilite_douce.geo_mob_statio_cycl s
     JOIN r_objet.lt_gestio_proprio g ON s.gestio = g.code::text
     JOIN r_objet.lt_gestio_proprio p ON s.proprio = p.code::text
     JOIN m_mobilite_douce.lt_mob_statio_protect pr ON s.protect::text = pr.code::text
     JOIN m_mobilite_douce.lt_mob_statio_acces a ON s.acces::text = a.code::text
     JOIN m_mobilite_douce.lt_mob_statio_mobil m ON s.mobil::text = m.code::text
     JOIN m_mobilite_douce.lt_mob_statio_typ_accro ta ON s.typ_accro::text = ta.code::text
  WHERE s.dbetat::text = '40'::text AND s.dbstatut::text = '10'::text;

COMMENT ON VIEW m_mobilite_douce.xopendata_an_v_statio_cycl IS 'Vue opendata des lieux de stationnements cyclables actifs et en service';


-- #################################################################### vue xopendata_geo_v_mob_amgt_cycl ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl
AS SELECT t.id_tronc AS id_local,
    upper(replace(r.valeur::text, 'é'::text, 'E'::text)) AS reseau_loc,
    string_agg(
        CASE
            WHEN p.plan_niv IS NULL OR (p.plan_niv::text = ANY (ARRAY['50'::character varying::text, '60'::character varying::text])) THEN (
            CASE
                WHEN c.numero IS NOT NULL OR c.numero::text <> ''::text THEN c.numero
                ELSE ''::character varying
            END::text || ' - '::text) || c.nomoff::text
            ELSE NULL::text
        END, ':'::text) AS nom_loc,
    NULL::text AS id_osm,
    string_agg(
        CASE
            WHEN p.plan_niv::text = ANY (ARRAY['10'::character varying::text, '20'::character varying::text, '30'::character varying::text]) THEN (
            CASE
                WHEN c.numero IS NOT NULL OR c.numero::text <> ''::text THEN c.numero
                ELSE ''::character varying
            END::text || ' - '::text) || c.nomoff::text
            ELSE NULL::text
        END, ':'::text) AS num_iti,
    t.insee_d,
    upper(replace(replace(ad.valeur::text, 'é'::text, 'E'::text), 'ê'::text, 'E'::text)) AS ame_d,
    upper(replace(rd.valeur::text, 'é'::text, 'E'::text)) AS regime_d,
    upper(replace(sd.valeur::text, 'é'::text, 'E'::text)) AS sens_d,
    t.largeur_d,
    upper(replace(ld.valeur::text, 'é'::text, 'E'::text)) AS local_d,
    upper(replace(std.valeur::text, 'é'::text, 'E'::text)) AS statut_d,
    upper(replace(rvd.valeur::text, 'é'::text, 'E'::text)) AS revet_d,
    t.insee_g,
    upper(replace(replace(ag.valeur::text, 'é'::text, 'E'::text), 'ê'::text, 'E'::text)) AS ame_g,
    upper(replace(rg.valeur::text, 'é'::text, 'E'::text)) AS regime_g,
    upper(replace(sg.valeur::text, 'é'::text, 'E'::text)) AS sens_g,
    t.largeur_g,
    upper(replace(lg.valeur::text, 'é'::text, 'E'::text)) AS local_g,
    upper(replace(stg.valeur::text, 'é'::text, 'E'::text)) AS statut_g,
    upper(replace(rvg.valeur::text, 'é'::text, 'E'::text)) AS revet_g,
    upper(replace(a.valeur::text, 'é'::text, 'E'::text)) AS acces_ame,
    to_char(t.dbupdate, 'YYYY-MM-DD'::text) AS date_maj,
    t.trafic_vit,
        CASE
            WHEN t.lum::text = 'f'::text THEN 'false'::text
            WHEN t.lum::text = 't'::text THEN 'true'::text
            ELSE NULL::text
        END AS lumiere,
        CASE
            WHEN t.d_service_g = t.d_service_d THEN t.d_service_d
            WHEN t.d_service_g IS NULL OR t.d_service_d IS NOT NULL THEN t.d_service_d
            WHEN t.d_service_d IS NULL OR t.d_service_g IS NOT NULL THEN t.d_service_g
            WHEN t.d_service_d IS NULL OR t.d_service_g IS NULL THEN NULL::integer
            WHEN t.d_service_g > t.d_service_d THEN t.d_service_d
            WHEN t.d_service_g < t.d_service_d THEN t.d_service_g
            ELSE NULL::integer
        END AS d_service,
    t.observ AS comm,
        CASE
            WHEN t.epci_d::text = 'arc'::text THEN 'Agglomération de la Région de Compiègne et de la Basse Automne'::text
            WHEN t.epci_d::text = 'cclo'::text THEN 'Communauté de Communes des Lisières de l''Oise'::text
            WHEN t.epci_d::text = 'ccpe'::text THEN 'Communauté de Communes de la Plaine d''Estrées'::text
            WHEN t.epci_d::text = 'cc2v'::text THEN 'Communauté de Communes des Deux Vallées'::text
            ELSE ''::text
        END AS source,
    t.epci_d,
    'Lambert 93'::text AS project_c,
        CASE
            WHEN t.src_geom::text = '00'::text THEN NULL::text::character varying
            ELSE src.valeur
        END AS ref_geo,
    t.geom
   FROM m_mobilite_douce.geo_mob_troncon t
     JOIN m_mobilite_douce.lt_mob_tronc_res r ON r.code::text = t.typ_res::text
     JOIN m_mobilite_douce.lt_mob_tronc_acces a ON a.code::text = t.acces_ame::text
     JOIN m_mobilite_douce.lt_mob_tronc_ame ad ON ad.code::text = t.ame_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_ame ag ON ag.code::text = t.ame_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_regime rg ON rg.code::text = t.regime_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_regime rd ON rd.code::text = t.regime_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_sens sg ON sg.code::text = t.sens_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_sens sd ON sd.code::text = t.sens_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_local lg ON lg.code::text = t.local_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_local ld ON ld.code::text = t.local_d::text
     JOIN r_objet.lt_etat_avancement stg ON stg.code::text = t.dbetat_g::text
     JOIN r_objet.lt_etat_avancement std ON std.code::text = t.dbetat_d::text
     JOIN m_mobilite_douce.lt_mob_tronc_revet rvg ON rvg.code::text = t.revet_g::text
     JOIN m_mobilite_douce.lt_mob_tronc_revet rvd ON rvd.code::text = t.revet_d::text
     JOIN r_objet.lt_booleen lu ON lu.code::text = t.lum::text
     JOIN r_objet.lt_src_geom src ON src.code::text = t.src_geom::text
     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_iti = t.id_tronc
     LEFT JOIN m_mobilite_douce.an_mob_iti_cycl c ON c.id_iticycl = lki.id_iti
     LEFT JOIN m_mobilite_douce.lk_mob_iti_plan lkp ON lkp.id_plan = c.id_iticycl
     LEFT JOIN m_mobilite_douce.an_mob_plan p ON p.id_plan = lkp.id_plan
  WHERE t.typ_mob::text = '10'::text AND (t.dbetat_d::text = '40'::text OR t.dbetat_g::text = '40'::text) AND t.dbstatut::text = '10'::text
  GROUP BY t.id_tronc, r.valeur, t.insee_d, ad.valeur, rd.valeur, sd.valeur, ld.valeur, std.valeur, rvd.valeur, ag.valeur, rg.valeur, sg.valeur, lg.valeur, stg.valeur, rvg.valeur, src.valeur, t.geom, a.valeur;

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl IS 'Vue opendata des aménagements cyclables';


-- #################################################################### vue xopendata_geo_v_mob_iti_rand ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_iti_rand source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_iti_rand
AS SELECT r.id_itirand AS id_local,
        CASE
            WHEN r.epci = 'arc'::text THEN 'Agglomération de la Région de Compiègne et de la Basse Automne'::text
            WHEN r.epci = 'cclo'::text THEN 'Communauté de Communes des Lisières de l''Oise'::text
            WHEN r.epci = 'ccpe'::text THEN 'Communauté de Communes de la Plaine d''Estrées'::text
            WHEN r.epci = 'cc2v'::text THEN 'Communauté de Communes des Deux Vallées'::text
            ELSE ''::text
        END AS producteur,
    r.contact,
    r.id_itirand AS uuid,
    r.url,
    NULL::text AS id_osm,
    r.nomoff AS nom_itineraire,
        CASE
            WHEN pr.valeur::text = 'VTT'::text THEN 'VTT'::text
            WHEN pr.valeur::text = 'Equestre'::text THEN 'équestre'::text
            ELSE lower(pr.valeur::text)
        END AS pratique,
        CASE
            WHEN tr.valeur::text = 'Etape'::text THEN 'étape'::text
            ELSE lower(tr.valeur::text)
        END AS type_itineraire,
    string_agg(lc.commune::text, ','::text) AS communes_nom,
    string_agg(lkr.insee::text, ','::text) AS communes_code,
    r.depart,
    r.arrivee,
    r.duree,
    r.balisage,
    r.lin_iti AS longueur,
    r.diff_iti AS difficulte,
    r.alti_max AS altitude_max,
    r.alti_min AS altitude_min,
    r.deni_pos AS denivele_positif,
    r.deni_neg AS denivele_negatif,
    r.instruc AS instructions,
    r.present_d AS presentation,
    r.present_c AS presentation_courte,
    r.theme AS themes,
    r.recommand AS recommandations,
    r.accessi AS accessibilite,
    r.acces_r AS acces_routier,
    r.acces_tc AS transports_commun,
    r.park_inf AS parking_info,
    r.park_loc AS parking_geometrie,
    to_char(r.dbinsert, 'YYYY-MM-DD'::text) AS date_creation,
    to_char(r.dbupdate, 'YYYY-MM-DD'::text) AS date_modification,
    NULL::text AS medias,
    NULL::text AS itineraire_parent,
    r.typ_sol AS type_sol,
        CASE
            WHEN r.pdipr::text = 'f'::text THEN 'false'::text
            WHEN r.pdipr::text = 't'::text THEN 'true'::text
            ELSE NULL::text
        END AS pdipr_inscription,
    to_char(r.pdipr_d::timestamp with time zone, 'YYYY-MM-DD'::text) AS pdipr_date_inscription,
    r.epci,
    st_union(st_linemerge(t.geom)) AS geom
   FROM m_mobilite_douce.an_mob_iti_rand r
     JOIN m_mobilite_douce.lt_mob_iti_pratrand pr ON r.prat_iti::text = pr.code::text
     JOIN m_mobilite_douce.lt_mob_iti_typrand tr ON r.typ_iti::text = tr.code::text
     LEFT JOIN m_mobilite_douce.lk_mob_itirand_com lkr ON lkr.id_itirand = r.id_itirand
     LEFT JOIN r_osm.geo_vm_osm_commune_grdc_plus lc ON lc.insee::text = lkr.insee::text
     LEFT JOIN m_mobilite_douce.lk_mob_tronc_iti lki ON lki.id_iti = r.id_itirand
     LEFT JOIN m_mobilite_douce.geo_mob_troncon t ON t.id_tronc = lki.id_tronc
  WHERE st_linemerge(t.geom) IS NOT NULL AND r.dbetat::text = '40'::text AND r.dbstatut::text = '10'::text
  GROUP BY r.id_itirand, r.epci, r.contact, r.url, r.nomoff, pr.valeur, tr.valeur, r.depart, r.arrivee, r.duree, r.balisage, r.lin_iti, r.diff_iti, r.alti_max, r.alti_min, r.deni_pos, r.deni_neg, r.instruc, r.present_d, r.present_c, r.theme, r.recommand, r.accessi, r.acces_r, r.acces_tc, r.park_inf, r.park_loc, r.dbinsert, r.dbupdate, r.typ_sol, r.pdipr, r.pdipr_d;

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_iti_rand IS 'Vue opendata des itinéraires de randonnées en service et avec un statut actif';


