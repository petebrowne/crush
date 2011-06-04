module Crush
  class Engine
    # The name of the file to be compressed
    attr_reader :file
    
    # A Hash of compression engine specific options. This is passed directly
    # to the underlying engine and is not used by the generic interface.
    attr_reader :options
    
    # The data to cmopress; loaded from a file or given directly.
    attr_reader :data
    
    # Used to determine if this class's initialize_engine method has
    # been called yet.
    @engine_initialized = false
    class << self
      attr_accessor :engine_initialized
      alias :engine_initialized? :engine_initialized
    end
    
    # Create a new engine with the file and options specified. By
    # default, the data to compress is read from the file. When a block is given,
    # it should read data and return as a String.
    #
    # All arguments are optional.
    def initialize(file = nil, options = nil)
      if file.respond_to?(:to_hash)
        @options = file.to_hash
      else
        @file    = file
        @options = options || {}
      end
      
      unless self.class.engine_initialized?
        initialize_engine
        self.class.engine_initialized = true
      end
      
      @data = if block_given?
        yield
      elsif file
        File.respond_to?(:binread) ? File.binread(file) : File.read(file)
      end
      
      prepare
    end
    
    # Compresses the data. Data can be read through the file or the block
    # given at initialization, or through passing it here directly.
    def compress(data = nil)
      @data = data unless data.nil?
      evaluate
    end
    alias :compile :compress
    alias :render :compress
    
    protected
    
      # Called once and only once for each template subclass the first time
      # the engine class is initialized. This should be used to require the
      # underlying engine library and perform any initial setup.
      def initialize_engine
        
      end
      
      # Do whatever preparation is necessary to setup the underlying compression
      # engine. Called immediately after template data is loaded. Instance
      # variables set in this method are available when #compress is called.
      def prepare
        
      end
      
      # Called when it's time to compress. Return the compressed data
      # from this method.
      def evaluate
        
      end
      
      # Like Kernel::require but issues a warning urging a manual require when
      # running under a threaded environment.
      def require_template_library(name)
        if Thread.list.size > 1
          warn "WARN: crush autoloading '#{name}' in a non thread-safe way; " +
               "explicit require '#{name}' suggested."
        end
        require name
      end
  end
end
