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
|![picto](.png)|Itinéraires cyclables||

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

## GeoTable : `[geo_v_mob_troncon]`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_blanc|x|||N'affiche rien pour pouvoir contourner la première ligne en gras dans les résultats des recherches de Géo.|Résultat de recherche|| 
|affiche_message|x|x||Affiche un message en HTML pour préciser que la droite et la gauche se remplissent en fonction du sens de saisie.|Fiche d'information|<center><font size=2 color="#FF0000"><b><i>La gauche ou la droite se détermine par rapport au sens de saisie du tronçon.</i></b></font></center>|
|ame_d|||Aménagement (droite)||Fiche d'information des tronçons||
|ame_g|||Aménagement (gauche)||Fiche d'information des tronçons||
|amenagement_recherche|x|||Utile à un autre champ calculé pour une recherche|Recherche sur les aménagements||{ame_g};{ame_d}|
|avanc_d|||Avancement (droite)||Fiche d'information des tronçons||
|avanc_g|||Avancement (gauche)||Fiche d'information des tronçons||
|avancement_recherche|x|||Utile à un autre champs calculé pour une recherche sur les avancements||{avanc_g};{avanc_d}|
|code_com_d|||Code Insee (droite)||Fiche d'information des tronçons||
|code_com_g|||Code Insee (gauche)||Fiche d'information des tronçons||
|commune_d|||Commune (droite)||||
|commune_g|||Commune (gauche)||||
|commune_recherche|x|||Utile à un autre champs calculé pour une recherche sur les communes||{code_com_g};{code_com_d}|
|SUITE A ECRIRE||||||

   * filtres :

|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
   
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|

   * particularité(s) : aucune





# Les fonctionnalités

Sont présentées ici uniquement les fonctionnalités spécifiques à l'application.

## Recherche globale : `[libellé]`

Cette recherche permet à l'utilisateur de faire une recherche libre sur une adresse.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.




## Recherche (clic sur la carte) : `[libellé]`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de l'adresse.

  * Configuration :

Source : `[libellé]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|


(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Fiche adresse
 



## Recherche : `Toutes les recherches cadastrales`

L'ensemble des recherches cadastrales ont été formatées et intégrées par l'éditeur via son module GeoCadastre.
Seul le nom des certaines recherches a été modifié par l'ARC pour plus de compréhension des utilisateurs.

Cette recherche est détaillée dans le répertoire GitHub `docurba`.


## Recherche : `[libellé]`

Cette recherche permet à l'utilisateur de faire une recherche sur les signalements.

  * Configuration :

Source : `[libellé]`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|


(Calcul des suggestions par "Contient la chaine")
(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|


|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|

(1) si liste de domaine

 * Fiches d'information active : ....
 

## Fiche d'information : `[libellé]`

Source : `[libellé]`

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

`[Aménagement]` : Couche utilisée `xapps_geo_vmr_mob_troncon_affiche` filtrée sur les aménagements `ame` et sur l'état d'avancement `avanc`.


## Statistique :

Aucune

## Modification géométrique : `[libellé]`

Cette recherche permet à l'utilisateur de saisir un sigbnalement concernant une voie ou une adresse.

  * Configuration :
  
Source : `[libellé]`

 * Filtres : aucun
 * Accrochage : aucun
 * Fiches d'information active : ......
 * Topologie : aucune 
 
 # La cartothèque

|Groupe|Sous-groupe|Visible dans la légende|Visible au démarrage|Détails visibles|Déplié par défaut|Geotable|Renommée|Issue d'une autre carte|Visible dans la légende|Visible au démarrage|Déplié par défaut|Couche sélectionnable|Couche accrochable|Catégorisation|Seuil de visibilité|Symbologie|Autres|
|:---|:---|:-:|:-:|:-:|:-:|:---|:---|:-:|:-:|:-:|:-:|:-:|:---|:---|:---|:---|:---|

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

* Carte : `[libellé]`

Comportement au clic : (dés)active uniquement l'item cliqué
Liste des recherches : Recherche dans la Base Adresse Locale, Recherche tronçon, Signalement voie/adresse, Recherche avancée d'une voie, Parcelle(s) sélectionnée(s) (description : GeoCadastre V3)

* Fonds de plan :

|Nom|Au démarrage|opacité|
|:---|:---|:---|
|Cadastre|x|80%|
|Plan de ville|x|60%|
|Photographie aérienne 2013|x|80%|

* Fonctionnalités

|Groupe|Nom|
|:---|:---|
|Recherche cadastrale (V3)||
||Parcelles par référence|
||Parcelles par adresse fiscale (V3)|
||Parcelles par nom du propriétaire (V3) (non disponible pour l'application URBANISME)|
||Parcelles multicritères (V3)|
||Parcelles par nom du propriétaire d'un local (V3) (non disponible pour l'application URBANISME)|
||Parcelles par surface (V3)|

