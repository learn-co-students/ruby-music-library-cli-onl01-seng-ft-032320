class Genre
    extend Concerns::Findable
  @@all = []
  
  attr_accessor :name, :song, :artist
  
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
  
  def self.create(genre)
    genre = self.new(genre)
    genre.save
    genre
  end
  
   def add_song(song)
    song.genre = self if song.genre == nil
    @songs << song unless @songs.include?(song)
  end
  
  def songs
    @songs
  end
  
  def artists
    results = songs.collect {|i| i.artist}
    results.uniq
  end
  
end