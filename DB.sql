CREATE SCHEMA ec2energy ;
CREATE TABLE ec2energy.clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(85) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  clientescol VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE);

CREATE TABLE ec2energy.tecnico (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(85) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  email VARCHAR(45) NOT NULL,
  clientescol VARCHAR(45) NOT NULL,
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

CREATE TABLE ec2energy.producto (
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