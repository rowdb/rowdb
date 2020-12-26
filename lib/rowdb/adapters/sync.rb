require 'oj'
require_relative 'adapter.rb'

##
# Synchronous file system.
##
class Rowdb
class Sync < Adapter

  ##
  # Load a JSON string from a file.
  #
  # @return Hash data
  ##
  def read()

    json = nil

    # Load JSON inside a Javascript variable.
    if @format == :js && File.exist?(@source)
      File.open(@source, 'r') do |file|
        json = file.read
        # Fix double encoding issue due to JSON string becoming Ruby string.
        json.gsub!('\\"', '"')
        unwrap(json)
      end
    # Load JSON string.
    else
      json = Oj.load_file(@source)
    end

    unless json.nil?

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

    Oj.to_file(@source, json)

    if @format == :js
      wrap()
    end

  end

end
end
