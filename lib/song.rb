require 'pry'

class Song
   extend Concerns::Findable
  @@all = []
  
  attr_accessor :name, :artist, :genre
  
  def initialize(name, artist = nil, genre = nil)
    @name=name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  
  def self.all
    @@all
  end
  
  def save
   self.class.all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(song)
    song = self.new(song)
    song.save
    song
  end
  
  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre=genre
    genre.add_song(self)
  end
  
   def self.new_from_filename(data)
    data.delete_suffix!(".mp3")
    new_array = data.split(" - ")
    artist_name = new_array[0]
    song_name = new_array[1]
    genre_name = new_array[2]
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(data)
    song = self.new_from_filename(data)
    song.save
    song
  end
  
end