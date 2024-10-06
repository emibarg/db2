CREATE TABLE Datos (
  id int PRIMARY KEY not null AUTO_INCREMENT,
  apellido varchar(50),
  nombre varchar(50),
  saldo int,
  mail varchar(50)


  
);
CREATE TABLE log_datos (
  id_cambio int primary key not null AUTO_INCREMENT,
  id int,
  apellido varchar(50),
  nombre varchar(50),
  saldo int,
  mail varchar(50),
  operacion varchar(50)
);
delimiter //
CREATE TRIGGER log_insert_datos
AFTER INSERT ON Datos
FOR EACH ROW
BEGIN
    INSERT INTO log_datos (id, apellido, nombre, saldo, mail, operacion)
    VALUES (NEW.id, NEW.apellido, NEW.nombre, NEW.saldo, NEW.mail, 'INSERT');
END//
delimiter;

delimiter // 
CREATE TRIGGER log_update_datos
AFTER UPDATE ON Datos
FOR EACH ROW
BEGIN
    INSERT INTO log_datos (id, apellido, nombre, saldo, mail, operacion)
    VALUES (NEW.id, NEW.apellido, NEW.nombre, NEW.saldo, NEW.mail, 'UPDATE');
END//
delimiter;

delimiter //
CREATE TRIGGER log_delete_datos
AFTER DELETE ON Datos
FOR EACH ROW
BEGIN
    INSERT INTO log_datos (id, apellido, nombre, saldo, mail, operacion)
    VALUES (OLD.id, OLD.apellido, OLD.nombre, OLD.saldo, OLD.mail, 'DELETE');
END//
delimiter;

delimiter //

CREATE PROCEDURE insertarDatos(IN pApellido varchar(50), IN pNombre varchar(50), IN pSaldo int, IN pMail varchar(50))
proc_label: BEGIN 

  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
  BEGIN
      ROLLBACK;
      SELECT 'Error en transaccion' AS message;
  END;

  START TRANSACTION;

  -- Insert data into the Datos table
  INSERT INTO Datos(apellido, nombre, saldo, mail) 
  VALUES (pApellido, pNombre, pSaldo, pMail);

  COMMIT; -- Commit the transaction

  SELECT 'Datos insertados correctamente' AS message;

END proc_label;
//
delimiter ;

delimiter //

CREATE PROCEDURE updateApellido(IN pId INT, IN pApellido varchar(50))
proc_label: BEGIN 

  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
  BEGIN
      ROLLBACK;
      SELECT 'Error en transaccion' AS message;
  END;

  START TRANSACTION;

  -- Update the apellido field in the Datos table
  UPDATE Datos 
  SET apellido = pApellido 
  WHERE id = pId;

  COMMIT; -- Commit the transaction

  SELECT 'Apellido actualizado correctamente' AS message;

END proc_label;
//
delimiter ;



delimiter // 
CREATE PROCEDURE updateNombre(IN pId INT, IN pNombre varchar(50))
proc_label: BEGIN 

  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
  BEGIN
      ROLLBACK;
      SELECT 'Error en transaccion' AS message;
  END;

  START TRANSACTION;

  -- Update the apellido field in the Datos table
  UPDATE Datos 
  SET nombre = pNombre 
  WHERE id = pId;

  COMMIT; -- Commit the transaction

  SELECT 'Nombre actualizado correctamente' AS message;

END proc_label;
//
delimiter ;

delimiter // 
CREATE PROCEDURE updateSaldo(IN pId INT, IN pSaldo int)
proc_label: BEGIN 

  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
  BEGIN
      ROLLBACK;
      SELECT 'Error en transaccion' AS message;
  END;

  START TRANSACTION;

  -- Update the apellido field in the Datos table
  UPDATE Datos 
  SET saldo = pSaldo 
  WHERE id = pId;

  COMMIT; -- Commit the transaction

  SELECT 'Saldo actualizado correctamente' AS message;

END proc_label;
//
delimiter ;


delimiter // 
CREATE PROCEDURE borrarDatos(IN pId INT)
proc_label: BEGIN 

  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
  BEGIN
      ROLLBACK;
      SELECT 'Error en transaccion' AS message;
  END;

  START TRANSACTION;

  -- Update the apellido field in the Datos table
  DELETE FROM Datos
    WHERE id = pId;

  COMMIT; -- Commit the transaction

  SELECT 'Datos borrados correctamente' AS message;

END proc_label;
//
delimiter ;





