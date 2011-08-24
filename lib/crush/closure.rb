require "crush/engine"

module Crush
  module Closure
    # Engine implementation of Google's Closure Compiler,
    # using the closure-compiler gem. See:
    #
    # https://rubygems.org/gems/closure-compiler
    class Compiler < Crush::Engine
      self.default_mime_type = "application/javascript"
      
      def self.engine_initialized?
        !!(defined? ::Closure && defined? ::Closure::Compiler)
      end
    
      def initialize_engine
        require_template_library "closure-compiler"
      end
    
      def prepare
        @engine = ::Closure::Compiler.new(options)
        @output = nil
      end
    
      def evaluate(scope, locals, &block)
        @output ||= @engine.compile(data)
      end
    end
  end
end
