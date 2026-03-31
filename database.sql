CREATE DATABASE IF NOT EXISTS estantes_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE estantes_db;

CREATE TABLE IF NOT EXISTS ubicaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255) DEFAULT '',
    color VARCHAR(7) DEFAULT '#3b82f6',
    fila INT DEFAULT NULL,
    columna INT DEFAULT NULL,
    pos_x INT DEFAULT NULL,
    pos_y INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS articulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NOT NULL,
    medida VARCHAR(50) DEFAULT '',
    ubicacion_id INT DEFAULT NULL,
    notas TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones(id) ON DELETE SET NULL
);

-- Ubicaciones de ejemplo (5x3 grid)
INSERT INTO ubicaciones (codigo, descripcion, color, fila, columna) VALUES
('A1', 'Estante A - Nivel 1', '#3b82f6', 1, 1),
('A2', 'Estante A - Nivel 2', '#3b82f6', 1, 2),
('A3', 'Estante A - Nivel 3', '#3b82f6', 1, 3),
('B1', 'Estante B - Nivel 1', '#10b981', 2, 1),
('B2', 'Estante B - Nivel 2', '#10b981', 2, 2),
('B3', 'Estante B - Nivel 3', '#10b981', 2, 3),
('C1', 'Estante C - Nivel 1', '#f59e0b', 3, 1),
('C2', 'Estante C - Nivel 2', '#f59e0b', 3, 2),
('C3', 'Estante C - Nivel 3', '#f59e0b', 3, 3),
('MESA1', 'Mesa de trabajo 1', '#ef4444', NULL, NULL),
('PISO', 'En el piso', '#8b5cf6', NULL, NULL);
