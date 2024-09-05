CREATE TABLE Carrera (
  
  id_carrera int NOT NULL,
  nombre varchar(50) NOT NULL,
  titulo varchar(50) NOT NULL,

  



  PRIMARY KEY(id_carrera)
);

CREATE TABLE Materia (
  id_materia int NOT NULL,
  nombre varchar(50) NOT NULL,


  PRIMARY KEY(id_materia)
);




CREATE TABLE Alumno (
  id_alumno int NOT NULL,
  nombre varchar(50) NOT NULL,
  apellido varchar(50) NOT NULL,
  dni int NOT NULL,
  fecha_nacimiento date NOT NULL,
  

  PRIMARY KEY(id_alumno)
);

CREATE TABLE Alumno_carrera (
  id_alumno int,
  id_carrera int,
  fecha_matriculacion date NOT NULL,

  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_carrera) REFERENCES Carrera(id_carrera),

  PRIMARY KEY(id_alumno, id_carrera)
);

CREATE TABLE Inscripcion_materia (
  id_alumno int NOT NULL,
  id_materia int NOT NULL, 
  fecha_inscripcion date NOT NULL,
  estado_inscripcion BOOL NOT NULL,
  fecha_estado date NOT NULL,


  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_materia) REFERENCES Materia(id_materia),
  PRIMARY KEY(id_alumno, id_materia)
);
CREATE TABLE Plan_materia_carrera (
  id_plan int NOT NULL,
  año_cursada int NOT NULL,
  cuatrimestre int NOT NULL,
  id_carrera int NOT NULL,
  id_materia int NOT NULL,


  FOREIGN KEY (id_carrera) REFERENCES Carrera(id_carrera),
  FOREIGN KEY (id_materia) REFERENCES Materia(id_materia),
  PRIMARY KEY(id_plan)
);

CREATE TABLE Parcial (
  id_parcial int NOT NULL,
  id_alumno int NOT NULL,
  id_materia int NOT NULL,
  fecha date NOT NULL,
  nota int,

  PRIMARY KEY(id_parcial),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_materia) REFERENCES Materia(id_materia)

);
CREATE TABLE Turno_examen (
  id_turno int not null,
  id_alumno int not null, 
  id_materia int not null,
  fecha_inscripcion date not null,
  fecha_examen date not null,
  nota int, 
  PRIMARY KEY(id_turno),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_materia) REFERENCES Materia(id_materia)
);


