require 'rudash'
require_relative 'adapters/Sync.rb'

class Rowdb

  def initialize(file_path, adapter = :sync)
    @adapter = self.send(adapter, normalize_path(file_path))
    @chain = R_.chain(@adapter.read())
    @get_path = nil
  end

  # Set default data.
  def defaults(data)
    if @chain.value().nil?
      @chain = R_.chain(data.transform_keys(&:to_sym))
    end
    self
  end

  def get(path)
    @get_path = path
    @chain.get(path)
    self
  end

  def set(path, value)
    @chain.set(path, value)
    self
  end

  def value()
    @chain.value()
  end

  def push(value)

    if @get_path.nil?
      raise StandardError.new "You must get() before push()."
    end

    # Add value to end of array.
    adder = -> (items) {
      [*items, value]
    }
    R_.update(@chain.value(), @get_path, adder)

    self
  end

  def write()
    @adapter.write(@chain.value())
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
