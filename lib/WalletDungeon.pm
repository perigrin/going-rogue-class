use 5.40.0;
use experimental 'class';

# Based on https://awkwardturtle.itch.io/wallet-dungeons
class WalletDungeons {
    use List::Util qw(sum);

    # Room types based on dice values
    my %room_types = (
        3  => 'Quarters',
        4  => 'Jail',
        5  => 'Sepulchre',
        6  => 'Statuary',
        7  => 'Store Room',
        8  => 'Courtyard',
        9  => 'Kitchen',
        10 => 'Forge',
        11 => 'Armory',
        12 => 'Garden',
        13 => 'Guard Post',
        14 => 'Library',
        15 => 'Arboretum',
        16 => 'Crypts',
        17 => 'Shrine',
        18 => 'Gallery',
        19 => 'Workshop',
        20 => 'Temple',
        21 => 'Temple',
        22 => 'Temple',
        23 => 'Throne Room',
        24 => 'Throne Room',
        25 => 'Throne Room',
        26 => 'Laboratory',
        27 => 'Laboratory',
        28 => 'Laboratory',
        29 => 'Menagerie',
        30 => 'Menagerie',
        31 => 'Menagerie',
        32 => 'Labyrinth',
    );

    # Define room constraints
    my %constraints = (
        'Dead End'  => 1,
        'Passage'   => 2,
        'Split'     => 3,
        'Crossroad' => 4,
        'Tower'     => 2,    # minimum of 2 dice to stack
        'Hall'      => 4,    # can touch up to 4 dice, merged as single room
    );

    # Roll dice and create dungeon layout
    method roll_dice($num_dice) {
        my @dice = map { int( rand(6) ) + 1 } 1 .. $num_dice;
        return @dice;
    }

    # Generate dungeon layout based on dice rolls
    method generate_dungeon($num_dice) {
        my @dice = $self->roll_dice($num_dice);
        my @rooms;

        for my $die (@dice) {
            my $type = $self->get_room_type($die);
            push @rooms,
              {
                type => $type,
                die  => $die,
                room => $self->get_room_name($die)
              };
        }

        return \@rooms;
    }

    # Determine the room type based on a die roll
    method get_room_type($die) {
        my @room_types =
          ( 'Dead End', 'Passage', 'Split', 'Crossroad', 'Tower', 'Hall' );
        return $room_types[ $die % 6 ];
    }

    # Get the room name based on total dice value
    method get_room_name($die) {
        my $room_sum = sum($die);
        for my $threshold ( reverse sort { $a <=> $b } keys %room_types ) {
            return $room_types{$threshold} if $room_sum >= $threshold;
        }
        return 'Unknown';
    }

    # Print the generated dungeon layout
    method print_dungeon($rooms) {
        for my $room (@$rooms) {
            say
"Room Type: $room->{type}, Die: $room->{die}, Room: $room->{room}";
        }
    }

}

