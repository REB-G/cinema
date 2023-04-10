-- Commandes --

-- Connexion : mysql -u identifiant -p mot_de_passe --
-- Pour voir les base de données : show databases --
-- Pour utiliser la base de données cinemas : use cinemas--
-- Pour créer une table : create table nom_de_la_table --
-- Pour voir les tables de la base de données : show tables --
-- Pour voir ce qui compose les tables : describe nom_de_la_table --
-- Pour modifier une table : alter table nom_de_la_table (suivi des instructions comme ADD nom_de_la_colonne, ou DROP nom_de_la_colonne par exemple) --
-- Pour supprimer une table : drop table nom_de_la_table --
-- Pour supprimer une base de données : drop database nom_de_la_table --
-- Pour quitter : exit ou ctrl + c --


-- Création de la base de données --
CREATE DATABASE IF NOT EXISTS cinemas;


-- Création des tables --

CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    firstname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    date_of_birth DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
    ) ENGINE=InnoDB;

CREATE TABLE prices (
    price_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name_category VARCHAR(255) NOT NULL,
    price float NOT NULL
    ) ENGINE=InnoDB;

CREATE TABLE genders (
    gender_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name_gender VARCHAR(50) NOT NULL
    ) ENGINE=InnoDB;

CREATE TABLE movies_theaters (
    movies_theater_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    number INT NOT NULL,
    total_of_places INT NOT NULL
    ) ENGINE=InnoDB;

CREATE TABLE movies (
    movie_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    duration INT NOT NULL,
    actors TEXT NOT NULL,
    directors TEXT NOT NULL,
    gender_id INT NOT NULL,
    CONSTRAINT movies_ibfk_1 FOREIGN KEY (gender_id) REFERENCES genders(gender_id)
    ) ENGINE=InnoDB;

CREATE TABLE sessions (
    session_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    movie_id INT NOT NULL,
    movies_theater_id INT NOT NULL,
    CONSTRAINT session_ibfk_1 FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    CONSTRAINT session_ibfk_2 FOREIGN KEY (movies_theater_id) REFERENCES movies_theaters(movies_theater_id)
    ) ENGINE=InnoDb;

CREATE TABLE cinemas (
    cinema_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    adress VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT cinema_ibfk_1 FOREIGN KEY (user_id) REFERENCES users(user_id)
    ) ENGINE=InnoDB;

CREATE TABLE reservations (
    reservation_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    reservation_date DATETIME NOT NULL,
    number_of_people INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    firstname VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(255) NOT NULL,
    amount float NOT NULL,
    created_at DATETIME NOT NULL,
    cinema_id INT NOT NULL,
    user_id INT,
    session_id INT NOT NULL,
    CONSTRAINT reservation_ibfk_1 FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id),
    CONSTRAINT reservation_ibfk_2 FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT reservation_ibfk_3 FOREIGN KEY (session_id) REFERENCES sessions(session_id)
    ) ENGINE=InnoDB;

CREATE TABLE payments (
    payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    payment_done_by VARCHAR(255) NOT NULL,
    reservation_id INT NOT NULL,
    user_id INT,
    CONSTRAINT payment_ibfk_1 FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    CONSTRAINT payment_ibfk_2 FOREIGN KEY (user_id) REFERENCES users(user_id)
    ) ENGINE=InnoDB;


-- Création des tables de jointures --

CREATE TABLE movies_theaters_movies (
    movies_theater_id INT NOT NULL,
    movie_id INT NOT NULL,
    PRIMARY KEY (movies_theater_id, movie_id),
    CONSTRAINT movies_theaters_movies_ibfk_1 FOREIGN KEY (movies_theater_id) REFERENCES movies_theaters(movies_theater_id),
    CONSTRAINT movies_theaters_movies_ibfk_2 FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
    ) ENGINE=InnoDB;

CREATE TABLE cinemas_movies_theaters (
    cinema_id INT NOT NULL,
    movies_theater_id INT NOT NULL,
    PRIMARY KEY (cinema_id, movies_theater_id),
    CONSTRAINT cinemas_movies_theaters_ibfk_1 FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id),
    CONSTRAINT cinemas_movies_theaters_ibfk_2 FOREIGN KEY (movies_theater_id) REFERENCES movies_theaters(movies_theater_id)
    ) ENGINE=InnoDB;

CREATE TABLE movies_cinemas (
    movie_id INT NOT NULL,
    cinema_id INT NOT NULL,
    PRIMARY KEY (movie_id, cinema_id),
    CONSTRAINT movies_cinemas_ibfk_1 FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    CONSTRAINT movies_cinemas_ibfk_2 FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id)
    ) ENGINE=InnoDB;

CREATE TABLE users_cinemas (
    user_id INT NOT NULL,
    cinema_id INT NOT NULL,
    PRIMARY KEY (user_id, cinema_id),
    CONSTRAINT users_cinemas_ibfk_1 FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT users_cinemas_ibfk_2 FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id)
    ) ENGINE=InnoDB;

CREATE TABLE users_sessions (
    user_id INT NOT NULL,
    session_id INT NOT NULL,
    PRIMARY KEY (user_id, session_id),
    CONSTRAINT users_sessions_ibfk_1 FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT users_sessions_ibfk_2 FOREIGN KEY (session_id) REFERENCES sessions(session_id)
    ) ENGINE=InnoDB;

CREATE TABLE users_prices (
    user_id INT NOT NULL,
    price_id INT NOT NULL,
    PRIMARY KEY (user_id, price_id),
    CONSTRAINT users_prices_ibfk_1 FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT users_prices_ibfk_2 FOREIGN KEY (price_id) REFERENCES prices(price_id)
    ) ENGINE=InnoDB;

CREATE TABLE cinemas_sessions (
    cinema_id INT NOT NULL,
    session_id INT NOT NULL,
    PRIMARY KEY (cinema_id, session_id),
    CONSTRAINT cinemas_sessions_ibfk_1 FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id),
    CONSTRAINT cinemas_sessions_ibfk_2 FOREIGN KEY (session_id) REFERENCES sessions(session_id)
    ) ENGINE=InnoDB;


-- Ajout des données dans les tables --

INSERT INTO users (user_id, name, firstname, email, password, role, phone_number, date_of_birth, created_at, updated_at)
    VALUES
    (1, 'Naupertu', 'Andréa', 'a.naupertu@gamil.com', '$2y$10$MT70au/VUyZUu8QJmIMbX.fiq5glMa/UPyRF5diFJC1X3ECF2jsaG','ADMIN', '0625987415', '1978/01/03', '2015/04/03', '2020/03/02'),
    (2, 'Carigeria', 'Caroline', 'c.caro@gmail.com', '$2y$10$.j.wxkdfuzdiJQFTK8.NRargPKCZfizjNGEFpob3UKQUe200Sp1rI', 'USER', '0635897485', '1985/02/16', '2021/05/07', '2021/05/07'),
    (3, 'Ingalls', 'Charles', 'c.ingalls@gmail.com', '$2y$10$v5KQLYzhbvht8d06LOLL050pdmS/D/DhbYUYsJ50s01hg3GSk8df9p', 'ADMIN', '0698523687', '1980/12/17', '2016/10/19', '2016/10/19'),
    (4, 'Potter', 'Harry', 'h.potter@gmail.com', '$2y$10$p5kJQKojjnvGF8s06LKIH085msjQ/S/hVGTRXdY80k03sd5YGZ2ce5e', 'ADMIN', '0785964125', '1998/04/03', '2022/10/12', '2022/10/12'),
    (5, 'Granger', 'Hermione', 'h.granger@gmail.com', '$2y$10^p6dfzsjHBGF8d05HUKL958lajQ/D/dHBGTYSj50l05de6HSd6df8f', 'USER', '0659871248', '1997/03/25', '2022/12/15', '2022/12/15'),
    (6, 'Weasley', 'Ron', 'r.weasley@gmail.com', '$2y$10$d5fkejHVFhK6D08KJDB090hdiD/D/fHSVFGdU53h08kd3GDj6df8f', 'USER', '0785369874', '1996/05/08', '2022/12/15', '2022/12/15'),
    (7, 'Halliwell', 'Piper', 'p.halliwell@gmail.com', '$2y$10$c8ehsjSHjVGj7d05JHGS080jdkQ/D/dHVGYUOsU80d01fe2HSk6da8y', 'ADMIN', '0785364125', '1979/10/07', '2015/09/15', '2015/09/15'),
    (8, 'Halliwell', 'Prue', 'p.hwell@gmail.com', '$2y$10$f5zJljdbHbchK506HDJD80kfjL/F/FhvgyYsJ60d08f8ffFr8fd8d', 'USER', '0614759825', '1983/07/03', '2016/08/09', '2016/08/09'),
    (9, 'Halliwell', 'Pheobe', 'ph.hwell@gmail.com', '$2y$10$v5FskfjhHjhD6f06FEG90fviS/F/FrjhyYYb50f06fr0HDf5gd9f', 'ADMIN', '0796253197', '1980/10/07', '2016/08/09', '2016/08/09'),
    (10, 'Halliwell', 'Paige', 'pa.hall@gmail.com', '$2r$10$g5HdhrjJvrJ5D065JI080kdlS/D/fbheyudVY85j05DJ75hd2fd5f', 'USER', '0732598715', '1985/12/10', '2019/05/10', '2019/05/10');

INSERT INTO prices (price_id, name_category, price)
    VALUES
    (1, 'Plein tarif', '9.20'),
    (2, 'Etudiant', '7.60'),
    (3, 'Moins de 14 ans', '5.90');

INSERT INTO genders (gender_id, name_gender)
    VALUES
    (1, 'Horreur'),
    (2, 'Comique'),
    (3, 'Dramatique'),
    (4, 'Romantique'),
    (5, 'Aventure'),
    (6, 'Policer'),
    (7, 'Fantastique');

INSERT INTO movies_theaters (movies_theater_id, number, total_of_places)
    VALUES
    (1, 1, 100),
    (2, 2, 150),
    (3, 3, 175),
    (4, 4, 300);

INSERT INTO movies (movie_id, title, description, duration, actors, directors, gender_id)
    VALUES
    (1, 'Avatar 2', 'Voici le récit palpitant des membres de la famille Sully et les épreuves auxquelles ils sont confrontés, les chemins qu\'ils doivent emprunter pour se protéger les uns les autres. Ce film se déroule après les évènements relatés dans Avatar 1.', 192, 'Sam Worthington, Zoe Saldana, Sigourney Weaver', 'James Cameron, Rick Jaffa', 5),
    (2, 'Murder Mistery', 'Lors d\'un voyage tant attendu en Europe, un policier New-Yorkais et sa femme se démènent pour résoudre un meurtre inexplicable survenu à bord d\'un yacht.', 97, 'Adam Sandler, Jennifer Aniston, Gemma Arterton, Luke Evans, Luis Gerardo Mendez, Adeel Akhtar', 'Kyle Newacheck', 2),
    (3, 'Titanic', 'Southampton, 10 avril 1912. Le paquebot le plus grand et le plus moderne du monde, réputé pour son insubmersibilité, le Titanic, appareille pour son premier voyage. Quatre jours plus tard, il heurte un iceberg. A son bord, un artiste pauvre et une grande bourgeoise tombent amoureux.', 194, 'Leonardo Di Caprio, Kate Winslet, Billy Zane', 'James Cameron', 3),
    (4, 'The Holiday', 'Une américaine et une Anglaise, toutes deux déçues des hommes, décident, sans se connaître, d\'échanger leurs maisons. L\'une arrive dans une demeure de rêve tandis que l\'autre découvre une petite maison de campagne sans prétentions. Les deux femmes pensent passer de paisibles vancances loins de la gent masculine, mais c\'était sans compter les frère de l\'une et le collaborateur de l\'autre.', 131, 'Cameron Diaz, Kate Winslet, Jude Law', 'Nancy Meyers', 4),
    (5, 'Jumanji', 'Le destin de quatre lycéens en retenue bascule lorsqu\'ils sont aspirés dans le monde de Jumanji. Après avoir découvert une vieille console contenant un jeu vidéo dont ils n\'avaient jamais entendu parler, les quatre jeunes se retouvent mystérieusement propulsés au coeur de la jungle de Jumanji. Pour revenir dans le monde réel, il va leur falloir affronter les pires dangers et triompger de l\'ultime aventure.', 179, 'Dwayne Johnson, Jack Black, Kevin Hart', 'Chris McKenna, Erik Sommers, Jake Kasdan', 7),
    (6, 'Glass Onion', 'C\'est dans un cadre idyllique que Benoit Blanc va résoudre de nouveaux mystères et surtout un nouveau meurtre. Il se retrouve coincé au sein d\'un groupe d\'amis hétéroclite, invité par un milliardaire dans sa propriété luxueuse nichée sur une île grecque.', 139, 'Daniel Craig, Edward Norton, Janelle Monae', 'Rian Johnson', 6),
    (7, 'Conjuring, les dossiers Warren', 'Avant Amityville, il y avait Harrisville... Conjuring: les dossiers Warren, raconte l\'histoire horrible mais vrai d\'Ed et Lorraine Warren, enquêteurs paranormaux réputés dans le monde entier, venus en aide à une famille terrorisée par une présence inquiétant dans leur ferme isolée.', 110, 'Vera Farmiga, Patrick Wilson, Ron Livingston', 'James Wan, Chad Hayes, Carey W. Hayes', 1),
    (8, 'Murder Mystery 2', 'Désormais soucieurs de faire décoller leur propre agence, les détectives Nick et Audrey Spitz se retrouvent au coeur d\'un enlèvement de niveau international, qui les touche de près.', 89, 'Adam Sandler, Jennifer Aniston, Mark Strong', 'Jeremy Garelick, James Vanderbilt', 2),
    (9, 'A couteaux tirés', 'Célèbre auteur de polars, Harlan Thrombey est retrouvé mort dans sa somptueuse propriété le soir de ses 85 ans. L\'esprit affûté et la mine débonnaire, le détectivre Benoit Blanc est alors engagé par un commanditaire annonyme afin d\'élucider l\'affaire.', 131, 'Daniel Craig, Chris Evans, Ana de Armas', 'Rian Johnson', 6),
    (10, 'Scream', 'Vingt-cinq ans après que la paisible ville de Woodsboro a été frappée par une série de meurtres violents, un nouveau tueur revêt le masque de Ghostface et prend pour cible un groupe d\'adolescents. Il est déterminé à faire ressugir les sombres secrets du passé.', 119, 'Neve Campbell, Courtney COx, David Arquette', 'James Vanderbilt, Guy Busick', 1);

INSERT INTO sessions (session_id, date, time, movie_id, movies_theater_id)
    VALUES
    (1, '2023/04/01', '21:30:00', 10, 4),
    (2, '2023/04/01', '21:00:00', 4, 1),
    (3, '2023/04/01', '20:30:00', 5, 2),
    (4, '2023/04/01', '20:00:00', 2, 3),
    (5, '2023/04/02', '21:30:00', 10, 4),
    (6, '2023/04/02', '21:00:00', 4, 1),
    (7, '2023/04/02', '20:30:00', 5, 2),
    (8, '2023/04/02', '20:00:00', 2, 3),
    (9, '2023/04/03', '21:30:00', 10, 4),
    (10, '2023/04/03', '21:00:00', 4, 1),
    (11, '2023/04/03', '20:30:00', 5, 2),
    (12, '2023/04/03', '20:00:00', 2, 3),
    (13, '2023/04/04', '21:30:00', 10, 4),
    (14, '2023/04/04', '21:00:00', 4, 1),
    (15, '2023/04/04', '20:30:00', 5, 2),
    (16, '2023/04/04', '20:00:00', 2, 3),
    (17, '2023/04/05', '21:30:00', 10, 4),
    (18, '2023/04/05', '21:00:00', 4, 1),
    (19, '2023/04/05', '20:30:00', 5, 2),
    (20, '2023/04/05', '20:00:00', 2, 3);

INSERT INTO cinemas (cinema_id, name, adress, email, phone_number, created_at, updated_at, user_id)
    VALUES
    (1, 'Gaumont', '100 rue de Paris, 75000 Paris', 'gaumont@gmail.com', '0125743689', '2010/10/11', '2020/04/15', 1),
    (2, 'Gaumont Provence', '100 rue de Provence, 83970 ProvenceVille', 'gaumontprovence@gmail.com', '0452378914', '2014/08/14', '2022/03/08', 3),
    (3, 'Gaumont Savoie', '100 rue de Savoie, 74000 Savoie', 'gaumontsavoie@gmail.com', '0575869547', '2013/05/07', '2021/07/15', 4),
    (4, 'Gaumont Pyrénnées', '100 rue des Pyrénnées, 07000 Pyrénnées', 'gaumontPyrennes@gmail.com', '0374812547', '2017/07/12', '2017/07/12', 7);

INSERT INTO reservations (reservation_id, reservation_date, number_of_people, name, firstname, phone_number, email, amount, created_at, cinema_id, user_id, session_id)
    VALUES
    (1, '2023/04/01', 3, 'Granger', 'Hermione', '0659871248', 'h.granger@gmail.com', '27.60', '2023/03/20',  3, 5, 1),
    (2, '2023/04/02', 4, 'Halliwell', 'Prue', '0614759825', 'p.hwell@gmail.com', '36.80', '2023/03/21',  1, 8, 2),
    (3, '2023/04/03', 2, 'Weasley', 'Ron', '0785369874', 'r.weasley@gmail.com', '18.40', '2023/03/22',  3, 6, 3),
    (4, '2023/04/04', 5, 'Harver', 'Albert', '0625784125', 'a.harver@gmail.com', '46.00', '2023/03/23',  2, NULL, 4),
    (5, '2023/04/05', 2, 'Kurlo', 'Josiane', '0752348745', 'j.jurlo@gmail.com', '18.40', '2023/03/24',  4, NULL, 5),
    (6, '2023/04/03', 4, 'Carigeria', 'Caroline', '0635897485', 'c.caro@gmail.com', '36.80', '2023/03/22',  1, 2, 6),
    (7, '2023/04/04', 3, 'Lupin', 'Remus', '0659871248', 'r.lupin@gmail.com', '27.60', '2023/03/23',  3, NULL, 7);

INSERT INTO payments (payment_id, payment_done_by, reservation_id, user_id)
    VALUES
    (1, 'Online', 1, 5),
    (2, 'Online', 2, 8),
    (3, 'Onplace', 3, 6),
    (4, 'Onplace', 4, NULL),
    (5, 'Onplace', 5, NULL),
    (6, 'Online', 6, 2),
    (7, 'Onplace', 7, NULL);

INSERT INTO movies_theaters_movies (movies_theater_id, movie_id)
    VALUES
    (1, 4),
    (1, 6),
    (2, 5),
    (2, 8),
    (3, 2),
    (4, 1),
    (4, 3),
    (4, 7),
    (4, 9),
    (4, 10);

INSERT INTO cinemas_movies_theaters (cinema_id, movies_theater_id)
    VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4),
    (4, 1),
    (4, 2),
    (4, 3),
    (4, 4);

INSERT INTO movies_cinemas (movie_id, cinema_id)
    VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (3, 1),
    (3, 2),
    (3, 3),
    (3, 4),
    (4, 1),
    (4, 2),
    (4, 3),
    (4, 4),
    (5, 1),
    (5, 2),
    (5, 3),
    (5, 4),
    (6, 1),
    (6, 2),
    (6, 3),
    (6, 4),
    (7, 1),
    (7, 2),
    (7, 3),
    (7, 4),
    (8, 1),
    (8, 2),
    (8, 3),
    (8, 4),
    (9, 1),
    (9, 2),
    (9, 3),
    (9, 4),
    (10, 1),
    (10, 2),
    (10, 3),
    (10, 4);

INSERT INTO users_cinemas (user_id, cinema_id)
    VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 3),
    (3, 4),
    (4, 2);

INSERT INTO users_prices (user_id, price_id)
    VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 2),
    (3, 3),
    (4, 1),
    (4, 2),
    (4, 3);

INSERT INTO cinemas_sessions (cinema_id, session_id)
    VALUES
    (1, 3),
    (1, 4),
    (1, 8),
    (1, 9),
    (1, 10),
    (2, 1),
    (2, 5),
    (2, 7),
    (2, 9),
    (2, 10),
    (3, 2),
    (3, 3),
    (3, 4),
    (3, 7),
    (3, 8),
    (4, 1),
    (4, 7),
    (4, 8),
    (4, 9),
    (4, 10);
