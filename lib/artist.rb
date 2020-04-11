class Artist 
  
  extend Concerns::Findable                                         #uses module 
  
  attr_accessor :name, :song, :genre                                #sets/gets variable
  
   @@all = []                                                       #stores all instances 
   
  def initialize(name)                                              #runs on object instantiation
    @name = name                                                    #sets name variable
    @songs = []                                                     #artist has many songs 
  end
  
  def self.all 
    @@all                                                           #implicit return
  end 
  
  def save 
    self.class.all << self                                          #shovel instance into @@all[]
  end
  
  def self.destroy_all 
    @@all.clear                                                     #deletes all instances from []
  end 
  
   def self.create(name)
    name = Artist.new(name)                                         #instantiates Artist object
    name.save                                                       #invokes save method which shovels instance into []
    name                                                            #implicit return
  end
  
  def songs 
    @songs                                                          #implicit return
  end 
  
  def add_song(song)
    song.artist = self if song.artist == nil                        #sets artist to song if it does not already have one
    @songs << song unless @songs.include?(song)                     #shovels song into [] if it's not already there
  end
  
  def genres
     genre_collection = songs.collect {|song| song.genre}           #iterates over @songs, returns new arr with collection of song's genres
    genre_collection.uniq                                           #returns new arrary without duplicates 
  end
end