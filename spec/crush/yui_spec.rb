require "spec_helper"
require "yui/compressor"

describe Crush::YUI::JavaScriptCompressor do
  specify { Crush::YUI::JavaScriptCompressor.engine_name.should == "yui_js" }
  
  it "is registered for '.js' files" do
    Crush.mappings["js"].should include(Crush::YUI::JavaScriptCompressor)
  end
  
  it "minifies using YUI::JavaScriptCompressor" do
    compressor = mock(:compressor)
    ::YUI::JavaScriptCompressor.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::JavaScriptCompressor.new.compress("hello").should == "world"
  end
  
  it "sends options to YUI::JavaScriptCompressor" do
    compressor = mock(:compressor)
    ::YUI::JavaScriptCompressor.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::JavaScriptCompressor.new(:foo => "bar").compress("hello")
  end
end

describe Crush::YUI::CssCompressor do
  specify { Crush::YUI::CssCompressor.engine_name.should == "yui_css" }
  
  it "is registered for '.js' files" do
    Crush.mappings["css"].should include(Crush::YUI::CssCompressor)
  end
  
  it "minifies using YUI::CssCompressor" do
    compressor = mock(:compressor)
    ::YUI::CssCompressor.should_receive(:new).with({}).and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::CssCompressor.new.compress("hello").should == "world"
  end
  
  it "sends options to YUI::CssCompressor" do
    compressor = mock(:compressor)
    ::YUI::CssCompressor.should_receive(:new).with(:foo => "bar").and_return(compressor)
    compressor.should_receive(:compress).with("hello").and_return("world")
    Crush::YUI::CssCompressor.new(:foo => "bar").compress("hello")
  end
end