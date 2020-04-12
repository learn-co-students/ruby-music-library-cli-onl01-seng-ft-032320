
class Song
  attr_accessor :name
  attr_reader :genre,:artist
    @@all = []
    
 def initialize(name,artist=nil,genre=nil)
    @name = name
   self.artist = artist if artist
    self.genre = genre if genre
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
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
def artist=(artist)
      @artist = artist if @artist == nil
    if @artist != nil
      @artist.add_song(self)
    end
    @artist
  end
  
  def self.find_by_name(given_song)
    self.all.find {|song| song.name == given_song}
  end
  
  def self.find_or_create_by_name(given_song)
    if self.find_by_name(given_song) == nil
      self.create(given_song)
    else
      self.find_by_name(given_song)
   end
  end
  
  def self.new_from_filename(filename)
    
    artist_name = filename.split(" - ")[0]
    song_name = filename.split(" - ")[1]
    genre_name = filename.split(" - ")[2].chomp(".mp3")
    
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end
  
  def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
  end
  
  
  
  

  
end 
