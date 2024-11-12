![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des mobilités douces #

## Principes
  * **généralité** :

En 2022, un nouveau cadre de mutualisation s'est ouvert avec l'accueil d'une nouvelle EPCI formant ainsi le territoire du Grand Compiégnois comprenant désormais 4 EPCI. Celui-ci a fait émerger l'envie de disposer d'une application sur la gestion des mobilités douces plus large que celle exitante, et surtout à destination des services mobilités. L'objectif est de laisser la gestion de l'information aux EPCI et plus au Service Information Géographique de l'Agglomération de la Région de Compiègne.

Cette application repose sur le développement d'une base de données partagée, stockée dans l'entrepôt de données du GéoCompiégnois, et à la fois étanche entre chaque EPCI.

L'application ainsi développée permet à chaque EPCI de disposer de ses propres données et de bénéficier des apports fonctionnels de tous. Elle permet également de visualiser les informations des autres EPCI afin d'assurer les continuités territoriales.
 
 * **résumé fonctionnel** :

Pour rappel des grands principes :

* le modèle de données et l'application répondent à un besoin de connaissance et de gestion des aménagements et du stationnement cyclables par les services mobilités de chaque intercommunalité
* la restitution des itinéraires (cyclables ou de randonnées) est intégré dans l'application à partir des tronçons aménagés et associés à des itinéraires
* restitution des informations pour alimentation de l'OpenData et de support de communications


## Schéma fonctionnel

(en cours de réalisation)

## Modèle relationel simplifié


![md_mcd](md_mcd.png)

## Dépendances

Cette base de donnnées est dépendante de listes de valeurs contenues dans le schéma r_objet (lt_etat_avancement, lt_statut, lt_src_geom, lt_gestio_proprio, lt_booleen).


## Classes d'objets des mobilités douces

L'ensemble des classes d'objets de gestion sont stockés dans le schéma `m_mobilite_douce`.

### Classes d'objets géographique :

`[m_mobilite_douce].[geo_mob_pan]` : table géographique contenant la localisation des panneaux routiers et de signalétiques cyclables/randonnées
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id_pan|Identifiant unique interne|text|('P'::text || nextval('m_mobilite_douce.geo_mob_pan_seq'::regclass))|
|id_tronc|Identifiant du tronçon le plus proche|text| |
|typ_sign|Type de signalisation|character varying(2)|'00'::character varying|
|typ_pan|Type de panneau|character varying(2)|'00'::character varying|
|code_pan|Code officiel du panneau|character varying(50)|'00'::character varying|
|etat_mob|Etat du support|character varying(2)|'00'::character varying|
|an_pose|Année de pose|integer| |
|azimuth|Angle en degrés entre la direction du panneau dans son axe de lecture et le nord. Indique la direction vers laquelle l'information portée par le panneau s'applique.|integer| |
|rattach|Référence le tronçon de route sur lequel s'applique la directive inscrite sur le panneau.|text| |
|dbetat|Etat d'avancement (Niveau de réalisation) du panneau|character varying(2)|'40'::character varying|
|dbstatut|Statut du panneau|character varying(2)|'10'::character varying|
|proprio|Nom de l'organisme qui entretient le panneau|text|'00'::text|
|gestio|Nom de l'aménageur|text|'00'::text|
|observ|Commentaire(s)|character varying(1000)| |
|src_geom|Code du référentiel géographique utilisé pour la saisie|character varying(2)|'24'::character varying|
|src_annee|Année du référentiel géographique|character varying(4)|'2021'::character varying|
|insee|Code Insee  de la commune d'implantation du panneau|character varying(5)| |
|commune|Commune d'implantation du panneau|character varying(80)| |
|epci|EPCI d'assise du panneau|character varying(5)| |
|op_sai|Opérateur de saisie|character varying(50)| |
|op_maj|Opérateur de mise à jour|character varying(50)| |
|dbinsert|Date d'insertion dans la base de données|timestamp without time zone|now()|
|dbupdate|Date de mise à jour dans la base de données|timestamp without time zone| |
|x_l93|Coordonnées X en Lambert 93|numeric| |
|y_l93|Coordonnées Y en Lambert 93|numeric| |
|geom|Classe d'objets géométrique|point(2154)| |
|gestio_a|Libellé de l'autre aménageur (rempli uniquement si gestio = autre)|text| |
|proprio_a|Libellé de l'autre organisme d'entretien(rempli uniquement si proprio = autre)|text| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id_pan` l'attribution automatique est composé d'un numéro séquentiel préfixé par la lettre 'P'. 
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_codepan_fkey` (lien vers la liste de valeurs du type de panneau `lt_mob_pan_codepan`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_dbetat_fkey` (lien vers la liste de valeurs de l'état d'avancement du panneau `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_dbstatut_fkey` (lien vers la liste de valeurs le statut du panneau `lt_statut`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_etat_fkey` (lien vers la liste de valeurs de l'état du panneau `lt_mob_etat`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_srcgeom_fkey` (lien vers la liste de valeurs des sources de saisies géographiques `lt_src_geom`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_typpan_fkey` (lien vers la liste de valeurs du type de panneau `lt_mob_pan_typ`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_typsign_fkey` (lien vers la liste de valeurs du type de signalétique `lt_mob_pan_typsign`)

* 6 triggers :
  * `t_t1_100_log` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t1_dbinsert` : trigger permettant d'insérer la date de saisie
  * `t_t2_dbupdate` : trigger permettant d'insérer la date de mise à jour
  * `t_t3_xyl93` : trigger permettant de calculer les coordonnées avant enregistrement
  *  `t_t5_autorite` : trigger permettant de récupérer la valeur de l'EPCI du profil utulisateur
  *  `t_t6_controle` : trigger permettant de contrôler la saisie et d'automatiser certaines valeurs à l'enregistrement 

 ---

`[m_mobilite_douce].[geo_mob_repere]` : table géographique contenant la localisation des repères cyclables/randonnées
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id_rep|Identifiant unique interne|text|('RC'::text || nextval('m_mobilite_douce.geo_mob_repere_seq'::regclass))|
|libelle|Numéro, nom ou description utilisé comme désignation du point de repère|character varying(255)| |
|typ_rep|Type de repère|character varying(2)|'00'::character varying|
|typ_rep_a|Autre type de repère (si typ_rep = autre)|character varying(255)| |
|num_compt|N° du compteur (si typ_rep = compteur)|text| |
|url_compt|URL d'accès aux statistiques du compteur (lien externe) (si typ_rep = compteur)|text| |
|usa_rep|Usage principal du repère|character varying(2)|'00'::character varying|
|dbetat|Etat d'avancement (Niveau de réalisation) du repère|character varying(2)|'40'::character varying|
|dbstatut|Statut du repère|character varying(2)|'10'::character varying|
|gestio|Aménageur|text|'00'::text|
|observ|Commentaire(s)|character varying(1000)| |
|epci|EPCI d'assise du repère|character varying(5)| |
|insee|Code Insee  de la commune d'implantation du repère|character varying(5)| |
|commune|Commune d'implantation du repère|character varying(80)| |
|op_sai|Opérateur de saisie|character varying(50)| |
|op_maj|Opérateur de mise à jour|character varying(50)| |
|dbinsert|Date d'insertion dans la base de données|timestamp without time zone|now()|
|dbupdate|Date de mise à jour dans la base de données|timestamp without time zone| |
|x_l93|Coordonnées X en Lambert 93|numeric| |
|y_l93|Coordonnées Y en Lambert 93|numeric| |
|geom|Classe d'objets géométrique|point(2154)| |
|proprio|Organisme qui entretient|text|'00'::text|
|gestio_a|Libellé de l'autre aménageur (rempli uniquement si gestio = autre)|text| |
|proprio_a|Libellé de l'autre organisme d'entretien(rempli uniquement si proprio = autre)|text| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id_rep` l'attribution automatique composé d'un numéro séquentiel préfixé par la lettre 'R'
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_dbetat_fkey` (lien vers la liste de valeurs de l'état d'avancement du panneau `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_dbstatut_fkey` (lien vers la liste de valeurs le statut du panneau `lt_statut`)
* Une clé étrangère existe sur la table de valeur `lt_mob_rep_typrep_fkey` (lien vers la liste de valeurs du type de repère `lt_mob_rep_typr`)
* Une clé étrangère existe sur la table de valeur `lt_mob_rep_usarep_fkey` (lien vers la liste de valeurs de l'usage du repère `lt_mob_rep_usar`)

* 6 triggers :
  * `t_t1_100_log` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t1_dbinsert` : trigger permettant d'insérer la date de saisie
  * `t_t2_dbupdate` : trigger permettant d'insérer la date de mise à jour
  * `t_t3_xyl93` : trigger permettant de calculer les coordonnées avant enregistrement
  *  `t_t5_autorite` : trigger permettant de récupérer la valeur de l'EPCI du profil utulisateur
  *  `t_t6_controle` : trigger permettant de contrôler la saisie et d'automatiser certaines valeurs à l'enregistrement 

 ---

 `[m_mobilite_douce].[geo_mob_statio_cycl]` : table géographique contenant la localisation des stationnements cyclables
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id_statio|Identifiant unique interne|text|('SC'::text || nextval('m_mobilite_douce.geo_mob_statio_cycl_seq'::regclass))|
|id_adresse|Identifiant de l'adresse|bigint| |
|id_voie|Identifiant de la voie|bigint| |
|complt_adr|Complément d'adresse|character varying(500)| |
|dbetat|Niveau d'avancement de l'équipement|character varying(2)|'40'::character varying|
|dbstatut|Statut de l'équipement|character varying(2)|'10'::character varying|
|etat_mob|Etat physique de l'équipement|character varying(2)|'10'::character varying|
|cap|Nombre de places de stationnement disponibles sur l'emplacement y compris les places adaptées à des vélos spéciaux|smallint|0|
|cap_cargo|Nombre de places de stationnement disponibles pour les vélos de grande taille|smallint| |
|typ_accro|Mode d'accrochage possible du vélo aux équipements de stationnement|character varying(2)|'00'::character varying|
|mobil|Type de mobilier de stationnement|character varying(2)|'00'::character varying|
|mobil_p|Précision sur le type de mobilier de stationnement|character varying(50)| |
|acces|Mode d'accès à l'emplacement de stationnement|character varying(2)|'00'::character varying|
|gratuit|L'usage de l'équipement de stationnement est-il gratuit ?|character varying(2)|'00'::character varying|
|protect|Protection du stationnement|character varying(2)|'00'::character varying|
|couvert|Le stationnement est-il couvert et est donc protégé de la pluie, de la neige et de la grêle ?|character varying(1)|'00'::character varying|
|surv|Le stationnement est-il surveillé par un gardien ou par de la vidéosurveillance ?|character varying(1)|'00'::character varying|
|lum| L'emplacement est-il éclairé la nuit (par de l'éclairage urbain ou dédié à l'emplacement) ?|character varying(1)|'00'::character varying|
|url|Site web d'information|text| |
|an_pose|Année de mise en service du stationnement vélo|integer| |
|proprio|Nom de l'organisme qui entretient|text|'00'::character varying|
|gestio|Nom de l'aménageur|text|'00'::text|
|src_geom|Référentiel géographique de saisie|character varying(100)|'24'::character varying|
|src_annee|Année du référentiel de saisie|character varying(4)|'2021'::character varying|
|observ|Commentaire(s)|character varying(1000)| |
|epci|EPCI d'assise de l'équipement|character varying(5)| |
|insee|Code Insee  de la commune d'implantation de l'équipement|character varying(5)| |
|commune|Commune d'implantation de l'équipement|character varying(80)| |
|op_sai|Opérateur de saisie|character varying(50)| |
|op_maj|Opérateur de mise à jour|character varying(50)| |
|dbinsert|Date d'insertion dans la base de données|timestamp without time zone|now()|
|dbupdate|Date de mise à jour dans la base de données|timestamp without time zone| |
|x_l93|Coordonnées X en Lambert 93|numeric| |
|y_l93|Coordonnées Y en Lambert 93|numeric| |
|geom|Classe d'objets géométrique|point(2154)| |
|gestio_a|Libellé de l'autre aménageur (rempli uniquement si gestio = autre)|text| |
|proprio_a|Libellé de l'autre organisme d'entretien(rempli uniquement si proprio = autre)|text| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id_rep` l'attribution automatique composé d'un numéro séquentiel préfixé par la lettre 'R'
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_dbetat_fkey` (lien vers la liste de valeurs de l'état d'avancement du panneau `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_pan_dbstatut_fkey` (lien vers la liste de valeurs le statut du panneau `lt_statut`)
* Une clé étrangère existe sur la table de valeur `lt_mob_rep_typrep_fkey` (lien vers la liste de valeurs du type de repère `lt_mob_rep_typr`)
* Une clé étrangère existe sur la table de valeur `lt_mob_rep_usarep_fkey` (lien vers la liste de valeurs de l'usage du repère `lt_mob_rep_usar`)

* 6 triggers :
  * `t_t0_controle` : trigger permettant de contrôler la saisie et d'automatiser certaines valeurs à l'enregistrement 
  * `t_t1_100_log` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t1_dbinsert` : trigger permettant d'insérer la date de saisie
  * `t_t2_dbupdate` : trigger permettant d'insérer la date de mise à jour
  * `t_t3_xyl93` : trigger permettant de calculer les coordonnées avant enregistrement
  * `t_t4_inseecommune` : trigger permettant de récupérer la valeur du code insee et le nom de la commune d'assise du stationnement
  * `t_t5_autorite` : trigger permettant de récupérer la valeur de l'EPCI du profil utulisateur

 ---

  `[m_mobilite_douce].[geo_mob_troncon]` : table géographique contenant la localisation des aménagements cyclables
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id_tronc|Identifiant unique interne|text|('TC'::text || nextval('m_mobilite_douce.geo_mob_troncon_seq'::regclass))|
|typ_mob|Type de mobilité douce|character varying(2)|'10'::character varying|
|typ_res|Type de réseau structurant local auquel appartient l'aménagement|character varying(2)|'00'::character varying|
|acces_ame|Accessibilité des aménagements par type de véhicule à deux roues non motorisé (hiérarchisation, si ROLLER, les autres possibles)|character varying(2)|'00'::character varying|
|trafic_vit|Vitesse maximale autorisée pour le trafic adjacent à l'aménagement, en km/h. La vitesse 5 km/h correspond à une vitesse à l'allure du pas|integer| |
|lum|Présence d'éclairage|character varying(1)|'0'::character varying|
|dbstatut|Statut de l'aménagement|character varying(2)|'10'::character varying|
|posi_dg|Indique les informations à remplir selon que l'aménagement est à droite à gauche ou les deux|character varying(2)|'10'::character varying|
|ame_d|Type d'aménagement de droite|character varying(2)| |
|dbetat_d|Etat d'avancement (Niveau de réalisation) de l'aménagement de droite|character varying(2)|'00'::character varying|
|an_prog_d|Année de programmation de l'aménagement de droite|integer| |
|d_service_d|Année de mise en service de l'aménagement de droite|integer| |
|regime_d|Régime présent sur la voie de droite|character varying(2)|'00'::character varying|
|sens_d|Sens de circulation de l'aménagement de droite|character varying(2)|'00'::character varying|
|largeur_d|Largeur de l'aménagement de droite (en mètre)|double precision| |
|local_d|Localisation de l'aménagement de droite|character varying(2)|'00'::character varying|
|revet_d|Niveau de qualité du revêtement de l'aménagement de droite qualifié par rapport à la pratique du vélo|character varying(2)|'00'::character varying|
|lin_d|Linéaire en mètre du tronçon de droite|integer| |
|cout_d|Coût en euro HT de l'aménagement de droite (attribut plus utilisé et masqué dans l'application)|integer| |
|subv_d|Subvention reçu en euro HT de l'aménagement de droite (attribut plus utilisé et masqué dans l'application)|integer| |
|com_g|Information sur le fait que la commune de gauche soit la même que la commune de droite|boolean|true|
|mame_g|Information sur le fait que l'aménagement de gauche soit la même que l'aménagement de droite|boolean|true|
|ame_g|Type d'aménagement de gauche|character varying(2)| |
|dbetat_g|Etat d'avancement (Niveau de réalisation) de l'aménagement de gauche|character varying(2)|'00'::character varying|
|an_prog_g|Année de programmation de l'aménagement de gauche|integer| |
|d_service_g|Année de mise en service de l'aménagement de gauche|integer| |
|regime_g|Régime présent sur la voie de gauche|character varying(2)|'00'::character varying|
|sens_g|Sens de circulation de l'aménagement de gauche|character varying(2)|'00'::character varying|
|largeur_g|Largeur de l'aménagement de gauche (en mètre)|double precision| |
|local_g|Localisation de l'aménagement de gauche|character varying(2)|'00'::character varying|
|revet_g|Niveau de qualité du revêtement de l'aménagement de gauche qualifié par rapport à la pratique du vélo|character varying(2)|'00'::character varying|
|lin_g|Linéaire en mètre du tronçon de gauche|integer| |
|cout_g|Coût en euro HT de l'aménagement de gauche (attribut plus utilisé et masqué dans l'application)|integer| |
|subv_g|Subvention reçu en euro HT de l'aménagement de gauche (attribut plus utilisé et masqué dans l'application)|integer| |
|proprio_d|Nom de l'organisation qui entretient l'aménagement de droite|text|'00'::character varying|
|gestio_d|Nom de l'aménageur de l'aménagement de droite|text|'00'::text|
|proprio_g|Nom de l'organisation qui entretient l'aménagement de gauche|text|'00'::character varying|
|gestio_g|Nom de l'aménageur de l'aménagement de gauche|text|'00'::text|
|conv_d|Tronçon de l'aménagement de droite sous convention de gestion|character varying(1)|'f'::character varying|
|conv_g|Tronçon de l'aménagement de gauche sous convention de gestion|character varying(1)|'f'::character varying|
|src_geom|Code du référentiel géographique utilisé pour la saisie|character varying(2)|'24'::character varying|
|src_annee|Année du référentiel géographique|character varying(4)|'2021'::character varying|
|observ|Commentaires divers|character varying(1000)| |
|op_sai|Opérateur de la saisie de la donnée|character varying(50)| |
|op_maj|Opérateur de la dernière mise à jour de la donnée|character varying(50)| |
|dbinsert|date de saisie de la donnée|timestamp without time zone|now()|
|dbupdate|date de mise à jour de la donnée|timestamp without time zone| |
|insee_d|Libellé de la commune de l'aménagement de droite|character varying(5)| |
|commune_d|Libellé de la commune de l'aménagement de droite|character varying(80)| |
|epci_d|EPCI d'assise de l'aménagement de droite|character varying(5)| |
|insee_g|Libellé de la commune de l'aménagement de gauche|character varying(5)| |
|commune_g|Libellé de la commune de l'aménagement de gauche|character varying(80)| |
|epci_g|EPCI d'assise de l'aménagement de gauche|character varying(5)| |
|epci|EPCI de saisie de l'aménagement|character varying(5)| |
|geom|Géométrie des objets saisis|multilinestring(2154)| |
|requal_g|Attribut permettant de de signaler une requalification de l'aménagement de gauche existant|boolean|false|
|requal_d|Attribut permettant de de signaler une requalification de l'aménagement de droite existant|boolean|false|
|reqame_g|Nouvel aménagement projeté à gauche après requalification|character varying(2)|'ZZ'::character varying|
|reqame_d|Nouvel aménagement projeté à droite après requalification|character varying(2)|'ZZ'::character varying|
|reqam_dbetat_g|Etat d'avancement du nouvel aménagement projeté à gauche après requalification|character varying(2)|'ZZ'::character varying|
|reqam_dbetat_d|Etat d'avancement du nouvel aménagement projeté à gauche après requalification|character varying(70)|'ZZ'::character varying|
|gestio_a_d|Libellé de l'autre aménageur à droite (rempli uniquement si gestio = autre)|text| |
|gestio_a_g|Libellé de l'autre aménageur à gauche (rempli uniquement si gestio = autre)|text| |
|proprio_a_d|Libellé de l'autre organisme d'entretien à droite (rempli uniquement si proprio = autre)|text| |
|proprio_a_g|Libellé de l'autre organisme d'entretien à gauche (rempli uniquement si proprio = autre)|text| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id_tronc` l'attribution automatique composé d'un numéro séquentiel préfixé par la lettre 'TC'
* Une clé étrangère existe sur la table de valeur `lt_etat_avancement_dbetat_d_requal_fkey` (lien vers la liste de valeurs de l'état d'avancement de la requalification du tronçon de droite `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_etat_avancement_dbetat_g_requal_fkey` (lien vers la liste de valeurs de l'état d'avancement de la requalification du tronçon de gauche `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_acces_fkey` (lien vers la liste de valeurs du type d'accéssibilité `lt_mob_tronc_acces`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_ame_d_fkey` (lien vers la liste de valeurs du type d'aménagement du tronçon de droite `lt_mob_tronc_ame`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_ame_d_requal_fkey` (lien vers la liste de valeurs de l'aménagement en requalification du tronçon de droite `lt_mob_tronc_ame`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_ame_g_fkey` (lien vers la liste de valeurs du type d'aménagement du tronçon de gauche `lt_mob_tronc_ame`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_ame_g_requal_fkey` (lien vers la liste de valeurs de l'aménagement en requalification du tronçon de gauche `lt_mob_tronc_ame`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_conv_d_fkey` (lien vers la liste de valeurs booléen de l'aménagement de droite sous convention de gestion`lt_booleen`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_conv_g_fkey` (lien vers la liste de valeurs booléen de l'aménagement de gauche sous convention de gestion`lt_booleen`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_dbetat_d_fkey` (lien vers la liste de valeurs de l'état d'avancement de l'aménagement de droite `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_dbetat_g_fkey` (lien vers la liste de valeurs de l'état d'avancement de l'aménagement de gauche `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_dbstatut_fkey` (lien vers la liste de valeurs du statut du tronçon `lt_statut`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_local_d_fkey` (lien vers la liste de valeurs de la localisation du tronçon de droite `lt_mob_tronc_local`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_local_g_fkey` (lien vers la liste de valeurs de la localisation du tronçon de gauche `lt_mob_tronc_local`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_lum_fkey` (lien vers la liste de valeurs booléen sur la présence de lumière sur le tronçon `lt_booleen`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_posi_dg_fkey` (lien vers la liste de valeurs de la position de l'aménagement (à droite, à gauche ou les deux) `lt_mob_tronc_posi`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_regime_d_fkey` (lien vers la liste de valeurs du regime de circulation du tronçon de droite `lt_mob_tronc_regime`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_regime_g_fkey` (lien vers la liste de valeurs du regime de circulation du tronçon de gauche `lt_mob_tronc_regime`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_res_fkey` (lien vers la liste de valeurs dy type de réseau cyclable `lt_mob_tronc_res`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_revet_d_fkey` (lien vers la liste de valeurs du type de revêtement du tronçon de droite `lt_mob_tronc_revet`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_revet_g_fkey` (lien vers la liste de valeurs du type de revêtement du tronçon de gauche `lt_mob_tronc_revet`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_sens_d_fkey` (lien vers la liste de valeurs du sens de circulation du tronçon de droite `lt_mob_tronc_sens`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_sens_g_fkey` (lien vers la liste de valeurs du sens de circulation du tronçon de gauche `lt_mob_tronc_sens`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_src_geom_fkey` (lien vers la liste de valeurs de la source du référentiel géographique de saisie `lt_src_geom`)
* Une clé étrangère existe sur la table de valeur `lt_mob_tronc_typ_fkey` (lien vers la liste de valeurs du type de tronçon (cyclable ou randonnée) `lt_mob_tronc_typ`)  

* 6 triggers :
  * `t_t0_controle` : trigger permettant de contrôler la saisie et d'automatiser certaines valeurs à l'enregistrement 
  * `t_t1_100_log` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t10_after_decoupe` : trigger permettant de gérer la découpe 
  * `t_t1_dbinsert` : trigger permettant d'insérer la date de saisie
  * `t_t2_dbupdate` : trigger permettant d'insérer la date de mise à jour
  * `t_t5_autorite` : trigger permettant de récupérer la valeur de l'EPCI du profil utulisateur
  * `t_t7_majpan_rep` : trigger permettant de gérer les associations des panneaux et repères aux tronçons
  * `t_t8_refresh_iti` : trigger permettant de rafraîchir les itinéraires après modification

 ---

### Classes d'objets attributaire :

`[m_mobilite_douce].[an_mob_iti_cycl]` : table alphanumérique contenant les itinéraires cyclables
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id_iticycl|Identifiant unique interne|text|uuid_generate_v4()|
|numero|Numérotation de l'itinéraire|character varying(20)| |
|nomoff|Nom officiel de l'itinéraire, à défaut celui présent sur les document de communication|character varying(255)| |
|nomusage|Autre nom ou appellation de l’itinéraire en usage|character varying(255)| |
|depart|Nom de la localité située au départ de l'itinéraire|character varying(255)| |
|arrivee|Nom de la localité située à l’arrivée de l'itinéraire|character varying(255)| |
|dbetat|Etat d'avancement (Niveau d'avancement) de l'itinéraire|character varying(2)|'40'::character varying|
|dbstatut|Statut de l'itinéraire|character varying(2)|'10'::character varying|
|usa_iti|Usage principale de l'itinéraire|character varying(2)|'00'::character varying|
|lieu_d|Principaux lieux desservis|text| |
|instruc|Description détaillée (pas à pas) du tracé de l'itinéraire|text| |
|url|Référence du site internet faisant la promotion de l'itinéraire|character varying(255)| |
|d_prog|Année de programmation de l'itinéraire|integer| |
|d_service|Année d'ouverture de l'itinéraire|integer| |
|p_long|Longueur prévisionnel|integer| |
|p_ame|Aménagement prévisionnel|text|'00'::text|
|p_mao|MAO du projet|text|'00'::text|
|p_coutm|Coût estimatif au mètre linéaire|integer| |
|p_cout|Coût total du projet|integer| |
|gestio|Nom de l'aménageur|text|'00'::text|
|itivar|Variante d'un itinéraire maître|boolean|false|
|id_itivar|Identifiant de l'itinéraire maître|text| |
|n_itivar|Libellé de la variante|character varying(255)| |
|observ|Commentaire(s)|character varying(1000)| |
|epci|EPCI d'assise de l'itinértaire|text| |
|maj_geom|Attribut volatile permettant d'activer ou non la mise à jour de la géométrie dans la partie GdPublic|boolean|false|
|maj_att|Attribut volatile permettant d'activer ou non la mise à jour des modifications attributaires dans la partie GdPublic|boolean|false|
|sup_gdpublic|Attribut volatile permettant de supprimer un itinéraire dans la partie GdPublic|boolean|false|
|op_sai|Opérateur de saisie|character varying(50)| |
|op_maj|Opérateur de mise à jour|character varying(50)| |
|dbinsert|Date d'insertion dans la base de données|timestamp without time zone|now()|
|dbupdate|Date de mise à jour dans la base de données|timestamp without time zone| |
|proprio|Organisme quii entretient l'itinéraire|text|'00'::text|
|p_subv|Subvention totale reçue pour l'itinéraire|integer| |
|gestio_a|Libellé de l'autre aménageur (rempli uniquement si gestio = autre)|text| |
|proprio_a|Libellé de l'autre organisme d'entretien(rempli uniquement si proprio = autre)|text| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `id_iticycl` l'attribution automatique de la référence par un identifiant de type UUID V4. 
* Une clé étrangère existe sur la table de valeur `lt_mob_iti_dbetat_fkey`  (lien vers la liste de valeurs de l'état d'avancement de l'itinéraire `lt_etat_avancement`)
* Une clé étrangère existe sur la table de valeur `lt_mob_iti_dbstatut_fkey` (lien vers la liste de valeurs du statut de l'itinéraire `lt_statut`)
* Une clé étrangère existe sur la table de valeur `lt_mob_iti_usage_fkey` (lien vers la liste de valeurs de l'usage de l'usage `lt_mob_iti_usage`)

* 6 triggers :
  * `t_t0_controle` : trigger permettant de contrôler la saisie utilisateur et l'enregistrement de certaines valeurs
  * `t_t1_100_log` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t1_dbinsert` : trigger permettant d'insérer la date de saisie
  * `t_t2_dbupdate` : trigger permettant d'insérer la date de mise à jour
  * `t_t5_autorite` : trigger permettant de récupérer la valeur de l'EPCI du profil utulisateur
  * `t_t8_refresh_iti` : trigger permettant de rafraîchir les itinéraires après modification
  * `t_t91_planvelo` : trigger permettant de récupérer 
  * `t_t9_droit_delegue` : trigger permettant de récupérer l'EPCI d'appartenance de l'utilisateur pour insertion dans les données afin de gérer les droits et l'étanchéïté des données 
---

#### Liste de valeurs

`[m_spanc].[lt_spanc_confor]` : Liste de valeurs des conformités du contrôle

|Nom attribut | Définition |
|:---|:---|
|code|Code des conformités du contrôle|character varying(2)| |
|valeur|Valeur des conformités du conclusion du contrôle|text| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné (non attribuée)|
|10|Conforme|
|20|Non conforme|
|30|Absence d'installation|
|ZZ|Non concerné (refus du contrôle)|

---



### Classes d'objets attributaire gérant les associations (ou relation d'appartenance des objets entre eux) :

`[m_spanc].[lk_spanc_contact]` : table alphanumérique de relation entre les installations et les contacts
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|Identifiant interne non signifiant|bigint|nextval('lk_spanc_contact_seq'::regclass)|
|idinstal|Identifiant de l'installation|bigint| |
|idcontact|Identifiant interne du contact|bigint| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ `id` l'attribution automatique de la référence unique s'effectue via une séquence. 

* 1 triggers :
  * `t_t1_100` : trigger permettant d'insérer toutes les modifications dans la table des logs
 
---

### classes d'objets applicatives métiers (vue) :

  * xapps_an_v_spanc_dernier_etat_equi : Vue applicative formattant l'affichage des derniers contrôles à l'installation (soit le diag initial ou la demande de travaux et le dernier contrôle)
  * xapps_geo_an_spanc_contr_export : Vue applicative générant les exports des contrôles
  * xapps_geo_an_spanc_install_export : Vue applicative générant les exports des installations
  * xapps_geo_v_spanc_rpqs_tab1 : Vue applicative ressortant les indicateurs RPQS pour le tableau de bord n°1 du SPANC
  * xapps_geo_v_spanc_tab2 : Vue applicative ressortant les indicateurs des types de contrôles par année par commune et  pour l'EPCI
  * xapps_geo_v_spanc_tab3 : Vue applicative ressortant le nombre total de contrôles par année et par epci
  * xapps_geo_v_spanc_tab4 : Vue applicative ressortant le montant de la redevance et des pénalités
  * xapps_geo_v_spanc_tab5 : Vue applicative ressortant les chiffres clés du SPANC
  * xapps_geo_v_spanc_tri_contr : Vue applicative pour palier au bug de GEO2.2 pour l'affichage des contrôles triés par date dans la fiche de l'installation
  * xapps_an_vmr_spanc_conception : Vue matérialisée applicative gérant la recherche des installations en conception rafraichie à chaque insertion ou modification d'un contrôle (par défaut rafraichie toutes les nuits)
  * xapps_an_vmr_spanc_conformite : Vue matérialisée applicative gérant la recherche des installations selon leur conformité rafraichie à chaque insertion ou modification d'un contrôle (par défaut rafraichie toutes les nuits)
  * xapps_geo_vmr_spanc_periodicite : Vue matérialisée applicative calculant les dates des prochains contrôles à partir des derniers contrôles en fonction de leur nature et de leur conclusion de chaque installation active (rafraichie après chaque insertion ou mise à jour d'un contrôle)
  * xapps_geo_vmr_spanc_anc : Vue matérialiséVue matérialisée applicative gérant la recherche des installations selon leur conformité rafraichie à chaque insertion ou modification d'un contrôlee applicative générant la récupération des adresses et les informations liées aux installations pour l'affichage cartographique et le fonctionnel au clic dans l'application (par défaut rafraichie toutes les nuits)
  * xapps_geo_vmr_spanc_anc : Vue matérialisée rafraichie applicative récupérant le nombre de dossier SPANC de conformité par adresse et affichant l'état du dernier contrôle (conforme ou non conforme) pour affichage dans GEO
 
### classes d'objets applicatives grands publics:

Sans objet

### classes d'objets opendata sont classés :

Sans objet

## Projet QGIS pour la gestion

Sans objet

## Traitement automatisé mis en place (Workflow de l'ETL FME)

Sans objet

## Export Open Data

Sans objet

---

