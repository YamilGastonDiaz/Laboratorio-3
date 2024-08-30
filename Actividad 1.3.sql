CREATE DATABASE ActividadTres

USE ActividadTres

CREATE TABLE PAISES(
    Pais_id BIGINT NOT NULL IDENTITY(1, 1),
    NombrePais VARCHAR(100) NOT NULL,
    PRIMARY KEY (Pais_id)
)

CREATE TABLE CIUDADES(
    Ciudad_id BIGINT NOT NULL IDENTITY(1, 1),
    NombreCiudad VARCHAR(100) NOT NULL,
    PRIMARY KEY (Ciudad_id)
)

CREATE TABLE TORNEOS(
    Torneo_id SMALLINT NOT NULL IDENTITY(1, 1),
    NombreTorneo VARCHAR(100) NOT NULL,
    PremioDinero SMALLMONEY NOT NULL,
    CostoInscripcion SMALLMONEY NOT NULL,
    Pais_id BIGINT NOT NULL,
    Ciudad_id BIGINT NOT NULL,
    FechaTorneo DATE NOT NULL,
    PRIMARY KEY (Torneo_id),
    FOREIGN KEY (Pais_id) REFERENCES PAISES (Pais_id),
    FOREIGN KEY (Ciudad_id) REFERENCES CIUDADES (Ciudad_id)
)

CREATE TABLE PARTICIPANTES(
    Participante_id TINYINT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Pais_id BIGINT NOT NULL,
    PRIMARY KEY (Participante_id),
    FOREIGN KEY (Pais_id) REFERENCES PAISES (Pais_id)
)

CREATE TABLE PARTICIPANTES_X_TORNEOS(
    Torneo_id SMALLINT NOT NULL,
    Participante_id TINYINT NOT NULL,
    PRIMARY KEY (Torneo_id, Participante_id),
    FOREIGN KEY (Torneo_id) REFERENCES TORNEOS (Torneo_id),
    FOREIGN KEY (Participante_id) REFERENCES PARTICIPANTES (Participante_id)
)

CREATE TABLE ESPECIES_PECES(
    Especies_id BIGINT NOT NULL IDENTITY(1, 1),
    NombreEspecie VARCHAR(50) NOT NULL,
    PRIMARY KEY (Especies_id)
)

CREATE TABLE CAPTURAS(
    Captura_id TINYINT NOT NULL IDENTITY(1, 1),
    Especies_id BIGINT NOT NULL,
    Peso DECIMAL NOT NULL,
    HoraCaptura TIME NOT NULL,
    PRIMARY KEY (Captura_id),
    FOREIGN KEY (Especies_id) REFERENCES ESPECIES_PECES (Especies_id)
)

CREATE TABLE ESPECIES_X_PARTICIPANTES (
    Participante_id TINYINT NOT NULL,
    Especies_id BIGINT NOT NULL,
    PRIMARY KEY (Participante_id, Especies_id),
    FOREIGN KEY (Participante_id) REFERENCES PARTICIPANTES (Participante_id),
    FOREIGN KEY (Especies_id) REFERENCES ESPECIES_PECES (Especies_id)
)

CREATE TABLE ESPECIES_X_TORNEOS (
    Torneo_id SMALLINT NOT NULL,
    Especies_id BIGINT NOT NULL,
    PRIMARY KEY (Torneo_id, Especies_id),
    FOREIGN KEY (Torneo_id) REFERENCES TORNEOS (Torneo_id),
    FOREIGN KEY (Especies_id) REFERENCES ESPECIES_PECES (Especies_id)
)

CREATE TABLE CAPTURAS_X_PARTICIPANTES (
    Captura_id TINYINT NOT NULL,
    Participante_id TINYINT NOT NULL,
    PRIMARY KEY (Captura_id, Participante_id),
    FOREIGN KEY (Captura_id) REFERENCES CAPTURAS (Captura_id),
    FOREIGN KEY (Participante_id) REFERENCES PARTICIPANTES (Participante_id)
)

CREATE TABLE CAPTURAS_X_TORNEOS (
    Captura_id TINYINT NOT NULL,
    Torneo_id SMALLINT NOT NULL,
    PRIMARY KEY (Captura_id, Torneo_id),
    FOREIGN KEY (Captura_id) REFERENCES CAPTURAS (Captura_id),
    FOREIGN KEY (Torneo_id) REFERENCES TORNEOS (Torneo_id)
)