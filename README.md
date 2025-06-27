# Going Rogue with Metamodern Perl

## Getting Started

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/matthewpersico/going-rogue-class)

The codespace has noVNC installed, you can access the desktop by going to [http://localhost:6080](http://localhost:6080).

Once you have opened the desktop, right-click and open a Terminal. 

Then, to start the demo game, run `carton exec bin/game.pl`.

### On your own machine

On OSX you need install with homebrew and App::cpm:

```perl
    brew install raylib
    PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig" cpm install
```

On other systems the installation dance is left as a lemma for the reader.
Alien::raylib currently will build an older version of Raylib so you need to
use a system library, or a patched version of Alien::raylib.


### Windows 11

1. Install the latest Ubuntu distribution on WSL from the Microsoft Store. Currently it's Ubuntu 22.04.3 LTS.
2. Update the OS:
```
 sudo apt-get update
```
3. Install necessary packages:
```
sudo apt install build-essential
sudo apt-get install libssl-dev
sudo apt-get install libz-dev
sudo apt install libasound2-dev libx11-dev libxrandr-dev libxi-dev libgl1-mesa-dev libglu1-mesa-dev libxcursor-dev libxinerama-dev libwayland-dev libxkbcommon-dev
```
4. Install perlbrew:
```
curl -L https://install.perlbrew.pl | bash
```
5. Update your PATH:
```
source ~/perl5/perlbrew/etc/bashrc
```
6. Install perl 5.40.0:
```
perlbrew install 5.40.0
```
7. Start using perl 5.40.0:
```
perlbrew switch 5.40.0
```
8. Install cpanm using all the defaults:
```
cpan App::cpanminus
```
9. Install updated raylib modules:
```
cpanm https://github.com/perigrin/Alien-raylib5.git
```
10. From your HOME directory clone repo:
```
git clone https://github.com/perigrin/going-rogue-class.git
```
11. cd to the repo root directory:
```
cd going-rogue-class
```
12. install dependencies:
```
cpanm --installdeps .
```
13. Comment out the "use local::lib qw(local);" line in bin/game.pl if it exists.
14. Run the game. It should pop up an x11 window. If you see a green @ sign in the middle, you have won!
```
perl bin/game.pl
```
### Ubuntu
```
# Install perlbrew
curl -L https://install.perlbrew.pl | bash
source ~/perl5/perlbrew/etc/bashrc

# Initialize
perlbrew init

# See what is available
perlbrew available

# Install some Perls
perlbrew install 5.40.0

# Switch to perl 5.40.0
perlbrew switch 5.40.0
cpan App::cpanminus

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
