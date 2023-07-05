
INSERT INTO Artists(name)
	VALUES('Prodigy'), ('Armin van Buuren'), ('Баста'), ('Rammstein'), 
	('Ludacris'), ('Miyagi'), ('Duwayne Motley'), ('Tiesto');


INSERT INTO Jenres(name)
	VALUES('Rock'), ('Techno'), ('Rap'), ('Hip-Hop'), ('Chillhouse');


INSERT INTO Albums(name, year)
	VALUES('No Tourists', 2018), ('Radio', 2022), ('Баста 4', 2015), ('Back For The First Time', 2017), 
('Balance', 2019), ('The London sessions', 2020), ('Keep Talking', 2021), ('Hattori', 2022), ('Album_mix', 2017);


INSERT INTO Tracks(name, duration, album_id)
	VALUES('Need Some', 144, 1), ('We live forever', 177, 1), ('Deutschland', 323, 2), ('Zeig Dich', 211, 2),
	('Райские Яблоки', 240, 3), ('Одна любовь', 323, 3), ('Game Got Switched', 249, 4), ('What is Your Fantasy', 275, 4),
	('Something Real', 299, 5), ('Blah Blah Blah', 183, 5), ('God Is A Dancer', 188, 6), ('Nothing Really Matters', 216, 6),
	('Keep Talking', 174, 7), ('My love', 253, 7), ('Ночь', 277, 8), ('Need Me', 277, 8), ('Track Mix', 333, 9);



INSERT INTO collections(name, year)
	VALUES('Collection_1', 2019), ('Collection_2', 2014), ('Collection_3', 2020), ('Collection_4', 2019), ('Collection_5', 2015),
	('Collection_6', 2022), ('Collection_7', 2009), ('Collection_8', 2017)
	

INSERT INTO jenreartist
	VALUES(1, 1), (2, 2), (3, 3), (4, 1), 
	(5, 4), (6, 3), (7, 5), (8, 2);

INSERT INTO albumartist
	VALUES(1, 1), (2, 5), (3, 3), (4, 2), (5, 4), (6, 8), (7, 7), (8, 6), (1, 9), (2, 9);


INSERT INTO collectiontrack
	VALUES(1, 1), (1, 2), (2, 3), (2, 4), 
	(3, 5), (3, 6), (4, 7), (4, 8), 
	(5, 9), (5, 10), (6, 11), (6, 12), 
	(7, 13), (7, 14), (8, 15), (8, 16);


