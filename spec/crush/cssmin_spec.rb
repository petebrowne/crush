require "spec_helper"
require "cssmin"

describe Crush::CSSMin do
  specify { Crush::CSSMin.default_mime_type.should == "text/css" }
  
  it "minifies using CSSMin" do
    ::CSSMin.should_receive(:minify).with("hello").and_return("world")
    Crush::CSSMin.compress("hello").should == "world"
  end
  
  it "is registered with Tilt" do
    ::CSSMin.should_receive(:minify).with("hello").and_return("world")
    Tilt.prefer Crush::CSSMin
    Tilt.new("application.css").compress("hello").should == "world"
  end
end
