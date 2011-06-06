module Crush
  class JSMin < Engine
    def self.engine_name
      "jsmin"
    end
    
    def self.engine_initialized?
      !!(defined? ::JSMin)
    end
    
    def initialize_engine
      require_template_library "jsmin"
    end
    
    def evaluate
      ::JSMin.minify(data)
    end
  end
end
