
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

  -- SELECT numMediciones as 'Numero de mediciones', numMedicionesNulas as 'Numero de nulos', avgValue as 'Promedio';

  -- Calculate total error sum
  SET suma = sumaERR1 + sumaERR2;
  -- SELECT suma as 'Result', sumaERR1 as 'ERR1', sumaERR2 as 'ERR2';


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


IF ABS(errorPorciento) > 100 THEN
    SET errorPorciento = 100;
    LEAVE proc_label;
  END IF;


  IF numMedicionesNulas > 0 THEN
    SET errorPorciento = ((errorPorciento * (numMediciones - numMedicionesNulas)) + (numMedicionesNulas * 100)) / numMediciones;
  END IF;


END //
DELIMITER ;