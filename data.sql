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