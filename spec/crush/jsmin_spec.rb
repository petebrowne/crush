require "spec_helper"

describe Crush::JSMin do
  specify { Crush::JSMin.default_mime_type.should == "application/javascript" }
  
  it "minifies using JSMin" do
    ::JSMin.should_receive(:minify).with("hello").and_return("world")
    Crush::JSMin.compress("hello").should == "world"
  end
  
  it "is registered with Tilt" do
    ::JSMin.should_receive(:minify).with("hello").and_return("world")
    Tilt.register Crush::JSMin, "js"
    Tilt.new("application.js").compress("hello").should == "world"
  end
end
