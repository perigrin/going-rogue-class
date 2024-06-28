use 5.40.0;
use experimental 'class';

class InventoryComponent {
    field @stuff;
    method add($thing) { push @stuff => $thing }
    method all()       { @stuff }

    method reap( $entity, $game ) {
        for my $thing (@stuff) {
            $thing->move(
                $thing->location->[0] - $entity->location->[0],
                $thing->location->[1] - $entity->location->[1]
            );
            $game->add_entity($thing);
        }
    }
}

class HealthComponent {
    field $hp : param : reader = 5;
    method update_hp($delta) { $hp += $delta }
    method is_dead()         { $hp >= 0 }
}

class CombatComponent {
    field $str : param = rand(9) + 1;
    field $armor : param : reader = rand(3) + 1;

    method attack() { $str }
}
