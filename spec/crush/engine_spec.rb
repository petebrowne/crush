require "spec_helper"

describe Crush::Engine do
  class MockEngine < Crush::Engine; end
  
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
end
