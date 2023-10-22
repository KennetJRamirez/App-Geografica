create database sistema_g;
use sistema_g;
select * from oceano;

CREATE TABLE oceano (
id_oceano INT PRIMARY KEY NOT NULL,
nombre VARCHAR(260)
);

DELIMITER //
CREATE TRIGGER insertar_oceano
BEFORE INSERT ON oceano
FOR EACH ROW
BEGIN
    DECLARE nuevo_id INT;
    SELECT IFNULL(MAX(id_oceano), 0) + 1 INTO nuevo_id FROM oceano;
    SET NEW.id_oceano = nuevo_id;
END;
//
DELIMITER ;

CREATE TABLE continente (
id_continente INT PRIMARY KEY NOT NULL,
nombre VARCHAR(260)
);

DELIMITER //
CREATE TRIGGER insertar_continente
BEFORE INSERT ON continente
FOR EACH ROW
BEGIN
    DECLARE nuevo_id INT;
    SELECT IFNULL(MAX(id_continente), 0) + 1 INTO nuevo_id FROM continente;
    SET NEW.id_continente = nuevo_id;
END;
//
DELIMITER ;

CREATE TABLE tipo_accidente(
id_tipo INT PRIMARY KEY NOT NULL,
nombre VARCHAR(260),
parent_id int
);


DELIMITER //

CREATE TRIGGER insertar_tipo_accidente
BEFORE INSERT ON tipo_accidente
FOR EACH ROW
BEGIN
    DECLARE nuevo_id INT;
    SELECT IFNULL(MAX(id_tipo), 0) + 1 INTO nuevo_id FROM tipo_accidente;
    SET NEW.id_tipo = nuevo_id;
END;
//
DELIMITER ;

create table pais(
id_pais int primary key not null,
nombre VARCHAR(260),
capital VARCHAR(260),
extension double,
idioma_oficial VARCHAR(260),
id_continente int,
FOREIGN KEY (id_continente) REFERENCES continente(id_continente)
);

DELIMITER //
CREATE TRIGGER insertar_pais
BEFORE INSERT ON pais
FOR EACH ROW
BEGIN
    DECLARE nuevo_id INT;
    SELECT IFNULL(MAX(id_pais), 0) + 1 INTO nuevo_id FROM pais;
    SET NEW.id_pais = nuevo_id;
END;
//
DELIMITER ;

CREATE TABLE accidente_geografico (
  id_accidente int NOT NULL primary key,
  nombre varchar(260) ,
  extension double ,
  altura double ,
  ultima_erupcion date ,
  caudal varchar(260) ,
  afluente varchar(260) ,
  origen varchar(260) ,
  desemboque varchar(260) ,
  esSalado boolean ,
  esDulce boolean ,
  id_pais int ,
  id_oceano int ,
  id_tipo int ,
FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
FOREIGN KEY (id_oceano) REFERENCES oceano(id_oceano),
FOREIGN KEY (id_tipo) REFERENCES tipo_accidente(id_tipo)
);

DELIMITER //
CREATE TRIGGER insertar_accidente
BEFORE INSERT ON accidente_geografico
FOR EACH ROW
BEGIN
    DECLARE nuevo_id INT;
    SELECT IFNULL(MAX(id_accidente), 0) + 1 INTO nuevo_id FROM accidente_geografico;
    SET NEW.id_accidente = nuevo_id;
END;
//
DELIMITER ;

-- Insertando continentes --
INSERT INTO continente (nombre) VALUES ('América');
INSERT INTO continente (nombre) VALUES ('África');
INSERT INTO continente (nombre) VALUES ('Asia');
INSERT INTO continente (nombre) VALUES ('Europa');
INSERT INTO continente (nombre) VALUES ('Oceanía');

-- Insertando océanos --
INSERT INTO oceano (nombre) VALUES ('Océano Atlántico');
INSERT INTO oceano (nombre) VALUES ('Océano Pacífico');
INSERT INTO oceano (nombre) VALUES ('Océano Índico');
INSERT INTO oceano (nombre) VALUES ('Océano Antártico');
INSERT INTO oceano (nombre) VALUES ('Océano Ártico');


-- Insertando tipo accidentes --
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Montaña', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Río', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Lago', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Volcán', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Glaciar', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Meseta', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Cañón', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Península', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Islas', NULL);
INSERT INTO tipo_accidente (nombre, parent_id) VALUES ('Delta', NULL);

select * from tipo_accidente;

-- Insertando accidentes --
INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Volcán Popocatépetl', 5452.76, 5426, '2022-01-31', NULL, NULL, 'Tectónico', NULL, 0, 1, 134, NULL, 1);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Monte Everest', NULL, 8848.86, NULL, NULL, NULL, 'Tectónico', NULL, 0, 1, 99, NULL, 2);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Río Danubio', 2850, NULL, NULL, 'Grande', 'Váh, Inn, Isar', 'Manantial', 'Mar Negro', 1, 0, 123, NULL, 3);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Lago Victoria', 68870, NULL, NULL, NULL, NULL, 'Fluvial', NULL, 1, 0, 160, NULL, 4);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Glaciar Aletsch', NULL, NULL, NULL, NULL, NULL, 'Glaciación', NULL, 0, 1, 91, NULL, 5);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Gran Cañón del Colorado', NULL, NULL, NULL, NULL, NULL, 'Erosión', NULL, 1, 0, 227, NULL, 6);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Delta del Ganges', NULL, NULL, NULL, NULL, NULL, 'Fluvial', 'Golfo de Bengala', 1, 0, 99, NULL, 7);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, afluente, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES
('Gran Barrera de Coral', NULL, NULL, NULL, NULL, NULL, 'Formación coralina', NULL, 1, 0, 169, NULL, 8);

INSERT INTO `accidente_geografico` (`nombre`, `extension`, `altura`, `id_tipo`, `id_pais`) VALUES
('Monte Everest', 8884.86, 8848.86, 1, 99),
('Monte Kilimanjaro', 3889.6, 5895, 1, 165);


INSERT INTO `accidente_geografico` (`nombre`, `extension`, `caudal`, `afluente`, `origen`, `desemboque`, `esDulce`, `id_tipo`, `id_pais`) VALUES
('Río Amazonas', 6575, '209,000 m³/s', NULL, 'Nevado Mismi', 'Océano Atlántico', 1, 2, 29),
('Río Nilo', 6650, '2,830 m³/s', NULL, 'Lago Victoria', 'Mediterráneo', 1, 2, 62);


INSERT INTO `accidente_geografico` (`nombre`, `extension`, `id_tipo`, `id_pais`) VALUES
('Lago Titicaca', 8562, 3, 198),
('Lago Baikal', 31492, 3, 185);

INSERT INTO `accidente_geografico` (`nombre`, `altura`, `ultima_erupcion`, `id_tipo`, `id_pais`) VALUES
('Volcán Popocatépetl', 5426, '2021-09-03', 4, 101),
('Volcán Fuji', 3776, '1707-12-16', 4, 109);

INSERT INTO `accidente_geografico` (`nombre`, `extension`, `id_tipo`, `id_pais`) VALUES
('Glaciar Perito Moreno', 250, 5, 12),
('Glaciar Franz Josef', 12, 5, 146);

INSERT INTO `accidente_geografico` (
  `id_accidente`, `nombre`, `extension`, `altura`, `ultima_erupcion`, `caudal`, `afluente`, `origen`, `desemboque`, `esSalado`, `esDulce`, `id_pais`, `id_oceano`, `id_tipo`
) VALUES (
  '19', 'Isla Volcánica', NULL, '4000', '2023-01-15', NULL, NULL, 'Tectónico', NULL, '0', '1', '156', '3', '1'
);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, id_tipo, id_oceano)
VALUES ('Otra Isla Volcánica', 3500, NULL, '2000-05-10', 4, 3);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, id_tipo, id_oceano)
VALUES ('Isla con Volcán', 3500, NULL, '2022-05-10', 4, 1);

INSERT INTO pais (nombre, capital, extension, idioma_oficial, id_continente)
VALUES ('Wakanda', 'Forever', 505992.28, 'Español', 4);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES ('Valle de Arán', 620.75, NULL, NULL, NULL, 'Pirineos', 'Mar Mediterráneo', 0, 1, 9, NULL, 7);

INSERT INTO accidente_geografico (nombre, extension, altura, ultima_erupcion, caudal, origen, desemboque, esSalado, esDulce, id_pais, id_oceano, id_tipo)
VALUES ('Valle de La Vida', 620.75, NULL, NULL, NULL, 'Pirineos', 'Mar Rojo', 10, 1, 9, NULL, 11);

INSERT INTO pais (nombre, capital, extension, idioma_oficial, id_continente)
VALUES ('País Amazona Ejemplo', 'Amazona', 6000000.00, 'Chinese', 1);

INSERT INTO accidente_geografico (nombre, id_tipo, id_pais)
VALUES ('Río Amazonas', 2, (SELECT id_pais FROM pais WHERE nombre = 'País Amazona Ejemplo'));


--  Consulta   --
Select distinct p.nombre As nombre_pais
From pais p
Where p.id_pais in (
	select distinct id_pais
    from accidente_geografico
    where id_tipo=1
    and altura > 3000
) and p.id_pais not in(
	select distinct id_pais
    from accidente_geografico
    where id_tipo=3
    and id_oceano=(
		select id_oceano
        from oceano
        where nombre='Oceano Pacifico'
    )
);





-- 4 ES tipo VOLCAN --
-- Consulta --
Select a.*, o.nombre AS nombre_oceano
From accidente_geografico AS a
JOIN oceano AS o ON a.id_oceano =o.id_oceano
Where a.id_tipo =4 
and o.nombre = 'Oceano Atlantico'
and a.ultima_erupcion >= DATE_SUB(CURDATE(), INTERVAL 100 YEAR); 



-- Consulta --
Select ag.*
From accidente_geografico AS ag
Where ag.origen='Pirineos'
	and ag.id_tipo=11
    and ag.id_pais NOT IN (select id_pais from pais where nombre="Francia");


-- Consulta --
select nombre, extension, idioma_oficial
from pais
where extension <5000
	and idioma_oficial='Italian';



-- Consulta --
select distinct ag.nombre, ag.esSalado
from accidente_geografico ag
where ag.esSalado=1
	and ag.id_pais IN (
		select id_pais
        from pais
        where id_continente = (Select id_continente FROM continente Where nombre="Asia")
			and nombre not in('Iran', 'Kazajistan')
    );



-- Consulta --
Select p.nombre AS nombre_pais, max(p.extension) AS extension_territorial
from pais p
join accidente_geografico ag On p.id_pais=ag.id_pais
where exists(
select 1
from accidente_geografico
where id_tipo=2 
and id_pais=p.id_pais
)
and not exists(
select 1
from accidente_geografico
where id_tipo=3
and extension>5
and id_pais = p.id_pais
)

group by p.id_pais
order by extension_territorial desc
limit 1;




