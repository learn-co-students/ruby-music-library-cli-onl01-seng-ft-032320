class MusicImporter
   attr_accessor :path
   
   def initialize(path)
      @path = path
   end

   def files
      Dir.children(path) #Produces all files within @path
   end

   def import
      files.each {|f| Song.create_from_filename(f)} #Creates new song instance for each file in @path
   end
end