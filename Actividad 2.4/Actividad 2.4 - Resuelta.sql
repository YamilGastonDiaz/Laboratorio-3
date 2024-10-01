USE BDArchivos

--Actividad 1
SELECT Nombre, Extension, CAST(Tamaño / 1048576.0 AS decimal(10, 2))
FROM Archivos
WHERE CAST(Tamaño / 1048576.0 AS decimal(10, 2)) > 
(
    SELECT AVG( CAST(Tamaño / 1048576.0 AS decimal(10, 2)))
    FROM Archivos
)

--Actividad 2
SELECT Apellido, Nombre
FROM Usuarios
WHERE IDUsuario NOT IN (
    SELECT DISTINCT IDUsuarioDueño
    FROM Archivos
    WHERE Extension = 'zip'
)

--Actividad 3
SELECT U.IDUsuario, U.Apellido, U.Nombre, TU.TipoUsuario
FROM Usuarios AS U
INNER JOIN TiposUsuario AS TU ON U.IDTipoUsuario = TU.IDTipoUsuario
WHERE U.IDUsuario NOT IN (
    SELECT A.IDUsuarioDueño
    FROM Archivos AS A
    WHERE YEAR(GETDATE()) = YEAR(FechaCreacion) OR YEAR(GETDATE()) = YEAR(FechaUltimaModificacion)
)

--Actividad 4
SELECT TU.TipoUsuario
FROM TiposUsuario AS TU
WHERE TU.IDTipoUsuario NOT IN 
(
    SELECT A.IDUsuarioDueño
    FROM Archivos AS A
    INNER JOIN Usuarios AS U ON A.IDUsuarioDueño = U.IDUsuario
    WHERE Eliminado = 1
)

--Actividad 5
SELECT DISTINCT TA.TipoArchivo, A.IDTipoArchivo
FROM TiposArchivos AS TA
INNER JOIN Archivos AS A ON TA.IDTipoArchivo = A.IDTipoArchivo
WHERE A.IDArchivo NOT IN (
    SELECT DISTINCT AC.IDArchivo
    FROM ArchivosCompartidos AS AC
    INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
    WHERE P.Nombre = 'Lectura'
)

--Actividad 6
SELECT A.Nombre, A.Extension, A.Tamaño
FROM Archivos AS A
WHERE A.Tamaño > (
SELECT MAX(Tamaño)
FROM Archivos
WHERE Extension = 'xls')

--Actividad 7
SELECT A.Nombre, A.Extension, A.Tamaño
FROM Archivos AS A
WHERE A.Tamaño > (
    SELECT MIN(Tamaño)
    FROM Archivos
    WHERE Extension = 'zip'
)

--Actividad 8
SELECT TA.TipoArchivo,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE TA.IDTipoArchivo = A.IDTipoArchivo AND Eliminado = 0
) AS NoEliminados,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE TA.IDTipoArchivo = A.IDTipoArchivo AND Eliminado = 1
) AS Eliminado
FROM TiposArchivos AS TA

--Actividad 9
SELECT U.IDUsuario, U.Apellido, U.Nombre,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE CAST(A.Tamaño / 1048576.0 AS decimal(10, 2)) < 20 AND U.IDUsuario = A.IDUsuarioDueño
) AS ArchivoPequeño,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE CAST(A.Tamaño / 1048576.0 AS decimal(10, 2)) >= 20 AND U.IDUsuario = A.IDUsuarioDueño
) AS ArchivoGrande
FROM Usuarios AS U

--Actividad 10
SELECT U.IDUsuario, U.Apellido, U.Nombre,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE YEAR(FechaCreacion) = 2022 AND U.IDUsuario = A.IDUsuarioDueño
) AS Cant2022,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE YEAR(FechaCreacion) = 2023 AND U.IDUsuario = A.IDUsuarioDueño
) AS Cant2023,
(
    SELECT COUNT(*) FROM Archivos AS A
    WHERE YEAR(FechaCreacion) = 2024 AND U.IDUsuario = A.IDUsuarioDueño
) AS Cant2024
FROM Usuarios AS U

--Actividad 11
SELECT A.Nombre
FROM Archivos AS A
WHERE A.IDArchivo IN (
    SELECT AC.IDArchivo FROM ArchivosCompartidos AS AC
    INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
    WHERE P.Nombre = 'Comentario'
)AND
A.IDArchivo NOT IN (
    SELECT AC.IDArchivo FROM ArchivosCompartidos AS AC
    INNER JOIN Permisos AS P ON AC.IDPermiso = P.IDPermiso
    WHERE P.Nombre = 'Lectura'
)

--Actividad 12
SELECT AUX.TipoArchivo
FROM
(
SELECT TA.TipoArchivo,
    (
        SELECT COUNT(*) FROM Archivos AS A
        WHERE TA.IDTipoArchivo = A.IDTipoArchivo AND Eliminado = 0
    ) AS NoEliminados,
    (
        SELECT COUNT(*) FROM Archivos AS A
        WHERE TA.IDTipoArchivo = A.IDTipoArchivo AND Eliminado = 1
    ) AS Eliminado
    FROM TiposArchivos AS TA
) AS AUX
WHERE AUX.Eliminado > AUX.NoEliminados

--Actividad 13
--Archivos pequeños (menos de 20MB) y archivos grandes (20MBs o más)
SELECT AUX.Apellido, AUX.Nombre, AUX.ArchivoPequeño, AUX.ArchivoGrande
FROM
(
SELECT U.Apellido, U.Nombre,
    (
        SELECT COUNT(*)
        FROM Archivos AS A
        WHERE Cast(A.Tamaño / 1048576.0 AS decimal(10, 2)) < 20 AND U.IDUsuario = A.IDUsuarioDueño
    ) AS ArchivoPequeño,
    (
        SELECT COUNT(*)
        FROM Archivos AS A
        WHERE Cast(A.Tamaño / 1048576.0 AS decimal(10, 2)) >= 20 AND U.IDUsuario = A.IDUsuarioDueño
    ) AS ArchivoGrande
FROM Usuarios AS U
) AS AUX
WHERE AUX.ArchivoPequeño >= 1 AND (AUX.ArchivoGrande >= 1 AND AUX.ArchivoPequeño > AUX.ArchivoGrande)

--Actividad 14
SELECT AUX.IDUsuario, AUX.Apellido, AUX.Nombre, AUX.Cant2022, AUX.Cant2023, AUX.Cant2024
FROM
(
SELECT U.IDUsuario, U.Apellido, U.Nombre,
    (
        SELECT COUNT(*)
        FROM Archivos AS A
        WHERE YEAR(A.FechaCreacion) = 2022 AND U.IDUsuario = A.IDUsuarioDueño
    ) AS Cant2022,
    (
        SELECT COUNT(*)
        FROM Archivos AS A
        WHERE YEAR(A.FechaCreacion) = 2023 AND U.IDUsuario = A.IDUsuarioDueño
    ) AS Cant2023,
    (
        SELECT COUNT(*)
        FROM Archivos AS A
        WHERE YEAR(A.FechaCreacion) = 2024 AND U.IDUsuario = A.IDUsuarioDueño
    ) AS Cant2024
    FROM Usuarios AS U
) AS AUX
WHERE Cant2022 > Cant2023 AND Cant2023 > Cant2024

--Actividad 14 Otra manera de resolver
SELECT U.IDUsuario, U.Apellido, U.Nombre
FROM Usuarios U
WHERE U.IDUsuario IN 
(
SELECT A.IDUsuarioDueño
FROM Archivos A
GROUP BY A.IDUsuarioDueño
HAVING COUNT(CASE WHEN YEAR(A.FechaCreacion) = 2022 THEN 1 END) > COUNT(CASE WHEN YEAR(A.FechaCreacion) = 2023 THEN 1 END)
   AND COUNT(CASE WHEN YEAR(A.FechaCreacion) = 2023 THEN 1 END) > COUNT(CASE WHEN YEAR(A.FechaCreacion) = 2024 THEN 1 END)
)
