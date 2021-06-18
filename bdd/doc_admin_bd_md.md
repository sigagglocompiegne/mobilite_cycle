![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base de données des mobilités douces #

## Généralité
 

## Principe de la modélisation des classes d'objets

![picto](.png)

## Modèle relationnel simplifié

![picto](.png)

## Schéma fonctionnel

(à venir)


## Dépendances

La base de données des aménagements cyclables s'appuie sur d'anciennes données préexistantes mise en place avec le standard *3V*. Suite au nouveau standard des *Aménagements cyclables* mis en place par Etalab, Il a fallu migrer les anciennes données en essayant de perdre le moins d'information possible pour ensuite pouvoir enrichir celles-ci et les transférer vers le PAN (Point d'Accès National).

|schéma | table | description | usage |
|:---|:---|:---|:---|   

---

## Classes d'objets

L'ensemble des classes d'objets unitaires sont stockées dans le schéma m_moblite_3v, celles dérivées et applicatives dans le schéma `x_apps`, celles dérivées pour les exports opendata dans le schéma `x_opendata`.

### Classe d'objet géographique et patrimoniale

`[an_mob_itineraire]` : table alphanumérique des métadonnées des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|iditi|Identifiant unique (clé primaire) de l itinéraire|text| |
|num_iti|Numéro de l itinéraire des schémas supra-intercommunaux|character varying(10)| |
|num_loc|Numéro de l itinéraire local|character varying(10)| |
|nom_off|Nom officiel ou à défaut celui mentionné dans un document de communication grand public|character varying(100)| |
|nom_usage|Autre nom ou appellation de l itinéraire en usage|character varying(100)| |
|depart|Nom de la localité située au départ|character varying(80)| |
|via|Localité ou lieu intermédiaire entre le départ et l arrivée de l itinéraire|character varying(254)| |
|arrivee|Nom de la localité située à l arrivée|character varying(80)| |
|est_inscri|Précise si l itinéraire est inscrit à un schéma de développement des véloroutes|character varying(2)| |
|niv_inscri|Niveau administratif du schéma dans lequel l itinéraire est inscrit et numéroté|character varying(2)| |
|nom_schema|Libellé du schéma d inscription|character varying(100)| |
|an_inscri|Année d approbation du schéma dans lequel l itinéraire est inscrit et numéroté|character varying(4)| |
|an_ouvert|Indique l année d ouverture de l itinéraire|character varying(4)| |
|gest_iti|Gestion sur l itinéraire en terme d action sur les données|character varying(2)| |
|usag|Usage principal de l itinéraire|character varying(2)| |
|usage_comm|diffusion des données au grand public|boolean|false|
|voca_iti|Vocation de l itinéraire|character varying(10)| |
|typ_iti|Typologie des aménagements cyclables prévus dans le cadre d un projet d itinéraires en projet|character varying(40)| |
|mao|Maître d ouvrage de l itinéraire en projet ou en cours de travaux|character varying(100)| |
|equip|Liste d équipements potentiellement proche ou desservis par l itinéraire|character varying(5000)| |
|descrip|Description de l itinéraire (parcours, …)|character varying(5000)| |
|cout|Estimation du coût au mètre linéaire de l aménagement de l itinéraire|character varying(10)| |
|esti|Estimation en euros de l aménagement de l itinéraire|character varying(10)| |
|url_site|Lien Http vers une page web|character varying(254)| |
|observ|Commentaires|character varying(1000)| |
|op_sai|Opérateur de saisie|character varying(20)| |
|date_sai|Date de saisie de la donnée|timestamp without time zone| |
|date_maj|Date de mise à jour de la donnée|timestamp without time zone| |

* triggers : *date_sai* et *date_maj*
<br/>
<br/>

`[geo_mob_troncon]` : table géométrique .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idtroncon|Identifiant unique (clé primaire) du tronçon|text| |
|id_osm|Identifiant unique du tronçon sur OpenStreetMap|character varying(30)| |
|id_on3v|Identifiant unique du tronçon sur le standard 3V|character varying(30)| |
|typ_res|Type de réseau local|character varying(2)| |
|gest|Gestionnaire de l infrastructure|character varying(2)| |
|propriete|Propriétaire de l infrastructure|character varying(2)| |
|d_service|Année de mise en service|character varying(4)| |
|trafic_vit|Vitesse maximale du trafic adjacent|character varying(2)| |
|lumiere|Présence d éclairage|character varying(1)| |
|code_com_g|Code insee de la commune à gauche de l aménagement|character varying(5)| |
|commune_g|Libellé de la commune à gauche de l aménagement|character varying(80)| |
|ame_g|Type d aménagement de gauche|character varying(2)| |
|avanc_g|Niveau d avancement en terme de projet à gauche|character varying(2)| |
|regime_g|Régime présent sur la voie de gauche|character varying(2)| |
|sens_g|Sens de circulation de l aménagement de gauche|character varying(2)| |
|largeur_g|Largeur en mètre de l aménagement de gauche|character varying(2)| |
|local_g|Localisation de l aménagement de gauche|character varying(2)| |
|revet_g|Type de revêtement du tronçon de gauche|character varying(2)| |
|code_com_d|Code insee de la commune à droite de l aménagement|character varying(5)| |
|commune_d|Libellé de la commune à droite de l aménagement|character varying(80)| |
|ame_d|Type d aménagement de droite|character varying(2)| |
|avanc_d|Niveau d avancement en terme de projet à droite|character varying(2)| |
|regime_d|Régime présent sur la voie de droite|character varying(2)| |
|sens_d|Sens de circulation de l aménagement de droite|character varying(2)| |
|largeur_d|Largeur en mètre de l aménagement de droite|character varying(2)| |
|local_d|Localisation de l aménagement de droite|character varying(2)| |
|revet_d|Type de revêtement du tronçon de droite|character varying(2)| |
|long_m|Longueur en mètre du tronçon|integer| |
|src_geom|Référentiel utilisé pour la digitalisation de la géométrie|character varying(2)| |
|observ|Commentaires|character varying(1000)| |
|verif|attribut spécifiant que l utilisaetur a vérifier l exactitude du tronçon|boolean|false|
|op_sai|Opérateur de saisie|character varying(20)| |
|date_sai|Date de saisie de la donnée|timestamp without time zone| |
|date_maj|Date de mise à jour de la donnée|timestamp without time zone| |
|geom|Géométrie de l objet|USER-DEFINED| |

* triggers : *commune_g*, *commune_d*, *long_m*, *date_sai* et *date_maj*
<br/>
<br/>

`[geo_mob_carrefour]` : table géométrique .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idcarrefour|Identifiant unique (clé primaire) du tronçon|text| |
|libelle|Libellé du carrefour|character varying(255)| |
|typ_car|Type de carrefour|character varying(2)| |
|avanc|Niveau d avancement en terme de projet|character varying(2)| |
|insee|Code insee de la commune d implantation|character varying(5)| |
|commune|Nom de la commune d implantation|character varying(80)| |
|observ|Commentaires|character varying(1000)| |
|op_sai|Opérateur de saisie|character varying(20)| |
|date_sai|Date de saisie de la donnée|timestamp without time zone| |
|date_maj|Date de mise à jour de la donnée|timestamp without time zone| |
|geom|Géométrie de l objet|USER-DEFINED| |

* triggers : *date_sai* et *date_maj*
<br/>
<br/>

`[lk_mob_ititroncon]` : table de relation .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|gid|Identifiant unique (clé primaire) de la relation|bigint| |
|idtroncon|Identifiant unique du tronçon|text| |
|iditi|Identifiant unique de litinéraire|text| |

* triggers : aucun
<br/>
<br/>

`[an_mob_media]` : table alpanumérique .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---| 
|qid|Identifiant uniqueue (clé primaire) du média|bigint| |
|gid|Identifiant de l objet référence|text| |
|media|Champ Média de GEO|text| |
|miniature|Champ miniature de GEO|bytea| |
|n_fichier|Nom du fichier|text| |
|t_fichier|Type de média dans GEO|text| |
|l_prec|Précision sur le document|character varying(1000)| |
|op_sai|Opérateur de saisie|character varying(20)| |
|date_sai|Date de saisie|timestamp without time zone| |

* triggers : aucun



## Liste de valeurs

`[lt_mob_ame]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|10|Non aménagé|
|11|Non aménagé (jalonnement)|
|20|Piste cyclable|
|30|Bande cyclable|
|41|Double sens cyclable piste|
|42|Double sens cyclable bande|
|43|Double sens cyclable non matérialisé|
|50|Voie verte|
|60|Vélo rue|
|61|Couloir Bus+Vélo|
|62|Rampe|
|63|Goulotte|
|64|Aménagement mixte piéton-vélo (hors voie verte)|
|70|Chaussée à voie centrale banalisée|
|71|Accotement revêtu hors CVCB|
|99|Autre|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_avanc]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|00|Non renseigné|
|10|Esquisse|
|20|Avant-projet|
|30|Provisoire|
|40|En travaux|
|50|En service|
|60|Supprimé|
|70|Abandonné|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_booleen]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|0|Non renseigné|
|f|Non|
|t|Oui|
|z|Non concerné|
<br/>
<br/>

`[lt_mob_carrefour]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|00|Non renseigné|
|10|SAS vélo|
|20|Traversée|
|30|Feux aménagés|
<br/>
<br/>

`[lt_mob_etat_inscri]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|00|Non renseigné|
|10|Ne sais pas (inconnu)|
|20|Non|
|30|Oui|
<br/>
<br/>

`[lt_mob_gest]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|00|Non renseigné|
|10|État|
|20|Région|
|30|Département|
|40|Intercommunalité|
|50|Commune|
|60|Privé|
<br/>
<br/>

`[lt_mob_gest_iti]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|10|ARC|
|20|CCPE|
|30|CCLO|
<br/>
<br/>

`[lt_mob_local]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|00|Non renseigné|
|10|Trottoir|
|20|Intermédiaire|
|30|Chaussée|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_niv_inscri]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|  
|00|Non renseigné|
|10|Européen|
|20|National|
|30|Régional|
|40|Départemental|
|50|Intercommunal|
|60|Communal|
|70|Infracommunal|
<br/>
<br/>

`[lt_mob_regime]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---| 
|00|Non renseigné|
|10|Zone 30|
|20|Aire piétonne|
|30|Zone de rencontre|
|40|En agglomération|
|50|Hors agglomération
|60|Autre|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_revet]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|
|00|Non renseigné|
|10|Lisse|
|11|....|
|20|Meuble|
|21|....|
|30|Rugueux|
|31|....|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_sens]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    

|Code | Valeur |
|:---|:---|
|00|Non renseigné|
|10|Unidirectionnel|
|20|Bidirectionnel|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_typres]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|   

|Code | Valeur |
|:---|:---|
|00|Non renseigné|
|10|REV|
|20|STRUCTURANT|
|30|AUTRE|
<br/>
<br/>

`[lt_mob_usage]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|   

|Code | Valeur |
|:---|:---|
|10|Cyclable|
|20|Piéton|
<br/>
<br/>

`[lt_mob_vitesse]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|   

|Code | Valeur |
|:---|:---|
|00|Non renseigné|
|10|10|
|11|15|
|20|20|
|21|25|
|30|30|
|40|40|
|50|50|
|60|60|
|70|70|
|80|80|
|90|90|
|ZZ|Non concerné|
<br/>
<br/>

`[lt_mob_voca_iti]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|   

|Code | Valeur |
|:---|:---|
|00|Non renseigné|
|10|Loisirs|
|20|Utilitaire|
<br/>
<br/>




























---


### classes d'objets applicatives de gestion :

`[libellé]` : vue de gestion permettant la saisie des objets 

* Fonction triggers : sans objet


---

### classes d'objets applicatives métiers sont classés dans le schéma x_apps :
 
Sans objet

---


### classes d'objets applicatives grands publics sont classés dans le schéma x_apps_public :

Sans objet

---

### classes d'objets opendata sont classés dans le schéma x_opendata :

Sans objet

---

## Log

(à traiter)

## Erreur

Sans objet

---

## Projet QGIS pour la gestion

Sans objet (uniquement un projet QGis pour le gabarit de mise à jour de l'inventaire cartographique [rubrique Gabarit du standard](https://github.com/sigagglocompiegne/espace_vert/blob/master/gabarit/livrables.md)

---

## Traitement automatisé mis en place (Workflow de l'ETL FME)

Sans objet

---

## Export Grand Public

Sans objet

---

## Export Open Data

Sans objet






