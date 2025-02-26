CREATE SCHEMA ec2energy ;
CREATE TABLE ec2energy.clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(85) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE);

CREATE TABLE ec2energy.tecnico (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(85) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE);

CREATE TABLE ec2energy.proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  contacto VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  UNIQUE INDEX nombre_UNIQUE (nombre ASC) VISIBLE,
  UNIQUE INDEX contacto_UNIQUE (contacto ASC) VISIBLE);

CREATE TABLE ec2energy.productos (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
   precio INT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  UNIQUE INDEX nombre_UNIQUE (nombre ASC) VISIBLE);

CREATE TABLE ec2energy.proveedor_producto (
  id INT NOT NULL AUTO_INCREMENT,
  id_proveedor INT NULL,
  id_producto INT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX id_proveedor_idx (id_proveedor ASC) VISIBLE,
  INDEX id_producto_idx (id_producto ASC) VISIBLE,
  CONSTRAINT id_proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES ec2energy.proveedor (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT id_producto
    FOREIGN KEY (id_producto)
    REFERENCES ec2energy.producto (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ec2energy.facturas (
  id INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  producto_id INT NOT NULL,
  fecha DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX fk_cliente_idx (id_cliente ASC) VISIBLE,
 INDEX fk_producto_idx (producto_id ASC) VISIBLE,
 CONSTRAINT fk_cliente
  FOREIGN KEY (id_cliente)
  REFERENCES ec2energy.clientes (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
CONSTRAINT fk_producto
  FOREIGN KEY (producto_id)
  REFERENCES ec2energy.productos (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION);


CREATE TABLE ec2energy.mantenimiento (
  id INT NOT NULL AUTO_INCREMENT,
  precio INT NOT NULL,
  id_producto INT NOT NULL,
  id_tecnico INT NOT NULL,
  id_cliente INT NOT NULL,
  id_factura INT NOT NULL,
  fecha DATETIME,

  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE,
  INDEX id_producto_idx (id_producto ASC) VISIBLE,
  INDEX id_tecnico_idx (id_tecnico ASC) VISIBLE,
  INDEX id_cliente_idx (id_cliente ASC) VISIBLE,
  INDEX fk_factura_idx (id_factura ASC) VISIBLE,
  CONSTRAINT fk_producto
    FOREIGN KEY (id_producto)
    REFERENCES ec2energy.productos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_tecnico
    FOREIGN KEY (id_tecnico)
    REFERENCES ec2energy.tecnico (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES ec2energy.clientes (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_factura
    FOREIGN KEY (id_tecnico)
    REFERENCES ec2energy.facturas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    -- Llenado de tablas
    -- Insertando registros en la tabla `clientes`
INSERT INTO ec2energy.clientes (nombre, direccion, telefono, email) VALUES
('Juan Pérez', 'Calle 123', '3123456789', 'juan@example.com'),
('Maria López', 'Avenida 456', '3134567890', 'maria@example.com'),
('Carlos Sánchez', 'Carrera 789', '3145678901', 'carlos@example.com'),
('Ana García', 'Calle 101', '3156789012', 'ana@example.com'),
('Luis Torres', 'Avenida 202', '3167890123', 'luis@example.com');


INSERT INTO ec2energy.tecnico (nombre, direccion, telefono, email) VALUES
('Javier Ruiz', 'Calle A', '3178901234', 'javier@example.com'),
('Laura Pérez', 'Calle B', '3189012345', 'laura@example.com'),
('Luis Fernández', 'Calle C', '3190123456', 'luisf@example.com'),
('Sofia Gómez', 'Calle D', '3201234567', 'sofia@example.com',
('Pedro González', 'Calle E', '3212345678', 'pedro@example.com');


INSERT INTO ec2energy.proveedor (nombre, contacto) VALUES
('Proveedora Solar', 'Carlos Martínez'),
('Proveedora Eólica', 'Ana Martínez'),
('Paneles S.A.', 'Luis Ramírez'),
('Energía Verde', 'María Sánchez'),
('Eólica Global', 'Juan González');


INSERT INTO ec2energy.productos (nombre_producto, tipo_producto, precio_producto) VALUES
('Panel Solar A', 'Panel Solar', 500),
('Turbina Eólica B', 'Turbina Eólica', 1200),
('Panel Solar C', 'Panel Solar', 600),
('Turbina Eólica D', 'Turbina Eólica', 1300),
('Panel Solar E', 'Panel Solar', 550);


INSERT INTO ec2energy.proveedor_producto (id_proveedor, id_producto) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5);


INSERT INTO ec2energy.facturas (id_cliente, producto_id, fecha) VALUES
(1, 1, '2023-06-01 10:00:00'),
(2, 2, '2023-06-05 14:00:00'),
(3, 3, '2023-07-10 16:00:00'),
(4, 4, '2023-07-15 09:00:00'),
(5, 5, '2023-08-01 11:00:00');


INSERT INTO ec2energy.mantenimiento (precio, id_producto, id_tecnico, id_cliente, id_factura,fecha) VALUES
(100, 1, 1, 1, 1,'2023-08-01 14:42:00'),
(150, 2, 2, 2, 2,'2023-06-01 10:28:00'),
(200, 3, 3, 3, 3,'2023-08-04 10:20:00'),
(250, 4, 4, 4, 4,'2023-12-12 08:16:00'),
(300, 5, 5, 5, 5,'2023-05-12 16:20:00');


-- Consultas finacieras
-- traer los nombres de los productos a los que hace referencia factura con producto_id, la suma de los precios de los productos como el precio total de la factura  
SELECT 
    p.nombre AS nombre_producto,
    SUM(p.precio) AS precio_total_factura
FROM 
    ec2energy.facturas f
JOIN 
    ec2energy.producto p ON f.producto_id = p.id
GROUP BY 
    f.id;

-- la cantidad de productos de un nombre en especifico vendidos entre dos fechas empleando la tabla facturas, añade una columna llamada porcentaje de ventas el cual es la cantidad de productos de un nombre especifico vendidos entre dos fechas dividido entre el total de productos vendidos entre dos fechas
SELECT 
    p.nombre_producto AS nombre_producto,
    COUNT(f.producto_id) AS cantidad_vendida,
    (COUNT(f.producto_id) / (SELECT COUNT(*) FROM ec2energy.facturas WHERE fecha BETWEEN '2023-06-01' AND '2023-08-01')) * 100 AS porcentaje_ventas
FROM 
    ec2energy.facturas f
JOIN 
    ec2energy.productos p ON f.producto_id = p.id
WHERE 
    p.nombre_producto = 'Panel Solar A' AND f.fecha BETWEEN '2023-06-01' AND '2023-09-01'
GROUP BY 
    p.nombre_producto;

-- - traer todos los proveedores asociados a un producto 

SELECT 
    pr.nombre AS nombre_proveedor, 
    pr.contacto AS contacto_proveedor, 
    p.nombre_producto AS nombre_producto
FROM 
    ec2energy.proveedor_producto pp
JOIN 
    ec2energy.proveedor pr ON pp.id_proveedor = pr.id
JOIN 
    ec2energy.productos p ON pp.id_producto = p.id
WHERE 
    p.nombre_producto = 'Panel Solar A';

-- la union del nombre del cliente y el nombre del tecnico que atiende un manteniemiento segun una fecha invocada para la columna fecha en mantenimiento
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
    AVG(p.precio_producto) AS promedio_ingresado
FROM 
    ec2energy.facturas f
JOIN 
    ec2energy.productos p ON f.producto_id = p.id
WHERE 
    f.fecha BETWEEN '2023-06-01' AND '2023-08-01';
    
TRUNCATE mantenimiento
