/* Database schema to keep the structure of entire database. */

--create table
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- update table
ALTER TABLE animals ADD COLUMN species VARCHAR(50);


-- multi table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id); 
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owner(id);

--join table
CREATE TABLE vets(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    date_of_graduation INT
);
SELECT * FROM vets;

CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vets_id INT REFERENCES vets(id),
    PRIMARY KEY (species_id, vets_id)
);

CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    visit_date DATE NOT NULL,
    PRIMARY KEY (animals_id, vets_id)
);