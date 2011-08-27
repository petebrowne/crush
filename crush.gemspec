# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "crush/version"

Gem::Specification.new do |s|
  s.name        = "crush"
  s.version     = Crush::VERSION
  s.authors     = [ "Pete Browne" ]
  s.email       = "me@petebrowne.com"
  s.homepage    = "http://github.com/petebrowne/crush"
  s.summary     = "Tilt templates for various JavaScript and CSS compression libraries."
  s.description = "Crush is a set of Tilt templates for the various JavaScript and CSS compression libraries in Ruby."

  s.rubyforge_project = "crush"

  s.add_dependency "tilt", "~> 1.3"
  
  s.add_development_dependency "rspec", "~> 2.6"
  s.add_development_dependency "rake"
  s.add_development_dependency "jsmin"
  s.add_development_dependency "packr"
  s.add_development_dependency "uglifier"
  s.add_development_dependency "closure-compiler"
  s.add_development_dependency "yui-compressor"
  s.add_development_dependency "cssmin"
  s.add_development_dependency "rainpress"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)
end
