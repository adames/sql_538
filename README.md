CREATE TABLE candidates (
id integer primary key,
name text);
CREATE TABLE artists (
id integer primary key,
name text);
CREATE TABLE lyrics (
id integer primary key,
line text,
theme text,
sentiment text);
CREATE TABLE songs (
id integer primary key,
title text,
release_date integer,
artist_id integer,
candidate_id integer);
CREATE TABLE songs_lyrics (
id integer primary key,
song_id integer,
lyric_id integer);
