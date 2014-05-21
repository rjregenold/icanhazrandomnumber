# icanhazrandomnumber.com

An online random number generator of the highest order.

## Features

Supports amazing query parameters like:

### min

The lower bounds for that pseudorandom goodness.

_The default is 0._

#### Examples

[http://icanhazrandomnumber.com?min=50](http://icanhazrandomnumber.com?min=50)

[http://icanhazrandomnumber.com?min=-10000](http://icanhazrandomnumber.com?min=-10000)

### max

You guessed it: the upper bounds for which a pseudorandom integer shall not
surpass.

_The default is 99999999999._

#### Examples

[http://icanhazrandomnumber.com?max=50](http://icanhazrandomnumber.com?max=50)

[http://icanhazrandomnumber.com?max=10000](http://icanhazrandomnumber.com?max=10000)

### fmt

It gets crazy here. This online random number generator even lets you specify
formats (ok, _format_ really, as `usd` is the only one).

_The default is just a plain 'ol regular integer._

#### Examples

[http://icanhazrandomnumber.com?fmt=usd](http://icanhazrandomnumber.com?fmt=usd)

### THEY CAN COMPOSE

As you may have guessed, these magical features are composable. You need
a random USD between $1,000 and $5,000? Why? But seriously, all you have to do
is this:

[http://icanhazrandomnumber.com?min=1000&max=5000&fmt=usd](http://icanhazrandomnumber.com?min=1000&max=5000&fmt=usd)

So many different combinations available that even math can't figure it out.

## Pourquoi, mon ami?

This was all really just done as an excuse to play with more Haskell and to
check out some of the cool things
[scotty](http://hackage.haskell.org/package/scotty) has going on.
