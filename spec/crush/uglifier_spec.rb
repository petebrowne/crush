require "spec_helper"
require "uglifier"

describe Crush::Uglifier do
  specify { Crush::Uglifier.default_mime_type.should == "application/javascript" }
  
  it "compresses using Uglifier" do
    compressor = mock(:compressor)
    ::Uglifier.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Uglifier.compress("hello").should == "world"
  end
  
  it "sends options to Uglifier" do
    compressor = mock(:compressor)
    ::Uglifier.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Uglifier.new(:foo => "bar").compress("hello")
  end
  
  it "is registered with Tilt" do
    compressor = mock(:compressor)
    ::Uglifier.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Tilt.prefer Crush::Uglifier
    Tilt.new("application.js").compress("hello").should == "world"
  end
end
