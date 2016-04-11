-- ------------------------------------------------------------
--         Script MySQL.
-- ------------------------------------------------------------
DROP DATABASE IF EXISTS p2p_blog;

CREATE DATABASE p2p_blog CHARACTER SET 'utf8';
USE p2p_blog;

DROP Table IF EXISTS categorie;
DROP Table IF EXISTS article;
DROP Table IF EXISTS commentaire;
DROP Table IF EXISTS utilisateur;
DROP Table IF EXISTS categorie_article;

-- ------------------------------------------------------------
--  Table: categorie
-- ------------------------------------------------------------

CREATE TABLE categorie (
	id INT UNSIGNED AUTO_INCREMENT,
	nom VARCHAR(150) NOT NULL,
	PRIMARY KEY(id)
);

--
-- données pour la table `categorie`
--

INSERT INTO `categorie` (`nom`) VALUES
('social'),
('culture');

-- ------------------------------------------------------------
--  Table: utilisateur
-- ------------------------------------------------------------

CREATE TABLE utilisateur(
        id           int UNSIGNED Auto_increment,
        pseudo       Varchar (150) NOT NULL ,
        mot_de_passe Varchar (255) NOT NULL ,
        PRIMARY KEY (id ),
        UNIQUE INDEX ind_pseudo (pseudo)
)ENGINE=InnoDB;

--
-- données pour la table `utilisateur`
--

INSERT INTO `utilisateur` (`pseudo`, `mot_de_passe`) VALUES
('Ludo', 'Ludo'),
('Sylvie', 'Sylvie');

-- ------------------------------------------------------------
--  Table: article
-- ------------------------------------------------------------

CREATE TABLE article(
        id             int UNSIGNED Auto_increment,
        titre          Varchar (150) NOT NULL ,
        extrait        Text NOT NULL ,
        texte          Text NOT NULL ,
		dT_edit      datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
		categorie_id INT UNSIGNED NOT NULL ,
        utilisateur_id Int UNSIGNED NOT NULL ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;

--
-- Triggers `article` pour mise à jour categorie_article
--
DROP TRIGGER IF EXISTS `insert_check_article`;
DELIMITER //
CREATE TRIGGER `insert_check_article` AFTER INSERT ON `article`
 FOR EACH ROW INSERT INTO `categorie_article` (`categorie_id`, `article_id`) VALUES(NEW.categorie_id, NEW.id)
//
DELIMITER ;
DROP TRIGGER IF EXISTS `upd_check_article`;
DELIMITER //
CREATE TRIGGER `upd_check_article` AFTER UPDATE ON `article`
 FOR EACH ROW IF NEW.categorie_id != old.categorie_id THEN
			INSERT INTO `categorie_article` (`categorie_id`, `article_id`) VALUES(NEW.categorie_id, NEW.id);
        END IF
//
DELIMITER ;

-- ------------------------------------------------------------
--  Table: commentaire
-- ------------------------------------------------------------

CREATE TABLE commentaire(
        id             int UNSIGNED Auto_increment,
        commentaire    Text NOT NULL ,
        article_id     Int UNSIGNED NOT NULL ,
        utilisateur_id Int UNSIGNED,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


-- ------------------------------------------------------------
--  Table: categorie_article
-- ------------------------------------------------------------

CREATE TABLE categorie_article (
	categorie_id INT UNSIGNED,
	article_id INT UNSIGNED,
	PRIMARY KEY (categorie_id, article_id)
);

ALTER TABLE article ADD CONSTRAINT FK_article_utilisateur_id FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id);
ALTER TABLE article ADD CONSTRAINT FK_article_categorie_id FOREIGN KEY (categorie_id) REFERENCES categorie(id);
ALTER TABLE commentaire ADD CONSTRAINT FK_commentaire_article_id FOREIGN KEY (article_id) REFERENCES article(id) ON DELETE CASCADE;
ALTER TABLE commentaire ADD CONSTRAINT FK_commentaire_utilisateur_id FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id) ON DELETE SET NULL;
ALTER TABLE categorie_article ADD CONSTRAINT FK_categorie_article_article_id FOREIGN KEY (article_id) REFERENCES article(id);
ALTER TABLE categorie_article ADD CONSTRAINT FK_categorie_article_categorie_id FOREIGN KEY (categorie_id) REFERENCES categorie(id);


--
-- données pour la table `article`
--

INSERT INTO `article` (`titre`, `extrait`, `texte`, `categorie_id`, `utilisateur_id`) VALUES
('Le Lorem Ipsum', 'Penitus expers esse amictu fuisse.', 'Harum trium sententiarum nulli prorsus assentior. Nec enim illa prima vera est, ut, quem ad modum in se quisque sit, sic in amicum sit animatus. Quam multa enim, quae nostra causa numquam faceremus, facimus causa amicorum! precari ab indigno, supplicare, tum acerbius in aliquem invehi insectarique vehementius, quae in nostris rebus non satis honeste, in amicorum fiunt honestissime; multaeque res sunt in quibus de suis commodis viri boni multa detrahunt detrahique patiuntur, ut iis amici potius quam ipsi fruantur.', 1, 1),
('Le Lorem Ipsum', 'Penitus expers esse amictu fuisse.', 'Harum trium sententiarum nulli prorsus assentior. Nec enim illa prima vera est, ut, quem ad modum in se quisque sit, sic in amicum sit animatus. Quam multa enim, quae nostra causa numquam faceremus, facimus causa amicorum! precari ab indigno, supplicare, tum acerbius in aliquem invehi insectarique vehementius, quae in nostris rebus non satis honeste, in amicorum fiunt honestissime; multaeque res sunt in quibus de suis commodis viri boni multa detrahunt detrahique patiuntur, ut iis amici potius quam ipsi fruantur.', 1, 1),
('Le Lorem Ipsum', 'Penitus expers esse amictu fuisse.', 'Harum trium sententiarum nulli prorsus assentior. Nec enim illa prima vera est, ut, quem ad modum in se quisque sit, sic in amicum sit animatus. Quam multa enim, quae nostra causa numquam faceremus, facimus causa amicorum! precari ab indigno, supplicare, tum acerbius in aliquem invehi insectarique vehementius, quae in nostris rebus non satis honeste, in amicorum fiunt honestissime; multaeque res sunt in quibus de suis commodis viri boni multa detrahunt detrahique patiuntur, ut iis amici potius quam ipsi fruantur.', 2, 2);

UPDATE `article` SET `categorie_id`=2 WHERE `id`=1;
UPDATE `article` SET `categorie_id`=2 WHERE `id`=2;
UPDATE `article` SET `categorie_id`=1 WHERE `id`=3;
