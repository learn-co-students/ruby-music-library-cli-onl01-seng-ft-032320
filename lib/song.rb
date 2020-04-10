class Song
   attr_accessor :name, :artist, :genre
   @@all = []
   
   #Name is mandatory // artist + genre are optional / defaulted to nil
   def initialize(name, artist = nil, genre = nil)
      @name = name
      self.artist = artist if artist #Set (self) or song.artist to artist if artist !nil 
      self.genre = genre if genre #Set (self) or song.genre to genre if genre !nil
      save 
   end

   def artist=(artist)
      @artist = artist 
      #Add song to artist if the artists songs does not include the song
      artist.add_song(self) if !artist.songs.include?(self)
   end

   def genre=(genre)
      @genre = genre
      #Add song to genre if the genres songs does not include the song
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
            # if truthy ? return : create
      self.find_by_name(name) ? self.find_by_name(name) : self.create(name) 
   end

   def self.new_from_filename(file)
      #Create new artist instance based on filename split
      artist = Artist.find_or_create_by_name(file.split(" - ")[0])
      #Setting variable for song creation later
      name = file.split(" - ")[1]
      #Create new genre instance based on filename split // remove .mp3 with second split
      genre = Genre.find_or_create_by_name(file.split(" - ")[2].split(".")[0])
      #Create new song based on split info
      song = Song.new(name, artist, genre)
      song
   end

   def self.create_from_filename(file)
      self.new_from_filename(file)
   end

end