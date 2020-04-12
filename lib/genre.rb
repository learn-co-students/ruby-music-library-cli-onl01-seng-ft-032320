
class Genre
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
    @songs << song
    song.genre = self
  end
  
  def artists
    self.songs.collect {|song| song.artist}.uniq
  end
  
  
end