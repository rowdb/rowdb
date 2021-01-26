Gem::Specification.new do |spec|

  spec.name        = 'rowdb'
  spec.version     = '0.6.4'
  spec.date        = '2021-01-26'
  spec.authors     = ["Maedi Prichard"]
  spec.email       = 'maediprichard@gmail.com'

  spec.summary     = "A local JSON database."
  spec.description = "A local JSON database using Rudash for easy Hash traversal."
  spec.homepage    = 'https://github.com/rowdb/rowdb'
  spec.license     = 'MPL-2.0'

  spec.files = ["lib/rowdb.rb", "lib/adapters/adapter.rb", "lib/adapters/sync.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "oj"
  spec.add_dependency "rudash"

end
