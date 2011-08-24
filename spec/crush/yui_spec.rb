require "spec_helper"

describe Crush::YUI::JavaScriptCompressor do
  specify { Crush::YUI::JavaScriptCompressor.default_mime_type.should == "application/javascript" }
  
  it "compresses using YUI::JavaScriptCompressor" do
    compressor = mock(:compressor)
    ::YUI::JavaScriptCompressor.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::JavaScriptCompressor.compress("hello").should == "world"
  end
  
  it "sends options to YUI::JavaScriptCompressor" do
    compressor = mock(:compressor)
    ::YUI::JavaScriptCompressor.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::JavaScriptCompressor.new(:foo => "bar").compress("hello")
  end
  
  it "is registered with Tilt" do
    compressor = mock(:compressor)
    ::YUI::JavaScriptCompressor.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Tilt.prefer Crush::YUI::JavaScriptCompressor
    Tilt.new("application.js").compress("hello").should == "world"
  end
end

describe Crush::YUI::CssCompressor do
  specify { Crush::YUI::CssCompressor.default_mime_type.should == "text/css" }
  
  it "compresses using YUI::CssCompressor" do
    compressor = mock(:compressor)
    ::YUI::CssCompressor.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::CssCompressor.compress("hello").should == "world"
  end
  
  it "sends options to YUI::CssCompressor" do
    compressor = mock(:compressor)
    ::YUI::CssCompressor.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::CssCompressor.new(:foo => "bar").compress("hello")
  end
  
  it "is registered with Tilt" do
    compressor = mock(:compressor)
    ::YUI::CssCompressor.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Tilt.prefer Crush::YUI::CssCompressor
    Tilt.new("application.css").compress("hello").should == "world"
  end
end