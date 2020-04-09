class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    @path = path 
  end 
  
  def files
    files = [ ]
   Dir.children(self.path).map {|file| files << file if file.length > 4}
     files 
  end 
  
  def import 
    files.each {|filename| Song.create_from_filename(filename)}
  end
  
end 