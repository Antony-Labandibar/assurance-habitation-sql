-- Base assurance_habitation.db : création des tables
-- Script généré avec SQL Power Architect, puis adapté pour SQLite :
--   - la clé étrangère est déclarée dans le CREATE TABLE, car SQLite ne gère pas
--     ALTER TABLE ... ADD CONSTRAINT ;
--   - les descriptions de colonnes (COMMENT ON, non supporté par SQLite) sont
--     reprises en commentaires.

PRAGMA foreign_keys = ON;

-- Référentiel géographique (38 916 communes)
CREATE TABLE Region (
    Code_dep_code_commune VARCHAR(6)  NOT NULL,  -- code département + code commune : clé unique
    dep_nom               VARCHAR(43) NOT NULL,  -- nom du département
    aca_nom               VARCHAR(24) NOT NULL,  -- académie associée à la commune
    reg_nom               VARCHAR(26) NOT NULL,  -- nom de la région
    reg_code              VARCHAR(2)  NOT NULL,  -- code administratif de la région
    com_nom_maj_court     VARCHAR(32) NOT NULL,  -- nom court de la commune en majuscules
    dep_code              VARCHAR(3)  NOT NULL,  -- code du département
    dep_nom_num           VARCHAR(49) NOT NULL,  -- nom du département avec son numéro
    CONSTRAINT Region_pk PRIMARY KEY (Code_dep_code_commune)
);

-- Contrats d'assurance habitation (30 335 contrats)
CREATE TABLE Contrat (
    Contrat_ID              INTEGER     NOT NULL,  -- identifiant unique du contrat
    No_voie                 INTEGER,               -- numéro dans la voie (facultatif)
    B_T_Q                   CHAR(1),               -- indicateur de répétition : bis, ter... (facultatif)
    Type_de_voie            VARCHAR(4),            -- rue, av, rte... (facultatif)
    Voie                    VARCHAR(26) NOT NULL,  -- libellé de la voie
    Code_dep_code_commune   VARCHAR(6)  NOT NULL,  -- clé étrangère vers Region
    Code_postal             VARCHAR(5)  NOT NULL,  -- VARCHAR pour conserver les zéros initiaux
    Surface                 INTEGER     NOT NULL,  -- surface du logement en m²
    Prix_cotisation_mensuel INTEGER     NOT NULL,  -- cotisation mensuelle
    Valeur_declaree_biens   VARCHAR(11) NOT NULL,  -- tranche de valeur déclarée des biens
    Formule                 VARCHAR(10) NOT NULL,  -- formule d'assurance choisie
    Type_contrat            VARCHAR(20) NOT NULL,  -- résidence principale, secondaire ou location
    Occupation              VARCHAR(12) NOT NULL,  -- locataire ou propriétaire
    Type_local              VARCHAR(11) NOT NULL,  -- appartement ou maison
    CONSTRAINT Contrat_pk PRIMARY KEY (Contrat_ID),
    CONSTRAINT Region_Contrat_fk FOREIGN KEY (Code_dep_code_commune)
        REFERENCES Region (Code_dep_code_commune)
);

-- Contrôle d'intégrité après import (aucune ligne retournée = aucune erreur)
-- PRAGMA foreign_key_check;
