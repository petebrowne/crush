require "spec_helper"

describe Crush do
  describe ".register_js" do
    it "registers all of the JavaScript engines with Tilt" do
      Tilt.mappings.delete "js"
      Crush.register_js
      Tilt.mappings["js"].should == [
        Crush::Uglifier,
        Crush::Closure::Compiler,
        Crush::YUI::JavaScriptCompressor,
        Crush::Packr,
        Crush::JSMin
      ]
    end
  end
  
  describe ".register_css" do
    it "registers all of the CSS engines with Tilt" do
      Tilt.mappings.delete "css"
      Crush.register_css
      Tilt.mappings["css"].should == [
        Crush::Sass::Engine,
        Crush::YUI::CssCompressor,
        Crush::Rainpress,
        Crush::CSSMin
      ]
    end
  end
  
  describe ".register" do
    it "registers all of the engines with Tilt" do
      Tilt.mappings.delete "js"
      Tilt.mappings.delete "css"
      Crush.register
      Tilt.mappings["js"].should == [
        Crush::Uglifier,
        Crush::Closure::Compiler,
        Crush::YUI::JavaScriptCompressor,
        Crush::Packr,
        Crush::JSMin
      ]
      Tilt.mappings["css"].should == [
        Crush::Sass::Engine,
        Crush::YUI::CssCompressor,
        Crush::Rainpress,
        Crush::CSSMin
      ]
    end
  end
end
