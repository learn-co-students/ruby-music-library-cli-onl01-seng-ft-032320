require_relative '../config/environment.rb'

class Song 
    extend Concerns::Findable
    include Concerns::Instances
    attr_accessor :name
    attr_reader :artist, :genre   

    @@all = []

    def initialize(song, artist = nil, genre = nil)
        @name = song 
        self.artist= artist unless artist == nil 
        self.genre= genre unless genre == nil
    end 

    def artist=(artist)
        @artist = artist 
        artist.add_song(self)
    end 

    def genre=(genre)
        @genre = genre 
        genre.songs << self unless genre.songs.include?(self)
    end 

    ###Class Methods###


    # def self.find_or_create_by_name(name)
    #     find_by_name(name) == nil ? Song.create(name) : find_by_name(name)
    # end

    def self.new_from_filename(file)
        parsed_file = file.split(/ - |\./)  
        artist = Artist.find_or_create_by_name(parsed_file[0])
        genre = Genre.find_or_create_by_name(parsed_file[2])
        song = Song.new(parsed_file[1], artist, genre)
    end 

    def self.create_from_filename(file)
        song = Song.new_from_filename(file)
        song.save
    end 
  

    def self.create(name)
        song = Song.new(name)
        song.save 
        song 
    end

    def self.all 
        @@all
    end

    def self.destroy_all
        @@all.clear
    end 
end 