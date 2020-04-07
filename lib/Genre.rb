require_relative '../config/environment.rb'

class Genre 
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

    def artists 
        songs.map{|song| song.artist}.uniq
    end 

    ###Class Methods###

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre 
    end 
    def self.all 
        @@all 
    end 

    def self.destroy_all 
        @@all.clear 
    end 

end 