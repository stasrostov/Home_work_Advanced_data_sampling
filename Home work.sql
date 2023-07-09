CREATE TABLE IF NOT EXISTS Jenres (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Artists (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Albums (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL,
	YEAR SMALLINT NOT NULL CHECK(YEAR > 2000)
);

CREATE TABLE IF NOT EXISTS Tracks (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL,
	duration INTEGER NOT NULL CHECK(duration > 60),
	album_id INTEGER NOT NULL REFERENCES Albums(id)
);


CREATE TABLE IF NOT EXISTS Collections (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL,
	YEAR SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS JenreArtist (
	PRIMARY KEY(artist_id, jenre_id),
	artist_id INTEGER NOT NULL REFERENCES Artists(id),
	jenre_id INTEGER NOT NULL REFERENCES Jenres(id)
);

CREATE TABLE IF NOT EXISTS AlbumArtist (
	PRIMARY KEY(artist_id, album_id),
	artist_id INTEGER NOT NULL REFERENCES Artists(id),
	album_id INTEGER NOT NULL REFERENCES Albums(id)
);

CREATE TABLE IF NOT EXISTS CollectionTrack (
	PRIMARY KEY(collection_id, track_id),
	collection_id INTEGER NOT NULL REFERENCES Collections(id),
	track_id INTEGER NOT NULL REFERENCES Tracks(id)
);


INSERT INTO Artists(name)
	VALUES('Prodigy'), ('Armin van Buuren'), ('Баста'), ('Rammstein'), 
	('Ludacris'), ('Miyagi'), ('Duwayne Motley'), ('Tiesto');


INSERT INTO Jenres(name)
	VALUES('Rock'), ('Techno'), ('Rap'), ('Hip-Hop'), ('Chillhouse'), ('Metal');


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
	(5, 4), (6, 3), (7, 5), (8, 2), (1, 6);

INSERT INTO albumartist
	VALUES(1, 1), (2, 5), (3, 3), (4, 2), (5, 4), (6, 8), (7, 7), (8, 6), (1, 9), (2, 9);


INSERT INTO collectiontrack
	VALUES(1, 1), (1, 2), (2, 3), (2, 4), 
	(3, 5), (3, 6), (4, 7), (4, 8), 
	(5, 9), (5, 10), (6, 11), (6, 12), 
	(7, 13), (7, 14), (8, 15), (8, 16);





-- Количество исполнителей в каждом жанре.
SELECT name, COUNT(*) FROM jenreartist ja
JOIN jenres j ON ja.jenre_id = j.id
GROUP BY name
ORDER BY COUNT(*) DESC; 

-- Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(*) FROM tracks t 
JOIN albums a  ON t.album_id = a.id
WHERE a."year" BETWEEN 2019 AND 2020;

-- Средняя продолжительность треков по каждому альбому.
SELECT a.name, AVG(t.duration) FROM tracks t
JOIN albums a ON t.album_id = a.id 
GROUP BY a.name;

-- Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT a.name FROM artists a
WHERE a.name NOT IN (
    SELECT a.name
    FROM artists a
    JOIN albumartist aa ON a.id = aa.artist_id
    JOIN albums al ON aa.album_id = al.id
    WHERE al.year = 2020
);

-- Названия сборников, в которых присутствует конкретный исполнитель (Prodigy).
SELECT c.name FROM collections c
JOIN collectiontrack ct ON c.id = ct.collection_id 
JOIN tracks t ON ct.track_id = t.id 
JOIN albums al ON t.album_id = al.id 
JOIN albumartist aa ON al.id = aa.album_id 
JOIN artists a ON aa.artist_id = a.id 
WHERE a.name = 'Prodigy';

-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT a.name FROM albums a 
JOIN albumartist aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
JOIN jenreartist j ON ar.id = j.artist_id
GROUP BY ar.id, a.name
HAVING COUNT(DISTINCT j.jenre_id) > 1;

-- Наименования треков, которые не входят в сборники.
SELECT t.name FROM tracks t
LEFT JOIN collectiontrack ct ON t.id = ct.track_id 
WHERE ct.collection_id IS NULL;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек.
SELECT ar.name FROM artists ar
JOIN albumartist aa ON ar.id = aa.artist_id 
JOIN albums a ON aa.album_id = a.id 
JOIN tracks t ON a.id = t.album_id 
WHERE t.duration = (SELECT MIN(duration) FROM tracks);

--Названия альбомов, содержащих наименьшее количество треков.
SELECT a.name FROM albums a
JOIN tracks t ON a.id = t.album_id
GROUP BY a.id, a.name
HAVING COUNT(t.id) = (
    SELECT COUNT(t2.id) FROM albums a2
    JOIN tracks t2 ON a2.id = t2.album_id
    GROUP BY a2.id
    ORDER BY COUNT(t2.id)
    LIMIT 1
);




















