-- ============================================================
--  BASE DE DATOS: clinica_veterinaria
--  Evaluación Final - Módulo 3
--  Autor: Jonathan Alexis Grez Parada
-- ============================================================

-- 1. CREAR BASE DE DATOS
CREATE DATABASE IF NOT EXISTS clinica_veterinaria;
USE clinica_veterinaria;

-- 2. CREAR TABLAS
CREATE TABLE duenos (
    id_dueno  INT          NOT NULL AUTO_INCREMENT,
    nombre    VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono  VARCHAR(20)  NOT NULL,
    CONSTRAINT pk_duenos PRIMARY KEY (id_dueno)
);

CREATE TABLE profesionales (
    id_profesional INT          NOT NULL AUTO_INCREMENT,
    nombre         VARCHAR(100) NOT NULL,
    especialidad   VARCHAR(100) NOT NULL,
    CONSTRAINT pk_profesionales PRIMARY KEY (id_profesional)
);

CREATE TABLE mascotas (
    id_mascota       INT          NOT NULL AUTO_INCREMENT,
    nombre           VARCHAR(100) NOT NULL,
    tipo             VARCHAR(50)  NOT NULL,
    fecha_nacimiento DATE         NOT NULL,
    id_dueno         INT          NOT NULL,
    CONSTRAINT pk_mascotas   PRIMARY KEY (id_mascota),
    CONSTRAINT fk_masc_dueno FOREIGN KEY (id_dueno)
        REFERENCES duenos(id_dueno)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE atenciones (
    id_atencion    INT  NOT NULL AUTO_INCREMENT,
    fecha_atencion DATE NOT NULL,
    descripcion    TEXT NOT NULL,
    id_mascota     INT  NOT NULL,
    id_profesional INT  NOT NULL,
    CONSTRAINT pk_atenciones       PRIMARY KEY (id_atencion),
    CONSTRAINT fk_aten_mascota     FOREIGN KEY (id_mascota)
        REFERENCES mascotas(id_mascota)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_aten_profesional FOREIGN KEY (id_profesional)
        REFERENCES profesionales(id_profesional)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. INSERTAR DATOS (datos chilenos)
INSERT INTO duenos (id_dueno, nombre, direccion, telefono) VALUES
    (1, 'Juan Pérez Soto',      'Av. Providencia 1234, Providencia, Santiago',  '987654321'),
    (2, 'Ana González Muñoz',   'Calle Los Aromos 456, Las Condes, Santiago',   '976543210'),
    (3, 'Carlos Rojas Fuentes', 'Pasaje Los Lirios 789, Maipú, Santiago',       '965432109');

INSERT INTO profesionales (id_profesional, nombre, especialidad) VALUES
    (1, 'Dr. Martínez',  'Veterinario general'),
    (2, 'Dra. Pérez',    'Especialista en dermatología'),
    (3, 'Dr. López',     'Cardiólogo veterinario');

INSERT INTO mascotas (id_mascota, nombre, tipo, fecha_nacimiento, id_dueno) VALUES
    (1, 'Rex',  'Perro', '2020-05-10', 1),
    (2, 'Luna', 'Gato',  '2019-02-20', 2),
    (3, 'Fido', 'Perro', '2021-03-15', 3);

INSERT INTO atenciones (id_atencion, fecha_atencion, descripcion, id_mascota, id_profesional) VALUES
    (1, '2025-03-01', 'Chequeo general',           1, 1),
    (2, '2025-03-05', 'Tratamiento dermatológico', 2, 2),
    (3, '2025-03-07', 'Consulta cardiológica',     3, 3);

-- 4. VERIFICAR DATOS
SELECT * FROM duenos;
SELECT * FROM profesionales;
SELECT * FROM mascotas;
SELECT * FROM atenciones;

-- 5. CONSULTAS

-- Consulta 1: Dueños y sus mascotas
SELECT d.id_dueno, d.nombre AS dueno, d.telefono,
       m.id_mascota, m.nombre AS mascota, m.tipo, m.fecha_nacimiento
FROM duenos d
JOIN mascotas m ON d.id_dueno = m.id_dueno
ORDER BY d.nombre;

-- Consulta 2: Atenciones con detalles del profesional
SELECT a.id_atencion, a.fecha_atencion, a.descripcion,
       m.nombre AS mascota, m.tipo,
       p.nombre AS profesional, p.especialidad
FROM atenciones a
JOIN mascotas      m ON a.id_mascota     = m.id_mascota
JOIN profesionales p ON a.id_profesional = p.id_profesional
ORDER BY a.fecha_atencion;

-- Consulta 3: Cantidad de atenciones por profesional
SELECT p.nombre AS profesional, p.especialidad,
       COUNT(a.id_atencion) AS total_atenciones
FROM profesionales p
LEFT JOIN atenciones a ON p.id_profesional = a.id_profesional
GROUP BY p.id_profesional, p.nombre, p.especialidad
ORDER BY total_atenciones DESC;

-- 6. ACTUALIZAR dirección de Juan Pérez
UPDATE duenos
SET direccion = 'Av. Lib. Bernardo OHiggins 999, Santiago Centro'
WHERE id_dueno = 1;

SELECT id_dueno, nombre, direccion FROM duenos WHERE id_dueno = 1;

-- 7. ELIMINAR atención id = 2
DELETE FROM atenciones WHERE id_atencion = 2;
SELECT * FROM atenciones;

-- 8. TRANSACCIÓN
START TRANSACTION;

    INSERT INTO mascotas (nombre, tipo, fecha_nacimiento, id_dueno)
    VALUES ('Toby', 'Perro', '2023-06-01', 1);

    INSERT INTO atenciones (fecha_atencion, descripcion, id_mascota, id_profesional)
    VALUES ('2026-03-17', 'Vacunacion inicial', 4, 1);

    UPDATE duenos
    SET telefono = '998877665'
    WHERE id_dueno = 1;

COMMIT;

SELECT * FROM mascotas   WHERE id_mascota = 4;
SELECT * FROM atenciones WHERE id_mascota = 4;
SELECT id_dueno, nombre, telefono FROM duenos WHERE id_dueno = 1;
