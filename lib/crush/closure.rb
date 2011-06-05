module Crush
  module Closure
    class Compiler < Crush::Engine
      def self.engine_initialized?
        !!(defined? ::Closure) && !!(defined? ::Closure::Compiler)
      end
    
      def initialize_engine
        require_template_library "closure-compiler"
      end
    
      def prepare
        @engine = ::Closure::Compiler.new(options)
      end
    
      def evaluate
        @engine.compile(data)
      end
    end
  end
end
