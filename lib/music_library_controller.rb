require 'pry'
class MusicLibraryController
  attr_accessor :path 
  
  def initialize(path = './db/mp3s')
    @path = path
    importer = MusicImporter.new(path)
    importer.import
  end
  
  def call
    input = '' 
    if input != exit
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip.downcase
    end
  end
  
  def list_songs
    #not hard coded 
    #prints all songs in numbered, alphabetical list
        #binding.pry
        Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
          puts "#{i + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}" 
        end
  end

  def list_artists
    #not hard coded 
    #prints all artist in numbered, alphabetical list
    artists = Artist.all.sort{|a, b| a.name <=> b.name}
    
    artists.each_with_index {|s, i| puts "#{i + 1}. #{s.name}"} 
  end

  def list_genres
    #not hard coded 
    #prints all genres in numbered, alphabetical list
    genres = Genre.all.sort{|a, b| a.name <=> b.name}
    
    genres.each_with_index {|s, i| puts "#{i + 1}. #{s.name}"} 
  end

  def list_songs_by_artist
    #prompts user to enter an artist
    puts "Please enter the name of an artist:"
    #accepts user input
    input = gets.strip
    #prints all songs by a particular artist in numbered, alphabetized list
    if artist = Artist.find_by_name(input)
      artist.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        puts "#{i + 1}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    #prompts user to enter an artist
    puts "Please enter the name of a genre:"
    #accepts user input
    input = gets.strip
    #prints all songs by a particular artist in numbered, alphabetized list
    if genre = Genre.find_by_name(input)
      genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        puts "#{i + 1}. #{s.artist.name} - #{s.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i

    songs = Song.all

    if (1..songs.length).include?(input)
      song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
    end

    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
  
end 