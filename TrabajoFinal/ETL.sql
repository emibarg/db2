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
  Distancia double not null,
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
SELECT DISTINCT disc_pubdate from NASA.table_name where disc_pubdate NOT IN (SELECT DISTINCT AnioMes from DW.AnioPaper);
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
JOIN DW.AnioPaper ap ON ap.AnioMes = tn.disc_pubdate
WHERE p.idPlaneta =', pidPlaneta,' and o.idObservatorio =', pidObservatorio,' and  m.idMetodo =', pidMetodo,' and ad.idAnio =', pidAnioDesc, ' and ap.idAnio =', pidAnioPaper, ' and tn.', columnName,'=-1' );
PREPARE stmt from @sql;
execute stmt;
deallocate prepare stmt;
set success = @success;

END //
delimiter ;

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
BEGIN
  DECLARE columnNameERR1 VARCHAR(50);
  DECLARE columnNameERR2 VARCHAR(50);
  DECLARE numMediciones INT DEFAULT 0;
  DECLARE numMedicionesNulas INT DEFAULT 0;
  DECLARE avgValue FLOAT DEFAULT 0;
  DECLARE suma FLOAT DEFAULT 0;
  DECLARE sumaERR1 FLOAT DEFAULT 0;
  DECLARE sumaERR2 FLOAT DEFAULT 0;

  -- Construct error column names
  SET columnNameERR1 = CONCAT(columnName, 'err1');
  SET columnNameERR2 = CONCAT(columnName, 'err2');

  -- Temporary table for capturing results
DROP TEMPORARY TABLE IF EXISTS tempResults;
  CREATE TEMPORARY TABLE tempResults (
    pnumMediciones INT,
    pnumMedicionesNulas INT,
    psumaERR1 FLOAT,
    psumaERR2 FLOAT,
    pavgValue FLOAT
  );

  SET @sql = CONCAT('
    INSERT INTO tempResults(pnumMediciones, pnumMedicionesNulas)
    SELECT 
      COUNT(tn.', columnName, '),
      SUM(CASE WHEN tn.', columnName, ' = -1 THEN 1 ELSE 0 END)
    FROM NASA.table_name tn
    JOIN DW.Planeta p ON p.nombrePlaneta = tn.pl_name 
    JOIN DW.Observatorio o ON o.nombreObservatorio = tn.disc_facility 
    JOIN DW.Metodo m ON m.nombreMetodo = tn.discoverymethod
    JOIN DW.AnioDesc ad ON ad.Anio = tn.disc_year 
    JOIN DW.AnioPaper ap ON ap.AnioMes = tn.disc_pubdate
    WHERE p.idPlaneta = ', pidPlaneta, '
      AND o.idObservatorio = ', pidObservatorio, '
      AND m.idMetodo = ', pidMetodo, '
      AND ad.idAnio = ', pidAnioDesc, '
      AND ap.idAnio = ', pidAnioPaper, '
');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;





SET @sql = CONCAT('
    UPDATE tempResults
    JOIN (SELECT 
      SUM(ABS(tn.', columnNameERR1, ')) as a,
      SUM(ABS(tn.', columnNameERR2, ')) as b,
      AVG(tn.', columnName, ') as c
    FROM NASA.table_name tn
    JOIN DW.Planeta p ON p.nombrePlaneta = tn.pl_name 
    JOIN DW.Observatorio o ON o.nombreObservatorio = tn.disc_facility 
    JOIN DW.Metodo m ON m.nombreMetodo = tn.discoverymethod
    JOIN DW.AnioDesc ad ON ad.Anio = tn.disc_year 
    JOIN DW.AnioPaper ap ON ap.AnioMes = tn.disc_pubdate
    WHERE p.idPlaneta = ', pidPlaneta, '
      AND o.idObservatorio = ', pidObservatorio, '
      AND m.idMetodo = ', pidMetodo, '
      AND ad.idAnio = ', pidAnioDesc, '
      AND ap.idAnio = ', pidAnioPaper, '
      AND tn.', columnName, ' != -1)
      AS subquery
      SET tempResults.psumaERR1 = subquery.a,
      tempResults.psumaERR2 = subquery.b,
      tempResults.pavgValue = subquery.c
'
);
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;





  -- Retrieve data from the temporary table into variables
  SELECT pnumMediciones, pnumMedicionesNulas, psumaERR1, psumaERR2, pavgValue
  INTO numMediciones, numMedicionesNulas, sumaERR1, sumaERR2, avgValue
  FROM tempResults;

  -- Drop temporary table after use
  DROP TEMPORARY TABLE tempResults;



  -- Calculate total error sum
  SET suma = sumaERR1 + sumaERR2;

  -- Handle cases based on calculations
  IF numMediciones = numMedicionesNulas THEN
    SET errorPorciento = 100;
  ELSEIF (avgValue < 1 AND suma >= 1) THEN
    SET errorPorciento = 100;
  ELSE
    SET errorPorciento = 100 * suma / avgValue;
    IF numMedicionesNulas > 0 THEN
      SET errorPorciento = (errorPorciento + numMedicionesNulas * 100) / numMediciones;
    END IF;
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
SELECT DISTINCT p.idPlaneta, o.idObservatorio, m.idMetodo, ad.idAnio, ap.idAnio, AVG(tn.sy_dist)
FROM NASA.table_name tn
JOIN DW.Planeta p ON p.nombrePlaneta = tn.pl_name 
JOIN DW.Observatorio o ON o.nombreObservatorio = tn.disc_facility 
JOIN DW.Metodo m ON m.nombreMetodo = tn.discoverymethod
JOIN DW.AnioDesc ad ON ad.Anio = tn.disc_year 
JOIN DW.AnioPaper ap ON ap.AnioMes = tn.disc_pubdate
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

  SET valorFinal = valorFinal / 23;
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



