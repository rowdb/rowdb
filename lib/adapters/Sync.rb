require 'oj'
require_relative 'Adapter.rb'

##
# Synchronous file system.
##
class Sync < Adapter

  ##
  # Load a JSON string from a file.
  #
  # @return Hash data
  ##
  def read()

    json = Oj.load_file(@source)

    unless json.nil?
      data = Oj.load(json)
      return data.transform_keys(&:to_sym)
    end

    return nil

  end

  ##
  # Save a Hash to a file as JSON.
  #
  # @param Hash data
  ##
  def write(data)

    json = Oj.dump(data, mode: :compat)
    Oj.to_file(@source, json)

  end

end
