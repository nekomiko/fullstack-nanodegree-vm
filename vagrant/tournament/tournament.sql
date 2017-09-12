-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE TABLE IF NOT EXISTS players (
	id serial primary key,
	name varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS matches (
	id serial primary key,
	player1 serial references players(id),
	player2 serial references players(id)
);

CREATE VIEW matches_part (id, name, matches) AS (
	SELECT players.id, players.name, COUNT(matches.id)
	from players left join matches 
	on (players.id = matches.player1 or players.id = matches.player2) GROUP BY players.id
);

CREATE VIEW matches_win (id, name, wins) AS (
	SELECT players.id, players.name, COUNT(matches.id)
	from players left join matches on (players.id = matches.player1) GROUP BY players.id
);

CREATE VIEW matches_stat (id, name, wins, matches) AS (
	SELECT m1.id, m1.name, m2.wins, m1.matches
	from matches_part as m1, matches_win as m2 where m1.id = m2.id
);

