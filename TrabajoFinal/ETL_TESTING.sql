
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



  -- Retrieve data from the temporary table into variables
  SELECT pnumMediciones, pnumMedicionesNulas, psumaERR1, psumaERR2, pavgValue
  INTO numMediciones, numMedicionesNulas, sumaERR1, sumaERR2, avgValue
  FROM tempResults;

  -- Drop temporary table after use
  DROP TEMPORARY TABLE tempResults;

  SELECT numMediciones as 'Numero de mediciones', numMedicionesNulas as 'Numero de nulos', avgValue as 'Promedio';

  -- Calculate total error sum
  SET suma = sumaERR1 + sumaERR2;
  SELECT suma as 'Result', sumaERR1 as 'ERR1', sumaERR2 as 'ERR2';


  -- Handle cases based on calculations
  IF numMediciones = numMedicionesNulas THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;
  
  IF (avgValue = 0) THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;

  SET errorPorciento = suma * 100 / avgValue;
  SELECT errorPorciento as 'X% final sin nulos';

IF errorPorciento > 100 THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;



  IF numMedicionesNulas > 0 THEN
     SELECT numMedicionesNulas * 100 / numMediciones as 'Porciento de nulos a sumar';
     SET errorPorciento = errorPorciento + numMedicionesNulas * 100 / numMediciones;
     Select errorPorciento as 'X% final con nulos';
  END IF;


END //
DELIMITER ;