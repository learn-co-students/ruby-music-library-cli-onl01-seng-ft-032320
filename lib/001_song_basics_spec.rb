class Song
  attr_accessor :name, :artist, :genre
  extend Concerns::Findable

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist
      self.artist = artist
      artist.songs << self
    end
    if genre
      self.genre = genre
      genre.songs << self
    end
  end

  def self.all
    @@all
  end

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def artist=(artist_object)
    if @artist == nil
      @artist = artist_object
    else
      @artist = @artist
    end

    if self.artist != nil
      @artist.add_song(self)
    end

    @artist
  end

  def genre=(genre_object)
    if @genre == nil
      @genre = genre_object
    else
      @genre = @genre
    end

    if self.genre != nil
      @genre.add_song(self)
    end

    @genre
  end

  def self.find_by_name(song_name)
    @@all.find do |song|
      song.name == song_name
    end
  end

  def self.find_or_create_by_name(song_name)
    if self.find_by_name(song_name)
      self.find_by_name(song_name)
    else
      song = self.create(song_name)
    end
  end

  def self.new_from_filename(file_name)
    file_array = []
    file_array << file_name.split(" - ")[0]
    file_array << file_name.split(" - ")[1]
    file_array << file_name.split(" - ")[2].chomp(".mp3")
      file_array
      song_artist = Artist.find_or_create_by_name(file_array[0])
      song_genre = Genre.find_or_create_by_name(file_array[2])
      song = self.new(file_array[1], song_artist, song_genre)
  end

  def self.create_from_filename(file_name)
    @@all << self.new_from_filename(file_name)
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

end
