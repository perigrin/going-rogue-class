use 5.40.0;
use experimental 'class';

class MoveAction {
    field $dx : param = 0;
    field $dy : param = 0;

    method execute( $target, $map, $game ) {
        my ( $x, $y ) = $target->location->@*;
        return if $map->is_wall( $x + $dx, $y + $dy );
        if ( my $entity = $game->entity_at( $x + $dx, $y + $dy ) ) {
            if ( $entity->get_component('CombatComponent') ) {
                $game->add_action( AttackAction->new( target => $entity ) );
            }
            else {
                $game->add_action( TakeAction->new( target => $entity ) );
            }
            return;
        }
        $target->move( $dx, $dy );
    }
}

class AttackAction {
    use List::Util qw( min );

    field $target : param;

    method execute( $attacker, $map, $game ) {
        my $target_health   = $target->get_component('HealthComponent');
        my $target_combat   = $target->get_component('CombatComponent');
        my $attacker_combat = $attacker->get_component('CombatComponent');
        my $damage = min( 0, $target_combat->armor - $attacker_combat->attack );
        $game->log( sprintf "attacker %s attacks %s for %d damage",
            $attacker->icon, $target->icon, $damage );
        $target_health->update_hp($damage);
        if ( $target_health->is_dead ) {
            $game->log( sprintf "target %s is dead", $target->icon );
            $game->remove_entity($target);
        }
    }
}

class TakeAction {

    field $target : param;

    method execute( $taker, $map, $game ) {
        $taker->get_component('InventoryComponent')->add($target);
        $game->remove_entity($target);
        $game->log( $taker->icon . " picked up " . $target->icon );
    }
}
