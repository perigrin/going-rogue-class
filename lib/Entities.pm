use 5.40.0;
use experimental 'class';

use Raylib::App;

class Entity {
    field $size : param;
    field $location : param;

    field $glyph = Raylib::Text->new(
        text  => '@',
        color => Raylib::Color::GREEN,
        size  => $size,
    );

    method move ( $dx, $dy ) {
        $location->[0] += $dx;
        $location->[1] += $dy;
    }

    method draw () { $glyph->draw( $location->@* ) }
}

