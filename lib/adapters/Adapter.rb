class Adapter

  def initialize(file_path, js_var)

    @source = normalize_path(file_path)
    @format = find_format(file_path)
    @prefix = "var #{js_var} = "
    @suffix = ";"

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

  ##
  # Find format.
  #
  # Find the format of a file based on its extension.
  ##
  def find_format(file_path)

    extension = File.extname(file_path)

    case extension
    when ".json"
      return :json
    when ".js"
      return :js
    end

    :json

  end

  ##
  # Wrap JSON in a Javascript variable.
  #
  # @param String json
  ##
  def wrap(json)

    json.prepend(@prefix)
    json << @suffix

  end

  ##
  # Unwrap JSON from a Javascript variable.
  #
  # @param String json
  ##
  def unwrap(json)

    json.delete_prefix!(@prefix)
    json.delete_suffix!(@suffix)

  end

end
