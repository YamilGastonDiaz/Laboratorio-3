CREATE DATABASE ActividadDos

USE ActividadDos

CREATE TABLE LIBROS(
    Libro_id BIGINT NOT NULL IDENTITY(1, 1),
    LibroTitulo VARCHAR(40) NOT NULL,
    AnioPublicado DATE NOT NULL,
    PRIMARY KEY (Libro_id)
)

CREATE TABLE GENEROS_LITERARIOS(
    Genero_id TINYINT NOT NULL IDENTITY(1, 1),
    Nombre VARCHAR(30) NOT NULL,
    PRIMARY KEY (Genero_id)
)

CREATE TABLE GENEROS_X_LIBROS(
    Libro_id BIGINT NOT NULL,
    Genero_id TINYINT NOT NULL,
    PRIMARY KEY (Libro_id, Genero_id),
    FOREIGN KEY (Libro_id) REFERENCES LIBROS (Libro_id),
    FOREIGN KEY (Genero_id) REFERENCES GENEROS_LITERARIOS (Genero_id)
)

CREATE TABLE PAISES(
    Pais_id INT NOT NULL IDENTITY(1, 1),
    NombrePais VARCHAR(50) NOT NULL,
    PRIMARY KEY (Pais_id)
)

CREATE TABLE AUTORES(
    Autor_id BIGINT NOT NULL IDENTITY(1, 1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Pais_id INT NOT NULL,
    PRIMARY KEY (Autor_id),
    FOREIGN KEY (Pais_id) REFERENCES PAISES (Pais_id)
)

CREATE TABLE LIBROS_X_AUTORES(
    Autor_id BIGINT NOT NULL,
    Libro_id BIGINT NOT NULL,
    PRIMARY KEY (Autor_id, Libro_id),
    FOREIGN KEY (Autor_id) REFERENCES AUTORES (Autor_id),
    FOREIGN KEY (Libro_id) REFERENCES LIBROS (Libro_id)
)

CREATE TABLE CORREOS(
    Correo_id BIGINT NOT NULL IDENTITY(1, 1),
    NombreCorreo VARCHAR(100) NOT NULL,
    PRIMARY KEY (Correo_id)
)

CREATE TABLE CLIENTES(
    Cliente_id BIGINT NOT NULL IDENTITY(1, 1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Dni INT NOT NULL,
    Correo_id BIGINT NOT NULL,
    PRIMARY KEY (Cliente_id),
    FOREIGN KEY (Correo_id) REFERENCES CORREOS (Correo_id)
)

CREATE TABLE CLIENTES_X_LIBROS(
    Cliente_id BIGINT NOT NULL,
    Libro_id BIGINT NOT NULL,
    FechaAdquirido DATE NOT NULL,
    Puntaja TINYINT NOT NULL,
    PRIMARY KEY (Cliente_id, Libro_id),
    FOREIGN KEY (Cliente_id) REFERENCES CLIENTES (Cliente_id),
    FOREIGN KEY (Libro_id) REFERENCES LIBROS (Libro_id)
)