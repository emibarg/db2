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
	   Select * from Plan_de_estudio;
	END IF;
END//
delimiter ;

--Carga de Materias en un plan de carrera
delimiter //
CREATE PROCEDURE cargarPlanMateria(IN pAño int, IN pNombreCarrera varchar(50), IN pNombreMateria varchar(50), IN pJefeCatedraDNI int)
proc_label:BEGIN
	DECLARE idPlanDeEstudio INT DEFAULT 0; 
	DECLARE idMateria INT DEFAULT 0;
	DECLARE idJefeCatedra INT DEFAULT 0; 
	DECLARE tempPlan INT DEFAULT 0;

	DECLARE temp INT DEFAULT 0; 

	Select count(*) INTO temp
	From Materia ma
	Where ma.nombre = pNombreMateria;

	IF temp = 0 THEN
	   Select 'No existe esa materia';
	   LEAVE proc_label;
	END IF;


	Select count(*) INTO temp
	From Carrera c
	Where c.nombre = pNombreCarrera;

	IF temp = 0 THEN
	   Select 'No existe esa carrera';
	   LEAVE proc_label;
	END IF;


	Select count(*) INTO temp
	From Profesor p
	inner join Persona pe on pe.id_persona = p.id_persona
	Where pe.dni = pJefeCatedraDNI;

	IF temp = 0 THEN
	   Select 'No existe ese profesor';
	   LEAVE proc_label;
	END IF;


	Select ma.id_materia INTO idMateria
	From Materia ma
	Where ma.nombre = pNombreMateria;

	Select ple.id_plan_de_estudio INTO idPlanDeEstudio
	From Carrera c
	inner join Plan_de_estudio ple on c.id_carrera = ple.id_carrera
	Where c.nombre = pNombreCarrera
	AND  (ple.año-pAño) >= all(Select (ple2.año-pAño)
	From Plan_de_estudio ple2
	Where ple2.id_carrera = c.id_carrera);

	Select p.id_profesor INTO idJefeCatedra
	From Profesor p
	inner join Persona pe on pe.id_persona = p.id_persona
	Where pe.dni = pJefeCatedraDNI;


	Select count(*) INTO tempPlan
	From Plan_materia pm
	Where pm.id_plan_de_estudio = idPlanDeEstudio AND pm.id_materia = idMateria AND pm.id_jefe_catedra = idJefeCatedra AND pm.año = pAño;

	IF tempPlan > 0 THEN
	   Select 'Ya existe esa materia en ese plan';
	   LEAVE proc_label;
	ELSE
	   INSERT INTO Plan_materia (id_plan_de_estudio, id_materia, id_jefe_catedra, año)
	   VALUES(idPlanDeEstudio, idMateria, idJefeCatedra, pAño);
	   Select * from Plan_materia;
	END IF;
	
	
END//
delimiter ;

--Matricula de un Alumno
delimiter //
Create PROCEDURE matricularAlumno(IN pDniAlumno int, IN pAñoPlan int, IN pNombreCarrera varchar(50) )
proc_label:BEGIN
	DECLARE idAlumno INT DEFAULT 0;
	DECLARE idPersona INT DEFAULT 0;
	DECLARE idPlanDeEstudio INT DEFAULT 0; 
	DECLARE tempMatricula INT DEFAULT 0;

	DECLARE temp INT DEFAULT 0;

	Select count(*) INTO temp
	From Persona p
	Where p.dni = pDniAlumno;

	IF temp = 0 THEN
	   Select 'No existe esa persona';
	   LEAVE proc_label;
	END IF;

	Select count(*) INTO temp
	From Carrera c
	Where c.nombre = pNombreCarrera;

	IF temp = 0 THEN
	   Select 'No existe esa carrera';
	   LEAVE proc_label;
	END IF;

	Select count(*) INTO temp
	From Plan_de_estudio ple inner join Carrera c on ple.id_carrera = c.id_carrera
	Where c.nombre = pNombreCarrera AND ple.año = pAñoPlan;

	IF temp = 0 THEN
	   Select 'No existe ese plan';
	   LEAVE proc_label;
	END IF;

	Select count(*) INTO temp
	From Alumno a inner join Persona p on p.id_persona = a.id_persona
	Where p.dni = pDniALumno;

	IF temp = 0 THEN
	   Select p.id_persona INTO idPersona
	   From Persona p 
	   Where p.dni = pDniAlumno;

	   INSERT INTO Alumno (id_persona)
	   VALUES(idPersona);
	END IF;

	Select a.id_alumno INTO idAlumno
	From Alumno a inner join Persona p on p.id_persona = a.id_persona
	Where p.dni = pDniALumno;

	Select ple.id_plan_de_estudio INTO idPlanDeEstudio
	From Plan_de_estudio ple inner join Carrera c on ple.id_carrera = c.id_carrera
	Where c.nombre = pNombreCarrera AND ple.año = pAñoPlan;

	Select count(*) into tempMatricula
	From Alumno_plan ap
	Where ap.id_alumno = idAlumno AND ap.id_plan_de_estudio = idPlanDeEstudio;

	IF tempMatricula > 0 THEN
	   Select 'Ya esta matriculado en ese plan de carrera';
	   LEAVE proc_label;
	ELSE
	   INSERT INTO Alumno_plan(id_alumno, id_plan_de_estudio, fecha_matriculacion, condicion)
	   VALUES (idAlumno, idPlanDeEstudio, CURDATE(), 'Inscripto');
	   Select * From Alumno_plan;
	END IF;
END//
delimiter ;
  
