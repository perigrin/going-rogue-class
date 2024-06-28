use 5.38.2;
use experimental 'class';

use Raylib::App;

class Map {
    field $tile_size : param;

    field $wall_glyph = Raylib::Text->new(
        text  => '#',
        color => Raylib::Color::GRAY,
        size  => $tile_size,
    );

    field @tiles =
      map { chomp; [ split //, $_ ] } map { split /\n/, $_ } <<~'END_MAP';
                           ################
                           #              #
                           #              #
                           #              #
                           #              #
                           #       e      #
                           #              #
                           #              #
                           #              #
                           #              #
                           #              #
                           #              #
                           ######## #######               ##########################
                           #              #               #                        #
                           #              #               #                        #
                           #              #               #                        #
                           #       d      #               #                        #
                           #              #               #                        #
                           #              #               #                        #
                           #              #               #                        #
                           #              #               #                        #
                           #              #               #                        #
    ##########################          ###################                        #
    #           #          #              #               #            l           #
    #           #          #              #               #                        #
    #                                                                              #
    #                                                                              #
    #                                                                              #
    #     a           b           c              i                                 #
    #                                                                              #
    #                                                                              #
    #                                                                              #
    #           #          #              #               #                        #
    #           #          #              #               #                        #
    ############################      #######################       ################
                           #              #            #                #
                           #              #            #                #
                           #              #            #                #
                           #              #            #                #
                           #       f      #            #        k       #
                           #              #            #                #
                           #              #            #                #
                           #              #            #                #
                           #              #            #                #
                           #              #            #                #
           #######################  #############################      ######
           #               #              #                #                #
           #               #              #                #                #
           #               #                               #                #
           #               #                               #                #
           #               #              #                #                #
           #       h       #       g      #        T       #       j        #
           #               #              #                #                #
           #               #              #                #                #
           #               #              #                #                #
           #                              #                #                #
           #               #              #                #                #
           #               #              #                                 #
           ##################################################################
    END_MAP

    method is_wall( $x, $y ) {
        $y = $y / $tile_size;
        $x = $x / $tile_size;
        $tiles[$y][$x] eq '#';
    }

    field %spawn_points = ();
    ADJUST {
        for my $y ( 0 .. $#tiles ) {
            my $row = $tiles[$y];
            for my $x ( 0 .. $#$row ) {
                next unless $row->[$x] =~ /[a-zA-Z]/;
                my $label = $row->[$x];
                $spawn_points{$label} = [ $x * $tile_size, $y * $tile_size ];
            }
        }
        $spawn_points{'entrance'} = [ 3 * $tile_size, 28 * $tile_size ];
    }

    method spawn_point($name) { $spawn_points{$name}; }

    method is_spawn_point( $x, $y ) {
        for my $point ( values %spawn_points ) {
            return 1 if $point->[0] == $x && $point->[1] == $y;
        }
        return 0;
    }

    method entrance() { $spawn_points{'entrance'} }

    method draw() {
        for my $y ( 0 .. $#tiles ) {
            my $row = $tiles[$y];
            for my $x ( 0 .. $#$row ) {
                if ( $row->[$x] eq '#' ) {
                    $wall_glyph->draw( $x * $tile_size, $y * $tile_size );
                }
            }
        }
    }

    method print () {
        for my $row (@tiles) {
            say join '', @$row;
        }
    }
}
