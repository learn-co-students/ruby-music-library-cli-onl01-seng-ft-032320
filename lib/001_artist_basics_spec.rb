class Artist
  attr_accessor :name, :songs

  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def add_song(song)
    if song.artist != self
      song.artist = self
    elsif @songs.include?(song) == false
      @songs << song
    end
  end

  def genres
    genre_list = songs.map do |song|
      song.genre
    end
    genre_list.uniq
  end

end
