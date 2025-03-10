 
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
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_geo_v_mob_statio_cycl;
DROP VIEW IF exists m_mobilite_douce.xopendata_geo_v_mob_amgt_cycl;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_geo_v_mob_iti_rand;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_geo_v_mob_equip;
DROP VIEW IF EXISTS m_mobilite_douce.xopendata_geo_v_mob_regroup;


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


-- #################################################################### vue xopendata_geo_v_mob_statio_cycl ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_statio_cycl source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_statio_cycl
AS SELECT s.id_statio AS id_local,
    NULL::text AS id_osm,
    s.insee AS code_com,
    ((('['::text || st_x(st_transform(s.geom, 4326))::numeric(8,7)) || ','::text) || st_y(st_transform(s.geom, 4326))::numeric(9,7)) || ']'::text AS coordonneesxy,
    s.cap AS capacite,
    s.cap_cargo AS capacite_cargo,
        CASE
            WHEN ta.code::text <> '00'::text THEN unaccent(upper(ta.valeur))
            ELSE ''::character varying
        END AS type_accroche,
        CASE
            WHEN m.code::text <> '00'::text THEN unaccent(upper(m.valeur))
            ELSE ''::character varying
        END AS mobilier,
        CASE
            WHEN a.code::text <> '00'::text THEN unaccent(upper(a.valeur))
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
            WHEN pr.code::text <> '00'::text THEN unaccent(upper(pr.valeur))
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
            WHEN s.dbupdate IS NULL THEN to_char(s.dbinsert,'YYYY-MM-JJ')
            ELSE to_char(s.dbinsert,'YYYY-MM-JJ')
        END AS date_maj,
    s.observ AS commentaires,
    s.epci,
    s.geom
   FROM m_mobilite_douce.geo_mob_statio_cycl s
     JOIN r_objet.lt_gestio_proprio g ON s.gestio = g.code::text
     JOIN r_objet.lt_gestio_proprio p ON s.proprio = p.code::text
     JOIN m_mobilite_douce.lt_mob_statio_protect pr ON s.protect::text = pr.code::text
     JOIN m_mobilite_douce.lt_mob_statio_acces a ON s.acces::text = a.code::text
     JOIN m_mobilite_douce.lt_mob_statio_mobil m ON s.mobil::text = m.code::text
     JOIN m_mobilite_douce.lt_mob_statio_typ_accro ta ON s.typ_accro::text = ta.code::text
  WHERE s.dbetat::text = '40'::text AND s.dbstatut::text = '10'::text;

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_statio_cycl IS 'Vue opendata des lieux de stationnements cyclables actifs et en service';



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

-- #################################################################### vue xopendata_geo_v_mob_regroup ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_regroup source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_regroup
AS WITH req_photo AS (
         SELECT an_mob_equip_regroup_media.id,
            'https://geo.compiegnois.fr/fichier_ref/metiers/mob/mob_douce/equip_regroup/'::text || an_mob_equip_regroup_media.n_fichier AS photo
           FROM m_mobilite_douce.an_mob_equip_regroup_media
          GROUP BY an_mob_equip_regroup_media.id, an_mob_equip_regroup_media.n_fichier
         LIMIT 1
        )
 SELECT (r.insee::text || '_REQUIP_'::text) || num_ordre AS id_regroupement,
    r.nom,
        CASE
            WHEN r.dbetat::text = ANY (ARRAY['40'::character varying, '90'::character varying]::text[]) THEN 'existante'::text
            WHEN r.dbetat::text = ANY (ARRAY['10'::character varying, '20'::character varying, '30'::character varying]::text[]) THEN 'en projet'::text
            WHEN r.dbetat::text = '00'::text THEN 'préconisé'::text
            ELSE NULL::text
        END AS statut,
    i.valeur AS importance,
    r.nb_equip,
        CASE
            WHEN p.photo IS NULL THEN p.photo
            ELSE NULL::text
        END AS photo,
    r.insee AS code_com,
    NULL::text AS src_photo,
    NULL::text AS l_photo
   FROM m_mobilite_douce.geo_mob_regroup r
     JOIN m_mobilite_douce.lt_mob_regroup_imp i ON r.importance::text = i.code::text
     LEFT JOIN req_photo p ON p.id = r.id_regroup where r.dbstatut = '10' ;

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_regroup IS 'Vue opendata des regroupements des équipements vélos';

-- #################################################################### vue xopendata_geo_v_mob_equip ###############################################

-- m_mobilite_douce.xopendata_geo_v_mob_equip source

CREATE OR REPLACE VIEW m_mobilite_douce.xopendata_geo_v_mob_equip
AS ( WITH req_photo AS (
         SELECT an_mob_equip_regroup_media.id,
            'https://geo.compiegnois.fr/documents/metiers/mob/mob_douce/equip_regroup/'::text || an_mob_equip_regroup_media.n_fichier AS photo
           FROM m_mobilite_douce.an_mob_equip_regroup_media
          GROUP BY an_mob_equip_regroup_media.id, an_mob_equip_regroup_media.n_fichier
        )
 SELECT (e.insee::text || '_EV_'::text) || e.num_ordre::text AS id_equip,
    e.id_eqvelo AS id_local,
    e.insee AS code_com,
    lte.valeur AS type_equip,
    lste.valeur AS ss_type_equip,
    p.valeur AS protection,
    NULL::smallint AS capacite,
        CASE
            WHEN e.dbetat::text = ANY (ARRAY['00'::character varying::text, 'ZZ'::character varying::text]) THEN 'Non renseigné'::character varying
            WHEN e.dbetat::text = ANY (ARRAY['10'::character varying::text, '20'::character varying::text, '30'::character varying::text]) THEN 'en projet'::character varying
            WHEN e.dbetat::text = '90'::text THEN 'moyen'::character varying
            WHEN em.code::text = '30'::text THEN 'dégradé'::character varying
            ELSE em.valeur
        END AS etat,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(e.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, ', '::text) AS string_agg
           FROM req_p p_1
             LEFT JOIN r_objet.lt_gestio_proprio l ON p_1.code = l.code::text) AS proprietaire,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(e.gestio, ';'::text)) AS code
                )
         SELECT string_agg(lg.valeur::text, ', '::text) AS string_agg
           FROM req_g g_1
             LEFT JOIN r_objet.lt_gestio_proprio lg ON g_1.code = lg.code::text) AS gestionnaire,
        CASE
            WHEN c.code::text = ANY (ARRAY['0'::character varying::text, 'z'::character varying::text]) THEN 'Pas d''information'::character varying
            ELSE c.valeur
        END AS couvert,
        CASE
            WHEN c1.code::text = ANY (ARRAY['0'::character varying::text, 'z'::character varying::text]) THEN 'Pas d''information'::character varying
            ELSE c1.valeur
        END AS payant,
        CASE
            WHEN c2.code::text = ANY (ARRAY['0'::character varying::text, 'z'::character varying::text]) THEN 'Pas d''information'::character varying
            ELSE c2.valeur
        END AS acces_pmr,
    st_x(st_transform(e.geom, 4326)) AS longitude,
    st_y(st_transform(e.geom, 4326)) AS latitude,
    e.x_l93 AS x,
    e.y_l93 AS y,
    ( SELECT ph.photo
         LIMIT 1) AS photo,
    s.valeur AS source,
    g.lib_epci AS producteur,
        CASE
            WHEN e.dbupdate IS NULL THEN to_char(e.dbinsert, 'YYYY-MM-DD'::text)
            ELSE to_char(e.dbupdate, 'YYYY-MM-DD'::text)
        END AS date_maj,
    e.observ AS commentaire,
    (e.insee::text || '_REQUIP_'::text) || num_ordre AS id_regroupement,
    NULL::text AS src_photo,
    'CC BY'::text AS l_photo
   FROM m_mobilite_douce.geo_mob_equip_velo e
     LEFT JOIN m_mobilite_douce.lt_mob_eqvelo_type lte ON e.type_equip::text = lte.code::text
     LEFT JOIN m_mobilite_douce.lt_mob_eqvelo_sstype lste ON e.ss_type_equip::text = lste.code::text
     LEFT JOIN m_mobilite_douce.lt_mob_statio_protect p ON e.protect::text = p.code::text
     LEFT JOIN m_mobilite_douce.lt_mob_etat em ON e.etat_mob::text = em.code::text
     LEFT JOIN r_objet.lt_booleen c ON e.couvert::text = c.code::text
     LEFT JOIN r_objet.lt_booleen c1 ON e.payant::text = c1.code::text
     LEFT JOIN r_objet.lt_booleen c2 ON e.acces_pmr::text = c2.code::text
     LEFT JOIN r_objet.lt_src_geom s ON e.src_geom::text = s.code::text
     LEFT JOIN req_photo ph ON ph.id = e.id_eqvelo
     LEFT JOIN r_administratif.an_geo g ON g.insee::text = e.insee::text
  WHERE e.dbstatut::text = '10'::text)
UNION ALL
( WITH req_photo AS (
         SELECT an_mob_statio_cylc_media.id,
            'https://geo.compiegnois.fr/documents/metiers/mob/mob_douce/statio/'::text || an_mob_statio_cylc_media.n_fichier AS photo
           FROM m_mobilite_douce.an_mob_statio_cylc_media
          GROUP BY an_mob_statio_cylc_media.id, an_mob_statio_cylc_media.n_fichier
        )
 SELECT (s.insee::text || '_EV_'::text) || s.num_ordre::text AS id_equip,
    s.id_statio AS id_local,
    s.insee AS code_com,
        CASE
            WHEN s.typ_accro::text = '21'::text THEN 'stationnement ancrage cadre et roue'::text
            WHEN s.typ_accro::text = '30'::text THEN 'stationnement sans accroche'::text
            WHEN s.typ_accro::text = '10'::text THEN 'stationnement ancrage roue'::text
            WHEN s.typ_accro::text = '20'::text THEN 'stationnement ancrage cadre'::text
            ELSE 'stationnement (ancrage non renseigné)'::text
        END AS type_equip,
    m.valeur AS ss_type_equip,
    p.valeur AS protection,
    s.cap AS capacite,
        CASE
            WHEN s.dbetat::text = ANY (ARRAY['00'::character varying::text, 'ZZ'::character varying::text]) THEN 'Non renseigné'::character varying
            WHEN s.dbetat::text = ANY (ARRAY['10'::character varying::text, '20'::character varying::text, '30'::character varying::text]) THEN 'en projet'::character varying
            WHEN s.dbetat::text = '90'::text THEN 'moyen'::character varying
            WHEN em.code::text = '30'::text THEN 'dégradé'::character varying
            ELSE em.valeur
        END AS etat,
    ( WITH req_p AS (
                 SELECT unnest(string_to_array(s.proprio, ';'::text)) AS code
                )
         SELECT string_agg(l.valeur::text, ', '::text) AS string_agg
           FROM req_p p_1
             LEFT JOIN r_objet.lt_gestio_proprio l ON p_1.code = l.code::text) AS proprietaire,
    ( WITH req_g AS (
                 SELECT unnest(string_to_array(s.gestio, ';'::text)) AS code
                )
         SELECT string_agg(lg.valeur::text, ', '::text) AS string_agg
           FROM req_g g_1
             LEFT JOIN r_objet.lt_gestio_proprio lg ON g_1.code = lg.code::text) AS gestionnaire,
        CASE
            WHEN c.code::text = ANY (ARRAY['0'::character varying::text, 'z'::character varying::text]) THEN 'Pas d''information'::character varying
            ELSE c.valeur
        END AS couvert,
        CASE
            WHEN s.gratuit::text = '10'::text THEN 'Non'::text
            WHEN s.gratuit::text = '30'::text THEN 'Oui'::text
            ELSE 'Pas d''information'::text
        END AS payant,
    'Pas d''information'::character varying AS acces_pmr,
    st_x(st_transform(s.geom, 4326)) AS longitude,
    st_y(st_transform(s.geom, 4326)) AS latitude,
    s.x_l93 AS x,
    s.y_l93 AS y,
    ( SELECT ps.photo
         LIMIT 1) AS photo,
    src.valeur AS source,
    g.lib_epci AS producteur,
        CASE
            WHEN s.dbupdate IS NULL THEN to_char(s.dbinsert, 'YYYY-MM-DD'::text)
            ELSE to_char(s.dbupdate, 'YYYY-MM-DD'::text)
        END AS date_maj,
    s.observ AS commentaire,
    (s.insee::text || '_REQUIP_'::text) || ( SELECT r.num_ordre
           FROM m_mobilite_douce.geo_mob_regroup r
          WHERE st_intersects(r.geom, s.geom) IS TRUE) AS id_regroupement,
    NULL::text AS src_photo,
    'CC BY'::text AS l_photo
   FROM m_mobilite_douce.geo_mob_statio_cycl s
     LEFT JOIN m_mobilite_douce.lt_mob_statio_mobil m ON s.mobil::text = m.code::text
     LEFT JOIN m_mobilite_douce.lt_mob_statio_protect p ON s.protect::text = p.code::text
     LEFT JOIN m_mobilite_douce.lt_mob_etat em ON s.etat_mob::text = em.code::text
     LEFT JOIN r_objet.lt_booleen c ON s.couvert::text = c.code::text
     LEFT JOIN r_objet.lt_src_geom src ON s.src_geom::text = src.code::text
     LEFT JOIN req_photo ps ON ps.id = s.id_statio
     LEFT JOIN r_administratif.an_geo g ON g.insee::text = s.insee::text
  WHERE s.dbstatut::text = '10'::text);

COMMENT ON VIEW m_mobilite_douce.xopendata_geo_v_mob_equip IS 'Vue opendata des équipements liés au vélo y compris le stationnement cyclable';

