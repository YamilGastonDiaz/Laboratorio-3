CREATE DATABASE RecuperatorioSegundoParcial2024C

GO

USE RecuperatorioSegundoParcial2024C

GO

CREATE TABLE TipoJuguete(
    ID_TipoJuguete INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    NombreTipo VARCHAR(50) NOT NULL
)

GO

CREATE TABLE Edicion (
    ID_Edicion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NombreEdicion VARCHAR(50) NOT NULL DEFAULT 'Normal'
)

GO

CREATE TABLE Juguetes(
    ID_Juguete INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre VARCHAR(50) NOT NULL UNIQUE,
    Valor MONEY NOT NULL,
    ID_Tipo INT NOT NULL FOREIGN KEY REFERENCES TipoJuguete(ID_TipoJuguete),
    ID_Edicion INT NOT NULL FOREIGN KEY REFERENCES Edicion(ID_Edicion)
)

GO
Create Table Clientes(
    ID_Cliente INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    Nombres Varchar(50) not null,
    Apellidos varchar(50) not null
)
Go
CREATE TABLE Ventas(
    ID_Venta INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    ID_Cliente INT NOT NULL FOREIGN KEY REFERENCES Clientes(ID_Cliente),
    ID_Juguete INT NOT NULL FOREIGN KEY REFERENCES Juguetes (ID_Juguete),
    CantidadVendida INT NOT NULL,
    FechaVenta DATE NOT NULL,
    Estado BIT NOT NULL DEFAULT 1
)


INSERT INTO TipoJuguete (NombreTipo) VALUES ('Muñecos');
INSERT INTO TipoJuguete (NombreTipo) VALUES ('Bloques de construcción');
INSERT INTO TipoJuguete (NombreTipo) VALUES ('Juegos de mesa');
INSERT INTO TipoJuguete (NombreTipo) VALUES ('Vehículos');
INSERT INTO TipoJuguete (NombreTipo) VALUES ('Peluches');


INSERT INTO Edicion (NombreEdicion) VALUES ('Normal');
INSERT INTO Edicion (NombreEdicion) VALUES ('Especial');

INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Hot Wheels Ford Mustang GT', 1499.99, 4, 1);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Osito cariñosito Los Simpsons', 899.50, 5, 1);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Muñeca articulada', 1299.75, 1, 2);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Camión de bomberos', 1999.00, 4, 1);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Juego de ajedrez', 799.99, 3, 1);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Castillo LEGO', 2499.50, 2, 2);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Avión de juguete', 1799.99, 4, 1);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Castillo de Shrek', 1599.25, 2, 2);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Pelota mágica', 499.90, 5, 2);
INSERT INTO Juguetes (Nombre, Valor, ID_Tipo, ID_Edicion) VALUES ('Argentinosaurus', 699.99, 1, 1);


INSERT INTO Clientes (Nombres, Apellidos) Values('Juan', 'Gonzalez')
INSERT INTO Clientes (Nombres, Apellidos) Values('Maria', 'Lopez')
INSERT INTO Clientes (Nombres, Apellidos) Values('Carolina', 'Perez')

INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,1, 3, '2024-11-01', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,2, 5, '2024-11-02', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,3, 2, '2024-11-03', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,4, 4, '2024-11-04', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,5, 6, '2024-11-05', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,6, 3, '2024-11-06', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (1,7, 2, '2024-11-07', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (2,8, 1, '2024-11-08', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (2,9, 4, '2024-11-09', 1);
INSERT INTO Ventas (ID_Cliente, ID_Juguete, CantidadVendida, FechaVenta, Estado) VALUES (2,10, 5, '2024-11-10', 1);