require 'pry'

class MusicImporter
  attr_accessor :path


  def initialize(path)
    @path = path
  end


  def files
    @files = Dir.entries(@path).select { |song| !File.directory?(song) && song.end_with?(".mp3")}
    #binding.pry
  end

  def import
    self.files.each {|filename|
      Song.create_from_filename(filename)
    }
  end

end
