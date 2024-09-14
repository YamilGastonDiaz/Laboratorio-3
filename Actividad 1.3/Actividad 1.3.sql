CREATE DATABASE ActividadTres

USE ActividadTres

CREATE TABLE PAISES(
    Pais_id INT NOT NULL IDENTITY(1, 1),
    NombrePais VARCHAR(100) NOT NULL,
    PRIMARY KEY (Pais_id),
)

CREATE TABLE CIUDADES(
    Ciudad_id INT NOT NULL IDENTITY(1, 1),
    NombreCiudad VARCHAR(100) NOT NULL,
    Pais_id INT NOT NULL
    PRIMARY KEY (Ciudad_id),
    FOREIGN KEY (Pais_id) REFERENCES PAISES (Pais_id)
)

CREATE TABLE TORNEOS(
    Torneo_id INT NOT NULL IDENTITY(1, 1),
    NombreTorneo VARCHAR(100) NOT NULL,
    FechaTorneoInicio DATE NOT NULL,
    FechaTorneoFin DATE NOT NULL,
    PremioDinero SMALLMONEY NOT NULL,
    Ciudad_id INT NOT NULL,
    PRIMARY KEY (Torneo_id),
    FOREIGN KEY (Ciudad_id) REFERENCES CIUDADES (Ciudad_id)
)

CREATE TABLE PARTICIPANTES(
    Participante_id INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Pais_id INT NOT NULL,
    PRIMARY KEY (Participante_id),
    FOREIGN KEY (Pais_id) REFERENCES PAISES (Pais_id)
)

CREATE TABLE INSCRIPCIONES(
    Inscripcion_id BIGINT NOT NULL,
    FechaInscripcion DATE NOT NULL,
    Participante_id INT NOT NULL,
    Torneo_id INT NOT NULL,
    PRIMARY KEY (Inscripcion_id),
    FOREIGN KEY (Participante_id) REFERENCES PARTICIPANTES (Participante_id),
    FOREIGN KEY (Torneo_id) REFERENCES TORNEOS (Torneo_id)
)

CREATE TABLE ESPECIES_PECES(
    Especies_id INT NOT NULL IDENTITY(1, 1),
    NombreEspecie VARCHAR(50) NOT NULL,
    PRIMARY KEY (Especies_id)
)

CREATE TABLE ESPECIES_X_TORNEOS (
    Torneo_id INT NOT NULL,
    Especies_id INT NOT NULL,
    PRIMARY KEY (Torneo_id, Especies_id),
    FOREIGN KEY (Torneo_id) REFERENCES TORNEOS (Torneo_id),
    FOREIGN KEY (Especies_id) REFERENCES ESPECIES_PECES (Especies_id)
)

CREATE TABLE CAPTURAS(
    Captura_id INT NOT NULL IDENTITY(1, 1),
    Participante_id INT NOT NULL,
    Torneo_id INT NOT NULL,
    Especies_id INT NOT NULL,
    Peso FLOAT NOT NULL,
    HoraCaptura TIME NOT NULL,
    Tag INT NOT NULL,
    PRIMARY KEY (Captura_id),
    FOREIGN KEY (Participante_id) REFERENCES  PARTICIPANTES (Participante_id),
    FOREIGN KEY (Torneo_id) REFERENCES TORNEOS (Torneo_id),
    FOREIGN KEY (Especies_id) REFERENCES ESPECIES_PECES (Especies_id)
)
