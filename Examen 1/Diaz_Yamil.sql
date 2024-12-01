USE ExamenRestaurant


--¿Cuál de los siguientes mozos no recibió nunca una propina de $18.500?
SELECT M.Apellidos, M.Nombres
FROM Mozos AS M
WHERE M.IDMozo NOT IN (
    SELECT SM.IDMozo
    FROM ServiciosMesa AS SM
    WHERE SM.Propina = 18500
)

--¿Qué platos han demorado en promedio en su preparación más de 24 minutos?
SELECT AUX.Nombre, AUX.TiempoPromedio
FROM
(
SELECT P.Nombre,
    (
        SELECT AVG(SM.TiempoPreparacion) FROM ServiciosMesa AS SM
        WHERE P.IDPlato = SM.IDPlato
    ) AS TiempoPromedio
FROM Platos AS P
) AS AUX
WHERE AUX.TiempoPromedio >= 24

--¿Cuál fue el mozo/a que en promedio haya recibido la mayor cantidad de dinero en concepto de propinas?
SELECT TOP 1 M.Apellidos, M.Nombres,
    (
        SELECT AVG(Propina) FROM ServiciosMesa AS SM
        WHERE M.IDMozo = SM.IDMozo
    ) AS PromedioPropina
FROM Mozos AS M
ORDER BY PromedioPropina DESC

--¿Cuál fue la cantidad de servicios de mesa que pagaron un importe de plato menor a la mitad del importe de plato promedio.?
SELECT COUNT(*) AS CantidadServicios
FROM ServiciosMesa AS SM
WHERE SM.ImportePlato < (
    SELECT AVG(SM.ImportePlato) / 2
    FROM ServiciosMesa AS SM
)

--Agrega las tablas, columnas y restricciones que consideres necesario para poder registrar los cocineros del restaurant.

--Debe poder registrarse el apellido, nombre, fecha de nacimiento y fecha de ingreso al restaurant. También se
--debe poder conocer qué cocineros participaron en cada servicio de mesa. Tener en cuenta que es posible que
--más de un cocinero haya trabajo en el mismo servicio de mesa.

CREATE TABLE Cocineros (
    Cocinero_id INT NOT NULL IDENTITY(1, 1),
    Apellido VARCHAR(50) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Fecha_nacimiento DATE NOT NULL,
    Fecha_ingreso DATE NOT NULL,
    PRIMARY KEY(Cocinero_id)
)

CREATE TABLE Cocineros_x_Servicios(
    Cocinero_id INT NOT NULL,
    IDServicioMesa BIGINT NOT NULL,
    PRIMARY KEY (Cocinero_id, IDServicioMesa),
    FOREIGN KEY (Cocinero_id) REFERENCES Cocineros(Cocinero_id),
    FOREIGN KEY (IDServicioMesa) REFERENCES ServiciosMesa (IDServicioMesa)
)
