CREATE TABLE IF NOT EXISTS person (
    firstName VARCHAR ( 50 ) NOT NULL,
	lastName VARCHAR ( 50 ) NOT NULL,
	age int NOT NULL
);

INSERT INTO person VALUES 
	('Bart', 'Simpson', 10),
	('Homer', 'Simpson', 39),
	('Lisa', 'Simpson', 8),
	('Ned', 'Flanders', 60),
	('Milhouse', 'Van Houten', 10),
	('Kirk', 'Simpson', 45),
	('Luann', 'Van Houten', 44),
	('Ralph', 'Wiggum', 8),
	('Clancy', 'Wiggum', 43),
	('Sarah', 'Wiggum', 43);