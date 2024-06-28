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

### Ubuntu
```
# Install perlbrew
curl -L https://install.perlbrew.pl | bash
 
# Initialize
perlbrew init
 
# See what is available
perlbrew available
 
# Install some Perls
perlbrew install 5.40.0

# Switch to perl 5.40.0
perlbrew switch 5.40.0

# Install Alien::RayLib
sudo apt-get install -y libasound2-dev \
            libxcursor-dev libxinerama-dev mesa-common-dev \
            libx11-dev libxrandr-dev libxi-dev \
            libgl1-mesa-dev libglu1-mesa-dev
git clone https://github.com/perigrin/Alien-raylib5
cd Alien-raylib5
cpanm Alien::raylib # To pull Alien raylib dependences
perl Makefile.PL
make install

# Game installatiom
git clone https://github.com/perigrin/going-rogue-class
cd going-rogue-class
cpanm Raylib::FFI
perl bin/game.pl
```

