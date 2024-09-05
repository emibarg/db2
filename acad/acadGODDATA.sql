-- Insertar datos en la tabla Persona
INSERT INTO Persona (id_persona, dni, nombre, apellido, fecha_nacimiento, direccion, mail, telefono) VALUES
(1, 12345678, 'Juan', 'De Giovanni', '1990-05-14', 'Calle Falsa 123', 'juan.perez@mail.com', '1234567890'),
(2, 23456789, 'María', 'García', '1988-08-23', 'Avenida Siempreviva 456', 'maria.garcia@mail.com', '0987654321'),
(3, 34567890, 'Julio Marcelo', 'Gutierrez', '1975-12-03', 'Calle Luna 789', 'julio.Gutierrez@mail.com', '1122334455');

-- Insertar datos en la tabla Alumno
INSERT INTO Alumno (id_alumno, id_persona) VALUES
(1, 1),
(2, 2);

-- Insertar datos en la tabla Profesor
INSERT INTO Profesor (id_profesor, sueldo, id_persona) VALUES
(1, 50000, 3);

-- Insertar datos en la tabla Carrera
INSERT INTO Carrera (id_carrera, nombre, titulo) VALUES
(1, 'Ingeniería Informática', 'Ingeniero Informático'),
(2, 'Ingeniería Civil', 'Ingeniero Civil');

-- Insertar datos en la tabla Plan_de_estudio
INSERT INTO Plan_de_estudio (id_plan_de_estudio, año, id_carrera) VALUES
(1, 2023, 1),
(2, 2023, 2);

-- Insertar datos en la tabla Alumno_plan
INSERT INTO Alumno_plan (id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion) VALUES
(1, 1, '2023-02-15', 'Regular'),
(2, 2, '2023-02-15', 'Regular');

-- Insertar datos en la tabla Facultad
INSERT INTO Facultad (id_facultad, nombre, direccion) VALUES
(1, 'Facultad de Ingeniería', 'Av. Universitaria 1000'),
(2, 'Facultad de Ciencias Exactas', 'Av. Ciencia 2000');

-- Insertar datos en la tabla Carrera_facultad
INSERT INTO Carrera_facultad (id_carrera, id_facultad) VALUES
(1, 1),
(2, 2);

-- Insertar datos en la tabla Aula
INSERT INTO Aula (id_aula, nombre, capacidad, extras, id_facultad) VALUES
(1, 'Aula 101', 30, 'Proyector', 1),
(2, 'Aula 102', 40, 'Pizarra Electrónica', 2);

-- Insertar datos en la tabla Materia
INSERT INTO Materia (id_materia, nombre) VALUES
(1, 'Base De Datos II'),
(2, 'Programacion II');

-- Insertar datos en la tabla Plan_materia
INSERT INTO Plan_materia (id_plan_materia, id_plan_de_estudio, id_materia, id_jefe_catedra, año) VALUES
(1, 1, 1, 1, 2023),
(2, 2, 2, 1, 2023);

-- Insertar datos en la tabla Cursada
INSERT INTO Cursada (id_cursada, año_cursada, cuatrimestre, id_plan_materia) VALUES
(1, 2023, 1, 1),
(2, 2023, 2, 2);

-- Insertar datos en la tabla Comision
INSERT INTO Comision (id_comision, nombre, id_cursada, id_aula) VALUES
(1, 'Comisión A', 1, 1),
(2, 'Comisión B', 2, 2);

-- Insertar datos en la tabla Alumno_comision
INSERT INTO Alumno_comision (id_alumno, id_comision, fecha_inscripcion, estado_inscripcion, fecha_estado) VALUES
(1, 1, '2023-03-01', 'Inscripto', '2023-03-02'),
(2, 2, '2023-03-01', 'Inscripto', '2023-03-02');

-- Insertar datos en la tabla Ayudante_de_catedra
INSERT INTO Ayudante_de_catedra (id_ayudante, id_comision) VALUES
(1, 1),
(1,2);

-- Insertar datos en la tabla Profesor_comision
INSERT INTO Profesor_comision (id_profesor, id_comision) VALUES
(1, 1),
(1, 2);

-- Insertar datos en la tabla Encuesta
INSERT INTO Encuesta (id_encuesta, comentario, rating, id_cursada, id_alumno, id_profesor) VALUES
(1, 'Buena cursada', 4, 1, 1, 1),
(2, 'Excelente curso', 5, 2, 2, 1);

-- Insertar datos en la tabla Turno_examen
INSERT INTO Turno_examen (id_turno_examen, fecha_examen, id_materia) VALUES
(1, '2023-07-10', 1),
(2, '2023-07-15', 2);

-- Insertar datos en la tabla Inscripcion_examen
INSERT INTO Inscripcion_examen (id_inscripcion, id_turno_examen, id_alumno, fecha_inscripcion, nota) VALUES
(1, 1, 1, '2023-06-20', '7'),
(2, 2, 2, '2023-06-21', '8');

-- Insertar datos en la tabla Parcial
INSERT INTO Parcial (id_parcial, id_alumno, id_cursada, fecha, nota) VALUES
(1, 1, 1, '2023-05-10', 6),
(2, 2, 2, '2023-05-11', 9);

