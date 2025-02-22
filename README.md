FULL JOIN

En SQL, el FULL JOIN (o FULL OUTER JOIN) es una poderosa técnica utilizada para combinar registros de dos o más tablas. A diferencia de un INNER JOIN, que solo devuelve filas donde hay coincidencias en ambas tablas, FULL JOIN recupera todas las filas de ambas tablas, completando NULL valores donde no existen coincidencias.

Algunos ejemplo de este empleando las clausalas WHERE, SORTED BY y ORDER BY son

1

SELECT d.departamento_id, d.nombre_departamento, COUNT(e.empleado_id) AS total_empleados
FROM departamentos d
FULL JOIN empleados e ON d.departamento_id = e.departamento_id
WHERE d.departamento_id IS NOT NULL
GROUP BY d.departamento_id, d.nombre_departamento
ORDER BY total_empleados DESC;

con este select se unen las tablas departamento y empleados, filtrando que la columna departamento_id que no sea nula, agrupa por departamento_id y ordena los resultados por el número de empleados de forma descendente.

2

SELECT p.producto_id, p.nombre_producto, SUM(v.cantidad_vendida) AS total_ventas
FROM productos p
FULL JOIN ventas v ON p.producto_id = v.producto_id
WHERE (v.cantidad_vendida > 100 OR v.cantidad_vendida IS NULL)
GROUP BY p.producto_id, p.nombre_producto
ORDER BY total_ventas DESC;

En esta consulta, se realiza un FULL JOIN entre las tablas productos y ventas, y se filtra por productos con ventas superiores a 100 unidades y no han tenido ventas, agrupándolos por su id y nombre, y ordenados de forma descendente segun el total de unidades vendidas de cada producto.

3

SELECT c.cliente_id, c.nombre_cliente, COUNT(co.compra_id) AS total_compras
FROM clientes c
FULL JOIN compras co ON c.cliente_id = co.cliente_id
GROUP BY c.cliente_id, c.nombre_cliente;

En esta consulta, se realiza un FULL JOIN entre las tablas clientes y compras, y se agrupa por cliente_id para calcular la cantidad total de compras de cada cliente.

4

SELECT p.producto_id, p.nombre_producto, SUM(v.cantidad_vendida) AS total_ventas
FROM productos p
FULL JOIN ventas v ON p.producto_id = v.producto_id
WHERE (v.cantidad_vendida > 50 OR v.cantidad_vendida IS NULL);

Esta consulta realiza un FULL JOIN entre las tablas productos y ventas, filtrando los resultados para incluir solo productos con ventas superiores a 50 unidades o aquellos productos sin ventas.

5 

SELECT e.empleado_id, e.nombre_empleado, COUNT(p.proyecto_id) AS total_proyectos
FROM empleados e
FULL JOIN proyectos p ON e.empleado_id = p.empleado_id
WHERE COUNT total_proyectos > 2
GROUP BY e.empleado_id, e.nombre_empleado
ORDER BY total_proyectos DESC;

Esta consulta utiliza un FULL JOIN entre las tablas empleados y proyectos, agrupando por empleado_id y nombre del empleado, ordena los resultados por la cantidad de proyectos asignados, con un filtro para mostrar solo aquellos empleados con más de 2 proyectos asignados y ordenados descendentemente.

CROSS JOIN

Con la sentencia CROSS JOIN se pueden unir todos los registros de una tabla A con los registros de la tabla B, incluso pueden unirse mas de dos tablas puede significar un riesgo al crear tablas de grandes dimensiones.
 
SELECT p.producto_id, p.nombre_producto, c.categoria_id, c.nombre_categoria, pr.proveedor_id, pr.nombre_proveedor
FROM productos p
CROSS JOIN categorias c
CROSS JOIN proveedores pr;



Algunos ejemplo de este empleando las clausalas WHERE, SORTED BY y ORDER BY son

1

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
CROSS JOIN Orders
WHERE Customers.CustomerID=Orders.CustomerID;

Con CROSS JOIN se devuelve toda coincidencia de registros entre ambas tablas si la otra tabla coincide o no. Entonces, si hay filas en "Clientes" que no tienen coincidencias en "Pedidos", o si hay son filas en "Pedidos" que no tienen coincidencias en "Clientes", esas filas serán listadas en la tabla.

2

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
CROSS JOIN Orders
WHERE Customers.CustomerID=Orders.CustomerID;

Con esta consulta se unen todos los registros de la tabla Customers y Orders, restringiendolas a aquellas en las que el id del comprador en Customers sea igual al id del comprador en Orders.

3
SELECT c.categoria_id, c.nombre_categoria, COUNT(p.producto_id) AS total_productos
FROM productos p
CROSS JOIN categorias c
WHERE c.categoria_id IN (1, 2, 3)
GROUP BY c.categoria_id, c.nombre_categoria
ORDER BY total_productos DESC;

En esta consulta, se realiza un CROSS JOIN entre las tablas productos y categorias. Luego, se filtran los resultados para solo mostrar productos de categorías específicas, agrupando los resultados por categoria_id y por el total de productos de forma descendiente.

4

SELECT p.producto_id, p.nombre_producto, pr.proveedor_id, pr.nombre_proveedor
FROM productos p
CROSS JOIN proveedores pr
WHERE p.precio > 50 AND pr.numero_productos > 3
ORDER BY p.nombre_producto;

Esta consulta muestra todos los id y nombres de productos, id y nombre del proveedor, pero solo aquellos cuyo precio sea mayor a 50 y cuyo proveedor tenga más de 3 productos asociados.

5

SELECT cl.cliente_id, cl.nombre_cliente, COUNT(p.producto_id) AS total_productos_comprados
FROM clientes cl
CROSS JOIN productos p
WHERE cl.cliente_id IN (1, 2, 3, 4, 5)
GROUP BY cl.cliente_id, cl.nombre_cliente
HAVING COUNT(p.producto_id) > 5
ORDER BY total_productos_comprados DESC;

En esta consulta, se realiza un CROSS JOIN entre clientes y productos, y se agrupan los resultados por cliente_id para contar cuántos productos de cada cliente se han combinado, agrupando por id y nombre de cliente filtrando para clientes con más de 5 productos y organizandolos descendentemente segun la cantidad de productos que cada cliente ha llevado


Punto 6

Enunciado del Proyecto
Contexto: Imagina que estamos desarrollando una base de datos para una empresa que vende y mantiene sistemas de energías renovables, tales como paneles solares y turbinas eólicas. La empresa tiene diferentes clientes y proporciona un sistema de mantenimiento y seguimiento de los productos vendidos.
Entidades:
Clientes: Información sobre los clientes de la empresa.
Atributos:
id (PK)
nombre
direccion
telefono
email
Tecnico: Información sobre los tecnicos de la empresa.
Atributos:
id (PK)
nombre
direccion
telefono
email
Productos: Información sobre los productos vendidos por la empresa (paneles solares, turbinas eólicas, etc.).
Atributos:
producto_id (PK)
nombre_producto
tipo_producto (ej. panel solar, turbina eólica)
precio_producto
Factura: Registro de ventas realizadas a los clientes.
Atributos:
venta_id (PK)
id_cliente (FK a Clientes)
producto_id (FK a Productos)
fecha_venta
Mantenimiento: Registro de los mantenimientos realizados a los productos vendidos.
Atributos:
id (PK)
id_producto (FK a Productos)
precio
id_tecnico (FK a Tecnico)
id_cliente (FK a Tecnico)
id_factura
Proveedores: Información sobre los proveedores de los productos.
Atributos:
id (PK)
nombre
contacto
Proveedores_Productos: Relación de los productos que cada proveedor ofrece.
Atributos:
proveedor_id (FK a Proveedores)
producto_id (FK a Productos)
Relaciones:
Un Cliente puede tener varias Facturas.
Una Factura está asociada a multiples Productos.
Un Producto puede tener múltiples registros de Mantenimiento.
Un Cliente puede tener multiples Mantenimientos asociados
Un Proveedor puede proporcionar varios Productos.


![Imagen 1. MER](https://github.com/user-attachments/assets/5097ad77-fc87-40a9-83b0-43fcdf9ac22e)
Imagen 1. MER


[Creación base de datos y consultas SQL funcionales](https://github.com/DNosheZ/EC2EnergyDB/blob/main/DB.sql)
