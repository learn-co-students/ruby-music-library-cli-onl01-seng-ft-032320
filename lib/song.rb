class Song
   attr_accessor :name, :artist, :genre
   @@all = []
   
   def initialize(name, artist = nil, genre = nil)
      @name = name
      self.artist = artist if artist
      self.genre = genre if genre
      save
   end

   def artist=(artist)
      @artist = artist 
      artist.add_song(self) if !artist.songs.include?(self)
   end

   def genre=(genre)
      @genre = genre
      genre.songs << self if !genre.songs.include?(self)
   end

   def self.all
      @@all
   end

   def self.destroy_all
      @@all.clear
   end

   def save
      @@all << self
   end

   def self.create(name)
      song = Song.new(name)
      song
   end

   def self.find_by_name(name)
      self.all.detect {|a| a.name == name}
   end

   def self.find_or_create_by_name(name)
      self.find_by_name(name) ? self.find_by_name(name) : self.create(name) 
   end

   def self.new_from_filename(file)
      artist = Artist.find_or_create_by_name(file.split(" - ")[0])
      name = file.split(" - ")[1]
      genre = Genre.find_or_create_by_name(file.split(" - ")[2].split(".")[0])
      song = Song.new(name, artist, genre)
      song
   end

   def self.create_from_filename(file)
      self.new_from_filename(file)
   end

end