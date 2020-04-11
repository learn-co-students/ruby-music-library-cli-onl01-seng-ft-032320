class Genre
  
  extend Concerns::Findable                                                 #uses module
  
  attr_accessor :name, :song, :artist                                       #set/gets variable

  @@all = []                                                                #stores all instances
  
  def initialize(name)                                                      #runs on object instantiation
    @name = name                                                            #sets name variable
    @songs = []                                                             #genre has many songs
  end
  
  def self.all
    @@all                                                                   #implicit return
  end 
  
  def save 
    self.class.all << self                                                  #adds instance to @@all[]
  end
  
  def self.destroy_all 
    @@all.clear                                                             #deletes all instances from @@all[]
  end 
  
  def add_song(song)
    song.genre = self if song.genre == nil                                  #sets genre to song if it does not already have one
      @songs << song unless @songs.include?(song)                           #shovels song into [] if it's not already there 
  end
  
   def self.create(genre)
    genre = Genre.new(genre)                                                #creates new object instance 
    genre.save                                                              #invokes save method which shovels instance to @@all[]
    genre                                                                   #implicit return
  end
  
  def songs
    @songs                                                                  #implicit return
  end
  
  def artists
    artist_collection = songs.collect {|song| song.artist}                  #invokes songs method, iterates over @songs and collects all artists
    artist_collection.uniq                                                  #returns new arr without duplicates
  end
end