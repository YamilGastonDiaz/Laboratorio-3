USE PedidosyClientes

SELECT * FROM Clientes
SELECT * FROM Pedidos

-- Ejercicio 1
SELECT Apellido, Nombre, CorreoElectronico FROM Clientes

-- Ejercicio 2
SELECT Apellido + ',' + Nombre AS NobreCompleto FROM Clientes ORDER BY Apellido DESC 

-- Ejercicio 3
SELECT Nombre, Apellido, Ciudad FROM Clientes WHERE Ciudad LIKE '%Jujuy'

-- Ejercicio 4
SELECT idCliente, Apellido, Nombre FROM Clientes WHERE CorreoElectronico IS NULL ORDER BY Apellido DESC, Nombre ASC

-- Ejercicio 5
SELECT TOP 1 idCliente, Apellido, Nombre FROM Clientes ORDER BY Apellido DESC, Nombre DESC

-- Ejercicio 6
SELECT Nombre, Apellido, FechaAlta FROM Clientes WHERE YEAR(FechaAlta) = 2019

-- Ejercicio 7 Tambien usar la funcion  COALESCE
SELECT Apellido, Nombre,
CASE
    WHEN CorreoElectronico IS NOT NULL THEN CorreoElectronico
    WHEN Telefono IS NOT NULL THEN Telefono
    WHEN Celular IS NOT NULL THEN Celular
    ELSE 'Incontactable'
END AS DatoContacto
FROM Clientes

SELECT Apellido, Nombre,
COALESCE(CorreoElectronico, Telefono, Celular, 'Incontactable') AS DatoContacto
FROM Clientes;

-- Ejercicio 8
SELECT Apellido, Nombre, FechaAlta,
CASE
    WHEN DATEPART(MONTH, FechaAlta) >= 1 AND DATEPART(MONTH, FechaAlta) <= 6 THEN 'Primer Semestre'
    ELSE 'Segundo Semestre'
END AS Semestre  
FROM Clientes

-- Ejercicio 9
SELECT IdCliente, Apellido, Nombre FROM Clientes WHERE Telefono IS NOT NULL AND Celular IS NULL ORDER BY FechaAlta DESC

-- Ejercicio 10
SELECT DISTINCT Ciudad FROM Clientes

-- Ejercicio 11
SELECT IdPedido, IdCliente, FechaPedido, MontoTotal FROM Pedidos WHERE Estado <> 'Rechazado' ORDER BY FechaPedido DESC

-- Ejercicio 12
SELECT * FROM Pedidos WHERE Estado in ('Pagado', 'En preparacion') AND MontoTotal BETWEEN 500 AND 1250

-- Ejercicio 13
SELECT DISTINCT MONTH(FechaPedido) AS MES_AÑO FROM Pedidos WHERE  YEAR(FechaPedido) BETWEEN 2018 AND 2019

-- Ejercicio 14
SELECT DISTINCT IdCliente FROM Pedidos WHERE MontoTotal > 1000 AND Estado <> 'Rechazado'

-- Ejercicio 15
SELECT * FROM Pedidos WHERE IdCliente IN (1, 8, 16, 24, 32, 48) ORDER BY IdCliente ASC, Estado ASC

-- Ejercicio 16
SELECT TOP 3 * FROM Pedidos WHERE Estado = 'Pagado' ORDER BY MontoTotal ASC

-- Ejercicio 17
SELECT IdPedido, Estado, MontoTotal FROM Pedidos 
WHERE Estado = 'Rechazado' AND MontoTotal < 500 OR Estado = 'En preparacion' AND MontoTotal > 1000

-- Ejercicio 18
SELECT *, DATEPART(WEEKDAY, FechaPedido) AS DiaSemana,
CASE
    WHEN DATEPART(WEEKDAY, FechaPedido) = 1 THEN 'Domingo'
    WHEN DATEPART(WEEKDAY, FechaPedido) = 2 THEN 'Lunes'
    WHEN DATEPART(WEEKDAY, FechaPedido) = 3 THEN 'Marte'
    WHEN DATEPART(WEEKDAY, FechaPedido) = 4 THEN 'Miercoles'
    WHEN DATEPART(WEEKDAY, FechaPedido) = 5 THEN 'Jueves'
    WHEN DATEPART(WEEKDAY, FechaPedido) = 6 THEN 'Viernes'
    ELSE 'Sabado'
END AS DiaLetras
FROM Pedidos WHERE YEAR(FechaPedido) = 2023 ORDER BY DiaSemana ASC

-- Ejercicio 19
SELECT *, MONTH(FechaPedido) as mes FROM Pedidos WHERE Estado = 'Pendiente' AND MONTH(FechaPedido) = MONTH(GETDATE())

-- Ejercicio 20
SELECT *,
CASE
    WHEN DATEPART(YEAR, FechaPedido) BETWEEN 2017 AND 2019 THEN MontoTotal * 0.5
    WHEN DATEPART(YEAR, FechaPedido) = 2020 OR DATEPART(YEAR, FechaPedido) = 2021 THEN MontoTotal * 0.3
    WHEN DATEPART(YEAR, FechaPedido) BETWEEN 2022 AND 2023 THEN MontoTotal * 0.1
    ELSE 0
END AS MontoTotalBonificado
FROM Pedidos WHERE Estado IN ('Pendiente', 'En preparacion') ORDER BY FechaPedido ASC

-- Ejercicio 21
SELECT * FROM Pedidos WHERE IdCliente NOT IN (9, 17, 25, 33, 47) ORDER BY IdCliente ASC

-- Ejercicio 22
SELECT * FROM Clientes WHERE CorreoElectronico IS NULL AND YEAR(FechaAlta) = 2017 AND Apellido LIKE 'O%' ORDER BY FechaAlta ASC

SELECT * FROM Clientes WHERE Telefono IS NULL AND Celular IS NULL AND YEAR(FechaAlta) = 2019 AND Apellido LIKE 'P%' ORDER BY FechaAlta ASC

-- Ejercicio 23
SELECT TOP 1 WITH TIES * FROM Pedidos ORDER BY MontoTotal DESC