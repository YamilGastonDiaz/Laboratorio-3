USE DIAGNOSTICO

--¿Qué Obras Sociales cubren a pacientes que se hayan atendido en algún turno con algún médico de especialidad 'Odontología'?
SELECT OB.NOMBRE
FROM OBRAS_SOCIALES AS OB
INNER JOIN PACIENTES AS P ON OB.IDOBRASOCIAL = P.IDOBRASOCIAL
INNER JOIN TURNOS AS T ON T.IDPACIENTE = P.IDPACIENTE
INNER JOIN MEDICOS AS M ON M.IDMEDICO = T.IDMEDICO
INNER JOIN ESPECIALIDADES AS E ON E.IDESPECIALIDAD = M.IDESPECIALIDAD
WHERE E.NOMBRE = 'Odontología'

--¿Cuántos pacientes distintos se atendieron en turnos que duraron más que la duración promedio?
SELECT COUNT(DISTINCT P.IDPACIENTE)
FROM PACIENTES AS P
INNER JOIN TURNOS AS T ON P.IDPACIENTE = T.IDPACIENTE
WHERE DURACION >
(
    SELECT AVG(DURACION)
    FROM TURNOS
)

--¿Cuál es el costo de la consulta promedio de los/as especialistas en "Oftalmología"?
SELECT AVG(M.COSTO_CONSULTA)
FROM MEDICOS AS M
INNER JOIN ESPECIALIDADES AS E ON M.IDESPECIALIDAD = E.IDESPECIALIDAD
WHERE E.NOMBRE = 'Oftalmología'

--¿Cuál es la cantidad de pacientes que no se atendieron en el año 2019?
SELECT COUNT(*) 
FROM PACIENTES AS P
WHERE P.IDPACIENTE NOT IN (
    SELECT T.IDPACIENTE
    FROM TURNOS AS T
    WHERE YEAR(FECHAHORA) = 2019 
)

--¿Cuál es el apellido del médico (sexo masculino) con más antigüedad de la clínica?
SELECT TOP 1 APELLIDO
FROM MEDICOS
WHERE SEXO = 'M'
ORDER BY FECHAINGRESO ASC

