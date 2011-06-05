module Crush
  class Uglifier < Engine
    def self.engine_initialized?
      !!(defined? ::Uglifier)
    end
    
    def initialize_engine
      require_template_library "uglifier"
    end
    
    def prepare
      @engine = ::Uglifier.new(options)
    end
    
    def evaluate
      @engine.compile(data)
    end
  end
end
