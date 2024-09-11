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
  
-- Inscripcion a cursada

delimiter //
CREATE PROCEDURE inscripcionCursada(IN pDniAlumno int, IN pNombreComision varchar(50), IN pNombreMateria varchar(50), IN pNombreCarrera varchar(50), IN pCuatrimestre int)
proc_label:BEGIN

	DECLARE idAlumno INT DEFAULT 0;
	DECLARE idComision INT DEFAULT 0;
	DECLARE idMateria INT DEFAULT 0;
	DECLARE idPlanDeEstudio INT DEFAULT 0;
	DECLARE idPlanMateria INT DEFAULT 0;
	DECLARE idCursada INT DEFAULT 0;
	DECLARE Condicion varchar(50) DEFAULT '';
	DECLARE tempInscripcion INT DEFAULT 0;

	DECLARE temp INT DEFAULT 0;

	IF (pCuatrimestre < 1 OR pCuatrimestre >2) THEN
	   Select 'Cuatrimestre invalido';
	   LEAVE proc_label;
	END IF;

	Select count(*) INTO temp
	From Persona p inner join Alumno a on p.id_persona = a.id_persona
	Where p.dni = pDniAlumno;

	IF temp = 0 THEN
	   Select 'No existe ese alumno';
	   LEAVE proc_label;
	END IF;

	Select count(*) INTO temp
	From Comision c
	Where c.nombre = pNombreComision;

	IF temp = 0 THEN
	   Select 'No existe ese nombre de comision';
	   LEAVE proc_label;
	END IF;

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
	From Persona p
	inner join Alumno a on a.id_persona = p.id_persona
	inner join Alumno_plan ap on a.id_alumno = ap.id_alumno
	inner join Plan_de_estudio pde on pde.id_plan_de_estudio = ap.id_plan_de_estudio
	inner join Carrera c on c.id_carrera = pde.id_carrera
	Where p.dni = pDniALumno AND c.nombre = pNombreCarrera;

	IF temp = 0 THEN
	   Select 'Ese alumno no esta inscripto a esa carrera';
	   LEAVE proc_label;
	END IF;

	Select pde.id_plan_de_estudio INTO idPlanDeEstudio
	From Persona p
	inner join Alumno a on a.id_persona = p.id_persona
	inner join Alumno_plan ap on a.id_alumno = ap.id_alumno
	inner join Plan_de_estudio pde on pde.id_plan_de_estudio = ap.id_plan_de_estudio
	inner join Carrera c on c.id_carrera = pde.id_carrera
	Where p.dni = pDniALumno AND c.nombre = pNombreCarrera
	Order by año DESC
	LIMIT 1;
	
	Select ma.id_materia INTO idMateria
	From Materia ma
	Where ma.nombre = pNombreMateria;

	Select count(*) into temp
	From Plan_materia pm
	Where pm.id_materia = idMateria and pm.id_plan_de_estudio = idPlanDeEstudio;

	IF temp = 0 THEN
	   Select 'Esa materia no esta en ese plan';
	   LEAVE proc_label;
	END IF;

	IF temp > 1 THEN
	   Select id_plan_materia into idPlanMateria
	   From Plan_materia pm
	   Where pm.id_materia = idMateria and pm.id_plan_de_estudio = idPlanDeEstudio and (pm.año-year(CURDATE())) >=all (Select (pm.año-year(CURDATE())) From Plan_materia pm2 Where pm2.id_materia = idMateria AND pm2.id_plan_de_estudio = idPlanDeEstudio);
	ELSE
	   Select id_plan_materia into idPlanMateria
	   From Plan_materia pm
	   Where pm.id_materia = idMateria and pm.id_plan_de_estudio = idPlanDeEstudio;
	END IF;

	Select a.id_alumno INTO idAlumno
	From Persona p inner join Alumno a on p.id_persona = a.id_persona
	Where p.dni = pDniAlumno;

	Select ac.estado_inscripcion INTO Condicion
	From Alumno_comision ac
	inner join Comision co on co.id_comision = ac.id_comision
	inner join Cursada cu on cu.id_cursada = co.id_cursada
	inner join Plan_materia pm on pm.id_plan_materia = cu.id_plan_materia
	Where  ac.id_alumno = idAlumno AND pm.id_materia = idMateria
	order by ac.fecha_inscripcion DESC
	LIMIT 1;

	IF Condicion = 'Cursando' OR Condicion = 'Regular' THEN
	   Select 'El alumno esta cursando o esta regular en esa materia';
	   LEAVE proc_label;
	END IF;

	Select cu.id_cursada INTO idCursada
	From Cursada cu
	Where cu.id_plan_materia = idPlanMateria
	AND (cu.año_cursada-year(CURDATE())) >= all(Select (cu2.año_cursada-year(CURDATE())) From Cursada cu2 Where cu2.id_plan_materia = idPlanMateria)
	AND cu.cuatrimestre = pCuatrimestre;

	Select count(*) INTO temp
	From Comision c
	Where c.nombre = pNombreComision AND c.id_cursada = idCursada;

	IF temp = 0 THEN
	   Select idCursada, idAlumno, idMateria, idPlanDeEstudio, idPlanMateria; 
	   Select 'No existe esa comision en esa cursada';
	   LEAVE proc_label;
	END IF;

	Select co.id_comision INTO idComision
	From Comision co
	Where co.nombre = pNombreComision AND co.id_cursada = idCursada;

	Select count(*) INTO tempInscripcion
	From Alumno_comision ac
	Where ac.id_alumno = idAlumno and ac.id_comision = idComision;

	IF tempInscripcion > 0 THEN
	   Select 'El alumno ya esta inscripto';
	   LEAVE proc_label;
	ELSE
	   INSERT INTO Alumno_comision (id_comision, id_alumno, fecha_inscripcion, estado_inscripcion, fecha_estado)
	   VALUES(idComision, idAlumno, CURDATE(), 'Cursando', CURDATE());
	END IF;
END//
delimiter ;

-- Inscripcion Examen

delimiter //

CREATE PROCEDURE inscripcionExamen (IN pDniAlumno int, IN pMateria varchar(50), IN pFechaTurno DATE )
proc_label:BEGIN

  DECLARE idAlumno int DEFAULT 0;
  DECLARE tempMateria INT DEFAULT 0;
  DECLARE isRegular INT DEFAULT 0;
  DECLARE hasNota int DEFAULT 0;
  DECLARE turnoExists int DEFAULT 0;
  DECLARE alreadyInscripto int DEFAULT 0;

  SELECT a.id_alumno into idAlumno
  FROM Persona p JOIN Alumno a on p.id_persona = a.id_persona
  WHERE p.dni = pDniAlumno;

  IF idAlumno = 0 THEN
    SELECT 'No existe ese alumno';
    LEAVE proc_label;
  END IF;

  SELECT id_materia INTO tempMateria
  FROM Materia m 
  WHERE m.nombre = pMateria;
  
  IF tempMateria = 0 THEN
    SELECT 'No existe esa materia';
    LEAVE proc_label;
  END IF;




  SELECT a.id_alumno INTO isRegular 
  FROM Persona p JOIN Alumno a on p.id_persona = a.id_persona
  JOIN Alumno_comision ac on a.id_alumno = ac.id_alumno 
  JOIN Comision c on c.id_comision = ac.id_comision
  JOIN Cursada cu on cu.id_cursada = c.id_comision 
  JOIN Plan_materia pm on cu.id_plan_materia = pm.id_plan_materia
  WHERE a.id_alumno = idAlumno AND ac.estado_inscripcion like '%Regular%' AND pm.id_materia = tempMateria;

  IF isRegular = 0 THEN 
    SELECT 'El alumno no esta regular en la materia solicitada';
    LEAVE proc_label;
  END IF;

  SELECT te.id_turno_examen INTO turnoExists
  FROM Turno_examen te 
  WHERE te.id_materia = tempMateria and te.fecha_examen = pFechaTurno;
  IF turnoExists = 0 THEN
    SELECT 'El turno no existe';
  END IF;

  SELECT count(*) INTO alreadyInscripto
   FROM Alumno a JOIN Inscripcion_examen ie on a.id_alumno = ie.id_alumno 
  JOIN Turno_examen te on ie.id_turno_examen = te.id_turno_examen
  WHERE a.id_alumno = idAlumno AND te.id_materia = tempMateria ;


IF alreadyInscripto>0 THEN 

  SELECT a.id_alumno INTO hasNota
  FROM Alumno a JOIN Inscripcion_examen ie on a.id_alumno = ie.id_alumno 
  JOIN Turno_examen te on ie.id_turno_examen = te.id_turno_examen
  WHERE a.id_alumno = idAlumno AND te.id_materia = tempMateria AND ie.nota IS NOT NULL;
  


  IF hasNota = 0  THEN 
    SELECT 'El alumno no tiene nota en su final';
    LEAVE proc_label;
  END IF; 
END IF;
  
    INSERT INTO Inscripcion_examen (id_turno_examen, id_alumno, fecha_inscripcion)
    VALUES (turnoExists, idAlumno, CURDATE());
END//

delimiter ;
