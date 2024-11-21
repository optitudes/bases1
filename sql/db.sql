-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: tur
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `project_types`
--

DROP TABLE IF EXISTS `project_types`;

CREATE TABLE project_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

--
-- Table structure for table `order_types`
--

DROP TABLE IF EXISTS `order_types`;

CREATE TABLE order_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

--
-- Table structure for table `order_state`
--

DROP TABLE IF EXISTS `order_states`;

CREATE TABLE order_states (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    name VARCHAR(200) UNIQUE NOT NULL,
    password VARCHAR(200) UNIQUE NOT NULL
);


--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;

CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (120) NOT NULL,
    address VARCHAR (200) NULL,
    phone VARCHAR (50) NULL,
    user_id int(11)  NULL,
    CONSTRAINT fk_client_user_idx FOREIGN KEY (user_id) REFERENCES users(id)
);

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATE NOT NULL,
    delivery_date DATE NOT NULL,
    client_id INT(11) NOT NULL,
    order_type_id INT(11) NOT NULL,
    order_state_id INT(11) NOT NULL,
    observations TEXT NULL,
    CONSTRAINT fk_order_client FOREIGN KEY (client_id) REFERENCES clients(id),
    CONSTRAINT fk_order_type FOREIGN KEY (order_type_id) REFERENCES order_types(id),
    CONSTRAINT fk_order_state_id FOREIGN KEY (order_state_id) REFERENCES order_states(id)
);

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;

CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount Double(10,2) NOT NULL,
    amount_paid Double(10,2) NOT NULL,
    created_at DATE NOT NULL,
    due_date DATE NOT NULL,  
    paid_at DATE NULL,       
    order_id INT(11)  NULL,
    client_id INT(11)  NULL,
    CONSTRAINT fk_bill_order FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_bill_client_idx FOREIGN KEY (client_id) REFERENCES clients(id)
);

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount Double(10,2) NOT NULL,
    bill_id INT(11)  NULL,
    created_at DATE NOT NULL,
    CONSTRAINT fk_payment_bill FOREIGN KEY (bill_id) REFERENCES bills(id)
);

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `departments`;

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) UNIQUE NOT NULL
);

--
-- Table structure for table `teachers`
--
DROP TABLE IF EXISTS `teachers`;

CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id int(11)  NULL,
    department_id int(11)  NULL,
    CONSTRAINT fk_teacher_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_teacher_department FOREIGN KEY (department_id) REFERENCES departments(id)
);



--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    duration_months int(11) NOT NULL,
    credits int(11) NOT NULL,
    teacher_id int(11)  NULL,
    CONSTRAINT fk_course_teacher FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

--
-- Table structure for table `students`
--
DROP TABLE IF EXISTS `students`;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id int(11)  NULL,
    department_id int(11)  NULL,
    CONSTRAINT fk_student_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_student_department FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Dropping the existing table if it exists
DROP TABLE IF EXISTS `course_student`;

-- Creating the course_student table
CREATE TABLE course_student (
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    final_note DECIMAL(4,4) NOT NULL,
    PRIMARY KEY (course_id, student_id),
    CONSTRAINT fk_course_student_course FOREIGN KEY (course_id) REFERENCES courses(id),
    CONSTRAINT fk_course_student_student FOREIGN KEY (student_id) REFERENCES students(id)
);

--
-- Table structure for table `projects`
--
DROP TABLE IF EXISTS `projects`;

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description VARCHAR(200) NOT NULL,
    start_date Date NOT NULL,
    end_time  Date NOT NULL,
    price DECIMAL(16,2) NOT NULL,
    project_type_id int(11)  NULL,
    artist_id int(11)  NULL,
    order_id int(11)  NULL,
    CONSTRAINT fk_project_project_type FOREIGN KEY (project_type_id) REFERENCES project_types(id),
    CONSTRAINT fk_project_artist FOREIGN KEY (artist_id) REFERENCES teachers(id),
    CONSTRAINT fk_project_order FOREIGN KEY (order_id) REFERENCES orders(id)
);

--
-- Table structure for table `product_types`
--

DROP TABLE IF EXISTS `product_types`;

CREATE TABLE product_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);


--
-- Table structure for table `products`
--
DROP TABLE IF EXISTS `products`;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description VARCHAR(200) NOT NULL,
    type_id int(11)  NOT NULL,
    project_id int(11)  NULL,
    order_id int(11)  NULL,
    CONSTRAINT fk_product_type_idx FOREIGN KEY (type_id) REFERENCES product_types(id),
    CONSTRAINT fk_product_project_idx FOREIGN KEY (project_id) REFERENCES projects(id),
    CONSTRAINT fk_project_order_idx FOREIGN KEY (order_id) REFERENCES orders(id)
);


-- Inserting data into `project_types`
LOCK TABLES `project_types` WRITE;

INSERT INTO project_types (name, description) VALUES
('Pintura', 'Proyectos centrados en técnicas de pintura al óleo, acrílico y acuarela, explorando la teoría del color y la composición.'),
('Escultura', 'Proyectos de escultura usando materiales como arcilla, mármol y metal para la creación de formas tridimensionales.'),
('Fotografía', 'Proyectos de fotografía que abarcan desde técnicas analógicas hasta digitales, con un enfoque en la composición y la narrativa visual.'),
('Diseño Gráfico', 'Proyectos enfocados en la creación de composiciones visuales usando software de diseño y teoría del diseño.'),
('Arte Digital', 'Proyectos que combinan medios tradicionales y digitales para crear nuevas formas de expresión visual.'),
('Instalación', 'Proyectos de arte conceptual y de instalación, creando experiencias inmersivas e interactivas.'),
('Cine Experimental', 'Proyectos de cine donde se experimenta con técnicas cinematográficas poco convencionales.'),
('Arte Urbano', 'Proyectos que se desarrollan en espacios públicos, incluyendo murales y arte en calles.'),
('Performance', 'Proyectos que combinan arte escénico, música y danza para expresar conceptos a través del cuerpo y la acción.'),
('Textil', 'Proyectos que exploran el arte del tejido, bordado y otras técnicas textiles en el contexto del arte contemporáneo.');

UNLOCK TABLES;

-- Inserting data into `order_types`
LOCK TABLES `order_types` WRITE;

INSERT INTO order_types (name, description) VALUES
('Encargo', 'Proyectos solicitados por clientes con un tema o estilo específico.'),
('Colección', 'Proyectos de arte realizados para ser parte de una colección permanente o temporal.'),
('Exposición', 'Proyectos creados específicamente para ser exhibidos en una galería o museo.'),
('Restauración', 'Proyectos de restauración de obras de arte antiguas o dañadas.'),
('Comercial', 'Proyectos realizados con un propósito comercial, como ilustraciones para marcas.'),
('Educacional', 'Proyectos enfocados en el aprendizaje y desarrollo de técnicas artísticas.'),
('Colaborativo', 'Proyectos donde varios artistas trabajan juntos en una obra colectiva.'),
('Fomentar Creatividad', 'Proyectos diseñados para estimular la creatividad en un entorno de grupo.'),
('Prototipo', 'Proyectos diseñados como prototipos para futuras producciones artísticas.'),
('Digitalización', 'Proyectos de arte creados para ser presentados en formatos digitales.');

UNLOCK TABLES;

-- Inserting data into `order_states`
LOCK TABLES `order_states` WRITE;

INSERT INTO order_states (name, description) VALUES
('Pendiente', 'El pedido ha sido recibido pero aún no ha comenzado.'),
('En progreso', 'El pedido está siendo trabajado activamente.'),
('Completado', 'El pedido ha sido terminado y está listo para la entrega.'),
('Cancelado', 'El pedido ha sido cancelado por el cliente o la academia.'),
('Retrasado', 'El pedido ha sufrido un retraso en la entrega.'),
('Aprobado', 'El pedido ha sido aprobado por el cliente para su ejecución.'),
('Rechazado', 'El pedido no fue aprobado por el cliente debido a diferencias en el diseño.'),
('En revisión', 'El pedido está siendo evaluado para modificaciones.'),
('Entregado', 'El pedido ha sido entregado al cliente.'),
('Facturado', 'El pedido ha sido facturado y está pendiente de pago.');

UNLOCK TABLES;

-- Inserting data into `users`
LOCK TABLES `users` WRITE;

INSERT INTO users (email, name, password) VALUES
('alicia@artacademy.com', 'Alicia Fernández', '1234pass'),
('juan@artacademy.com', 'Juan Pérez', '5678pass'),
('luisa@artacademy.com', 'Luisa Martínez', 'abcd1234'),
('pedro@artacademy.com', 'Pedro Gómez', 'qwerty1234'),
('maria@artacademy.com', 'María López', 'password987'),
('jose@artacademy.com', 'José Hernández', 'securepass01'),
('anna@artacademy.com', 'Anna Ruiz', 'newpass1234'),
('carlos@artacademy.com', 'Carlos Sánchez', '12345secure'),
('laura@artacademy.com', 'Laura Díaz', 'pass1234safe'),
('francisco@artacademy.com', 'Francisco Ramos', 'keysecure098');

UNLOCK TABLES;

-- Inserting data into `clients`
LOCK TABLES `clients` WRITE;

INSERT INTO clients (name, address, phone, user_id) VALUES
('Carlos Arte', 'Calle del Arte, 101', '555-1234', 1),
('Galería El Sol', 'Avenida de la Cultura, 25', '555-5678', 2),
('María de la Cruz', 'Plaza de las Artes, 10', '555-8765', 3),
('Estudio Creativo', 'Calle 45, 14', '555-2345', 4),
('Exposiciones López', 'Calle Mayor, 200', '555-9999', 5),
('Taller de Arte', 'Avenida de los Pintores, 35', '555-4532', 6),
('Arte Contemporáneo', 'Ronda de la Cultura, 67', '555-8765', 7),
('Galería Aérea', 'Calle La Luna, 12', '555-5432', 8),
('Proyectos Visuales', 'Calle de los Artistas, 50', '555-1239', 9),
('Tienda de Arte', 'Calle del Viento, 19', '555-7543', 10);

UNLOCK TABLES;

-- Inserting data into `orders`
LOCK TABLES `orders` WRITE;

INSERT INTO orders (created_at, delivery_date, client_id, order_type_id, order_state_id, observations) VALUES
('2024-11-01', '2024-12-01', 1, 1, 1, 'Pedido inicial de pintura.'),
('2024-11-05', '2024-12-10', 2, 3, 2, 'Encargo para exposición de esculturas.'),
('2024-11-07', '2024-12-15', 3, 2, 1, 'Restauración de pintura antigua.'),
('2024-11-10', '2024-12-20', 4, 1, 4, 'Comisión de arte comercial para una marca.'),
('2024-11-15', '2024-12-25', 5, 5, 1, 'Nuevo proyecto de arte digital.'),
('2024-11-17', '2024-12-30', 6, 4, 1, 'Cine experimental para galería.'),
('2024-11-20', '2024-12-10', 7, 6, 2, 'Exposición de arte contemporáneo.'),
('2024-11-22', '2024-12-05', 8, 7, 3, 'Pintura mural para espacio público.'),
('2024-11-25', '2024-12-15', 9, 8, 2, 'Colaboración artística de pintura y escultura.'),
('2024-11-28', '2024-12-20', 10, 9, 1, 'Proyecto de instalación artística.');

UNLOCK TABLES;

-- Inserting data into `bills`
LOCK TABLES `bills` WRITE;

INSERT INTO bills (amount, amount_paid, created_at, due_date, paid_at, order_id, client_id) VALUES
(2000.00, 1000.00, '2024-11-05', '2024-12-05', NULL, 1, 1),
(3000.00, 1500.00, '2024-11-10', '2024-12-10', NULL, 2, 2),
(1500.00, 500.00, '2024-11-15', '2024-12-15', NULL, 3, 3),
(1000.00, 500.00, '2024-11-18', '2024-12-18', NULL, 4, 4),
(2500.00, 1000.00, '2024-11-22', '2024-12-22', NULL, 5, 5),
(3500.00, 1750.00, '2024-11-25', '2024-12-25', NULL, 6, 6),
(4000.00, 2000.00, '2024-11-27', '2024-12-27', NULL, 7, 7),
(1200.00, 600.00, '2024-11-30', '2024-12-30', NULL, 8, 8),
(1800.00, 900.00, '2024-12-01', '2024-12-30', NULL, 9, 9),
(2200.00, 1100.00, '2024-12-03', '2024-12-30', NULL, 10, 10);

UNLOCK TABLES;

-- Inserting data into `payments`
LOCK TABLES `payments` WRITE;

INSERT INTO payments (amount, bill_id, created_at) VALUES
(500.00, 1, '2024-11-06'),
(1000.00, 2, '2024-11-12'),
(200.00, 3, '2024-11-17'),
(300.00, 4, '2024-11-20'),
(700.00, 5, '2024-11-23'),
(1200.00, 6, '2024-11-26'),
(1000.00, 7, '2024-11-28'),
(500.00, 8, '2024-12-02'),
(400.00, 9, '2024-12-05'),
(500.00, 10, '2024-12-08');

UNLOCK TABLES;

-- Inserting data into `departments`
LOCK TABLES `departments` WRITE;

INSERT INTO departments (name) VALUES
('Pintura'),
('Escultura'),
('Fotografía'),
('Diseño Gráfico'),
('Arte Digital'),
('Instalación'),
('Cine Experimental'),
('Arte Urbano'),
('Performance'),
('Textil');

UNLOCK TABLES;

-- Inserting data into `teachers`
LOCK TABLES `teachers` WRITE;

INSERT INTO teachers (user_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

UNLOCK TABLES;

-- Inserting data into `courses`
LOCK TABLES `courses` WRITE;

INSERT INTO courses (name, duration_months, credits, teacher_id) VALUES
('Pintura al óleo', 6, 30, 1),
('Escultura en arcilla', 6, 30, 2),
('Fotografía digital', 6, 30, 3),
('Diseño gráfico básico', 6, 30, 4),
('Arte digital avanzado', 6, 30, 5),
('Instalación artística', 6, 30, 6),
('Cine experimental y vanguardista', 6, 30, 7),
('Arte urbano y muralismo', 6, 30, 8),
('Performance y teatro experimental', 6, 30, 9),
('Textil y bordado contemporáneo', 6, 30, 10);

UNLOCK TABLES;

-- Inserting data into `students`
LOCK TABLES `students` WRITE;

INSERT INTO students (user_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

UNLOCK TABLES;

-- Inserting data into `course_student`
LOCK TABLES `course_student` WRITE;

INSERT INTO course_student (course_id, student_id, final_note) VALUES
(1, 1, 9.5),
(2, 2, 8.5),
(3, 3, 7.0),
(4, 4, 6.0),
(5, 5, 8.0),
(6, 6, 9.0),
(7, 7, 8.5),
(8, 8, 9.0),
(9, 9, 9.5),
(10, 10, 7.5);

UNLOCK TABLES;

-- Inserting data into `projects`
LOCK TABLES `projects` WRITE;

INSERT INTO projects (name, description, start_date, end_time, price, project_type_id, artist_id, order_id) VALUES
('Pintura Abstracta', 'Proyecto de pintura abstracta para una exposición de arte contemporáneo', '2024-11-01', '2024-12-01', 3000.00, 1, 1, 1),
('Escultura Moderna', 'Escultura moderna que combina materiales reciclados y tradicionales', '2024-11-05', '2024-12-05', 5000.00, 2, 2, 2),
('Fotografía Nocturna', 'Serie de fotografías de paisajes urbanos nocturnos', '2024-11-10', '2024-12-10', 2000.00, 3, 3, 3),
('Arte Digital Interactivo', 'Proyecto de arte digital que explora la interacción entre el público y la obra', '2024-11-15', '2024-12-15', 4000.00, 4, 4, 4),
('Instalación Sonora', 'Instalación sonora que fusiona arte visual y música experimental', '2024-11-20', '2024-12-20', 6000.00, 5, 5, 5),
('Cine Experimental', 'Película experimental de corta duración, enfocada en técnicas no convencionales de grabación', '2024-11-25', '2024-12-25', 3500.00, 6, 6, 6),
('Arte Urbano Mural', 'Mural artístico en la calle que representa la cultura local', '2024-11-30', '2024-12-30', 2500.00, 7, 7, 7),
('Performance Teatral', 'Performance que combina danza, música y arte visual para expresar conceptos abstractos', '2024-12-05', '2024-12-15', 1500.00, 8, 8, 8),
('Textil Experimental', 'Proyecto de arte textil con materiales reciclados, bordado y técnicas mixtas', '2024-12-10', '2024-12-20', 2000.00, 9, 9, 9),
('Escultura en Hielo', 'Escultura efímera en hielo que cambia con las estaciones', '2024-12-15', '2024-12-25', 7000.00, 10, 10, 10);

UNLOCK TABLES;

-- Inserting data into `product_types`
LOCK TABLES `product_types` WRITE;

INSERT INTO product_types (name, description) VALUES
('Escultura', 'Esculturas creadas en materiales como piedra, madera y metal.'),
('Pintura', 'Pinturas en diversos estilos y técnicas, como óleo, acuarela y acrílico.'),
('Fotografía', 'Fotografías artísticas impresas en diversos tamaños y formatos.'),
('Digital', 'Arte digital impreso o visualizado en plataformas electrónicas.'),
('Arte Textil', 'Obras de arte creadas con tejidos, bordados y fibras.'),
('Impresión 3D', 'Proyectos artísticos que utilizan impresoras 3D para crear piezas de arte.'),
('Collage', 'Obras que combinan diferentes elementos y materiales en una sola pieza.'),
('Performance', 'Obras performativas que invitan a la interacción del público.'),
('Mural', 'Pinturas o dibujos realizados en murales o paredes de espacios públicos.'),
('Instalación', 'Obras de arte que crean una experiencia inmersiva para el espectador.');

UNLOCK TABLES;

-- Inserting data into `products`
LOCK TABLES `products` WRITE;

INSERT INTO products (name, description, type_id, project_id, order_id) VALUES
('Escultura en Mármol', 'Escultura abstracta en mármol, obra única', 1, 1, 1),
('Pintura Abstracta', 'Pintura abstracta al óleo con colores vibrantes', 2, 2, 2),
('Fotografía de la Ciudad', 'Fotografía en blanco y negro de la ciudad nocturna', 3, 3, 3),
('Arte Digital en Pantalla', 'Pieza de arte digital que interactúa con el público', 4, 4, 4),
('Cojín Bordado', 'Cojín decorativo con bordado manual de diseño contemporáneo', 5, 5, 5),
('Escultura Impresa en 3D', 'Escultura moderna creada con impresión 3D', 6, 6, 6),
('Collage de Fotografías', 'Collage artístico utilizando fotografías de la ciudad', 7, 7, 7),
('Mural Urbano', 'Mural en la pared de un edificio con temática local', 8, 8, 8),
('Instalación de Luz', 'Instalación artística que juega con luces y sombras', 9, 9, 9),
('Escultura Efímera en Hielo', 'Escultura de hielo que cambia de forma con el tiempo', 10, 10, 10);

UNLOCK TABLES;
