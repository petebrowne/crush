Crush
=====

Crush is a generic interface, like Tilt, for the various compression engines in Ruby.
It is useful for asset libraries that support multiple javascript and stylesheet compression engines.

Basic Usage
-----------

```ruby
require "uglifier"
require "crush"
Crush.new("application.js").compress
```

This would automatically compress the data found in the `application.js` file using Uglifier.
Crush favors engines whose libraries have already been loaded.

If you have multiple compression libraries loaded, and you want to control which one to use,
you can initialize the engine directly.

```ruby
require "uglifier"
require "jsmin"
require "crush"
Crush::Uglifier.new("application.js").compress
```

Or you could use `Crush.prefer` to tell Crush which engine you'd like to use.

```ruby
require "uglifier"
require "jsmin"
require "crush"
Crush.prefer(Crush::Uglifier) # or Crush.prefer(:uglifier)
Crush.new("application.js").compress
```

API
---

There a few different ways to compress some data. The API, for the most part, follows the Tilt
API. So this is the standard way of compressing (reading the data from the file):

```ruby
Crush.new("file.js", :mangle => true).compress
```

You can also pass the data using a block, like Tilt.

```ruby
Crush.new(:uglifier, :mangle => true) { "some data to compress" }.compress
```

_Note how I declared which engine to use by its name (as a Symbol)._

I've also included a way to pass data that is more consistent with the other compression engines:

```ruby
Crush.new(:uglifier, :mangle => true).compress("some data to compress")
```

Engines
-------

Support fo these compression engines are included:

    ENGINES                    FILE EXTENSIONS    REQUIRED LIBRARIES
    -------------------------- ------------------ ------------------
    JSMin                      .js,  .min.js      jsmin
    Packr                      .js,  .pack.js     packr
    YUI::JavaScriptCompressor  .js,  .yui.js      yui/compressor
    Closure::Compiler          .js,  .closure.js  closure-compiler
    Uglifier                   .js,  .ugly.js     uglifier
    CSSMin                     .css, .min.css     cssmin
    Rainpress                  .css, .rain.css    rainpress
    YUI::CssCompressor         .css, .yui.css     yui/compressor    

Copyright
---------

Copyright (c) 2011 [Peter Browne](http://petebrowne.com). See LICENSE for details.
