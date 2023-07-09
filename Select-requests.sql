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