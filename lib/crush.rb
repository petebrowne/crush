require "crush/version"
require "tilt"

module Crush
  require "crush/closure"
  require "crush/cssmin"
  require "crush/jsmin"
  require "crush/packr"
  require "crush/rainpress"
  require "crush/uglifier"
  require "crush/yui"
   
  Tilt.register JSMin,                     "js"
  Tilt.register Packr,                     "js"
  Tilt.register YUI::JavaScriptCompressor, "js"
  Tilt.register Closure::Compiler,         "js"
  Tilt.register Uglifier,                  "js"
  
  Tilt.register CSSMin,                    "css"
  Tilt.register Rainpress,                 "css"
  Tilt.register YUI::CssCompressor,        "css"
end
