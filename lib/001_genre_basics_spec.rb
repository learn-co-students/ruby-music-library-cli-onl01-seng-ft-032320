class Genre
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
    new_genre = self.new(name)
    new_genre.save
    new_genre
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def artists
    artist_list = songs.map do |song|
      song.artist
    end
    artist_list.uniq
  end

  def add_song(song)
    if song.genre != self
      song.genre = self
    elsif @songs.include?(song) == false
      @songs << song
    end
  end
end
