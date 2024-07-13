-- Consultas con funciones de agregaci�n--

-- 1) Total de ventas globales--
-- Pregunta: �Cu�l es el total de ventas (TotalCompra) a nivel global?--

SELECT SUM (TotalCompra) AS TotalVentas
FROM
	Ordenes;

-- 2) Promedio de precios de productos por categor�a--
--Pregunta: �Cu�l es el precio promedio de los productos dentro de cada categor�a?--

SELECT CategoriaID,
AVG (Precio) AS PrecioPromedio
FROM Productos
GROUP BY CategoriaID;

-- 3) Orden m�nima y m�xima por sucursal--
--Pregunta: �Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?--

SELECT SucursalID, -- Dimension--
		MIN (TotalCompra) AS Minimo, --Metrica 1--
		MAX (TotalCompra) AS Maximo --Metrica 2--
FROM Ordenes
GROUP BY SucursalID;

-- 4) Mayor n�mero de kil�metros recorridos para entrega--
--Pregunta: �Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?--

SELECT
MAX (KilometrosRecorrer) AS [Km Recorridos]
FROM Ordenes;

-- 5) Promedio de cantidad de productos por orden--
--Pregunta: �Cu�l es la cantidad promedio de productos por orden?--

SELECT OrdenID, AVG (Cantidad) AS [Promedio de Productos]
FROM DetalleOrden
GROUP BY OrdenID;

-- 6) Total de ventas por tipo de pago--
--Pregunta: �C�mo se distribuye la Facturaci�n Total del Negocio de acuerdo a los m�todos de pago?--

SELECT TipoPagoID, -- Dimension--
		SUM(TotalCompra) AS Facturaci�n
FROM Ordenes
GROUP BY TipoPagoID;

-- 7) Sucursal con la venta promedio m�s alta--
--Pregunta: �Cual Sucursal tiene el ingreso promedio m�s alto?--

SELECT TOP 1 SucursalID,
		AVG(TotalCompra) AS IngresoPromedio -- Metrica--
FROM Ordenes
GROUP BY SucursalID
ORDER BY IngresoPromedio DESC;

-- 8) Sucursal con la mayor cantidad de ventas por encima de un umbral--
--Pregunta: �Cu�les son las sucursales que han generado ventas totales por encima de $ 1000?--

SELECT  SucursalID, --Dimension--
		SUM(TotalCompra) AS VentasTotales -- Metrica--
FROM Ordenes
GROUP BY SucursalID
HAVING SUM (TotalCompra) > 1000.00
ORDER BY VentasTotales DESC;

-- 9) Comparaci�n de ventas promedio antes y despu�s de una fecha espec�fica--
--Pregunta: �C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?--

SELECT
(SELECT AVG(TotalCompra) AS PromedioVentas FROM Ordenes WHERE FechaOrdenTomanda < '2023-07-01') AS  PrimerSemestre,
(SELECT AVG(TotalCompra) AS PromedioVentas FROM Ordenes WHERE FechaOrdenTomanda >= '2023-07-01') AS SegundoSemestre;

-- 10) An�lisis de actividad de ventas por horario--
/*�Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor cantidad de ventas,
cu�l es el ingreso promedio de estas ventas, y cu�l ha sido el importe m�ximo alcanzado por una orden en dicha jornada?
*/

SELECT  HorarioVenta, -- Dimension Cualitativa--
		COUNT(OrdenID) AS CantidadVentas, --Metrica1---
		CONVERT(DECIMAL(10,2),AVG (TotalCompra)) AS IngresoPromedio, --Metrica2--
		MAX (TotalCompra) AS MaximoCompra --Metrica3--
FROM Ordenes
GROUP BY HorarioVenta;


