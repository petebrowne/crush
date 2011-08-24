require "spec_helper"
require "rainpress"

describe Crush::Rainpress do
  specify { Crush::Rainpress.default_mime_type.should == "text/css" }
  
  it "compresses using Rainpress" do
    ::Rainpress.should_receive(:compress).with("hello", {}).and_return("world")
    Crush::Rainpress.compress("hello").should == "world"
  end
  
  it "sends options to Rainpress" do
    ::Rainpress.should_receive(:compress).with("hello", :foo => "bar")
    Crush::Rainpress.new(:foo => "bar").compress("hello")
  end
  
  it "is registered with Tilt" do
    ::Rainpress.should_receive(:compress).with("hello", {}).and_return("world")
    Tilt.prefer Crush::Rainpress
    Tilt.new("application.css").compress("hello").should == "world"
  end
end
