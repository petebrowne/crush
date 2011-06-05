require "spec_helper"

describe Crush::JSMin do
  it "is registered for '.js' files" do
    Crush.mappings["js"].should include(Crush::JSMin)
  end
  
  it "minifies using JSMin" do
    ::JSMin.should_receive(:minify).with("hello").and_return("world")
    Crush::JSMin.new.compress("hello").should == "world"
  end
end
