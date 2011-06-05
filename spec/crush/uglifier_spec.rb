require "spec_helper"

describe Crush::Uglifier do
  it "is registered for '.js' files" do
    Crush.mappings["js"].should include(Crush::Uglifier)
  end
  
  it "minifies using Uglifier" do
    uglifier = mock(:uglifier)
    ::Uglifier.should_receive(:new).with({}).and_return(uglifier)
    uglifier.should_receive(:compile).with("hello").and_return("world")
    Crush::Uglifier.new.compress("hello").should == "world"
  end
  
  it "sends options to Uglifier" do
    uglifier = mock(:uglifier)
    ::Uglifier.should_receive(:new).with(:foo => "bar").and_return(uglifier)
    uglifier.should_receive(:compile).with("hello").and_return("world")
    Crush::Uglifier.new(:foo => "bar").compress("hello")
  end
end
