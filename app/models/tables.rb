class Tables
  def self.create
    candidates = <<-SQL
    CREATE TABLE candidates (
    id integer primary key,
    name text);
    SQL

    artists = <<-SQL
    CREATE TABLE artists (
    id integer primary key,
    name text);
    SQL

    lyrics = <<-SQL
    CREATE TABLE lyrics (
    id integer primary key,
    line text,
    theme text,
    sentiment text);
    SQL

    songs = <<-SQL
    CREATE TABLE songs (
    id integer primary key,
    title text,
    release_date integer,
    artist_id integer,
    candidate_id integer);
    SQL

    songs_lyrics = <<-SQL
    CREATE TABLE songs_lyrics (
    id integer primary key,
    song_id integer,
    lyric_id integer);
    SQL

    tables = [candidates, artists, lyrics, songs, songs_lyrics]
    tables.each {|table| DB.execute(table)}
  end

  def self.drop
    artists = <<-SQL
    DROP TABLE IF EXISTS artists;
    SQL

    candidates = <<-SQL
    DROP TABLE IF EXISTS candidates;
    SQL

    lyrics = <<-SQL
    DROP TABLE IF EXISTS lyrics;
    SQL

    songs = <<-SQL
    DROP TABLE IF EXISTS songs;
    SQL

    songs_lyrics = <<-SQL
    DROP TABLE IF EXISTS songs_lyrics;
    SQL

    tables = [candidates, artists, lyrics, songs, songs_lyrics]
    tables.each {|table| DB.execute(table)}
  end
end
