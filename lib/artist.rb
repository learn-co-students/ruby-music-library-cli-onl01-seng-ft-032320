require_relative "./concerns/findable.rb" #Allows us to use our Findable module
class Artist
   extend Concerns::Findable #Allows us to use our Findable module (extend for class methods / include for instance methods)

   attr_accessor :name, :songs
   @@all = []
   
   def initialize(name)
      @name = name
      @songs = []
      save
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
      artist = Artist.new(name)
   end

   def add_song(song)
      #Add to artist songs unless it already exists
      songs << song unless songs.include?(song)
      #Add self to song.artist unless it already has an artist value
      song.artist = self unless song.artist
   end

   def genres
      songs.collect{|s| s.genre}.uniq
   end
end