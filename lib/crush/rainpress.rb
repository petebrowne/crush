require "crush/engine"

module Crush
  # Engine implementation of the CSS compressor,
  # Rainpress. See:
  #
  # https://rubygems.org/gems/rainpress
  class Rainpress < Engine
    self.default_mime_type = "text/css"
    
    def self.engine_initialized?
      !!(defined? ::Rainpress)
    end
    
    def initialize_engine
      require_template_library "rainpress"
    end
    
    def prepare
      @output = nil
    end
    
    def evaluate(scope, locals, &block)
      @output ||= ::Rainpress.compress(data, options)
    end
  end
end
