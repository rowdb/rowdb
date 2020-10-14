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

      if @format == :js
        unwrap(json)
      end

      # Parse JSON.
      data = Oj.load(json)
      return data.transform_keys(&:to_sym)

    end

    return nil

  end

  ##
  # Save a Hash to a file as a JSON string or JS.
  #
  # @param Hash data
  ##
  def write(data)

    json = Oj.dump(data, mode: :compat)

    if @format == :js
      wrap(json)
    end

    Oj.to_file(@source, json)

  end

end
