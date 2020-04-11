require "pry"
class Song
  
  extend Concerns::Findable
  
   attr_accessor :name  
   attr_reader :artist, :genre 
   @@all = []
   
   def initialize(name, artist=nil, genre=nil)
     @name = name 
     self.artist = artist if artist 
     self.genre = genre if genre
   end 
   
   
   def genre=(genre)
     @genre = genre 
     @genre.add_song(self)
       
   end 
   
   def artist=(artist)
       
        @artist = artist 
        @artist.add_song(self)
   end
   
   
   def self.find_by_name(name)
     self.all.find do |song|
           song.name == name 
        end 
   end
   
    def self.create(name)
     song = Song.new(name)
     song.save 
     song
   end 
   
   
   def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
   end
   
   def self.new_from_filename(filename)
   # binding.pry
    
    newfile= filename.chomp(".mp3")
    newwfile = newfile.split(" - ")
    artist_name = newwfile[0]
    song_name = newwfile[1]
    genre_type = newwfile[2]
    
    song = self.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_type)
    song 
    end
     
     def self.create_from_filename(filename)
       file = self.new_from_filename(filename)
       file.save 
     end 
   
   def save 
     @@all << self unless @@all.include?(self)
   end 
   
   def self.all 
     @@all 
   end
   
  
   
   def self.destroy_all 
     @@all.clear 
   end 
   
end 