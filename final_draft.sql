DROP DATABASE IF EXISTS Marriage;
CREATE DATABASE IF NOT EXISTS Marriage;
USE Marriage;


-- person may have no middle names
CREATE TABLE Names (
    person_id VARCHAR(20) NOT NULL,
    forename VARCHAR(30) NOT NULL,
    middle_name_1 VARCHAR(30),
    middle_name_2 VARCHAR(30),
    surname VARCHAR(30) NOT NULL,
    title VARCHAR(20) NOT NULL,
    PRIMARY KEY (person_id)
);

CREATE TABLE Countries(
    country_id TINYINT(1) NOT NULL,
    country_name VARCHAR(58) NOT NULL,
    PRIMARY KEY (country_id)
);

CREATE TABLE Locations(
    location_id INTEGER NOT NULL,
    country_id TINYINT(1) NOT NULL, 
    state_province VARCHAR(30) NOT NULL,
    city_town VARCHAR(30) NOT NULL,
    PRIMARY KEY (location_id),
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

CREATE TABLE Parents (
    person_id VARCHAR(20) NOT NULL, 
    parent_1_id VARCHAR(20), 
    parent_2_id VARCHAR(20),
    PRIMARY KEY (person_id)
);

-- NULL default for DOD of course
CREATE TABLE People (
    person_id VARCHAR(20) NOT NULL, 
    nationality TINYINT(1) NOT NULL, 
    sex VARCHAR(3) NOT NULL, 
    DOB DATE NOT NULL, 
    place_of_birth INTEGER NOT NULL, 
    DOD DATE DEFAULT NULL, 
    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES Names(person_id),
    FOREIGN KEY (place_of_birth) REFERENCES Locations(location_id)
);

ALTER TABLE Parents ADD FOREIGN KEY (Parent_1_id) REFERENCES People(person_id);
ALTER TABLE Parents ADD FOREIGN KEY (Parent_1_id) REFERENCES People(person_id);

CREATE TABLE Registries (
    registry_id VARCHAR(10) NOT NULL, 
    name VARCHAR(60) NOT NULL, 
    location INTEGER NOT NULL,
    PRIMARY KEY (registry_id),
    FOREIGN KEY (location) REFERENCES Locations(location_id)
);

CREATE TABLE Marriages (
    certificate_no VARCHAR(20) NOT NULL, 
    registration_date DATE NOT NULL, 
    registration_place VARCHAR(10) NOT NULL,
    PRIMARY KEY (certificate_no),
    FOREIGN KEY (registration_place) REFERENCES Registries(registry_id)
);

CREATE TABLE Married_People (
    person_id VARCHAR(20) NOT NULL, 
    certificate_no VARCHAR(20) NOT NULL, 
    PRIMARY KEY (person_id, certificate_no),
    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (certificate_no) REFERENCES Marriages(certificate_no)
);

CREATE TABLE Witnesses (
    person_id VARCHAR(20) NOT NULL, 
    certificate_no VARCHAR(20) NOT NULL, 
    PRIMARY KEY (person_id, certificate_no),
    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (certificate_no) REFERENCES Marriages(certificate_no)
);

CREATE TABLE Courts (
    court_id VARCHAR(8) NOT NULL, 
    name VARCHAR(40) NOT NULL, 
    location INTEGER NOT NULL,
    PRIMARY KEY (court_id),
    FOREIGN KEY (location) REFERENCES Locations(location_id)
);

CREATE TABLE Divorces (
    decree_no VARCHAR(20) NOT NULL, 
    divorce_date DATE NOT NULL,  
    divorce_place VARCHAR(8) NOT NULL,
    PRIMARY KEY (decree_no),
    FOREIGN KEY (divorce_place) REFERENCES Courts(court_id)
);



INSERT INTO Countries
    VALUES  (1, 'Ireland'),
            (2, 'The United Kingdom of Great Britain and Northern Ireland'),
            (3, 'France'),
            (4, 'Spain');

INSERT INTO Names
    VALUES  ('AAAAA11111', 'John', 'Richard', NULL, 'Mikleson', 'Mr'),
            ('BBBBB11111', 'Michele', 'Tina', 'Georgia', 'Roberts', 'Mrs'),
            ('CCCCC11111', 'Sarah', NULL, NULL, 'Collins', 'Ms'),
            ('DDDDD11111', 'Joseph', 'Jesus', NULL, 'Gough', 'Dr'),
            ('EEEEE11111', 'George', 'James', 'Jack', 'Mikleson', 'Mr'),
            ('FFFFF11111', 'Roberta', 'Consuela', NULL, 'Mikleson', 'Mrs'),
            ('GGGGG11111', 'Harry', 'Karl', NULL, 'Roberts', 'Mr'),
            ('HHHHH11111', 'Deborah', 'Laura', NULL, 'Roberts', 'Mrs');

INSERT INTO Locations
    VALUES  (174910, 1, 'Dublin', 'Swords'),
            (9832164, 1, 'Cork', 'Cork'),
            (348219, 2, 'South Yorkshire', 'Sheffield'),
            (9567432, 4, 'Andalusia', 'Granada'),
            (7194132, 3, 'Ile de France', 'Paris');

INSERT INTO People
    VALUES  ('AAAAA11111', 1, 'M', '1989-12-01', 174910, NULL),
            ('BBBBB11111', 1, 'F', '1987-01-31', 9832164, NULL),
            ('CCCCC11111', 2, 'F', '1973-04-23', 348219, NULL),
            ('DDDDD11111', 3, 'M', '1978-08-14', 7194132, NULL),
            ('EEEEE11111', 1, 'M', '1956-11-21', 174910, NULL),
            ('FFFFF11111', 4, 'F', '1960-03-09', 9832164, NULL),
            ('GGGGG11111', 2, 'M', '1949-03-12', 348219, '2012-09-01'),
            ('HHHHH11111', 2, 'F', '1959-01-09', 7194132, NULL);

INSERT INTO Parents
    VALUES  ('AAAAA11111', 'EEEEE11111', 'FFFFF11111'),
            ('BBBBB11111', 'GGGGG11111', 'HHHHH11111');



