require 'oj'
require_relative 'Adapter.rb'

class FileSystem < Adapter

  def read()

    Oj.load_file(@source)

  end

  def write(json)

    Oj.to_file(@source, json)

  end

end
