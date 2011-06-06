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
  
  @preferred_engines = {}
  @engine_mappings   = Hash.new { |h, k| h[k] = [] }
  
  # Hash of registered compression engines.
  def self.mappings
    @engine_mappings
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
  def self.prefer(engine_or_name, *extensions)
    engine = find_by_name(engine_or_name) unless engine_or_name.is_a?(Class)
    
    if extensions.empty?
      mappings.each do |ext, engines|
        @preferred_engines[ext] = engine if engines.include?(engine)
      end
    else
      register(engine, *extensions)
      extensions.each do |ext|
        ext = normalize(ext)
        @preferred_engines[ext] = engine
      end
    end
  end
  
  # Looks for a compression engine. When given a Symbol, it will look for an engine
  # by name. When given a String, it will look for a compression engine by filename
  # or file extension.
  def self.[](path_or_name)
    path_or_name.is_a?(Symbol) ? find_by_name(path_or_name) : find_by_path(path_or_name)
  end
  
  # Create a new compression engine. The first argument is used to determine
  # which engine to use. This can be either an engine name (as a Symbol) or a path
  # to a file (as a String). If a path is given, the engine is initialized with
  # a reference to that path.
  def self.new(path_or_name, options = {}, &block)
    if engine = self[path_or_name]
      path = path_or_name.is_a?(Symbol) ? nil : path_or_name
      engine.new(path, options, &block)
    else
      raise EngineNotFound.new("No compression engine registered for '#{path}'")
    end
  end
  
  # Look for a compression engine with the given engine name.
  # Return nil when no engine is found.
  def self.find_by_name(engine_name)
    mappings.values.flatten.detect { |engine| engine.engine_name == engine_name.to_s }
  end
  
  # Look for a compression engine for the given filename or file
  # extension. Return nil when no engine is found.
  def self.find_by_path(path)
    pattern = File.basename(path.to_s).downcase
    until pattern.empty? || registered?(pattern)
      pattern.sub! /^[^.]*\.?/, ""
    end
    pattern = normalize(pattern)
    
    preferred_engine = @preferred_engines[pattern]
    return preferred_engine unless preferred_engine.nil?
    
    mappings[pattern].detect(&:engine_initialized?) || mappings[pattern].first
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
