Crush
=====

Crush is a set of Tilt templates for the various JavaScript and CSS compression libraries in Ruby.


Basic Usage
-----------

```ruby
require "crush"
Tilt.register Crush::Uglifier, "js"
Tilt.new("application.js").render
# => compressed JavaScript...
```

API
---

The included templates are actually subclasses of `Crush::Engine`, which adds a few
methods common to compression libraries.

`Crush::Engine.compress` takes the given string and immediately compresses it. It is also
aliased as `compile`.

```ruby
Crush::CSSMin.compress "body { color: red; }"
# => "body{color:red;}"

# Using Tilt's interface:
Tilt[:css].compress "body { color: red; }"
# => "body{color:red;}"
```

`Crush::Engine`s do not require data from a file or block like `Tilt::Template`s. They can
be initialized and given data through the `Crush::Engine#compress` instance method, which
is also aliased as `compile`.

```ruby
engine = Crush::CSSMin.new
# Does not through an ArgumentError like a Tilt::Template
engine.compress "body { color: red; }"
# => "body{color:red;}"
```

Engines
-------

Support fo these compression engines are included:

    ENGINES                    EXTENSIONS  REQUIRED LIBRARIES
    -------------------------- ----------- -----------------------
    JSMin                      .js         jsmin
    Packr                      .js         packr
    YUI::JavaScriptCompressor  .js         yui/compressor
    Closure::Compiler          .js         closure-compiler
    Uglifier                   .js         uglifier
    CSSMin                     .css        cssmin
    Rainpress                  .css        rainpress
    YUI::CssCompressor         .css        yui/compressor    

Copyright
---------

Copyright (c) 2011 [Peter Browne](http://petebrowne.com). See LICENSE for details.
