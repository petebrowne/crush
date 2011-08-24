require "crush/engine"

module Crush
  # Engine implementation of the CSS minification
  # library, CSSMin. See:
  #
  # https://rubygems.org/gems/cssmin
  class CSSMin < Engine
    self.default_mime_type = "text/css"
      
    def self.engine_initialized?
      !!(defined? ::CSSMin)
    end
    
    def initialize_engine
      require_template_library "cssmin"
    end
    
    def prepare
      @output = nil
    end
    
    def evaluate(scope, locals, &block)
      @output ||= ::CSSMin.minify(data)
    end
  end
end
