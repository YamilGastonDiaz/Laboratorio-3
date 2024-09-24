USE BDArchivos

--Actividad 1
SELECT COUNT(*) AS CantidadZip
FROM Archivos AS A
WHERE A.Extension = 'zip'

--Actividad 2
SELECT COUNT(*) AS ArchivoModificado
FROM Archivos AS A
WHERE A.FechaCreacion <> A.FechaUltimaModificacion

--Actividad 3
SELECT CAST(MIN(A.FechaCreacion) AS DATE) AS FehcaAntigua
FROM Archivos AS A
WHERE A.Extension = 'pdf'

--Actividad 4
SELECT COUNT( DISTINCT A.Extension)
FROM Archivos AS A
WHERE A.Nombre LIKE '%Informe%' OR A.Nombre LIKE '%Documento%'

--Actividad 5
SELECT AVG(CAST(Tamaño AS float) / 1048576)
FROM Archivos
WHERE Extension IN('doc', 'docx', 'xls', 'xlsx')

--Actividad 6
SELECT COUNT(*)
FROM ArchivosCompartidos AS AC
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE U.Apellido = 'Clarck'

--Actividad 7
SELECT COUNT(DISTINCT TU.TipoUsuario)
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE A.Extension = 'pdf'

--Actividad 8
SELECT MAX(CAST(A.Tamaño AS float) / 1048576)
FROM Archivos AS A
WHERE YEAR(A.FechaCreacion) = 2024

--Actividad 9
SELECT TU.TipoUsuario, COUNT(DISTINCT A.IDUsuarioDueño)
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE A.Extension = 'pdf'
GROUP BY TU.TipoUsuario

--Actividad 10
SELECT U.Nombre, U.Apellido, SUM(A.Tamaño) AS TotalCompartido
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
WHERE AC.FechaCompartido IS NOT NULL
GROUP BY U.Nombre, U.Apellido
ORDER BY TotalCompartido DESC

--Actividad 11
SELECT TA.TipoArchivo, AVG(A.Tamaño) AS Promedio
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
GROUP BY TA.TipoArchivo

--Actividad 12
SELECT A.Extension, COUNT(a.Extension) AS Cantidad, SUM(A.Tamaño) AS TotalBytes
FROM Archivos AS A
GROUP BY A.Extension
ORDER BY Cantidad ASC

--Actividad 13
SELECT U.IDUsuario, U.Apellido, U.Nombre, ISNULL(SUM(A.Tamaño), 0) AS TotalBytes
FROM Usuarios AS U
LEFT JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDueño
GROUP BY U.IDUsuario, U.Apellido, U.Nombre

--Actividad 14
SELECT TA.TipoArchivo, COUNT(A.IDTipoArchivo)
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
WHERE P.Nombre = 'Lectura'
GROUP BY TA.TipoArchivo, P.Nombre
HAVING COUNT(A.IDTipoArchivo) > 1

--Actividad 16
SELECT TA.TipoArchivo ,MAX(A.Tamaño)
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
GROUP BY TA.TipoArchivo

--Actividad 17
SELECT TA.TipoArchivo, AVG(CAST(A.Tamaño as float))
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo
GROUP BY TA.TipoArchivo
HAVING  AVG(CAST(A.Tamaño as float) / 1048576) > 50

--Actividad 18
SELECT A.Extension, COUNT(A.IDArchivo)
FROM Archivos AS A
LEFT JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
WHERE AC.IDArchivo IS NULL
GROUP BY A.Extension
HAVING COUNT(A.IDArchivo) > 2

