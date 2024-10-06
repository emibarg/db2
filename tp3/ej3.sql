CREATE TABLE socio (
  id int primary key AUTO_INCREMENT,
  apellido varchar(50),
  nombre varchar(50),
  fecha_ingreso date,
  actividad varchar(50),
  estado varchar(50)
);

CREATE TABLE cuotas (
 id_cuota int primary key AUTO_INCREMENT,
cuota int,
monto int,
id_socio int,
estado varchar(50));


delimiter //
CREATE TRIGGER cuotas
AFTER INSERT ON socio
FOR EACH ROW
BEGIN
    INSERT INTO cuotas(cuota,monto,id_socio,estado) values(1,100,NEW.id,'Pendiente');
     INSERT INTO cuotas(cuota,monto,id_socio,estado) values(2,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(3,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(4,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(5,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(6,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(7,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(8,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(9,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(10,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(11,100,NEW.id,'Pendiente');
 INSERT INTO cuotas(cuota,monto,id_socio,estado) values(12,100,NEW.id,'Pendiente');

END//
delimiter;

delimiter //

CREATE PROCEDURE cargarDatosSocio(IN pApellido varchar(50), IN pNombre varchar(50), IN pFechaIngreso DATE,IN pActividad varchar(50), IN pEstado varchar(50))
proc_label: BEGIN 

  DECLARE EXIT HANDLER FOR SQLEXCEPTION 
  BEGIN
      ROLLBACK;
      SELECT 'Error en transaccion' AS message;
  END;

  START TRANSACTION;

  -- Insert data into the Datos table
  INSERT INTO socio(apellido, nombre, fecha_ingreso,actividad, estado)
  VALUES (pApellido, pNombre, pFechaIngreso,pActividad, pEstado);

  COMMIT; -- Commit the transaction

  SELECT 'Datos insertados correctamente' AS message;

END
//
delimiter ;
