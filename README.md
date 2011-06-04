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
Crush.prefer(Crush::Uglifier)
Crush.new("application.js").compress
```

Copyright
---------

Copyright (c) 2011 [Peter Browne](http://petebrowne.com). See LICENSE for details.
