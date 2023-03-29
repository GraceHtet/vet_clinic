/*Queries that provide answers to the questions from all projects.*/

--create table
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts< 3;
SELECT date_of_birth FROM animals WHERE name= 'Agumon' OR name= 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- update table
BEGIN;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK;

BEGIN WORK;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;


BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK TRANSACTION;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * from animals;
SAVEPOINT delete22;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO delete22;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < -1;
COMMIT WORK;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts),neutered FROM animals GROUP BY neutered;
SELECT species,MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species,date_of_birth,AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species,date_of_birth ;

--multi tables
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name, species.name AS type FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name, species.name AS type, owners.full_name AS owner FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

WITH countani AS (SELECT owners.full_name AS owner_name, COUNT(animals.owner_id) AS count, MAX(COUNT(owner_id)) OVER() AS maxcount FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name) SELECT owner_name, count FROM countani WHERE count = maxcount;