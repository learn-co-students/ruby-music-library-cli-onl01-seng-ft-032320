require_relative "./concerns/findable.rb" #Allows us to use our Findable module
class Genre
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
      genre = Genre.new(name)
   end

   def artists
      songs.collect{|s| s.artist}.uniq
   end

end