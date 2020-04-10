class Song 
  
  attr_accessor :name, :genre 
  attr_reader :artist 
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    # binding.pry
    self.artist=(artist) if artist
    self.genre=genre if genre
    # @genre = genre 
    
    @@all << self
  end
  
  def save
    @@all << self
  end
  
  def artist=(artist)
    # binding.pry 
    # artist.songs << self if !artist.songs.include?(self)
    @artist = artist if !@artist
    artist.add_song(self)
  end
  
  # Class Methods
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    song = self.new(name) 
    song.save
    song
  end
  
end