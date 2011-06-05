# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "crush/version"

Gem::Specification.new do |s|
  s.name        = "crush"
  s.version     = Crush::VERSION
  s.authors     = %w(Pete Browne)
  s.email       = "me@petebrowne.com"
  s.homepage    = "http://github.com/petebrowne/crush"
  s.summary     = "A generic interface to multiple Ruby compression engines."
  s.description = "Crush is a generic interface, like Tilt, for the various compression engines in Ruby."

  s.rubyforge_project = "crush"
  
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "jsmin"
  s.add_development_dependency "packr"
  s.add_development_dependency "uglifier"
  s.add_development_dependency "closure-compiler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)
end
