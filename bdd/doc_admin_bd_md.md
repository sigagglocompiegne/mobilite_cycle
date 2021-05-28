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

La base de données des espaces verts s'appuie sur des référentiels préexistants constituant autant de dépendances nécessaires pour l'implémentation de la base PEI.

|schéma | table | description | usage |
|:---|:---|:---|:---|   


---

## Classes d'objets

L'ensemble des classes d'objets unitaires sont stockées dans le schéma m_espace_vert, celles dérivées et applicatives dans le schéma `x_apps`, celles dérivées pour les exports opendata dans le schéma `x_opendata`.

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






