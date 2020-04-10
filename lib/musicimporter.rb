require 'pry'
class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    @path = path 
  end 
  
  def files
    Dir.chdir(@path) do | path |
        Dir.glob("*.mp3")
    end
  end 
  
  def import
    self.files.each do |name|
      Song.create_from_filename(name)
    end
  end
  
end 