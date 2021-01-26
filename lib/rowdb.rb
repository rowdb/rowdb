################################################################################
# A local JSON database using Rudash for easy Hash traversal.
#
# @author Maedi Prichard
################################################################################

require 'rudash'
require_relative 'adapters/sync.rb'

class Rowdb

  def initialize(file_path, adapter = :sync, js_var = "db")

    # Initialize the chosen adapter.
    @adapter = self.send(adapter, file_path, js_var)

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

  ##
  # Adapters.
  #
  # The chosen adapter is initialized by the constructor.
  ##

  def sync(file_path, js_var)
    Sync.new(file_path, js_var)
  end

end
