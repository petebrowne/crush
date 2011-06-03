module Crush
  extend self
  
  # Look for a compressor engine for the given filename or file
  # extension. Return nil when no engine is found.
  def [](path)
    pattern = File.basename(path.to_s).downcase
    until pattern.empty? || registered?(pattern)
      pattern.sub!(/^[^.]*\.?/, "")
    end
    
    pattern = normalize(pattern)
    mappings[pattern].first
  end
  
  # Hash of registered compression engines.
  def mappings
    @mappings ||= Hash.new { |h, k| h[k] = [] }
  end
  
  # Ensures the extension doesn't include the "."
  def normalize(ext)
    ext.to_s.downcase.sub(/^\./, '')
  end
  
  # Make the given compression engine preferred. Which means,
  # it will reordered the beginning of its mapping.
  def prefer(engine)
    mappings.each do |ext, engines|
      if engines.include?(engine)
        engines.delete(engine)
        engines.unshift(engine)
      end
    end
  end
  
  # Registers a compression engine for the given file extension(s).
  def register(engine, *extensions)
    extensions.each do |ext|
      ext = normalize(ext)
      mappings[ext].unshift(engine).uniq!
    end
  end
  
  # Returns true when an engine exists for the given file extension.
  def registered?(ext)
    ext = normalize(ext)
    mappings.key?(ext) && !mappings[ext].empty?
  end
end
