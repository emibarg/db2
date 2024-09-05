
--Cantidad de alumnos inscriptos por carrera

SELECT c.nombre, count(id_alumno)
FROM Alumno_plan ap inner join Plan_de_estudio pe on ap.id_plan_de_estudio = pe.id_plan_de_estudio
inner join Carrera c on pe.id_carrera = c.id_carrera
GROUP BY c.id_carrera;

--CANTIDAD DE EXAMENES RENDIDOS Y APROBADOS POR MATERIA NOTA >4
SELECT Count(*) as Cantidad_parciales_aprobados, m.nombre 
FROM Parcial p JOIN Cursada c on p.id_cursada = c.id_cursada
JOIN Plan_materia pm on pm.id_plan_materia = c.id_plan_materia 
JOIN Materia m on pm.id_materia = m.id_materia
WHERE nota >= 4
GROUP BY m.nombre;
--Cantidad de alumnos Regulares y Libres por materia 
SELECT Count(*) as Cantidad_alumnos, ac.estado_inscripcion, m.nombre  
FROM Alumno_comision ac JOIN Comision c on ac.id_comision = c.id_comision
JOIN Cursada cu on c.id_cursada = cu.id_cursada 
JOIN Plan_materia pm on cu.id_plan_materia = pm.id_plan_materia 
JOIN Materia m on pm.id_materia = m.id_materia
GROUP BY ac.estado_inscripcion, m.nombre
HAVING estado_inscripcion like "%Regular%" or estado_inscripcion like "%Libre%";
--listado de alumnos inscriptos para cursar por materia
SELECT Count(*) as Cantidad_alumnos, ac.estado_inscripcion, m.nombre  
FROM Alumno_comision ac JOIN Comision c on ac.id_comision = c.id_comision
JOIN Cursada cu on c.id_cursada = cu.id_cursada 
JOIN Plan_materia pm on cu.id_plan_materia = pm.id_plan_materia 
JOIN Materia m on pm.id_materia = m.id_materia
GROUP BY ac.estado_inscripcion, m.nombre
HAVING estado_inscripcion like "%Inscripto%";
--Cantidad de alumnos "Activos" por plan de carrera
SELECT Count(*) as Cantidad_alumnos, pe.año, c.nombre
FROM Alumno_plan ap JOIN Plan_de_estudio pe on ap.id_plan_de_estudio = pe.id_plan_de_estudio
JOIN Carrera c on pe.id_carrera = c.id_carrera
WHERE ap.condicion like "Regular"
GROUP BY pe.id_plan_de_estudio;
--Cantidad de alumnos inscriptos por plan de carrera
SELECT Count(*) as Cantidad_alumnos, pe.año, c.nombre
FROM Alumno_plan ap JOIN Plan_de_estudio pe on ap.id_plan_de_estudio = pe.id_plan_de_estudio
JOIN Carrera c on pe.id_carrera = c.id_carrera
WHERE ap.condicion NOT like "%Recibido%"
GROUP BY pe.id_plan_de_estudio;

