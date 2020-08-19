Gem::Specification.new do |spec|

  spec.name        = 'rowdb'
  spec.version     = '0.4.1'
  spec.date        = '2020-08-19'
  spec.authors     = ["Maedi Prichard"]
  spec.email       = 'maediprichard@gmailcom'

  spec.summary     = "A local JSON database."
  spec.description = "A local JSON database for Ruby inspired by lowdb, using Rudash for easy Hash traversal."
  spec.homepage    = 'https://github.com/rowdb/rowdb'
  spec.license     = 'MPL-2.0'

  spec.files         = ["lib/rowdb.rb", "lib/adapters/Adapter.rb", "lib/adapters/Sync.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "oj"
  spec.add_dependency "rudash"

end
