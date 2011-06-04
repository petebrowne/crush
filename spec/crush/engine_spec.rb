require "spec_helper"

describe Crush::Engine do
  class MockEngine < Crush::Engine
  end
  
  describe "#file" do
    it "returns the file the engine was initialized with" do
      engine = MockEngine.new("application.js") {}
      engine.file.should == "application.js"
    end
  end
  
  describe "#options" do
    it "returns the options passed to the engine" do
      engine = MockEngine.new(nil, :foo => "bar") {}
      engine.options[:foo].should == "bar"
    end
  end
  
  describe "#data" do
    it "returns the data from the file" do
      File.stub(:binread => "Hello", :read => "Hello")
      engine = MockEngine.new("application.js")
      engine.data.should == "Hello"
    end
    
    it "returns the data from the given block" do
      engine = MockEngine.new("application.js") { "Hello" }
      engine.data.should == "Hello"
    end
  end
  
  class InitializingMockEngine < Crush::Engine
    class << self
      attr_accessor :initialized_count
    end

    def initialize_engine
      self.class.initialized_count += 1
    end
  end
  
  describe "#initialize_engine" do
    it "is called one time to require the library" do
      InitializingMockEngine.initialized_count = 0
      InitializingMockEngine.new
      InitializingMockEngine.initialized_count.should == 1
      InitializingMockEngine.new
      InitializingMockEngine.initialized_count.should == 1
    end
  end
  
  class InitializedMockEngine < Crush::Engine
  end
  
  describe ".engine_initialized?" do
    it "returns false before the engine has been initialized" do
      InitializedMockEngine.engine_initialized?.should be_false
    end
    
    it "returns true once the engine has been initialized" do
      InitializedMockEngine.new
      InitializedMockEngine.engine_initialized?.should be_true
    end
  end
  
  class PreparingMockEngine < Crush::Engine
    class << self
      attr_accessor :prepared_count
    end
    
    def prepare
      self.class.prepared_count += 1
    end
  end
  
  describe "#prepare" do
    it "is called each time an engine is created" do
      PreparingMockEngine.prepared_count = 0
      PreparingMockEngine.new
      PreparingMockEngine.prepared_count.should == 1
      PreparingMockEngine.new
      PreparingMockEngine.prepared_count.should == 2
    end
  end
  
  class SimpleMockEngine < Crush::Engine
    def evaluate
      @data.strip
    end
  end
  
  describe "#compress" do
    it "compresses the data using the engine" do
      File.stub(:binread => "  hello  ", :read => "  hello  ")
      SimpleMockEngine.new("file.txt").compile.should == "hello"
      SimpleMockEngine.new { "  hello  " }.render.should == "hello"
      SimpleMockEngine.new.compress("  hello  ").should == "hello"
    end
  end
end
