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

-- multi table
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name, species.name AS type FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name, species.name AS type, owners.full_name AS owner FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

WITH countani AS (SELECT owners.full_name AS owner_name, COUNT(animals.owner_id) AS count, MAX(COUNT(owner_id)) OVER() AS maxcount FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name) SELECT owner_name, count FROM countani WHERE count = maxcount;


-- join table
SELECT A.name, V.name, Vi.visit_date AS vdate FROM vets V JOIN visits Vi ON V.id = Vi.vets_id JOIN animals A ON Vi.animals_id = A.id WHERE V.name = 'William Tatcher' ORDER BY vdate DESC LIMIT 1;

SELECT V.name, COUNT(S.species_id) FROM vets V JOIN specializations S ON V.id = S.vets_id GROUP BY V.name HAVING V.name = 'Stephanie Mendez';

SELECT V.name, S.name FROM vets V FULL JOIN specializations SV ON V.id = SV.vets_id LEFT JOIN species S on SV.species_id = S.id GROUP BY V.name, S.name;

SELECT  V.name, A.name, Vi.visit_date FROM animals A JOIN visits Vi ON A.id = Vi.animals_id JOIN vets V ON V.id = Vi.vets_id WHERE V.name = 'Stephanie Mendez' AND  Vi.visit_date BETWEEN '2020-04-01' AND '2020-08-30'; 

WITH maxt AS (SELECT A.name AS ani_name, Count(Vi.animals_id) AS count, Max(Count(Vi.animals_id)) OVER() AS maxcount FROM animals A JOIN visits Vi ON A.id = Vi.animals_id GROUP  BY A.name) SELECT ani_name, count
FROM maxt WHERE  count = maxcount; 

SELECT A.name, V.name, Vi.visit_date FROM animals A JOIN visits Vi ON A.id = Vi.animals_id JOIN vets V ON V.id = Vi.vets_id WHERE  V.name = 'Maisy Smith ' ORDER  BY Vi.visit_date LIMIT  1; 

SELECT Vi.visit_date, A.name AS animal_name, A.date_of_birth, A.escape_attempts, A.neutered, A.weight_kg, species.name AS specie, V.name AS vet, V.age, V.date_of_graduation FROM species JOIN animals A ON species.id = A.species_id JOIN visits Vi ON A.id = Vi.animals_id JOIN vets V ON Vi.vets_id = V.id ORDER  BY Vi.visit_date DESC LIMIT  1; 

WITH view AS (SELECT S.name, V.name AS vet FROM vets V FULL JOIN visits Vi ON  V.id = Vi.vets_id FULL JOIN specializations SV ON SV.vets_id = V.id FULL JOIN species S ON S.id = SV.species_id WHERE S.name is NULL) SELECT vet, COUNT(vet) FROM view GROUP BY vet;


SELECT V.name AS vet ,S.name AS species,  COUNT(S.name) AS count FROM vets V FULL JOIN visits Vi ON  V.id = Vi.vets_id FULL JOIN animals A ON Vi.animals_id = A.id FULL JOIN species S ON S.id = A.species_id GROUP BY S.name,V.name HAVING V.name = 'Maisy Smith ' ORDER BY count DESC LIMIT 1;

-- indexes
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animalS_id = 4;

EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';