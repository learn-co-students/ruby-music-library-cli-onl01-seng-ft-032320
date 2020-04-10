class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    mp3_files = Dir.chdir(@path) do
      Dir.glob("**/*.mp3")
    end
    mp3_files
  end

  def import
    files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
