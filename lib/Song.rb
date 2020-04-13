class Song
  attr_accessor :name, :genre
  attr_reader :artist
  extend Concerns::Findable
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @genre = genre
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if !@genre.songs.include?(self)
      @genre.songs << self
    end
  end
  
  def self.find_or_create_by_name(name)
    found = self.find_by_name(name)
    if found
      found
    else
      self.create(name)
    end
  end
  
  def self.new_from_filename(filename)
    artist, name, genre = filename.gsub(".mp3", "").split(" - ")
    song = self.new(name)
    song.artist = Artist.find_or_create_by_name(artist)
    song.genre = Genre.find_or_create_by_name(genre)
    song
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    @@all << song
  end
end