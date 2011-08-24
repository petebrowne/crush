require "crush/engine"

module Crush
  # Engine implementation of Dean Edwards'
  # JavaScript compressor, Packr. See:
  #
  # https://rubygems.org/gems/packr
  class Packr < Engine
    self.default_mime_type = "application/javascript"
    
    def self.engine_initialized?
      !!(defined? ::Packr)
    end
    
    def initialize_engine
      require_template_library "packr"
    end
    
    def prepare
      @output = nil
    end
    
    def evaluate(scope, locals, &block)
      @output ||= ::Packr.pack(data, options)
    end
  end
end
