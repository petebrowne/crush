require "crush/version"

module Crush
  extend self
  
  autoload :Closure,   "crush/closure"
  autoload :CSSMin,    "crush/cssmin"
  autoload :Engine,    "crush/engine"
  autoload :JSMin,     "crush/jsmin"
  autoload :Packr,     "crush/packr"
  autoload :Rainpress, "crush/rainpress"
  autoload :Uglifier,  "crush/uglifier"
  autoload :YUI,       "crush/yui"
  
  # Registers all of the JavaScripts engines
  # with Tilt in the following order of importance:
  #
  # 1. Crush::Uglifer
  # 2. Crush::Closure::Compiler
  # 3. Crush::YUI::JavaScriptCompressor
  # 4. Crush::Packr
  # 5. Crush::JSMin
  def register_js
    Tilt.register JSMin,                     "js"
    Tilt.register Packr,                     "js"
    Tilt.register YUI::JavaScriptCompressor, "js"
    Tilt.register Closure::Compiler,         "js"
    Tilt.register Uglifier,                  "js"
  end
  
  # Registers all of the CSS engines
  # with Tilt in the following order of importance:
  #
  # 3. Crush::CSSMin
  # 4. Crush::Rainpress
  # 5. Crush::YUI::CssCompressor
  def register_css
    Tilt.register CSSMin,             "css"
    Tilt.register Rainpress,          "css"
    Tilt.register YUI::CssCompressor, "css"
  end
  
  # Registers all of the included engines
  # with Tilt.
  #
  # (see #register_js)
  # (see #register_css)
  def register
    register_js
    register_css
  end
  alias :register_all :register
end
