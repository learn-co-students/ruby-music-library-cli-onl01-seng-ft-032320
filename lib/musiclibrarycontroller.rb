require_all 'lib' #Gives this file access to the entire lib folder

class MusicLibraryController
   attr_accessor :path
   
   def initialize(path = './db/mp3s')
      @path = path
      MusicImporter.new(path).import #Passes path into MI and imports so that we have song instances
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
         end
      end
   end

   def list_songs
      #Look at each song instance . sort by name . go through each and assign index => put
      Song.all.sort_by{|s| s.name}.each.with_index(1) do |n,i|
         puts "#{i}. #{n.artist.name} - #{n.name} - #{n.genre.name}"
      end
   end

   def list_artists
      #Look at each artist instance . sort by name . go through each and assign index => put   
      Artist.all.sort_by{|a| a.name}.each.with_index(1) do |a,i|
         puts "#{i}. #{a.name}"
      end
   end

   def list_genres
       #Look at each genre instance . sort by name . go through each and assign index => put   
      Genre.all.sort_by{|g| g.name}.each.with_index(1) do |a,i|
         puts "#{i}. #{a.name}"
      end   
   end

   def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip
      # artist is assigned to an artist instance if Artist.find_by... returns true
      # since we wrote "artist =" ruby checks the right of the equal sign first
      if artist = Artist.find_by_name(input)
         #Look at all songs of the artist . sort by name . check each / assign index and puts
         artist.songs.sort_by{|s| s.name}.each.with_index(1) do |n,i|
            puts "#{i}. #{n.name} - #{n.genre.name}"
         end
      end 
   end

   def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip
      # genre is assigned to an genre instance if Genre.find_by... returns true
      # since we wrote "genre =" ruby checks the right of the equal sign first
      if genre = Genre.find_by_name(input)
         #Look at all songs of the genre . sort by name . check each / assign index and puts
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
end