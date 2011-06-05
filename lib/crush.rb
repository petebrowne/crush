module Crush
  autoload :Closure,   "crush/closure"
  autoload :CSSMin,    "crush/cssmin"
  autoload :Engine,    "crush/engine"
  autoload :JSMin,     "crush/jsmin"
  autoload :Packr,     "crush/packr"
  autoload :Rainpress, "crush/rainpress"
  autoload :Uglifier,  "crush/uglifier"
  autoload :YUI,       "crush/yui"
  
  class EngineNotFound < StandardError; end
  
  # Hash of registered compression engines.
  def self.mappings
    @mappings ||= Hash.new { |h, k| h[k] = [] }
  end
  
  # Ensures the extension doesn't include the "."
  def self.normalize(ext)
    ext.to_s.downcase.sub /^\./, ""
  end
  
  # Registers a compression engine for the given file extension(s).
  def self.register(engine, *extensions)
    extensions.each do |ext|
      ext = normalize(ext)
      mappings[ext].unshift(engine).uniq!
    end
  end
  
  # Returns true when an engine exists for the given file extension.
  def self.registered?(ext)
    ext = normalize(ext)
    mappings.key?(ext) && !mappings[ext].empty?
  end
  
  # Make the given compression engine preferred. Which means,
  # it will reordered the beginning of its mapping.
  def self.prefer(engine)
    mappings.each do |ext, engines|
      if engines.include?(engine)
        engines.delete(engine)
        engines.unshift(engine)
      end
    end
  end
  
  # Look for a compression engine for the given filename or file
  # extension. Return nil when no engine is found.
  def self.[](path)
    pattern = File.basename(path.to_s).downcase
    until pattern.empty? || registered?(pattern)
      pattern.sub! /^[^.]*\.?/, ""
    end
    
    pattern = normalize(pattern)
    mappings[pattern].detect(&:engine_initialized?) || mappings[pattern].first
  end
  
  # Create a new compression engine for the given file using the file's extension
  # to determine the the engine mapping.
  def self.new(path, options = {}, &block)
    if engine = self[path]
      engine.new path, options, &block
    else
      raise EngineNotFound.new("No compression engine registered for '#{path}'")
    end
  end
  
  register Crush::JSMin,                     "js",  "min.js"
  register Crush::Packr,                     "js",  "pack.js"
  register Crush::YUI::JavaScriptCompressor, "js",  "yui.js"
  register Crush::Closure::Compiler,         "js",  "closure.js"
  register Crush::Uglifier,                  "js",  "ugly.js"
  
  register Crush::CSSMin,                    "css", "min.css"
  register Crush::Rainpress,                 "css", "rain.css"
  register Crush::YUI::CssCompressor,        "css", "yui.css"
end
