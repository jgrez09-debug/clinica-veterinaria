# Clínica Veterinaria — Base de Datos

Proyecto de base de datos relacional desarrollado como **Evaluación Final del Módulo 3**.

## Descripción

Base de datos MySQL para gestionar una clínica veterinaria. Permite registrar dueños, mascotas, profesionales y atenciones, garantizando la integridad referencial entre todas las tablas.

## Tecnologías utilizadas

- **MySQL** — Motor de base de datos relacional
- **SQL** — DDL (CREATE), DML (INSERT, SELECT, UPDATE, DELETE) y TCL (COMMIT, ROLLBACK)

## Estructura de la base de datos

```
clinica_veterinaria
├── duenos          → id_dueno (PK), nombre, direccion, telefono
├── profesionales   → id_profesional (PK), nombre, especialidad
├── mascotas        → id_mascota (PK), nombre, tipo, fecha_nacimiento, id_dueno (FK)
└── atenciones      → id_atencion (PK), fecha_atencion, descripcion, id_mascota (FK), id_profesional (FK)
```

## Funcionalidades implementadas

- Creación de tablas con claves primarias y foráneas
- Inserción de datos de ejemplo con información chilena
- Consultas con JOIN para relacionar tablas
- Consultas con funciones de agregación (COUNT, GROUP BY)
- Actualización y eliminación de registros con integridad referencial
- Transacción con COMMIT que agrupa múltiples operaciones

## Cómo ejecutar

1. Tener MySQL instalado (se recomienda MySQL Workbench)
2. Abrir el archivo `clinica_veterinaria.sql`
3. Ejecutar el script completo

## Autor

**Jonathan Alexis Grez Parada**
Kibernum IT Academy — Módulo 3 · 2026
