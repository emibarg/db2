INSERT INTO Facultad (id_facultad, nombre, direccion)
VALUES (, '', '');

INSERT INTO Carrera_facultad (id_carrera, id,facultad)
VALUES (, );

INSERT INTO Aula (id_aula, id_facultad, nombre, capacidad, extras)
VALUES (, , '', ,'');

INSERT INTO Carrera (id_carrera, nombre, titulo)
VALUES (, '', '');

INSERT INTO Materia (id_materia, nombre)
VALUES(, '');

INSERT INTO Persona (id_persona, nombre, apellido, dni, fecha_nacimiento, direccion, mail, telefono)
VALUES(, '', '', , '', '', '', '');

INSERT INTO Profesor (id_profesor, id_persona, sueldo)
VALUES(, , );

INSERT INTO Alumno (id_alumno, id_persona)
VALUES(, );

INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
VALUES(, , '', '');

INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera)
VALUES(, , );

INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(, , , , );

INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(, , , );

INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(, , '', );

INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(, , '', '', '');

INSERT INTO Ayudante_de_catedra (id_comision, id_ayudante)
VALUES(, );

INSERT INTO Profesor_comision (id_comision, id_profesor)
VALUES(, );

INSERT INTO Parcial (id_parcial, id_alumno, id_cursada, fecha, nota)
VALUES(, , , '', );

INSERT INTO Turno_examen (id_turno_examen, id_materia, fecha_examen)
VALUES(, , '');

INSERT INTO Inscripcion_examen (id_inscripcion, id_turno_examen, id_alumno, fecha_inscripcion, nota)
VALUES(, , , '', '');

INSERT INTO Encuesta (id_encuesta, id_cursada, id_alumno, id_profesor, rating, comentario)
VALUES(, , , , , '');

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE Facultad
SET id_facultad = , nombre = '', direccion = ''
WHERE ;

UPDATE Carrera_facultad
SET id_carrera =, id,facultad =
WHERE ;

UPDATE Aula
SET id_aula =, id_facultad =, nombre = '', capacidad =, extras = ''
WHERE ;

UPDATE Carrera
SET id_carrera =, nombre = '', titulo = ''
WHERE ;

UPDATE Materia
SET id_materia =, nombre = ''
WHERE ;

UPDATE Persona
SET id_persona = , nombre = '', apellido = '', dni = , fecha_nacimiento = '', direccion = '', mail = '', telefono = ''
WHERE;

UPDATE Profesor
SET id_profesor = , id_persona = , sueldo = 
WHERE ;

UPDATE Alumno
SET id_alumno = , id_persona =
WHERE ;

UPDATE Alumno_plan
SET id_alumno = , id_plan_de_estudio = , fecha_matriculacion = '', condicion = ''
WHERE ;

UPDATE Plan_de_estudio
SET id_plan_de_estudio = , año = , id_carrera = 
WHERE ;

UPDATE Plan_materia
SET id_plan_materia = , id_plan_de_estudio = , id_materia = , id_jefe_catedra =, año = 
WHERE ;

UPDATE Cursada
SET id_cursada = , id_plan_materia =, año_cursada =, cuatrimestre = 

UPDATE Comision
SET id_comision = , id_cursada = , nombre = '', id_aula =
WHERE ;

UPDATE Alumno_comision
SET id_comision = , id_alumno = , fecha_inscripcion = '', estado_inscripcion = '', fecha_estado = ''
WHERE ;

UPDATE Ayudante_de_catedra
SET id_comision = , id_ayudante =
WHERE ;

UPDATE Profesor_comision
SET id_comision = , id_profesor =
WHERE ;

UPDATE Parcial
SET id_parcial = , id_alumno = , id_cursada =, fecha = '', nota =
WHERE ;

UPDATE Turno_examen
SET id_turno_examen = , id_materia = , fecha_examen = ''
WHERE ;

UPDATE Inscripcion_examen
SET id_inscripcion = , id_turno_examen = , id_alumno = , fecha_inscripcion = '', nota = ''
WHERE ;

UPDATE Encuesta
SET id_encuesta = , id_cursada = , id_alumno = , id_profesor = , rating = , comentario = ''
WHERE ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Carrera (id_carrera, nombre, titulo)
VALUES (3, 'Ingeniería en Computación', 'Ingeniero en Computación');

INSERT INTO Carrera_facultad (id_carrera, id,facultad)
VALUES (3, 1);

INSERT INTO Carrera (id_carrera, nombre, titulo)
VALUES (4, 'Licenciatura en Bioinformática', 'Licenciado en Bioinformática');

INSERT INTO Carrera_facultad (id_carrera, id,facultad)
VALUES (4, 1);





INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera)
VALUES(3, 2016, 3);
INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera)
VALUES(4, 2024, 3);

INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera)
VALUES(5, 2020, 4);
INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera)
VALUES(6, 2024, 4);

INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera)
VALUES(7, 2016, 1);





INSERT INTO Materia (id_materia, nombre)
VALUES(3, 'Tecnicas Digitales');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(3, 3, 3, 1, 2018);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(4, 4, 3, 1, 2024);
INSERT INTO Materia (id_materia, nombre)
VALUES(4, 'Ingenieria de Software');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(5, 3, 4, 1, 2014);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(6, 4, 4, 1, 2024);
INSERT INTO Materia (id_materia, nombre)
VALUES(5, 'Electronica Fisica');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(7, 3, 5, 1, 2004);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(8, 4, 5, 1, 2024);

INSERT INTO Materia (id_materia, nombre)
VALUES(6, 'Quimica Organica');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(9, 5, 6, 1, 2020);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(10, 6, 6, 1, 2024);
INSERT INTO Materia (id_materia, nombre)
VALUES(7, 'Economia');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(11, 5, 7, 1, 2021);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(12, 6, 7, 1, 2023);
INSERT INTO Materia (id_materia, nombre)
VALUES(8, 'Pensamiento Teologico');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(13, 5, 8, 1, 2021);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(14, 6, 8, 1, 2024);

INSERT INTO Materia (id_materia, nombre)
VALUES(9, 'Arquitectura de Software II');
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(15, 7, 9, 1, 2017);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(16, 1, 9, 1, 2024);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(17, 7, 2, 1, 2017);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(18, 1, 2, 1, 2024);
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año)
VALUES(19, 7, 1, 1, 2017);


// CREAR ALUMNOS, INSCRIBIRLOS A UN PLAN DE UNA CARRERA E INSCRIBIRLOS A TODAS LAS MATERIAS DEL PLAN.

INSERT INTO Persona (id_persona, nombre, apellido, dni, fecha_nacimiento, direccion, mail, telefono)
VALUES(4, 'Pedro', 'Drucard', 4343112, '2002-01-12', 'Calle Real 312', 'pedro.drucard@mail.com', '298-2344221');
INSERT INTO Alumno (id_alumno, id_persona)
VALUES(3, 4);
INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
VALUES(3, 3, '2022-06-06', 'Cursando');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(3, 3, 2024, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(3, 3, 'Comision A', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(3, 3, '2022-06-06', 'Inscripto', '2022-06-06');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(4, 5, 2024, 2);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(4, 4, 'Comision A1', 2);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(4, 3, '2022-09-08', 'Cancelada', '2022-09-09');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(5, 7, 2024, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(5, 5, 'Comision A', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(5, 3, '2022-01-12', 'Cursando', '2022-02-12');

INSERT INTO Persona (id_persona, nombre, apellido, dni, fecha_nacimiento, direccion, mail, telefono)
VALUES(5, 'Alejandra', 'Guerrero', 3344112, '2003-04-01', 'Calle Realeza 329', 'alejandra.guerrero@mail.com', '376 4433112');
INSERT INTO Alumno (id_alumno, id_persona)
VALUES(4, 5);
INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
VALUES(4, 4, '2024-01-01', 'Cursando');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(6, 4, 2024, 2);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(6, 6, 'Comision C', 2);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(6, 4, '2024-07-02', 'Inscripto', '2024-07-07');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(7, 6, 2024, 2);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(7, 7, 'Comision B2', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(7, 4, '2024-07-02', 'Inscripto', '2024-07-07');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(8, 8, 2024, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(8, 8, 'Comision A', 2);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(8, 4, '2024-03-01', 'Inscripto', '2024-03-01');

INSERT INTO Persona (id_persona, nombre, apellido, dni, fecha_nacimiento, direccion, mail, telefono)
VALUES(6, 'Fernando', 'Altamirano', 441232, '2003-01-04', 'Calle Ratrue 31', 'fernando.altamirano@mail.com', '351 5423312');
INSERT INTO Alumno (id_alumno, id_persona)
VALUES(5, 6);
INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
VALUES(5, 5, '2020-01-01', 'Cursando');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(9, 9, 2020, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(9, 9, 'Comision C2', 2);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(9, 5, '2020-03-03', 'Inscripto', '2020-03-03');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(10, 11, 2020, 2);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(10, 10, 'Comision A1', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(10, 5, '2020-03-04', 'Cancelada', '2020-04-03');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(11, 13, 2020, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(11, 11, 'Comision B1', 2);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(11, 5, '2020-03-02', 'Inscripto', '2020-03-03');

INSERT INTO Persona (id_persona, nombre, apellido, dni, fecha_nacimiento, direccion, mail, telefono)
VALUES(7, 'Hector', 'Martinez', 43332112, '2002-10-10', 'Calle Salvador 444', 'hector.martinez@mail.com', '351 4332211');
INSERT INTO Alumno (id_alumno, id_persona)
VALUES(6, 7);
INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
VALUES(6, 6, '2024-01-01', 'Cursando');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(12, 10, 2024, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(12, 12, 'Comision A', 2);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(12, 6, '2024-01-02', 'Inscripto', '2024-01-03');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(13, 12, 2024, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(13, 13, 'Comision C1', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(13, 6, '2024-01-01', 'Inscripto', '2024-01-02');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(14, 14, 2024, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(14, 14, 'Comision B3', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(14, 6, '2024-01-01', 'Inscripto', '2024-01-03');

INSERT INTO Persona (id_persona, nombre, apellido, dni, fecha_nacimiento, direccion, mail, telefono)
VALUES(8, 'Agustin', 'Leonardo', 43123321, '2003-02-10', 'Calle San Martin 542', 'agustin.leonardo@mail.com', '351 5632321');
INSERT INTO Alumno (id_alumno, id_persona)
VALUES(7, 8);
INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
VALUES(7, 7, '2018-03-03', 'Cursando');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(15, 15, 2020, 2);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(15, 15, 'Comision F5', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(15, 7, '2020-01-01', 'Inscripto', '2020-01-01');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(16, 17, 2020, 2);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(16, 16, 'Comision G9', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(16, 7, '2020-02-02', 'Inscripto', '2020-02-03');
INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(17, 19, 2020, 1);
INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(17, 17, 'Comision L8', 1);
INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(17, 7, '2020-02-03', 'Inscripto', '2020-02-03');



