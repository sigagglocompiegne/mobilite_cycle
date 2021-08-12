![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de l'application Itinéraires cyclables #


* Statut
  - [x] à rédiger
  - [ ] en cours de rédaction
  - [ ] relecture
  - [ ] finaliser
  - [ ] révision

# Généralité

|Représentation| Nom de l'application |Résumé|
|:---|:---|:---|
|![picto](.png)|Aménagements cyclables||

# Accès

|Public|Métier|Accès restreint|
|:-:|:-:|:---|
||X|Accès réservé aux personnels gestionnaires des données.||


# Droit par profil de connexion

* **Prestataires**

Sans Objet

* **Personnes du service métier**

|Fonctionnalités|Lecture|Ecriture|Précisions|
|:---|:-:|:-:|:---|

* **Autres profils**

Sans objet

# Les données

Sont décrites ici les Géotables et/ou Tables intégrées dans GEO pour les besoins de l'application. Les autres données servant d'habillage (pour la cartographie ou les recherches) sont listées dans les autres parties ci-après. Le tableau ci-dessous présente uniquement les changements (type de champ, formatage du résultat, ...) ou les ajouts (champs calculés, filtre, ...) non présents dans la donnée source. 




## GeoTable : `[geo_mob_lieustatio]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
   * 
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|gestionnaire|gest|||est similaire à une valeur choisie par l'utilisateur|lt_mob_gest||
|gratuit|gratuit||booléen|est vraie ou fausse selon le choix de l'utilisateur|||
|acces|acces|||est similaire à une valeur choisie par l'utilisateur|lt_mob_statio_acces||
|avanc|avanc|||est similaire à une valeur choisie par l'utilisateur|lt_mob_avanc||
|commune|insee|||est similaire à une valeur choisie par l'utilisateur|Commune APC||
|protégé|protection|||est similaire à une valeur choisie par l'utilisateur|lt_mob_statio_protec||

   * relations :
   * 
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|an_mob_equstatio|idlieustatio|1..n|
|an_mob_media|id - idlieustatio|0..n|
   * particularité(s) : aucune



## GeoTable : `[xapps_geo_vmr_mob_iti_deparr]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|Paramètre global|iditi|x||la valeur de l'attribut est égale à un paramètre global de l'application|||
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|

   * particularité(s) : aucune



## GeoTable : `[geo_vmr_mob_iti_affiche]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|Paramètre global|iditi|x|la valeur de l'attribut est égale à un paramètre global de l'application||||
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|an_mob_itineraire|iditi|0..1|
   * particularité(s) : aucune



## GeoTable : `[geo_mob_carrefour]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|typ_car|typ_car|||est similaire à une valeur choisie par l'utilisateur|lt_mob_carrefour||
|avancement|avanc|||est similaire à une valeur choisie par l'utilisateur|lt_mob_avanc||
|commune|insee|||est similaire à une valeur choisie par l'utilisateur|Commune APC||
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|geo_vmr_mob_iti / an_mob_itineraire|geom / iditi|0..n / 0..1|
|an_mob_media|id - idcarrefour|0..n|
   * particularité(s) : aucune



## GeoTable : `[geo_v_mob_noeud]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
   
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|

   * particularité(s) : aucune



## GeoTable : `[geo_v_mob_troncon]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|choix revetement|revetement_recherche|||est similaire à une valeur choisie par l'utilisateur|lt_mob_revet||
|choix avanc_g|avanc_g|||est égale à une valeur choisie par l'utilisateur|||
|choix idtroncon|idtroncon|||est égale à une valeur choisie par l'utilisateur|||
|select spatiale geom contenue|geom|||est contenue dans la sélection issue d'une donnée spatiale|||
|choix avancement|avancement_recherche|||est similaire à une valeur choisie par l'utilisateur|lt_mob_avanc||
|choix commune|commune_recherche|||est similaire à une valeur choisie par l'utilisateur|Commune APC||
|choix avanc_d|avanc_d|||est égale à une valeur choisie par l'utilisateur|||
|choix commune_g|commune_g|||est égale à une valeur choisie par l'utilisateur|||
|choix ame_d|ame_d|||est égale à une valeur choisie par l'utilisateur|||
|choix amenagement|amenagement_recherche|||est similaire à une valeur choisie par l'utilisateur|lt_mob_ame||
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|an_mob_media|gid - idtroncon|0..n|
|lk_mob_ititroncon / an_mob_itineraire|idtroncon / iditi|0..n / 1|
|xapps_an_v_mob_erreur|id - troncon|0..1|
   * particularité(s) : aucune



## GeoTable : `[xapps_geo_vmr_mob_troncon_affiche]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|avancement|avanc|||est égale à une valeur choisie par l'utilisateur|||
|aménagement|ame|||est égale à une valeur choisie par l'utilisateur|||
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|lk_mob_ititroncon / an_mob_itineraire|idtroncon / iditi|0..n / 1|
   * particularité(s) : aucune



## GeoTable : `[geo_vm_osm_commune_apc]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

   * filtres :
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|Filtre zoom auto utilisateur|insee|x||est égale à ccocom|||
   * relations :
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|

   * particularité(s) : aucune





# Les fonctionnalités

Sont présentées ici uniquement les fonctionnalités spécifiques à l'application.

## Recherche globale : `[Rechercher un itinéraire]`

Cette recherche permet à l'utilisateur de faire une recherche libre sur un nom d'itinéraire.


## Recherche globale : `[Recherche dans la Base Adresse Locale]`

Cette recherche permet à l'utilisateur de faire une recherche libre sur une adresse.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.



## Recherche (clic sur la carte) : `[Recherche d'un troçon]`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations sur le tronçon sélectionné.

  * Configuration :

Source : `[geo_v_mob_troncon]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres : 
    * choix commune : est similaire à une valeur de la liste de choix `Commune APC`.
    * choix amenagement : est similaire à une valeur de la liste de choix `lt_mob_ame`.
    * choix avancement : est similaire à une valeur de la liste de choix `lt_mob_avanc`.
    * choix revetement : est similaire à une valeur de la liste de choix `lt_mob_revet`.
 * Fiches d'information active : Fiche du tronçon cyclable
 


## Recherche (clic sur la carte) : `[Rechercher un itinéraire]`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations des itinéraires.

  * Configuration :

Source : `[an_mob_itineraire]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres :
    * gest_iti : est similaire à une valeur de la liste de choix `lt_mob_gest_iti`.
    * affiche_iti : est égale à une valeur choisi par l'utilisateur.
 * Fiches d'information active : Fiche de l'itinéraire



## Recherche (clic sur la carte) : `[Recherche carrefour cyclable]`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations des carrefours cyclables.

  * Configuration :

Source : `[geo_mob_carrefour ]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres : 
    * Commune : est similaire à une valeur de la liste de choix `Commune APC`.
    * typ_car : est similaire à une valeur de la liste de choix `lt_mob_carrefour`.
    * avancement : est similaire à une valeur de la liste de choix `lt_mob_avanc`.
 * Fiches d'information active : Fiche du carrefour cyclable



## Recherche (clic sur la carte) : `[Recherche stationnement cyclable]`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations des stationnements cyclables.

  * Configuration :

Source : `[geo_mob_lieustatio]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|


(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres : 
    * accès : est similaire à une valeur de la liste de choix `lt_mob_statio_acces`.
    * gratuit : est vrai ou faux selon le choix de l'utilisateur.
    * protégé : est similaire à une valeur de la liste de choix `lt_mob_statio_protec`.
    * avanc : est similaire à une valeur de la liste de choix `lt_mob_avanc`.
    * commune : est similaire à une valeur de la liste de choix `Commune APC`.
 * Fiches d'information active : Fiche du lieu de stationnement



## Recherche (clic sur la carte) : `[Parcelle par adresse]`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de l'adresse et des parcelles.

  * Configuration :

Source : `[Parcelle (Alpha)]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres : 
    * Commune de votre territoire (Parcelle (Alpha)) : 
    * Lieu-dit (Parcelle (Alpha)) : ...
    * Adresse (Parcelle (Alpha)) : ...
    * N° de voirie (Parcelle (Alpha)) : ...
 * Fiches d'information active : Fiche parcelle / Note de renseignements d'urbanisme



## Recherche : `Toutes les recherches cadastrales`

L'ensemble des recherches cadastrales ont été formatées et intégrées par l'éditeur via son module GeoCadastre.
Seul le nom des certaines recherches a été modifié par l'ARC pour plus de compréhension des utilisateurs.

Cette recherche est détaillée dans le répertoire GitHub `docurba`.













## Recherche : `[Rechercher un itinéraire]`

Cette recherche permet à l'utilisateur de faire une recherche sur les itinéraires.

  * Configuration :

Source : `[an_mob_itineraire]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient la chaine")
(la détection des doublons n'est pas activée ici)

 * Filtres :
    * gest_iti
    * affiche_iti
|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|

(1) si liste de domaine

 * Fiches d'information active : Fiche de l'itinéraire
 
 

## Recherche : `[Recherche d'un tronçon]`

Cette recherche permet à l'utilisateur de faire une recherche sur les tronçons cyclables.

  * Configuration :

Source : `[geo_v_mob_troncon]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient la chaine")
(la détection des doublons n'est pas activée ici)

 * Filtres :
    * choix commune
    * choix amenagement
    * choix avancement
    * choix revetement
|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|


|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|

(1) si liste de domaine

 * Fiches d'information active : Fiche du tronçon cyclable
 
 
 
## Recherche : `[Recherche carrefour cyclable]`

Cette recherche permet à l'utilisateur de faire une recherche sur les carrefours cyclables.

  * Configuration :

Source : `[geo_mob_carrefour]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient la chaine")
(la détection des doublons n'est pas activée ici)

 * Filtres :
    * Commune
    * typ_car
    * avancement
|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|

(1) si liste de domaine

 * Fiches d'information active : Fiche du carrefour cyclable 
 


## Recherche : `[Recherche stationnement cyclable]`

Cette recherche permet à l'utilisateur de faire une recherche sur les stationnements cyclables.

  * Configuration :

Source : `[geo_mob_lieustatio]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|

(Calcul des suggestions par "Contient la chaine")
(la détection des doublons n'est pas activée ici)

 * Filtres :
    * accès
    * gratuit
    * protégé
    * avanc
    * commune
|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|

(1) si liste de domaine

 * Fiches d'information active : Fiche du lieu de stationnement
 
 

 

## Fiche d'information : `[Fiche de l'itinéraire]`

Source : `[an_mob_itineraire]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|700x650|Onglet|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte



## Fiche d'information : `[Fiche du tronçon cyclable]`

Source : `[geo_v_mob_troncon]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|700x650|Onglet|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte



## Fiche d'information : `[Fiche du lieu de stationnement]`

Source : `[geo_mob_lieustatio]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|700x650|Onglet|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte



## Fiche d'information : `[Fiche des équipements du stationnement]`

Source : `[an_mob_equstatio]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|700x650|Onglet|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte



## Fiche d'information : `[Fiche du carrefour cyclable]`

Source : `[geo_mob_carrefour]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|700x650|Onglet|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte


## Fiche d'information : `[Fiche lk_mob_ititroncon]`

Source : `[lk_mob_ititroncon]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte
 
 

## Fiche d'information : `[Mobilité - Média]`

Source : `[an_mob_media]`

* Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|

 * Saisie : aucune
 * Modèle d'impression : Fiche standard + carte



 
## Analyse :

`[Aménagement]` : vue utilisée `xapps_geo_vmr_mob_troncon_affiche` filtrée sur les aménagements `ame` et sur l'état d'avancement `avanc`.




## Statistique :

`[APC - Répartition par aménagement cyclable]` : vue utilisée `xapps_an_v_mob3v_tab2_apc` pour afficher un graphique du pourcentage par aménagement sur l'ensemble du pays compiègnois.

---
`[APC - tableau de stationnement cyclable en service]` : vue utilisée `xapps_an_v_mob3v_tab11_apc` pour afficher un tableau des statistiques des stationnements cyclables sur l'ensemble du pays compiègnois.

---
`[APC - Itinéraires cyclables - chiffres clés]` : vue utilisée `xapps_an_v_mob3v_tab1_apc` pour afficher les chiffres clés des kilomètres de tronçons aménagés et le nombre de stationnements cyclables en service sur l'ensemble du pays compiègnois.

---
`[EPCI - Répartition par aménagement cyclable]` : vue utilisée `xapps_an_v_mob3v_tab2_epci` pour afficher un graphique du pourcentage par aménagement par EPCI.

---
`[EPCI - tableau de stationnement cyclable en service]` : vue utilisée `xapps_an_v_mob3v_tab11_epci` pour afficher un tableau des statistiques des stationnements cyclables par EPCI.

---
`[EPCI - Itinéraires cyclables - chiffres clés]` : vue utilisée `xapps_an_v_mob3v_tab1_epci` pour afficher les chiffres clés des kilomètres de tronçons aménagés et le nombre de stationnements cyclables en service par EPCI.

---
`Itinéraire cyclable : aménagements pour l'itinéraire selectionné` : vue utilisée `xapps_an_v_mob3v_tab32` pour un affichage des différents kilomètres par aménagement par itinéraire.

---
`Chiffres clés pour l'Itinéraire cyclable sélectionnné` : vue utilisée `xapps_an_v_mob3v_tab3` pour un affichage du nom de l'itinéraire choisi et sa longueur en kilomètre.

---
`Chiffres clés des itinéraires cyclables` : vue utilisée `xapps_an_v_mob3v_tab31` pour afficher le nombre total d'itinéraire et le nombre total de kilomètre de tronçons.




## Modification géométrique : `[Modification troncon]`

Cette modification permet d'ajouter, de mettre à jour ou de supprimer de la données de la couche `geo_mob_troncon`.

  * Configuration :
  
Source : `[geo_v_mob_troncon]`

 * Filtres : aucun
 * Accrochage : 
    * `geo_v_mob_troncon` : segment, noeud, extrémité.
    * `Commune` : segment, noeud.
 * Fiches d'information active : ......
 * Topologie : aucune 
 
 

 ## Modification géométrique : `[Saisie des stationnements cyclables]`

Cette recherche permet à l'utilisateur de saisir, de modifier ou de supprimer des stationnements cyclabels.

  * Configuration :
  
Source : `[geo_mob_lieustatio]`

 * Filtres : aucun
 * Accrochage : aucun
 * Fiches d'information active : ......
 * Topologie : aucune 
 
 
 
 ## Modification géométrique : `[Saisie carrefour cyclable]`

Cette recherche permet à l'utilisateur de saisir, de modifier ou de supprimer des carrefours cyclables.

  * Configuration :
  
Source : `[geo_mob_carrefour ]`

 * Filtres : aucun
 * Accrochage : 
    * `geo_v_mob_troncon` : noeud.
 * Fiches d'information active : ......
 * Topologie : aucune 

 
 
 
 # La cartothèque

|Groupe|Sous-groupe|Visible dans la légende|Visible au démarrage|Détails visibles|Déplié par défaut|Geotable|Renommée|Issue d'une autre carte|Couche sélectionnable|Couche accrochable|Catégorisation|Seuil de visibilité|Symbologie|Autres|
|:---|:---|:-:|:-:|:-:|:-:|:-:|:---|:-:|:-:|:-:|:-:|:-:|:---|:---|
|Stationnement cyclable||x|x|(ne sais pas)|x|x|Lieux de stationnement|||x|x (par état d'avancement)|1:35 000|(à ajouter)||
|Itinéraire cyclable||x||(ne sais pas)|||Nom des départs et des arrivées|||x|||(à ajouter)|points de départs et d'arrivées des itinéraires.|
|Itinéraire cyclable||x||(ne sais pas)|||Tronçon non aménagé|||x||||||(à ajouter)|affichage par dessus la couche `Itinéraire` pour visualiser les tronçons non aménagés.|
|Itinéraire cyclable||x||(ne sais pas)|||Itinéraire|||x|||(à ajouter)||
|Tronçon cyclable||x|x|(ne sais pas)|||Carrefour cyclable|||x|x (par type de carrefour)|1:30 000|(à ajouter)||
|Tronçon cyclable||x|x|(ne sais pas)|||Extrémité des tronçons|||||1:5 000|(à ajouter)||
|Tronçon cyclable||x|x|(ne sais pas)|||Sens du tracé|||x||1:5 000|(à ajouter)||
|Tronçon cyclable||x|x|(ne sais pas)||x|tronçon|||x|x (avec une analyse)|1:500 000|(à ajouter)|contient une analyse sur les aménagements et les états d'avancements|
|Données externes||x|x|(ne sais pas)|||Limite communale|||x|||(à ajouter)||

# L'application

* Généralités :

|Gabarit|Thème|Modules spé|Impression|Résultats|
|:---|:---|:---|:---|:---|
|Pro|Thème GeoCompiegnois 1.0.7|StreetView,GeoCadastre (V3),Google Analytics,Page de connexion perso, Export Fonctionnalités (Adresse),Multimédia (signalement Voie/Adresse),javascript|8 Modèles standards A4 et A3||

* Particularité de certains modules :
  * Module introduction : ce menu s'ouvre automatiquement à l'ouverture de l'application grâce un code dans le module javascript. Ce module contient une introduction sur l'application, et des liens vers des fiches d'aide.
  * Module javacript : 
  `var injector = angular.element('body').injector();
var acfApplicationService = injector.get('acfApplicationService');
acfApplicationService.whenLoaded(setTimeout(function(){
$(".sidepanel-item.launcher-application").click();
}, 100));`
    * Module Export Fonctionnalité : ce module permet l'export des données issues de recherche

|Type d'export|
|:---|
|D'après la liste|

|Fonctionnalités exportables|
|:---|


* Recherche globale :

|Noms|Tri|Nb de sugggestion|Texte d'invite|
|:---|:---|:---|:---|
|Recherche dans la Base Adresse Locale,Recherche d'une voie, Localiser un équipement|alpha|15|Rechercher une adresse, une voie,  un équipement, ...|

* Carte : `[Aménagements cyclables]`

Comportement au clic : (dés)active uniquement l'item cliqué
Liste des recherches : Recherche dans la Base Adresse Locale, recherche un itinéraire.

* Fonds de plan :

|Nom|Au démarrage|opacité|
|:---|:---|:---|
|Cadastre||100%|
|Plan de ville||100%|
|Photographie aérienne 2018|x|80%|
|Carte IGN 25000||100%|

* Fonctionnalités

|Groupe|Nom|
|:---|:---|
|Itinéraires cyclables||
||Ajouter un nouvel itinéraire|
||Recherche et modification d'un itinéraire|
|Tronçons cyclables||
||Ajout et modification d'un tronçon|
||Recherche d'un tronçon|
|Stationnements cyclables||
||Saisie des stationnements cyclables|
||Recherche stationnement cyclable|
|Carrefours cyclables||
||Ajout d'un carrefour cyclable|
||Recherche et modification d'un carrefour cyclable|
|Recherche cadastrale (V3)||
||Parcelles par référence|
||Parcelles par adresse fiscale (V3)|
||Parcelles par nom du propriétaire (V3) (non disponible pour l'application URBANISME)|
||Parcelles multicritères (V3)|
||Parcelles par nom du propriétaire d'un local (V3) (non disponible pour l'application URBANISME)|
||Parcelles par surface (V3)|

