require "crush/engine"

module Crush
  module Sass
    # Engine implementation of the Sass::Engine
    # CSS compressor. See:
    #
    # https://rubygems.org/gems/sass
    class Engine < Crush::Engine
      self.default_mime_type = "text/css"
      
      DEFAULT_OPTIONS = {
        :style  => :compressed,
        :syntax => :scss
      }
        
      def self.engine_initialized?
        !!(defined?(::Sass) && defined?(::Sass::Engine))
      end
      
      def initialize_engine
        require_template_library "sass"
      end
      
      def prepare
        @engine = ::Sass::Engine.new DEFAULT_OPTIONS.dup.merge(options)
        @output = nil
      end
      
      def evaluate(scope, locals, &block)
        @output ||= @engine.render(data)
      end
    end
  end
end
