class Song

    #### Attributes ####
    attr_accessor :name, :artist, :genre
    @@all = []


    #### Instance Methods ####
    def initialize(name, artist="Bob", genre="")
        @name = name
        if artist.class == Artist
            self.artist=(artist)
        end

        if genre.class == Genre
            self.genre=(genre)
        end
    end

    def save
        self.class.all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        if !(genre.songs.include?(self))
            genre.songs << self
        end
    end


    #### Class Methods####
    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def self.create(name)
        new_song = self.new(name)
        new_song.save
        new_song
    end

    def self.find_by_name(name)
        Song.all.find {|song_obj| song_obj.name == name}
    end

    def self.find_or_create_by_name(name)
        if find_by_name(name).nil?
            self.create(name)
        else
            find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        song_file = filename.split(" - ")
        song = self.find_or_create_by_name(song_file[1])
        song.artist = Artist.find_or_create_by_name(song_file[0])
        song.genre = Genre.find_or_create_by_name(song_file[2].chomp('.mp3'))
        song
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
    end
end
