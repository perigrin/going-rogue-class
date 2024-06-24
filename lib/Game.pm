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

    field $map = Map->new;

    field $player = Entity->new(
        location => $map->entrance,
        size     => $size,
    );

    field @actions;
    field $key_map = {
        KEY_UP()    => sub { push @actions => MoveAction->new( dy => -$size ) },
        KEY_DOWN()  => sub { push @actions => MoveAction->new( dy => $size ) },
        KEY_LEFT()  => sub { push @actions => MoveAction->new( dx => -$size ) },
        KEY_RIGHT() => sub { push @actions => MoveAction->new( dx => $size ) },
    };

    field $keyboard = Raylib::Keyboard->new( key_map => $key_map );

    method update() {
        $_->execute( $player, $map ) for @actions;
        @actions = ();
    }

    method render() {
        $app->clear();
        $app->draw_objects( $map, $player );
    }

    method run() {
        while ( !$app->exiting ) {
            $keyboard->handle_events();    # process input
            $self->update();
            $self->render();
        }
    }
}
