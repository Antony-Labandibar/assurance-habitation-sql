-- Base assurance_habitation.db : 12 requêtes d'analyse
-- Les résultats et leurs explications sont détaillés dans requetes_sql.pdf

-- Requête 1 : contrats et surfaces pour le code postal 92100 (98 contrats)
SELECT Contrat_ID, Surface
FROM Contrat
WHERE Code_postal = '92100';

-- Requête 2 : liste des régions de France (19 régions distinctes)
SELECT DISTINCT reg_nom
FROM Region;

-- Requête 3 : nombre de contrats sur les résidences principales (25 620)
SELECT COUNT(*) AS nombre_contrats
FROM Contrat
WHERE Type_contrat = 'Résidence principale';

-- Requête 4 : les 5 contrats avec les plus grandes surfaces
SELECT Contrat_ID, Surface AS Surface_en_m2
FROM Contrat
ORDER BY Surface DESC
LIMIT 5;

-- Requête 5 : prix moyen de la cotisation mensuelle (19,33 €)
SELECT ROUND(AVG(Prix_cotisation_mensuel), 2) AS prix_moyen
FROM Contrat;

-- Requête 6 : nombre de contrats par catégorie de valeur déclarée des biens
SELECT Valeur_declaree_biens AS categorie_valeur,
       COUNT(*) AS nombre_contrats
FROM Contrat
GROUP BY Valeur_declaree_biens;

-- Requête 7 : nombre de formules Integral en Pays de la Loire (589)
SELECT COUNT(*) AS nombre_formules_integral
FROM Contrat AS c
JOIN Region AS r
    ON c.Code_dep_code_commune = r.Code_dep_code_commune
WHERE c.Formule = 'Integral'
  AND r.reg_nom = 'Pays de la Loire';

-- Requête 8 : contrats des maisons du département 71 (4 contrats)
SELECT Contrat_ID, Type_contrat, Formule
FROM Contrat AS c
JOIN Region AS r
    ON c.Code_dep_code_commune = r.Code_dep_code_commune
WHERE c.Type_local = 'Maison'
  AND r.dep_code = '71';

-- Requête 9 : surface moyenne des logements assurés à Paris (51,77 m²)
SELECT ROUND(AVG(c.Surface), 2) AS Surface_Paris_moyenne_en_m2
FROM Contrat AS c
JOIN Region AS r
    ON c.Code_dep_code_commune = r.Code_dep_code_commune
WHERE r.dep_code = '75';

-- Requête 10 : top 10 des départements par prix moyen de cotisation
SELECT r.dep_code, r.dep_nom,
       ROUND(AVG(c.Prix_cotisation_mensuel), 2) AS prix_moyen_cotisation
FROM Contrat AS c
JOIN Region AS r
    ON c.Code_dep_code_commune = r.Code_dep_code_commune
GROUP BY r.dep_code, r.dep_nom
ORDER BY prix_moyen_cotisation DESC
LIMIT 10;

-- Requête 11 : communes ayant au moins 150 contrats (20 communes)
SELECT r.com_nom_maj_court, COUNT(*) AS nombre_contrats
FROM Contrat AS c
JOIN Region AS r
    ON c.Code_dep_code_commune = r.Code_dep_code_commune
GROUP BY r.com_nom_maj_court
HAVING COUNT(*) >= 150
ORDER BY nombre_contrats DESC;

-- Requête 12 : nombre de contrats par région (Île-de-France en tête : 14 177)
SELECT r.reg_nom, COUNT(*) AS nombre_contrats
FROM Contrat AS c
JOIN Region AS r
    ON c.Code_dep_code_commune = r.Code_dep_code_commune
GROUP BY r.reg_nom
ORDER BY nombre_contrats DESC;
