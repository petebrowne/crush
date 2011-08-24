require "crush/engine"

module Crush
  module YUI
    # Engine implementation the YUI JavaScript
    # compressor. See:
    #
    # https://rubygems.org/gems/yui-compressor
    class JavaScriptCompressor < Crush::Engine
      self.default_mime_type = "application/javascript"
      
      def self.engine_initialized?
        !!(defined? ::YUI && defined? ::YUI::JavaScriptCompressor)
      end
    
      def initialize_engine
        require_template_library "yui/compressor"
      end
    
      def prepare
        @engine = ::YUI::JavaScriptCompressor.new(options)
        @output = nil
      end
    
      def evaluate(scope, locals, &block)
        @output ||= @engine.compress(data)
      end
    end
    
    # Engine implementation the YUI CSS
    # compressor. See:
    #
    # https://rubygems.org/gems/yui-compressor
    class CssCompressor < Crush::Engine
      self.default_mime_type = "text/css"
      
      def self.engine_initialized?
        !!(defined? ::YUI && defined? ::YUI::CssCompressor)
      end
    
      def initialize_engine
        require_template_library "yui/compressor"
      end
    
      def prepare
        @engine = ::YUI::CssCompressor.new(options)
        @output = nil
      end
    
      def evaluate(scope, locals, &block)
        @output ||= @engine.compress(data)
      end
    end
  end
end
