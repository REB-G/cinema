
-- Exemples d'utilisation de la base de données --

-- Exemple pour retrouver toutes les réservations pour une séance --
SELECT * FROM reservations WHERE session_id = 1;


-- Exemple pour retrouver tous les admins --
SELECT * FROM users WHERE role = 'ADMIN';


-- Exemple pour trouver un utilisateur par son nom --
SELECT * FROM users WHERE name = 'ingalls';


-- Exemple pour trouver un film par son titre --
SELECT * FROM movies WHERE title = 'A couteaux tirés';


--Exemple pour trouver les films d'un réalisateur --
SELECT * FROM movies WHERE directors = 'James Cameron';


-- Exemple pour trouver toutes sessions dans un cinéma particulier --
SELECT * FROM cinemas_sessions WHERE cinema_id = 1;
