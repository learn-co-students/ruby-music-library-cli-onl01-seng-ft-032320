class MusicLibraryController

    #### Attributes ####
    attr_accessor :library

    #### Instance Methods ####
    def initialize(music_path='./db/mp3s')
        # binding.pry
        importer = MusicImporter.new(music_path)
        importer.import
    end

    def call
        input = ""
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        until input == exit
            puts "What would you like to do?"
            input = gets
        end
    end

    def list_songs
        Song.all.uniq.sort {|a,b| a.name <=> b.name}.each_with_index {|song, idx| puts "#{idx+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        Artist.all.sort {|a,b| a.name <=> b.name}.each_with_index {|artist_obj, idx| puts "#{idx+1}. #{artist_obj.name}"}
    end

    def list_genres
        Genre.all.sort {|a,b| a.name <=> b.name}.each_with_index {|genre, idx| puts "#{idx+1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets
        Artist.all.each do |artist_obj|
            if artist_obj.name == input
                song_list = Song.all.select {|song| song.artist.name == input}
                # binding.pry
                song_list.sort {|a,b| a.name <=> b.name}.uniq.each_with_index {|song, idx| puts "#{idx+1}. #{song.name} - #{song.genre.name}"}
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets
        Genre.all.each do |genre_obj|
            if genre_obj.name == input
                song_list = Song.all.select {|song| song.genre.name == input}
                # binding.pry
                song_list.sort {|a,b| a.name <=> b.name}.uniq.each_with_index {|song, idx| puts "#{idx+1}. #{song.artist.name} - #{song.name}"}
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets
        input = input.to_i
        if input >= 1 && input <= Song.all.uniq.count
            song = Song.all.sort {|a,b| a.name <=> b.name}.uniq[input-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end
