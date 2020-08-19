require 'rudash'
require_relative 'adapters/Sync.rb'

class Rowdb

  def initialize(file_path, adapter = :sync)
    @adapter = self.send(adapter, normalize_path(file_path))
    @data = R_.chain(@adapter.read())
    @get_path = nil
  end

  def defaults(data)
    if @data.value().nil?
      # Load default data.
      @data = R_.chain(data)
      # Save data to disk.
      @adapter.write(data)
    end
    self
  end

  def get(path)
    @get_path = path
    @data.get(path)
    self
  end

  def set(path, value)
    @data.set(path, value)
    self
  end

  def value()
    @data.value()
  end

  def push(value)
    if @get_path.nil?
      raise StandardError.new "You must get() before push()."
    end

    index = @data.get(@get_path).value().count
    @data.set("#{@get_path}[#{index}]", value)

    self
  end

  def write()
    @adapter.write(@data.value())
    self
  end

  private

  def sync(file_path)
    Sync.new(file_path)
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
