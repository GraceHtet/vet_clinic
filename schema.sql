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
