require 'oj'
require_relative 'Adapter.rb'

class FileSystem < Adapter

  ##
  # Load a JSON string from a file.
  #
  # @return Hash data
  ##
  def read()

    json = Oj.load_file(@source)

    unless json.nil?
      return Oj.load(json)
    end

    return nil

  end

  ##
  # Save a Hash to a file as JSON.
  #
  # @param Hash data
  ##
  def write(data)

    json = Oj.dump(data)
    Oj.to_file(@source, json)

  end

end
