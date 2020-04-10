class Song 
  attr_accessor :name, :artist, :genre, :path
  extend Concerns::Findable
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    @artist = artist
    @genre = genre
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
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
    song = Song.new(name) 
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.add_song(self)
  end 
  
  def self.find_by_name(name) 
    @@all.detect do |song|
      song.name == name
    end
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end 
  
  def self.new_from_filename(path)
    # binding.pry
    new_song = path.split(" - ")
    artist_new = new_song[0]
    song_new = new_song[1]
    genre_name = new_song[2].split(".mp3").join
    
    artist = Artist.find_or_create_by_name(artist_new)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_new, artist, genre)
  end 
  
  def self.create_from_filename(name)
    self.new_from_filename(name).save
  end
  
  
end