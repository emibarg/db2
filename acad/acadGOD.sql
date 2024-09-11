Drop schema acad;
Create schema acad;
Use acad;

CREATE TABLE Persona (
  id_persona int not null AUTO_INCREMENT,
  dni int not null,
  nombre varchar(50) not null,
  apellido varchar(50) not null,
  fecha_nacimiento date not null,
  direccion varchar(50) not null,
  mail varchar(50) not null,
  telefono varchar(50) not null,

  PRIMARY KEY(id_persona)

);

CREATE TABLE Alumno (
  id_alumno int not null AUTO_INCREMENT,
  id_persona int not null,
  PRIMARY KEY(id_alumno),
  FOREIGN KEY(id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE Profesor (

  id_profesor int not null AUTO_INCREMENT, 
  sueldo int not null CHECK ( sueldo>0 ),
  id_persona int not null,
  PRIMARY KEY(id_profesor),
  FOREIGN KEY(id_persona) REFERENCES Persona(id_persona)
);

CREATE TABLE Carrera (
  id_carrera int not null AUTO_INCREMENT,
  nombre varchar(50) not null unique,
  titulo varchar(50) not null unique,
  PRIMARY KEY(id_carrera)
);

CREATE TABLE Plan_de_estudio (
  id_plan_de_estudio int not null AUTO_INCREMENT,
  año int not null,
  id_carrera int not null,
  PRIMARY KEY(id_plan_de_estudio),
  FOREIGN KEY(id_carrera) REFERENCES Carrera(id_carrera)
);

CREATE TABLE Alumno_plan (
  id_alumno int not null,
  id_plan_de_estudio int not null,
  fecha_matriculacion date not null,
  condicion varchar(50) not null,
  PRIMARY KEY(id_plan_de_estudio,id_alumno),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_plan_de_estudio) REFERENCES Plan_de_estudio(id_plan_de_estudio)

);

CREATE TABLE Facultad (
  id_facultad int not null AUTO_INCREMENT,
  nombre varchar(50) not null unique,
  direccion varchar(100) not null unique,
  PRIMARY KEY(id_facultad)
);

CREATE TABLE Carrera_facultad (
  id_carrera int not null,
  id_facultad int not null,

  PRIMARY KEY(id_facultad,id_carrera),
  FOREIGN KEY(id_carrera) REFERENCES Carrera(id_carrera),
  FOREIGN KEY(id_facultad) REFERENCES Facultad(id_facultad)

);

CREATE TABLE Aula  (
  id_aula int not null AUTO_INCREMENT,
  nombre varchar(50) not null unique,
  capacidad int not null,
  extras varchar(100),
  id_facultad int not null,
  PRIMARY KEY(id_aula),
  FOREIGN KEY(id_facultad) REFERENCES Facultad(id_facultad)

);

CREATE TABLE Materia (
  id_materia int not null AUTO_INCREMENT,
  nombre varchar(50) not null unique,
  PRIMARY KEY(id_materia)
);

CREATE TABLE Plan_materia (
  id_plan_materia int not null AUTO_INCREMENT,
  id_plan_de_estudio int not null,
  id_materia int not null,
  id_jefe_catedra int not null,
  año int not null,
  PRIMARY KEY(id_plan_materia),
  FOREIGN KEY(id_plan_de_estudio) REFERENCES Plan_de_estudio(id_plan_de_estudio),
  FOREIGN KEY(id_materia) REFERENCES Materia(id_materia),
  FOREIGN KEY(id_jefe_catedra) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Cursada (
  id_cursada int not null AUTO_INCREMENT,
  año_cursada int not null,
  cuatrimestre int not null CHECK ( cuatrimestre>0 && cuatrimestre<3 ),
  id_plan_materia int not null,
  PRIMARY KEY(id_cursada),
  FOREIGN KEY(id_plan_materia) REFERENCES Plan_materia(id_plan_materia)
);

CREATE TABLE Comision (
  id_comision int not null AUTO_INCREMENT,
  nombre varchar(50) not null,
  id_cursada int not null,
  id_aula int not null,
  PRIMARY KEY(id_comision),
  FOREIGN KEY(id_cursada) REFERENCES Cursada(id_cursada),
  FOREIGN KEY(id_aula) REFERENCES Aula(id_aula)
);

CREATE TABLE Alumno_comision (
  id_alumno int not null,
  id_comision int not null,
  fecha_inscripcion date not null,
  estado_inscripcion varchar(50) not null,
  fecha_estado date not null,
  PRIMARY KEY(id_alumno, id_comision),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_comision) REFERENCES Comision(id_comision)
);

CREATE TABLE Ayudante_de_catedra (
  id_ayudante int not null,
  id_comision int not null,
  PRIMARY KEY(id_ayudante,id_comision),
  FOREIGN KEY(id_ayudante) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_comision) REFERENCES Comision(id_comision)
);

CREATE TABLE Profesor_comision (
  id_profesor int not null,
  id_comision int not null,
  PRIMARY KEY(id_comision,id_profesor),
  FOREIGN KEY(id_profesor) REFERENCES Profesor(id_profesor),
  FOREIGN KEY(id_comision) REFERENCES Comision(id_comision)
);

CREATE TABLE Encuesta (
  id_encuesta int not null AUTO_INCREMENT, 
  comentario varchar(50),
  rating int CHECK ( rating >0 && rating<6 ),
  id_cursada int not null,
  id_alumno int not null,
  id_profesor int not null,

  PRIMARY KEY(id_encuesta),
  FOREIGN KEY(id_cursada) REFERENCES Cursada(id_cursada),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Turno_examen (
  id_turno_examen int not null AUTO_INCREMENT,
  fecha_examen date not null,
  id_materia int not null,
  PRIMARY KEY(id_turno_examen),
  FOREIGN KEY(id_materia) REFERENCES Materia(id_materia)
);

CREATE TABLE Inscripcion_examen (
  id_inscripcion int not null AUTO_INCREMENT,
  id_turno_examen int not null,
  id_alumno int not null,
  fecha_inscripcion date not null,
  nota varchar(10),
  PRIMARY KEY(id_inscripcion),
  FOREIGN KEY(id_turno_examen) REFERENCES Turno_examen(id_turno_examen),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno)
);

CREATE TABLE Parcial (
  id_parcial int not null AUTO_INCREMENT,
  id_alumno int not null,
  id_cursada int not null,
  fecha date not null,
  nota int not null CHECK ( nota>1 && nota<11 ),
  PRIMARY KEY(id_parcial),
  FOREIGN KEY(id_alumno) REFERENCES Alumno(id_alumno),
  FOREIGN KEY(id_cursada) REFERENCES Cursada(id_cursada)
);








