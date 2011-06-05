module Crush
  class Rainpress < Engine
    def self.engine_initialized?
      !!(defined? ::Rainpress)
    end
    
    def initialize_engine
      require_template_library "rainpress"
    end
    
    def evaluate
      ::Rainpress.compress(data, options)
    end
  end
end
