![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Prescriptions locales pour la gestion des mobilités douces 

[ ] à rédiger [ ] en cours de rédaction [x] finaliser

Ensemble des éléments constituant la mise en oeuvre de la base de données sur la thématique des mobilités douces ainsi que l'exploitation de ces données dans les différentes applications dédiées.

- Script d'initialisation de la base de données
  * [Suivi des modifications](bdd/md_00_trace.sql)
  * [Création  de la structure initiale](bdd/md_10_squelette.sql)
  * [Création des vues applicatives](bdd/md_21_vues_xapps.sql)
  * [Création des vues Open Data](bdd/md_23_vues_xopendata.sql)
  * [Création des privilèges](bdd/md_99_grant.sql)
- [Documentation d'administration de la base de données](bdd/doc_admin_bd_md.md)
- [Documentation des utilisateurs de l'application (authentification nécessaire)](https://geo.compiegnois.fr/portail/index.php/2024/05/29/les-mobilites-douces/)


## Contexte

L’ARC est engagée dans un plan de modernisation numérique pour l’exercice de ses missions de services publics. L’objectif poursuivi vise à permettre à la collectivité de se doter d’outil d’aide à la décision et d’optimiser l’organisation de ses services. Ces objectifs se déclinent avec la mise en place d’outils informatiques adaptés au quotidien des services et le nécessaire retour auprès de la collectivité, des informations (données) produites et gérées par ses prestataires. 

L’ARC privilégie donc une organisation dans laquelle l’Interface Homme Machine (IHM) du métier assure l’alimentation d’un entrepôt de données territoriales. Cette stratégie « agile » permet de répondre au plus près des besoins des services dans une trajectoire soutenable assurant à la fois une bonne maitrise des flux d’information et un temps d’acculturation au sein de l’organisation.

De plus cette thématique est partagée dans le cadre de la mutualisation avec les EPCI du Grand Compiégnois. La gestion des mobilités douces fait partie de ce cadre. La gestion des données et l'applicatif sont donc partagés entre les 4 EPCI du Grand Compiégnois.

## Voir aussi

- [Schéma de données national pour le stationnement cyclable](https://schema.data.gouv.fr/etalab/schema-stationnement-cyclable/latest.html)
- [Documentation sur le stationnement cyclable](https://doc.transport.data.gouv.fr/producteurs/documentation-sur-le-stationnement-cyclable#description-du-schema)
- [Schéma de données national d’aménagements cyclables](https://schema.data.gouv.fr/etalab/schema-amenagements-cyclables/latest.html)
- [Documentation sur les aménagements cyclables (GITHUB)](https://github.com/etalab/schema-amenagements-cyclables/blob/master/documentation/ame_d.md)
- [Documentation sur les aménagements cyclables (ETALAB)](https://doc.transport.data.gouv.fr/producteurs/amenagements-cyclables#amenagements-cyclables)
- [Vélo et Territoires-  guide de saisie](https://www.velo-territoires.org/politiques-cyclables/data-velo-modeles-donnees/schema-donnees-amenagements-cyclables/#)
- [VéloObs - Observatoire du vélo](https://github.com/2p2r/velobs_web/blob/master/documentation_utilisateurs.md)
- [Outil de signalement Vélo&Territoires](https://www.velo-territoires.org/observatoires/observatoire-national-des-veloroutes-et-voies-vertes/outil-signalement-anomalies-cyclables/)
- [GéoVélo](https://geovelo.app/fr/)
- [PANO](https://github.com/IGNF/pano?tab=readme-ov-file)
- [Schéma de randonnées](https://schema.data.gouv.fr/PnX-SI/schema_randonnee/)
- [Schéma de randonnées (GitHub)](https://github.com/PnX-SI/schema_randonnee?tab=readme-ov-file)

## Jeu de données consolidé

Les jeux de données sont en cours de préparation, ils seront bientôt disponibles (courant 2025).

