CREATE TABLE Clientes (
  codcli int,
  nomcli varchar(50) NOT NULL,
  provincia varchar(50) NOT NULL,

  PRIMARY KEY(codcli)

);

CREATE TABLE Productos (

  Codpro int,
  Nompro varchar(50) NOT NULL,
  Precio float NOT NULL CHECK ( Precio>0 ),
  Origen varchar(50) NOT NULL,

  PRIMARY KEY(Codpro)
);


CREATE TABLE Ventas (
  NumeroVenta int,
  codcli int NOT NULL,
  Codpro int NOT NULL,
  Fecha date NOT NULL,
  Cantidad int NOT NULL CHECK ( Cantidad>0 ),
  Precio float NOT NULL CHECK ( Precio>0 ),
  Total float NOT NULL CHECK ( Total >0 ),


  PRIMARY KEY(NumeroVenta),
  FOREIGN KEY(Codpro) REFERENCES Productos(Codpro),
  FOREIGN KEY(codcli) REFERENCES Clientes(codcli)



);
