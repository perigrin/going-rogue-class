use 5.40.0;
use experimental 'class';

use Raylib::App;

use Actions;
use Entities;

class Game {
    use Raylib::Keyboard;
    use Map;

    field $width : param  = 800;
    field $height : param = 600;
    field $size : param   = 10;
    field $name : param   = 'My Cool Game';

    field $app = Raylib::App->window( $width, $height, $name );

    field $map = Map->new( tile_size => $size );

    field @stuff;

    ADJUST {

        for (qw(c d f g)) {
            push @stuff => Boon->new(
                location => $map->spawn_point($_),
                icon     => 'B',
                size     => $size
            );
        }

        for (qw(e h k)) {
            push @stuff => Threat->new(
                location => $map->spawn_point($_),
                icon     => 'T',
                size     => $size
            );
        }

        for (qw(a i l)) {
            push @stuff => Obstacle->new(
                location => $map->spawn_point($_),
                icon     => 'O',
                size     => $size
            );
        }
    }

    field $player = Player->new(
        location => $map->entrance,
        size     => $size,
    );

    field @actions;
    method add_action($action) { push @actions => $action }

    field $key_map = {
        KEY_UP()    => sub { push @actions => MoveAction->new( dy => -$size ) },
        KEY_DOWN()  => sub { push @actions => MoveAction->new( dy => $size ) },
        KEY_LEFT()  => sub { push @actions => MoveAction->new( dx => -$size ) },
        KEY_RIGHT() => sub { push @actions => MoveAction->new( dx => $size ) },
    };

    field $keyboard = Raylib::Keyboard->new( key_map => $key_map );

    method entity_at( $x, $y ) {
        my ($e) =
          grep { my $l = [ $_->location ]; $l->[0] == $x && $l->[1] == $y }
          @stuff;
        return $e;
    }

    method update() {
        $_->execute( $player, $map, $self ) for @actions;
        @actions = ();
    }

    method render() {
        $app->clear();
        $app->draw_objects( $map, $player, @stuff );
    }

    method run() {
        while ( !$app->exiting ) {
            $keyboard->handle_events();    # process input
            $self->update();
            $self->render();
        }
    }
}
