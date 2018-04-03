
class Bi::Archive

  FourCC = "BIAR"
  VERSION = 1

  attr_reader :archive_name

  def initialize
    @files = {}
  end

  def load(filename)
    unless File.exist?(filename) and File.file?(filename)
      raise "archive file #{filename} not exist"
    end

    @archive_name = filename
    File.open(@archive_name, "r") do |archive|
      four_cc = archive.sysread(4)
      version = archive.sysread(4).unpack("V").first

      if four_cc != FourCC or version != 1
        raise "version error: #{four_cc} #{version}"
      end

      @list_size = archive.sysread(4).unpack("V").first
      @files = {}

      @data_start = 4 + 4 + 4 # four_cc + version + list_size

      @list_size.times do
        size, file_start, filename_length = archive.sysread(4*3).unpack("VVV")
        filename = archive.sysread(filename_length)
        @files[filename] = [file_start,size]
        @data_start += 4*3 + filename_length
      end
    end
  end

  def files
    @files.keys
  end

  def include?(filename)
    @files.include? filename
  end

  def at(filename)
    return nil unless @files[filename]
    @data_start + @files[filename][0]
  end

  def size(filename)
    return nil unless @files[filename]
    @files[filename][1]
  end

  def read(at,length)
    dat = nil
    File.open(@archive_name) do |archive|
      archive.sysseek at
      dat = archive.read length
    end
    dat
  end
end
