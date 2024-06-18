-- Creation of a test base...

CREATE DATABASE observatory;

CREATE TABLE sectors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  coordinates VARCHAR(20) NOT NULL,
  light_intensity INT NOT NULL,
  obstacles VARCHAR(255),
  objects_count INT NOT NULL,
  unidentified_objects INT NOT NULL,
  identified_objects INT NOT NULL,
  notes VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE objects (
  id INT PRIMARY KEY AUTO_INCREMENT,
  object_type VARCHAR(50),
  accuracy DEC(7,6) NOT NULL,
  quantity INT NOT NULL,
  observation_time TIME NOT NULL,
  observation_date DATE NOT NULL,
  notes VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE natural_objects (
  id INT PRIMARY KEY AUTO_INCREMENT,
  object_type VARCHAR(50),
  galaxy VARCHAR(50),
  accuracy DEC(7,6) NOT NULL,
  luminous INT NOT NULL,
  conjugated_objects VARCHAR(255),
  notes VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE positions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  earth_position VARCHAR(50),
  sun_position VARCHAR(50),
  moon_position VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

CREATE TABLE space_entities (
  id INT PRIMARY KEY AUTO_INCREMENT,
  sector_id INT,
  object_id INT,
  natural_object_id INT,
  position_id INT,
  FOREIGN KEY (sector_id) REFERENCES sectors(id),
  FOREIGN KEY (object_id) REFERENCES objects(id),
  FOREIGN KEY (natural_object_id) REFERENCES natural_objects(id),
  FOREIGN KEY (position_id) REFERENCES positions(id)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

INSERT INTO sectors (coordinates, light_intensity, obstacles, objects_count, unidentified_objects, identified_objects, notes) VALUES
('422`123', 500000, 2, 4, 1, 3, null);

INSERT INTO positions (earth_position, sun_position, moon_position) VALUES ("546`434", "324`121", "342`645");

INSERT INTO space_entities (sector_id, object_id, natural_object_id, position_id) VALUES(1, null, null, 1);

DELIMITER //

CREATE PROCEDURE procedure1 (table1 VARCHAR(255), table2 VARCHAR(255))
BEGIN
    IF table1 = "sectors" THEN
        IF table2 = "objects" THEN
            SELECT s.*, o.* FROM sectors s
            INNER JOIN space_entities c ON s.id = c.sector_id
            INNER JOIN objects o ON c.object_id = o.id;
        END IF;
        IF table2 = "positions" THEN
            SELECT s.*, p.* FROM sectors s
            INNER JOIN space_entities c ON s.id = c.sector_id
            INNER JOIN positions p ON c.position_id = p.id;
        END IF;
        IF table2 = "natural_objects" THEN
            SELECT s.*, n.* FROM sectors s
            INNER JOIN space_entities c ON s.id = c.sector_id
            INNER JOIN natural_objects n ON c.natural_object_id = n.id;
        END IF;
    END IF;

    IF table1 = "objects" THEN
      IF table2 = "sectors" THEN
          SELECT o.*, s.* FROM objects o
          INNER JOIN space_entities ON o.id = c.object_id
          INNER JOIN sectors s ON c.sector_id = s.id;
      END IF;
      IF table2 = "positions" THEN
          SELECT o.*, p.* FROM objects o
          INNER JOIN space_entities c ON o.id = c.object_id
          INNER JOIN positions p ON c.position_id = p.id;
      END IF;
      IF table2 = "natural_objects" THEN
          SELECT o.*, n.* FROM objects o
          INNER JOIN space_entities c ON o.id = c.object_id
          INNER JOIN natural_objects n ON c.natural_object_id = n.id;
      END IF;
    END IF;

    IF table1 = "positions" THEN
      IF table2 = "Sectors" THEN
          SELECT p.*, s.* FROM positions p
          INNER JOIN space_entities c ON p.id = c.position_id
          INNER JOIN sectors s ON c.sector_id = s.id;
      END IF;
      IF table2 = "objects" THEN
          SELECT p.*, o.* FROM positions p
          INNER JOIN space_entities c ON p.id = c.position_id
          INNER JOIN objects o ON c.object_id = o.id;
      END IF;
      IF table2 = "natural_objects" THEN
          SELECT p.*, n.* FROM positions p
          INNER JOIN space_entities c ON p.id = c.position_id
          INNER JOIN natural_objects n ON c.natural_object_id = n.id;
      END IF;
    END IF;

    IF table1 = "natural_objects" THEN
      IF table2 = "sectors" THEN
          SELECT n.*, s.* FROM natural_objects n
          INNER JOIN space_entities c ON n.id = c.natural_object_id
          INNER JOIN sectors s ON c.sector_id = s.id;
      END IF;
      IF table2 = "objects" THEN
          SELECT n.*, o.* FROM natural_objects n
          INNER JOIN space_entities c ON n.id = c.natural_object_id
          INNER JOIN objects o ON c.object_id = o.id;
      END IF;
      IF table2 = "positions" THEN
          SELECT n.*, p.* FROM natural_objects n
          INNER JOIN space_entities c ON n.id = c.natural_object_id
          INNER JOIN positions p ON c.position_id = p.id;
      END IF;
    END IF;
END //
DELIMITER ;