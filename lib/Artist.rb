require_relative '../config/environment.rb'

class Artist 
    extend Concerns::Findable
    include Concerns::Instances
    attr_accessor :name 

    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
    end 

    def songs 
        @songs 
    end 

    def add_song(song)
        song.artist = self if song.artist == nil 
        @songs << song unless @songs.include?(song)
    end

    def genres
        songs.map{|song| song.genre}.uniq
    end  

    ###Class Methods###
    def self.create(name)
        artist = Artist.new(name)
        artist.save 
        artist 
    end 
    
    def self.all 
        @@all 
    end 

    def self.destroy_all
        @@all.clear
    end 
end 