
/*******************************************************************************
   Studio Yogaritmo Database - Version 1.7
   Script: Yogaritmo_PostgreSql.sql
   Description: Creates and populates the Yogaritmo database.
   DB Server: PostgreSql
   Author: Sandra Bierhals 
********************************************************************************/


/*******************************************************************************
   Create Tables
********************************************************************************/

CREATE TABLE "Professor"
(
    "ID_Prof" INT PRIMARY KEY,
    "Nome" CHAR(60) NOT NULL,
    "Formacao" CHAR(30) NOT NULL,
    "Disponibilidade" CHAR(30) NOT NULL,
    "Email" CHAR(60) NOT NULL,
    "Telefone" CHAR(24) UNIQUE,
    "Morada" CHAR(70)
);

CREATE TABLE "Cliente"
(
    "ID_Cliente" INT PRIMARY KEY,
    "Nome" CHAR(60) NOT NULL,
    "Email" CHAR(60) NOT NULL,
    "Telefone" CHAR(24) UNIQUE,
    "Morada" CHAR(70),
    "Idade" INT NOT NULL
);

CREATE TABLE "TipoDeAula"
(
    "ID_TipoDeAula" INT PRIMARY KEY,
    "Tipo" CHAR(40) NOT NULL    
);

CREATE TABLE "Aula"
(
    "ID_Aula" INT PRIMARY KEY,
    "Duracao" CHAR(30),
    "Data" DATE NOT NULL,
    "Hora" TIME NOT NULL,
    "ID_TipoDeAula" INT NOT NULL,
    "ID_Prof" INT NOT NULL,
    FOREIGN KEY ("ID_TipoDeAula") REFERENCES "TipoDeAula"("ID_TipoDeAula"),
    FOREIGN KEY ("ID_Prof") REFERENCES "Professor"("ID_Prof")
);

CREATE TABLE "Reserva"
(
    "ID_Reserva" INT PRIMARY KEY,
    "Data" DATE NOT NULL,
    "Hora" TIME NOT NULL,
    "ID_Cliente" INT NOT NULL,
    "ID_Aula" INT NOT NULL,
    FOREIGN KEY ("ID_Cliente") REFERENCES "Cliente"("ID_Cliente"),
    FOREIGN KEY ("ID_Aula") REFERENCES "Aula"("ID_Aula")
);

CREATE TABLE "Faz"
(
     "ID_Aula" INT NOT NULL,
     "ID_Cliente" INT NOT NULL,
     FOREIGN KEY ("ID_Aula") REFERENCES "Aula"("ID_Aula"),
     FOREIGN KEY ("ID_Cliente") REFERENCES "Cliente"("ID_Cliente")
);

CREATE TABLE "Feedback"
(
    "ID_Feedback" INT PRIMARY KEY,
    "Nota" INT NOT NULL,
    "Data" DATE NOT NULL,
    "Hora" TIME NOT NULL,
    "ID_Aula" INT NOT NULL,
    "ID_Cliente" INT NOT NULL,
    FOREIGN KEY ("ID_Aula") REFERENCES "Aula"("ID_Aula"),
    FOREIGN KEY ("ID_Cliente") REFERENCES "Cliente"("ID_Cliente")
);

CREATE TABLE "TipoDeCompra"
(
    "ID_TipoDeCompra" INT PRIMARY KEY,
    "Tipo" CHAR(120)    
);

CREATE TABLE "Compra"
(
    "ID_Compra" INT PRIMARY KEY,
    "Data" DATE NOT NULL,
    "Hora" TIME NOT NULL,
    "ID_TipoDeCompra" INT NOT NULL,
    "ID_Cliente" INT NOT NULL,
    FOREIGN KEY ("ID_TipoDeCompra") REFERENCES "TipoDeCompra"("ID_TipoDeCompra"),
    FOREIGN KEY ("ID_Cliente") REFERENCES "Cliente"("ID_Cliente")    
);

CREATE TABLE "Metodo"
(
    "ID_MetodoDePagamento" INT PRIMARY KEY,
    "Tipo" CHAR(60) NOT NULL    
);

CREATE TABLE "Pagamento"
(
    "ID_Pagamento" INT PRIMARY KEY,
    "Status" CHAR(30) NOT NULL,
    "Detalhes" CHAR(60) NOT NULL,
    "Data" DATE NOT NULL,
    "Hora" TIME NOT NULL,
    "Preco" FLOAT NOT NULL,
    "ID_MetodoDePagamento" INT NOT NULL,
    FOREIGN KEY ("ID_MetodoDePagamento") REFERENCES "Metodo"("ID_MetodoDePagamento")
);

/*******************************************************************************
   Populate Tables
********************************************************************************/

INSERT INTO "Professor" ("ID_Prof", "Nome", "Formacao", "Disponibilidade", "Email", "Telefone", "Morada") VALUES
(1, 'David Hogan', 'Yoga Integral', 'Terça e Quinta, 14h-18h', 'cwalker@yahoo.com', '+351929136765', '29371 Zachary Flats Suite 230, Lake Kimberly, WV 34130'),
(2, 'Sarah Smith', 'Ashtanga Yoga', 'Segunda a Sexta, 8h-12h', 'alexandracalderon@santana.com', '+351917942238', '73486 Ball Flat, Lake Monicafort, NE 67649'),
(3, 'Samuel Wilson', 'Ashtanga Yoga', 'Segunda a Sexta, 8h-12h', 'hebertdavid@yahoo.com', '+351917228422', '249 Mayer Key, Russelltown, NC 27245'),
(4, 'Mr. Daniel Morris', 'Hatha Yoga', 'Terça a Sexta, 14h-19h', 'krogers@yahoo.com', '+351989740368', '3439 Williams Expressway, East Jeffrey, OR 80406'),
(5, 'Crystal Brewer', 'Vinyasa Flow', 'Segunda a Sábado, 14h-19h', 'colemankatelyn@gmail.com', '+351988810608', '252 Hendrix Fords Apt. 667, Williamside, IL 17514'),
(6, 'Lúcia Fernandes', 'Vinyasa Flow', 'Terça a Quarta, 14h-19h', 'luciaf@email.com', '+351955740368', 'Avenida dos Oceanos, 890'),
(7, 'Ana Pereira', 'Yoga', 'Quarta a Quinta, 14h-19h', 'anap@email.com', '+351989748868', 'Avenida dos Mares, 90'),
(8, 'Sarah Lee', 'Yoga Integral', 'Terça a Sábado, 14h-19h', 'uriley@valentine-byrd.biz', '+351912471684', '647 Reginald Parkway Suite 973, Charlesmouth, WI 52216'),
(9, 'Stanley Chandler', 'Vinyasa Flow', 'Segunda a Sábado, 14h-19h', 'amanda54@haley-stephens.info', '+351975503228', 'Unit 1688 Box 2467, DPO AP 94818'),
(10, 'Brandy Lee', 'Hatha Yoga', 'Segunda a Sexta, 8h-12h', 'joneskevin@hotmail.com', '+351973790682', '3519 Donald River Apt. 547, Sanchezville, LA 64920'),
(11, 'Elizabeth Yoder', 'Vinyasa Flow', 'Sexta a Sábado, 8h-11h', 'amanda00@jones.org', '+351942962176', 'USS Pennington, FPO AP 46973'),
(12, 'Katelyn Mcgrath', 'Yoga', 'Terça a Sábado, 8h-11h', 'rachel33@garcia-jones.com', '+351963893741', '65273 Carlos Springs Apt. 636, Hoffmanside, AZ 30221'),
(13, 'Billy Valencia', 'Ashtanga Yoga', 'Terça a Sábado, 14h-19h', 'rsilva@gmail.com', '+351962477071', 'Unit 0591 Box 1388, DPO AA 25400'),
(14, 'Jared Martinez', 'Hatha Yoga', 'Segunda a Sexta, 8h-12h', 'pamelasmith@hotmail.com', '+351956926718', '78847 Carla Ridges, New Jasonview, NH 40687'),
(15, 'Lydia Santana', 'Ashtanga Yoga', 'Segunda a Sexta, 8h-12h', 'victorbaker@hampton.com', '+351947818204', '505 Thompson Route Suite 928, West Jason, OR 53362'),
(16, 'Shari Blair', 'Vinyasa Flow', 'Terça e Quinta, 14h-18h', 'prodriguez@gmail.com', '+351938467370', '64598 Kenneth Way, Villegasberg, OR 09723'),
(17, 'Peter Evans', 'Hatha Yoga', 'Terça a Sábado, 14h-19h', 'whitealicia@glass-hernandez.com', '+351957964317', '8334 Gary Mews, Lake Laura, WY 87972'),
(18, 'Latasha Sandoval', 'Vinyasa Flow', 'Terça a Sábado, 14h-19h', 'justinhamilton@mason.info', '+351930271233', '43628 Connor Plains, New Julie, RI 35755'),
(19, 'Megan Moore', 'Yoga Integral', 'Terça e Quinta, 14h-18h', 'mary38@hotmail.com', '+351925802351', '5742 Samantha Tunnel, Brandontown, NJ 92885'),
(20, 'Michael Smith', 'Yoga', 'Terça a Sábado, 14h-19h', 'osmith@thornton-cantrel.com', '+351946006307', '737 Owens Suite 832, Lake Andreaborough, IL 05666');

INSERT INTO "TipoDeAula" ("ID_TipoDeAula", "Tipo") VALUES
(1, 'Kundalini Yoga'),
(2, 'Vinyasa Yoga'),
(3, 'Iyengar Yoga'),
(4, 'Ashtanga Yoga'),
(5, 'Hot Yoga'),
(6, 'Hatha Yoga'),
(7, 'Yin Yoga'),
(8, 'Pilates'),
(9, 'Medidatacao'),
(10, 'Chanting'),
(11, 'Hot Yoga');

INSERT INTO "Aula" ("ID_Aula", "Duracao", "Data", "Hora", "ID_TipoDeAula", "ID_Prof") VALUES
(1, '90 minutos', '2023-07-22', '08:00:00', 7, 19),
(2, '90 minutos', '2023-06-30', '14:30:00', 3, 10),
(3, '60 minutos', '2023-09-20', '09:00:00', 11, 4),
(4, '120 minutos', '2023-05-18', '10:30:00', 5, 16),
(5, '120 minutos', '2023-09-23', '11:00:00', 2, 12),
(6, '90 minutos', '2023-09-30', '15:30:00', 8, 7),
(7, '90 minutos', '2023-04-25', '16:00:00', 1, 14),
(8, '120 minutos', '2023-12-16', '17:30:00', 4, 18),
(9, '60 minutos', '2023-11-26', '18:00:00', 6, 10),
(10, '120 minutos', '2023-07-27', '08:30:00', 9, 18),
(11, '120 minutos', '2023-02-14', '09:30:00', 10, 7),
(12, '60 minutos', '2023-02-21', '10:00:00', 2, 3),
(13, '90 minutos', '2023-06-11', '14:00:00', 11, 3),
(14, '120 minutos', '2023-07-23', '15:00:00', 4, 8),
(15, '60 minutos', '2023-07-06', '16:30:00', 7, 20),
(16, '90 minutos', '2023-10-12', '17:00:00', 3, 10),
(17, '60 minutos', '2023-02-21', '18:30:00', 5, 19),
(18, '90 minutos', '2023-08-11', '08:00:00', 8, 11),
(19, '60 minutos', '2023-07-12', '09:30:00', 6, 8),
(20, '60 minutos', '2023-11-15', '10:30:00', 1, 9),
(21, '120 minutos', '2023-07-18', '14:30:00', 9, 13),
(22, '120 minutos', '2023-01-30', '15:00:00', 10, 5),
(23, '120 minutos', '2023-10-15', '16:00:00', 11, 2),
(24, '90 minutos', '2023-02-03', '17:30:00', 2, 11),
(25, '60 minutos', '2023-06-08', '18:00:00', 7, 17);  /* ID_TipoDeAula values were kept between 1 and 11 because the dataset includes only 11 types */

INSERT INTO "Cliente" ("ID_Cliente", "Nome", "Email", "Telefone", "Morada", "Idade") VALUES
(1, 'Beth Barnett', 'hgonzalez@gmail.com', '+351934715823', '546 Jessica Hill, Horneview, MT 49085', 58),
(2, 'Andrew Evans', 'fbrooks@sharp.info', '+351935510045', '348 James Forge Apt. 810, New Danielfurt, CA 67750', 19),
(3, 'Jennifer Ramirez', 'gregory04@snyder-stewart.com', '+351961942762', '7475 Everett Junctions, North Danielchester, WI 64886', 34),
(4, 'Brett Cooper', 'patrick69@gmail.com', '+351995716964', '425 Tina Loop Suite 836, Kellyhaven, VA 61222', 35),
(5, 'Brianna Mccoy', 'matthewsalexis@yahoo.com', '+351946497172', 'USNS Carey, FPO AE 64754', 30),
(6, 'Jessica Meyer', 'rmckay@herring.biz', '+351931178341', '292 Henderson Union Suite 936, West Matthew, SC 37135', 27),
(7, 'Keith Hodges', 'gomezsamantha@hotmail.com', '+351969558861', '4191 Young Summit Apt. 571, Lake Mary, ND 18299', 31),
(8, 'James Love', 'nathanlopez@hotmail.com', '+351931940619', '718 Christopher Village, Wrightshire, ID 31064', 61),
(9, 'Zachary Rodriguez', 'paulgarcia@gmail.com', '+351973438851', '34187 Kristie Isle Apt. 748, Port Jilltown, AZ 53756', 58),
(10, 'Eric Lee', 'nicholas87@hotmail.com', '+351942940337', '23837 Reyes Drives, Allisonburgh, PA 55309', 21),
(11, 'Pamela George', 'laura15@hernandez-fisher.org', '+351990607747', '803 Shah Wall Apt. 191, Perryfort, MA 65815', 37),
(12, 'Diane Moore', 'thompsonerin@yahoo.com', '+351989455986', '5068 Jensen Plaza, Port Dawnbury, LA 04756', 56),
(13, 'Mary Rangel', 'oconnormary@stuart.biz', '+351960406865', '47306 Moreno Squares Suite 855, Huertamouth, AL 87603', 29),
(14, 'Patricia Vincent', 'tracy62@winters.com', '+351935354918', '6060 Lopez Dam Apt. 379, Travismouth, SC 35031', 67),
(15, 'Douglas Velez', 'christopher52@hotmail.com', '+351974510238', '36684 Gutierrez Islands, North Jenniferport, MN 51315', 24),
(16, 'Alexa Rodriguez', 'harry83@yahoo.com', '+351966627200', '4047 Cortez Vista Apt. 983, Michaelside, KS 24694', 35),
(17, 'Tony Schmitt', 'donaldsmith@frazier.com', '+351936464890', '334 Ramsey Fall Apt. 091, New Kathybury, CO 77064', 26),
(18, 'Michael Harris', 'daisy52@martinez.net', '+351959003579', '2370 Bradley Glen, New Suechester, SD 94276', 47),
(19, 'John George', 'jeremy20@yahoo.com', '+351969161345', '533 Hinton Rapids Apt. 803, Valerieville, GA 56004', 63),
(20, 'Michael Perry', 'matthew19@edwards.com', '+351955222382', '15955 Wilson Pine, Jerryton, WA 77515', 22);

INSERT INTO "Reserva" ("ID_Reserva", "Data", "Hora", "ID_Cliente", "ID_Aula") VALUES
(1, '2023-10-29', '01:27:28', 5, 3),
(2, '2023-04-02', '03:45:45', 8, 21),
(3, '2023-10-11', '03:38:25', 17, 13),
(4, '2023-03-21', '02:21:01', 19, 4),
(5, '2023-07-13', '16:45:57', 18, 1),
(6, '2023-10-20', '13:42:14', 12, 22),
(7, '2023-09-06', '03:12:55', 14, 19),
(8, '2023-01-16', '17:05:22', 14, 12),
(9, '2023-12-08', '19:02:33', 15, 24),
(10, '2023-11-28', '21:45:22', 6, 18),
(11, '2023-05-24', '17:30:37', 13, 15),
(12, '2023-02-03', '21:59:57', 20, 1),
(13, '2023-06-26', '01:17:04', 6, 6),
(14, '2023-07-14', '23:49:29', 6, 25),
(15, '2023-02-21', '17:44:57', 15, 9),
(16, '2023-03-18', '02:09:14', 15, 13),
(17, '2023-03-29', '12:40:24', 17, 12),
(18, '2023-06-07', '01:46:02', 12, 3),
(19, '2023-05-08', '01:32:02', 14, 24),
(20, '2023-12-03', '15:31:53', 16, 10); /* ID_Aula values used ranged from 1 to 25 */

INSERT INTO "Faz" ("ID_Aula", "ID_Cliente") VALUES
(5, 12),  -- Cliente 12 participa da Aula 5
(15, 3),  -- Cliente 3 participa da Aula 15
(2, 17),  -- Cliente 17 participa da Aula 2
(21, 6),  -- Cliente 6 participa da Aula 21
(8, 10),  -- Cliente 10 participa da Aula 8
(13, 19), -- Cliente 19 participa da Aula 13
(7, 4),   -- Cliente 4 participa da Aula 7
(10, 14), -- Cliente 14 participa da Aula 10
(18, 9),  -- Cliente 9 participa da Aula 18
(3, 20),  -- Cliente 20 participa da Aula 3
(24, 7),   -- Cliente 7 participa da Aula 1
(14, 5),  -- Cliente 5 participa da Aula 14
(19, 2),  -- Cliente 2 participa da Aula 19
(11, 16), -- Cliente 16 participa da Aula 11
(6, 8),   -- Cliente 8 participa da Aula 6
(9, 18),  -- Cliente 18 participa da Aula 9
(4, 15),  -- Cliente 15 participa da Aula 4
(12, 13), -- Cliente 13 participa da Aula 12
(17, 11), -- Cliente 11 participa da Aula 17
(20, 1);  -- Cliente 1 participa da Aula 20

INSERT INTO "Feedback" ("ID_Feedback", "Nota", "Data", "Hora", "ID_Aula", "ID_Cliente") VALUES
(1, 4, '2023-10-09', '16:23:43', 14, 4),
(2, 1, '2023-05-18', '09:06:45', 6, 12),
(3, 4, '2023-06-30', '15:21:20', 12, 19),
(4, 4, '2022-12-29', '18:21:58', 15, 13),
(5, 2, '2023-06-25', '11:23:40', 2, 13),
(6, 2, '2023-10-12', '14:01:50', 9, 15),
(7, 3, '2023-06-27', '19:35:11', 4, 17),
(8, 4, '2023-04-06', '17:07:33', 13, 20),
(9, 5, '2023-08-26', '00:58:44', 5, 8),
(10, 4, '2023-06-02', '13:19:58', 13, 12),
(11, 2, '2023-06-10', '11:08:51', 13, 4),
(12, 2, '2023-04-07', '23:12:08', 22, 4),
(13, 5, '2023-11-02', '15:40:22', 8, 2),
(14, 2, '2023-11-29', '18:57:28', 19, 1),
(15, 1, '2023-03-18', '18:25:28', 15, 19),
(16, 1, '2023-04-30', '06:55:32', 17, 12),
(17, 2, '2023-07-22', '21:28:21', 19, 15),
(18, 5, '2023-05-10', '17:52:21', 12, 19),
(19, 5, '2023-04-20', '03:51:30', 19, 18),
(20, 1, '2023-02-03', '22:15:10', 25, 14);  /* These values represent feedback scores (assuming a scale from 1 to 5). */

INSERT INTO "TipoDeCompra" ("ID_TipoDeCompra", "Tipo") VALUES (1, 'Pacote de 5 aulas');
INSERT INTO "TipoDeCompra" ("ID_TipoDeCompra", "Tipo") VALUES (2, 'Pacote de 10 aulas');
INSERT INTO "TipoDeCompra" ("ID_TipoDeCompra", "Tipo") VALUES (3, 'Mensalidades'); /* Each type has a unique ID associated with it to simplify references in other parts of the database. */

INSERT INTO "Compra" ("ID_Compra", "Data", "Hora", "ID_TipoDeCompra", "ID_Cliente") VALUES
(1, '2023-03-10', '07:40:09', 1, 9),
(2, '2023-04-01', '03:12:20', 3, 2),
(3, '2023-11-04', '22:33:54', 1, 19),
(4, '2023-05-08', '14:34:22', 3, 1),
(5, '2023-12-15', '12:49:53', 2, 17),
(6, '2023-11-14', '23:10:03', 3, 1),
(7, '2023-04-28', '14:11:35', 3, 20),
(8, '2023-10-27', '18:56:42', 1, 9),
(9, '2023-11-28', '00:23:56', 2, 10),
(10, '2023-10-03', '07:10:14', 2, 14),
(11, '2023-05-28', '17:05:46', 3, 18),
(12, '2023-01-05', '04:25:48', 3, 12),
(13, '2023-08-27', '05:19:11', 3, 7),
(14, '2023-09-30', '03:37:44', 3, 14),
(15, '2023-08-09', '18:23:40', 3, 3),
(16, '2023-11-13', '13:12:18', 1, 1),
(17, '2023-01-05', '01:27:16', 2, 3),
(18, '2023-11-15', '14:09:51', 3, 1),
(19, '2023-01-08', '11:47:06', 1, 9),
(20, '2023-04-11', '02:53:57', 3, 6);

INSERT INTO "Metodo" ("ID_MetodoDePagamento", "Tipo") VALUES
(1, 'Virtual'),
(2, 'Cartão'),
(3, 'Voucher'),
(4, 'Numerário');

INSERT INTO "Pagamento" ("ID_Pagamento", "Status", "Detalhes", "Data", "Hora", "Preco", "ID_MetodoDePagamento") VALUES
(1, 'Concluído', 'Compra de Pacote de 10 Aulas', '2023-05-30', '04:09:40', 50.00, 3),
(2, 'Concluído', 'Pagamento de Mensalidade', '2023-06-20', '09:04:22', 35.00, 4),
(3, 'Concluído', 'Compra de Pacote de 5 Aulas', '2023-10-22', '20:48:54', 30.00, 1),
(4, 'Concluído', 'Compra de Pacote de 10 Aulas', '2023-07-31', '17:03:03', 50.00, 2),
(5, 'Pendente', 'Pagamento de Mensalidade', '2023-06-22', '10:07:04', 35.00, 3),
(6, 'Concluído', 'Pagamento de Mensalidade', '2023-11-20', '14:38:02', 35.00, 1),
(7, 'Concluído', 'Pagamento de Mensalidade', '2023-05-09', '01:20:37', 35.00, 1),
(8, 'Concluído', 'Compra de Pacote de 10 Aulas', '2023-07-10', '22:00:47', 50.00, 3),
(9, 'Cancelado', 'Compra de Pacote de 5 Aulas', '2023-03-17', '13:40:15', 30.00, 3),
(10, 'Concluído', 'Pagamento de Mensalidade', '2023-07-03', '22:07:25', 35.00, 3),
(20, 'Concluído', 'Compra de Pacote de 10 Aulas', '2023-11-26', '19:35:38', 50.00, 3),
(21, 'Concluído', 'Compra de Pacote de 5 Aulas', '2023-05-08', '13:55:20', 30.00, 4),
(22, 'Concluído', 'Compra de Pacote de 5 Aulas', '2023-03-31', '11:34:13', 30.00, 3),
(23, 'Concluído', 'Compra de Pacote de 10 Aulas', '2023-03-07', '01:39:10', 50.00, 2),
(24, 'Concluído', 'Pagamento de Mensalidade', '2023-05-19', '18:19:32', 35.00, 3),
(25, 'Pendente', 'Compra de Pacote de 10 Aulas', '2023-08-26', '17:14:32', 50.00, 3),
(26, 'Concluído', 'Compra de Pacote de 5 Aulas', '2023-05-19', '09:32:08', 30.00, 1),
(27, 'Concluído', 'Pagamento de Mensalidade', '2023-09-09', '05:49:14', 35.00, 2),
(28, 'Concluído', 'Compra de Pacote de 10 Aulas', '2023-07-04', '22:36:28', 50.00, 1),
(29, 'Pendente', 'Compra de Pacote de 5 Aulas', '2023-01-31', '23:14:41', 30.00, 4),
(30, 'Concluído', 'Pagamento de Mensalidade', '2022-12-25', '09:19:22', 35.00, 3);





























