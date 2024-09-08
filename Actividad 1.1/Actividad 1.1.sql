CREATE DATABASE ActividadUno

USE ActividadUno

CREATE TABLE  ESTUDIANTES(
    Estudiante_id BIGINT NOT NULL IDENTITY(1, 1),
    Apellido VARCHAR(50) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Ciudad VARCHAR(50),
    FechaIngreso DATE NOT NULL DEFAULT(GETDATE()),
    PRIMARY KEY (Estudiante_id)
)

CREATE TABLE TIPOS_INSTRUMENTOS(
    TipoInstrumento_id TINYINT NOT NULL IDENTITY(1, 1),
    NombreTipo VARCHAR(50) NOT NULL,
    PRIMARY KEY (TipoInstrumento_id)
)

CREATE TABLE INSTRUMENTOS(
    Intrumentos_id VARCHAR(15) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    TipoInstrumento_id TINYINT NOT NULL,
    PRIMARY KEY (Intrumentos_id),
    FOREIGN KEY (TipoInstrumento_id) REFERENCES TIPOS_INSTRUMENTOS (TipoInstrumento_id)
)

CREATE TABLE INSTRUMETOS_X_ESTUDIANTES(
    Estudiante_id BIGINT NOT NULL,
    Intrumentos_id VARCHAR(15) NOT NULL,
    PRIMARY KEY (Estudiante_id, Intrumentos_id),
    FOREIGN KEY (Estudiante_id) REFERENCES ESTUDIANTES (Estudiante_id),
    FOREIGN KEY (Intrumentos_id) REFERENCES INSTRUMENTOS (Intrumentos_id)
)