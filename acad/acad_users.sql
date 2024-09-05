CREATE ROLE acad_admin;

GRANT SELECT on acad.* to acad_admin;
GRANT INSERT on acad.* to acad_admin;
GRANT UPDATE on acad.* to acad_admin;
GRANT DELETE on acad.* to acad_admin;

CREATE ROLE alumno;

GRANT SELECT on acad.* to alumno;

GRANT INSERT on acad.Alumno_comision to alumno;
GRANT INSERT on acad.Encuesta to alumno;
GRANT INSERT on acad.Inscripcion_examen to alumno;

GRANT UPDATE on acad.Encuesta to alumno;
GRANT UPDATE on acad.Alumno_comision to alumno;

CREATE ROLE secretaria;

GRANT SELECT on acad.* to secretaria;

GRANT INSERT on acad.Alumno_comision to secretaria;
GRANT INSERT on acad.Parcial to secretaria;
GRANT INSERT on acad.Turno_examen to secretaria;
GRANT INSERT on acad.Alumno to secretaria;
GRANT INSERT on acad.Alumno_plan to secretaria;
GRANT INSERT on acad.Cursada to secretaria;
GRANT INSERT on acad.Aula to secretaria;
GRANT INSERT on acad.Ayudante_de_catedra to secretaria;
GRANT INSERT on acad.Inscripcion_examen to secretaria;
GRANT INSERT on acad.Persona to secretaria;
GRANT INSERT on acad.Profesor to secretaria;
GRANT INSERT on acad.Profesor_comision to secretaria;

GRANT UPDATE on acad.Alumno_comision to secretaria;
GRANT UPDATE on acad.Parcial to secretaria;
GRANT UPDATE on acad.Turno_examen to secretaria;
GRANT UPDATE on acad.Alumno to secretaria;
GRANT UPDATE on acad.Alumno_plan to secretaria;
GRANT UPDATE on acad.Cursada to secretaria;
GRANT UPDATE on acad.Aula to secretaria;
GRANT UPDATE on acad.Ayudante_de_catedra to secretaria;
GRANT UPDATE on acad.Comision to secretaria;
GRANT UPDATE on acad.Inscripcion_examen to secretaria;
GRANT UPDATE on acad.Persona to secretaria;
GRANT UPDATE on acad.Profesor to secretaria;
GRANT UPDATE on acad.Profesor_comision to secretaria;

GRANT DELETE on acad.Alumno_comision to secretaria;

CREATE ROLE profesor;

GRANT SELECT on acad.* to profesor;

CREATE ROLE jefe_catedra;

GRANT SELECT on acad.* to jefe_catedra;

GRANT INSERT on acad.Plan_materia to jefe_catedra;

GRANT UPDATE on acad.Plan_materia to jefe_catedra;


CREATE USER acad_admin@localhost IDENTIFIED BY 'supersecurepassword';
GRANT acad_admin to acad_admin@localhost;

CREATE USER alumno@'%' IDENTIFIED BY 'password';
GRANT alumno to alumno@'%';

CREATE USER secretaria@localhost IDENTIFIED BY 'securepassword';
GRANT secretaria to secretaria@localhost;

CREATE USER profesor@'%' IDENTIFIED BY 'password';
GRANT profesor to profesor@'%';

CREATE USER jefe_catedra@'%' IDENTIFIED BY 'password';
GRANT jefe_catedra to jefe_catedra@'%';
