require "tilt"

module Crush
  # Crush::Engine is an abstract class like Tilt::Template,
  # which adds methods common to compression library APIs.
  class Engine < Tilt::Template
    class << self
      # Convenience method of initializing an
      # engine and immediately compressing the given
      # data.
      #
      # @param String data The data to compress.
      # @param Hash options Options to pass to the 
      #   underlying compressor.
      # @return String the compressed data.
      def compress(data, options = {})
        self.new(options).compress(data)
      end
      alias :compile :compress
    end
    
    # Override Tilt::Template#initialize so that it
    # does not require a file or block. This is done
    # so that Crush::Engines can follow the usual
    # compressor API convention of having an instance
    # method, #compress, which accepts the data to
    # compress as an argument.
    #
    # @see Tilt::Template#initialize
    def initialize(file = nil, *args, &block)
      unless block_given? or args[0].respond_to?(:to_str)
        block = lambda { "" }
      end
      super file, *args, &block
    end
    
    # Compresses the given data.
    #
    # @param String data The data to compress.
    # @return String the compressed data.
    def compress(data)
      @data = data.to_s
      render
    end
    alias :compile :compress
    
    protected
    
    # Crush::Engines are usually very, very simple.
    # There's no need for them to be required to
    # implement #prepare.
    def prepare
    end
  end
end
