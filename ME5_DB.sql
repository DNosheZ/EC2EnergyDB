-- 1. Crear el esquema
CREATE SCHEMA IF NOT EXISTS ec2energy;

-- ==========================
-- 2. Tabla: clientes
-- ==========================
CREATE TABLE ec2energy.clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(85) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC)
);

-- ==========================
-- 3. Tabla: tecnico
-- ==========================
CREATE TABLE ec2energy.tecnico (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(85) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC)
);

-- ==========================
-- 4. Tabla: proveedor
-- ==========================
CREATE TABLE ec2energy.proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  contacto VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC),
  UNIQUE INDEX nombre_UNIQUE (nombre ASC),
  UNIQUE INDEX contacto_UNIQUE (contacto ASC)
);

-- ==========================
-- 5. Tabla: productos
-- ==========================
CREATE TABLE ec2energy.productos (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  precio INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC),
  UNIQUE INDEX nombre_UNIQUE (nombre ASC)
);

-- ==========================
-- 6. Tabla: proveedor_producto
-- ==========================
CREATE TABLE ec2energy.proveedor_producto (
  id INT NOT NULL AUTO_INCREMENT,
  id_proveedor INT NULL,
  id_producto INT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC),
  INDEX id_proveedor_idx (id_proveedor ASC),
  INDEX id_producto_idx (id_producto ASC),
  CONSTRAINT fk_id_proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES ec2energy.proveedor (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_id_producto
    FOREIGN KEY (id_producto)
    REFERENCES ec2energy.productos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- ==========================
-- 7. Tabla: facturas
-- ==========================
CREATE TABLE ec2energy.facturas (
  id INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  producto_id INT NOT NULL,
  fecha DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC),
  INDEX fk_cliente_idx (id_cliente ASC),
  INDEX fk_producto_idx (producto_id ASC),
  CONSTRAINT fk_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES ec2energy.clientes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_producto_fact
    FOREIGN KEY (producto_id)
    REFERENCES ec2energy.productos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- ==========================
-- 8. Tabla: mantenimiento
-- ==========================
CREATE TABLE ec2energy.mantenimiento (
  id INT NOT NULL AUTO_INCREMENT,
  precio INT NOT NULL,
  id_producto INT NOT NULL,
  id_tecnico INT NOT NULL,
  id_cliente INT NOT NULL,
  id_factura INT NOT NULL,
  fecha DATETIME,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC),
  INDEX id_producto_idx (id_producto ASC),
  INDEX id_tecnico_idx (id_tecnico ASC),
  INDEX id_cliente_idx (id_cliente ASC),
  INDEX fk_factura_idx (id_factura ASC),
  CONSTRAINT fk_producto_mant
    FOREIGN KEY (id_producto)
    REFERENCES ec2energy.productos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tecnico_mant
    FOREIGN KEY (id_tecnico)
    REFERENCES ec2energy.tecnico (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cliente_mant
    FOREIGN KEY (id_cliente)
    REFERENCES ec2energy.clientes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_factura_mant
    FOREIGN KEY (id_factura)
    REFERENCES ec2energy.facturas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- ===================================================
-- LLENADO DE TABLAS
-- ===================================================

-- Tabla clientes
INSERT INTO ec2energy.clientes (nombre, direccion, telefono, email)
VALUES
('Juan Pérez', 'Calle 123', '3123456789', 'juan@example.com'),
('Maria López', 'Avenida 456', '3134567890', 'maria@example.com'),
('Carlos Sánchez', 'Carrera 789', '3145678901', 'carlos@example.com'),
('Ana García', 'Calle 101', '3156789012', 'ana@example.com'),
('Luis Torres', 'Avenida 202', '3167890123', 'luis@example.com');

-- Tabla tecnico
INSERT INTO ec2energy.tecnico (nombre, direccion, telefono, email)
VALUES
('Javier Ruiz', 'Calle A', '3178901234', 'javier@example.com'),
('Laura Pérez', 'Calle B', '3189012345', 'laura@example.com'),
('Luis Fernández', 'Calle C', '3190123456', 'luisf@example.com'),
('Sofia Gómez', 'Calle D', '3201234567', 'sofia@example.com'),
('Pedro González', 'Calle E', '3212345678', 'pedro@example.com');

-- Tabla proveedor
INSERT INTO ec2energy.proveedor (nombre, contacto)
VALUES
('Proveedora Solar', 'Carlos Martínez'),
('Proveedora Eólica', 'Ana Martínez'),
('Paneles S.A.', 'Luis Ramírez'),
('Energía Verde', 'María Sánchez'),
('Eólica Global', 'Juan González');

-- Tabla productos
INSERT INTO ec2energy.productos (nombre, tipo, precio)
VALUES
('Panel Solar A', 'Panel Solar', 500),
('Turbina Eólica B', 'Turbina Eólica', 1200),
('Panel Solar C', 'Panel Solar', 600),
('Turbina Eólica D', 'Turbina Eólica', 1300),
('Panel Solar E', 'Panel Solar', 550);

-- Tabla proveedor_producto
INSERT INTO ec2energy.proveedor_producto (id_proveedor, id_producto)
VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5);

-- Tabla facturas
INSERT INTO ec2energy.facturas (id_cliente, producto_id, fecha)
VALUES
(1, 1, '2023-06-01 10:00:00'),
(2, 2, '2023-06-05 14:00:00'),
(3, 3, '2023-07-10 16:00:00'),
(4, 4, '2023-07-15 09:00:00'),
(5, 5, '2023-08-01 11:00:00');

-- Tabla mantenimiento
INSERT INTO ec2energy.mantenimiento (precio, id_producto, id_tecnico, id_cliente, id_factura, fecha)
VALUES
(100, 1, 1, 1, 1, '2023-08-01 14:42:00'),
(150, 2, 2, 2, 2, '2023-06-01 10:28:00'),
(200, 3, 3, 3, 3, '2023-08-04 10:20:00'),
(250, 4, 4, 4, 4, '2023-12-12 08:16:00'),
(300, 5, 5, 5, 5, '2023-05-12 16:20:00');

-- Consultas finacieras
-- traer los nombres de los productos a los que hace referencia factura con producto_id,
-- la suma de los precios de los productos como el precio total de la factura
SELECT 
    p.nombre AS nombre_producto,
    SUM(p.precio) AS precio_total_factura
FROM 
    ec2energy.facturas f
JOIN 
    ec2energy.productos p ON f.producto_id = p.id
GROUP BY 
    f.id;

-- la cantidad de productos de un nombre en especifico vendidos entre dos fechas
-- empleando la tabla facturas, añade una columna llamada porcentaje de ventas 
-- el cual es la cantidad de productos de un nombre especifico vendidos entre 
-- dos fechas dividido entre el total de productos vendidos entre dos fechas
SELECT 
    p.nombre AS nombre_producto,
    COUNT(f.producto_id) AS cantidad_vendida,
    (COUNT(f.producto_id) / (SELECT COUNT(*) 
                             FROM ec2energy.facturas 
                             WHERE fecha BETWEEN '2023-06-01' AND '2023-08-01')) * 100 AS porcentaje_ventas
FROM 
    ec2energy.facturas f
JOIN 
    ec2energy.productos p ON f.producto_id = p.id
WHERE 
    p.nombre = 'Panel Solar A' 
    AND f.fecha BETWEEN '2023-06-01' AND '2023-09-01'
GROUP BY 
    p.nombre;

-- traer todos los proveedores asociados a un producto
SELECT 
    pr.nombre AS nombre_proveedor, 
    pr.contacto AS contacto_proveedor, 
    p.nombre AS nombre_producto
FROM 
    ec2energy.proveedor_producto pp
JOIN 
    ec2energy.proveedor pr ON pp.id_proveedor = pr.id
JOIN 
    ec2energy.productos p ON pp.id_producto = p.id
WHERE 
    p.nombre = 'Panel Solar A';

-- la union del nombre del cliente y el nombre del tecnico que atiende un mantenimiento 
-- segun una fecha invocada para la columna fecha en mantenimiento
SELECT 
    c.nombre AS nombre_cliente,
    t.nombre AS nombre_tecnico
FROM 
    ec2energy.mantenimiento m
JOIN 
    ec2energy.clientes c ON m.id_cliente = c.id
JOIN 
    ec2energy.tecnico t ON m.id_tecnico = t.id
WHERE 
    m.fecha = '2023-06-01 10:28:00';

-- el promedio de dinero ingresado a factura entre dos fechas
SELECT 
    AVG(p.precio) AS promedio_ingresado
FROM 
    ec2energy.facturas f
JOIN 
    ec2energy.productos p ON f.producto_id = p.id
WHERE 
    f.fecha BETWEEN '2023-06-01' AND '2023-08-01';

-- Ejemplo de truncate
TRUNCATE ec2energy.mantenimiento;



-- consulta 1 punto 2
SELECT 
    c.id AS id_cliente,
    c.nombre AS nombre_cliente,
    f.id AS id_factura
FROM ec2energy.clientes c
LEFT JOIN ec2energy.facturas f ON c.id = f.id_cliente

UNION

SELECT 
    c.id AS id_cliente,
    c.nombre AS nombre_cliente,
    f.id AS id_factura
FROM ec2energy.clientes c
RIGHT JOIN ec2energy.facturas f ON c.id = f.id_cliente;

-- consulta 2 punto 2 
SELECT 
    pr.nombre AS nombre_proveedor, 
    pr.contacto AS contacto, 
    p.nombre AS nombre_producto, 
    f.id AS id_factura, 
    f.fecha
FROM ec2energy.proveedor pr
LEFT JOIN ec2energy.proveedor_producto pp ON pr.id = pp.id_proveedor
LEFT JOIN ec2energy.productos p ON pp.id_producto = p.id
LEFT JOIN ec2energy.facturas f ON p.id = f.producto_id
WHERE YEAR(f.fecha) = 2023

UNION

SELECT 
    pr.nombre AS nombre_proveedor, 
    pr.contacto AS contacto, 
    p.nombre AS nombre_producto, 
    f.id AS id_factura, 
    f.fecha
FROM ec2energy.proveedor pr
RIGHT JOIN ec2energy.proveedor_producto pp ON pr.id = pp.id_proveedor
RIGHT JOIN ec2energy.productos p ON pp.id_producto = p.id
RIGHT JOIN ec2energy.facturas f ON p.id = f.producto_id
WHERE YEAR(f.fecha) = 2023;

-- Consulta 3 punto 2
SELECT 
    c.nombre AS nombre_cliente, 
    COUNT(m.id) AS total_mantenimientos
FROM ec2energy.clientes c
LEFT JOIN ec2energy.mantenimiento m ON c.id = m.id_cliente
GROUP BY c.id

UNION

SELECT 
    c.nombre AS nombre_cliente, 
    COUNT(m.id) AS total_mantenimientos
FROM ec2energy.clientes c
RIGHT JOIN ec2energy.mantenimiento m ON c.id = m.id_cliente
GROUP BY c.id;

-- Consulta 4 punto 2
SELECT * 
FROM (
    SELECT 
        p.nombre AS nombre_producto, 
        SUM(p.precio) AS suma_precios
    FROM ec2energy.productos p
    LEFT JOIN ec2energy.facturas f ON p.id = f.producto_id
    GROUP BY p.id
    
    UNION

    SELECT 
        p.nombre AS nombre_producto, 
        SUM(p.precio) AS suma_precios
    FROM ec2energy.productos p
    RIGHT JOIN ec2energy.facturas f ON p.id = f.producto_id
    GROUP BY p.id
) AS union_table
ORDER BY suma_precios DESC;

-- Consulta 5 punto 2
SELECT *
FROM (
    SELECT 
        c.nombre AS nombre_cliente,
        c.email,
        COUNT(f.id) AS total_facturas
    FROM ec2energy.clientes c
    LEFT JOIN ec2energy.facturas f ON c.id = f.id_cliente
    GROUP BY c.id
    HAVING c.email LIKE '%example%' OR COUNT(f.id) > 1
    
    UNION
    
    SELECT 
        c.nombre AS nombre_cliente,
        c.email,
        COUNT(f.id) AS total_facturas
    FROM ec2energy.clientes c
    RIGHT JOIN ec2energy.facturas f ON c.id = f.id_cliente
    GROUP BY c.id
    HAVING c.email LIKE '%example%' OR COUNT(f.id) > 1
) AS union_table;


-- Consulta 1 punto 4
SELECT 
    c.nombre AS nombre_cliente,
    t.nombre AS nombre_tecnico
FROM ec2energy.clientes c
CROSS JOIN ec2energy.tecnico t
WHERE c.id < 6 OR t.id > 5;


-- Consulta 2 punto 4 

SELECT 
    CONCAT(pr.nombre, ' - ', p.nombre) AS proveedor_producto,
    COUNT(*) AS total_combinaciones
FROM ec2energy.proveedor pr
CROSS JOIN ec2energy.productos p
GROUP BY pr.id, p.id
ORDER BY proveedor_producto ASC;

-- Consulta 3 Punto 4

SELECT
    f.id AS id_factura,
    m.id AS id_mantenimiento,
    COUNT(*) AS conteo
FROM ec2energy.facturas f
CROSS JOIN ec2energy.mantenimiento m
GROUP BY f.id, m.id
HAVING COUNT(*) > 0;

-- Consulta 4 punto 4
SELECT
    f.id AS factura_id,
    p.nombre AS producto,
    p.precio,
    f.fecha
FROM ec2energy.facturas f
CROSS JOIN ec2energy.productos p
WHERE p.precio > 1000
ORDER BY f.fecha DESC;

-- Consulta 5 punto 4
SELECT 
    c.nombre AS cliente,
    t.nombre AS tecnico,
    COUNT(*) AS combinaciones
FROM ec2energy.clientes c
CROSS JOIN ec2energy.tecnico t
WHERE (c.id % 2 = 0 AND t.id % 2 = 0)
   OR (c.id % 2 = 1 AND t.id % 2 = 1)
GROUP BY c.id, t.id;


-- Insertar nuevos clientes Paso 1 punto 6
INSERT INTO ec2energy.clientes (nombre, direccion, telefono, email)
VALUES 
('Camilo Vargas', 'Carrera 700', '3271122334', 'camilo@example.com'),
('Julieta López', 'Avenida 999', '3285566778', 'julieta@example.com');

-- Insertar nuevos técnicos
INSERT INTO ec2energy.tecnico (nombre, direccion, telefono, email)
VALUES
('Milena Rojas', 'Calle Z', '3281111222', 'milena@example.com'),
('Oscar Linares', 'Calle Y', '3292222333', 'oscar@example.com');

-- Paso 2 punto 6 
UPDATE ec2energy.productos
SET precio = 560
WHERE tipo = 'Panel Solar'
  AND precio < 550;

-- Paso 3 punto 6 
-- Eliminar un mantenimiento específico
DELETE FROM ec2energy.mantenimiento
WHERE id = 100;  -- Ejemplo de id incorrecto

-- Vaciar por completo la tabla mantenimiento
TRUNCATE ec2energy.mantenimiento;

-- Paso 4 punto 6 
ALTER TABLE ec2energy.productos
ADD COLUMN descuento INT DEFAULT 0;

SELECT 
    nombre,
    tipo,
    precio,
    (precio * 0.19) AS impuesto_est,
    (precio - (precio * descuento / 100)) AS precio_con_descuento
FROM ec2energy.productos;

SELECT *
FROM ec2energy.productos
WHERE descuento IS NULL;


-- Paso 6.1 INNER JOIN 	punto 6
SELECT 
    c.nombre AS cliente,
    f.id AS id_factura,
    p.nombre AS producto
FROM ec2energy.facturas f
INNER JOIN ec2energy.clientes c ON f.id_cliente = c.id
INNER JOIN ec2energy.productos p ON f.producto_id = p.id;

-- Paso 6.2 LEFT JOIN 	punto 6
SELECT 
    c.nombre AS cliente,
    f.id AS id_factura,
    p.nombre AS producto
FROM ec2energy.clientes c
LEFT JOIN ec2energy.facturas f ON c.id = f.id_cliente
LEFT JOIN ec2energy.productos p ON f.producto_id = p.id
ORDER BY c.nombre ASC;

-- Paso 6.3 FULL JOIN punto 6 
SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    f.id AS factura_id
FROM ec2energy.clientes c
LEFT JOIN ec2energy.facturas f ON c.id = f.id_cliente

UNION

SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    f.id AS factura_id
FROM ec2energy.clientes c
RIGHT JOIN ec2energy.facturas f ON c.id = f.id_cliente;

-- Paso 6.4 CROSS JOIN punto 6 
SELECT 
    t.nombre AS tecnico,
    p.nombre AS producto
FROM ec2energy.tecnico t
CROSS JOIN ec2energy.productos p
WHERE p.precio > 600
ORDER BY t.nombre;

-- Paso 7 punto 6 
SELECT 
    c.nombre AS cliente,
    COUNT(f.id) AS total_facturas,
    SUM(p.precio) AS total_ventas
FROM ec2energy.facturas f
INNER JOIN ec2energy.clientes c ON f.id_cliente = c.id
INNER JOIN ec2energy.productos p ON f.producto_id = p.id
GROUP BY c.id
ORDER BY total_ventas DESC;

-- Paso 8 punto 6
SELECT 
    p.nombre AS producto,
    p.precio,
    p.descuento
FROM ec2energy.productos p
WHERE p.precio BETWEEN 500 AND 700
  AND p.tipo = 'Panel Solar'
ORDER BY p.precio DESC;

-- Paso 9 punto 6 
SELECT
    f.id AS factura_id,
    c.nombre AS cliente,
    t.nombre AS tecnico_encargado,
    m.precio AS costo_mantenimiento,
    p.nombre AS producto,
    p.precio AS precio_producto,
    (
        SELECT AVG(pr.precio)
        FROM ec2energy.productos pr
    ) AS promedio_precio_general
FROM ec2energy.facturas f
INNER JOIN ec2energy.clientes c ON f.id_cliente = c.id
INNER JOIN ec2energy.mantenimiento m ON f.id = m.id_factura
INNER JOIN ec2energy.tecnico t ON m.id_tecnico = t.id
INNER JOIN ec2energy.productos p ON f.producto_id = p.id
ORDER BY f.id; 









