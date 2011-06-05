module Crush
  class Packr < Engine
    def self.engine_initialized?
      !!(defined? ::Packr)
    end
    
    def initialize_engine
      require_template_library "packr"
    end
    
    def evaluate
      ::Packr.pack(data, options)
    end
  end
end
