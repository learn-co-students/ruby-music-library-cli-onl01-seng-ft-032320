class Song 
  
  attr_accessor :name, :genre, :artist 
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    # binding.pry
    self.artist=(artist) if artist
    self.genre=genre if genre
    
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
  
   def genre=(genre)
    @genre = genre
    if !(genre.songs.include?(self))
      genre.songs << self
    end
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
  
  def self.find_by_name(name)
    @@all.detect { |song| song.name == name}
    
  end
  
  def self.find_or_create_by_name(name)
    # if self.find_by_name(name)
    #   self.find_by_name(name)
      
    # else
    #   song = self.create(name)
    # end
    
    find_by_name(name) || create(name)
  end
  
  
  
  
  
  
end