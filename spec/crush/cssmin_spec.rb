require "spec_helper"
require "cssmin"

describe Crush::CSSMin do
  specify { Crush::CSSMin.engine_name.should == "cssmin" }
  
  it "is registered for '.js' files" do
    Crush.mappings["css"].should include(Crush::CSSMin)
  end
  
  it "minifies using CSSMin" do
    ::CSSMin.should_receive(:minify).with("hello").and_return("world")
    Crush::CSSMin.new.compress("hello").should == "world"
  end
end
