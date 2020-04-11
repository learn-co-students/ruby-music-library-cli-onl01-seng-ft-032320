require 'pry'
class Song
  
  extend Concerns::Findable                                                         #uses module
  
  attr_accessor :name, :artist, :genre                                              #sets/gets variable
 
  @@all = []                                                                        #stores all instances
  
  def initialize(name, artist = nil, genre = nil)                                   #runs on object instantiation, sets default value for two args
    @name = name                                                                    #sets name variable
    self.artist = artist if artist                                                  #sets artist variable if given in arg
    self.genre = genre if genre                                                     #sets genre variable if given in arg
  end
  
  def self.all
    @@all                                                                           #implicit return
  end 
  
  def save 
    self.class.all << self                                                          #shovel instance to @@all[]
  end
  
  def self.destroy_all 
    @@all.clear                                                                     #deletes all instances from @@all[]
  end 
  
  def self.create(song)
    song = Song.new(song)                                                           #creates new instance
    song.save                                                                       #invokes save method with shovels instance to @@all[]
    song                                                                            #implicit return
  end
  
  def artist=(artist)                                                               #custom setter method
    @artist = artist                                                                #sets variable 
    artist.add_song(self)                                                           #invokes add_song method from Artist class? 
  end
  
  def genre=(genre)                                                                 #custom setter method 
    @genre = genre                                                                  #sets variable 
    genre.add_song(self)                                                            #invokes add_song method from Genre class?
  end
  
  def self.new_from_filename(filename)
    filename.delete_suffix!(".mp3")
    split_filename = filename.split(" - ") 
    artist_name = split_filename[0]
    song_name = split_filename[1]
    genre_name = split_filename[2]
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    new_song = Song.new_from_filename(filename)
    new_song.save
    new_song
  end
end