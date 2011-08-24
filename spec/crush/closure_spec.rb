require "spec_helper"
require "closure-compiler"

describe Crush::Closure::Compiler do
  specify { Crush::Closure::Compiler.default_mime_type.should == "application/javascript" }
  
  it "compresses using Closure::Compiler" do
    compressor = mock(:compressor)
    ::Closure::Compiler.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Closure::Compiler.compress("hello").should == "world"
  end
  
  it "sends options to Closure::Compiler" do
    compressor = mock(:compressor)
    ::Closure::Compiler.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Closure::Compiler.new(:foo => "bar").compress("hello")
  end
  
  it "is registered with Tilt" do
    compressor = mock(:compressor)
    ::Closure::Compiler.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Tilt.prefer Crush::Closure::Compiler
    Tilt.new("application.js").compress("hello").should == "world"
  end
end
