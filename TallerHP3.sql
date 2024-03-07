create database Biblioteca;
use Biblioteca;

CREATE TABLE Autores (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
nacionalidad VARCHAR(100),
fechaNacimiento DATE
);
CREATE TABLE Usuarios (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(255),
fechaNacimiento DATE
);

CREATE TABLE Editoriales (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(255),
fundacion DATE
);
CREATE TABLE Categorias (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(255)
);
CREATE TABLE Libros (
id INT PRIMARY KEY,
titulo VARCHAR(255) NOT NULL,
autorId INT,
editorialId INT,
categoriaId INT,
fechaPublicacion DATE,
disponibilidad  BOOLEAN,
FOREIGN KEY (autorId) REFERENCES Autores(id),
FOREIGN KEY (editorialId) REFERENCES Editoriales(id),
FOREIGN KEY (categoriaId) REFERENCES Categorias(id)
);
CREATE TABLE Biblioteca (
id INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(255),
telefono VARCHAR(20),
fecha_creacion DATE
);

-- Insertar datos en la tabla Biblioteca
INSERT INTO Biblioteca (id, nombre, direccion, telefono,
fecha_creacion)
VALUES
(1, 'Biblioteca Central', 'Calle Principal 123', '123-456-7890',
'1990-01-01'),
(2, 'Biblioteca Municipal', 'Avenida Central 456',
'098-765-4321', '1985-05-15');
-- Insertar datos en la tabla Autores
INSERT INTO Autores (id, nombre, nacionalidad, fechaNacimiento)
VALUES
(1, 'Gabriel García Márquez', 'Colombiano', '1927-03-06'),
(2, 'J.K. Rowling', 'Británica', '1965-07-31'),
(3, 'Stephen King', 'Estadounidense', '1947-09-21');
-- Insertar datos en la tabla Editoriales
INSERT INTO Editoriales (id, nombre, direccion, fundacion)
VALUES
(1, 'Salamandra', 'Barcelona, España', '1994-01-01'),
(2, 'Penguin Random House', 'New York, USA', '2013-07-01');
-- Insertar datos en la tabla Categorias
INSERT INTO Categorias (id, nombre, descripcion)
VALUES
(1, 'Ficción', 'Libros de ficción'),
(2, 'No ficción', 'Libros de no ficción'),
(3, 'Fantasía', 'Libros de fantasía'),
(4, 'Terror', 'Libros de terror'),
(5, 'Drama', 'Libros de drama');
-- Insertar datos en la tabla Libros
INSERT INTO Libros (id, titulo, autorId, editorialId, categoriaId,
fechaPublicacion)
VALUES
(1, 'Cien años de soledad', 1, 1, 1, '1967-05-30'),
(2, 'Harry Potter y la piedra filosofal', 2, 1, 3, '1997-06-26'),
(3, 'It', 3, 2, 4, '1986-09-15'),

-- Agrega más libros para cumplir con el requisito
(4, 'Crónica de una muerte anunciada', 1, 1, 1, '1981-01-01'),
(5, 'Harry Potter y la cámara secreta', 2, 1, 3, '1998-07-02'),
(6, 'Harry Potter y el prisionero de Azkaban', 2, 1, 3,
'1999-07-08'),
(7, 'Carrie', 3, 2, 4, '1974-04-05'),
(8, 'The Shining', 3, 2, 4, '1977-01-28'),
(9, 'La torre oscura', 3, 2, 4, '1982-06-10'),
(10, 'Noticias del imperio', 1, 1, 1, '1986-01-01'),
(11, 'La hojarasca', 1, 1, 1, '1955-01-01'),
(12, 'El amor en los tiempos del cólera', 1, 1, 1, '1985-01-01'),
(13, 'Harry Potter y el cáliz de fuego', 2, 1, 3, '2000-07-08'),
(14, 'Harry Potter y la Orden del Fénix', 2, 1, 3, '2003-06-21'),
(15, 'Harry Potter y el misterio del príncipe', 2, 1, 3,
'2005-07-16');

drop Procedure IF EXISTS PrimerPunto;
DELIMITER //

CREATE PROCEDURE PrimerPunto()
BEGIN
    DECLARE My_Autor VARCHAR(150) DEFAULT 'J.K. Rowling';
    SELECT * from Libros l join Autores a on l.autorId = a.id where a.nombre = My_Autor;
END //

DELIMITER ;

call PrimerPunto();


drop Procedure IF EXISTS SegundoPunto;
DELIMITER //

CREATE PROCEDURE SegundoPunto()
BEGIN
    DECLARE My_Categoria VARCHAR(150) DEFAULT 'Ficción';
    SELECT * from Libros l join Categorias c on l.categoriaId = c.id where c.nombre = My_Categoria;
END //

DELIMITER ;

call SegundoPunto();



drop Procedure IF EXISTS TerceroPunto;
DELIMITER //
CREATE PROCEDURE TerceroPunto()
BEGIN
    DECLARE Gabriel VARCHAR(150) DEFAULT 'Gabriel García Márquez';
    SELECT * from Libros l join Autores a on l.autorId = a.id where a.nombre = Gabriel and l.fechaPublicacion > '1970-01-01';
END //

DELIMITER ;

call TerceroPunto();


drop Procedure IF EXISTS CuartoPunto;
DELIMITER //
CREATE PROCEDURE CuartoPunto()
BEGIN
    DECLARE My_Categoria VARCHAR(150) DEFAULT 'Terror';
    SELECT * from Libros l join Categorias c on l.categoriaId = c.id where c.nombre = My_Categoria and l.fechaPublicacion > '1976-01-01';
END //

DELIMITER ;

call CuartoPunto();


drop Procedure IF EXISTS sextoPunto;
DELIMITER //
CREATE PROCEDURE sextoPunto(Editorial varchar(150))
BEGIN
	SELECT * from Libros l join Editoriales e on l.editorialId = e.id where e.nombre = Editorial;

END //

DELIMITER ;
call sextoPunto('Penguin Random House');


drop Procedure IF EXISTS SeptimoPunto;
DELIMITER //
CREATE PROCEDURE SeptimoPunto(Categoria varchar(150))
BEGIN
    SELECT * from Libros l join Categorias c on l.categoriaId = c.id 
    where c.nombre = Categoria
	ORDER BY l.fechaPublicacion DESC
    LIMIT 1;
END //

DELIMITER ;
call SeptimoPunto('Terror');