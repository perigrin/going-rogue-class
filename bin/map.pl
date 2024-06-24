#!/bin/perl
use local::lib ();
use lib 'lib';
use Map;

my $app = Raylib::App->window( 800, 500, $0 );
while ( !$app->exiting ) {
    $app->draw_objects( Map->new );
}

