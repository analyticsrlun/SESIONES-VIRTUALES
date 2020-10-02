#install.packages("RODBC")
library(RODBC) 
cn  <- odbcDriverConnect(connection="Driver={SQL Server};server=LAPTOP-BIT1OKR8;database=AnalyticsRL;trusted_connection=yes;")

#CREAR TABLA
sqlQuery(cn,"CREATE TABLE Usuario(id int identity(1,1) PRIMARY KEY,
              Nombre VARCHAR(50),
              Nacionalidad VARCHAR(30),
              FechaNac date)")


#AÑADIR DIRECCIÓN
 <- sqlQuery(cn,"ALTER TABLE Usuario ADD Direccion VARCHAR(50)")


#MODIFICAR UNA COLUMNA
sqlQuery(cn,"ALTER TABLE Usuario ALTER COLUMN Nombre VARCHAR(60)")


#CREAR TABLA CARRERA
sqlQuery(cn,"CREATE TABLE Carrera(IdCarrera VARCHAR(5) PRIMARY KEY, Carrera VARCHAR(50))")


#AÑADIR ELEMENTOS A CARRERA
sqlQuery(cn,"INSERT Carrera (IdCarrera,Carrera) VALUES ('ISC','Ingenieria en sistemas')")

sqlQuery(cn,"INSERT Carrera (IdCarrera,Carrera) VALUES ('IND','Ingenieria Industrial')")



#AGREGAR IdCarrera en Usuario
sqlQuery(cn,"ALTER TABLE Usuario ADD IdCarrera VARCHAR(5)")


#AGREGAR LLAVE FOREANA IdCarrera a Usuario
sqlQuery(cn,"ALTER TABLE Usuario ADD CONSTRAINT FK_IdCarrera
             FOREIGN KEY (IdCarrera) REFERENCES Carrera(IdCarrera)")


#DESPLEGAR TODOS LOS ELEMETOS DE CARRERA
carrera <- sqlQuery(cn,"SELECT * FROM Carrera")

#AÑADIR REGISTROS
sqlQuery(cn,"INSERT INTO  Usuario VALUES('Karen Morales','Mexicana','10/10/1997','Tijuana','ISC')")
sqlQuery(cn,"INSERT INTO  Usuario VALUES('Jairo Castro','Colombiano','07/06/1999','Tijuana','IND')")

sqlQuery(cn,"SELECT * FROM Usuario")

#PAQUETE SQLDF sirve para ejecutar sentencias SQL en marcos de datos R, optimizado para mayor comodidad.

#install.packages("sqldf")
# install.packages("datos", dependencies = T)
 require(sqldf)
 library(datos)
 paises <- datos ::paises

 View(paises)

# Comodín *
 sqldf("SELECT * FROM paises")
 
#SELECT variable1, variable2 FROM data
 sqldf("SELECT pais,Continente from paises")

# LIMIT #.
 a <-sqldf("SELECT * FROM paises LIMIT 5")

 
# SUM()
 sqldf("SELECT SUM(Anio) AS 'SUMA AÑOS 'from paises ")

 
# AVG ()
 sqldf("SELECT SUM(Anio) AS 'SUMA AÑOS ', AVG(Anio) AS 'PROMEDIO AÑOS' from paises ")
 

# COUNT
 sqldf("SELECT COUNT(Continente) AS 'CANTIDAD ASIA' FROM paises where Continente='Asia'")

  
# GROUP BY
 sqldf("SELECT Continente AS 'NombredeContinente' from paises GROUP BY Continente")


# DESC ASC
 sqldf("SELECT * from paises ASC")

# upper,lower
 names(paises)
 sqldf("sELECT UPPER(Pais) as 'PAIS' ,LOWER(Continente) AS 'continente' from paises limit 5 ")

# WHERE < > != <> ==
 sqldf("SELECT Continente, pais, Anio, poblacion from paises where Anio<2015 limit 20")

#BETWEEN 
sqldf("SELECT Anio,pais,Continente from paises where Anio between 2000 AND 2018 LIMIT 15")
 
#TERMINE LIKE '%'
sqldf("SELECT * from paises WHERE pais LIKE '%A' LIMIT 15 ")
 

 #INICIO LIKE 'A%'
sqldf("SELECT Continente,pais from paises WHERE pais LIKE 'A%' LIMIT 15 ")

 
 # TINE LIKE '%A%'
sqldf("SELECT Continente,pais, Anio from paises WHERE pais LIKE '%A%'")
 