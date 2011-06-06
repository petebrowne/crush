require "spec_helper"
require "packr"

describe Crush::Packr do
  specify { Crush::Packr.engine_name.should == "packr" }
  
  it "is registered for '.js' files" do
    Crush.mappings["js"].should include(Crush::Packr)
  end
  
  it "minifies using Packr" do
    ::Packr.should_receive(:pack).with("hello", {}).and_return("world")
    Crush::Packr.new.compress("hello").should == "world"
  end
  
  it "sends options to Packr" do
    ::Packr.should_receive(:pack).with("hello", :foo => "bar")
    Crush::Packr.new(:foo => "bar").compress("hello")
  end
end
