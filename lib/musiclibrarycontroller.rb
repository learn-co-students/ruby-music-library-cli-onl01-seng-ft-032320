class MusicLibraryController
  
      attr_accessor :path 
      
  def initialize(path=("./db/mp3s"))
    @path = path 
    songo = MusicImporter.new(path)
    new_songo = songo.import 
  end 
  
  def call
    puts "Welcome to your music library!"
    user_input = gets.chomp
    if user_input != exit 
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    case user_input
    
     when "list_songs"
       list_songs
     when "list artist"
       list_artists
     when "list genres"
       list_genres 
     when "list artist"
       list_songs_by_artist
     when "list genre"
       list_songs_by_genre
     when "play song"
       play_song
     end 
    end 
  end 
    
    def list_songs
      #binding.pry
      Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |a, i|
      puts "#{i}. #{a.artist.name} - #{a.name} - #{a.genre.name}"
      end
    end 
    
    def list_artists
      #binding.pry
      Artist.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |a,i|
      puts "#{i}. #{a.name}"
      end
    end

      
    
    
     def list_genres
      #binding.pry
      #sorted_name = Song.all.sort_by { |song| song.genre.name }
      #sorted_name.each_with_index { |song, index| puts "#{index + 1}. #{song.genre.name}"}
      
      Genre.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |a,i|
      puts "#{i}. #{a.name}"
      end
    end 
    
    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      user_input = gets.chomp
      if genre = Genre.find_by_name(user_input)
        genre_sorted = genre.songs.sort_by do |song| song.name 
      end 
        genre_sorted.each.with_index(1) do |song, index| 
          puts "#{index}. #{song.artist.name} - #{song.name}"
        end 
      end 
    end
    
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      user_input = gets.chomp
      
      if singer = Artist.find_by_name(user_input)
        
        sosinger_sorted = singer.songs.sort_by do |song| song.name 
      end 
      sosinger_sorted.each.with_index(1) do |song,index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
    end 
    
    def play_song
      
      puts "Which song number would you like to play?"
      user_input = gets.chomp.to_i 
     
      if (1..Song.all.length).include?(user_input)
         song_list = Song.all.sort_by { |song| song.name}
         song = song_list[user_input - 1]
         puts "Playing #{song.name} by #{song.artist.name}"
         #play_song
       end 
    end 
  
  
end 