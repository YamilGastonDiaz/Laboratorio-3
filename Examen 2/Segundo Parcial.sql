Create Database SegundoParcial20242C
go
Use SegundoParcial20242C
go
Create Table Provincias(
    ID_Provincia int not null primary key identity (1, 1),
    Nombre varchar(50) not null,
    ImpuestoImportacion decimal(10, 2) null -- Por ej: 25 es 25% de recargo. NULL si no tiene recargo.
)
go
Create Table Clientes(
    ID_Cliente int not null primary key identity (1, 1),
    ID_Provincia int not null foreign key references Provincias(ID_Provincia),
    Apellidos varchar(100) not null,
    Nombres varchar(100) not null,
    Domicilio varchar(200) not null
)
go
Create Table Importaciones(
    ID_Importacion bigint not null primary key identity (1, 1),
    ID_Cliente int not null foreign key references Clientes(ID_Cliente),
    Descripcion varchar(200),
    Fecha date,
    Valor money,
    Arancel money,
    Pagado bit
)
GO
Create Table Envios(
    ID_Importacion bigint not null primary key foreign key references Importaciones(ID_Importacion),
    FechaEstimada date,
    Costo money
)
go
-- Provincias
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('Buenos Aires', 5);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('Cordoba', 11);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('Santa Fe', 17);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('Entre Rios', 28);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('Tucumán', null);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('Mendoza', null);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('La Pampa', null);
    INSERT INTO Provincias (Nombre, ImpuestoImportacion) VALUES ('San Juan', null);

-- Clientes
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (5, 'Gonzalez', 'Juan', 'Av. Mitre 123');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (4, 'Rodriguez', 'María', 'Av. San Martin 456');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (1, 'Sanchez', 'Pedro', 'Av. 9 de Julio 789');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (7, 'Perez', 'Lucia', 'Av. Corrientes 123');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (8, 'Gomez', 'Diego', 'Av. Rivadavia 456');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (2, 'Martinez', 'Ana', 'Av. Belgrano 789');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (3, 'Diaz', 'Carlos', 'Av. La Plata 123');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (6, 'Lopez', 'Sofia', 'Av. San Juan 456');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (5, 'Ramirez', 'Jorge', 'Av. Salta 789');
    INSERT INTO Clientes (ID_Provincia, Apellidos, Nombres, Domicilio) VALUES (1, 'Jimenez', 'Luciana', 'Av. Córdoba 123');

-- Importaciones
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (1, 'Importación de electrodomésticos', '2023-01-15', 150000.00, 7500.00, 1);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (1, 'Importación de muebles', '2023-03-20', 85000.00, 4250.00, 0);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (2, 'Importación de vehículos', '2023-06-05', 350000.00, 17500.00, 1);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (2, 'Importación de maquinaria agrícola', '2023-07-18', 275000.00, 13750.00, 0);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (3, 'Importación de textiles', '2023-09-12', 60000.00, 3000.00, 1);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (3, 'Importación de calzado', '2023-11-25', 45000.00, 2250.00, 0);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (4, 'Importación de herramientas', '2023-04-10', 90000.00, 4500.00, 1);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (4, 'Importación de productos químicos', '2023-08-20', 120000.00, 6000.00, 0);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (5, 'Importación de alimentos', '2023-02-15', 70000.00, 3500.00, 1);
INSERT INTO Importaciones (ID_Cliente, Descripcion, Fecha, Valor, Arancel, Pagado) VALUES (5, 'Importación de bebidas', '2023-10-05', 80000.00, 4000.00, 0);

-- Envios
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (1, '2023-02-01', 5000.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (2, '2023-04-01', 3000.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (3, '2023-06-20', 12000.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (4, '2023-08-05', 10000.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (5, '2023-09-01', 2500.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (6, '2023-12-10', 2000.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (7, '2023-05-01', 4000.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (8, '2023-09-15', 7500.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (9, '2023-03-01', 3500.00);
INSERT INTO Envios (ID_Importacion, FechaEstimada, Costo) VALUES (10, '2023-11-01', 4500.00);





