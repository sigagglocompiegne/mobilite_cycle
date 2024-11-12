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

![md_schema](md_schema_fonctionnel.png)

## Modèle relationel simplifié


![md_mcd](md_mcd.png)

## Dépendances

Cette base de donnnées n'a pas de dépendances.


## Classes d'objets des mobilités douces

L'ensemble des classes d'objets de gestion sont stockés dans le schéma `m_mobilite_douce`.

### Classes d'objets géographique :

`[m_spanc].[an_spanc_installation]` : table alphanumérique contenant les attributs métiers de l'installation
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idinstal|Identifiant interne non signifiant|bigint|nextval('m_spanc.an_spanc_installation_id_seq'::regclass)|
|idadresse|Identifiant de base adresse locale du Grand Compiégnois|bigint| |
|adcompl|Complément d'adresse|text| |
|typ_im|Type d'immeuble concerné|character varying(2)| |
|nb_piece|Nombre de pièces principales|integer| |
|inst_eh|Equivalent habitant de l'installation|character varying(2)|'00'::character varying|
|inst_com|Installation commune à plusieurs immeubles|boolean|false|
|inst_acontr|Installation soumis à un contrôle|boolean|true|
|inst_conv|Installation soumis à une convention|boolean|false|
|date_crea|Date de création de l'installation|timestamp without time zone| |
|inst_age|Age de l'installation sans connaître la date de création|integer| |
|inst_etat|Etat de l'installation|character varying(2)|'10'::character varying|
|cad_sect|Section cadastrale|character varying(2)| |
|cad_par|Parcelle cadastrale|character varying(4)| |
|observ|Commentaires divers|character varying(5000)| |
|date_sai|Date de saisie des informations d'installation|timestamp without time zone| |
|date_maj|Date de mise à jour des informations d'installation|timestamp without time zone| |
|op_sai|Opérateur ayant saisi l'information d'installation|character varying(20)| |
|op_maj|Opérateur ayant modifier les informations d'installation|character varying(20)| |
|epci|Acronyme de l'EPCI d'assise de l'installation|text| |
|geom1|Géométrie du point d'adresse récupéré à la saisie pour la fonctionnalité d'association d'adresse à une installation pour la sélection via l'objet courant dans GEO et affichage des adresses dans un rayon de 50m|Geometry(point,2154)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `idinstal` l'attribution automatique de la référence unique s'effectue via une séquence. 
* Une clé étrangère existe sur la table de valeur `an_spanc_installation_eh_fkey` (lien vers la liste de valeurs du type d'installation `lt_spanc_eh`)
* Une clé étrangère existe sur la table de valeur `an_spanc_installation_inst_etat_fkey` (lien vers la liste de valeurs de l'état de l'installation `lt_spanc_etatinstall`)
* Une clé étrangère existe sur la table de valeur `an_spanc_installation_typim_fkey` (lien vers la liste de valeurs du type d'immeuble `lt_spanc_typim`)

* 6 triggers :
  * `t_t1_100` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t1_an_spanc_installation_date_sai` : trigger permettant d'insérer la date de saisie
  * `t_t2_an_spanc_installation_date_maj` : trigger permettant d'insérer la date de mise à jour
  * `t_t3_an_spanc_installation_controle_saisie` : trigger permettant de gérer les contrôles de saisie et les insertions de certains attributs particulier à l'insertion
  *  `t_t8_refresh_carto` : trigger permettant de rafraichir la vue matérialisée `m_spanc.xapps_geo_vmr_spanc_anc`
  *  `t_t9_autorite_competente` : trigger permettant de récupérer l'EPCI d'appartenance de l'utilisateur pour insertion dans les données afin de gérer les droits et l'étanchéïté des données 
 

### Classes d'objets attributaire :

`[m_spanc].[an_spanc_installation]` : table alphanumérique contenant les attributs métiers de l'installation
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idinstal|Identifiant interne non signifiant|bigint|nextval('m_spanc.an_spanc_installation_id_seq'::regclass)|
|idadresse|Identifiant de base adresse locale du Grand Compiégnois|bigint| |
|adcompl|Complément d'adresse|text| |
|typ_im|Type d'immeuble concerné|character varying(2)| |
|nb_piece|Nombre de pièces principales|integer| |
|inst_eh|Equivalent habitant de l'installation|character varying(2)|'00'::character varying|
|inst_com|Installation commune à plusieurs immeubles|boolean|false|
|inst_acontr|Installation soumis à un contrôle|boolean|true|
|inst_conv|Installation soumis à une convention|boolean|false|
|date_crea|Date de création de l'installation|timestamp without time zone| |
|inst_age|Age de l'installation sans connaître la date de création|integer| |
|inst_etat|Etat de l'installation|character varying(2)|'10'::character varying|
|cad_sect|Section cadastrale|character varying(2)| |
|cad_par|Parcelle cadastrale|character varying(4)| |
|observ|Commentaires divers|character varying(5000)| |
|date_sai|Date de saisie des informations d'installation|timestamp without time zone| |
|date_maj|Date de mise à jour des informations d'installation|timestamp without time zone| |
|op_sai|Opérateur ayant saisi l'information d'installation|character varying(20)| |
|op_maj|Opérateur ayant modifier les informations d'installation|character varying(20)| |
|epci|Acronyme de l'EPCI d'assise de l'installation|text| |
|geom1|Géométrie du point d'adresse récupéré à la saisie pour la fonctionnalité d'association d'adresse à une installation pour la sélection via l'objet courant dans GEO et affichage des adresses dans un rayon de 50m|Geometry(point,2154)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ `idinstal` l'attribution automatique de la référence unique s'effectue via une séquence. 
* Une clé étrangère existe sur la table de valeur `an_spanc_installation_eh_fkey` (lien vers la liste de valeurs du type d'installation `lt_spanc_eh`)
* Une clé étrangère existe sur la table de valeur `an_spanc_installation_inst_etat_fkey` (lien vers la liste de valeurs de l'état de l'installation `lt_spanc_etatinstall`)
* Une clé étrangère existe sur la table de valeur `an_spanc_installation_typim_fkey` (lien vers la liste de valeurs du type d'immeuble `lt_spanc_typim`)

* 6 triggers :
  * `t_t1_100` : trigger permettant d'insérer toutes les modifications dans la table des logs
  * `t_t1_an_spanc_installation_date_sai` : trigger permettant d'insérer la date de saisie
  * `t_t2_an_spanc_installation_date_maj` : trigger permettant d'insérer la date de mise à jour
  * `t_t3_an_spanc_installation_controle_saisie` : trigger permettant de gérer les contrôles de saisie et les insertions de certains attributs particulier à l'insertion
  *  `t_t8_refresh_carto` : trigger permettant de rafraichir la vue matérialisée `m_spanc.xapps_geo_vmr_spanc_anc`
  *  `t_t9_autorite_competente` : trigger permettant de récupérer l'EPCI d'appartenance de l'utilisateur pour insertion dans les données afin de gérer les droits et l'étanchéïté des données 
 
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

