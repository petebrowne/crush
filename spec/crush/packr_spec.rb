require "spec_helper"

describe Crush::Packr do
  specify { Crush::Packr.default_mime_type.should == "application/javascript" }
  
  it "compresses using Packr" do
    ::Packr.should_receive(:pack).with("hello", {}).and_return("world")
    Crush::Packr.compress("hello").should == "world"
  end
  
  it "is registered with Tilt" do
    ::Packr.should_receive(:pack).with("hello", {}).and_return("world")
    Tilt.register Crush::Packr, "js"
    Tilt.new("application.js").compress("hello").should == "world"
  end
end
