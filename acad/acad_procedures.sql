USE acad;

delimiter //
CREATE PROCEDURE contarAlumnos()
BEGIN
	select count(*)
	from Alumno;
END//
delimiter ;

-- Cargar carrera
delimiter //
CREATE PROCEDURE cargarCarrera(IN pNombre varchar(50), IN pTitulo varchar(50), IN pNombreFacultad varchar(50))
proc_label:BEGIN

	DECLARE tempCarrera INT DEFAULT 0;
	DECLARE tempTitulo INT DEFAULT 0;
	DECLARE tempFacultad INT DEFAULT 0;
	DECLARE idFacultad INT DEFAULT 0;
	DECLARE idCarrera INT DEFAULT 0;



	SELECT count(*) INTO tempFacultad
	FROM Facultad f
	WHERE f.nombre = pNombreFacultad;

	IF tempFacultad = 0 THEN
	   Select 'No existe esa facultad';
	   LEAVE proc_label;
	END IF;

	SELECT count(*) INTO tempCarrera 
	FROM Carrera c
	WHERE c.nombre = pNombre;

	SELECT count(*) INTO tempTitulo 
	FROM Carrera c
	WHERE c.titulo = pTitulo;
	
	IF tempCarrera > 0 OR tempTitulo > 0 THEN
	   Select 'Ya existe';
	ELSE
	   INSERT INTO Carrera (nombre, titulo)
	   VALUES (pNombre, pTitulo);

	   SELECT id_facultad INTO idFacultad
	   FROM Facultad f
	   WHERE f.nombre = pNombreFacultad;

	   SELECT id_carrera INTO idCarrera
	   FROM Carrera c
	   WHERE c.nombre = pNombre;

	   INSERT INTO Carrera_facultad (id_carrera, id_facultad)
	   VALUES (idCarrera, idFacultad);

	   SELECT * FROM Carrera;
	END IF;
END//
delimiter ;

-- Cargar plan de una carrera
delimiter //
CREATE PROCEDURE cargarPlanDeEstudio(IN pAño int, IN pNombreCarrera varchar(50))
proc_label:BEGIN

	DECLARE tempPlan INT DEFAULT 0;
	DECLARE idCarrera INT DEFAULT 0;

	SELECT id_carrera INTO idCarrera
	FROM Carrera c
	WHERE c.nombre = pNombreCarrera;

	IF idCarrera = 0 THEN
	   Select 'No existe esa carrera';
	   LEAVE proc_label;
	END IF;

	SELECT count(*) INTO tempPlan
	FROM Plan_de_estudio pe
	WHERE pe.año = pAño AND id_carrera = idCarrera;

	IF tempPlan > 0 THEN
	   Select 'Ya esta';
	ELSE
	   INSERT INTO Plan_de_estudio (año, id_carrera)
	   VALUES(pAño , idCarrera);
	END IF;
END//
delimiter ;

--Carga de Materias en un plan de carrera
delimiter //
CREATE PROCEDURE cargarPlanMateria(IN pAño int, IN pNombreCarrera varchar(50), IN pNombreMateria varchar(50), IN pJefeCatedraDNI int)
proc_label:BEGIN
	DECLARE idPlanMateria INT DEFAULT 0; --Buscar plan de estudio con nombre de carrera y año
	DECLARE idMateria INT DEFAULT 0; --Buscar materia con el nombre de materia
	DECLARE idJefeCatedra INT DEFAULT 0; --Buscar Profesor con el DNI
	DECLARE tempPlan INT DEFAULT 0; --Checkear que el plan ya no exista
	
	
END//
delimiter ;

--Matricula de un Alumno
delimiter //
Create PROCEDURE matricularAlumno(IN pDniAlumno int ,pIdPlan int )
proc_label:BEGIN 
  
