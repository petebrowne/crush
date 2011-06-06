require "spec_helper"
require "uglifier"

describe Crush::Uglifier do
  specify { Crush::Uglifier.engine_name.should == "uglifier" }
  
  it "is registered for '.js' files" do
    Crush.mappings["js"].should include(Crush::Uglifier)
  end
  
  it "minifies using Uglifier" do
    compressor = mock(:compressor)
    ::Uglifier.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Uglifier.new.compress("hello").should == "world"
  end
  
  it "sends options to Uglifier" do
    compressor = mock(:compressor)
    ::Uglifier.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compile).with("hello").and_return("world")
    Crush::Uglifier.new(:foo => "bar").compress("hello")
  end
end
