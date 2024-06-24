# Flutter Worker Project App
Esta es una aplicación desarrollada en Dart para Flutter, diseñada para dispositivos Android, que permite gestionar trabajadores y sus proyectos mediante una relación N. 
Utiliza una API RESTful para interactuar con los datos, la cual está implementada mediante NoCodeDB (NoCoDB) ejecutado en Docker.

## Características
- Gestión de Trabajadores y Proyectos: Visualiza y gestiona la relación entre trabajadores y proyectos.
- Búsqueda: Realiza búsquedas tanto de trabajadores como de proyectos para facilitar la navegación.
- Detalles Ampliados: Permite ver detalles específicos de cada trabajador y proyecto al pulsar sobre ellos.
- Tecnologías Utilizadas
- Flutter: Framework de Google para el desarrollo de aplicaciones móviles.
- Dart: Lenguaje de programación utilizado por Flutter.
- NoCodeDB: Plataforma que proporciona una interfaz de base de datos API-first a través de Docker.
- Docker: Plataforma de contenedores que permite la ejecución de aplicaciones de manera aislada y eficiente.
## Instalación y Ejecución
- Clona este repositorio.
- Asegúrate de tener Docker instalado en tu máquina.
- Ejecuta NoCodeDB utilizando Docker:
```
docker run -p 8080:8080 nocodb/nocodb
```
> info de NoCoDB: [documentación](https://data-apis-v2.nocodb.com)

Configura la URL de la API en el archivo de configuración de la aplicación Flutter.
Ejecuta la aplicación en tu dispositivo Android utilizando Flutter.
## Base de datos
```
-- Create Worker table
CREATE TABLE Workers (
 ID INT AUTO_INCREMENT PRIMARY KEY,
 Image_Path VARCHAR(255) NOT NULL,
 First_Name VARCHAR(25) NOT NULL,
 Last_Name VARCHAR(50) NOT NULL,
 Email VARCHAR(100),
 Date_of_Birth DATE NOT NULL,
 Phone VARCHAR(9) NOT NULL CHECK (Phone REGEXP '^[0-9]{9}$'),
 Address VARCHAR(100) NOT NULL
);

-- Create Projects table
CREATE TABLE Projects (
 ID INT AUTO_INCREMENT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL,
 Description VARCHAR(255) NOT NULL,
 Budget DECIMAL(10,2),
 Start_Date DATE NOT NULL,
 End_Date DATE
);

-- Create project_worker relationship table with composite primary key
CREATE TABLE project_worker (
 Worker_ID INT,
 Project_ID INT,
 Role ENUM('Leader','Member','Collaborator') DEFAULT 'Member',
 Assigned_Hours_Per_Week TINYINT CHECK (Assigned_Hours_Per_Week BETWEEN 0 AND 40),
 Assignment_Date DATE DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (Worker_ID) REFERENCES Workers(ID) ON UPDATE CASCADE ON DELETE NO ACTION,
 FOREIGN KEY (Project_ID) REFERENCES Projects(ID) ON UPDATE CASCADE ON DELETE NO ACTION,
 PRIMARY KEY (Worker_ID, Project_ID)
);
```
## Contribuciones
¡Las contribuciones son bienvenidas! 
#### Por favor, sigue los siguientes pasos para contribuir:
- Realiza un fork del repositorio.
- Crea una nueva rama para tu funcionalidad (git checkout -b nueva-funcionalidad).
- Realiza los cambios necesarios y realiza commit (git commit -m 'Añadir nueva funcionalidad').
- Empuja los cambios a tu rama (git push origin nueva-funcionalidad).
- Crea un Pull Request en GitHub.

## Autor
- Bryan Graña Martínez
## Contacto
Para cualquier duda o sugerencia, contáctame por correo electrónico:
- [Email](mailto:bryangranamartinez@gmail.com)
