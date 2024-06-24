use 5.38.2;
use experimental 'class';

use Raylib::App;

class Map {
    field $tile_size : param = 10;

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
    #     a           b           c              k                                 #
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
           #       h       #       g      #        ^5      #       j        #
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

    method entrance() { [ 60, 281 ] }

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
