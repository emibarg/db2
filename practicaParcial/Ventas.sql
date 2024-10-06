DROP DATABASE Ventas;




CREATE DATABASE Ventas;

USE Ventas;

CREATE TABLE Clientes (
  idCliente int AUTO_INCREMENT not null,
  Empresa varchar(50) not null,
  Acumulado float default  0,

  PRIMARY KEY(idCliente)
);

CREATE TABLE Productos (
  idProducto int AUTO_INCREMENT not null,
  Descripcion varchar(100) not null,

  PRIMARY KEY(idProducto)

);

CREATE TABLE Ventas (
  idVenta int AUTO_INCREMENT not null,
  Fecha date not null,
  Producto int not null,
  Monto float not null,
  Cliente int not null,

  PRIMARY KEY(idVenta),
  FOREIGN KEY(Producto) REFERENCES Productos(idProducto),
  FOREIGN KEY(Cliente) REFERENCES Clientes(idCliente)
);


delimiter //
CREATE PROCEDURE cargarCliente(IN pEmpresa varchar(50))
proc_label:BEGIN

DECLARE tempEmpresa int default 0;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN 
  rollback;
  SELECT 'Error in transaction' AS Message;
END;

START TRANSACTION;



SELECT idCliente into tempEmpresa FROM Clientes WHERE Empresa = pEmpresa ;


IF tempEmpresa > 0 THEN
  SELECT 'El cliente ya fue cargado anteriormente';
  rollback;
  LEAVE proc_label;
END IF;

INSERT INTO Clientes (
  Empresa
) VALUES ( pEmpresa );

END//

delimiter ;

delimiter //
CREATE PROCEDURE cargarProducto(IN pDescripcion varchar(100))
proc_label:BEGIN
DECLARE tempProducto int default 0;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN 
  rollback;
  SELECT 'Error in transaction' AS Message;
END;





START TRANSACTION;
SELECT idProducto into tempProducto FROM Productos WHERE Descripcion = pDescripcion;


IF tempProducto > 0 THEN
  SELECT 'El Producto ya fue cargado anteriormente';
  rollback;
  LEAVE proc_label;
END IF;

INSERT INTO Productos (
  Descripcion
) VALUES ( pDescripcion );

END//

delimiter ;


delimiter //
CREATE PROCEDURE cargarVenta(IN pDate varchar(15), IN pProducto int, IN pMonto float, IN pCliente int)
proc_label:BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
  rollback;
  SELECT 'Error in transaction' AS message;
END;

START TRANSACTION;
IF pMonto< 0 THEN
  SELECT 'monto menor a 0';
  rollback;
  LEAVE proc_label;
END IF;

INSERT INTO Ventas (
  Fecha, Producto, Monto, Cliente
) VALUES ( pDate, pProducto, pMonto,pCliente );
END//

delimiter ;

delimiter //

CREATE TRIGGER tr_venta_insert
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
  UPDATE Clientes c set c.Acumulado = (c.Acumulado + new.Monto) WHERE c.idCliente = new.Cliente;
END //

delimiter ; 

SELECT c.Empresa, p.idProducto, count(*) as Cantidad
FROM Clientes c JOIN Ventas v ON c.idCliente = v.Cliente JOIN Productos p ON p.idProducto = v.Producto
GROUP BY c.idCliente, p.idProducto;

