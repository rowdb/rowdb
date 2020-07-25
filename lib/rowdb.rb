require 'rudash'
require_relative 'adapters/FileSystem.rb'

class Rowdb

  def initialize(adapter = :file_system, file_path)
    @adapter = self.send(adapter, normalize_path(file_path))
    @data = @adapter.read()
  end

  def defaults(hash)
    json = Oj.dump(hash)
    @adapter.write(json)
  end

  def get(path)
    R_.get(@adapter.source, path)
  end

  def set(path, value)
    @data = R_.set(@data, path, value)
  end

  private

  def file_system(file_path)
    FileSystem.new(file_path)
  end

  ##
  # Normalize path.
  #
  # @param file_path - An absolute or relative path.
  # @return An absolute path.
  ##
  def normalize_path(file_path)

    # Absolute path.
    if file_path.start_with? '/'
      return file_path
    # Relative path.
    else
      # Get directory the script executed from.
      return File.join(Dir.pwd, '/' + file_path)
    end

  end

end
