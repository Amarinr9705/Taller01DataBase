-- Crear base de datos
CREATE DATABASE Biblioteca;
GO
USE Biblioteca;
GO


-- TABLAS PRINCIPALES


CREATE TABLE Autor (
    id_autor INT IDENTITY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    es_corporativo BIT NOT NULL,
    CONSTRAINT pk_Autor_Id PRIMARY KEY (id_autor)
);


CREATE TABLE Editorial (
    id_editorial INT IDENTITY NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    contacto VARCHAR(255) NOT NULL,
    CONSTRAINT pk_Editorial_Id PRIMARY KEY (id_editorial)
);


CREATE TABLE TipoPublicacion (
    id_tipo_publicacion INT IDENTITY NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    CONSTRAINT pk_TipoPublicacion_Id PRIMARY KEY (id_tipo_publicacion)
);

CREATE TABLE Descriptor (
    id_descriptor INT IDENTITY NOT NULL,
    descriptor VARCHAR(50) NOT NULL,
    CONSTRAINT pk_Descriptor_Id PRIMARY KEY (id_descriptor)
);


-- TABLA PUBLICACION

CREATE TABLE Publicacion (
    id_publicacion INT IDENTITY NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    idioma VARCHAR(50) NOT NULL,
    num_paginas INT NOT NULL,
    id_editorial INT NOT NULL,
    id_tipo_publicacion INT NOT NULL,
    CONSTRAINT pk_Publicacion_Id PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_Publicacion_IdEditorial FOREIGN KEY (id_editorial) REFERENCES Editorial(id_editorial),
    CONSTRAINT fk_Publicacion_IdTipoPublicacion FOREIGN KEY (id_tipo_publicacion) REFERENCES TipoPublicacion(id_tipo_publicacion)
);


-- TABLAS HIJAS DE PUBLICACION


CREATE TABLE Libro (
    id_publicacion INT NOT NULL,
    issn VARCHAR(13),
    edicion VARCHAR(60),
    capitulos INT,
    CONSTRAINT pk_Libro_Id PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_Libro_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

CREATE TABLE Revista (
    id_publicacion INT NOT NULL,
    issn VARCHAR(13),
    numero INT,
    volumen INT,
    CONSTRAINT pk_Revista_Id PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_Revista_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

CREATE TABLE Tesis (
    id_publicacion INT NOT NULL,
    universidad VARCHAR(255),
    grado VARCHAR(100),
    asesor VARCHAR(100),
    CONSTRAINT pk_Tesis_Id PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_Tesis_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

CREATE TABLE Periodico (
    id_publicacion INT NOT NULL,
    isbn VARCHAR(13),
    numero_ejemplar INT,
    CONSTRAINT pk_Periodico_Id PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_Periodico_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

CREATE TABLE Articulos (
    id_publicacion INT NOT NULL,
    rango_paginas VARCHAR(50) NOT NULL,
    CONSTRAINT pk_Articulos_Id PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_Articulos_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);


-- TABLAS PUENTE (N:M)


CREATE TABLE AutorPublicacion (
    id_autor INT NOT NULL,
    id_publicacion INT NOT NULL,
    CONSTRAINT pk_AutorPublicacion PRIMARY KEY (id_autor, id_publicacion),
    CONSTRAINT fk_AutorPublicacion_IdAutor FOREIGN KEY (id_autor) REFERENCES Autor(id_autor),
    CONSTRAINT fk_AutorPublicacion_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);

CREATE TABLE DescriptorPublicacion (
    id_descriptor INT NOT NULL,
    id_publicacion INT NOT NULL,
    CONSTRAINT pk_DescriptorPublicacion PRIMARY KEY (id_descriptor, id_publicacion),
    CONSTRAINT fk_DescriptorPublicacion_IdDescriptor FOREIGN KEY (id_descriptor) REFERENCES Descriptor(id_descriptor),
    CONSTRAINT fk_DescriptorPublicacion_IdPublicacion FOREIGN KEY (id_publicacion) REFERENCES Publicacion(id_publicacion)
);
