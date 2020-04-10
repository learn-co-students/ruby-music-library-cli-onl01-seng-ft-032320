class Artist

    #### Attributes ####
    attr_accessor :name, :songs
    @@all = []


    #### Instance Methods ####
    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        self.class.all << self
    end

    def add_song(song)
        if song.artist.nil?
            song.artist = self
        end

        if !(@songs.include?(song))
            @songs << song
        end
    end

    def genres
        genre_collection = self.songs.collect {|song| song.genre}
        genre_collection.uniq
    end


    #### Class Methods####
    extend Concerns::Findable

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def self.create(name)
        new_artist = self.new(name)
        new_artist.save
        new_artist
    end
end
