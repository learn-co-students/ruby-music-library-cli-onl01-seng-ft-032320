class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    def files
      @files ||=  Dir.entries(@path).select {|song| !File.directory?(song) && song.end_with?(".mp3")}
    end
  end
  
  def import
    files.each{|file| Song.create_from_filename(file)}
  end
end