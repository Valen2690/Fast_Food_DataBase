-- Creación Base de Datos--

CREATE DATABASE Fast_Food_DB

USE Fast_Food_DB;

-- Creación de Tablas -- 

CREATE TABLE Categorias( 
	CategoriaID INT PRIMARY KEY IDENTITY, 
	Nombre VARCHAR(255) NOT NULL);

CREATE TABLE Productos (
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	CategoriaID INT,
	Precio DECIMAL (10,2) NOT NULL);

CREATE TABLE Sucursales(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255) NOT NULL);

CREATE TABLE Empleados(
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Posicion VARCHAR(255),
	Departamento VARCHAR(255),
	SucursalID INT,
	ROL VARCHAR(255));

CREATE TABLE Clientes(
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255) NOT NULL);

CREATE TABLE OrigenesOrden(
	OrigenesID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL,);


CREATE TABLE TiposPago(
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL,);

CREATE TABLE Mensajeros(
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	EsExterno BIT NOT NULL);

CREATE TABLE DetalleOrden (
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL (10,2),
	PRIMARY KEY (OrdenID,ProductoID));

CREATE TABLE Ordenes(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT,
	SucursalID INT,
	MensajeroID INT,
	TipoPagoID INT,
	OrigenesID INT,
	HorarioVenta VARCHAR(255),
	TotalCompra DECIMAL (10,2),
	KilometrosRecorrer DECIMAL (10,2),
	FechaDespacho DATETIME,
	FechaEntrega DATETIME,
	FechaOrdenTomanda DATETIME,
	FechaOrdenLista DATETIME);

	-- Creación de Relaciones--

ALTER TABLE Productos
ADD CONSTRAINT Fk_Productos_Categorias
FOREIGN KEY (CategoriaID) REFERENCES Categorias (CategoriaID);

ALTER TABLE Ordenes
ADD CONSTRAINT Fk_Ordenes_Empleados
FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID);

ALTER TABLE Ordenes 
ADD CONSTRAINT Fk_Ordenes_Sucursal
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID);

ALTER TABLE Ordenes 
ADD CONSTRAINT Fk_Ordenes_Mensajeros
FOREIGN KEY (MensajeroID) REFERENCES Mensajeros(MensajeroID);

ALTER TABLE Ordenes
ADD CONSTRAINT Fk_Ordenes_TipoPago
FOREIGN KEY (TipoPagoID) REFERENCES TiposPago(TipoPagoID);

ALTER TABLE Ordenes
ADD CONSTRAINT Fk_Ordenes_OrigenesOrden
FOREIGN KEY (OrigenesID) REFERENCES OrigenesOrden(OrigenesID);

ALTER TABLE Ordenes
ADD CONSTRAINT Fk_Ordenes_Clientes
FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID);

ALTER TABLE Empleados
ADD CONSTRAINT Fk_Empleados_Sucursarles
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID);

ALTER TABLE DetalleOrden
ADD CONSTRAINT Fk_DetalleOrden_Ordenes
FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID);

ALTER TABLE DetalleOrden
ADD CONSTRAINT Fk_DetalleOrden_Productos
FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID);
