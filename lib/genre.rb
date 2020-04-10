class Genre

    #### Attributes ####
    attr_accessor :name
    @@all = []


    #### Instance Methods ####
    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        self.class.all << self
    end

    def songs
        @songs
    end

    def artists
        artist_collection = self.songs.collect {|song| song.artist}
        artist_collection.uniq
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
        new_genre = self.new(name)
        new_genre.save
        new_genre
    end
end
