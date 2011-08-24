require "crush/engine"

module Crush
  # Engine implementation of Douglas Crockford's
  # JSMin JavaScript minifier. See:
  #
  # https://rubygems.org/gems/jsmin
  class JSMin < Engine
    self.default_mime_type = "application/javascript"
    
    def self.engine_initialized?
      !!(defined? ::JSMin)
    end
    
    def initialize_engine
      require_template_library "jsmin"
    end
    
    def prepare
      @output = nil
    end
    
    def evaluate(scope, locals, &block)
      @output ||= ::JSMin.minify(data)
    end
  end
end
