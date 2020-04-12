
class Artist
  extend Concerns::Findable
  
  attr_accessor :name, :songs
   @@all = []
   
  def initialize(name)
    @name = name
    @songs = []
    save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end 
  
  def self.destroy_all
    @@all = []
  end
  
  def self.create(name)
    name = self.new(name)
    name
  end
  
  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist == nil
  end

  
  def songs
    @songs
  end
  
  def genres
    self.songs.collect {|song| song.genre}.uniq
  end
  
  



end