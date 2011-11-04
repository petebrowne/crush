Crush
=====

Crush is a set of Tilt templates for the various JavaScript and CSS compression libraries in Ruby.

See here for more information about Tilt templates: [http://github.com/rtomayko/tilt](https://github.com/rtomayko/tilt)

Well, they're not really templates. They're more like engines or processors. But, anyway, they fit
in very well with Tilt, because each one likes to do things a little differently. Tilt + Crush cures
the headache by providing a generic API to use any of the engines you need.

Basic Usage
-----------

Step 1, Install:

``` bash
$ gem install crush
```

Step 2, Compress:

``` ruby
require "crush"
Crush.register
Tilt.new("application.js").render
# => compressed JavaScript...
```

Tilt Mappings
-------------

If you look closely at the above example, you had to call `Crush.register` before you could
use any of the engines. That's because, by default, Crush does not automatically register
its templates with Tilt. But, fear not, it's insanely easy to register them.

``` ruby
require "crush"
Crush.register
# or you can use this shortcut to do the same thing:
require "crush/all"
```

If you only want to use the JavaScript templates:

``` ruby
require "crush"
Crush.register_js
# or just:
require "crush/js"
```

CSS engines only:

``` ruby
require "crush"
Crush.register_css
# or, because I love shortcuts so much:
require "crush/css"
```

And finally, it's not hard to register only the ones you need, manually:

``` ruby
require "crush"
Tilt.register Crush::Uglifier, "js"
Tilt.register Crush::Rainpress, "css"
```

Generic API
-----------

The included templates are actually subclasses of `Crush::Engine`, which adds a few
methods somewhat common to compression libraries.

`Crush::Engine.compress` takes the given string and immediately compresses it. It is also
aliased as `compile`.

``` ruby
Crush::CSSMin.compress "body { color: red; }"
# => "body{color:red;}"

# Using Tilt's interface:
Tilt[:css].compress "body { color: red; }"
# => "body{color:red;}"
```

`Crush::Engine`s do not require data from a file or block like `Tilt::Template`s. They can
be initialized and given data through the `Crush::Engine#compress` instance method, which
is also aliased as `compile`.

``` ruby
engine = Crush::CSSMin.new
# Does not throw an ArgumentError like a Tilt::Template
engine.compress "body { color: red; }"
# => "body{color:red;}"
```

Included Engines
----------------

Support fo these compression engines are included:

    ENGINES                    FILE_EXTENSIONS  REQUIRED LIBRARIES
    -------------------------- ---------------- -----------------------
    JSMin                      .js              jsmin
    Packr                      .js              packr
    YUI::JavaScriptCompressor  .js              yui/compressor
    Closure::Compiler          .js              closure-compiler
    Uglifier                   .js              uglifier
    CSSMin                     .css             cssmin
    Rainpress                  .css             rainpress
    YUI::CssCompressor         .css             yui/compressor
    Sass::Engine               .css             sass

Copyright
---------

Copyright (c) 2011 [Peter Browne](http://petebrowne.com). See LICENSE for details.
