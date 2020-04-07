require 'pry'

class MusicLibraryController 
    attr_accessor :path 
    
    def initialize(file_path = "./db/mp3s")
        @path = file_path
        importer = MusicImporter.new(@path)
        importer.import
    end 

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        answer = gets.chomp 
        possible_answers = ["list songs", "list artists", "list genres", "list artist", "list genre", "play song", "exit"]
        if possible_answers.include?(answer)
            case answer 
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list genres"
                list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre 
            when "play song"
                play_song
            when "exit"
                
            end 
        else
             call    
        end 
    end 

    def list_songs
        songs = Song.all.sort_by{|song| song.name}
        #listed_songs = songs.map{|song| "#{song.artist} - #{song.name} - #{song.genre}"}
        songs.each.with_index(1) do |song, count|
            puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end 
    end 

    def list_artists
        artists = Artist.all.sort_by{|artist| artist.name}
        artists.each.with_index(1) do |artist, count|
            puts "#{count}. #{artist.name}"
        end 
    end 

    def list_genres 
        genres = Genre.all.sort_by{|genre| genre.name}
        genres.each.with_index(1) do |genre, count|
            puts "#{count}. #{genre.name}"
        end 
    end 

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        name = gets.chomp
        songs = Song.all.select{|song| song.artist.name == name}.sort_by{|song| song.name}
        songs.each.with_index(1) do |song, count|
            puts "#{count}. #{song.name} - #{song.genre.name}"
        end 
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = gets.chomp
        songs = Song.all.select{|song| song.genre.name == genre}.sort_by{|song| song.name}
        songs.each.with_index(1) do |song, count|
            puts "#{count}. #{song.artist.name} - #{song.name}"
        end 
    end

    def play_song
        puts "Which song number would you like to play?"
        songs = Song.all.sort_by{|song| song.name}   
        choice = gets.chomp.to_i
        if choice > 0 && choice <= songs.length
            song = songs[choice - 1]
            puts "Playing #{song.name} by #{song.artist.name}"        
        end 
    end


end 