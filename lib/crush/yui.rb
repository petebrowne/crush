module Crush
  module YUI
    class JavaScriptCompressor < Crush::Engine
      def self.engine_initialized?
        !!(defined? ::YUI) && !!(defined? ::YUI::JavaScriptCompressor)
      end
    
      def initialize_engine
        require_template_library "yui/compressor"
      end
    
      def prepare
        @engine = ::YUI::JavaScriptCompressor.new(options)
      end
    
      def evaluate
        @engine.compile(data)
      end
    end
  end
end
