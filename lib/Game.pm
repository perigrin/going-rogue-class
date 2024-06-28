use 5.40.0;
use experimental 'class';

use Raylib::App;

class Game {
    use Raylib::Keyboard;

    use Actions;
    use Components;
    use Entities;
    use Map;

    field $width : param  = 800;
    field $height : param = 600;
    field $size : param   = 10;
    field $name : param   = 'My Cool Game';

    field $app = Raylib::App->window( $width, $height, $name );

    field $map = Map->new( tile_size => $size );

    field @entities;

    method add_entity($entity) {
        push @entities => $entity;
    }

    method remove_entity($entity) {
        @entities = grep { $_ != $entity } @entities;
        $entity->reap($self);
    }

    my $add_boon = method(%config) {
        push @entities => Entity->new(
            %config,
            icon => 'B',
            size => $size
        );
    };

    my $add_threat = method(%config) {
        push @entities => Entity->new(
            %config,
            icon       => 'T',
            size       => $size,
            components => {
                'CombatComponent' => CombatComponent->new( str => rand(4) + 1 ),
                'HealthComponent' => HealthComponent->new(),
            },
        );
    };

    my $add_obstacle = method(%config) {
        push @entities => Entity->new(
            %config,
            icon       => 'O',
            size       => $size,
            components => {
                'CombatComponent' => CombatComponent->new(),
                'HealthComponent' => HealthComponent->new()
            },
        );
    };

    ADJUST {
        for (qw(c d f g)) {
            $self->$add_boon( location => $map->spawn_point($_) );
        }

        for (qw(e h k)) {
            $self->$add_threat( location => $map->spawn_point($_) );
        }

        for (qw(a i l)) {
            $self->$add_obstacle( location => $map->spawn_point($_) );
        }
    }

    field $player = Entity->new(
        location   => $map->entrance,
        size       => $size,
        icon       => '@',
        components => {
            'InventoryComponent' => InventoryComponent->new(),
            'CombatComponent'    => CombatComponent->new(),
            'HealthComponent'    => HealthComponent->new(),
        }
    );

    field @actions;
    method add_action($action) { push @actions => $action }

    # these need to push directly because $self doesn't exist yet
    field $key_map = {
        KEY_UP()    => sub { push @actions => MoveAction->new( dy => -$size ) },
        KEY_DOWN()  => sub { push @actions => MoveAction->new( dy => $size ) },
        KEY_LEFT()  => sub { push @actions => MoveAction->new( dx => -$size ) },
        KEY_RIGHT() => sub { push @actions => MoveAction->new( dx => $size ) },
    };

    field $keyboard = Raylib::Keyboard->new( key_map => $key_map );

    method entity_at( $x, $y ) {
        my ($e) =
          grep { my $l = $_->location; $l->[0] == $x && $l->[1] == $y }
          @entities;
        return $e;
    }

    method log($message) {
        warn "$message\n";
    }

    method update() {
        while ( my $action = shift @actions ) {
            $action->execute( $player, $map, $self );
        }
    }

    method render() {
        $app->clear();
        $app->draw_objects( $map, $player, @entities );
    }

    method run() {
        while ( !$app->exiting ) {
            $keyboard->handle_events();    # process input
            $self->update();
            $self->render();
        }
    }
}
