class Artist
  extend Concerns::Findable
  @@all = []
  
  attr_accessor :name, :songs, :genre
  
  
  def initialize(name)
    @name=name
    @songs = []
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
  
  def self.create(artist)
    artist = self.new(artist)
    artist.save
    artist
  end
  
  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song unless @songs.include?(song)
  end
  
  def songs
    @songs
  end
  
  def genres
    results = songs.collect {|i| i.genre}
    results.uniq
   end
  
end