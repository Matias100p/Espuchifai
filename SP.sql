USE Espochifai;

-- 1)Realizar los SP para dar de alta todas las entidades menos las tablas Cliente y Reproducción. En la tabla reproducción el SP se debe llamar ‘Reproducir’.

DELIMITER $$

drop procedure
    if exists Altabanda $$
create procedure
    Altabanda(
        unidBanda TINYINT,
        unidAlbum int,
        unnombre VARCHAR(50),
        unfundacion DATE
    ) begin
insert into
    banda(
        idbanda,
        idalbum,
        nombre,
        fundacion
    ) value(
        unidBanda,
        unidAlbum,
        unnombre,
        unfundacion
    );

end $$

DELIMITER $$

DROP PROCEDURE
    if exists AltaAlbum $$
create procedure
    AltaAlbum(
        unidAlbum int,
        unidCancion TINYINT,
        unnombre VARCHAR(45),
        unlanzamiento DATE
    ) begin
insert into
    Album (
        idAlbum,
        idCancion,
        nombre,
        lanzamiento
    ) value (
        unidAlbum,
        unidCancion,
        unnombre,
        unlanzamiento
    );

end $$

DELIMITER $$

DROP PROCEDURE
    if exists AltaCancion $$
create procedure
    AltaCancion(
        unidCancion bigint,
        unnombre VARCHAR(45),
        unnumero_ord TINYINT
    ) begin
insert into
    Cancion(idCancion, nombre, numero_ord) value(
        unidCancion,
        unnombre,
        unnumero_ord
    );

end $$

DELIMITER $$

DROP PROCEDURE
    if exists Reproducir $$
create procedure
    Reproducir(
        unidReproduccion SMALLINT,
        unidCliente SMALLINT,
        unidCancion bigint,
        untiempo_repro DATETIME
    ) begin
insert into
    reproducir(
        idReproduccion,
        idCliente,
        idCancion,
        tiempo_repro
    ) value(
        unidReproduccion,
        unidCliente,
        unidCancion,
        untiempo_repro
    );

end $$ -- 2)Se pide hacer el SP ‘registrarCliente’ que reciba los datos del cliente. Es importante guardar encriptada la contraseña del cliente usando SHA256.

DELIMITER $$

DROP PROCEDURE
    if exists registrarCliente $$
create procedure
    registrarCliente(
        unidCliente SMALLINT,
        unnombre VARCHAR(45),
        unapellido VARCHAR(45),
        unemail VARCHAR(45),
        uncontrasena CHAR(20)
    ) begin
insert into
    Cliente (
        idCliente,
        nombre,
        apellido,
        email,
        contrasena
    ) value (
        unidCliente,
        unnombre,
        unapellido,
        unemail,
        sha2(uncontrasena, 256)
    );

end $$ -- 3)Se pide hacer el SF ‘CantidadReproduccionesBanda’ que reciba por parámetro un identificador de banda y 2 fechas, se debe devolver la cantidad de reproducciones que tuvieron las canciones de esa banda entre esas 2 fechas (inclusive).

DELIMITER $$

drop function
    if exists CantidadReproduccionesBanda $$
create function
    CantidadReproduccionesBanda (
        unidBanda TINYINT,
        fecha1 DATETIME,
        fecha2 DATETIME
    ) RETURNS INT READS SQL DATA begin DECLARE CantRepro INT;

SELECT
    COUNT(*) INTO CantRepro
FROM reproducir
WHERE
    tiempo_repro BETWEEN FECHA1 AND FECHA2;

RETURN CantRepro;

end $$ --4)

DELIMITER $$

DROP PROCEDURE IF EXISTS Buscar $$
CREATE PROCEDURE Buscar (cadena VARCHAR(45))
begin
    SELECT *
    FROM Cancion
    JOIN Album USING (idAlbum)
    JOIN Banda USING (idBanda)
    WHERE MATCH ( Cancion.nombre, Album.nombre, Banda.nombre) AGAINST (‘cadena’);
end $$

CALL AltaCancion(1,'la vaca lola',1);
CALL AltaAlbum(1, 1,'WASD','2012-03-03');
CALL Altabanda(1,1,'SSD','1990-04-05');
CALL registrarCliente(1,'EL','MATI','ELMATI2@GMAIL.COM','POLS');
CALL Reproducir(1,1,1,NOW());
