require "spec_helper"
require "rainpress"

describe Crush::Rainpress do
  it "is registered for '.js' files" do
    Crush.mappings["css"].should include(Crush::Rainpress)
  end
  
  it "minifies using Rainpress" do
    ::Rainpress.should_receive(:compress).with("hello", {}).and_return("world")
    Crush::Rainpress.new.compress("hello").should == "world"
  end
  
  it "sends options to Rainpress" do
    ::Rainpress.should_receive(:compress).with("hello", :foo => "bar")
    Crush::Rainpress.new(:foo => "bar").compress("hello")
  end
end
