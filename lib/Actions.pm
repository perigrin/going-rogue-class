use 5.40.0;
use experimental 'class';

class MoveAction {
    field $dx : param = 0;
    field $dy : param = 0;

    method execute( $target, $map, $game ) {
        my ( $x, $y ) = $target->location;
        return if $map->is_wall( $x + $dx, $y + $dy );
        if ( my $entity = $game->entity_at( $x + $dx, $y + $dy ) ) {
            $game->add_action( AttackAction->new( target => $entity ) );
            return;
        }
        $target->move( $dx, $dy );
    }
}

class AttackAction {
    use List::Util qw( min );

    field $target : param;

    method execute( $attacker, $map, $ ) {
        $target->update_hp( min( 0, $target->armor - $attacker->strength ) );
    }
}


