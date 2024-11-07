DROP DATABASE DW;
CREATE DATABASE DW;

USE DW;



CREATE TABLE Sistema (
  idSistema int AUTO_INCREMENT,
  nombreSistema varchar(200) not null UNIQUE,

  PRIMARY KEY(idSistema)
);

CREATE TABLE Planeta (
  idPlaneta int AUTO_INCREMENT,
  nombrePlaneta varchar(200) not null UNIQUE,
  idSistema int not null,

  PRIMARY KEY(idPlaneta),
  FOREIGN KEY(idSistema) REFERENCES Sistema(idSistema)
);

CREATE TABLE Observatorio (
  idObservatorio int AUTO_INCREMENT,
  nombreObservatorio varchar(200) not null UNIQUE,

  PRIMARY KEY(idObservatorio)
);

CREATE TABLE AnioDesc (
  idAnio int AUTO_INCREMENT,
  Anio int not null UNIQUE,

  PRIMARY KEY(idAnio)
);
CREATE TABLE AnioPaper (
  idAnio int AUTO_INCREMENT,
  AnioMes varchar(50) not null UNIQUE,
  

  PRIMARY KEY(idAnio)
);


CREATE TABLE Metodo (
  idMetodo int AUTO_INCREMENT,
  nombreMetodo varchar(200) not null UNIQUE,

  PRIMARY KEY(idMetodo)
);

CREATE TABLE DescubrimientoExoplaneta (
  idObservatorio int not null,
  idMetodo int not null,
  idPlaneta int not null,
  idAnioDesc int not null,
  idAnioPaper int not null,
  PrecisionPercent float default 0,
  Distancia double default 0,
  InfoSobreEstrella BOOLEAN default false,

  PRIMARY KEY(idObservatorio,idMetodo,idPlaneta,idAnioDesc, idAnioPaper),
  FOREIGN KEY(idObservatorio) REFERENCES Observatorio(idObservatorio),
  FOREIGN KEY(idMetodo) REFERENCES Metodo(idMetodo),
  FOREIGN KEY(idPlaneta) REFERENCES Planeta(idPlaneta),
  FOREIGN KEY(idAnioDesc) REFERENCES AnioDesc(idAnio),
  FOREIGN KEY(idAnioPaper) REFERENCES AnioPaper(idAnio)

);

delimiter //

CREATE PROCEDURE cargarSistemas()
proc_label:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'ERROR EN TRANSACTION' as MESSAGE;
END;

START TRANSACTION;
INSERT INTO Sistema (nombreSistema) 
SELECT DISTINCT hostname from NASA.table_name where hostname not in(SELECT DISTINCT nombreSistema from DW.Sistema );
COMMIT;
END//
delimiter ;

delimiter // 
CREATE PROCEDURE cargarPlanetas()
proc_label:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'ERROR EN TRANSACTION' as MESSAGE;
  END;
START TRANSACTION;
call cargarSistemas();
INSERT INTO Planeta(nombrePlaneta, idSistema) 
SELECT DISTINCT pl_name, idSistema from NASA.table_name JOIN DW.Sistema on NASA.table_name.hostname = DW.Sistema.nombreSistema where pl_name not in (SELECT DISTINCT  nombrePlaneta from DW.Planeta);
COMMIT;
END//

delimiter ;


delimiter // 
CREATE PROCEDURE cargarObservatorios()
proc_label:BEGIN 
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'ERROR EN TRANSACTION' AS MESSAGE;
END;

START TRANSACTION;
INSERT INTO Observatorio(nombreObservatorio)
SELECT DISTINCT disc_facility from NASA.table_name where disc_facility not in ( SELECT DISTINCT nombreObservatorio FROM DW.Observatorio) ;
COMMIT;
END// 
delimiter ;


delimiter //
CREATE PROCEDURE cargarAnioDesc()
proc_label:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'ERROR EN TRANSACTION' AS MESSAGE;
END;

START TRANSACTION;
INSERT INTO AnioDesc(Anio)
SELECT DISTINCT disc_year from NASA.table_name where disc_year not in (SELECT DISTINCT  Anio from DW.AnioDesc);
COMMIT;
END//
delimiter ;


delimiter // 
CREATE PROCEDURE cargarAnioPaper()
proc_label:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'ERROR EN TRANSACTION' AS MESSAGE;
END;
START TRANSACTION;
INSERT INTO AnioPaper (AnioMes)
SELECT DISTINCT releasedate from NASA.table_name where releasedate NOT IN (SELECT DISTINCT AnioMes from DW.AnioPaper);
COMMIT;
END//
delimiter ;

delimiter // 
CREATE PROCEDURE countNull(in pidPlaneta int, in pidObservatorio int,in pidMetodo int,in pidAnioDesc int,in pidAnioPaper int,in columnName varchar(50), out success int) 

BEGIN

SET @sql = CONCAT('Select Count(tn.',columnName,') into @success
  from NASA.table_name tn 
  JOIN DW.Planeta p ON p.nombrePlaneta = tn.pl_name 
JOIN DW.Observatorio o ON o.nombreObservatorio = tn.disc_facility 
JOIN DW.Metodo m ON m.nombreMetodo = tn.discoverymethod
JOIN DW.AnioDesc ad ON ad.Anio = tn.disc_year 
JOIN DW.AnioPaper ap ON ap.AnioMes = tn.releasedate
WHERE p.idPlaneta =', pidPlaneta,' and o.idObservatorio =', pidObservatorio,' and  m.idMetodo =', pidMetodo,' and ad.idAnio =', pidAnioDesc, ' and ap.idAnio =', pidAnioPaper, ' and tn.', columnName,'=-1' );
PREPARE stmt from @sql;
execute stmt;
deallocate prepare stmt;
set success = @success;

END //
delimiter ;




DROP PROCEDURE IF EXISTS testCalc;
DELIMITER //
CREATE PROCEDURE testCalc()
BEGIN

DECLARE error_pl_orbper FLOAT;
DECLARE error_pl_orbsmax FLOAT;
DECLARE error_pl_rade FLOAT;
DECLARE error_pl_masse FLOAT;
DECLARE error_pl_msinie FLOAT;
DECLARE error_pl_cmasse FLOAT;
DECLARE error_pl_bmasse FLOAT;
DECLARE error_pl_dens FLOAT;
DECLARE error_pl_insol FLOAT;
DECLARE error_pl_eqt FLOAT;
DECLARE error_pl_orbincl FLOAT;
DECLARE error_pl_tranmid FLOAT;
DECLARE error_pl_imppar FLOAT;
DECLARE error_pl_trandep FLOAT;
DECLARE error_pl_trandur FLOAT;
DECLARE error_pl_ratdor FLOAT;
DECLARE error_pl_ratror FLOAT;
DECLARE error_pl_occdep FLOAT;
DECLARE error_pl_orbtper FLOAT;
DECLARE error_pl_rvamp FLOAT;
DECLARE error_pl_projobliq FLOAT;
DECLARE error_pl_trueobliq FLOAT;

select '1 1 1 1 1' AS 'Test Case';
CALL calcError(1, 1, 1, 1, 1, 'pl_orbper', error_pl_orbper);
CALL calcError(1, 1, 1, 1, 1, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(1, 1, 1, 1, 1, 'pl_rade', error_pl_rade);
CALL calcError(1, 1, 1, 1, 1, 'pl_masse', error_pl_masse);
CALL calcError(1, 1, 1, 1, 1, 'pl_msinie', error_pl_msinie);
CALL calcError(1, 1, 1, 1, 1, 'pl_cmasse', error_pl_cmasse);
CALL calcError(1, 1, 1, 1, 1, 'pl_bmasse', error_pl_bmasse);
CALL calcError(1, 1, 1, 1, 1, 'pl_dens', error_pl_dens);
CALL calcError(1, 1, 1, 1, 1, 'pl_insol', error_pl_insol);
CALL calcError(1, 1, 1, 1, 1, 'pl_eqt', error_pl_eqt);
CALL calcError(1, 1, 1, 1, 1, 'pl_orbincl', error_pl_orbincl);
CALL calcError(1, 1, 1, 1, 1, 'pl_tranmid', error_pl_tranmid);
CALL calcError(1, 1, 1, 1, 1, 'pl_imppar', error_pl_imppar);
CALL calcError(1, 1, 1, 1, 1, 'pl_trandep', error_pl_trandep);
CALL calcError(1, 1, 1, 1, 1, 'pl_trandur', error_pl_trandur);
CALL calcError(1, 1, 1, 1, 1, 'pl_ratdor', error_pl_ratdor);
CALL calcError(1, 1, 1, 1, 1, 'pl_ratror', error_pl_ratror);
CALL calcError(1, 1, 1, 1, 1, 'pl_occdep', error_pl_occdep);
CALL calcError(1, 1, 1, 1, 1, 'pl_orbtper', error_pl_orbtper);
CALL calcError(1, 1, 1, 1, 1, 'pl_rvamp', error_pl_rvamp);
CALL calcError(1, 1, 1, 1, 1, 'pl_projobliq', error_pl_projobliq);
CALL calcError(1, 1, 1, 1, 1, 'pl_trueobliq', error_pl_trueobliq);

SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

select '5003 19 4 12 264' AS 'Test Case';
CALL calcError(5003, 19, 4, 12, 264, 'pl_orbper', error_pl_orbper);
CALL calcError(5003, 19, 4, 12, 264, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(5003, 19, 4, 12, 264, 'pl_rade', error_pl_rade);
CALL calcError(5003, 19, 4, 12, 264, 'pl_masse', error_pl_masse);
CALL calcError(5003, 19, 4, 12, 264, 'pl_msinie', error_pl_msinie);
CALL calcError(5003, 19, 4, 12, 264, 'pl_cmasse', error_pl_cmasse);
CALL calcError(5003, 19, 4, 12, 264, 'pl_bmasse', error_pl_bmasse);
CALL calcError(5003, 19, 4, 12, 264, 'pl_dens', error_pl_dens);
CALL calcError(5003, 19, 4, 12, 264, 'pl_insol', error_pl_insol);
CALL calcError(5003, 19, 4, 12, 264, 'pl_eqt', error_pl_eqt);
CALL calcError(5003, 19, 4, 12, 264, 'pl_orbincl', error_pl_orbincl);
CALL calcError(5003, 19, 4, 12, 264, 'pl_tranmid', error_pl_tranmid);
CALL calcError(5003, 19, 4, 12, 264, 'pl_imppar', error_pl_imppar);
CALL calcError(5003, 19, 4, 12, 264, 'pl_trandep', error_pl_trandep);
CALL calcError(5003, 19, 4, 12, 264, 'pl_trandur', error_pl_trandur);
CALL calcError(5003, 19, 4, 12, 264, 'pl_ratdor', error_pl_ratdor);
CALL calcError(5003, 19, 4, 12, 264, 'pl_ratror', error_pl_ratror);
CALL calcError(5003, 19, 4, 12, 264, 'pl_occdep', error_pl_occdep);
CALL calcError(5003, 19, 4, 12, 264, 'pl_orbtper', error_pl_orbtper);
CALL calcError(5003, 19, 4, 12, 264, 'pl_rvamp', error_pl_rvamp);
CALL calcError(5003, 19, 4, 12, 264, 'pl_projobliq', error_pl_projobliq);
CALL calcError(5003, 19, 4, 12, 264, 'pl_trueobliq', error_pl_trueobliq);

SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

select '1915 46 7 21 59' AS 'Test Case';
CALL calcError(1915, 46, 7, 21, 59, 'pl_orbper', error_pl_orbper);
CALL calcError(1915, 46, 7, 21, 59, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(1915, 46, 7, 21, 59, 'pl_rade', error_pl_rade);
CALL calcError(1915, 46, 7, 21, 59, 'pl_masse', error_pl_masse);
CALL calcError(1915, 46, 7, 21, 59, 'pl_msinie', error_pl_msinie);
CALL calcError(1915, 46, 7, 21, 59, 'pl_cmasse', error_pl_cmasse);
CALL calcError(1915, 46, 7, 21, 59, 'pl_bmasse', error_pl_bmasse);
CALL calcError(1915, 46, 7, 21, 59, 'pl_dens', error_pl_dens);
CALL calcError(1915, 46, 7, 21, 59, 'pl_insol', error_pl_insol);
CALL calcError(1915, 46, 7, 21, 59, 'pl_eqt', error_pl_eqt);
CALL calcError(1915, 46, 7, 21, 59, 'pl_orbincl', error_pl_orbincl);
CALL calcError(1915, 46, 7, 21, 59, 'pl_tranmid', error_pl_tranmid);
CALL calcError(1915, 46, 7, 21, 59, 'pl_imppar', error_pl_imppar);
CALL calcError(1915, 46, 7, 21, 59, 'pl_trandep', error_pl_trandep);
CALL calcError(1915, 46, 7, 21, 59, 'pl_trandur', error_pl_trandur);
CALL calcError(1915, 46, 7, 21, 59, 'pl_ratdor', error_pl_ratdor);
CALL calcError(1915, 46, 7, 21, 59, 'pl_ratror', error_pl_ratror);
CALL calcError(1915, 46, 7, 21, 59, 'pl_occdep', error_pl_occdep);
CALL calcError(1915, 46, 7, 21, 59, 'pl_orbtper', error_pl_orbtper);
CALL calcError(1915, 46, 7, 21, 59, 'pl_rvamp', error_pl_rvamp);
CALL calcError(1915, 46, 7, 21, 59, 'pl_projobliq', error_pl_projobliq);
CALL calcError(1915, 46, 7, 21, 59, 'pl_trueobliq', error_pl_trueobliq);


SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

select '4913 54 7 7 168' AS 'Test Case';
CALL calcError(4913, 54, 7, 7, 168, 'pl_orbper', error_pl_orbper);
CALL calcError(4913, 54, 7, 7, 168, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(4913, 54, 7, 7, 168, 'pl_rade', error_pl_rade);
CALL calcError(4913, 54, 7, 7, 168, 'pl_masse', error_pl_masse);
CALL calcError(4913, 54, 7, 7, 168, 'pl_msinie', error_pl_msinie);
CALL calcError(4913, 54, 7, 7, 168, 'pl_cmasse', error_pl_cmasse);
CALL calcError(4913, 54, 7, 7, 168, 'pl_bmasse', error_pl_bmasse);
CALL calcError(4913, 54, 7, 7, 168, 'pl_dens', error_pl_dens);
CALL calcError(4913, 54, 7, 7, 168, 'pl_insol', error_pl_insol);
CALL calcError(4913, 54, 7, 7, 168, 'pl_eqt', error_pl_eqt);
CALL calcError(4913, 54, 7, 7, 168, 'pl_orbincl', error_pl_orbincl);
CALL calcError(4913, 54, 7, 7, 168, 'pl_tranmid', error_pl_tranmid);
CALL calcError(4913, 54, 7, 7, 168, 'pl_imppar', error_pl_imppar);
CALL calcError(4913, 54, 7, 7, 168, 'pl_trandep', error_pl_trandep);
CALL calcError(4913, 54, 7, 7, 168, 'pl_trandur', error_pl_trandur);
CALL calcError(4913, 54, 7, 7, 168, 'pl_ratdor', error_pl_ratdor);
CALL calcError(4913, 54, 7, 7, 168, 'pl_ratror', error_pl_ratror);
CALL calcError(4913, 54, 7, 7, 168, 'pl_occdep', error_pl_occdep);
CALL calcError(4913, 54, 7, 7, 168, 'pl_orbtper', error_pl_orbtper);
CALL calcError(4913, 54, 7, 7, 168, 'pl_rvamp', error_pl_rvamp);
CALL calcError(4913, 54, 7, 7, 168, 'pl_projobliq', error_pl_projobliq);
CALL calcError(4913, 54, 7, 7, 168, 'pl_trueobliq', error_pl_trueobliq);

SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

select '4876 54 7 26 76' AS 'Test Case';
CALL calcError(4876, 54, 7, 26, 76, 'pl_orbper', error_pl_orbper);
CALL calcError(4876, 54, 7, 26, 76, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(4876, 54, 7, 26, 76, 'pl_rade', error_pl_rade);
CALL calcError(4876, 54, 7, 26, 76, 'pl_masse', error_pl_masse);
CALL calcError(4876, 54, 7, 26, 76, 'pl_msinie', error_pl_msinie);
CALL calcError(4876, 54, 7, 26, 76, 'pl_cmasse', error_pl_cmasse);
CALL calcError(4876, 54, 7, 26, 76, 'pl_bmasse', error_pl_bmasse);
CALL calcError(4876, 54, 7, 26, 76, 'pl_dens', error_pl_dens);
CALL calcError(4876, 54, 7, 26, 76, 'pl_insol', error_pl_insol);
CALL calcError(4876, 54, 7, 26, 76, 'pl_eqt', error_pl_eqt);
CALL calcError(4876, 54, 7, 26, 76, 'pl_orbincl', error_pl_orbincl);
CALL calcError(4876, 54, 7, 26, 76, 'pl_tranmid', error_pl_tranmid);
CALL calcError(4876, 54, 7, 26, 76, 'pl_imppar', error_pl_imppar);
CALL calcError(4876, 54, 7, 26, 76, 'pl_trandep', error_pl_trandep);
CALL calcError(4876, 54, 7, 26, 76, 'pl_trandur', error_pl_trandur);
CALL calcError(4876, 54, 7, 26, 76, 'pl_ratdor', error_pl_ratdor);
CALL calcError(4876, 54, 7, 26, 76, 'pl_ratror', error_pl_ratror);
CALL calcError(4876, 54, 7, 26, 76, 'pl_occdep', error_pl_occdep);
CALL calcError(4876, 54, 7, 26, 76, 'pl_orbtper', error_pl_orbtper);
CALL calcError(4876, 54, 7, 26, 76, 'pl_rvamp', error_pl_rvamp);
CALL calcError(4876, 54, 7, 26, 76, 'pl_projobliq', error_pl_projobliq);
CALL calcError(4876, 54, 7, 26, 76, 'pl_trueobliq', error_pl_trueobliq);

SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

select '1409 21 4 7 168' AS 'Test Case';
CALL calcError(1409, 21, 4, 7, 168, 'pl_orbper', error_pl_orbper);
CALL calcError(1409, 21, 4, 7, 168, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(1409, 21, 4, 7, 168, 'pl_rade', error_pl_rade);
CALL calcError(1409, 21, 4, 7, 168, 'pl_masse', error_pl_masse);
CALL calcError(1409, 21, 4, 7, 168, 'pl_msinie', error_pl_msinie);
CALL calcError(1409, 21, 4, 7, 168, 'pl_cmasse', error_pl_cmasse);
CALL calcError(1409, 21, 4, 7, 168, 'pl_bmasse', error_pl_bmasse);
CALL calcError(1409, 21, 4, 7, 168, 'pl_dens', error_pl_dens);
CALL calcError(1409, 21, 4, 7, 168, 'pl_insol', error_pl_insol);
CALL calcError(1409, 21, 4, 7, 168, 'pl_eqt', error_pl_eqt);
CALL calcError(1409, 21, 4, 7, 168, 'pl_orbincl', error_pl_orbincl);
CALL calcError(1409, 21, 4, 7, 168, 'pl_tranmid', error_pl_tranmid);
CALL calcError(1409, 21, 4, 7, 168, 'pl_imppar', error_pl_imppar);
CALL calcError(1409, 21, 4, 7, 168, 'pl_trandep', error_pl_trandep);
CALL calcError(1409, 21, 4, 7, 168, 'pl_trandur', error_pl_trandur);
CALL calcError(1409, 21, 4, 7, 168, 'pl_ratdor', error_pl_ratdor);
CALL calcError(1409, 21, 4, 7, 168, 'pl_ratror', error_pl_ratror);
CALL calcError(1409, 21, 4, 7, 168, 'pl_occdep', error_pl_occdep);
CALL calcError(1409, 21, 4, 7, 168, 'pl_orbtper', error_pl_orbtper);
CALL calcError(1409, 21, 4, 7, 168, 'pl_rvamp', error_pl_rvamp);
CALL calcError(1409, 21, 4, 7, 168, 'pl_projobliq', error_pl_projobliq);
CALL calcError(1409, 21, 4, 7, 168, 'pl_trueobliq', error_pl_trueobliq);

SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

select '2169 14 4 14 250' AS 'Test Case';
CALL calcError(2169, 14, 4, 14, 250, 'pl_orbper', error_pl_orbper);
CALL calcError(2169, 14, 4, 14, 250, 'pl_orbsmax', error_pl_orbsmax);
CALL calcError(2169, 14, 4, 14, 250, 'pl_rade', error_pl_rade);
CALL calcError(2169, 14, 4, 14, 250, 'pl_masse', error_pl_masse);
CALL calcError(2169, 14, 4, 14, 250, 'pl_msinie', error_pl_msinie);
CALL calcError(2169, 14, 4, 14, 250, 'pl_cmasse', error_pl_cmasse);
CALL calcError(2169, 14, 4, 14, 250, 'pl_bmasse', error_pl_bmasse);
CALL calcError(2169, 14, 4, 14, 250, 'pl_dens', error_pl_dens);
CALL calcError(2169, 14, 4, 14, 250, 'pl_insol', error_pl_insol);
CALL calcError(2169, 14, 4, 14, 250, 'pl_eqt', error_pl_eqt);
CALL calcError(2169, 14, 4, 14, 250, 'pl_orbincl', error_pl_orbincl);
CALL calcError(2169, 14, 4, 14, 250, 'pl_tranmid', error_pl_tranmid);
CALL calcError(2169, 14, 4, 14, 250, 'pl_imppar', error_pl_imppar);
CALL calcError(2169, 14, 4, 14, 250, 'pl_trandep', error_pl_trandep);
CALL calcError(2169, 14, 4, 14, 250, 'pl_trandur', error_pl_trandur);
CALL calcError(2169, 14, 4, 14, 250, 'pl_ratdor', error_pl_ratdor);
CALL calcError(2169, 14, 4, 14, 250, 'pl_ratror', error_pl_ratror);
CALL calcError(2169, 14, 4, 14, 250, 'pl_occdep', error_pl_occdep);
CALL calcError(2169, 14, 4, 14, 250, 'pl_orbtper', error_pl_orbtper);
CALL calcError(2169, 14, 4, 14, 250, 'pl_rvamp', error_pl_rvamp);
CALL calcError(2169, 14, 4, 14, 250, 'pl_projobliq', error_pl_projobliq);
CALL calcError(2169, 14, 4, 14, 250, 'pl_trueobliq', error_pl_trueobliq);

SELECT error_pl_orbper as 'ERROR pl_orbper',
error_pl_orbsmax as 'ERROR pl_orbsmax',
error_pl_rade as 'ERROR pl_rade',
error_pl_masse as 'ERROR pl_masse',
error_pl_msinie as 'ERROR pl_msinie',
error_pl_cmasse as 'ERROR pl_cmasse',
error_pl_bmasse as 'ERROR pl_bmasse',
error_pl_dens as 'ERROR pl_dens',
error_pl_insol as 'ERROR pl_insol',
error_pl_eqt as 'ERROR pl_eqt';
SELECT
error_pl_orbincl as 'ERROR pl_orbincl',
error_pl_tranmid as 'ERROR pl_tranmid',
error_pl_imppar as 'ERROR pl_imppar',
error_pl_trandep as 'ERROR pl_trandep',
error_pl_trandur as 'ERROR pl_trandur',
error_pl_ratdor as 'ERROR pl_ratdor',
error_pl_ratror as 'ERROR pl_ratror',
error_pl_occdep as 'ERROR pl_occdep',
error_pl_orbtper as 'ERROR pl_orbtper',
error_pl_rvamp as 'ERROR pl_rvamp',
error_pl_projobliq as 'ERROR pl_projobliq',
error_pl_trueobliq as 'ERROR pl_trueobliq';

SELECT SUM((error_pl_orbper + error_pl_orbsmax + error_pl_rade + error_pl_masse + error_pl_msinie + error_pl_cmasse + error_pl_bmasse + error_pl_dens + error_pl_insol + error_pl_eqt + error_pl_orbincl + error_pl_tranmid + error_pl_imppar + error_pl_trandep + error_pl_trandur + error_pl_ratdor + error_pl_ratror + error_pl_occdep + error_pl_orbtper + error_pl_rvamp + error_pl_projobliq + error_pl_trueobliq) / 22) as 'Total Error';
SELECT '-----------------------------------';

END//
DELIMITER ;



DROP PROCEDURE IF EXISTS calcError;

DELIMITER //
CREATE PROCEDURE calcError(
  IN pidPlaneta INT,
  IN pidObservatorio INT,
  IN pidMetodo INT,
  IN pidAnioDesc INT,
  IN pidAnioPaper INT,
  IN columnName VARCHAR(50),
  OUT errorPorciento FLOAT
)
proc_label:BEGIN
  DECLARE columnNameERR1 VARCHAR(50);
  DECLARE columnNameERR2 VARCHAR(50);
  DECLARE numMediciones INT DEFAULT 0;
  DECLARE numMedicionesNulas INT DEFAULT 0;
  DECLARE avgValue FLOAT DEFAULT 0;
  DECLARE suma FLOAT DEFAULT 0;
  DECLARE sumaERR1 FLOAT DEFAULT 0;
  DECLARE sumaERR2 FLOAT DEFAULT 0;


  SET columnNameERR1 = CONCAT(columnName, 'err1');
  SET columnNameERR2 = CONCAT(columnName, 'err2');

DROP TEMPORARY TABLE IF EXISTS tempResults;
  CREATE TEMPORARY TABLE tempResults (
    pnumMediciones INT,
    pnumMedicionesNulas INT,
    psumaERR1 FLOAT,
    psumaERR2 FLOAT,
    pavgValue FLOAT
  );

  SET @sql = CONCAT('
    INSERT INTO tempResults(pnumMediciones, pnumMedicionesNulas, psumaERR1, psumaERR2, pavgValue)
    SELECT 
      COUNT(tn.', columnName, '),
      SUM(CASE WHEN tn.', columnName, ' = -1 THEN 1 ELSE 0 END),
      SUM(ABS(CASE WHEN tn.', columnNameERR1, ' = -1 THEN 0 ELSE tn.', columnNameERR1, ' END)),
      SUM(ABS(CASE WHEN tn.', columnNameERR2, ' = -1 THEN 0 ELSE tn.', columnNameERR2, ' END)),
      AVG(CASE WHEN tn.', columnName, ' = -1 THEN 0 ELSE tn.', columnName, ' END)
    FROM NASA.table_name tn
    JOIN DW.Planeta p ON p.nombrePlaneta = tn.pl_name 
    JOIN DW.Observatorio o ON o.nombreObservatorio = tn.disc_facility 
    JOIN DW.Metodo m ON m.nombreMetodo = tn.discoverymethod
    JOIN DW.AnioDesc ad ON ad.Anio = tn.disc_year 
    JOIN DW.AnioPaper ap ON ap.AnioMes = tn.releasedate
    WHERE p.idPlaneta = ', pidPlaneta, '
      AND o.idObservatorio = ', pidObservatorio, '
      AND m.idMetodo = ', pidMetodo, '
      AND ad.idAnio = ', pidAnioDesc, '
      AND ap.idAnio = ', pidAnioPaper, '
');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;




  SELECT pnumMediciones, pnumMedicionesNulas, psumaERR1, psumaERR2, pavgValue
  INTO numMediciones, numMedicionesNulas, sumaERR1, sumaERR2, avgValue
  FROM tempResults;


  DROP TEMPORARY TABLE tempResults;

  -- SELECT numMediciones as 'Numero de mediciones', numMedicionesNulas as 'Numero de nulos', avgValue as 'Promedio';


  SET suma = sumaERR1 + sumaERR2;
  -- SELECT suma as 'Result', sumaERR1 as 'ERR1', sumaERR2 as 'ERR2';


  IF numMediciones = numMedicionesNulas THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;
  
  IF (avgValue = 0) THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;

  SET errorPorciento = suma * 100 / avgValue;


IF ABS(errorPorciento) > 100 THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;


  IF numMedicionesNulas > 0 THEN
    SET errorPorciento = ((errorPorciento * (numMediciones - numMedicionesNulas)) + (numMedicionesNulas * 100)) / numMediciones;
  END IF;


END //
DELIMITER ;

delimiter //

CREATE PROCEDURE cargarMetodos()
proc_label:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'ERROR EN TRANSACTION' AS MESSAGE;
END;

START TRANSACTION;

INSERT INTO Metodo(nombreMetodo)
SELECT DISTINCT discoverymethod FROM NASA.table_name where discoverymethod not in (SELECT DISTINCT nombreMetodo from DW.Metodo );
COMMIT;
END//
delimiter ;

delimiter //
CREATE PROCEDURE cargarDescubrimientos()
BEGIN
  DECLARE valorFinal float default 0;
  DECLARE temp float default 0;
  DECLARE credits int default false;
  DECLARE counter int default 0;
  DECLARE cidPlaneta int;
  DECLARE cidObservatorio int;
  DECLARE cidMetodo int;
  DECLARE cidAnioDesc int;
  DECLARE cidAnioPaper int;
  DECLARE row_cursor CURSOR FOR 
  SELECT idPlaneta, idObservatorio, idMetodo, idAnioDesc, idAnioPaper
  from DescubrimientoExoplaneta;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET credits = true;
    

    START TRANSACTION;

    -- Load data into dependent tables in correct order
    CALL cargarPlanetas();
    CALL cargarMetodos();
    CALL cargarAnioDesc();
    CALL cargarAnioPaper();
    CALL cargarObservatorios();

    -- Insert into the final DescubrimientoExoplaneta table
   INSERT INTO DescubrimientoExoplaneta(idPlaneta, idObservatorio, idMetodo, idAnioDesc, idAnioPaper, Distancia)
SELECT p.idPlaneta, o.idObservatorio, m.idMetodo, ad.idAnio, ap.idAnio, (CASE WHEN AVG(tn.sy_dist) = -1 THEN 0 ELSE AVG(tn.sy_dist) END)
FROM NASA.table_name tn
JOIN DW.Planeta p ON p.nombrePlaneta = tn.pl_name 
JOIN DW.Observatorio o ON o.nombreObservatorio = tn.disc_facility 
JOIN DW.Metodo m ON m.nombreMetodo = tn.discoverymethod
JOIN DW.AnioDesc ad ON ad.Anio = tn.disc_year 
JOIN DW.AnioPaper ap ON ap.AnioMes = tn.releasedate
GROUP BY p.idPlaneta, o.idObservatorio, m.idMetodo, ad.idAnio, ap.idAnio;

UPDATE DescubrimientoExoplaneta
  SET InfoSobreEstrella=true
  WHERE idPlaneta in (SELECT p.idPlaneta
                      FROM DW.Planeta p JOIN NASA.table_name tn ON p.nombrePlaneta = tn.pl_name
                      WHERE tn.hostname NOT LIKE '-1' AND tn.st_rad  not LIKE '-1' and tn.st_spectype  not LIKE '-1');




    COMMIT;


END//

delimiter ;

DELIMITER //

CREATE PROCEDURE cargarErrores()
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE counter INT DEFAULT 0;
  DECLARE MaxSize INT DEFAULT 0;
  DECLARE temp FLOAT DEFAULT 0;
  DECLARE valorFinal FLOAT DEFAULT 0;
  DECLARE cidPlaneta INT;
  DECLARE cidObservatorio INT;
  DECLARE cidMetodo INT;
  DECLARE cidAnioDesc INT;
  DECLARE cidAnioPaper INT;

  DROP TABLE IF EXISTS temporal_table;

  CREATE TABLE temporal_table (
    idTemp INT PRIMARY KEY AUTO_INCREMENT,
    idObservatorio INT NOT NULL,
    idMetodo INT NOT NULL,
    idPlaneta INT NOT NULL,
    idAnioDesc INT NOT NULL,
    idAnioPaper INT NOT NULL,
    PrecisionPercent FLOAT DEFAULT 0
  );

  SELECT "Table Created" AS 'Progress';

  INSERT INTO temporal_table(idObservatorio, idMetodo, idPlaneta, idAnioDesc, idAnioPaper)
  SELECT idObservatorio, idMetodo, idPlaneta, idAnioDesc, idAnioPaper FROM DescubrimientoExoplaneta;

  SELECT "Data Inserted" AS 'Progress';

  SELECT COUNT(*) INTO MaxSize FROM temporal_table; 

  SELECT "MaxSize Calculated" AS 'Progress', MaxSize AS 'MaxSize';

  SET counter = 0;
  SET i = 0;
  loop_label: LOOP
    SET i = i + 1;
    SET valorFinal = 0;

    IF i > MaxSize THEN
      LEAVE loop_label;
    END IF;

    SELECT idObservatorio, idMetodo, idPlaneta, idAnioDesc, idAnioPaper 
    INTO cidObservatorio, cidMetodo, cidPlaneta, cidAnioDesc, cidAnioPaper 
    FROM temporal_table 
    WHERE idTemp = i;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_orbper', temp);
  SET valorFinal = valorFinal + temp;
  
  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_orbsmax', temp);
  SET valorFinal = valorFinal + temp;
  
  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_rade', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_masse', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_msinie', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_cmasse', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_bmasse', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_dens', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_insol', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_eqt', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_orbincl', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_tranmid', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_imppar', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_trandep', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_trandur', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_ratdor', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_ratror', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_occdep', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_orbtper', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_rvamp', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_projobliq', temp);
  SET valorFinal = valorFinal + temp;

  CALL calcError(cidPlaneta, cidObservatorio, cidMetodo, cidAnioDesc, cidAnioPaper, 'pl_trueobliq', temp);
  SET valorFinal = valorFinal + temp;

  SET valorFinal = valorFinal / 22;
  SET valorFinal = 100 - valorFinal;

    -- Update the temporal_table with the calculated valorFinal
    UPDATE temporal_table
    SET PrecisionPercent = valorFinal
    WHERE idTemp = i;

    SET counter = counter + 1;
    SELECT CONCAT(counter, ' of ', MaxSize) AS 'Progress';

  END LOOP loop_label;

  UPDATE DescubrimientoExoplaneta
  JOIN temporal_table
  ON DescubrimientoExoplaneta.idPlaneta = temporal_table.idPlaneta
  AND DescubrimientoExoplaneta.idObservatorio = temporal_table.idObservatorio
  AND DescubrimientoExoplaneta.idMetodo = temporal_table.idMetodo
  AND DescubrimientoExoplaneta.idAnioDesc = temporal_table.idAnioDesc
  AND DescubrimientoExoplaneta.idAnioPaper = temporal_table.idAnioPaper
  SET DescubrimientoExoplaneta.PrecisionPercent = temporal_table.PrecisionPercent;


  SELECT "Data Updated" AS 'Progress';

  COMMIT;

END //

DELIMITER ;



