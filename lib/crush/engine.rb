module Crush
  class Engine
    # The name of the file to be compressed
    attr_reader :file
    
    # A Hash of compression engine specific options. This is passed directly
    # to the underlying engine and is not used by the generic interface.
    attr_reader :options
    
    # The data to cmopress; loaded from a file or given directly.
    attr_reader :data
    
    # Create a new engine with the file and options specified. By
    # default, the data to compress is read from the file. When a block is given,
    # it should read data and return as a String.
    #
    # All arguments are optional.
    def initialize(file = nil, options = {})
      @file    = file
      @options = options
      
      @data = if block_given?
        yield
      elsif file
        File.respond_to?(:binread) ? File.binread(file) : File.read(file)
      end
    end
  end
end
