class Artist
  attr_accessor :name, :song
  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end
  def songs
    @songs
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(artist)
    artist = Artist.new(artist)
    artist.save
    artist
  end

  def add_song(song)
    if songs.include?(song) == false
      songs << song
      if song.artist == nil
        song.artist = self
      end
    end
  end


  def genres
    self.songs.map {|song| song.genre}.uniq
  end

  
  
end