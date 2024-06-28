use 5.40.0;
use experimental 'class';

use Raylib::App;

class Entity {
    field $size : param;
    field $location : param : reader;
    field $icon : param : reader;

    field $glyph = Raylib::Text->new(
        text  => $icon,
        color => Raylib::Color::GREEN,
        size  => $size,
    );

    field $components : param = {};

    method add_component($component) {
        $components->{ builtin::blessed($component) } = $component;
    }

    method remove_component($component) {
        if ( blessed($component) ) {
            $component = blessed($component);
        }
        delete $components->{$component};
    }

    method get_component($component) {
        if ( blessed($component) ) {
            $component = blessed($component);
        }
        return $components->{$component};
    }

    method reap($game) {
        for my $component ( values $components->%* ) {
            next unless $component->can('reap');
            $component->reap($game);
        }
    }

    method move ( $dx, $dy ) {
        $location->[0] += $dx;
        $location->[1] += $dy;
    }

    method draw () { $glyph->draw( $location->@* ) }
}

