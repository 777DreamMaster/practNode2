-- Creation of a test base...

CREATE DATABASE bank;

CREATE TABLE individuals (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  middle_name VARCHAR(30),
  passport VARCHAR(10) UNIQUE NOT NULL,
  taxpayer_id VARCHAR(12) UNIQUE NOT NULL,
  insurance_id VARCHAR(11) UNIQUE NOT NULL,
  driver_licence VARCHAR(10) UNIQUE,
  additional_docs VARCHAR(255),
  notes VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

INSERT INTO individuals (first_name, last_name, middle_name, passport, taxpayer_id, insurance_id, driver_licence, additional_docs, notes) VALUES
('Ivan', 'Ivanov', 'Ivanovich', '1234567890', '432534151123', '2352443346', null, null, null),
('Alexei', 'Chumakov', 'Olegovich', '1512551252', '124525325123', '7567567624', null, null, null),
('Stepan', 'Jukov', 'Petrovich', '5464126454', '465645636246', '5345343632', null, null, null),
('Sergey', 'Ostapov', 'Andreevich', '1234234423', '243346354345', '3453467456', null, null, null),
('Gleb', 'Mamin', 'Alexandrovich', '1245547413', '645685456876', '7547454645', null, null, null);

CREATE TABLE borrowers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  taxpayer_id VARCHAR(12) UNIQUE NOT NULL,
  legal_entity BIT NOT NULL,
  address VARCHAR(255) NOT NULL,
  amount DEC(15, 2) NOT NULL,
  conditions VARCHAR(255) NOT NULL,
  legal_notes VARCHAR(255),
  contracts_list VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE funds (
  id INT PRIMARY KEY AUTO_INCREMENT,
  individual_id INT NOT NULL,
  amount DEC(15, 2) NOT NULL,
  interest DEC(5,2) NOT NULL,
  term TIMESTAMP NOT NULL,
  conditions VARCHAR(255) NOT NULL,
  notes VARCHAR(255),
  borrower_id INT NOT NULL,
  FOREIGN KEY (individual_id) REFERENCES individuals(id),
  FOREIGN KEY (borrower_id) REFERENCES borrowers(id)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE loans (
  id INT PRIMARY KEY AUTO_INCREMENT,
  company_id INT NOT NULL,
  individual_id INT NOT NULL,
  amount DEC(15, 2) NOT NULL,
  interest DEC(5,2) NOT NULL,
  term TIMESTAMP NOT NULL,
  conditions VARCHAR(255) NOT NULL,
  notes VARCHAR(255),
  FOREIGN KEY (individual_id) REFERENCES individuals(id)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;