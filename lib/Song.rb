class Song

 attr_accessor :name

  @@all = [] #this is a collection of all of the songs

  def initialize(name,artist=nil,genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new(name).tap do|song|
      song.save
    end
  end

  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end

  def artist
    @artist
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)

  end

  def genre
    @genre
  end

  def self.find_by_name(name)
    @@all.find do |song|
        song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.create_from_filename(name)
    @@all << self.new_from_filename(name)

  end

  def self.new_from_filename(name)
    #parse the filename
    song_name = name.split(" - ")[1]
    artist_name = name.split(" - ")[0]
    genre_name = name.split(" - ")[2].chomp(".mp3")
    artist = Artist.find_or_create_by_name(artist_name)
    #song.genre = Genre.create(genre_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new(song_name, artist, genre)

  end


end
