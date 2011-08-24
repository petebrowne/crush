require "crush/engine"

module Crush
  # Engine implementation of the UglifyJS
  # JavaScript compressor. See:
  #
  # https://rubygems.org/gems/rainpress
  class Uglifier < Engine
    self.default_mime_type = "application/javascript"
      
    def self.engine_initialized?
      !!(defined? ::Uglifier)
    end
    
    def initialize_engine
      require_template_library "uglifier"
    end
    
    def prepare
      @engine = ::Uglifier.new(options)
      @output = nil
    end
    
    def evaluate(scope, locals, &block)
      @output ||= @engine.compile(data)
    end
  end
end
