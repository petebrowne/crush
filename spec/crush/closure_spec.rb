require "spec_helper"

describe Crush::Closure::Compiler do
  it "is registered for '.js' files" do
    Crush.mappings["js"].should include(Crush::Closure::Compiler)
  end
  
  it "minifies using Closure::Compiler" do
    compressor = mock(:compressor)
    ::Closure::Compiler.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Closure::Compiler.new.compress("hello").should == "world"
  end
  
  it "sends options to Closure::Compiler" do
    compressor = mock(:compressor)
    ::Closure::Compiler.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Closure::Compiler.new(:foo => "bar").compress("hello")
  end
end
