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

