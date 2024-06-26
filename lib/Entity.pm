use 5.40.0;
use experimental 'class';

use Raylib::App;

class Entity {
    field $size : param;
    field $location : param;
    field $icon : param = '@';

    field $glyph = Raylib::Text->new(
        text  => $icon,
        color => Raylib::Color::GREEN,
        size  => $size,
    );

    field $hp : param       = 10;
    field $armor : param    = 6;
    field $strength : param = 10;

    method armor()    { $armor }
    method strength() { $strength }

    method update_hp($delta) {
        $hp += $delta;
    }

    method location() { $location->@* }

    method move ( $dx, $dy ) {
        $location->[0] += $dx;
        $location->[1] += $dy;
    }

    method draw () { $glyph->draw( $location->@* ) }

}

