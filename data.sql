/* Populate database with sample data. */

-- create table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon',DATE '2020-03-02', 0, true,  10.23),
('Gabumon',DATE '2018-11-15', 2, true,  8),
('Pikachu',DATE '2021-01-07', 1, false,  15.04),
('Devimon',DATE '2017-05-12', 5, true,  11);

-- update table
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander',DATE '2020-02-08', 0, false,  11),
('Plantmon',DATE '2021-11-15', 2, true,  5.7),
('Squirtle',DATE '1993-04-02', 3, false,  12.13),
('Angemon',DATE '2005-06-12', 1, true,  45),
('Boarmon',DATE '2005-06-07', 7, true,  20.4),
('Blossom',DATE '1998-10-13', 3, true,  17),
('Ditto',DATE '2022-05-14', 4, true,  22);

--multi tables
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES ('Pokemon'),
('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' or name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon ' OR name = 'Boarmon';

--join table
INSERT INTO vets(name, age, date_of_graduation)
VALUES ('William Tatcher', 45,DATE '2000-04-23'),
('Maisy Smith ', 26 ,DATE '2019-01-17'),
('Stephanie Mendez', 64,DATE '1981-05-04'),
('Jack Harkness ', 38 ,DATE '2008-06-08');