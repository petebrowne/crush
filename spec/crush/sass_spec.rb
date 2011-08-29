require "spec_helper"

describe Crush::Sass::Engine do
  specify { Crush::Sass::Engine.default_mime_type.should == "text/css" }
  
  it "compresses using Sass::Engine" do
    compressor = mock(:compressor)
    ::Sass::Engine.should_receive(:new).with(:style => :compressed, :syntax => :scss).and_return(compressor)
    compressor.should_receive(:render).with("hello").and_return("world")
    Crush::Sass::Engine.compress("hello").should == "world"
  end
  
  it "sends options to Sass::Engine" do
    compressor = mock(:compressor)
    ::Sass::Engine.should_receive(:new).with(:style => :compressed, :syntax => :scss, :foo => "bar").and_return(compressor)
    compressor.should_receive(:render).with("hello").and_return("world")
    Crush::Sass::Engine.new(:foo => "bar").compress("hello")
  end
  
  it "is registered with Tilt" do
    compressor = mock(:compressor)
    ::Sass::Engine.should_receive(:new).with(:style => :compressed, :syntax => :scss).and_return(compressor)
    compressor.should_receive(:render).with("hello").and_return("world")
    Tilt.register Crush::Sass::Engine, "css"
    Tilt.new("application.css").compress("hello").should == "world"
  end
end
