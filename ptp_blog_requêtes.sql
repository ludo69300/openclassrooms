-- ------------------------------------------------------------
--         Script requêtes MySQL.
-- ------------------------------------------------------------

-- ------------------------------------------------------------
--  page d’accueil : titre, date, auteur et résumé. Ils sont triés par date de publication.
-- ------------------------------------------------------------

SELECT article.titre, DATE_FORMAT(article.dT_edit, '%d/%m/%Y') AS dt_art, utilisateur.pseudo , article.extrait
FROM article 
INNER JOIN utilisateur 
	ON utilisateur_id=utilisateur.id
ORDER BY dT_edit

-- ------------------------------------------------------------
--  page utilisateur : articles écrits par un utilisateur triés par date
-- ------------------------------------------------------------

SELECT article.titre, DATE_FORMAT(article.dT_edit, '%d/%m/%Y') AS dt_art, article.extrait
FROM article 
WHERE utilisateur_id=1
ORDER BY dT_edit

