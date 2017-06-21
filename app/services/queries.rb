class Query

  def self.most_common_theme
    # What’s the most common theme?
    most_common_theme = <<-SQL
    SELECT theme, COUNT(theme) FROM lyrics
    GROUP BY theme
    ORDER BY COUNT(theme) DESC LIMIT 1;
    SQL
    DB.execute(most_common_theme)
  end

  def self.most_positive_candidate
    # Which candidate are rap songs most positive toward?
    most_positive_candidate = <<-SQL
    SELECT candidates.name, COUNT(lyrics.sentiment)
    FROM candidates
    INNER JOIN songs ON songs.candidate_id = candidates.id
    INNER JOIN songs_lyrics ON songs.id = songs_lyrics.song_id
    INNER JOIN lyrics ON lyrics.id = songs_lyrics.lyric_id
    GROUP BY candidates.name
    HAVING lyrics.sentiment = 'positive'
    ORDER BY COUNT(lyrics.sentiment) DESC LIMIT 1
    SQL
    DB.execute(most_positive_candidate)
  end

  def self.most_negative_candidate
    # Which candidate are rap songs most positive toward?
    most_negative_candidate = <<-SQL
    SELECT candidates.name, COUNT(lyrics.sentiment)
    FROM candidates
    INNER JOIN songs ON songs.candidate_id = candidates.id
    INNER JOIN songs_lyrics ON songs.id = songs_lyrics.song_id
    INNER JOIN lyrics ON lyrics.id = songs_lyrics.lyric_id
    GROUP BY candidates.name
    HAVING lyrics.sentiment = 'negative'
    ORDER BY COUNT(lyrics.sentiment) DESC
    SQL
    DB.execute(most_negative_candidate)
  end


  def most_political_year
    # Which year was the most political?
    most_political_year = <<-SQL
    SELECT songs.release_date, COUNT(lyrics.theme)
    FROM songs
    INNER JOIN songs_lyrics ON songs_lyrics.song_id = songs.id
    INNER JOIN lyrics ON songs_lyrics.lyric_id = lyrics.id
    GROUP BY songs.release_date
    HAVING lyrics.theme = 'political'
    ORDER BY COUNT(lyrics.theme) DESC
    SQL
    DB.execute(most_political_year)
  end


    # Which is the most political rapper?


    # What’s the most common theme for each candidate?


    # How Manny Hillary lyrics mention bill


    # How many Hillary songs mention bill before 2015

end
