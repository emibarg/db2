CREATE ROLE acad_admin@localhost;

GRANT SELECT on acad.* to acad_admin@localhost;
GRANT INSERT on acad.* to acad_admin@localhost;
GRANT UPDATE on acad.* to acad_admin@localhost;
GRANT DELETE on acad.* to acad_admin@localhost;

CREATE ROLE alumno@'%';

GRANT SELECT on acad.* to alumno@'%';

GRANT INSERT on acad.Alumno_comision to alumno@'%';
GRANT INSERT on acad.Encuesta to alumno@'%';
GRANT INSERT on acad.Inscripcion_examen to alumno@'%';

GRANT UPDATE on acad.Encuesta to alumno@'%';
GRANT UPDATE on acad.Alumno_comision to alumno@'%';

CREATE ROLE secretaria@localhost;

GRANT SELECT on acad.* to secretaria@localhost;

GRANT INSERT on acad.Alumno_comision to secretaria@localhost;
GRANT INSERT on acad.Parcial to secretaria@localhost;
GRANT INSERT on acad.Turno_examen to secretaria@localhost;
GRANT INSERT on acad.Alumno to secretaria@localhost;
GRANT INSERT on acad.Alumno_plan to secretaria@localhost;
GRANT INSERT on acad.Cursada to secretaria@localhost;
GRANT INSERT on acad.Aula to secretaria@localhost;
GRANT INSERT on acad.Ayudante_de_catedra to secretaria@localhost;
GRANT INSERT on acad.Comision to secretaria@localhost;
GRANT INSERT on acad.Inscripcion_examen to secretaria@localhost;
GRANT INSERT on acad.Persona to secretaria@localhost;
GRANT INSERT on acad.Profesor to secretaria@localhost;
GRANT INSERT on acad.Profesor_comision to secretaria@localhost;

GRANT UPDATE on acad.Alumno_comision to secretaria@localhost;
GRANT UPDATE on acad.Parcial to secretaria@localhost;
GRANT UPDATE on acad.Turno_examen to secretaria@localhost;
GRANT UPDATE on acad.Alumno to secretaria@localhost;
GRANT UPDATE on acad.Alumno_plan to secretaria@localhost;
GRANT UPDATE on acad.Cursada to secretaria@localhost;
GRANT UPDATE on acad.Aula to secretaria@localhost;
GRANT UPDATE on acad.Ayudante_de_catedra to secretaria@localhost;
GRANT UPDATE on acad.Comision to secretaria@localhost;
GRANT UPDATE on acad.Inscripcion_examen to secretaria@localhost;
GRANT UPDATE on acad.Persona to secretaria@localhost;
GRANT UPDATE on acad.Profesor to secretaria@localhost;
GRANT UPDATE on acad.Profesor_comision to secretaria@localhost;

GRANT DELETE on acad.Alumno_comision to secretaria@localhost;

CREATE ROLE profesor@'%';

GRANT SELECT on acad.* to profesor@'%';

CREATE ROLE jefe_catedra@localhost;

GRANT SELECT on acad.* to jefe_catedra@localhost;

GRANT INSERT on acad.Plan_materia to jefe_catedra@localhost;

GRANT UPDATE on acad.Plan_materia to jefe_catedra@localhost;

CREATE ROLE ayudante_catedra@'%';

GRANT SELECT on acad.* to ayudante_catedra@'%';
