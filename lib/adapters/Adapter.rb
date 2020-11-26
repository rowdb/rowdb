class Adapter

  def initialize(file_path, js_var)

    @source = normalize_path(file_path)
    @format = find_format(file_path)
    @prefix = "var #{js_var} = "
    @suffix = ";"

  end

  ##
  # Normalize path to absolute path.
  #
  # @param file_path [String] An absolute or relative path.
  # @return [String] An absolute path.
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
  # Find the format of a file based on its extension.
  #
  # @parm file_path [String] The path to the file.
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
  # @param json [String] The stringified JSON.
  ##
  def wrap()

    new_file = ""

    # Open file.
    File.open(@source, 'r') do |file|
      new_file = file.read
      new_file.prepend(@prefix)
      new_file << @suffix
    end

    # Overwrite file.
    File.open(@source, 'w') do |file|
      file.write(new_file)
    end

  end

  ##
  # Unwrap JSON from a Javascript variable.
  #
  # @param json [String] The stringified JSON.
  ##
  def unwrap(json)

    # Deletes: var data = \"
    json.delete_prefix!(@prefix + '"')

    # Deletes: \";
    # Deletes: \";\n
    json.delete_suffix!('"' + @suffix)
    json.delete_suffix!('"' + @suffix + "\n")

  end

end
