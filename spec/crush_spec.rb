require "spec_helper"

describe Crush do
  class MockCompressor
    def self.engine_initialized?
      true
    end
    
    attr_reader :args, :block
    def initialize(*args, &block)
      @args = args
      @block = block
    end
  end
  
  class MockCompressor2 < MockCompressor
    def self.engine_initialized?
      false
    end
  end
  
  before(:all) do
    Crush.register(MockCompressor,  "mock", ".mck", "file.txt")
    Crush.register(MockCompressor,  "mult")
    Crush.register(MockCompressor2, "mult")
  end
  
  describe ".mappings" do
    it "always returns an array" do
      Crush.mappings["none"].should == []
    end
  end
  
  describe ".register" do
    it "stores engines" do
      Crush.mappings["mock"].should include(MockCompressor)
      Crush.mappings["mck"].should include(MockCompressor)
      Crush.mappings["file.txt"].should include(MockCompressor)
    end
    
    it "prefers the latest registered engines" do
      Crush.mappings["mult"].first.should == MockCompressor2
    end
  end
  
  describe ".registered?" do
    it "returns false if the extension is not registered" do
      Crush.registered?("none").should be_false
    end
    
    it "returns true if the given extension is registered" do
      Crush.registered?("mock").should be_true
      Crush.registered?(".mock").should be_true
    end
  end
  
  describe ".[]" do
    it "returns nil when no engines are found" do
      Crush["none"].should be_nil
    end
    
    it "returns engines matching exact extension names" do
      Crush["mock"].should == MockCompressor
    end
    
    it "returns engines matching exact file extensions" do
      Crush[".MOCK"].should == MockCompressor
    end
    
    it "returns engines matching multiple file extensions" do
      Crush["application.js.Mock"].should == MockCompressor
    end
    
    it "returns engines matching filenames" do
      Crush["some/path/file.txt"].should == MockCompressor
    end
    
    it "returns engines that are already initialized" do
      Crush["mult"].should == MockCompressor
    end
  end
  
  describe ".prefer" do
    it "reorders the engine mappings so the given engine is returned" do
      Crush.prefer(MockCompressor)
      Crush["mult"].should == MockCompressor
    end
  end
  
  describe ".new" do
    it "creates a new engine if found" do
      compressor = Crush.new("application.mock", :key => "value") { "Hello World" }
      compressor.args.should =~ [ "application.mock", { :key => "value" } ]
      compressor.block.call.should == "Hello World"
    end
    
    it "raises an error if no engine is found" do
      expect { Crush.new("file.php") }.to raise_error(Crush::EngineNotFound)
    end
  end
end
