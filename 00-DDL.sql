DROP DATABASE IF EXISTS Espochifai;
CREATE DATABASE Espochifai;
USE Espochifai;

create Table Album(
    idAlbum TINYINT NOT NULL,
    idCancion TINYINT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    lanzamiento DATE NOT NULL,
    PRIMARY KEY (idAlbum),
    CONSTRAINT UQ_Album_nombre UNIQUE (nombre)
);
create table Banda(
    idBanda TINYINT NOT NULL,
    idAlbum TINYINT not null, 
    nombre VARCHAR(50) not null,
    fundacion DATE not null,
    PRIMARY KEY (idBanda),
    CONSTRAINT FK_Banda_Album FOREIGN KEY (idAlbum)
        REFERENCES Album (idAlbum),
    CONSTRAINT UQ_Banda_nombre UNIQUE (nombre)
);
create Table Cancion(
    idCancion TINYINT NOT NULL,
    nombre VARCHAR(45) not NULL,
    numero_ord INT not NULL,
    PRIMARY KEY (idCancion),
    CONSTRAINT UQ_Cancion_nombre UNIQUE (nombre)
    
);
create Table Cliente(
    idCliente SMALLINT not null,
    nombre VARCHAR(45) not null,
    apellido VARCHAR(45) not NULL,
    email VARCHAR(45) not NULL,
    contrasena CHAR(20) not NULL,
    PRIMARY KEY (idCliente)
);
create Table Reproduccion(
    idReproduccion SMALLINT not NULL,
    idCliente SMALLINT not NULL,
    idCancion TINYINT NOT NULL,
    tiempo_repro DATETIME NOT NULL,
    PRIMARY KEY (idReproduccion),
    CONSTRAINT FK_Cliente_Reproduccion FOREIGN KEY (idCliente) 
        REFERENCES Cliente (idCliente),
    CONSTRAINT FK_Cancion_Reproduccion FOREIGN KEY (idCancion) 
        REFERENCES Cancion (idCancion)
);
