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

-- Inscripcion en examen
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





delimiter //

CREATE PROCEDURE cargarNota(IN pDniAlumno int, IN pMateria varchar(50), IN pNota int)
proc_label: BEGIN

  DECLARE idAlumno INT DEFAULT 0;
  DECLARE idMateria INT DEFAULT 0;
  DECLARE isInscripto INT DEFAULT 0;
  DECLARE hasNota INT DEFAULT 0;


  SELECT a.id_alumno INTO idAlumno
  FROM Alumno a JOIN Persona p on a.id_persona = p.id_persona
  WHERE p.dni = pDniAlumno;


  IF idAlumno = 0 THEN
    SELECT 'El DNI ingresado no pertenece a un Alumno registrado';
    LEAVE proc_label;
  END IF;


  SELECT m.id_materia INTO idMateria
  FROM Materia m
  WHERE m.nombre = pMateria;


  IF idMateria = 0 THEN
    SELECT 'No existe esa materia';
    LEAVE proc_label;
  END IF;


  SELECT ie.id_inscripcion INTO isInscripto
  FROM Alumno a 
  JOIN Inscripcion_examen ie ON a.id_alumno = ie.id_alumno
  JOIN Turno_examen te on ie.id_turno_examen = te.id_turno_examen
  WHERE a.id_alumno = idAlumno AND te.id_materia = idMateria
  ORDER BY ie.fecha_inscripcion DESC
  LIMIT 1;

  IF isInscripto IS NULL THEN
    SELECT 'El alumno no está inscripto en el examen';
    LEAVE proc_label;
  END IF;


  SELECT ie.id_inscripcion INTO hasNota
  FROM Alumno a 
  JOIN Inscripcion_examen ie ON a.id_alumno = ie.id_alumno
  JOIN Turno_examen te on ie.id_turno_examen = te.id_turno_examen
  WHERE a.id_alumno = idAlumno AND te.id_materia = idMateria
  ORDER BY ie.fecha_inscripcion DESC
  LIMIT 1;

  IF hasNota IS NOT NULL THEN
    SELECT 'El alumno ya tiene nota';
    LEAVE proc_label;
  END IF;


  IF pNota < 1 OR pNota > 10 THEN
    SELECT 'La nota no es válida';
    LEAVE proc_label;
  END IF;


  UPDATE Inscripcion_examen
  SET nota = pNota
  WHERE id_inscripcion = isInscripto;

  SELECT ie.nota 
  FROM Inscripcion_examen ie 
  WHERE ie.id_inscripcion = isInscripto;

END//

delimiter ;

