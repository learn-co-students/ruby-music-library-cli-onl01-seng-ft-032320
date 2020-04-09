class Song
  attr_accessor :name, :artist, :genre
  
  @@all=[]
  
  def initialize(name, artist= nil, genre= nil)
    @name= name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = self.new(name)
    song.name = name
    song.save
    song
  end
  
  def artist=(artist)
    @artist= artist
    artist.add_song(self) if !artist.songs.include?(self)
  end
  
  def genre=(genre)
    @genre= genre
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.find_by_name(name)
    @@all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.all.include?(name)
    self.find_by_name(name)|| self.create(name)
  end
  
  def self.new_from_filename(file_name)
    parse_song = file_name.split(" - ")
    song_artist = Artist.find_or_create_by_name(parse_song[0])
    song_genre = Genre.find_or_create_by_name(parse_song[2].chomp(".mp3"))
    Song.new(parse_song[1], song_artist, song_genre)
  end
  
  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
    song.save
  end
end


#rspec spec/010_music_library_controller_spec.rb

