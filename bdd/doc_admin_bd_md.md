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
|m_mobilite_3v| an_mob_itineraire| Table alphanumérique recensant l ensemble des itinéraires déclarés sur le Pays Compiégnois| stocke les différents itinéraires| |
|m_mobilite_3v| geo_mob_troncon| Table géographique représentant les tronçons d aménagement cyclables sur le Pays Compiégnois| stocke les différents tronçons cyclables| |
|m_mobilite_3v| geo_mob_carrefour| Table géographique représentant la localisation des carrefours aménagés sur des intersections de tronçons cyclables sur le Pays Compiégnois| stocke les différents carrefours renseignés| |
|m_mobilite_3v| lk_mob_ititroncon| Table de relation permettant le rattachement des tronçons à un ou plusieurs itinéraires| stocke les liaisons entre les itinéraires et les tronçons| |
|m_mobilite_3v| an_mob_media| Table alphanumérique gérant la liste des documents associés aux objets cyclables| |

---

## Classes d'objets

L'ensemble des classes d'objets unitaires sont stockées dans le schéma m_moblite_3v, celles dérivées et applicatives dans le schéma `x_apps`, celles dérivées pour les exports opendata dans le schéma `x_opendata`.

### Classe d'objet géographique et patrimoniale

`[libellé]` : table alphanumérique des métadonnées des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  


* triggers : sans objet





## Liste de valeurs

`[libellé]` : Liste permettant de décrire la nomenclature de niveau 1 des objets .

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    


|code | valeur |
|:---|:---| 



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






