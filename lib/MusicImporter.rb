class MusicImporter 
    attr_accessor :path

    def initialize(file)
        @path = file 
    end 

    def files 
        @files = Dir.entries(path)
        @files.select{|file| file.include?("mp3")}
    end 

    def import 
        files.each do |file|
            Song.create_from_filename(file)
        end 
    end 

end 