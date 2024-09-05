INSERT INTO Facultad (id_facultad, nombre, direccion)
VALUES (, '', '');

INSERT INTO Facultad_carrera (id_carrera, id,facultad)
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

INSERT INTO Alumno_plan (id_alumno, id_plan_estudio, fecha_matriculacion, condicion)
VALUES(, , '', '');

INSERT INTO Plan_estudio (id_plan_estudio, año, id_carrera)
VALUES(, , );

INSERT INTO Plan_materia (id_plan_materia, id_plan_estudio, id_materia, id_jefe_catedra, año)
VALUES(, , , , );

INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(, , , );

INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(, , '', );

INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(, , '', '', '');

INSERT INTO Ayudante_comision (id_comision, id_ayudante)
VALUES(, );

INSERT INTO Profesor_comision (id_comision, id_profesor)
VALUES(, );

INSERT INTO Parcial (id_parcial, id_alumno, id_cursada, fecha, nota)
VALUES(, , , '', );

INSERT INTO Turno_examen (id_turno, id_materia, fecha_examen)
VALUES(, , '');

INSERT INTO Inscripcion_examen (id_inscripcion, id_turno, id_alumno, fecha_inscripcion, nota)
VALUES(, , , '', '');

INSERT INTO Encuesta (id_encuesta, id_cursada, id_alumno, id_profesor, rating, comentario)
VALUES(, , , , , '');

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE Facultad
SET id_facultad = , nombre = '', direccion = ''
WHERE ;

UPDATE Facultad_carrera
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

INSERT INTO Profesor (id_profesor, id_persona, sueldo)
VALUES(, , );

INSERT INTO Alumno (id_alumno, id_persona)
VALUES(, );

INSERT INTO Alumno_plan (id_alumno, id_plan_estudio, fecha_matriculacion, condicion)
VALUES(, , '', '');

INSERT INTO Plan_estudio (id_plan_estudio, año, id_carrera)
VALUES(, , );

INSERT INTO Plan_materia (id_plan_materia, id_plan_estudio, id_materia, id_jefe_catedra, año)
VALUES(, , , , );

INSERT INTO Cursada (id_cursada, id_plan_materia, año_cursada, cuatrimestre)
VALUES(, , , );

INSERT INTO Comision (id_comision, id_cursada, nombre, id_aula)
VALUES(, , '', );

INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
VALUES(, , '', '', '');

INSERT INTO Ayudante_comision (id_comision, id_ayudante)
VALUES(, );

INSERT INTO Profesor_comision (id_comision, id_profesor)
VALUES(, );

INSERT INTO Parcial (id_parcial, id_alumno, id_cursada, fecha, nota)
VALUES(, , , '', );

INSERT INTO Turno_examen (id_turno, id_materia, fecha_examen)
VALUES(, , '');

INSERT INTO Inscripcion_examen (id_inscripcion, id_turno, id_alumno, fecha_inscripcion, nota)
VALUES(, , , '', '');

INSERT INTO Encuesta (id_encuesta, id_cursada, id_alumno, id_profesor, rating, comentario)
VALUES(, , , , , '');
