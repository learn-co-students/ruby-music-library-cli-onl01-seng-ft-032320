class Genre
  attr_accessor :name, :artist, :song
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(genre)
    genre = Genre.new(genre)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def add_song(song)
    if songs.include?(song) == false
      songs << song
      if song.genre == nil
        song.genre = self
      end
    end
  end

  def artists
    self.songs.map {|song| song.artist}.uniq
  end
end
