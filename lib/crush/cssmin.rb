module Crush
  class CSSMin < Engine
    def self.engine_name
      "cssmin"
    end
      
    def self.engine_initialized?
      !!(defined? ::CSSMin)
    end
    
    def initialize_engine
      require_template_library "cssmin"
    end
    
    def evaluate
      ::CSSMin.minify(data)
    end
  end
end
