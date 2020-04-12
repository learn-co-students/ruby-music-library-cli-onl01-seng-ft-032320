class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    @file = Dir.glob("#{@path}/*.mp3")
    @file.map do |file_str|
      file_str.gsub("#{@path}/", "")
    end
  end

  def import
    files.each do |file_name|
      Song.create_from_filename(file_name)
    end
  end

end
