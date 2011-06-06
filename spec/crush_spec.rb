require "spec_helper"

describe Crush do
  class MockCompressor
    def self.engine_name
      "mock"
    end
    
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
    def self.engine_name
      "mock2"
    end
    
    def self.engine_initialized?
      false
    end
  end
  
  before(:all) do
    Crush.register(MockCompressor,  "mock", ".mck", "file.txt")
    Crush.register(MockCompressor,  "mult", "mlt")
    Crush.register(MockCompressor2, "mult", "mlt")
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
    it "returns engines found by path when given strings" do
      Crush["mock"].should == MockCompressor
      Crush["application.js.mock"].should == MockCompressor
      Crush["some/path/file.txt"].should == MockCompressor
    end
    
    it "returns engines found by name when given symbols" do
      Crush[:mock].should == MockCompressor
      Crush[:mock2].should == MockCompressor2
    end
  end
  
  describe ".prefer" do
    it "reorders the engine engines so the given engine is returned" do
      Crush.prefer(MockCompressor)
      Crush["mult"].should == MockCompressor
    end
    
    it "accepts symbol names of the various engines" do
      Crush.prefer(:mock2)
      Crush["mult"].should == MockCompressor2
    end
    
    it "limits the preference to the given extensions" do
      Crush.prefer(:mock, "mlt")
      Crush["mult"].should == MockCompressor2
      Crush["mlt"].should == MockCompressor
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
  
  describe ".find_by_name" do
    it "returns nil if the engine could not be found" do
      Crush.find_by_name("none").should be_nil
    end
    
    it "returns the registered engine with the given name" do
      Crush.find_by_name("mock").should == MockCompressor
      Crush.find_by_name("mock2").should == MockCompressor2
    end
  end
  
  describe ".find_by_path" do
    it "returns nil when no engines are found" do
      Crush.find_by_path("none").should be_nil
    end
    
    it "returns engines matching exact extension names" do
      Crush.find_by_path("mock").should == MockCompressor
    end
    
    it "returns engines matching exact file extensions" do
      Crush.find_by_path(".MOCK").should == MockCompressor
    end
    
    it "returns engines matching multiple file extensions" do
      Crush.find_by_path("application.js.Mock").should == MockCompressor
    end
    
    it "returns engines matching filenames" do
      Crush.find_by_path("some/path/file.txt").should == MockCompressor
    end
    
    it "returns engines that are already initialized" do
      Crush.instance_variable_get("@preferred_engines").delete("mult")
      Crush.find_by_path("mult").should == MockCompressor
    end
  end
end
