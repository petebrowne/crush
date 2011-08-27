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
      # @param [String] data The data to compress.
      # @param [Hash] options Options to pass to the 
      #   underlying compressor.
      # @return [String] the compressed data.
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
    # (see Tilt::Template#initialize)
    def initialize(file = nil, *args, &block)
      unless block_given? or args[0].respond_to?(:to_str)
        block = Proc.new {}
      end
      super file, *args, &block
    end
    
    # Compresses the given data.
    #
    # @param [String] data The data to compress.
    # @return [String] the compressed data.
    def compress(data = nil)
      @data = data.to_s unless data.nil?
      render
    end
    alias :compile :compress
    
    # Override Tilt::Template#render to check for
    # data and raise an error if there isn't any.
    #
    # (see Tilt::Template#render)
    def render(*args)
      raise ArgumentError, "data must be set before rendering" if @data.nil?
      super
    end
    
    protected
    
    # Crush::Engines are usually very, very simple.
    # There's no need for them to be required to
    # implement #prepare.
    def prepare
    end
  end
end
