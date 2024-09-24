use BDArchivos

SELECT * FROM Usuarios
SELECT * FROM TiposUsuario
SELECT * FROM ArchivosCompartidos

--Actividad 1
SELECT U.Nombre, U.Apellido, TU.TipoUsuario
FROM Usuarios AS U
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario

--Actividad 2
SELECT U.IDUsuario, U.Nombre, U.Apellido, TU.TipoUsuario
FROM Usuarios AS U
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TU.TipoUsuario IN ('Suscripción Free', 'Suscripción Básica')

--Actividad 3
SELECT A.Nombre, A.Extension, CAST(A.Tamaño / 1048576.0 AS decimal(10, 2)) AS Megabyte, TA.TipoArchivo
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo

--Actividad 4
SELECT Nombre + '.' + Extension AS NombreArchivo
FROM Archivos
WHERE Extension IN ('zip', 'docx', 'xls', 'js', 'gif')

--Actividad 5
SELECT A.Nombre, A.Extension, CAST(A.Tamaño / 1048576.0 AS decimal(10, 2)) AS Megabyte, A.FechaCreacion
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE U.Nombre = 'Michael' AND U.Apellido = 'Williams'

--Actividad 6
SELECT TOP 1 WITH TIES A.IDArchivo, A.IDUsuarioDueño, A.Nombre, A.Extension, A.Descripcion, A.IDTipoArchivo, A.Tamaño, A.FechaCreacion, A.FechaUltimaModificacion, A.Eliminado 
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE U.Nombre = 'Michael' AND U.Apellido = 'Williams' ORDER BY Tamaño DESC

--Actividad 7
SELECT A.Nombre, A.Extension, A.Tamaño, A.FechaCreacion, A.FechaUltimaModificacion, U.Apellido, U.Nombre
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE Descripcion LIKE '%empresa%' OR Descripcion LIKE '%presupuesto%'

--Actividad 8
SELECT DISTINCT A.Extension
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE TipoUsuario IN  ('Suscripción Plus', 'Suscripción Premium', 'Suscripción
Empresarial')

--Actividad 9
SELECT U.Apellido, U.Nombre, A.Tamaño
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDueño
WHERE A.Extension = 'zip' ORDER BY A.Tamaño DESC

--Actividad 10
SELECT A.Nombre, A.Extension, A.Tamaño, TA.TipoArchivo,
CASE
    WHEN A.Tamaño >= 1073741824 THEN CAST(A.Tamaño / 1073741824.0 AS decimal(10))
    WHEN A.Tamaño >= 1048576 THEN CAST(A.Tamaño / 1048576 AS decimal(10))
    WHEN A.Tamaño >= 1024 THEN CAST(A.Tamaño / 1024 AS decimal(10))
    ELSE A.Tamaño
END AS 'TamañoCalculado',
CASE
    WHEN A.Tamaño >= 1073741824 THEN 'Gigabyte'
    WHEN A.Tamaño >= 1048576 THEN 'Megabyte'
    WHEN A.Tamaño >= 1024 THEN 'Kilobyte'
    ELSE 'Byte'
END AS 'Unidad'
FROM Archivos AS A
INNER JOIN TiposArchivos AS TA ON A.IDTipoArchivo = TA.IDTipoArchivo

--Actividad 11
SELECT DISTINCT A.Nombre, A.Extension
FROM Archivos A
INNER JOIN ArchivosCompartidos AC ON A.IDArchivo = AC.IDArchivo

--Actividad 12
SELECT A.Nombre, A.Extension
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
WHERE U.Apellido IN ('Clarck', 'Jones')

--Actividad 13
SELECT A.Nombre, A.Extension, U.Apellido, U.Nombre
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS U ON AC.IDUsuario = U.IDUsuario
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
WHERE P.Nombre = 'Escritura'

--Actividad 14
SELECT A.Nombre, A.Extension
FROM Archivos AS A
LEFT JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
WHERE AC.FechaCompartido IS NULL

--Actividad 15
SELECT DISTINCT U.Apellido, U.Nombre
FROM Usuarios AS U
INNER JOIN Archivos AS A ON U.IDUsuario = A.IDUsuarioDueño
WHERE Eliminado <> 0

--Actividad 16
SELECT TU.TipoUsuario
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE Tamaño >= 125829120

--Actividad 17
SELECT U.Apellido, U.Nombre, A.Nombre, A.Extension, A.FechaCreacion, A.FechaUltimaModificacion, DATEDIFF(DAY, A.FechaUltimaModificacion, GETDATE()) AS DiasTranscurriodos
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE A.FechaCreacion <> FechaUltimaModificacion

--Actividad 18
SELECT A.Nombre, A.Extension, A.Tamaño, Ud.Apellido, Ud.Nombre, Uc.Apellido AS ApellidoCompartido, Uc.Nombre AS NombreCompartido, P.Nombre
FROM Archivos AS A
INNER JOIN Usuarios AS Ud ON A.IDUsuarioDueño = Ud.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS Uc ON AC.IDUsuario = Uc.IDUsuario
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso

--Actividad 19
SELECT A.Nombre, A.Extension, A.Tamaño, Ud.Apellido, Ud.Nombre, Uc.Apellido AS ApellidoCompartido, Uc.Nombre AS ApellidoCompartido, P.Nombre
FROM Archivos AS A
INNER JOIN Usuarios AS Ud ON A.IDUsuarioDueño = Ud.IDUsuario
INNER JOIN ArchivosCompartidos AS AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS Uc ON AC.IDUsuario = Uc.IDUsuario
INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
WHERE Ud.IDTipoUsuario = Uc.IDTipoUsuario

--Actividad 20
SELECT U.Apellido, U.Nombre
FROM Archivos AS A
INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
WHERE A.Nombre = 'Documento Legal'
UNION
SELECT Uc.Apellido, Uc.Nombre
FROM Archivos AS A
INNER JOIN ArchivosCompartidos AC ON A.IDArchivo = AC.IDArchivo
INNER JOIN Usuarios AS Uc ON AC.IDUsuario = Uc.IDUsuario
WHERE A.Nombre = 'Documento Legal'