DROP SCHEMA ejercicio;

CREATE SCHEMA ejercicio;
USE ejercicio;

CREATE TABLE Cuenta(
       id_cliente INT AUTO_INCREMENT,
       monto FLOAT not null DEFAULT 0,
       
       PRIMARY KEY(id_cliente)
);

INSERT INTO Cuenta(monto) VALUES (500.43);
INSERT INTO Cuenta(monto) VALUES (53.43);

delimiter //
CREATE PROCEDURE transferencia(IN idCuentaEnvia int, IN idCuentaRecibe int, IN pMonto float)
proc_label:BEGIN
	DECLARE montoFinalEnvia float DEFAULT 0;
	DECLARE montoFinalRecibe float DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	  rollback;
	  SELECT 'Error en transaction' AS message;
	END;
	
	START TRANSACTION;
	  IF pMonto <= 0 THEN
	     Select 'Transferencia negativa o nula' AS message;
	     commit;
	     LEAVE proc_label;
	  END IF;
	   
	  Select c.monto INTO montoFinalEnvia
   	  From Cuenta c
	  Where c.id_cliente = idCuentaEnvia;

	  IF montoFinalEnvia - pMonto < 0 THEN
	     Select 'Monto insuficiente' AS message;
	     commit;
	     LEAVE proc_label;
	  END IF;
	  
	  UPDATE Cuenta
	  SET monto = montoFinalEnvia - pMonto
	  WHERE id_cliente = idCuentaEnvia;

	  Select c.monto INTO montoFinalRecibe
	  From Cuenta c
	  Where c.id_cliente = idCuentaRecibe;
	  
	  UPDATE Cuenta
	  SET monto = montoFinalRecibe + pMonto
	  WHERE id_cliente = idCuentaRecibe;

	  commit;
END//
delimiter ;

CREATE TABLE Datos(
       id int auto_increment,
       apellido varchar(50) not null,
       nombre varchar(50) not null,
       saldo float not null,
       mail varchar(50) not null unique,

       PRIMARY KEY(id)
);

CREATE TABLE log_datos(
       id_cambio int auto_increment,
       id int not null,
       apellido varchar(50) not null,
       nombre varchar(50) not null,
       saldo float not null,
       mail varchar(50) not null,
       operacion varchar(2) CHECK(operacion = 'I' OR operacion = 'U' OR operacion = 'D'),

       PRIMARY KEY(id_cambio)
);

delimiter //
CREATE TRIGGER tr_datos_insert
AFTER INSERT ON Datos
FOR EACH ROW
BEGIN
	INSERT INTO log_datos(id, apellido, nombre, saldo, mail, operacion)
	VALUES(NEW.id, NEW.apellido, NEW.nombre, NEW.saldo, NEW.mail, 'I');
END//
delimiter ; 

delimiter //
CREATE PROCEDURE cargarDato(IN pApellido varchar(50), IN pNombre varchar(50), IN pSaldo float, IN pMail varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	  rollback;
	  Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	  INSERT INTO Datos(apellido, nombre, saldo, mail)
	  VALUES(pApellido, pNombre, pSaldo, pMail);
	  commit;
END//
delimiter ;

delimiter //
CREATE TRIGGER tr_datos_update
AFTER UPDATE ON Datos
FOR EACH ROW
BEGIN
	INSERT INTO log_datos(id, apellido, nombre, saldo, mail, operacion)
	VALUES(NEW.id, NEW.apellido, NEW.nombre, NEW.saldo, NEW.mail, 'U');
END//
delimiter ;

delimiter //
CREATE PROCEDURE cambiarDatoApellido(IN pId int, IN pApellido varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 UPDATE Datos
	 SET apellido = pApellido
	 WHERE id = pId;
	 commit;
END//
delimiter ;

delimiter //
CREATE PROCEDURE cambiarDatoNombre(IN pId int, IN pNombre varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 UPDATE Datos
	 SET nombre = pNombre
	 WHERE id = pId;
	 commit;
END//
delimiter ;

delimiter //
CREATE PROCEDURE cambiarDatoSaldo(IN pId int, IN pSaldo float)
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 UPDATE Datos
	 SET saldo = pSaldo
	 WHERE id = pId;
	 commit;
END//
delimiter ;

delimiter //
CREATE TRIGGER tr_datos_delete
AFTER DELETE ON Datos
FOR EACH ROW
BEGIN
	INSERT INTO log_datos(id, apellido, nombre, saldo, mail, operacion)
	VALUES(OLD.id, OLD.apellido, OLD.nombre, OLD.saldo, OLD.mail, 'D');
END//
delimiter ;

delimiter //
CREATE PROCEDURE borrarDato(IN pId int)
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 DELETE FROM Datos
	 WHERE id = pId;
	 commit;
END//
delimiter ;

CREATE TABLE socio(
       id int auto_increment,
       apellido varchar(50) not null,
       nombre varchar(50) not null,
       fechaingreso date not null DEFAULT CURDATE(),
       actividad varchar(50) not null CHECK(actividad = 'Fútbol' OR actividad = 'Tenis' OR actividad = 'Natación'),
       estado varchar(50) not null CHECK(estado = 'Activo' OR estado = 'Pasivo'),
       saldo float not null DEFAULT 0,

       PRIMARY KEY(id)
);

CREATE TABLE cuotas(
       id_cuota int auto_increment,
       cuota int CHECK(cuota > 0 AND cuota < 13),
       monto float CHECK(monto > 0),
       estado varchar(50) DEFAULT 'No abonado' CHECK(estado = 'Abonado' OR estado = 'No abonado' OR estado = 'Cancelada'),
       id_socio int not null,
       
       FOREIGN KEY(id_socio) REFERENCES socio(id),
       PRIMARY KEY(id_cuota)
);

delimiter //
CREATE TRIGGER tr_socio_insert
AFTER INSERT ON socio
FOR EACH ROW
BEGIN
	DECLARE i INT DEFAULT 1;
	loop_label:loop
	  INSERT INTO cuotas(cuota, monto, id_socio)
	  VALUES (i, 100, NEW.id);
	  SET i = i + 1;
	  IF i > 12 THEN
	     LEAVE loop_label;
	  END IF;
	END loop;
END//
delimiter ;

delimiter //
CREATE PROCEDURE cargarSocio(IN pApellido varchar(50), IN pNombre varchar(50), IN pFechaIngreso date, IN pActividad varchar(50), IN pEstado varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	  rollback;
	  Select 'Error en transaction' as MeSSAge;
	END;
	START TRANSACTION;
	  INSERT INTO socio(apellido, nombre, fechaingreso, actividad, estado)
	  VALUES (pApellido, pNombre, pFechaIngreso, pActividad, pEstado);
	  COMMIT;
END//
delimiter ;

delimiter //
CREATE PROCEDURE cambiarSocioApellido(IN pId int, IN pApellido varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 UPDATE socio
	 SET apellido = pApellido
	 WHERE id = pId;
	 commit;
END//
delimiter ;

delimiter //
CREATE PROCEDURE cambiarSocioNombre(IN pId int, IN pNombre varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 UPDATE socio
	 SET nombre = pNombre
	 WHERE id = pId;
	 commit;
END//
delimiter ;

● Crear un procedimiento que permita actualizar estado de socio. Si pasa a
Pasivo, cancelar todas las cuotas relacionadas.
● Crear un procedimiento que permita actualizar cuota como pagada y
descontar del saldo del socio.

delimiter //
CREATE PROCEDURE cambiarSocioEstado(IN pId int, IN pEstado varchar(50))
proc_label:BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	 ROLLBACK;
	 Select 'Error en transaction' AS message;
	END;

	START TRANSACTION;
	 IF pEstado != 'Activo' AND pEstado != 'Pasivo' THEN
	   Select 'Estado inválido' as Message;
	   commit;
	   LEAVE proc_label;
	 END IF;
	
	 UPDATE socio
	 SET estado = pEstado
	 WHERE id = pId;

	 IF pEstado = 'Pasivo' THEN
	  UPDATE cuotas
	  SET estado = 'Cancelada'
	  WHERE id_socio = pId AND estado != 'Abonado';
	 END IF;
	 commit;
END//
delimiter ;
