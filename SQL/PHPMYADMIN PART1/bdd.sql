-- Active: 1669111536603@@127.0.0.1@3306@bdd_finance
CREATE DATABASE db_financial;

USE db_financial;

CREATE TABLE Trader (
    nom varchar(255) NOT NULL,
    classe_actif varchar(255) NOT NULL,
    anneesExperience int(12) NOT NULL,
    nomEquipe varchar(255) NOT NULL,
    PRIMARY KEY (nom),
    FOREIGN KEY (nomEquipe) REFERENCES trader(nomEquipe)
);


CREATE TABLE Equipe (
    nom varchar(255) NOT NULL,
    style varchar(255) NOT NULL,
    chef varchar(255) NOT NULL,
    PRIMARY KEY (nom)
);

CREATE TABLE Transaction (
    nom varchar(255),
    date varchar(255) NOT NULL,
    lieu varchar(255) NOT NULL,
    prix int(12) NOT NULL,
    nomEquipe varchar(255) NOT NULL,
    PRIMARY KEY (nom),
    FOREIGN KEY (nomEquipe) REFERENCES trader(nomEquipe)
);

INSERT INTO Transaction (nom, date, lieu, prix, nomEquipe)
 VALUES
 ('AXA SA', '2021-06-15', 'PARIS', 26, 'Equipe1'),
 ('TotalEnergies', '2004-09-03', 'PARIS', 57, 'Equipe2'),
 ('Apple Inc', '2014-09-05', 'USA', 150, 'Equipe1'),
 ('Dubai Elec', '2020-11-22', 'DUBAI', 1, 'Equipe3'),
 ('Amazon', '2010-07-12', 'USA', 100, 'Equipe3'),
 ('Naspers', '1997-08-16', 'SOUTH AFRICA', 120, 'Equipe2'),
 ('PetroChina', '2019-04-20', 'HONG KONG', 10, 'Equipe5'),
 ('ETF Vanguard', '2015-02-22', 'LA', 200, 'Equipe7'),
 ('DassaultAviation', '2016-01-01', 'PARIS', 140, 'Equipe6');

INSERT INTO Trader (nom, classe_actif, anneesExperience, nomEquipe)
 VALUES
 ('Yannick', 'fixed income', 10, 'Equipe1'),
 ('Patrick', 'action', 10, 'Equipe1'),
 ('Cedrick', 'commodities', 10, 'Equipe1'),
 ('Jordan', 'change', 2, 'Equipe2'),
 ('Gaelle', 'exotic', 4, 'Equipe3'),
 ('Georges', 'CDS', 20, 'Equipe6');

INSERT INTO Equipe (nom, style, chef)
 VALUES
 ('Equipe1', 'marketing making', 'leonardo'),
 ('Equipe2', 'arbitrage', 'michaelgelo'),
 ('Equipe3', 'trading de volatilite', 'raphael'),
 ('Equipe4', 'trading de haute frequence', 'donatello'),
 ('Equipe5', 'arbitrage statistique', 'Smith'),
 ('Equipe6', 'arbitrage statistique', 'Smith'),
 ('Equipe7', 'strategie fond de fond', 'Ray');

 --mf01 
select nom , classe_actif
from Trader
where anneesExperience < 5 

--mf02
select classe_actif
from trader
where nomEquipe = "Equipe1"

--mf03
select classe_actif
from trader
GROUP BY classe_actif = "commodities"

--mf04
select classe_actif
from trader
where anneesExperience > 20

--mf05
select nom
from trader
where anneesExperience >= 5 AND anneesExperience <= 10

--mf06
select classe_actif
from trader
where classe_actif LIKE 'ch%'

--mf07
select nom
from Equipe
where style = "arbitrage statistique"

--mf08
select nom
from Equipe
where chef = "Smith"

--mf09
select nom
from Transaction
ORDER BY nom ASC

--mf010
select date
from Transaction
where date = "2019-04-20" 

--mf011
SELECT lieu,prix 
From Transaction 
WHERE prix > 150;

--mf012
SELECT * 
From Transaction 
WHERE prix < 50 AND lieu LIKE 'PARIS';

--mf013
SELECT lieu 
From transaction 
WHERE date > '2014-01-01' And date <'2014-12-31';

--mtj01
SELECT trader.nom,classe_actif,anneesExperience, style
FROM trader INNER JOIN equipe ON trader.nomEquipe = equipe.nom
WHERE anneesExperiences > 3 AND style = 'arbitrage statistique'
ORDER BY nom;

--mtj02
SELECT lieu,chef
FROM transaction INNER JOIN equipe
ON transaction.nomEquipe = equipe.nom
WHERE chef = 'Smith' AND prix<20
ORDER BY lieu ASC;

--mtj03
SELECT COUNT(tran.lieu) 
FROM transaction tran LEFT JOIN equipe 
ON tran.nomEquipe = equipe.nom 
WHERE equipe.style ='marketing making' 
AND tran.date >= "2021-01-01" 
AND tran.date <= '2021-12-31';

--mtj04
SELECT AVG(tran.prix),lieu 
FROM transaction tran INNER JOIN equipe e 
ON tran.nomEquipe = e.nom 
WHERE e.style = 'marketing making' GROUP BY tran.lieu;

--mtj05
SELECT trader.classe_actif, e.chef,tran.date 
FROM trader JOIN equipe e ON trader.nomEquipe = e.nom 
JOIN transaction tran ON tran.nomEquipe = trader.nomEquipe 
WHERE date = '2016-01-01' AND e.chef = 'Smith';

--mtj21
SELECT AVG(trader.anneesExperience), trader.classe_actif,e.style 
FROM trader INNER JOIN equipe e ON trader.nomEquipe = e.nom 
WHERE trader.classe_actif = 'action' GROUP BY e.style;

--mts01
SELECT trader.nom,anneesExperience,style,nomEquipe
FROM trader,equipe
WHERE trade.nomEquipe = equipe.nom AND
anneesExperience > 3 AND
style = 'arbitrage statistique'
GROUP BY nom ASC;

--mts02
SELECT lieu,chef
FROM transaction, equipe
WHERE prix < 20
AND chef = 'Smith'
GROUP BY lieu ASC;

--mts03
SELECT count(Transaction.lieu) as nb_market 
FROM Transaction 
WHERE year(Transaction.date) = 2015 AND 
Transaction.nomEquipe IN 
( SELECT nom 
FROM Equipe 
WHERE Equipe.style = 'volatilite' 
);

--mts04
SELECT lieu , AVG(Transaction.prix) 
FROM Transaction 
WHERE Transaction.nomEquipe IN ( 
    SELECT nom FROM Equipe 
    WHERE Equipe.style = 'marketing making' ) 
    GROUP BY Transaction.lieu;

--mts5
SELECT Trader.classe_actif 
FROM Trader 
WHERE Trader.nomEquipe IN ( 
    SELECT nom FROM Equipe 
    WHERE Equipe.chef = "Smith" 
    AND Equipe.nom IN ( 
        SELECT nomEquipe 
        FROM Transaction 
        WHERE Transaction.date = "2016-01-01" ) 
        );






