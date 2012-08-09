# -*- encoding: utf-8 -*-
require File.expand_path('../lib/seeding/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nikolai Manek"]
  gem.email         = ["niko.manek@gmail.com"]
  gem.description   = %q{Seedy creates a seed.rb from your existing database. You can write queries on the rails console and it will write the results to your seed.rb. I wrote it after having to create seed files with thousands of values and could not handle it any longer..}
  gem.summary       = %q{Seedy creates a seed.rb from query results}
  gem.homepage      = "https://github.com/nikoma/seeding"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "seeding"
  gem.require_paths = ["lib"]
  gem.version       = Seeding::VERSION
  
  gem.add_runtime_dependency "uuid"
  gem.add_runtime_dependency "mash"
end
