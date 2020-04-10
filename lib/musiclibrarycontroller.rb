require_all 'lib'

class MusicLibraryController
   attr_accessor :path
   
   def initialize(path = './db/mp3s')
      @path = path
      import = MusicImporter.new(path).import
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
      input = ""
      while input != "exit"
         input = gets.downcase.strip
         if input == "list songs"
            list_songs
            
         elsif input == "list artists"
            list_artists
            
         elsif input == "list genres"
            list_genres
            
         elsif input == "list artist"
            list_songs_by_artist
            
         elsif input == "list genre"
            list_songs_by_genre
            
         elsif input == "play song"
            play_song
         else
            "Sorry I don't understand. What would you like to do?"
            input = gets.downcase.strip
         end
      end
   end

   def list_songs
      Song.all.sort_by{|s| s.name}.each.with_index(1) do |n,i|
         puts "#{i}. #{n.artist.name} - #{n.name} - #{n.genre.name}"
      end
   end

   def list_artists
      Artist.all.sort_by{|a| a.name}.each.with_index(1) do |n,i|
         puts "#{i}. #{n.name}"
      end
   end

   def list_genres
      Genre.all.sort_by{|g| g.name}.each.with_index(1) do |n,i|
         puts "#{i}. #{n.name}"
      end   
   end

   def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip
      if artist = Artist.find_by_name(input)
         artist.songs.sort_by{|s| s.name}.each.with_index(1) do |n,i|
            puts "#{i}. #{n.name} - #{n.genre.name}"
         end
      end 
   end

   def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip
      if genre = Genre.find_by_name(input)
         genre.songs.sort_by{|s| s.name}.each.with_index(1) do |n,i|
            puts "#{i}. #{n.artist.name} - #{n.name}"
         end
      end 
   end

   def play_song
      puts "Which song number would you like to play?"
      input = gets.strip.to_i
      if input > 1 && input <= Song.all.length
         puts "Playing #{Song.all[input].name} by #{Song.all[input].artist.name}"
      end
   end

   # def welcome
   #    puts "Welcome to your music library!"
   #    puts "To list all of your songs, enter 'list songs'."
   #    puts "To list all of the artists in your library, enter 'list artists'."
   #    puts "To list all of the genres in your library, enter 'list genres'."
   #    puts "To list all of the songs by a particular artist, enter 'list artist'."
   #    puts "To list all of the songs of a particular genre, enter 'list genre'."
   #    puts "To play a song, enter 'play song'."
   #    puts "To quit, type 'exit'."
   #    puts "What would you like to do?"
   # end
end