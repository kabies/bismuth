
class Bi::Archive
  include ::Singleton

  FourCC = "CNBR"
  VERSION = 1

  attr_reader :archive_name

  def self.load(filename)
    Archive.instance.load filename
  end

  def initialize
    @files = {}
  end

  def load(filename)
    unless File.exist?(filename) and File.file?(filename)
      raise "file not exist"
    end

    @archive_name = filename
    archive = File.open @archive_name, "r"

    four_cc = archive.read(4)
    version = archive.read(4).unpack("V").first

    if four_cc != FourCC or version != 1
      raise "version error: #{four_cc} #{version}"
    end

    @list_size = archive.read(4).unpack("V").first
    @files = {}

    @data_start = 4 + 4 + 4 # four_cc + version + list_size

    @list_size.times do
      size, file_start, filename_length = archive.read(4*3).unpack("VVV")
      filename = archive.read(filename_length)
      # p [size, file_start, filename_length, filename]
      @files[filename] = [file_start,size]
      @data_start += 4*3 + filename_length
    end

    # XXX: mruby-io incorrect tell...
    # @data_start = archive.tell

    self
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

end
