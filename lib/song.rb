require 'pry'
class Song
  attr_accessor :name, :artist, :genre



  @@all = []

  def initialize(name, artist =  nil, genre = nil )
    @name = name
    self.artist = artist if artist # this states that the instance setter method .artist will only be run if artist equals true (nil will make it false) so default argument will make it false and not run.
    self.genre = genre if genre

  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    new_song = self.new(name)  # creates an new instance of a song
    new_song.save # the new song is an intance and has an instance method of save witch shovel the intance into the Class variable
    new_song # returns the new song.
  end

  def artist=(artist) # intance of an artist
    @artist = artist
    artist.add_song(self) #.add_song gives a artist a song and shovels the instance of that song into the @songs array of the artist
  end

  def genre=(genre) # this is talking an genre instance
    @genre = genre
    if genre.songs.include?(self)

    else
      genre.songs << self
    end
  end

  def self.find_by_name(song_name)
    self.all.find{|song| song.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    self.find_by_name(song_name)  || self.create(song_name)
    #binding.pry
  end

  def self.new_from_filename(filename)
    song_name = filename.split(" - ")[1]
    artirst_name = filename.split(" - ")[0]
    genre_name = filename.split(" - ")[2].split(".mp3").join


    artist = Artist.find_or_create_by_name(artirst_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.all << self.new_from_filename(filename)

  end



end
