# Going Rogue with Metamodern Perl

## Getting Started

On OSX you need install with homebrew and App::cpm:

```perl
    brew install raylib
    PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig" cpm install
```

On other systems the installation dance is left as a lemma for the reader.
Alien::raylib currently will build an older version of Raylib so you need to
use a system library, or a patched version of Alien::raylib.
