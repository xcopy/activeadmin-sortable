# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin-sortable/version'

Gem::Specification.new do |gem|
  gem.name          = 'activeadmin-sortable'
  gem.version       = Activeadmin::Sortable::VERSION
  gem.authors       = ['Kairat Jenishev']
  gem.email         = ['kairat.jenishev@gmail.com']
  gem.description   = %q{Drag and drop sort interface for ActiveAdmin tables}
  gem.summary       = %q{Reorder ActiveAdmin resource records is easy now}
  gem.homepage      = 'https://github.com/xcopy/activeadmin-sortable'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activeadmin', '>= 0.4'
  # todo
  # gem.add_dependency 'acts_as_list'
  gem.add_dependency 'js-routes'
end
